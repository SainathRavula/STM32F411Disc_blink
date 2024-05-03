#include <libopencm3/stm32/rcc.h>
#include <libopencm3/stm32/gpio.h>
void delay(void);
int main(void) {
        rcc_periph_clock_enable(RCC_GPIOD);
        gpio_mode_setup(GPIOD, GPIO_MODE_OUTPUT, GPIO_PUPD_NONE,GPIO12 | GPIO13 | GPIO14 | GPIO15);
	

	while(1) 
	{
		gpio_clear(GPIOD,GPIO12 | GPIO13 | GPIO14 | GPIO15);
		delay();
		
		gpio_set(GPIOD,GPIO12);
		delay();
		
		
		gpio_set(GPIOD,GPIO13);
		delay();
		
		
		gpio_set(GPIOD,GPIO14);
		delay();
		
		
		gpio_set(GPIOD,GPIO15);
		delay();

	}
}

void delay(void) 
{
for (int i = 0; i < LITTLE_BIT; i++) 
		{
			__asm__("nop");
		}
}





















/*

#include <libopencm3/stm32/rcc.h>
#include <libopencm3/stm32/gpio.h>

int main(void) {
        rcc_periph_clock_enable(RCC_LED1);
#if defined(STM32F1) //F1 is a precious snowflake
	gpio_set_mode(PORT_LED1, GPIO_MODE_OUTPUT_2_MHZ, GPIO_CNF_OUTPUT_PUSHPULL, PIN_LED1);
#else // everyone else is sane
        gpio_mode_setup(PORT_LED1, GPIO_MODE_OUTPUT, GPIO_PUPD_NONE, PIN_LED1);
#endif
	gpio_set(PORT_LED1, PIN_LED1);
#if defined(RCC_LED2)
        rcc_periph_clock_enable(RCC_LED2);
        gpio_mode_setup(PORT_LED2, GPIO_MODE_OUTPUT, GPIO_PUPD_NONE, PIN_LED2);
#endif
	while(1) {
		//wait a little bit
		for (int i = 0; i < LITTLE_BIT; i++) {
			__asm__("nop");
		}
		gpio_toggle(PORT_LED1, PIN_LED1);
#if defined(RCC_LED2)
		gpio_toggle(PORT_LED2, PIN_LED2);
#endif
	}
}

*/
