//Maya ASCII 2013 scene
//Name: Picture_Frame.ma
//Last modified: Wed, Jan 15, 2014 06:55:52 PM
//Codeset: 1252
requires maya "2013";
requires "Mayatomr" "2013.0 - 3.10.1.4 ";
requires "stereoCamera" "10.0";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya 2013";
fileInfo "version" "2013 x64";
fileInfo "cutIdentifier" "201202220241-825136";
fileInfo "osv" "Microsoft Business Edition, 64-bit  (Build 9200)\n";
fileInfo "license" "student";
createNode transform -s -n "persp";
	setAttr ".v" no;
	setAttr ".t" -type "double3" -3.3900816173614277 2.4110285093880748 5.2710751538915979 ;
	setAttr ".r" -type "double3" -8.6149227072172199 -23.000000000000629 2.1595178650705648e-016 ;
createNode camera -s -n "perspShape" -p "persp";
	setAttr -k off ".v" no;
	setAttr ".fl" 34.999999999999986;
	setAttr ".coi" 6.2886599092906019;
	setAttr ".imn" -type "string" "persp";
	setAttr ".den" -type "string" "persp_depth";
	setAttr ".man" -type "string" "persp_mask";
	setAttr ".tp" -type "double3" 0 1.3689953147610361 -0.013713354962383822 ;
	setAttr ".hc" -type "string" "viewSet -p %camera";
createNode transform -s -n "top";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 100.10000000000002 2.2226664952995633e-014 ;
	setAttr ".r" -type "double3" -89.999999999999986 0 0 ;
createNode camera -s -n "topShape" -p "top";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 100.1;
	setAttr ".ow" 20.652834390092877;
	setAttr ".imn" -type "string" "top";
	setAttr ".den" -type "string" "top_depth";
	setAttr ".man" -type "string" "top_mask";
	setAttr ".hc" -type "string" "viewSet -t %camera";
	setAttr ".o" yes;
createNode transform -s -n "front";
	setAttr ".v" no;
	setAttr ".t" -type "double3" -0.59417044021510745 1.5331652175273116 100.11812808640856 ;
createNode camera -s -n "frontShape" -p "front";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 100.1;
	setAttr ".ow" 4.9313912935300861;
	setAttr ".imn" -type "string" "front";
	setAttr ".den" -type "string" "front_depth";
	setAttr ".man" -type "string" "front_mask";
	setAttr ".hc" -type "string" "viewSet -f %camera";
	setAttr ".o" yes;
createNode transform -s -n "side";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 100.10000000000002 0 2.2226664952995633e-014 ;
	setAttr ".r" -type "double3" 0 89.999999999999986 0 ;
createNode camera -s -n "sideShape" -p "side";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 100.1;
	setAttr ".ow" 7.62718457105884;
	setAttr ".imn" -type "string" "side";
	setAttr ".den" -type "string" "side_depth";
	setAttr ".man" -type "string" "side_mask";
	setAttr ".hc" -type "string" "viewSet -s %camera";
	setAttr ".o" yes;
createNode transform -n "pCube1";
	setAttr ".t" -type "double3" 0 1.3689953147610361 0 ;
	setAttr ".r" -type "double3" 0 0 90 ;
	setAttr ".s" -type "double3" 2.2968011269647595 3.1887105815759509 0.061668905921081041 ;
createNode mesh -n "pCubeShape1" -p "pCube1";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".pv" -type "double2" 0.031831787690244417 0.96339164218519868 ;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr -s 4 ".pt[12:15]" -type "float3"  -2.3283064e-010 -2.3283064e-010 
		0 2.3283064e-010 -2.3283064e-010 0 2.3283064e-010 2.3283064e-010 0 -2.3283064e-010 
		2.3283064e-010 0;
	setAttr ".vnm" 0;
createNode mesh -n "polySurfaceShape1" -p "pCube1";
	setAttr -k off ".v";
	setAttr ".io" yes;
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".pv" -type "double2" 0.5 0.5 ;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 16 ".uvst[0].uvsp[0:15]" -type "float2" 0.16603556 0.067706287
		 0.83396447 0.067706287 0.83396447 0.93229365 0.16603556 0.93229365 0.10568637 0.98734212
		 0.89431369 0.98734212 0.90455532 1 0.095444679 1 0.90455532 0 0.095444679 0 0.89431369
		 0.012657821 0.10568637 0.012657821 0.83396447 0.067706287 0.16603556 0.067706287
		 0.83396447 0.93229365 0.16603556 0.93229365;
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr -s 16 ".vt[0:15]"  -0.48734206 -0.48734218 0.5 0.48734206 -0.48734218 0.5
		 -0.48734206 0.48734218 0.5 0.48734206 0.48734218 0.5 -0.5 0.5 -0.94474131 0.5 0.5 -0.94474131
		 -0.5 -0.5 -0.94474131 0.5 -0.5 -0.94474131 -0.41275495 -0.43229371 0.5 0.41275495 -0.43229371 0.5
		 0.41275495 0.43229371 0.5 -0.41275495 0.43229371 0.5 -0.41275495 -0.43229371 -0.043637455
		 0.41275495 -0.43229371 -0.043637455 0.41275495 0.43229371 -0.043637455 -0.41275495 0.43229371 -0.043637455;
	setAttr -s 28 ".ed[0:27]"  0 1 0 2 3 0 4 5 0 6 7 0 0 2 0 1 3 0 2 4 0
		 3 5 0 4 6 0 5 7 0 6 0 0 7 1 0 0 8 0 1 9 0 8 9 0 3 10 0 9 10 0 2 11 0 11 10 0 8 11 0
		 8 12 0 9 13 0 12 13 0 10 14 0 13 14 0 11 15 0 15 14 0 12 15 0;
	setAttr -s 14 -ch 56 ".fc[0:13]" -type "polyFaces" 
		f 4 22 24 -27 -28
		mu 0 4 0 1 2 3
		f 4 1 7 -3 -7
		mu 0 4 4 5 6 7
		f 4 2 9 -4 -9
		mu 0 4 7 6 8 9
		f 4 3 11 -1 -11
		mu 0 4 9 8 10 11
		f 4 -12 -10 -8 -6
		mu 0 4 10 8 6 5
		f 4 10 4 6 8
		mu 0 4 9 11 4 7
		f 4 0 13 -15 -13
		mu 0 4 11 10 12 13
		f 4 5 15 -17 -14
		mu 0 4 10 5 14 12
		f 4 -2 17 18 -16
		mu 0 4 5 4 15 14
		f 4 -5 12 19 -18
		mu 0 4 4 11 13 15
		f 4 14 21 -23 -21
		mu 0 4 13 12 1 0
		f 4 16 23 -25 -22
		mu 0 4 12 14 2 1
		f 4 -19 25 26 -24
		mu 0 4 14 15 3 2
		f 4 -20 20 27 -26
		mu 0 4 15 13 0 3;
	setAttr ".cd" -type "dataPolyComponent" Index_Data Edge 0 ;
	setAttr ".cvd" -type "dataPolyComponent" Index_Data Vertex 0 ;
	setAttr ".hfd" -type "dataPolyComponent" Index_Data Face 0 ;
	setAttr ".vnm" 0;
