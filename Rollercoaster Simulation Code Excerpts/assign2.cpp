/*
	CSCI 480 Computer Graphics
	Assignment 2: Simulating a Roller Coaster
	By: Joshua Lee
*/
#include <vector>
#include "stdafx.h"
#include <pic.h>
#include <windows.h>
#include <stdlib.h>
#include <stdio.h>
#include <iostream>
#include <GL/glu.h>
#include <GL/glut.h>
#include <GL.h>
#include <GLU.h>
#include <glut.h>

typedef enum { ROTATE, TRANSLATE, SCALE } CONTROLSTATE;
CONTROLSTATE g_ControlState = ROTATE;

/* represents one control point along the spline */
struct point {
	double x;
	double y;
	double z;
};

/* spline struct which contains how many control points, and an array of control points */
struct spline {
	int numControlPoints;
	struct point *points;
};

/* the spline array */
struct spline *g_Splines;

/* total number of splines */
int g_iNumOfSplines;

std::vector<point> rightSplineInner;
std::vector<point> leftSplineInner;

std::vector<point> cameraPathSplinePoints;
float splineGranularity = 0.01;
int frame = 0;
double trackWidth = 1;
double railWidth = .02;
double displaceTrack = -20;
int speed = 5;////////////////////////////////////LOOK HERE!!!!!!!!!  This changes the speed of the animation...


GLuint Bottom_Texture_Name, Top_Texture_Name, Front_Texture_Name, Back_Texture_Name, Left_Texture_Name, Right_Texture_Name, Wood_Texture_Name;
Pic *Current_Texture;



//This function loads in new textures
void loadTexture(GLuint texture, char* fileName){

	Current_Texture = jpeg_read(fileName, NULL);

	glBindTexture(GL_TEXTURE_2D, texture);

	glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_REPLACE);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, 512, 512, 0, GL_RGB, GL_UNSIGNED_BYTE, Current_Texture->pix);
}

//I didn't touch this function
int loadSplines(char *argv) {
	char *cName = (char *)malloc(128 * sizeof(char));
	FILE *fileList;
	FILE *fileSpline;
	int iType, i = 0, j, iLength;

	/* load the track file */
	fileList = fopen(argv, "r");
	if (fileList == NULL) {
		printf ("can't open file\n");
		exit(1);
	}
  
	/* stores the number of splines in a global variable */
	fscanf(fileList, "%d", &g_iNumOfSplines);

	g_Splines = (struct spline *)malloc(g_iNumOfSplines * sizeof(struct spline));

	/* reads through the spline files */
	for (j = 0; j < g_iNumOfSplines; j++) {
		i = 0;
		fscanf(fileList, "%s", cName);
		fileSpline = fopen(cName, "r");

		if (fileSpline == NULL) {
			printf ("can't open file\n");
			exit(1);
		}

		/* gets length for spline file */
		fscanf(fileSpline, "%d %d", &iLength, &iType);

		/* allocate memory for all the points */
		g_Splines[j].points = (struct point *)malloc(iLength * sizeof(struct point));
		g_Splines[j].numControlPoints = iLength;

		/* saves the data to the struct */
		while (fscanf(fileSpline, "%lf %lf %lf", 
			&g_Splines[j].points[i].x, 
			&g_Splines[j].points[i].y, 
			&g_Splines[j].points[i].z) != EOF) {
			i++;
		}
	}

	free(cName);

	return 0;
}

//This calculates the exact trail the camera will follow (It's calculated based off of the points calulated for the right track rail)
void calculateCameraPath(){
	double rise = 0, run = 0, length = 0;
	int counter = 0;
	point temp;

	while(counter < rightSplineInner.size() - 1){
		
		temp.y = rightSplineInner.at(counter).y;

		rise = -(rightSplineInner.at(counter+1).x - rightSplineInner.at(counter).x);
		run = rightSplineInner.at(counter+1).z - rightSplineInner.at(counter).z;

		length = sqrt(rise*rise + run*run)*20;

		temp.x = rightSplineInner.at(counter).x + (run / length);
		temp.z = rightSplineInner.at(counter).z + (rise / length);

		cameraPathSplinePoints.push_back(temp);

		counter++;
	}
}

