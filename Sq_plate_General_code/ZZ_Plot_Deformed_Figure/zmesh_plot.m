path1 = genpath('Input');
path2 = genpath('output');
addpath(path1,path2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                         INPUT STARTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% ---------> 1
filename = 'normalization_parameters.txt' ;
data_normalization_para = load(filename) ;
Lo = data_normalization_para(1,1) ;  % Length
Eo = data_normalization_para(1,2) ; % Youngs Modulous
To = data_normalization_para(1,3) ; % Time


% ---------> 2
% Factor by which the displacement must be multiplied to get a visible
% deformed geometry

filename = 'factor.txt' ;
factor = load(filename) ;

% ---------> 3
% Initial data
filename = 'origin.txt' ;
data1 = load(filename) ;

Xo = data1(1,1); 
Yo = data1(1,2);

% ---------> 4
% Length of beam and thickness of beam

filename = 'geometric_data.txt' ;
data2 = load(filename) ;

Lx = data2(1,1); 
Ly = data2(1,2);
thickness_of_beam  = data2(1,3);

% ---------> 5
% Number of elements in y and x direction

filename = 'fe_data.txt' ;
data3 = load(filename) ;
  

% Number of Elements
nel = data3(1,1);

% Number of Nodes
nno = data3(1,2) ; 
ndof = data3(1,3) ;


% ---------> 6
% Element Connectivity
filename = 'connectivity.txt' ;
CON = load(filename) ;

% ---------> 7
% Load the data file
PX1 = load('initial_coordinate.txt') ;
PX2 = load('deformed_coordinate.txt') ;
PX3 = load('deformed_displacement.txt') ;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                         INPUT ENDS                                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


PXDeformed = PX2 + factor * PX3 ;

MaxLx = max(PX2(:,1));
MaxLy = max(PX2(:,2));

Mx = 0.1*Lx ; axe = [Xo-Mx Xo+MaxLx+Mx Yo-Mx Yo+MaxLy+Mx] ;

% Plot the undeformed configuration
col = 'g' ;
for i = 1:nel
  
    X = [PX1(CON(i,1),1) PX1(CON(i,2),1) PX1(CON(i,3),1) PX1(CON(i,4),1) PX1(CON(i,1),1)] ;
    Y = [PX1(CON(i,1),2) PX1(CON(i,2),2) PX1(CON(i,3),2) PX1(CON(i,4),2) PX1(CON(i,1),2)] ;   
    
    if col == 'o'
        plot(X,Y,'k') ; hold on
    else
        fill(X,Y,col) ; hold on
    end
    
end
 
% Plot the deformed configuration
col = 'r' ;
for i = 1:nel
  
    X = [PXDeformed(CON(i,1),1) PXDeformed(CON(i,2),1) PXDeformed(CON(i,3),1) PXDeformed(CON(i,4),1) PXDeformed(CON(i,1),1)] ;
    Y = [PXDeformed(CON(i,1),2) PXDeformed(CON(i,2),2) PXDeformed(CON(i,3),2) PXDeformed(CON(i,4),2) PXDeformed(CON(i,1),2)] ;   
    
    if col == 'o'
        plot(X,Y,'r') ; hold on
    else
        fill(X,Y,col) ; hold on
    end
    
end

% Figure Properties
xlabel('X / L_o')
ylabel('Y / L_o')
string_title = strcat('Deformed figure ');
title(string_title) ;

%shading interp
axis(axe)
axis equal
