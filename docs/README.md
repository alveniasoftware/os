# AlveniaOS

## Prerequisites

To build AlveniaOS, you need to have a Linux system (or something that supports the following packages and shell files) with the following packages installed:
- `xorriso`
- `grub`
- `nasm` (or another Assembler)
- `gcc` and `g++` (or another C++ compiler)
- `binutils`
- `sh`

If you want to use another Assembler than NASM, go to `scripts/run.sh` and change the `ASMC` variable to your Assembler. And if your assembler needs other flags, change the `ASMC_FLAGS` variable to your flags.

If you want to use another C compiler than GCC, go to `scripts/run.sh` and change the `CC` variable to your C++ compiler. And if your C++ compiler needs other flags, change the `CC_FLAGS` variable to your flags.

Last thing, if you want to change the os name, go to `scripts/run.sh` and change the `OS_NAME` variable to your os name. Then go to conf/grub.cfg and change the `menuentry` and file name to your os name.

## Building

Before you start building, you will need to run setup first, `scripts/setup.sh`. This will create the needed directories and files for the build process.

To build AlveniaOS, you need to run `scripts/run.sh`. This will build the kernel and the bootloader. After that, it will create an ISO file at the root directory. Run `scripts/run.sh build` to build the kernel and bootloader.

## Cleaning

To clean the build, run `scripts/run.sh clean`. This will clean the files created by the build process.

## Tested on

I've tested this on WSL-2 for Windows. Using Debian 12. 