# Ally-Patches

A maximum-entropy splitter
This code is intended to generate ally patches for a given input image as described in [1]. Please, cite the paper when you use this code.

A function to split an input image into a set of pathces according to thier entropy values such that the returned patches have entropy values>=entTH and the overlap between any two of them is <= ovrlpTh. The stride Strd determines the step of the sliding mask over the original image im. 

# Usage:

MATLAB Command:
  p = maxEntropyPatches( im, patch_Size, Stride, entropy_threshold, overlap_threshold)

Alaa E. Abdel-Hakim
# Reference:

[1] Alaa E. Abdel-Hakim. "Ally patches for spoliation of adversarial patches." Journal of Big Data 6, no. 1 (2019): 51.
