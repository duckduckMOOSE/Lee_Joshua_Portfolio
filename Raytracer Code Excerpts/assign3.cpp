/*
CSCI 480
Assignment 3 Raytracer

Name: Joshua Lee
*/

#include <pic.h>
#include <windows.h>
#include <stdlib.h>
#include <GL/glu.h>
#include <GL/glut.h>

#include <iostream>
#include <stdio.h>
#include <string>
#include <math.h>
#include <cmath>
#include <numeric>

#define MAX_TRIANGLES 10
#define MAX_SPHERES 10
#define MAX_LIGHTS 10

char *filename=0;

//different display modes
#define MODE_DISPLAY 1
#define MODE_JPEG 2
int mode=MODE_DISPLAY;

//you may want to make these smaller for debugging purposes
#define WIDTH 640
#define HEIGHT 480

//the field of view of the camera
#define fov 60.0

//Pixel rgb color
double currentIlluminationR = 0;
double currentIlluminationG = 0;
double currentIlluminationB = 0;

//Used for depth test when drawing objects
int currentTriangleIndex = -1;
double currentSphereDepth = -9999;
double currentTriangleDepth = -9999;

unsigned char buffer[HEIGHT][WIDTH][3];

struct Vertex
{
  double position[3];
  double color_diffuse[3];
  double color_specular[3];
  double normal[3];
  double shininess;
};

typedef struct _Triangle
{
  struct Vertex v[3];
} Triangle;

typedef struct _Sphere
{
  double position[3];
  double color_diffuse[3];
  double color_specular[3];
  double shininess;
  double radius;
} Sphere;

typedef struct _Light
{
  double position[3];
  double color[3];
} Light;

Triangle triangles[MAX_TRIANGLES];
Sphere spheres[MAX_SPHERES];
Light lights[MAX_LIGHTS];
double ambient_light[3];
double ambientLightPower = 0;

int num_triangles=0;
int num_spheres=0;
int num_lights=0;

void plot_pixel_display(int x,int y,unsigned char r,unsigned char g,unsigned char b);
void plot_pixel_jpeg(int x,int y,unsigned char r,unsigned char g,unsigned char b);
void plot_pixel(int x,int y,unsigned char r,unsigned char g,unsigned char b);
void rayTrace(int px, int py);

//Sphere Stuff
double calculateDotProduct(double x1, double y1, double z1, double x2, double y2, double z2);
void calculateSphereIllumination(Light light, Sphere sphere, double pointx, double pointy, double pointz);
double checkSphereCollision(int px, int py, int i);

//Triangle Stuff
bool checkTriangleCollision(int px, int py, int i);
bool isContainedByTriangle(Vertex pointOnTriangle, Triangle triangle);
Vertex calculateCrossProduct(double bx, double by, double bz, double cx, double cy, double cz);
Vertex findPointOnTriangle(double xd, double yd, double zd, Triangle triangle);
void calculateTriangleIllumination(Light light, Triangle triangle, double pointx, double pointy, double pointz);
double calculateTriangleArea(double ax, double ay, double bx, double by, double cx, double cy);
double calculateKD(Triangle triangle, double x, double y, int rgb);
double calculateKS(Triangle triangle, double x, double y, int rgb);
double calculateNormal(Triangle triangle, double x, double y, int rgb);

//Shadow Stuff
bool isInShadow(double px, double py, double pz);
bool checkTriangleShadow(double px, double py, double pz, int j);
bool isContainedByTriangleShadow(Vertex pointOnTriangle, Triangle triangle);
Vertex findPointOnTriangleShadow(double xd, double yd, double zd, double px, double py, double pz, Triangle triangle);
bool checkSphereShadow(double px, double py, double pz, int j);




//This function is called once per pixel from draw_scene()
void rayTrace(int px, int py){
	bool hit = false;

	for(int i = 0; i < num_spheres; i++){
		if(checkSphereCollision(px, py, i) > 0){//If ray hits sphere
			plot_pixel(px,py,255*currentIlluminationR,255*currentIlluminationG,255*currentIlluminationB);
			hit = true;
		}
	}

	for(int i = 0; i < num_triangles; i++){
		if(checkTriangleCollision(px, py, i)){//If ray hits triangle
			plot_pixel(px,py,255*currentIlluminationR,255*currentIlluminationG,255*currentIlluminationB);
			hit = true;
		}
	}

	if(!hit){//If ray hits nothing
		plot_pixel(px,py,255,255,255);
	}
}


