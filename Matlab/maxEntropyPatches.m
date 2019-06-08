function patches = maxEntropyPatches( im, pSize, Strd, entTh, ovrlpTh)
%A maximum-entropy splitter
%   This code is intended to generate ally patches for a given input image as described in [1]. Please, cite the paper when you use this code.
%   A function to split an input image into a set of pathces according to
%   thier entropy values such that the returned patches have entropy
%   values>=entTH and the overlap between any two of them is <= ovrlpTh.
%   The stride Strd determines the step of the sliding mask over the
%   original image im.
%
% Alaa E. Abdel-Hakim
% October 2017
%
% Reference:
%       [1] Alaa E. Abdel-Hakim. "Ally patches for spoliation of adversarial patches." Journal of Big Data 6, no. 1 (2019): 51.

tic
h = size(im,1);
w = size(im,2);

imEnt = entropy(im);
pCount = 0;
pCor = zeros(ceil(h/Strd*w/Strd),2);     % Initially allocate a large space for pathces
pEnts = zeros(ceil(h/Strd*w/Strd),1); 
ovrlp = zeros(ceil(h/Strd*w/Strd),1);
        
for i = 1:Strd:h-pSize+1
    for j = 1:Strd:w-pSize+1
        p = im(i:i+pSize-1,j:j+pSize-1,:);  % Get a patch
        ent = entropy(p);
        if(ent/imEnt < entTh); continue; end    % Check a sufficient information content
        % Add the current patch
        pCount = pCount+1;
        pCor(pCount,:) = [i,j];
        pEnts(pCount) = ent; 
        rectangle('Position',[j,i,pSize,pSize],'EdgeColor','red');
        text(j,i,num2str(ent));
    end
end
%remove the extra places in the patches
pCor(pCount+1:size(pCor,1),:) = [];
pEnts(pCount+1:size(pEnts,1)) = [];

srtdPdata = sortrows([pEnts,pCor],'descend');

ovrlps = triu(rectint([srtdPdata(:,2:3),pSize*ones(size(srtdPdata,1),2)],[srtdPdata(:,2:3),pSize*ones(size(srtdPdata,1),2)]),1);
[tt,tmpidx] = find(ovrlps >= ovrlpTh*pSize*pSize);
tmpidx = [tt,tmpidx];
tmpidx = sortrows(tmpidx,1);

final_idx = [1:pCount]';
finalCount = pCount;
while ~isempty(tmpidx)
    final_idx(final_idx==tmpidx(1,2))=[];
    [row2remove,tmp] = find(tmpidx(:,1) == tmpidx(1,2));
    tmpidx(row2remove,:) = [];
    tmpidx(1,:) = [];
end


%Display for debug
close all
imshow(im);
hold on;
for i=1:length(final_idx)
    rectangle('Position',[srtdPdata(final_idx(i),3),srtdPdata(final_idx(i),2),pSize,pSize],'EdgeColor','green','LineWidth', 4);
end

patches = [srtdPdata(final_idx,3),srtdPdata(final_idx,2),srtdPdata(final_idx,1)];
toc
end

