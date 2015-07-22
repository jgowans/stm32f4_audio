//#include "stm32f4_discovery_audio.h"
#include <stdint.h>
#include "stm32f4xx_hal.h"
#include "stm32f4_discovery.h"
#include "stm32f4_discovery_audio.h"
#include "klaxon.h"

extern I2S_HandleTypeDef hAudioOutI2s;

int main(void) {
    uint32_t sample_cnt;
    HAL_StatusTypeDef ret;
    HAL_Init();
    if (0 != BSP_AUDIO_OUT_Init(OUTPUT_DEVICE_HEADPHONE, 100, 44100)) {
        for(;;);
    }
    cs43l22_Play(AUDIO_I2C_ADDRESS, NULL, 0);
    __HAL_I2S_ENABLE(&hAudioOutI2s);
    for(sample_cnt = 0; sample_cnt < sizeof(klaxon_array)/(sizeof(klaxon_array[0])) ; ++sample_cnt) {
        if (I2S_WaitFlagStateUntilTimeout(&hAudioOutI2s, I2S_FLAG_TXE, RESET, 100) != HAL_OK) {
            for(;;);
        }
        (hAudioOutI2s.Instance)->DR = klaxon_array[sample_cnt];
        if (I2S_WaitFlagStateUntilTimeout(&hAudioOutI2s, I2S_FLAG_TXE, RESET, 100) != HAL_OK) {
            for(;;);
        }
        (hAudioOutI2s.Instance)->DR = klaxon_array[sample_cnt];
    }
    cs43l22_Stop(AUDIO_I2C_ADDRESS, 0);
    for(;;);
    return 0;
}

void SysTick_Handler(void) {
    HAL_IncTick();
}
