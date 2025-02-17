clear all

clc

maskinfo=spm_vol('anat_post.nii'); % Mask after coregister
[In,xyz]=spm_read_vols(maskinfo);
vals = In(:); % column vector
ind = find(vals>=500); %After coregister not 1000

new_In=zeros(size(In));
new_In(ind)=1;

maskinfo.fname = 'Mask.nii';

spm_write_vol(maskinfo, new_In);

% mdm
Mdminfo=spm_vol('Left-Mdm-additional-t2.nii'); 
[In_mdm,xyz_mdm]=spm_read_vols(Mdminfo);

Mdm=zeros(size(In_mdm));

% find the similar combination
for i=1:size(ind,1)
    if new_In(ind(i))==In_mdm(ind(i))
      Mdm(ind(i))=1;
    end
end

Mdminfo.fname = 'Mdm.nii';

spm_write_vol(Mdminfo, Mdm);


% mdl
Mdlinfo=spm_vol('Left-Mdl-additional-t2.nii'); 
[In_mdl,xyz_mdl]=spm_read_vols(Mdlinfo);

Mdl=zeros(size(In_mdl));

% find the similar combination
for i=1:size(ind,1)
    if new_In(ind(i))==In_mdl(ind(i))
      Mdl(ind(i))=1;
    end
end

Mdlinfo.fname = 'Mdl.nii';

spm_write_vol(Mdlinfo, Mdl);