%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
%                 INDIAN INSTITUTE OF TECHNOLOGY GUWAHATI                 %
%                  DEPARTMENT OF MECHANICAL ENGINEERING                   %
%                                                                         %
%                          2022-23 2ND SEMESTER                           %
%                                                                         %
%               ME 682 - NONLINEAR FINITE ELEMENT METHODS                 %
%                                                                         %
%                                                                         %
% Code initially developed by: Sachin Singh Gautam                        %
%                                                                         %
%                                                                         %
% Project 1: Due date 31.03.2023, Friday, 5 PM                            %
%                                                                         %
% The code is written for solving a finding the displacement, strains and % 
% stresses for a rectangular plate with a circular hole subjected to      %
% uniformly distributed load.                                             %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [rel] = get_element_load_vector(  ...
    load_type,p,q,Lx,Ly,Tx,Ty,ndoel,xI,ngps,xigs,I2)


%
% Input
%
% con - connectivity for ith element
% nodel - number of dof per eleemnt
% oI - undefomred coordinate
% xI - deformed coordinate
% U - displacement 
% ngps - number of Gauss point required for surface integration
% xigs - this array contains the Gauss point 

%
% Output
% 
% rel - elemental external force vector 


    % Initialize 
rel = zeros(ndoel,1) ;

%for uniform load on both sides 
if load_type == 1
 
    if xI(2,1) == Lx
    
    % Gauss Point Loop (Volume Integrals)
        for gp = 1:ngps
            % Gauss point coordinates, weight
            xi = xigs(gp,1) ; eta = -1  ; wg = xigs(gp,2) ;
        
            % Shape Functions
            N1 = ( 1 - xi )*( 1 - eta )/4 ;
            N2 = ( 1 + xi )*( 1 - eta )/4 ;
            N3 = ( 1 + xi )*( 1 + eta )/4 ;
            N4 = ( 1 - xi )*( 1 + eta )/4 ;
            N  = [N1*I2 N2*I2 N3*I2 N4*I2] ;
            
            Tx=(Tx_1+Tx_2)/2;
            
            t_bar = [Tx;0];
        
            dx = xI(1,1) - xI(2,1) ; 
            dy = xI(1,2) - xI(2,2) ;
        
            length = sqrt(dx*dx+dy*dy);
        
            jacobian = length/2;
        
            rel = rel + N' * t_bar * jacobian * wg ;
        end % End of Gauss point loop

    elseif xI(2,2) == Ly
            % Gauss Point Loop (Volume Integrals)
        for gp = 1:ngps
        
            % Gauss point coordinates, weight
            xi = xigs(gp,1) ; eta = -1  ; wg = xigs(gp,2) ;
        
            % Shape Functions
            N1 = ( 1 - xi )*( 1 - eta )/4 ;
            N2 = ( 1 + xi )*( 1 - eta )/4 ;
            N3 = ( 1 + xi )*( 1 + eta )/4 ;
            N4 = ( 1 - xi )*( 1 + eta )/4 ;
            N  = [N1*I2 N2*I2 N3*I2 N4*I2] ;
            Ty=(Ty_1+Ty_2)/2;
            t_bar = [0;Ty];
        
            dx = xI(1,1) - xI(2,1) ; 
            dy = xI(1,2) - xI(2,2) ;
        
            length = sqrt(dx*dx+dy*dy);
        
            jacobian = length/2;
        
            rel = rel + N' * t_bar * jacobian * wg ;
        end % End of Gauss point loop
    
    end % End of if loop


