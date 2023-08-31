path1 = genpath('Input');
addpath(path1);


% % Number of elements in y direction
% ny = 4 ;
% 
% % Number of elements in x direction
% nx = 4 ; % <--- change this for your own problem


% connectivity and coordinate input


if mesh_type == 1
    coord = readmatrix('coord8.csv');
    connect = readmatrix('connect8.csv');
    bc_node_x = readmatrix('bc_node_x8.csv');
    bc_node_y = readmatrix('bc_node_y8.csv');

elseif mesh_type == 2
    coord = readmatrix('coord20.csv');
    connect = readmatrix('connect20.csv');
    bc_node_x = readmatrix('bc_node_x20.csv');
    bc_node_y = readmatrix('bc_node_y20.csv');

elseif mesh_type == 3
    coord = readmatrix('coord30.csv');
    connect = readmatrix('connect30.csv');
    bc_node_x = readmatrix('bc_node_x30.csv');
    bc_node_y = readmatrix('bc_node_y30.csv');
elseif mesh_type == 4
    coord = readmatrix('coord40.csv');
    connect = readmatrix('connect40.csv');
    bc_node_x = readmatrix('bc_node_x40.csv');
    bc_node_y = readmatrix('bc_node_y40.csv');

elseif mesh_type == 5
coord = readmatrix('coord50.csv');
    connect = readmatrix('connect50.csv');
    bc_node_x = readmatrix('bc_node_x50.csv');
    bc_node_y = readmatrix('bc_node_y50.csv');
end

% Number of Elements
nel = size(connect,1) ;

% Number of Nodes
nno = size(coord,1) ;

% Number of dofs per element 
ndoel = 8 ;
 
% Number of dofs in the FE mesh, Number of dofs per element
ndof = 2*nno ; ndoelo = 8 ;

CON = zeros(nel,4) ; % since 4 nodes per element
CON = connect ;



filename = 'Input/fe_data.txt' ;
fid = fopen(filename,'w') ;
fprintf(fid,' %g \t %g \t %g',nel,nno,ndof);
fclose(fid);

% Element Connectivity
%
% Note that the below code works only for rectangular bodies. You can
% either write your own code or take input from comemrcial FE packages like
% ANSYS. In that case change the below code accordingly.


% iel = 0 ;
% for j = 1:ny
%     for i = 1:nx 
%         iel = iel + 1 ; 
%         CON(iel,:) = [ (j-1)*(nx+1)+i  (j-1)*(nx+1)+i+1  j*(nx+1)+i+1  j*(nx+1)+i ] ;    
%     end
% end

filename = 'Input/connectivity.txt' ;
fid = fopen(filename,'w') ;
for iel = 1:nel
    if iel < nel
        fprintf(fid,'%g \t %g \t %g \t %g \n',CON(iel,:));   
    else
        fprintf(fid,'%g \t %g \t %g \t %g',CON(iel,:));
    end
end
fclose(fid);



% ino = 0 ;
% for j = 0:ny
%     for i = 0:nx 
%         ino = ino + 1 ;
%         Xn(ino,:) =  [ Xo + i*Lx/nx  Yo + j*Ly/ny ] ;
%     end
% end

% Initial Node Coordinates
Xn = zeros(nno,2) ; % 2 dof per node i.e. x coordinate and y coordinate.

Xn = coord ;

filename = 'Input/coordinate.txt' ;
fid = fopen(filename,'w') ;
for ino = 1:nno
    if ino < nno
        fprintf(fid,'%20.15f \t %20.15f \n',Xn(ino,:));   
    else
        fprintf(fid,'%20.15f \t %20.15f',Xn(ino,:));   
    end
end
fclose(fid);


% Current node coordinates initialized as initial coordinates to start
% with.
xn = Xn ; % Xn contains the coordinates of the reference configuration all the time
          % xn contains the coordinates of the current configuration all
          % the time
