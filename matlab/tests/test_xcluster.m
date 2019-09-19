% LICENSE
% 
% _This file is Copyright 2018 by the Image Processing and Analysis Group (BioImage Suite Team). Dept. of Radiology & Biomedical Imaging, Yale School of Medicine._
% 
% BioImage Suite Web is licensed under the Apache License, Version 2.0 (the "License");
% 
% - you may not use this software except in compliance with the License.
% - You may obtain a copy of the License at [http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)
% 
% __Unless required by applicable law or agreed to in writing, software
% distributed under the License is distributed on an "AS IS" BASIS,
% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
% See the License for the specific language governing permissions and
% limitations under the License.__
% 
% ENDLICENSE

function result = test_xcluster(debug)

    if nargin<1
        debug=1;
    end

    [testutil,filepath,lib]=bis_testutils();
    testutil.printheader('Test Indiv');
    fname1= testutil.getTestFilename([ 'indiv' filesep 'prep.nii.gz' ]);
    fname2= testutil.getTestFilename([ 'indiv' filesep 'group.nii.gz' ]);

    % Load Images
    disp('-----')
    parc = bis_image(fname2,debug+1);
    disp('-----')
    fmri =  bis_image(fname1,debug+1);
    disp('-----')

    disp('-------------------------------------------------')

    imgdata=uint16(parc.getImageData()>0);
    newmask=bis_image();
    newmask.create(imgdata,parc.getSpacing(),parc.getAffine())
    newmask.print('newmask');

    param.useradius='true';
    param.radius=8.0;
    param.numthreads=2;
    disp('-------------------------------------------------')
    distmatrix=bis_imagedistancematrix(fmri,newmask,param,1);
    disp([' Sparse Matrix Computed',mat2str(size(distmatrix))]);

    disp('-------------------------------------------------')

    indexmap=lib.computeImageIndexMapWASM(newmask,0);
    indexmap.print('Indexmap');

    parcellation=bis_distmatrixparcellation(distmatrix,indexmap,20,1.0);
    parcellation.print('Parcellation');
    result=parcellation;

end
