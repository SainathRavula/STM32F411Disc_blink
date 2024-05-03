PREFIX?=arm-none-eabi-
CC=$(PREFIX)gcc
OBJCOPY=$(PREFIX)objcopy
OD=bin

all: everything

SFLAGS	 	= --static
SFLAGS		+= -nostartfiles
SFLAGS		+= -std=c11
SFLAGS		+= -g3
SFLAGS		+= -Os
SFLAGS		+= -fno-common
SFLAGS		+= -ffunction-sections
SFLAGS		+= -fdata-sections
SFLAGS		+= -I./libopencm3/include
SFLAGS		+= -L./libopencm3/lib

LFLAGS	 	= -Wl,--start-group
LFLAGS		+= -lc
LFLAGS		+= -lgcc
LFLAGS		+= -lnosys
LFLAGS		+= -Wl,--end-group

M4FH_FLAGS	 = $(SFLAGS)
M4FH_FLAGS	+= -mcpu=cortex-m4
M4FH_FLAGS	+= -mthumb
M4FH_FLAGS	+= -mfloat-abi=hard
M4FH_FLAGS	+= -mfpu=fpv4-sp-d16


include boards.stm32.mk

everything: outdir $(BOARDS_ELF) $(BOARDS_BIN) $(BOARDS_HEX)
	echo "\n====================Build Complete===================="

libopencm3/Makefile:
	@echo "Initializing libopencm3 submodule"
	git submodule update --init

libopencm3/lib/libopencm3_%.a: libopencm3/Makefile
	$(MAKE) -C libopencm3

%.bin: %.elf
	@#printf "  OBJCOPY $(*).bin\n"
	$(OBJCOPY) -Obinary $(*).elf $(*).bin

%.hex: %.elf
	@#printf "  OBJCOPY $(*).hex\n"
	$(OBJCOPY) -Oihex $(*).elf $(*).hex

outdir:
	mkdir -p $(OD)/stm32
	
clean:
	$(RM) -r $(OD)/stm32
	#$(RM) $(BOARDS_ELF) $(BOARDS_BIN) $(BOARDS_HEX)
	echo $(RM) "$(OD)/stm32"
	echo "\n====================Clean Complete===================="

.PHONY: everything outdir clean all
$(V).SILENT:
