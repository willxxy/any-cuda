# any-cuda
A simple way to download and configure all your paths to a specific cuda version.

Ever had trouble downloading or configuring the correct cuda version you need?

This repository is mostly taken from the [bitsandbytes install_cuda.sh file](https://github.com/bitsandbytes-foundation/bitsandbytes/blob/main/install_cuda.sh) but I modified it slightly.
The modifications are the following:
- the order of exports of LD_LIBRARY_PATH and PATH (this seems to matter sometimes)
- configuring cuda home and cuda version in bash file

Simply run with the following line:

`./install_cuda.sh CUDA_VERSION BASE_PATH EXPORT_BASHRC`

where 

- CUDA_VERSION is cuda versions between 110 to 125 (this should work for most modern NVIDIA GPUS).
- BASE_PATH is your absolute path to the directory you want to download your cuda files to.
- EXPORT_BASHRC can be optionally set to 1 if you want to automatically configure your bash file and source it (I recommend this).

This should work for most cases (I have tried it many times and always works). If there are any exceptions please don't hesitate to submit an issue!