//This calculates the points for the track rail on the left (It's calculated based off of the points calulated for the right track rail)
void calculateLeftInnerRail(){
	double rise = 0, run = 0, length = 0;
	int counter = 0;
	point temp;

	while(counter < rightSplineInner.size() - 1){
		
		temp.y = rightSplineInner.at(counter).y;  //Note that the rails will always be at an equal height off the ground.

		rise = -(rightSplineInner.at(counter+1).x - rightSplineInner.at(counter).x);
		run = rightSplineInner.at(counter+1).z - rightSplineInner.at(counter).z;

		length = sqrt(rise*rise + run*run)*10;

		temp.x = rightSplineInner.at(counter).x + (run / length);
		temp.z = rightSplineInner.at(counter).z + (rise / length);

		leftSplineInner.push_back(temp);

		counter++;
	}
}

//This calculates the points for the track rail on the right
void calculateRightInnerRail(point p0, point p1, point p2, point p3){
	double x, y, z, u = 0;
	point temp;

	//calculates right-inner rail
	while(u < 1){
		z =   0.5 * ( (2 * p1.x) + (-p0.x + p2.x) * u + (2 * p0.x - 5 * p1.x + 4 * p2.x - p3.x) * u*u + (-p0.x + 3 * p1.x - 3 * p2.x + p3.x) * u*u*u);
		x =   0.5 * ( (2 * p1.y) + (-p0.y + p2.y) * u + (2 * p0.y - 5 * p1.y + 4 * p2.y - p3.y) * u*u + (-p0.y + 3 * p1.y - 3 * p2.y + p3.y) * u*u*u);
		y =   0.5 * ( (2 * p1.z) + (-p0.z + p2.z) * u + (2 * p0.z - 5 * p1.z + 4 * p2.z - p3.z) * u*u + (-p0.z + 3 * p1.z - 3 * p2.z + p3.z) * u*u*u);

		temp.x = x;
		temp.y = y;
		temp.z = z + displaceTrack;

		rightSplineInner.push_back(temp);

		u += splineGranularity;
	}

}

//Draws the slats in-between the two rails.  
//Also initializes lighting.  I used a point light
void drawcrossrail(){
	int railWidth = 1;

	glEnable(GL_TEXTURE_2D);
	glBindTexture(GL_TEXTURE_2D, Wood_Texture_Name);

	glEnable(GL_NORMALIZE);
	glEnable(GL_LIGHTING);
	glEnable(GL_LIGHT0);

	GLfloat light_position[4] = {-5.0, 10.0, -5.0, 1.0};
	glLightfv(GL_LIGHT0, GL_POSITION, light_position);

	glBegin(GL_QUADS);
		for(int i = 0; i < 2000; i++){
			if(i % 5 == 0){
				glNormal3f(0, 1, 0);
				glTexCoord2f(0.0, 0.0);
				glVertex3f(rightSplineInner.at(i).x ,rightSplineInner.at(i).y ,rightSplineInner.at(i).z);
				glTexCoord2f(0.0, 1.0);
				glVertex3f(leftSplineInner.at(i).x ,leftSplineInner.at(i).y,leftSplineInner.at(i).z);
				glTexCoord2f(1.0, 1.0);
				glVertex3f(leftSplineInner.at(i+railWidth).x ,leftSplineInner.at(i+railWidth).y,leftSplineInner.at(i+railWidth).z);
				glTexCoord2f(1.0, 0.0);
				glVertex3f(rightSplineInner.at(i+railWidth).x ,rightSplineInner.at(i+railWidth).y ,rightSplineInner.at(i+railWidth).z);
			}
		}
	glEnd();
	glDisable(GL_TEXTURE_2D);
}

//This draws both rails (Note the rails are thickened GL_LINES)
void drawspline(){

	//right track bar
	glBegin(GL_LINES);
		glColor3f(.75, .75, .75);
		for(int i = 0; i < 2000; i++){
			glVertex3f(rightSplineInner.at(i).x ,rightSplineInner.at(i).y ,rightSplineInner.at(i).z);
			glVertex3f(rightSplineInner.at(i+1).x ,rightSplineInner.at(i+1).y ,rightSplineInner.at(i+1).z);
		}
	glEnd();

	//left track bar
	glBegin(GL_LINES);
		for(int i = 0; i < leftSplineInner.size()-1; i++){
			glVertex3f(leftSplineInner.at(i).x ,leftSplineInner.at(i).y ,leftSplineInner.at(i).z);
			glVertex3f(leftSplineInner.at(i+1).x ,leftSplineInner.at(i+1).y ,leftSplineInner.at(i+1).z);
		}
	glEnd();
	
}

