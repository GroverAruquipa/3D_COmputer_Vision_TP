% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 5371.393513813539357 ; 5794.382596264904350 ];

%-- Principal point:
cc = [ 2015.500000000000000 ; 1511.500000000000000 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ 0.098876995756925 ; -1.029828543711605 ; 0.053608843077963 ; 0.007985437804794 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 173.297177912144178 ; 209.381823489168823 ];

%-- Principal point uncertainty:
cc_error = [ 0.000000000000000 ; 0.000000000000000 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.229768047578438 ; 1.914112307344265 ; 0.010458247778487 ; 0.010017340160453 ; 0.000000000000000 ];

%-- Image size:
nx = 4032;
ny = 3024;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 15;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 0;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ -1.929302e+00 ; -1.928881e+00 ; 5.782394e-01 ];
Tc_1  = [ -1.808988e+02 ; -1.363584e+02 ; 9.220091e+02 ];
omc_error_1 = [ 2.321711e-02 ; 2.439133e-02 ; 3.458130e-02 ];
Tc_error_1  = [ 3.762989e+00 ; 1.468691e+00 ; 2.936686e+01 ];

%-- Image #2:
omc_2 = [ 1.641886e+00 ; 1.716317e+00 ; -7.425491e-01 ];
Tc_2  = [ -1.961489e+02 ; -9.766650e+01 ; 8.448257e+02 ];
omc_error_2 = [ 1.349118e-02 ; 1.566504e-02 ; 2.081579e-02 ];
Tc_error_2  = [ 1.361140e+00 ; 2.692142e+00 ; 2.405835e+01 ];

%-- Image #3:
omc_3 = [ 1.474835e+00 ; 1.587021e+00 ; -9.042669e-01 ];
Tc_3  = [ -2.005188e+02 ; -3.754383e+01 ; 8.784479e+02 ];
omc_error_3 = [ 1.005739e-02 ; 1.219978e-02 ; 1.529730e-02 ];
Tc_error_3  = [ 1.423137e+00 ; 1.931432e+00 ; 2.461232e+01 ];

%-- Image #4:
omc_4 = [ 1.830746e+00 ; 1.212043e+00 ; -8.183467e-01 ];
Tc_4  = [ -2.376730e+02 ; 9.265178e+00 ; 8.650469e+02 ];
omc_error_4 = [ 1.456628e-02 ; 1.111276e-02 ; 1.308268e-02 ];
Tc_error_4  = [ 1.186901e+00 ; 1.737369e+00 ; 2.616665e+01 ];

%-- Image #5:
omc_5 = [ 2.067214e+00 ; 9.241551e-01 ; -9.673647e-02 ];
Tc_5  = [ -2.140588e+02 ; -5.954056e+01 ; 8.366064e+02 ];
omc_error_5 = [ 1.662165e-02 ; 1.163485e-02 ; 2.273816e-02 ];
Tc_error_5  = [ 1.258920e+00 ; 2.012439e+00 ; 2.898092e+01 ];

%-- Image #6:
omc_6 = [ 1.605821e+00 ; 1.740420e+00 ; -8.173618e-01 ];
Tc_6  = [ -1.793392e+02 ; -1.230629e+02 ; 1.617616e+03 ];
omc_error_6 = [ 2.014966e-02 ; 2.212935e-02 ; 3.071188e-02 ];
Tc_error_6  = [ 2.724696e+00 ; 4.409665e+00 ; 5.137879e+01 ];

%-- Image #7:
omc_7 = [ 2.301534e+00 ; -6.194735e-01 ; -5.359973e-01 ];
Tc_7  = [ -6.328169e+01 ; 2.376155e+02 ; 9.324197e+02 ];
omc_error_7 = [ 1.655434e-02 ; 1.111285e-02 ; 3.548577e-02 ];
Tc_error_7  = [ 2.103305e+00 ; 3.300093e+00 ; 3.506442e+01 ];

%-- Image #8:
omc_8 = [ -2.732725e+00 ; 2.863122e-01 ; 1.485697e+00 ];
Tc_8  = [ -2.761237e+01 ; 1.568163e+02 ; 1.255060e+03 ];
omc_error_8 = [ 1.915079e-02 ; 1.329562e-02 ; 3.062569e-02 ];
Tc_error_8  = [ 2.730860e+00 ; 1.755580e+00 ; 4.230821e+01 ];

%-- Image #9:
omc_9 = [ 2.238115e+00 ; 1.151835e-01 ; -3.842881e-02 ];
Tc_9  = [ -1.448620e+02 ; 2.051104e+02 ; 1.237150e+03 ];
omc_error_9 = [ 2.695065e-02 ; 1.171016e-02 ; 2.808620e-02 ];
Tc_error_9  = [ 2.182748e+00 ; 5.942512e+00 ; 4.911309e+01 ];

%-- Image #10:
omc_10 = [ -2.621500e+00 ; 8.182848e-01 ; 1.011015e+00 ];
Tc_10  = [ -3.896752e+01 ; 1.294443e+02 ; 1.145895e+03 ];
omc_error_10 = [ 2.272651e-02 ; 1.192501e-02 ; 3.957754e-02 ];
Tc_error_10  = [ 2.507214e+00 ; 2.026628e+00 ; 3.657307e+01 ];

%-- Image #11:
omc_11 = [ -1.607413e+00 ; -1.990272e+00 ; 9.804872e-01 ];
Tc_11  = [ -9.330586e+01 ; -3.260508e+01 ; 1.532752e+03 ];
omc_error_11 = [ 2.025869e-02 ; 2.775557e-02 ; 3.043703e-02 ];
Tc_error_11  = [ 3.844296e+00 ; 2.790338e+00 ; 5.376322e+01 ];

%-- Image #12:
omc_12 = [ -1.770402e+00 ; -1.891279e+00 ; 8.750129e-01 ];
Tc_12  = [ -1.280296e+02 ; -1.013422e+02 ; 1.546213e+03 ];
omc_error_12 = [ 2.394252e-02 ; 2.737788e-02 ; 3.372248e-02 ];
Tc_error_12  = [ 4.377411e+00 ; 2.574102e+00 ; 5.306379e+01 ];

%-- Image #13:
omc_13 = [ -1.964224e+00 ; -1.781244e+00 ; 6.245463e-01 ];
Tc_13  = [ -7.496157e+00 ; -1.520351e+02 ; 1.084693e+03 ];
omc_error_13 = [ 2.906647e-02 ; 2.696493e-02 ; 4.727284e-02 ];
Tc_error_13  = [ 2.747207e+00 ; 1.630905e+00 ; 3.824948e+01 ];

%-- Image #14:
omc_14 = [ -2.143351e+00 ; -1.377880e+00 ; 4.486429e-01 ];
Tc_14  = [ -1.074065e+02 ; -1.668409e+02 ; 1.234097e+03 ];
omc_error_14 = [ 2.457377e-02 ; 1.734906e-02 ; 5.535607e-02 ];
Tc_error_14  = [ 3.467458e+00 ; 2.329786e+00 ; 4.037159e+01 ];

%-- Image #15:
omc_15 = [ -1.831402e+00 ; -1.507960e+00 ; 8.605479e-01 ];
Tc_15  = [ -7.172658e+01 ; -1.252970e+02 ; 1.160307e+03 ];
omc_error_15 = [ 1.740149e-02 ; 1.543002e-02 ; 2.520220e-02 ];
Tc_error_15  = [ 2.965878e+00 ; 1.808736e+00 ; 3.755196e+01 ];

