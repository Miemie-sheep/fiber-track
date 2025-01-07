 function scan_flipper;

clear
clc
close all
%%
fn = dir;
fn = fn(3:end);
end_point = ',1';
ext = cd;
for n = 1:length(fn);
data{n} = [ext '/' fn(n).name];
end
%data = {
% '/home/will/Desktop/WG_Research/Thalamotomy/Cognitive/masks_inorder/segmentedmasks/MD-Pf/JC_MD-Pf.nii'
% '/home/will/Desktop/WG_Research/Thalamotomy/Cognitive/masks_inorder/segmentedmasks/MD-Pf/JM_MD-Pf.nii'
% '/home/will/Desktop/WG_Research/Thalamotomy/Cognitive/masks_inorder/segmentedmasks/MD-Pf/AB_MD-Pf.nii'
%};
% % Load the MRI scans
% scans = dir('/path/to/scans/*.nii'); % replace with your directory path and file extension

%%
for i = 1:length(data)
filename = data{i};
scan = load_nii(filename);
% Mirror the data along the sagittal plane
mirrored_data = flip(scan.img, 1);
% Update the header information to reflect the mirrored data
scan.hdr.hist.srow_x(1) = -scan.hdr.hist.srow_x(1);
scan.hdr.hist.quatern_b = -scan.hdr.hist.quatern_b;
scan.hdr.hist.quatern_c = -scan.hdr.hist.quatern_c;
% Save the mirrored data as a new .nii file
[~, name, ext] = fileparts(filename);
new_filename = fullfile('/home/shenshen/Desktop/Project/tractography/vc/mdl', [name '_mirrored' ext]); % replace with your output directory path
scan.img = mirrored_data;
save_nii(scan, new_filename);
end