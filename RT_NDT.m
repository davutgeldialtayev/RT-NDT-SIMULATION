clc;
clear;
% Radiographic Testing Simulation for Material Thickness and Flaw Detection

% Define material parameters
material_thickness = 5:1:20; % Material thickness range (5 mm to 20 mm)
depth = 1:1:20; % Depth range (1 mm to 20 mm)
attenuation_coefficient = 0.2; % X-ray attenuation coefficient (cm⁻¹ for steel)

% Simulate X-ray intensity for different cases
% No defect
no_defect_intensity = exp(-attenuation_coefficient * material_thickness');
% Crack defect (assumed crack at depth 5 mm)
crack_intensity = exp(-attenuation_coefficient * (material_thickness' - 5));
crack_intensity(material_thickness' < 5) = 1; % No effect for thickness < 5 mm
% Void defect (assumed void at depth 5 mm)
void_intensity = exp(-attenuation_coefficient * (material_thickness' - 5) * 2); % Void effect is stronger

%% 1. X-ray Intensity Heatmaps for Different Flaws (Individual Heatmaps)

% Create separate heatmaps for No Defect, Crack Defect, and Void Defect

% No Defect Intensity Heatmap
figure;
subplot(3,1,1);
imagesc(material_thickness, depth, no_defect_intensity); 
colormap('jet');
colorbar;
xlabel('Material Thickness (mm)');
ylabel('Depth (mm)');
title('X-ray Intensity - No Defect');
axis tight;
set(gca, 'YDir', 'normal'); % Reverse Y-axis to show depth from top to bottom

% Crack Defect Intensity Heatmap
subplot(3,1,2);
imagesc(material_thickness, depth, crack_intensity); 
colormap('jet');
colorbar;
xlabel('Material Thickness (mm)');
ylabel('Depth (mm)');
title('X-ray Intensity - Crack Defect');
axis tight;
set(gca, 'YDir', 'normal');

% Void Defect Intensity Heatmap
subplot(3,1,3);
imagesc(material_thickness, depth, void_intensity); 
colormap('jet');
colorbar;
xlabel('Material Thickness (mm)');
ylabel('Depth (mm)');
title('X-ray Intensity - Void Defect');
axis tight;
set(gca, 'YDir', 'normal');

%% 2. Intensity Profiles at Different Depths (Line Plot)
depths_to_plot = [5, 10, 15]; % Depths to plot X-ray intensity
% Calculate intensity profiles at specific depths
intensity_at_depths_no_defect = exp(-attenuation_coefficient * (material_thickness - depths_to_plot(1)));
intensity_at_depths_crack = exp(-attenuation_coefficient * (material_thickness - depths_to_plot(1)) * 1.5); % Crack effect
intensity_at_depths_void = exp(-attenuation_coefficient * (material_thickness - depths_to_plot(1)) * 2); % Void effect

% Plot intensity profiles at different depths
figure;
hold on;
plot(material_thickness, intensity_at_depths_no_defect, 'g-', 'LineWidth', 2);
plot(material_thickness, intensity_at_depths_crack, 'r-', 'LineWidth', 2);
plot(material_thickness, intensity_at_depths_void, 'b-', 'LineWidth', 2);
hold off;
title('X-ray Intensity Profile at Specific Depths');
xlabel('Material Thickness (mm)');
ylabel('X-ray Intensity (arbitrary units)');
legend('No Defect', 'With Crack', 'With Void');
grid on;

%% 3. Surface Plot of X-ray Intensity Across Material Dimensions (3D Surface)
material_length = 20; % mm
material_width = 20; % mm
[Thickness, Depth] = meshgrid(material_thickness, depth);

% Simulate X-ray attenuation for the 3D model (Crack defect as an example)
intensity = exp(-attenuation_coefficient * (Thickness - Depth * 0.1)); % Simple attenuation model

% 3D Surface plot
figure;
surf(Thickness, Depth, intensity);
xlabel('Material Thickness (mm)');
ylabel('Depth (mm)');
zlabel('X-ray Intensity (arbitrary units)');
title('X-ray Intensity Distribution Across Material Dimensions');
colorbar;
shading interp;

