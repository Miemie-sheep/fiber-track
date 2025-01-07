clear
clc

%% Script for G Mac
fn = dir;
fn = fn(3:end);
%end_point = ',1';
 ext = cd;
for n = 1:length(fn);

 Pt{n} =  [ext '/' fn(n).name];
 end
%%

%Pt ={

%};

end_point = ',1';

spm fmri
for i = 1:length(Pt)
    file_loc = strcat(Pt{i},end_point);

    matlabbatch{1}.spm.spatial.normalise.estwrite.subj.vol = {file_loc};
    matlabbatch{1}.spm.spatial.normalise.estwrite.subj.resample = {file_loc};
    matlabbatch{1}.spm.spatial.normalise.estwrite.eoptions.biasreg = 0.0001;
    matlabbatch{1}.spm.spatial.normalise.estwrite.eoptions.biasfwhm = 60;
    matlabbatch{1}.spm.spatial.normalise.estwrite.eoptions.tpm = {'/home/shenshen/apps/spm12/tpm/TPM.nii'};
    matlabbatch{1}.spm.spatial.normalise.estwrite.eoptions.affreg = 'mni';
    matlabbatch{1}.spm.spatial.normalise.estwrite.eoptions.reg = [0 0.001 0.5 0.05 0.2];
    matlabbatch{1}.spm.spatial.normalise.estwrite.eoptions.fwhm = 0;
    matlabbatch{1}.spm.spatial.normalise.estwrite.eoptions.samp = 3;
    matlabbatch{1}.spm.spatial.normalise.estwrite.woptions.bb = [-78 -112 -70
        78 76 85];
    matlabbatch{1}.spm.spatial.normalise.estwrite.woptions.vox = [1 1 1];
    matlabbatch{1}.spm.spatial.normalise.estwrite.woptions.interp = 4;
    matlabbatch{1}.spm.spatial.normalise.estwrite.woptions.prefix = 'w';

    spm_jobman('run',matlabbatch);

end