createNode transform -n "pCube2";
	setAttr ".t" -type "double3" -1.5507428012967155 1.6877572822016609 -0.85383101529765615 ;
	setAttr ".r" -type "double3" 0 0 90 ;
	setAttr ".s" -type "double3" 2.2968011269647595 3.1887105815759509 0.061668905921081041 ;
createNode mesh -n "pCubeShape2" -p "pCube2";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".pv" -type "double2" 0.031831787690244417 0.96339164218519868 ;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 16 ".uvst[0].uvsp[0:15]" -type "float2" 0.90527719 0.13503963
		 0.90636182 0.87519789 0.095371544 0.87439251 0.094657317 0.13641886 0.037968647 0.058841545
		 0.039153475 0.94852525 0.031831786 0.96339166 0.031272203 0.046403121 0.97155106
		 0.046424206 0.96905279 0.96369189 0.96213627 0.9527849 0.96001703 0.058810823 0.91091996
		 0.88061875 0.91059452 0.12966937 0.089819193 0.87936735 0.091213152 0.12872317;
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr -s 4 ".pt[12:15]" -type "float3"  -2.3283064e-010 -2.3283064e-010 
		0 2.3283064e-010 -2.3283064e-010 0 2.3283064e-010 2.3283064e-010 0 -2.3283064e-010 
		2.3283064e-010 0;
	setAttr -s 16 ".vt[0:15]"  -0.48734206 -0.48734218 0.5 0.48734206 -0.48734218 0.5
		 -0.48734206 0.48734218 0.5 0.48734206 0.48734218 0.5 -0.5 0.5 -0.94474131 0.5 0.5 -0.94474131
		 -0.5 -0.5 -0.94474131 0.5 -0.5 -0.94474131 -0.41275495 -0.43229371 0.5 0.41275495 -0.43229371 0.5
		 0.41275495 0.43229371 0.5 -0.41275495 0.43229371 0.5 -0.41275495 -0.43229371 -0.043637455
		 0.41275495 -0.43229371 -0.043637455 0.41275495 0.43229371 -0.043637455 -0.41275495 0.43229371 -0.043637455;
	setAttr -s 28 ".ed[0:27]"  0 1 0 2 3 0 4 5 0 6 7 0 0 2 0 1 3 0 2 4 0
		 3 5 0 4 6 0 5 7 0 6 0 0 7 1 0 0 8 0 1 9 0 8 9 0 3 10 0 9 10 0 2 11 0 11 10 0 8 11 0
		 8 12 0 9 13 0 12 13 0 10 14 0 13 14 0 11 15 0 15 14 0 12 15 0;
	setAttr -s 13 -ch 52 ".fc[0:12]" -type "polyFaces" 
		f 4 22 24 -27 -28
		mu 0 4 0 1 2 3
		f 4 1 7 -3 -7
		mu 0 4 4 5 6 7
		f 4 3 11 -1 -11
		mu 0 4 8 9 10 11
		f 4 -12 -10 -8 -6
		mu 0 4 10 9 6 5
		f 4 10 4 6 8
		mu 0 4 8 11 4 7
		f 4 0 13 -15 -13
		mu 0 4 11 10 12 13
		f 4 5 15 -17 -14
		mu 0 4 10 5 14 12
		f 4 -2 17 18 -16
		mu 0 4 5 4 15 14
		f 4 -5 12 19 -18
		mu 0 4 4 11 13 15
		f 4 14 21 -23 -21
		mu 0 4 13 12 1 0
		f 4 16 23 -25 -22
		mu 0 4 12 14 2 1
		f 4 -19 25 26 -24
		mu 0 4 14 15 3 2
		f 4 -20 20 27 -26
		mu 0 4 15 13 0 3;
	setAttr ".cd" -type "dataPolyComponent" Index_Data Edge 0 ;
	setAttr ".cvd" -type "dataPolyComponent" Index_Data Vertex 0 ;
	setAttr ".hfd" -type "dataPolyComponent" Index_Data Face 0 ;
	setAttr ".vnm" 0;