//This draws the sky and ground... and a teapot as well...
void drawSkybox(){

	float skyboxWidth = 500;

	glEnable(GL_TEXTURE_2D);

		//Top
		glBindTexture(GL_TEXTURE_2D, Top_Texture_Name);
			glBegin(GL_QUADS);
				glTexCoord2f(0.0, 0.0);
				glVertex3f(-skyboxWidth, +skyboxWidth, -skyboxWidth);
				glTexCoord2f(0.0, 1.0);
				glVertex3f(-skyboxWidth, +skyboxWidth, +skyboxWidth);
				glTexCoord2f(1.0, 1.0);
				glVertex3f(+skyboxWidth, +skyboxWidth, +skyboxWidth);
				glTexCoord2f(1.0, 0.0);
				glVertex3f(+skyboxWidth, +skyboxWidth, -skyboxWidth);
			glEnd();

		//Bottom
		glBindTexture(GL_TEXTURE_2D, Bottom_Texture_Name);
			glBegin(GL_QUADS);
				glTexCoord2f(0.0, 0.0);
				glVertex3f(-skyboxWidth, -skyboxWidth, -skyboxWidth);
				glTexCoord2f(0.0, 1.0);
				glVertex3f(+skyboxWidth, -skyboxWidth, -skyboxWidth);
				glTexCoord2f(1.0, 1.0);
				glVertex3f(+skyboxWidth, -skyboxWidth, +skyboxWidth);
				glTexCoord2f(1.0, 0.0);
				glVertex3f(-skyboxWidth, -skyboxWidth, +skyboxWidth);
			glEnd();

		//Front
		glBindTexture(GL_TEXTURE_2D, Back_Texture_Name);
			glBegin(GL_QUADS);
				glTexCoord2f(1.0, 0.0);
				glVertex3f(-skyboxWidth, +skyboxWidth, -skyboxWidth);
				glTexCoord2f(0.0, 0.0);
				glVertex3f(+skyboxWidth, +skyboxWidth, -skyboxWidth);
				glTexCoord2f(0.0, 1.0);
				glVertex3f(+skyboxWidth, -skyboxWidth, -skyboxWidth);
				glTexCoord2f(1.0, 1.0);
				glVertex3f(-skyboxWidth, -skyboxWidth, -skyboxWidth);
			glEnd();

		//Back
		glBindTexture(GL_TEXTURE_2D, Front_Texture_Name);
			glBegin(GL_QUADS);
				glTexCoord2f(0.0, 0.0);
				glVertex3f(-skyboxWidth, +skyboxWidth, +skyboxWidth);
				glTexCoord2f(0.0, 1.0);
				glVertex3f(-skyboxWidth, -skyboxWidth, +skyboxWidth);
				glTexCoord2f(1.0, 1.0);
				glVertex3f(+skyboxWidth, -skyboxWidth, +skyboxWidth);
				glTexCoord2f(1.0, 0.0);
				glVertex3f(+skyboxWidth, +skyboxWidth, +skyboxWidth);
			glEnd();

		//Right
		glBindTexture(GL_TEXTURE_2D, Right_Texture_Name);
			glBegin(GL_QUADS);
				glTexCoord2f(1.0, 0.0);
				glVertex3f(+skyboxWidth, +skyboxWidth, -skyboxWidth);
				glTexCoord2f(0.0, 0.0);
				glVertex3f(+skyboxWidth, +skyboxWidth, +skyboxWidth);
				glTexCoord2f(0.0, 1.0);
				glVertex3f(+skyboxWidth, -skyboxWidth, +skyboxWidth);
				glTexCoord2f(1.0, 1.0);
				glVertex3f(+skyboxWidth, -skyboxWidth, -skyboxWidth);
			glEnd();

		//Left
		glBindTexture(GL_TEXTURE_2D, Left_Texture_Name);
			glBegin(GL_QUADS);
				glTexCoord2f(1.0, 0.0);
				glVertex3f(-skyboxWidth, +skyboxWidth, +skyboxWidth);
				glTexCoord2f(0.0, 0.0);
				glVertex3f(-skyboxWidth, +skyboxWidth, -skyboxWidth);
				glTexCoord2f(0.0, 1.0);
				glVertex3f(-skyboxWidth, -skyboxWidth, -skyboxWidth);
				glTexCoord2f(1.0, 1.0);
				glVertex3f(-skyboxWidth, -skyboxWidth, +skyboxWidth);
			glEnd();

	glDisable(GL_TEXTURE_2D);

	glutSolidTeapot(1);
}