//TRIANGLE STUFF///////////////////////////////////////////////////////////////////////////////////////////////////////

//This looks for triangle intersections
bool checkTriangleCollision(int px, int py, int i){
	double xd, yd, zd;
	double theTangent;
	double length = 0;
	theTangent = tan(fov*3.1415926/180/2);

	xd = (-(4/3)*theTangent) + 2 * ((4/3)*theTangent) * ((double)px/640);
	yd = -theTangent + 1.5 * theTangent*((double)py/480);
	zd = -1;
	//Normalizing
	length = sqrt(xd*xd + yd*yd + zd*zd);
	xd = xd/length;
	yd = yd/length;
	zd = zd/length;

	//Find the point where the ray intersects the triangle's plane
	Vertex pointOnTriangle;
	pointOnTriangle = findPointOnTriangle(xd, yd, zd, triangles[i]);

	if(currentSphereDepth < pointOnTriangle.position[2]){
	currentTriangleDepth = -9999;

	//Is this point inside the triangle?
	if(isContainedByTriangle(pointOnTriangle, triangles[i])){
		currentTriangleDepth = pointOnTriangle.position[2];
		currentTriangleIndex = i;
		if(!isInShadow(pointOnTriangle.position[0], pointOnTriangle.position[1], pointOnTriangle.position[2])){
			currentTriangleIndex = -1;
			for(int j = 0; j < num_lights; j++){
				calculateTriangleIllumination(lights[j], triangles[i], pointOnTriangle.position[0], pointOnTriangle.position[1], pointOnTriangle.position[2]);
			}
		}
		else{
			currentIlluminationR = ambient_light[0];
			currentIlluminationG = ambient_light[1];
			currentIlluminationB = ambient_light[2];
		}
		return true;
	}
	}

	return false;
}

double calculateTriangleArea(double ax, double ay, double bx, double by, double cx, double cy){
	return abs( 0.5*((bx-ax)*(cy-ay)-(cx-ax)*(by-ay)) );
}

double calculateKD(Triangle triangle, double x, double y, int rgb){
	double alpha, beta, gamma, intensity;

	alpha = calculateTriangleArea(x, y, triangle.v[1].position[0], triangle.v[1].position[1], triangle.v[2].position[0], triangle.v[2].position[1]);
	alpha = alpha / calculateTriangleArea(triangle.v[0].position[0], triangle.v[0].position[1], triangle.v[1].position[0], triangle.v[1].position[1], triangle.v[2].position[0], triangle.v[2].position[1]);
	beta = calculateTriangleArea(triangle.v[0].position[0], triangle.v[0].position[1], x, y, triangle.v[2].position[0], triangle.v[2].position[1]);
	beta = beta / calculateTriangleArea(triangle.v[0].position[0], triangle.v[0].position[1], triangle.v[1].position[0], triangle.v[1].position[1] , triangle.v[2].position[0], triangle.v[2].position[1]);
	gamma = calculateTriangleArea(triangle.v[0].position[0], triangle.v[0].position[1], triangle.v[1].position[0], triangle.v[1].position[1], x, y);
	gamma = gamma / calculateTriangleArea(triangle.v[0].position[0], triangle.v[0].position[1], triangle.v[1].position[0], triangle.v[1].position[1] , triangle.v[2].position[0], triangle.v[2].position[1]);

	intensity = alpha*triangle.v[0].color_diffuse[rgb] + beta*triangle.v[1].color_diffuse[rgb] + gamma*triangle.v[2].color_diffuse[rgb];

	return intensity;
}

double calculateKS(Triangle triangle, double x, double y, int rgb){
	double alpha, beta, gamma, intensity;

	alpha = calculateTriangleArea(x, y, triangle.v[1].position[0], triangle.v[1].position[1], triangle.v[2].position[0], triangle.v[2].position[1]);
	alpha = alpha / calculateTriangleArea(triangle.v[0].position[0], triangle.v[0].position[1], triangle.v[1].position[0], triangle.v[1].position[1], triangle.v[2].position[0], triangle.v[2].position[1]);
	beta = calculateTriangleArea(triangle.v[0].position[0], triangle.v[0].position[1], x, y, triangle.v[2].position[0], triangle.v[2].position[1]);
	beta = beta / calculateTriangleArea(triangle.v[0].position[0], triangle.v[0].position[1], triangle.v[1].position[0], triangle.v[1].position[1] , triangle.v[2].position[0], triangle.v[2].position[1]);
	gamma = calculateTriangleArea(triangle.v[0].position[0], triangle.v[0].position[1], triangle.v[1].position[0], triangle.v[1].position[1], x, y);
	gamma = gamma / calculateTriangleArea(triangle.v[0].position[0], triangle.v[0].position[1], triangle.v[1].position[0], triangle.v[1].position[1] , triangle.v[2].position[0], triangle.v[2].position[1]);

	intensity = alpha*triangle.v[0].color_specular[rgb] + beta*triangle.v[1].color_specular[rgb] + gamma*triangle.v[2].color_specular[rgb];

	return intensity;
}

double calculateNormal(Triangle triangle, double x, double y, int rgb){
	double alpha, beta, gamma, intensity;

	alpha = calculateTriangleArea(x, y, triangle.v[1].position[0], triangle.v[1].position[1], triangle.v[2].position[0], triangle.v[2].position[1]);
	alpha = alpha / calculateTriangleArea(triangle.v[0].position[0], triangle.v[0].position[1], triangle.v[1].position[0], triangle.v[1].position[1], triangle.v[2].position[0], triangle.v[2].position[1]);
	beta = calculateTriangleArea(triangle.v[0].position[0], triangle.v[0].position[1], x, y, triangle.v[2].position[0], triangle.v[2].position[1]);
	beta = beta / calculateTriangleArea(triangle.v[0].position[0], triangle.v[0].position[1], triangle.v[1].position[0], triangle.v[1].position[1] , triangle.v[2].position[0], triangle.v[2].position[1]);
	gamma = calculateTriangleArea(triangle.v[0].position[0], triangle.v[0].position[1], triangle.v[1].position[0], triangle.v[1].position[1], x, y);
	gamma = gamma / calculateTriangleArea(triangle.v[0].position[0], triangle.v[0].position[1], triangle.v[1].position[0], triangle.v[1].position[1] , triangle.v[2].position[0], triangle.v[2].position[1]);

	intensity = alpha*triangle.v[0].normal[rgb] + beta*triangle.v[1].normal[rgb] + gamma*triangle.v[2].normal[rgb];

	return intensity;
}

//If a hit on a triangle is registered, this calculates the pixel color
void calculateTriangleIllumination(Light light, Triangle triangle, double pointx, double pointy, double pointz){

	double kdR, kdG, kdB;
	double ksR, ksG, ksB;
	double sh = triangle.v[0].shininess;
	double xl, yl, zl;
	double xn, yn, zn;
	double xr, yr, zr;
	double xv, yv, zv;
	double length;

	kdR = calculateKD(triangle, pointx, pointy, 0);
	kdG = calculateKD(triangle, pointx, pointy, 1);
	kdB = calculateKD(triangle, pointx, pointy, 2);

	ksR = calculateKS(triangle, pointx, pointy, 0);
	ksG = calculateKS(triangle, pointx, pointy, 1);
	ksB = calculateKS(triangle, pointx, pointy, 2);

	//L vector
	xl = light.position[0] - pointx;
	yl = light.position[1] - pointy;
	zl = light.position[2] - pointz;
	//Normalize
	length = sqrt(xl*xl + yl*yl + zl*zl);
	xl = xl/length;
	yl = yl/length;
	zl = zl/length;

	//N vector
	xn = calculateNormal(triangle, pointx, pointy, 0);
	yn = calculateNormal(triangle, pointx, pointy, 1);
	zn = calculateNormal(triangle, pointx, pointy, 2);
	//Normalize
	length = sqrt(xn*xn + yn*yn + zn*zn);
	xn = xn/length;
	yn = yn/length;
	zn = zn/length;

	//V vector
	xv = -pointx;
	yv = -pointy;
	zv = -pointz;
	//Normalize
	length = sqrt(xv*xv + yv*yv + zv*zv);
	xv = xv/length;
	yv = yv/length;
	zv = zv/length;

	//R vector (Rr = Ri - 2 N (Ri . N))
	double dotProductValue;
	dotProductValue = calculateDotProduct(pointx, pointy, pointz, xn, yn, zn);
	xr = pointx-2*xn*(dotProductValue);
	yr = pointy-2*yn*(dotProductValue);
	zr = pointz-2*zn*(dotProductValue);
	//Normalize
	length = sqrt(xr*xr + yr*yr + zr*zr);
	xr = xr/length;
	yr = yr/length;
	zr = zr/length;

	//Illumination equation
	double LdotN, RdotV;
	//return (kd * (L dot N) + ks * (R dot V) ^ sh)
	LdotN = calculateDotProduct(xl, yl, zl, xn, yn, zn);
	RdotV = calculateDotProduct(xr, yr, zr, xv, yv, zv);
	currentIlluminationR = (kdR * LdotN + ksR * pow(RdotV, sh))*light.color[0];
	currentIlluminationG = (kdG * LdotN + ksG * pow(RdotV, sh))*light.color[1];
	currentIlluminationB = (kdB * LdotN + ksB * pow(RdotV, sh))*light.color[2];
	currentIlluminationR += ambient_light[0];
	currentIlluminationG += ambient_light[1];
	currentIlluminationB += ambient_light[2];

	//Clamping values
	if(currentIlluminationR > 1){
		currentIlluminationR = 1;
	}
	if(currentIlluminationR < 0){
		currentIlluminationR = 0;
	}
	if(currentIlluminationG > 1){
		currentIlluminationG = 1;
	}
	if(currentIlluminationG < 0){
		currentIlluminationG = 0;
	}
	if(currentIlluminationB > 1){
		currentIlluminationB = 1;
	}
	if(currentIlluminationB < 0){
		currentIlluminationB = 0;
	}
}