createNode mesh -n "polySurfaceShape1" -p "pCube2";
	setAttr -k off ".v";
	setAttr ".io" yes;
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".pv" -type "double2" 0.5 0.5 ;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 16 ".uvst[0].uvsp[0:15]" -type "float2" 0.16603556 0.067706287
		 0.83396447 0.067706287 0.83396447 0.93229365 0.16603556 0.93229365 0.10568637 0.98734212
		 0.89431369 0.98734212 0.90455532 1 0.095444679 1 0.90455532 0 0.095444679 0 0.89431369
		 0.012657821 0.10568637 0.012657821 0.83396447 0.067706287 0.16603556 0.067706287
		 0.83396447 0.93229365 0.16603556 0.93229365;
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr -s 16 ".vt[0:15]"  -0.48734206 -0.48734218 0.5 0.48734206 -0.48734218 0.5
		 -0.48734206 0.48734218 0.5 0.48734206 0.48734218 0.5 -0.5 0.5 -0.94474131 0.5 0.5 -0.94474131
		 -0.5 -0.5 -0.94474131 0.5 -0.5 -0.94474131 -0.41275495 -0.43229371 0.5 0.41275495 -0.43229371 0.5
		 0.41275495 0.43229371 0.5 -0.41275495 0.43229371 0.5 -0.41275495 -0.43229371 -0.043637455
		 0.41275495 -0.43229371 -0.043637455 0.41275495 0.43229371 -0.043637455 -0.41275495 0.43229371 -0.043637455;
	setAttr -s 28 ".ed[0:27]"  0 1 0 2 3 0 4 5 0 6 7 0 0 2 0 1 3 0 2 4 0
		 3 5 0 4 6 0 5 7 0 6 0 0 7 1 0 0 8 0 1 9 0 8 9 0 3 10 0 9 10 0 2 11 0 11 10 0 8 11 0
		 8 12 0 9 13 0 12 13 0 10 14 0 13 14 0 11 15 0 15 14 0 12 15 0;
	setAttr -s 14 -ch 56 ".fc[0:13]" -type "polyFaces" 
		f 4 22 24 -27 -28
		mu 0 4 0 1 2 3
		f 4 1 7 -3 -7
		mu 0 4 4 5 6 7
		f 4 2 9 -4 -9
		mu 0 4 7 6 8 9
		f 4 3 11 -1 -11
		mu 0 4 9 8 10 11
		f 4 -12 -10 -8 -6
		mu 0 4 10 8 6 5
		f 4 10 4 6 8
		mu 0 4 9 11 4 7
		f 4 0 13 -15 -13
		mu 0 4 11 10 12 13
		f 4 5 15 -17 -14
		mu 0 4 10 5 14 12
		f 4 -2 17 18 -16
		mu 0 4 5 4 15 14
		f 4 -5 12 19 -18
		mu 0 4 4 11 13 15
		f 4 14 21 -23 -21
		mu 0 4 13 12 1 0
		f 4 16 23 -25 -22
		mu 0 4 12 14 2 1
		f 4 -19 25 26 -24
		mu 0 4 14 15 3 2
		f 4 -20 20 27 -26
		mu 0 4 15 13 0 3;
	setAttr ".cd" -type "dataPolyComponent" Index_Data Edge 0 ;
	setAttr ".cvd" -type "dataPolyComponent" Index_Data Vertex 0 ;
	setAttr ".hfd" -type "dataPolyComponent" Index_Data Face 0 ;
	setAttr ".vnm" 0;
createNode lightLinker -s -n "lightLinker1";
	setAttr -s 8 ".lnk";
	setAttr -s 8 ".slnk";
createNode displayLayerManager -n "layerManager";
createNode displayLayer -n "defaultLayer";
createNode renderLayerManager -n "renderLayerManager";
createNode renderLayer -n "defaultRenderLayer";
	setAttr ".g" yes;
createNode polyMapCut -n "polyMapCut1";
	setAttr ".uopa" yes;
	setAttr ".ics" -type "componentList" 2 "e[2:3]" "e[9]";
createNode polyMapCut -n "polyMapCut2";
	setAttr ".uopa" yes;
	setAttr ".ics" -type "componentList" 2 "e[2:3]" "e[9]";
createNode polyMapCut -n "polyMapCut3";
	setAttr ".uopa" yes;
	setAttr ".ics" -type "componentList" 2 "e[2:3]" "e[9]";
createNode polyMapCut -n "polyMapCut4";
	setAttr ".uopa" yes;
	setAttr ".ics" -type "componentList" 2 "e[2:3]" "e[9]";
createNode polyMapCut -n "polyMapCut5";
	setAttr ".uopa" yes;
	setAttr ".ics" -type "componentList" 2 "e[2:3]" "e[9]";
createNode polyMapCut -n "polyMapCut6";
	setAttr ".uopa" yes;
	setAttr ".ics" -type "componentList" 2 "e[2:3]" "e[9]";
createNode polyTweakUV -n "polyTweakUV1";
	setAttr ".uopa" yes;
	setAttr -s 10 ".uvtk";
	setAttr ".uvtk[0]" -type "float2" 0.017185301 0.015003681 ;
	setAttr ".uvtk[1]" -type "float2" -0.01718533 0.015003681 ;
	setAttr ".uvtk[2]" -type "float2" -0.01718533 -0.015003681 ;
	setAttr ".uvtk[3]" -type "float2" 0.017185301 -0.015003681 ;
	setAttr ".uvtk[6]" -type "float2" 0.035762016 0.029056646 ;
	setAttr ".uvtk[7]" -type "float2" -0.030886963 0.029056646 ;
	setAttr ".uvtk[8]" -type "float2" 0.035762016 -0.023890296 ;
	setAttr ".uvtk[9]" -type "float2" -0.030886963 -0.023890296 ;
	setAttr ".uvtk[16]" -type "float2" -1.6491082 0.029056646 ;
	setAttr ".uvtk[17]" -type "float2" -1.6491082 -0.023890296 ;
createNode polyMapCut -n "polyMapCut7";
	setAttr ".uopa" yes;
	setAttr ".ics" -type "componentList" 3 "e[22]" "e[24]" "e[26:27]";
createNode polyMapCut -n "polyMapCut8";
	setAttr ".uopa" yes;
	setAttr ".ics" -type "componentList" 3 "e[22]" "e[24]" "e[26:27]";
createNode polyTweakUV -n "polyTweakUV2";
	setAttr ".uopa" yes;
	setAttr -s 22 ".uvtk[0:21]" -type "float2" 0.013197266 0.91639292 0.027308986
		 -0.028173774 0.027308986 -0.47191966 0.36417165 -0.47191966 0.40539667 -0.50916636
		 -0.013916127 -0.50916636 -0.038376257 -0.53134596 0.42726484 -0.53134596 -0.038376257
		 0.028505513 0.42726484 0.028505513 -0.013916127 0.0090729147 0.40539667 0.0090729147
		 0.018171523 -0.020196332 0.37330899 -0.020196332 0.018171523 -0.47989708 0.37330899
		 -0.47989708 0.85746861 -0.53134596 0.85746861 0.028505513 0.36417165 -0.028173774
		 0.66977549 0.081638485 0.036084667 -0.4167926 -0.62049341 0.41796198;
