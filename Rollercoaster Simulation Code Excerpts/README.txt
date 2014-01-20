README

Program Features:

-Rollercoaster is rendered with Catmull-Rom splines.  
 The track rails are thickened GL_LINES.
 The crossbars are textured GL_QUADS

-The ground and sky are made with GL_QUADS.
 They're textured with some sort of alpine skybox textures.
 I got the textures from:
 http://www.redsorceress.com/skybox.html
 http://www.cgtextures.com/

-The camera is animated with the movecamera() function

-I placed a point light in my scene.  
 You can see it's effects best on the teapot 
 next to the rollercoaster.



OVERALL NOTE:  

When riding the roller coaster, the up normal is always
pointing straight up the y-axis.  I made the track in such
a way that both the left and right rails are always at the
same y height.  

The light normals on the track are the 
lines perpenicular to the slope of the spline at each
individual spot.