//This is a helper function for checkTriangleCollision()
 Vertex findPointOnTriangle(double xd, double yd, double zd, Triangle triangle){
	double t;
	Vertex pointOnTriangle;

	t = -calculateDotProduct(-triangle.v[0].position[0], -triangle.v[0].position[1], -triangle.v[0].position[2], triangle.v[0].normal[0], triangle.v[0].normal[1], triangle.v[0].normal[2]);
	t = t / calculateDotProduct(xd, yd, zd, triangle.v[0].normal[0], triangle.v[0].normal[1], triangle.v[0].normal[2]);
	
	pointOnTriangle.position[0] = t*xd;
	pointOnTriangle.position[1] = t*yd;
	pointOnTriangle.position[2] = t*zd;

	return pointOnTriangle;
}
 
//This is a helper function for checkTriangleCollision()
 bool isContainedByTriangle(Vertex pointOnTriangle, Triangle triangle){
	double test1, test2, test3;
	Vertex p0 = triangle.v[0], p1 = triangle.v[1], p2 = triangle.v[2], x = pointOnTriangle;
	Vertex test1CrossResult, test2CrossResult, test3CrossResult;
	
	test1CrossResult = calculateCrossProduct(p1.position[0]-p0.position[0], p1.position[1]-p0.position[1], p1.position[2]-p0.position[2], x.position[0]-p0.position[0], x.position[1]-p0.position[1], x.position[2]-p0.position[2]);
	test2CrossResult = calculateCrossProduct(p2.position[0]-p1.position[0], p2.position[1]-p1.position[1], p2.position[2]-p1.position[2], x.position[0]-p1.position[0], x.position[1]-p1.position[1], x.position[2]-p1.position[2]);
	test3CrossResult = calculateCrossProduct(p0.position[0]-p2.position[0], p0.position[1]-p2.position[1], p0.position[2]-p2.position[2], x.position[0]-p2.position[0], x.position[1]-p2.position[1], x.position[2]-p2.position[2]);

	test1 = calculateDotProduct(test1CrossResult.position[0], test1CrossResult.position[1], test1CrossResult.position[2], triangle.v[0].normal[0], triangle.v[0].normal[1], triangle.v[0].normal[2]);
	test2 = calculateDotProduct(test2CrossResult.position[0], test2CrossResult.position[1], test2CrossResult.position[2], triangle.v[0].normal[0], triangle.v[0].normal[1], triangle.v[0].normal[2]);
	test3 = calculateDotProduct(test3CrossResult.position[0], test3CrossResult.position[1], test3CrossResult.position[2], triangle.v[0].normal[0], triangle.v[0].normal[1], triangle.v[0].normal[2]);

	if(test1 >= 0 && test2 >= 0 && test3 >= 0){
		return true;
	}
	return false;
 }





 //SPHERE STUFF//////////////////////////////////////////////////////////////////////////////////////////////////////

 //This looks for sphere intersections