createNode script -n "sceneConfigurationScriptNode";
	setAttr ".b" -type "string" "playbackOptions -min 1 -max 24 -ast 1 -aet 48 ";
	setAttr ".st" 6;
createNode deleteComponent -n "deleteComponent1";
	setAttr ".dc" -type "componentList" 1 "f[2]";
createNode polyPlanarProj -n "polyPlanarProj1";
	setAttr ".uopa" yes;
	setAttr ".ics" -type "componentList" 1 "f[0:12]";
	setAttr ".ix" -type "matrix" 2.2968011269647595 0 0 0 0 2.9220415794523236 0 0 0 0 0.061668905921081041 0
		 0 0 0 1;
	setAttr ".ws" yes;
	setAttr ".pc" -type "double3" 0 0 -0.013713355176150801 ;
	setAttr ".ps" -type "double2" 2.2968011269647595 2.9220415794523236 ;
	setAttr ".cam" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1;
createNode polyTweakUV -n "polyTweakUV3";
	setAttr ".uopa" yes;
	setAttr -s 16 ".uvtk[0:15]" -type "float2" 0.10505405 0 -0.10505402
		 0 -0.10505402 0 0.10505405 0 0.12403789 0 -0.12403792 0 -0.12725961 0 0.12725958
		 0 0.12725958 0 -0.12725961 0 -0.12403792 0 0.12403789 0 -0.10505402 0 0.10505405
		 0 -0.10505402 0 0.10505405 0;
createNode lambert -n "lambert2";
createNode shadingEngine -n "lambert2SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo1";
createNode file -n "file1";
	setAttr ".ftn" -type "string" "C:/Users/joshual/Desktop/Boats at sea.jpg";
createNode place2dTexture -n "place2dTexture1";
createNode polyPlanarProj -n "polyPlanarProj2";
	setAttr ".uopa" yes;
	setAttr ".ics" -type "componentList" 1 "f[0:12]";
	setAttr ".ix" -type "matrix" 5.0999229882825669e-016 2.2968011269647595 0 0 -2.9220415794523236 6.4882356808400567e-016 0 0
		 0 0 0.061668905921081041 0 0 0 0 1;
	setAttr ".ws" yes;
	setAttr ".pc" -type "double3" 0 0 -0.013713355176150801 ;
	setAttr ".ps" -type "double2" 2.922041579452324 2.2968011269647599 ;
	setAttr ".cam" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1;
createNode polyTweakUV -n "polyTweakUV4";
	setAttr ".uopa" yes;
	setAttr -s 16 ".uvtk[0:15]" -type "float2" -0.027016463 0.04779458 -0.025931835
		 -0.037557147 0.027665256 -0.038362477 0.026951026 0.049173813 0.025310826 0.046183605
		 0.026495654 -0.038816854 0.031831786 -0.036608353 0.031272203 0.046403121 -0.028448932
		 0.046424206 -0.030947201 -0.036308095 -0.025205841 -0.03455722 -0.027325116 0.046152882
		 -0.021373663 -0.032136235 -0.021699119 0.042424329 0.022112908 -0.03338768 0.023506861
		 0.041478124;
createNode textureBakeSet -n "initialTextureBakeSet";
createNode partition -n "textureBakePartition";
createNode vertexBakeSet -n "initialVertexBakeSet";
	addAttr -ci true -sn "fs" -ln "filterSize" -min -1 -at "double";
	addAttr -ci true -sn "fns" -ln "filterNormalTolerance" -min 0 -max 180 -at "double";
	setAttr ".fs" 0.001;
	setAttr ".fns" 5;
