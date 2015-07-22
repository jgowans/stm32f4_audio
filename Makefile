DEVICE_INCLUDES = -I ./CMSIS/Device/ST/STM32F4xx/Include/
HAL_INCLUDES = -I ./STM32F4xx_HAL_Driver/Inc
ARM_INCLUDES = -I ./CMSIS/Include/
BSP_INCLUDES = -I ./Drivers/BSP/STM32F4-Discovery
CSL_INCLUDES = -I ./Drivers/BSP/Components/cs43l22
INCLUDES = -I ./ $(DEVICE_INCLUDES) $(HAL_INCLUDES) $(ARM_INCLUDES) $(BSP_INCLUDES) $(CSL_INCLUDES)

CC=arm-none-eabi-gcc
CFLAGS= $(INCLUDES) -mcpu=cortex-m4 -mthumb -mhard-float -g -std=c99 -DSTM32F407xx

AS=arm-none-eabi-as 
ASFLAGS = -mcpu=cortex-m4 -mthumb -g

LD = arm-none-eabi-ld
LINKER_FILE = STM32F407VG_FLASH.ld
LDFLAGS = -T $(LINKER_FILE) -nostartfiles 

OBJS = \
       main.o \
       startup_stm32f407xx.o \
       system_stm32f4xx.o \
       stm32f4_discovery.o \
       stm32f4xx_hal_gpio.o \
       stm32f4xx_hal.o \
       stm32f4xx_hal_cortex.o \
       stm32f4xx_hal_spi.o \
       stm32f4xx_hal_dma.o \
       stm32f4xx_hal_i2c.o \
       stm32f4xx_hal_i2s.o \
       stm32f4xx_hal_i2s_ex.o \
       stm32f4xx_hal_rcc.o \
       stm32f4xx_hal_rcc_ex.o \
       stm32f4_discovery_audio.o \
       cs43l22.o \
       libPDMFilter_CM4F_GCC.a \

main.elf: $(OBJS)
	$(CC) $(CFLAGS) $(LDFLAGS) -o main.elf $(OBJS)

main.o: main.c klaxon.h

startup_stm32f407xx.o: startup_stm32f407xx.s

system_stm32f4xx.o: system_stm32f4xx.c

stm32f4_discovery.o: stm32f4_discovery.c

stm32f4xx_hal_gpio.o: stm32f4xx_hal_gpio.c

stm32f4xx_hal.o: stm32f4xx_hal.c

stm32f4xx_hal_cortex.o: stm32f4xx_hal_cortex.c

stm32f4xx_hal_spi.o: stm32f4xx_hal_spi.c

stm32f4xx_hal_dma.o: stm32f4xx_hal_dma.c

stm32f4xx_hal_i2c.o: stm32f4xx_hal_i2c.c

stm32f4xx_hal_rcc.o: stm32f4xx_hal_rcc.c
       
stm32f4xx_hal_rcc_ex.o: stm32f4xx_hal_rcc_ex.c
       
stm32f4xx_hal_i2s.o: stm32f4xx_hal_i2s.c

stm32f4_discovery_audio.o: stm32f4_discovery_audio.c

stm32f4xx_hal_i2s.o: stm32f4xx_hal_i2s.c

cs43l22.o: cs43l22.c

clean:
	rm -f *.elf *.bin *.o