double checkSphereCollision(int px, int py, int i){
	double xd, yd, zd;
	double xc, yc, zc;
	double b, c;
	double t0, t1, tFinal;
	double theTangent;
	double length = 0;

	theTangent = tan(fov*3.1415926/180/2);

	xd = (-(4/3)*theTangent) + 2 * ((4/3)*theTangent) * ((double)px/640);
	yd = -theTangent + 1.5 * theTangent*((double)py/480);
	zd = -1;
	//Normalizing
	length = sqrt(xd*xd + yd*yd + zd*zd);
	xd = xd/length;
	yd = yd/length;
	zd = zd/length;

	xc = spheres[i].position[0];
	yc = spheres[i].position[1];
	zc = spheres[i].position[2];

	b = 2*(xd*(-xc)+yd*(-yc)+zd*(-zc));
	c = (xc)*(xc)+(yc)*(yc)+(zc)*(zc)-(spheres[i].radius)*(spheres[i].radius);

	t0 = (-b + sqrt(b*b - 4*c))/(2);
	t1 = (-b - sqrt(b*b - 4*c))/(2);

	tFinal = min(t0, t1);
	currentSphereDepth = -9999;

	if(tFinal > 0){
		currentSphereDepth = -1*tFinal;
		if(!isInShadow(xd*tFinal, yd*tFinal, -1*tFinal)){
			for(int j = 0; j < num_lights; j++){
				calculateSphereIllumination(lights[j], spheres[i], xd*tFinal, yd*tFinal, -1*tFinal);
			}
		}
		else{
			currentIlluminationR = ambient_light[0];
			currentIlluminationG = ambient_light[1];
			currentIlluminationB = ambient_light[2];
		}
	}

	return tFinal;
}

//If a hit on a sphere is registered, this calculates the pixel color
void calculateSphereIllumination(Light light, Sphere sphere, double pointx, double pointy, double pointz){
	double kdR = sphere.color_diffuse[0], kdG = sphere.color_diffuse[1], kdB = sphere.color_diffuse[2];
	double ksR = sphere.color_specular[0], ksG = sphere.color_specular[1], ksB = sphere.color_specular[2];
	double sh = sphere.shininess;
	double xl, yl, zl;
	double xn, yn, zn;
	double xr, yr, zr;
	double xv, yv, zv;
	double length;

	//L vector
	xl = light.position[0] - pointx;
	yl = light.position[1] - pointy;
	zl = light.position[2] - pointz;
	//Normalize
	length = sqrt(xl*xl + yl*yl + zl*zl);
	xl = xl/length;
	yl = yl/length;
	zl = zl/length;

	//N vector
	xn = pointx - sphere.position[0];
	yn = pointy - sphere.position[1];
	zn = pointz - sphere.position[2];
	//Normalize
	length = sqrt(xn*xn + yn*yn + zn*zn);
	xn = xn/length;
	yn = yn/length;
	zn = zn/length;

	//V vector
	xv = -pointx;
	yv = -pointy;
	zv = -pointz;
	//Normalize
	length = sqrt(xv*xv + yv*yv + zv*zv);
	xv = xv/length;
	yv = yv/length;
	zv = zv/length;

	//R vector (Rr = Ri - 2 N (Ri . N))
	double dotProductValue;
	dotProductValue = calculateDotProduct(pointx, pointy, pointz, xn, yn, zn);
	xr = pointx-2*xn*(dotProductValue);
	yr = pointy-2*yn*(dotProductValue);
	zr = pointz-2*zn*(dotProductValue);
	//Normalize
	length = sqrt(xr*xr + yr*yr + zr*zr);
	xr = xr/length;
	yr = yr/length;
	zr = zr/length;

	//Illumination equation
	double LdotN, RdotV;
	//return (kd * (L dot N) + ks * (R dot V) ^ sh)
	LdotN = calculateDotProduct(xl, yl, zl, xn, yn, zn);
	RdotV = calculateDotProduct(xr, yr, zr, xv, yv, zv);
	currentIlluminationR = (kdR * LdotN + ksR * pow(RdotV, sh))*light.color[0];
	currentIlluminationG = (kdG * LdotN + ksG * pow(RdotV, sh))*light.color[1];
	currentIlluminationB = (kdB * LdotN + ksB * pow(RdotV, sh))*light.color[2];
	currentIlluminationR += ambient_light[0];
	currentIlluminationG += ambient_light[1];
	currentIlluminationB += ambient_light[2];

	//Clamping values
	if(currentIlluminationR > 1){
		currentIlluminationR = 1;
	}
	if(currentIlluminationR < 0){
		currentIlluminationR = 0;
	}
	if(currentIlluminationG > 1){
		currentIlluminationG = 1;
	}
	if(currentIlluminationG < 0){
		currentIlluminationG = 0;
	}
	if(currentIlluminationB > 1){
		currentIlluminationB = 1;
	}
	if(currentIlluminationB < 0){
		currentIlluminationB = 0;
	}
}





