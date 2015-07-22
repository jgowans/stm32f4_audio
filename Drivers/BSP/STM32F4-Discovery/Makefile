HAL_INC = -I ../../../STM32F4xx_HAL_Driver/Inc/

CC = arm-none-eabi-gcc
CFLAGS = $(HAL_INC) -mcpu=cortex-m4 -g -mthumb

OBJS = stm32f4_discovery.o

all: $(OBJS)

stm32f4_discovery.o: stm32f4_discovery.c
