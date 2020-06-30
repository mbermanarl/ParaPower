function a = stress_Random(Results)
% Purpose: learn how to take input from GUI and process it into an output
% that can be read by the GUI
% generate 4D matrix from GUI input (PPResults obj) that GUI can read
% 06-29-20
% Trinity Cheng
% input: PPResults object
% output: 4D matrix of: material # + (n1*n2) for each xyz point and
% corresponding time
% 
% n1 and n2 represent normalized x and y (on 0 to 1 vector) of each
% element's center
% [coordinate value of center of element]/[total length of vector]
% coordinate value of center = cumsum vector - 1/2 element size vector

% ONE: get input
% TWO: process input
% THREE: return 4D matrix
ModelInput=Results.Model;
material_number = Results.Model.Model;
time = Results.Model.GlobalTime;

% create normalized axes
x_normalized = normalize_Vector(Results.Model.X);
y_normalized = normalize_Vector(Results.Model.Y);
z_normalized = normalize_Vector(Results.Model.Z);

x_size = length(x_normalized);
y_size = length(y_normalized);
z_size = length(z_normalized);
t_size = length(time);

material_number = Results.Model.Model;
mat_loc_val = zeros(x_size,y_size,z_size,t_size);

for t=1:t_size
    for h=1:x_size;
        one_x_normalized = x_normalized(h);
        for i=1:y_size
            one_y_normalized = y_normalized(i);
            for j=1:z_size
                one_z_normalized = z_normalized(j);
                mat_loc_val(h,i,j,t) = material_number(h,i,j) + one_x_normalized*one_y_normalized*one_z_normalized;
            end
        end
    end
end

a = mat_loc_val;

return

function normalized = normalize_Vector(delta_vector)
vector_dimensions = cumsum(delta_vector);
vector_half = delta_vector/2;
vector_centers = vector_dimensions - vector_half;
normalized = vector_centers/vector_dimensions(end);
return