//SHADOW STUFF////////////////////////////////////////////////////////////////////////////////////////////////////////

//This is the basic check-shadow-fuction
bool isInShadow(double px, double py, double pz){
	for(int j = 0; j < num_lights; j++){
		if(checkSphereShadow(px, py, pz, j)){
			return true;
		}		
		else if(checkTriangleShadow(px, py, pz, j)){
			return true;
		}
	}
	return false;
}

//Helper function to isInShadow()
bool checkSphereShadow(double px, double py, double pz, int j){
	double xd, yd, zd;
	double xc, yc, zc;
	double b, c;
	double t0, t1, tFinal;
	double length = 0;

	xd = lights[j].position[0] - px;
	yd = lights[j].position[1] - py;
	zd = lights[j].position[2] - pz;
	//Normalizing
	length = sqrt(xd*xd + yd*yd + zd*zd);
	xd = xd/length;
	yd = yd/length;
	zd = zd/length;

	for(int i = 0; i < num_spheres; i++){
		xc = spheres[i].position[0];
		yc = spheres[i].position[1];
		zc = spheres[i].position[2];

		b = 2*(xd*(px-xc)+yd*(py-yc)+zd*(pz-zc));
		c = (px-xc)*(px-xc)+(py-yc)*(py-yc)+(pz-zc)*(pz-zc)-(spheres[i].radius)*(spheres[i].radius);

		t0 = (-b + sqrt(b*b - 4*c))/(2);
		t1 = (-b - sqrt(b*b - 4*c))/(2);

		tFinal = min(t0, t1);

		if(tFinal > 0){
			return true;
		}
	}
	return false;
}

//Helper function to isInShadow()
bool checkTriangleShadow(double px, double py, double pz, int j){
	double xd, yd, zd;
	double length = 0;

	xd = lights[j].position[0] - px;
	yd = lights[j].position[1] - py;
	zd = lights[j].position[2] - pz;
	//Normalizing
	length = sqrt(xd*xd + yd*yd + zd*zd);
	xd = xd/length;
	yd = yd/length;
	zd = zd/length;

	for(int i = 0; i < num_triangles; i++){
		if(currentTriangleIndex != i){
			//Find the point where the ray intersects the triangle's plane
			Vertex pointOnTriangle;
			pointOnTriangle = findPointOnTriangleShadow(xd, yd, zd, px, py, pz, triangles[i]);

			if(pointOnTriangle.position[2] < currentSphereDepth){
				return false;
			}
			if(pointOnTriangle.position[2] < currentTriangleDepth){
				return false;
			}

			//Is this point inside the triangle?
			if(isContainedByTriangleShadow(pointOnTriangle, triangles[i])){
				return true;
			}
		}
	}	
	return false;
}

//Helper function to checkTriangleShadow()
 Vertex findPointOnTriangleShadow(double xd, double yd, double zd, double px, double py, double pz, Triangle triangle){
	double t;
	Vertex pointOnTriangle;

	t = -calculateDotProduct(px-triangle.v[0].position[0], py-triangle.v[0].position[1], pz-triangle.v[0].position[2], triangle.v[0].normal[0], triangle.v[0].normal[1], triangle.v[0].normal[2]);
	t = t / calculateDotProduct(xd, yd, zd, triangle.v[0].normal[0], triangle.v[0].normal[1], triangle.v[0].normal[2]);

	pointOnTriangle.position[0] = px + t*xd;
	pointOnTriangle.position[1] = py + t*yd;
	pointOnTriangle.position[2] = pz + t*zd;

	return pointOnTriangle;
}
 
 //Helper function to checkTriangleShadow()
