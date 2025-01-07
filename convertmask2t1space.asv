function convertmask2t1space(mask,t1,t1resample)

%mask ='/home/shenshen/software/freesurfer-linux-ubuntu22_amd64-7.4.1/freesurfer/subjects/aa/mri/left-Mdm.nii.gz';

%t1 ='/home/shenshen/software/freesurfer-linux-ubuntu22_amd64-7.4.1/freesurfer/subjects/aa/mri/001.nii.gz';
scans{1}=mask;


maskinfo = spm_vol(mask);
[In,xyz]=spm_read_vols(maskinfo);

t1info = spm_vol(t1);
[Int1,xyzt1]=spm_read_vols(t1info);

[Xm,imagem]=ea_genX(scans);

scans{1}=t1;
[Xt1,imaget1]=ea_genX(scans);


% find the mask 1's = zeros(

real = find(Xm==1);

realxyz = round(xyz(:,real),1);
tmp = round(xyzt1,1);
tol= 1;
%% takes too long
%hit = zeros(length(tmp),1);
hit  = false(length(tmp),1);
%%
for m = 1:length(realxyz);
diff = abs(tmp-realxyz(:,m)); % each  Gx,Gy,Gx - MDxm,MDym,MDzm
matching = all(diff < tol, 1); % if a row matches (using if diff<tolerance rather than if diff==0)
hit = hit | matching'; % nice bool masking trick (if new index is true then true)
if rem(m, 100) == 0 %status bar
disp(m)
end
end
%%

%for m = 1:length(realxyz);

%for n = 1:length(tmp); 

 %   diff(:,n) = realxyz(:,m)-tmp(:,n);
  %  s(n) = sum(diff(:,n)==0);
    
   
%end

 %f = find(s==3);

%if ~isempty(f);
 %   hit(f) = 1;
%end

%end
%%
%t1resample ='/home/will/hipsthomasdocker/testdata/cs/resample.nii';
ea_exportmap(imaget1,hit,'test.nii.gz',[],t1resample)
%%