%for linear varying load on x direction and dniform distribuyed load in y 
% direction
elseif load_type == 2

     if xI(2,1) == Lx

         % type of loading
     if p == 1
             
            y_1=xI(2,2);
            y_2=xI(3,2);
        
     elseif p == 2
            y_1_height = xI(2,2);
            y_1=(Ly- y_1_height);
            y_2_height = xI(3,2);
            y_2=(Ly- y_2_height);
     end

        
     
    % Gauss Point Loop (Volume Integrals)
        for gp = 1:ngps
    
            % Gauss point coordinates, weight
            xi = xigs(gp,1) ; eta = -1  ; wg = xigs(gp,2) ;
        
            % Shape Functions
            N1 = ( 1 - xi )*( 1 - eta )/4 ;
            N2 = ( 1 + xi )*( 1 - eta )/4 ;
            N3 = ( 1 + xi )*( 1 + eta )/4 ;
            N4 = ( 1 - xi )*( 1 + eta )/4 ;
            N  = [N1*I2 N2*I2 N3*I2 N4*I2] ;

            L_1=Tx_1+((Tx_2-Tx_1)*(y_1/Ly));
            L_2=Tx_1+((Tx_2-Tx_1)*(y_2/Ly));
            L=(L_2+L_1)/2;
            t_bar = [L;0];
        
            dx = xI(1,1) - xI(2,1) ; 
            dy = xI(1,2) - xI(2,2) ;
        
            length = sqrt(dx*dx+dy*dy);
        
            jacobian = length/2;
        
            rel = rel + N' * t_bar * jacobian * wg ;
        end % End of Gauss point loop

       elseif xI(2,2) == Ly
            % Gauss Point Loop (Volume Integrals)
        for gp = 1:ngps
        
            % Gauss point coordinates, weight
            xi = xigs(gp,1) ; eta = -1  ; wg = xigs(gp,2) ;
        
            % Shape Functions
            N1 = ( 1 - xi )*( 1 - eta )/4 ;
            N2 = ( 1 + xi )*( 1 - eta )/4 ;
            N3 = ( 1 + xi )*( 1 + eta )/4 ;
            N4 = ( 1 - xi )*( 1 + eta )/4 ;
            N  = [N1*I2 N2*I2 N3*I2 N4*I2] ;
            Ty=(Ty_1+Ty_2)/2;
            t_bar = [0;Ty];
        
            dx = xI(1,1) - xI(2,1) ; 
            dy = xI(1,2) - xI(2,2) ;
        
            length = sqrt(dx*dx+dy*dy);
        
            jacobian = length/2;
        
            rel = rel + N' * t_bar * jacobian * wg ;
        end % End of Gauss point loop
    
    end % End of if loop





%for unifom distributed load in x direction and linear varying load on y
%direction

elseif  load_type == 3
 
    if xI(2,2) == Ly

         % type of loading

     if q == 1
             
         x_1=xI(2,1);
         x_2=xI(3,1);
        
     elseif q == 2
            x_1_length = xI(2,1);
            x_1=(Lx- x_1_length);
            x_2_length = xI(3,1);
            x_2=(Lx- x_2_length);
     end


        

            % Gauss Point Loop (Volume Integrals)
        for gp = 1:ngps
        
            % Gauss point coordinates, weight
            xi = xigs(gp,1) ; eta = -1  ; wg = xigs(gp,2) ;
        
            % Shape Functions
            N1 = ( 1 - xi )*( 1 - eta )/4 ;
            N2 = ( 1 + xi )*( 1 - eta )/4 ;
            N3 = ( 1 + xi )*( 1 + eta )/4 ;
            N4 = ( 1 - xi )*( 1 + eta )/4 ;
            N  = [N1*I2 N2*I2 N3*I2 N4*I2] ;
          
            M_1=(Ty*x_1)/Lx;
            M_2=(Ty*x_2)/Lx;
            M=(M_1+M_2)/2;
            t_bar = [0;M];
        
            dx = xI(1,1) - xI(2,1) ; 
            dy = xI(1,2) - xI(2,2) ;
        
            length = sqrt(dx*dx+dy*dy);
        
            jacobian = length/2;
        
            rel = rel + N' * t_bar * jacobian * wg ;
        end % End of Gauss point loop

 elseif xI(2,1) == Lx
    
    % Gauss Point Loop (Volume Integrals)
        for gp = 1:ngps
    
            % Gauss point coordinates, weight
            xi = xigs(gp,1) ; eta = -1  ; wg = xigs(gp,2) ;
        
            % Shape Functions
            N1 = ( 1 - xi )*( 1 - eta )/4 ;
            N2 = ( 1 + xi )*( 1 - eta )/4 ;
            N3 = ( 1 + xi )*( 1 + eta )/4 ;
            N4 = ( 1 - xi )*( 1 + eta )/4 ;
            N  = [N1*I2 N2*I2 N3*I2 N4*I2] ;
        
            Tx=(Tx_1+Tx_2)/2;

            t_bar = [Tx;0];
        
            dx = xI(1,1) - xI(2,1) ; 
            dy = xI(1,2) - xI(2,2) ;
        
            length = sqrt(dx*dx+dy*dy);
        
            jacobian = length/2;
        
            rel = rel + N' * t_bar * jacobian * wg ;
        end % End of Gauss point loop
    
    end % End of if loop

end

end