bool isContainedByTriangleShadow(Vertex pointOnTriangle, Triangle triangle){
	double test1, test2, test3;
	Vertex p0 = triangle.v[0], p1 = triangle.v[1], p2 = triangle.v[2], x = pointOnTriangle;
	Vertex test1CrossResult, test2CrossResult, test3CrossResult;
	
	test1CrossResult = calculateCrossProduct(p1.position[0]-p0.position[0], p1.position[1]-p0.position[1], p1.position[2]-p0.position[2], x.position[0]-p0.position[0], x.position[1]-p0.position[1], x.position[2]-p0.position[2]);
	test2CrossResult = calculateCrossProduct(p2.position[0]-p1.position[0], p2.position[1]-p1.position[1], p2.position[2]-p1.position[2], x.position[0]-p1.position[0], x.position[1]-p1.position[1], x.position[2]-p1.position[2]);
	test3CrossResult = calculateCrossProduct(p0.position[0]-p2.position[0], p0.position[1]-p2.position[1], p0.position[2]-p2.position[2], x.position[0]-p2.position[0], x.position[1]-p2.position[1], x.position[2]-p2.position[2]);

	test1 = calculateDotProduct(test1CrossResult.position[0], test1CrossResult.position[1], test1CrossResult.position[2], triangle.v[0].normal[0], triangle.v[0].normal[1], triangle.v[0].normal[2]);
	test2 = calculateDotProduct(test2CrossResult.position[0], test2CrossResult.position[1], test2CrossResult.position[2], triangle.v[0].normal[0], triangle.v[0].normal[1], triangle.v[0].normal[2]);
	test3 = calculateDotProduct(test3CrossResult.position[0], test3CrossResult.position[1], test3CrossResult.position[2], triangle.v[0].normal[0], triangle.v[0].normal[1], triangle.v[0].normal[2]);

	if(test1 >= 0 && test2 >= 0 && test3 >= 0){
		return true;
	}
	return false;
 }





//UTILITY FUNCTIONS/////////////////////////////////////////////////////////////////////////////////////////////////

//This calculates Cross Products
 Vertex calculateCrossProduct(double bx, double by, double bz, double cx, double cy, double cz){
 	double ax, ay, az;
	Vertex finalAnswer;

	ax = by*cz - bz*cy;
	ay = bz*cx - bx*cz;
	az = bx*cy - by*cx;

	finalAnswer.position[0] = ax;
	finalAnswer.position[1] = ay;
	finalAnswer.position[2] = az;

	return finalAnswer;
 }

 //This calculates Dot Products
double calculateDotProduct(double x1, double y1, double z1, double x2, double y2, double z2){
    double a[] = { x1, y1, z1 };
    double b[] = { x2, y2, z2 };
	double finalValue;

	finalValue = x1*x2 + y1*y2 + z1*z2;
	return finalValue;
}





//MODIFY THIS FUNCTION
void draw_scene()
{
  unsigned int x,y;
  //simple output
  for(x=0;x < WIDTH;x++)
  {
    glBegin(GL_POINTS);
    for(y=0;y < HEIGHT;y++)
    {
	  rayTrace(x, y);
    }
    glEnd();
    glFlush();
  }
  printf("Done!\n");
}

void plot_pixel_display(int x,int y,unsigned char r,unsigned char g,unsigned char b)
{
  glColor3f(((double)r)/256.f,((double)g)/256.f,((double)b)/256.f);
  glVertex2i(x,y);
}

void plot_pixel_jpeg(int x,int y,unsigned char r,unsigned char g,unsigned char b)
{
  buffer[HEIGHT-y-1][x][0]=r;
  buffer[HEIGHT-y-1][x][1]=g;
  buffer[HEIGHT-y-1][x][2]=b;
}

void plot_pixel(int x,int y,unsigned char r,unsigned char g, unsigned char b)
{
  plot_pixel_display(x,y,r,g,b);
  if(mode == MODE_JPEG)
      plot_pixel_jpeg(x,y,r,g,b);
}

void save_jpg()
{
  Pic *in = NULL;

  in = pic_alloc(640, 480, 3, NULL);
  printf("Saving JPEG file: %s\n", filename);

  memcpy(in->pix,buffer,3*WIDTH*HEIGHT);
  if (jpeg_write(filename, in))
    printf("File saved Successfully\n");
  else
    printf("Error in Saving\n");

  pic_free(in);      

}

void parse_check(char *expected,char *found)
{
  if(stricmp(expected,found))
    {
      char error[100];
      printf("Expected '%s ' found '%s '\n",expected,found);
      printf("Parse error, abnormal abortion\n");
      exit(0);
    }

}

