% SPM12

% The transformation is nonlinear, so the affine transform by itself is unlikely to be very accurate.  You'll need to get the segmentation to write out the deformation field as a y_*.nii file.  The following may give you some pointers.....

% Best regards,

% -John

% https://www.jiscmail.ac.uk/cgi-bin/webadmin?A2=spm;8005badf.1606
%%


clear all

clc

%%% native space T1
t1info = spm_vol('anat_t1.nii');
[Int1,xyzt1]=spm_read_vols(t1info);
%nativemask = zeros(length(xyzt1));

tmp = round(xyzt1,1);
hit  = false(length(tmp),1);



%%% MNI space binary mask from post op t2
maskinfo = spm_vol('Mask.nii'); % patients binary mask
[In,xyz]=spm_read_vols(maskinfo);
vals = In(:);
ind = find(vals==1);


all_xyz_mni=xyz(:,ind); %all mni co-ordinates z


Py      = 'y_anat_t1.nii'; % transformation matrix from normalised post op t2 scan where mask was derived from

Pnative = 'anat_t1.nii'; % native space t2 image of post op thalamotomy scan

%%

% mm coordinate in MNI space

Nii = nifti(Py);

iM  = inv(Nii.mat);

for n = 1:length(all_xyz_mni);

xyz_mni = all_xyz_mni(:,n)'; % mni co-ordinate in mm of mask 



% voxel coordinate in MNI space of y_*.nii



ijk = iM(1:3,:)*[xyz_mni 1]';



% mm coordinate in native images

native_x = spm_bsplins(Nii.dat(:,:,:,1,1),ijk(1),ijk(2),ijk(3),[1 1 1 0 0 0]);

native_y = spm_bsplins(Nii.dat(:,:,:,1,2),ijk(1),ijk(2),ijk(3),[1 1 1 0 0 0]);

native_z = spm_bsplins(Nii.dat(:,:,:,1,3),ijk(1),ijk(2),ijk(3),[1 1 1 0 0 0]);





% voxel coordinate in native image Pnative

Nii_image  = nifti(Pnative);

iM2        = inv(Nii_image.mat);

ijk_native = iM2(1:3,:)*[native_x native_y native_z 1]';



natmm = [native_x native_y native_z]'; %% native space co-ordinate of mask

realxyz(:,n)= natmm;

end

scans{1}='anat_t1.nii';
[Xt1,imaget1]=ea_genX(scans);

% now find closest match between native and mni co-ordinate
tol = 1;

for m = 1:length(realxyz);
diff = abs(tmp-realxyz(:,m)); % each  Gx,Gy,Gx - MDxm,MDym,MDzm
matching = all(diff < tol, 1); % if a row matches (using if diff<tolerance rather than if diff==0)
hit = hit | matching'; 

pos = find(matching==1);
Xt1(pos) = 1000;



% nice bool masking trick (if new index is true then true)
if rem(m, 100) == 0 %status bar
disp(m)
end
end


fn = cd;
maskresample =[fn '/maskresample.nii'];


%t1resample ='/home/will/Desktop/freesurfer_seg/testspm/resample.nii';
ea_exportmap(imaget1,hit,'test.nii',[],maskresample)

t1resample =[fn '/anat_post.nii'];


%t1resample ='/home/will/Desktop/freesurfer_seg/testspm/resample.nii';
ea_exportmap(imaget1,Xt1,'test.nii',[],t1resample)

% now fuse images of post op t2 with mask for co-registration