createNode partition -n "vertexBakePartition";
createNode mentalrayItemsList -s -n "mentalrayItemsList";
createNode mentalrayGlobals -s -n "mentalrayGlobals";
createNode mentalrayOptions -s -n "miDefaultOptions";
	addAttr -ci true -m -sn "stringOptions" -ln "stringOptions" -at "compound" -nc 
		3;
	addAttr -ci true -sn "name" -ln "name" -dt "string" -p "stringOptions";
	addAttr -ci true -sn "value" -ln "value" -dt "string" -p "stringOptions";
	addAttr -ci true -sn "type" -ln "type" -dt "string" -p "stringOptions";
	setAttr ".maxr" 2;
	setAttr -s 28 ".stringOptions";
	setAttr ".stringOptions[0].name" -type "string" "rast motion factor";
	setAttr ".stringOptions[0].value" -type "string" "1.0";
	setAttr ".stringOptions[0].type" -type "string" "scalar";
	setAttr ".stringOptions[1].name" -type "string" "rast transparency depth";
	setAttr ".stringOptions[1].value" -type "string" "8";
	setAttr ".stringOptions[1].type" -type "string" "integer";
	setAttr ".stringOptions[2].name" -type "string" "rast useopacity";
	setAttr ".stringOptions[2].value" -type "string" "true";
	setAttr ".stringOptions[2].type" -type "string" "boolean";
	setAttr ".stringOptions[3].name" -type "string" "importon";
	setAttr ".stringOptions[3].value" -type "string" "false";
	setAttr ".stringOptions[3].type" -type "string" "boolean";
	setAttr ".stringOptions[4].name" -type "string" "importon density";
	setAttr ".stringOptions[4].value" -type "string" "1.0";
	setAttr ".stringOptions[4].type" -type "string" "scalar";
	setAttr ".stringOptions[5].name" -type "string" "importon merge";
	setAttr ".stringOptions[5].value" -type "string" "0.0";
	setAttr ".stringOptions[5].type" -type "string" "scalar";
	setAttr ".stringOptions[6].name" -type "string" "importon trace depth";
	setAttr ".stringOptions[6].value" -type "string" "0";
	setAttr ".stringOptions[6].type" -type "string" "integer";
	setAttr ".stringOptions[7].name" -type "string" "importon traverse";
	setAttr ".stringOptions[7].value" -type "string" "true";
	setAttr ".stringOptions[7].type" -type "string" "boolean";
	setAttr ".stringOptions[8].name" -type "string" "shadowmap pixel samples";
	setAttr ".stringOptions[8].value" -type "string" "3";
	setAttr ".stringOptions[8].type" -type "string" "integer";
	setAttr ".stringOptions[9].name" -type "string" "ambient occlusion";
	setAttr ".stringOptions[9].value" -type "string" "false";
	setAttr ".stringOptions[9].type" -type "string" "boolean";
	setAttr ".stringOptions[10].name" -type "string" "ambient occlusion rays";
	setAttr ".stringOptions[10].value" -type "string" "256";
	setAttr ".stringOptions[10].type" -type "string" "integer";
	setAttr ".stringOptions[11].name" -type "string" "ambient occlusion cache";
	setAttr ".stringOptions[11].value" -type "string" "false";
	setAttr ".stringOptions[11].type" -type "string" "boolean";
	setAttr ".stringOptions[12].name" -type "string" "ambient occlusion cache density";
	setAttr ".stringOptions[12].value" -type "string" "1.0";
	setAttr ".stringOptions[12].type" -type "string" "scalar";
	setAttr ".stringOptions[13].name" -type "string" "ambient occlusion cache points";
	setAttr ".stringOptions[13].value" -type "string" "64";
	setAttr ".stringOptions[13].type" -type "string" "integer";
	setAttr ".stringOptions[14].name" -type "string" "irradiance particles";
	setAttr ".stringOptions[14].value" -type "string" "false";
	setAttr ".stringOptions[14].type" -type "string" "boolean";
	setAttr ".stringOptions[15].name" -type "string" "irradiance particles rays";
	setAttr ".stringOptions[15].value" -type "string" "256";
	setAttr ".stringOptions[15].type" -type "string" "integer";
	setAttr ".stringOptions[16].name" -type "string" "irradiance particles interpolate";
	setAttr ".stringOptions[16].value" -type "string" "1";
	setAttr ".stringOptions[16].type" -type "string" "integer";
	setAttr ".stringOptions[17].name" -type "string" "irradiance particles interppoints";
	setAttr ".stringOptions[17].value" -type "string" "64";
	setAttr ".stringOptions[17].type" -type "string" "integer";
	setAttr ".stringOptions[18].name" -type "string" "irradiance particles indirect passes";
	setAttr ".stringOptions[18].value" -type "string" "0";
	setAttr ".stringOptions[18].type" -type "string" "integer";
	setAttr ".stringOptions[19].name" -type "string" "irradiance particles scale";
	setAttr ".stringOptions[19].value" -type "string" "1.0";
	setAttr ".stringOptions[19].type" -type "string" "scalar";
	setAttr ".stringOptions[20].name" -type "string" "irradiance particles env";
	setAttr ".stringOptions[20].value" -type "string" "true";
	setAttr ".stringOptions[20].type" -type "string" "boolean";
	setAttr ".stringOptions[21].name" -type "string" "irradiance particles env rays";
	setAttr ".stringOptions[21].value" -type "string" "256";
	setAttr ".stringOptions[21].type" -type "string" "integer";
	setAttr ".stringOptions[22].name" -type "string" "irradiance particles env scale";
	setAttr ".stringOptions[22].value" -type "string" "1";
	setAttr ".stringOptions[22].type" -type "string" "integer";
	setAttr ".stringOptions[23].name" -type "string" "irradiance particles rebuild";
	setAttr ".stringOptions[23].value" -type "string" "true";
	setAttr ".stringOptions[23].type" -type "string" "boolean";
	setAttr ".stringOptions[24].name" -type "string" "irradiance particles file";
	setAttr ".stringOptions[24].value" -type "string" "";
	setAttr ".stringOptions[24].type" -type "string" "string";
	setAttr ".stringOptions[25].name" -type "string" "geom displace motion factor";
	setAttr ".stringOptions[25].value" -type "string" "1.0";
	setAttr ".stringOptions[25].type" -type "string" "scalar";
	setAttr ".stringOptions[26].name" -type "string" "contrast all buffers";
	setAttr ".stringOptions[26].value" -type "string" "true";
	setAttr ".stringOptions[26].type" -type "string" "boolean";
	setAttr ".stringOptions[27].name" -type "string" "finalgather normal tolerance";
	setAttr ".stringOptions[27].value" -type "string" "25.842";
	setAttr ".stringOptions[27].type" -type "string" "scalar";
createNode mentalrayFramebuffer -s -n "miDefaultFramebuffer";
createNode shadingEngine -n "baked_lambert2SG_pCube1SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo2";
createNode lambert -n "lambert3";
	setAttr ".c" -type "float3" 0 0 0 ;
createNode file -n "baked_lambert2SG_pCube1_fnbake1";
	setAttr ".ftn" -type "string" "z:/Autodesk/projects/default/renderData/mentalray/lightMap/baked-lambert2SG-pCube1.tif";
createNode place2dTexture -n "place2dTexture2";
createNode shadingEngine -n "baked_baked_lambert2SG_pCube1SG_pCube1SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo3";
createNode lambert -n "lambert4";
	setAttr ".c" -type "float3" 0 0 0 ;
createNode file -n "baked_baked_lambert2SG_pCube1SG_pCube1_fnbake1";
	setAttr ".ftn" -type "string" "C:/Users/joshual/Desktop/New_Project//renderData/mentalray/lightMap/baked-baked_lambert2SG_pCube1SG-pCube1.tif";
createNode place2dTexture -n "place2dTexture3";
createNode lambert -n "Sea_Painting_Texture";
createNode shadingEngine -n "lambert5SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo4";
createNode file -n "file2";
	setAttr ".ftn" -type "string" "C:/Users/joshual/Desktop/Art Portfolio/The Nautilus Assets/Picture Frame/Textures/Sea_Painting.tif";
