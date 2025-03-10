# any-cuda
Ever spent countless hours downloading and/or configuring the correct cuda version you need? I know I have. Well...this repository is for you!

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

Make sure to allow permissions for install_cuda.sh! You can do this by

`chmod +x install_cuda.sh`

This should work for most cases (I have tried it many times and always works). If there are any exceptions please don't hesitate to submit an issue!

# Known Issues

1. There has been some issues where the script does not fully work. In this case we recommend doing each command separately, i.e., wget the run file, bash run the downloaded file and exporting manually.