void parse_doubles(FILE*file, char *check, double p[3])
{
  char str[100];
  fscanf(file,"%s",str);
  parse_check(check,str);
  fscanf(file,"%lf %lf %lf",&p[0],&p[1],&p[2]);
  printf("%s %lf %lf %lf\n",check,p[0],p[1],p[2]);
}

void parse_rad(FILE*file,double *r)
{
  char str[100];
  fscanf(file,"%s",str);
  parse_check("rad:",str);
  fscanf(file,"%lf",r);
  printf("rad: %f\n",*r);
}

void parse_shi(FILE*file,double *shi)
{
  char s[100];
  fscanf(file,"%s",s);
  parse_check("shi:",s);
  fscanf(file,"%lf",shi);
  printf("shi: %f\n",*shi);
}

int loadScene(char *argv)
{
  FILE *file = fopen(argv,"r");
  int number_of_objects;
  char type[50];
  int i;
  Triangle t;
  Sphere s;
  Light l;
  fscanf(file,"%i",&number_of_objects);

  printf("number of objects: %i\n",number_of_objects);
  char str[200];

  parse_doubles(file,"amb:",ambient_light);

  for(i=0;i < number_of_objects;i++)
    {
      fscanf(file,"%s\n",type);
      printf("%s\n",type);
      if(stricmp(type,"triangle")==0)
	{

	  printf("found triangle\n");
	  int j;

	  for(j=0;j < 3;j++)
	    {
	      parse_doubles(file,"pos:",t.v[j].position);
	      parse_doubles(file,"nor:",t.v[j].normal);
	      parse_doubles(file,"dif:",t.v[j].color_diffuse);
	      parse_doubles(file,"spe:",t.v[j].color_specular);
	      parse_shi(file,&t.v[j].shininess);
	    }

	  if(num_triangles == MAX_TRIANGLES)
	    {
	      printf("too many triangles, you should increase MAX_TRIANGLES!\n");
	      exit(0);
	    }
	  triangles[num_triangles++] = t;
	}
      else if(stricmp(type,"sphere")==0)
	{
	  printf("found sphere\n");

	  parse_doubles(file,"pos:",s.position);
	  parse_rad(file,&s.radius);
	  parse_doubles(file,"dif:",s.color_diffuse);
	  parse_doubles(file,"spe:",s.color_specular);
	  parse_shi(file,&s.shininess);

	  if(num_spheres == MAX_SPHERES)
	    {
	      printf("too many spheres, you should increase MAX_SPHERES!\n");
	      exit(0);
	    }
	  spheres[num_spheres++] = s;
	}
      else if(stricmp(type,"light")==0)
	{
	  printf("found light\n");
	  parse_doubles(file,"pos:",l.position);
	  parse_doubles(file,"col:",l.color);

	  if(num_lights == MAX_LIGHTS)
	    {
	      printf("too many lights, you should increase MAX_LIGHTS!\n");
	      exit(0);
	    }
	  lights[num_lights++] = l;
	}
      else
	{
	  printf("unknown type in scene description:\n%s\n",type);
	  exit(0);
	}
    }
  return 0;
}

void display()
{

}

void init()
{
  glMatrixMode(GL_PROJECTION);
  glOrtho(0,WIDTH,0,HEIGHT,1,-1);
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity();

  glClearColor(0,0,0,0);
  glClear(GL_COLOR_BUFFER_BIT);
}

void idle()
{
  //hack to make it only draw once
  static bool once=false;
  if(!once)
  {
      draw_scene();
      if(mode == MODE_JPEG)
		save_jpg();
		}
  once=true;
}

int main (int argc, char ** argv)
{
  if (argc<2 || argc > 3)
  {  
    printf ("usage: %s <scenefile> [jpegname]\n", argv[0]);
    exit(0);
  }
  if(argc == 3)
    {
      mode = MODE_JPEG;
      filename = argv[2];
    }
  else if(argc == 2)
    mode = MODE_DISPLAY;

  glutInit(&argc,argv);
  loadScene(argv[1]);

  glutInitDisplayMode(GLUT_RGBA | GLUT_SINGLE);
  glutInitWindowPosition(0,0);
  glutInitWindowSize(WIDTH,HEIGHT);
  int window = glutCreateWindow("Ray Tracer");
  glutDisplayFunc(display);
  glutIdleFunc(idle);
  init();
  glutMainLoop();
}
