%face connectivity

face_con=[  1 2
            2 3
            3 4
            4 1   ];   %for local quad element


load_nodes=zeros(nx+1,2);
Fud=-1;
ele_load_face=zeros(nx,2);

for i=1:nno
    if Xn(i,2)==Ly
        load_nodes(i,:)=[2*i Fud];

        for j=1:nel
            if CON(j,4)==i
                ele_load_face(j,:)=[i 3];
            end
        end
    end 
end

filename = 'Input/load_nodes_data.txt' ;
fid = fopen(filename,'w') ;
for ino = 1:nno
    if ino < nno
        fprintf(fid,'%g \t %g \n',load_nodes(ino,:));   
    else
        fprintf(fid,'%g \t %g',load_nodes(ino,:));   
    end
end
fclose(fid);

filename = 'Input/ele_load_data.txt' ;
fid = fopen(filename,'w') ;
for ino = 1:nno
    if ino < nno
        fprintf(fid,'%g \t %g \n',ele_load_face(ino,:));   
    else
        fprintf(fid,'%g \t %g',ele_load_face(ino,:));   
    end
end
fclose(fid);