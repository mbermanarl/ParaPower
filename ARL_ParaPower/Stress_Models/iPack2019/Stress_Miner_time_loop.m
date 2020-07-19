% call Miner 3D to construct 4D and VM
function [stressx,stressy,stressz,stressvm] = Stress_Miner_time_loop (Results)

time = Results.Model.GlobalTime;
dx = Results.Model.X;
dy = Results.Model.Y;
dz = Results.Model.Z;

n_dx = length(dx);
n_dy = length(dy);
n_dz = length(dz);
n_time = length(time);

% Miner's matrix order: 1st=y, 2nd=x, 3rd=z
stressx = zeros(n_dy,n_dx,n_dz,n_time);
stressy = zeros(n_dy,n_dx,n_dz,n_time);
stressz = zeros(n_dy,n_dx,n_dz,n_time);
stressvm = zeros(n_dy,n_dx,n_dz,n_time);

% XYZ
for timestep = 1:n_time
    [stressx3D, stressy3D, stressz3D] = Stress_Miner_time(Results,timestep);
    
    stressx(:,:,:,timestep) = stressx3D;
    stressy(:,:,:,timestep) = stressy3D;
    stressz(:,:,:,timestep) = stressz3D;
    
end

% VM
stressvm = (((stressx-stressz).^2 + (stressx-stressy).^2 + (stressy-stressz).^2)/2).^.5;

end