//This is called to animate camera
void movecamera(){
	float cameraHeight = 0.04;
	if(frame < rightSplineInner.size() ){
		gluLookAt(cameraPathSplinePoints.at(frame).x, cameraPathSplinePoints.at(frame).y+cameraHeight, cameraPathSplinePoints.at(frame).z, cameraPathSplinePoints.at(frame + 1).x, cameraPathSplinePoints.at(frame + 1).y+cameraHeight, cameraPathSplinePoints.at(frame + 1).z, 0, 1, 0);
		frame += speed;
	}

}

//Calls the created display list
void display()
{
	glCallList(1);
  	glutSwapBuffers();
}

//Stuff necessary to update and redisplay vertex info.
void doIdle()
{
	glClear ( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );
	glLoadIdentity();// clear modelview
	movecamera();
    glutPostRedisplay();
}

//Creates a display list of all static objects (basically everything...)
void createDisplayList(){
	glNewList(1, GL_COMPILE_AND_EXECUTE);
		drawSkybox();
		drawspline();
		drawcrossrail();
	glEndList();
}

//Loads textures and creates display list
void myinit()
{
	glClearColor(0.0, 0.0, 0.0, 0.0);
	glEnable(GL_DEPTH_TEST);

	for(int i = 0; i < g_Splines[0].numControlPoints; i+=1){
		calculateRightInnerRail(g_Splines[0].points[i], g_Splines[0].points[i+1], g_Splines[0].points[i+2], g_Splines[0].points[i+4]);
	}
	calculateLeftInnerRail();
	calculateCameraPath();
	glLineWidth(15);

	glGenTextures(1, &Bottom_Texture_Name);
	loadTexture(Bottom_Texture_Name, "seamless_cobblestone.jpg");

	glGenTextures(1, &Top_Texture_Name);
	loadTexture(Top_Texture_Name, "alpine_top.jpg");

	glGenTextures(1, &Front_Texture_Name);
	loadTexture(Front_Texture_Name, "alpine_front.jpg");

	glGenTextures(1, &Back_Texture_Name);
	loadTexture(Back_Texture_Name, "alpine_back.jpg");

	glGenTextures(1, &Left_Texture_Name);
	loadTexture(Left_Texture_Name, "alpine_left.jpg");

	glGenTextures(1, &Right_Texture_Name);
	loadTexture(Right_Texture_Name, "alpine_right.jpg");

	glGenTextures(1, &Wood_Texture_Name);
	loadTexture(Wood_Texture_Name, "wood.jpg");

	createDisplayList();
}

//this is the main fuction...
int _tmain(int argc, _TCHAR* argv[])
{

	if (argc<2)
	{  
		printf ("usage: %s <trackfile>\n", argv[0]);
		exit(0);
	}

	loadSplines(argv[1]);

	glutInitDisplayMode(GLUT_RGB | GLUT_DOUBLE | GLUT_DEPTH);
	glutInitWindowSize(1000,1000);
	glutCreateWindow("Height Map");

	glMatrixMode( GL_PROJECTION );
	glLoadIdentity();
	gluPerspective( 60,1.0,0.1,2000 );
	glMatrixMode( GL_MODELVIEW );

	//initTexture();

	/* tells glut to use a particular display function to redraw */
	glutDisplayFunc(display);
	
	/* replace with any animate code */
	glutIdleFunc(doIdle);

	/* do initialization */
	myinit();

	glutMainLoop();
	return 0;
}