createNode place2dTexture -n "place2dTexture4";
createNode lambert -n "lambert6";
createNode shadingEngine -n "lambert6SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo5";
createNode file -n "file3";
	setAttr ".ftn" -type "string" "C:/Users/joshual/Desktop/Picture_Frame_Texture.tif";
createNode place2dTexture -n "place2dTexture5";
createNode lambert -n "Blank_Picture";
createNode shadingEngine -n "lambert7SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo6";
createNode file -n "file4";
	setAttr ".ftn" -type "string" "C:/Users/joshual/Desktop/Art Portfolio/The Nautilus Assets/Picture Frame/Textures/Portrait_Nemo_Texture.tif";
createNode place2dTexture -n "place2dTexture6";
select -ne :time1;
	setAttr ".o" 1;
	setAttr ".unw" 1;
select -ne :renderPartition;
	setAttr -s 8 ".st";
select -ne :initialShadingGroup;
	setAttr ".ro" yes;
select -ne :initialParticleSE;
	setAttr ".ro" yes;
select -ne :defaultShaderList1;
	setAttr -s 8 ".s";
select -ne :defaultTextureList1;
	setAttr -s 6 ".tx";
select -ne :postProcessList1;
	setAttr -s 2 ".p";
select -ne :defaultRenderUtilityList1;
	setAttr -s 4 ".u";
select -ne :defaultRenderingList1;
select -ne :renderGlobalsList1;
select -ne :hardwareRenderGlobals;
	setAttr ".ctrs" 256;
	setAttr ".btrs" 512;
select -ne :defaultHardwareRenderGlobals;
	setAttr ".fn" -type "string" "im";
	setAttr ".res" -type "string" "ntsc_4d 646 485 1.333";
connectAttr "polyTweakUV4.out" "pCubeShape1.i";
connectAttr "polyTweakUV4.uvtk[0]" "pCubeShape1.uvst[0].uvtw";
relationship "link" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "lambert2SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "baked_lambert2SG_pCube1SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "baked_baked_lambert2SG_pCube1SG_pCube1SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "lambert5SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "lambert6SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "lambert7SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "lambert2SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "baked_lambert2SG_pCube1SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "baked_baked_lambert2SG_pCube1SG_pCube1SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "lambert5SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "lambert6SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "lambert7SG.message" ":defaultLightSet.message";
connectAttr "layerManager.dli[0]" "defaultLayer.id";
connectAttr "renderLayerManager.rlmi[0]" "defaultRenderLayer.rlid";
connectAttr "|pCube1|polySurfaceShape1.o" "polyMapCut1.ip";
connectAttr "polyMapCut1.out" "polyMapCut2.ip";
connectAttr "polyMapCut2.out" "polyMapCut3.ip";
connectAttr "polyMapCut3.out" "polyMapCut4.ip";
connectAttr "polyMapCut4.out" "polyMapCut5.ip";
connectAttr "polyMapCut5.out" "polyMapCut6.ip";
connectAttr "polyMapCut6.out" "polyTweakUV1.ip";
connectAttr "polyTweakUV1.out" "polyMapCut7.ip";
connectAttr "polyMapCut7.out" "polyMapCut8.ip";
connectAttr "polyMapCut8.out" "polyTweakUV2.ip";
connectAttr "polyTweakUV2.out" "deleteComponent1.ig";
connectAttr "deleteComponent1.og" "polyPlanarProj1.ip";
connectAttr "pCubeShape1.wm" "polyPlanarProj1.mp";
connectAttr "polyPlanarProj1.out" "polyTweakUV3.ip";
connectAttr "file1.oc" "lambert2.c";
connectAttr "lambert2.oc" "lambert2SG.ss";
connectAttr "lambert2SG.msg" "materialInfo1.sg";
connectAttr "lambert2.msg" "materialInfo1.m";
connectAttr "file1.msg" "materialInfo1.t" -na;
connectAttr "place2dTexture1.c" "file1.c";
connectAttr "place2dTexture1.tf" "file1.tf";
connectAttr "place2dTexture1.rf" "file1.rf";
connectAttr "place2dTexture1.mu" "file1.mu";
connectAttr "place2dTexture1.mv" "file1.mv";
connectAttr "place2dTexture1.s" "file1.s";
connectAttr "place2dTexture1.wu" "file1.wu";
connectAttr "place2dTexture1.wv" "file1.wv";
connectAttr "place2dTexture1.re" "file1.re";
connectAttr "place2dTexture1.of" "file1.of";
connectAttr "place2dTexture1.r" "file1.ro";
connectAttr "place2dTexture1.n" "file1.n";
connectAttr "place2dTexture1.vt1" "file1.vt1";
connectAttr "place2dTexture1.vt2" "file1.vt2";
connectAttr "place2dTexture1.vt3" "file1.vt3";
connectAttr "place2dTexture1.vc1" "file1.vc1";
connectAttr "place2dTexture1.o" "file1.uv";
connectAttr "place2dTexture1.ofs" "file1.fs";
connectAttr "polyTweakUV3.out" "polyPlanarProj2.ip";
connectAttr "pCubeShape1.wm" "polyPlanarProj2.mp";
connectAttr "polyPlanarProj2.out" "polyTweakUV4.ip";
connectAttr "initialTextureBakeSet.pa" "textureBakePartition.st" -na;
connectAttr "initialVertexBakeSet.pa" "vertexBakePartition.st" -na;
connectAttr ":mentalrayGlobals.msg" ":mentalrayItemsList.glb";
connectAttr ":miDefaultOptions.msg" ":mentalrayItemsList.opt" -na;
connectAttr ":miDefaultFramebuffer.msg" ":mentalrayItemsList.fb" -na;
connectAttr ":miDefaultOptions.msg" ":mentalrayGlobals.opt";
connectAttr ":miDefaultFramebuffer.msg" ":mentalrayGlobals.fb";
connectAttr "lambert3.oc" "baked_lambert2SG_pCube1SG.ss";
connectAttr "baked_lambert2SG_pCube1SG.msg" "materialInfo2.sg";
connectAttr "lambert3.msg" "materialInfo2.m";
connectAttr "baked_lambert2SG_pCube1_fnbake1.msg" "materialInfo2.t" -na;
connectAttr "baked_lambert2SG_pCube1_fnbake1.oc" "materialInfo2.tc";
connectAttr "baked_lambert2SG_pCube1_fnbake1.oc" "lambert3.ic";
connectAttr "place2dTexture2.o" "baked_lambert2SG_pCube1_fnbake1.uv";
connectAttr "place2dTexture2.ofs" "baked_lambert2SG_pCube1_fnbake1.fs";
connectAttr "place2dTexture2.c" "baked_lambert2SG_pCube1_fnbake1.c";
connectAttr "place2dTexture2.tf" "baked_lambert2SG_pCube1_fnbake1.tf";
connectAttr "place2dTexture2.rf" "baked_lambert2SG_pCube1_fnbake1.rf";
connectAttr "place2dTexture2.mu" "baked_lambert2SG_pCube1_fnbake1.mu";
connectAttr "place2dTexture2.mv" "baked_lambert2SG_pCube1_fnbake1.mv";
connectAttr "place2dTexture2.s" "baked_lambert2SG_pCube1_fnbake1.s";
connectAttr "place2dTexture2.wu" "baked_lambert2SG_pCube1_fnbake1.wu";
connectAttr "place2dTexture2.wv" "baked_lambert2SG_pCube1_fnbake1.wv";
connectAttr "place2dTexture2.re" "baked_lambert2SG_pCube1_fnbake1.re";
connectAttr "place2dTexture2.vt1" "baked_lambert2SG_pCube1_fnbake1.vt1";
connectAttr "place2dTexture2.vt2" "baked_lambert2SG_pCube1_fnbake1.vt2";
connectAttr "place2dTexture2.vt3" "baked_lambert2SG_pCube1_fnbake1.vt3";
connectAttr "place2dTexture2.vc1" "baked_lambert2SG_pCube1_fnbake1.vc1";
connectAttr "place2dTexture2.n" "baked_lambert2SG_pCube1_fnbake1.n";
connectAttr "place2dTexture2.of" "baked_lambert2SG_pCube1_fnbake1.of";
connectAttr "place2dTexture2.r" "baked_lambert2SG_pCube1_fnbake1.ro";
connectAttr "lambert4.oc" "baked_baked_lambert2SG_pCube1SG_pCube1SG.ss";
connectAttr "baked_baked_lambert2SG_pCube1SG_pCube1SG.msg" "materialInfo3.sg";
connectAttr "lambert4.msg" "materialInfo3.m";
connectAttr "baked_baked_lambert2SG_pCube1SG_pCube1_fnbake1.msg" "materialInfo3.t"
		 -na;
