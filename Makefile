# This makefile to build firmware from command line in Windows and Linux
# Before running make, ensure that path to GNU ARM Embedded toolchain (arm-none-eabi-gcc)
# is added to the system path, e.g. like this:
#     set PATH=d:\EmBitz\share\em_armgcc\bin\;%PATH%
# or in Linux:
#     export PATH=$PATH:/opt/gcc-arm-none-eabi-7-2017-q4-major/bin
#
# GNU ARM Embedded toolchain for Linux is available here:
# https://launchpad.net/~team-gcc-arm-embedded/+archive/ubuntu/ppa

ifeq ($(OS),Windows_NT)
    DETECTED_OS := Windows
else
    DETECTED_OS := $(shell uname -s)
endif

ifeq ($(DETECTED_OS),Windows)
   mkdir = mkdir $(subst /,\,$(1)) > nul 2>&1 || (exit 0)
   rm = $(wordlist 2,65535,$(foreach FILE,$(subst /,\,$(1)),& del $(FILE) > nul 2>&1)) || (exit 0)
   rmdir = del /F /S /Q $(subst /,\,$(1)) > nul 2>&1 || (exit 0)
   gen_timestamp = gen_timestamp.bat
else
   mkdir = mkdir -p $(1)
   rm = rm $(1) > /dev/null 2>&1 || true
   rmdir = rm -rf $(1) > /dev/null 2>&1 || true
   gen_timestamp = ./gen_timestamp.sh
endif

CC      = arm-none-eabi-gcc
OBJCOPY = arm-none-eabi-objcopy
SIZE    = arm-none-eabi-size

CFLAGS  = -mcpu=cortex-m7 -mthumb -mfloat-abi=hard -fgcse -fexpensive-optimizations -fomit-frame-pointer \
          -fdata-sections -ffunction-sections -Os -g -mfpu=fpv5-sp-d16 -MMD -Wall

ASFLAGS = -mcpu=cortex-m7 -mthumb -Wa,--gdwarf-2

LDFLAGS = -mcpu=cortex-m7 -mthumb -mfloat-abi=hard -fgcse -fexpensive-optimizations -fomit-frame-pointer \
          -fdata-sections -ffunction-sections -Os -g -mthumb -mfpu=fpv5-sp-d16 -Wl,-Map=bin/Release/F7Discovery.map \
          -u _printf_float -specs=nano.specs -Wl,--gc-sections -TSrc/Sys/STM32F746NGHx_FLASH.ld -lm


.PHONY: all

all: 
  echo make all

clean:
	echo make clean
  

