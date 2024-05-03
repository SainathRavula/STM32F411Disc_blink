# Instructions: 
# 1) add a rule for your board to the bottom of this file
# 2) profit!

LFLAGS_STM32=$(LFLAGS) main.c -T ld.stm32.basic


# STM32F4 starts up with HSI at 16MHz
STM32F4_CFLAGS=$(M4FH_FLAGS) -DSTM32F4 -DLITTLE_BIT=800000 $(LFLAGS_STM32) -lopencm3_stm32f4


define RAWMakeBoard
	$(CC) -DRCC_LED1=RCC_$(1) -DPORT_LED1=$(1) -DPIN_LED1=$(2) \
		$(if $(5),-DRCC_LED2=RCC_$(5) -DPORT_LED2=$(5) -DPIN_LED2=$(6),) \
		$(3) -o $(OD)/stm32/$(4)
endef

define MakeBoard
BOARDS_ELF+=$(OD)/stm32/$(1).elf
BOARDS_BIN+=$(OD)/stm32/$(1).bin
BOARDS_HEX+=$(OD)/stm32/$(1).hex
$(OD)/stm32/$(1).elf: main.c libopencm3/lib/libopencm3_$(5).a
	@echo "  $(5) -> Creating $(OD)/stm32"
	@echo "  $(5) -> Creating $(OD)/stm32/$(1).bin"
	@echo "  $(5) -> Creating $(OD)/stm32/$(1).hex"
	@echo "  $(5) -> Creating $(OD)/stm32/$(1).elf"
	$(call RAWMakeBoard,$(2),$(3),$(4),$(1).elf,$(6),$(7))
	#echo "1->$(1) || 2->$(2) || 3->$(3) ||  5->$(5) || 6->$(6) || 7->$(7)"

endef

define stm32f4board
	$(call MakeBoard,$(1),$(2),$(3),$(STM32F4_CFLAGS),stm32f4,$(4),$(5))
endef
	
# STM32F4-Discovery board
$(eval $(call stm32f4board,stm32f4discover,GPIOD,GPIO12))
#$(eval $(call stm32f4board,stm32f4discover,GPIOD,GPIO13))