connectAttr "baked_baked_lambert2SG_pCube1SG_pCube1_fnbake1.oc" "materialInfo3.tc"
		;
connectAttr "baked_baked_lambert2SG_pCube1SG_pCube1_fnbake1.oc" "lambert4.ic";
connectAttr "place2dTexture3.o" "baked_baked_lambert2SG_pCube1SG_pCube1_fnbake1.uv"
		;
connectAttr "place2dTexture3.ofs" "baked_baked_lambert2SG_pCube1SG_pCube1_fnbake1.fs"
		;
connectAttr "place2dTexture3.c" "baked_baked_lambert2SG_pCube1SG_pCube1_fnbake1.c"
		;
connectAttr "place2dTexture3.tf" "baked_baked_lambert2SG_pCube1SG_pCube1_fnbake1.tf"
		;
connectAttr "place2dTexture3.rf" "baked_baked_lambert2SG_pCube1SG_pCube1_fnbake1.rf"
		;
connectAttr "place2dTexture3.mu" "baked_baked_lambert2SG_pCube1SG_pCube1_fnbake1.mu"
		;
connectAttr "place2dTexture3.mv" "baked_baked_lambert2SG_pCube1SG_pCube1_fnbake1.mv"
		;
connectAttr "place2dTexture3.s" "baked_baked_lambert2SG_pCube1SG_pCube1_fnbake1.s"
		;
connectAttr "place2dTexture3.wu" "baked_baked_lambert2SG_pCube1SG_pCube1_fnbake1.wu"
		;
connectAttr "place2dTexture3.wv" "baked_baked_lambert2SG_pCube1SG_pCube1_fnbake1.wv"
		;
connectAttr "place2dTexture3.re" "baked_baked_lambert2SG_pCube1SG_pCube1_fnbake1.re"
		;
connectAttr "place2dTexture3.vt1" "baked_baked_lambert2SG_pCube1SG_pCube1_fnbake1.vt1"
		;
connectAttr "place2dTexture3.vt2" "baked_baked_lambert2SG_pCube1SG_pCube1_fnbake1.vt2"
		;
connectAttr "place2dTexture3.vt3" "baked_baked_lambert2SG_pCube1SG_pCube1_fnbake1.vt3"
		;
connectAttr "place2dTexture3.vc1" "baked_baked_lambert2SG_pCube1SG_pCube1_fnbake1.vc1"
		;
connectAttr "place2dTexture3.n" "baked_baked_lambert2SG_pCube1SG_pCube1_fnbake1.n"
		;
connectAttr "place2dTexture3.of" "baked_baked_lambert2SG_pCube1SG_pCube1_fnbake1.of"
		;
connectAttr "place2dTexture3.r" "baked_baked_lambert2SG_pCube1SG_pCube1_fnbake1.ro"
		;
connectAttr "file2.oc" "Sea_Painting_Texture.c";
connectAttr "Sea_Painting_Texture.oc" "lambert5SG.ss";
connectAttr "pCubeShape1.iog" "lambert5SG.dsm" -na;
connectAttr "lambert5SG.msg" "materialInfo4.sg";
connectAttr "Sea_Painting_Texture.msg" "materialInfo4.m";
connectAttr "file2.msg" "materialInfo4.t" -na;
connectAttr "place2dTexture4.c" "file2.c";
connectAttr "place2dTexture4.tf" "file2.tf";
connectAttr "place2dTexture4.rf" "file2.rf";
connectAttr "place2dTexture4.mu" "file2.mu";
connectAttr "place2dTexture4.mv" "file2.mv";
connectAttr "place2dTexture4.s" "file2.s";
connectAttr "place2dTexture4.wu" "file2.wu";
connectAttr "place2dTexture4.wv" "file2.wv";
connectAttr "place2dTexture4.re" "file2.re";
connectAttr "place2dTexture4.of" "file2.of";
connectAttr "place2dTexture4.r" "file2.ro";
connectAttr "place2dTexture4.n" "file2.n";
connectAttr "place2dTexture4.vt1" "file2.vt1";
connectAttr "place2dTexture4.vt2" "file2.vt2";
connectAttr "place2dTexture4.vt3" "file2.vt3";
connectAttr "place2dTexture4.vc1" "file2.vc1";
connectAttr "place2dTexture4.o" "file2.uv";
connectAttr "place2dTexture4.ofs" "file2.fs";
connectAttr "file3.oc" "lambert6.c";
connectAttr "lambert6.oc" "lambert6SG.ss";
connectAttr "lambert6SG.msg" "materialInfo5.sg";
connectAttr "lambert6.msg" "materialInfo5.m";
connectAttr "file3.msg" "materialInfo5.t" -na;
connectAttr "place2dTexture5.c" "file3.c";
connectAttr "place2dTexture5.tf" "file3.tf";
connectAttr "place2dTexture5.rf" "file3.rf";
connectAttr "place2dTexture5.mu" "file3.mu";
connectAttr "place2dTexture5.mv" "file3.mv";
connectAttr "place2dTexture5.s" "file3.s";
connectAttr "place2dTexture5.wu" "file3.wu";
connectAttr "place2dTexture5.wv" "file3.wv";
connectAttr "place2dTexture5.re" "file3.re";
connectAttr "place2dTexture5.of" "file3.of";
connectAttr "place2dTexture5.r" "file3.ro";
connectAttr "place2dTexture5.n" "file3.n";
connectAttr "place2dTexture5.vt1" "file3.vt1";
connectAttr "place2dTexture5.vt2" "file3.vt2";
connectAttr "place2dTexture5.vt3" "file3.vt3";
connectAttr "place2dTexture5.vc1" "file3.vc1";
connectAttr "place2dTexture5.o" "file3.uv";
connectAttr "place2dTexture5.ofs" "file3.fs";
connectAttr "file4.oc" "Blank_Picture.c";
connectAttr "Blank_Picture.oc" "lambert7SG.ss";
connectAttr "pCubeShape2.iog" "lambert7SG.dsm" -na;
connectAttr "lambert7SG.msg" "materialInfo6.sg";
connectAttr "Blank_Picture.msg" "materialInfo6.m";
connectAttr "file4.msg" "materialInfo6.t" -na;
connectAttr "place2dTexture6.c" "file4.c";
connectAttr "place2dTexture6.tf" "file4.tf";
connectAttr "place2dTexture6.rf" "file4.rf";
connectAttr "place2dTexture6.mu" "file4.mu";
connectAttr "place2dTexture6.mv" "file4.mv";
connectAttr "place2dTexture6.s" "file4.s";
connectAttr "place2dTexture6.wu" "file4.wu";
connectAttr "place2dTexture6.wv" "file4.wv";
connectAttr "place2dTexture6.re" "file4.re";
connectAttr "place2dTexture6.of" "file4.of";
connectAttr "place2dTexture6.r" "file4.ro";
connectAttr "place2dTexture6.n" "file4.n";
connectAttr "place2dTexture6.vt1" "file4.vt1";
connectAttr "place2dTexture6.vt2" "file4.vt2";
connectAttr "place2dTexture6.vt3" "file4.vt3";
connectAttr "place2dTexture6.vc1" "file4.vc1";
connectAttr "place2dTexture6.o" "file4.uv";
connectAttr "place2dTexture6.ofs" "file4.fs";
connectAttr "lambert2SG.pa" ":renderPartition.st" -na;
connectAttr "baked_lambert2SG_pCube1SG.pa" ":renderPartition.st" -na;
connectAttr "baked_baked_lambert2SG_pCube1SG_pCube1SG.pa" ":renderPartition.st" 
		-na;
connectAttr "lambert5SG.pa" ":renderPartition.st" -na;
connectAttr "lambert6SG.pa" ":renderPartition.st" -na;
connectAttr "lambert7SG.pa" ":renderPartition.st" -na;
connectAttr "lambert2.msg" ":defaultShaderList1.s" -na;
connectAttr "lambert3.msg" ":defaultShaderList1.s" -na;
connectAttr "lambert4.msg" ":defaultShaderList1.s" -na;
connectAttr "Sea_Painting_Texture.msg" ":defaultShaderList1.s" -na;
connectAttr "lambert6.msg" ":defaultShaderList1.s" -na;
connectAttr "Blank_Picture.msg" ":defaultShaderList1.s" -na;
connectAttr "file1.msg" ":defaultTextureList1.tx" -na;
connectAttr "baked_lambert2SG_pCube1_fnbake1.msg" ":defaultTextureList1.tx" -na;
connectAttr "baked_baked_lambert2SG_pCube1SG_pCube1_fnbake1.msg" ":defaultTextureList1.tx"
		 -na;
connectAttr "file2.msg" ":defaultTextureList1.tx" -na;
connectAttr "file3.msg" ":defaultTextureList1.tx" -na;
connectAttr "file4.msg" ":defaultTextureList1.tx" -na;
connectAttr "place2dTexture1.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "place2dTexture4.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "place2dTexture5.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "place2dTexture6.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "defaultRenderLayer.msg" ":defaultRenderingList1.r" -na;
// End of Picture_Frame.ma
