% A usage-illustration script
%
% This code is provided under MIT License.
% When used, please, cite the corresponding paper.
%
% Reference:
%           Alaa E. Abdel-Hakim. "Ally patches for spoliation of adversarial patches." Journal of Big Data 6, no. 1 (2019): 51.
%
%             @Article{Abdel-Hakim2019,
%             author="Abdel-Hakim, Alaa E.",
%             title="Ally patches for spoliation of adversarial patches",
%             journal="Journal of Big Data",
%             year="2019",
%             month="Jun",
%             day="07",
%             volume="6",
%             number="1",
%             pages="51",
%             issn="2196-1115",
%             doi="10.1186/s40537-019-0213-4",
%             url="https://doi.org/10.1186/s40537-019-0213-4"
%             }

% p contains a data structure of the returned patches. It is a simple 2D
% matrix whose dimensions Nx3. N is the number of the returned patches. The
% first two columns are the coordinates of the upper left corner of the
% returned patches and the third column contins the patch's entropy value.
%


im = imread("Hockey.jpg");

patch_Size = 60; % The patch size (square patches)
Stride = 7;
entropy_threshold = 0.75;
overlap_threshold = 0.1;

p = maxEntropyPatches( im, patch_Size, Stride, entropy_threshold, overlap_threshold);

