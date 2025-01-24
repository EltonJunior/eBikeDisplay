#include "gpio.h"

Gpio::Gpio(int pin, int type, void (*isrInput)(void), QObject *parent) : QObject(parent)
{
#if WIRINGPI_ACTIVE
    setenv("WIRINGPI_GPIOMEM", "1", 1);
    wiringPiSetup();
    m_pin = pin;
    m_toggleStatus = 0;

    switch(type)
    {
        case GPIO_INPUT:
        {
            pinMode(m_pin, INPUT);
            wiringPiISR(m_pin, INT_EDGE_BOTH, isrInput);
        } break;

        case GPIO_OUTPUT:
        {
            pinMode(m_pin, OUTPUT);

        } break;

    }
    digitalWrite(m_pin,LOW);
#endif
}
void Gpio::isrCallback()
{
#if WIRINGPI_ACTIVE
    emit inputChanged(digitalRead(m_pin));
#endif
}

void Gpio::pinHigh()
{
#if WIRINGPI_ACTIVE
    digitalWrite(m_pin,HIGH);
#endif
}

void Gpio::pinLow()
{
#if WIRINGPI_ACTIVE
    digitalWrite(m_pin,LOW);
#endif
}

void Gpio::pinToggle()
{
#if WIRINGPI_ACTIVE
    m_toggleStatus ^= 1;
    digitalWrite(m_pin, m_toggleStatus);
#endif
}
