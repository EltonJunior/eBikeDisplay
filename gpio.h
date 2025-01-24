#ifndef GPIO_H
#define GPIO_H

#include <QObject>

#if WIRINGPI_ACTIVE
#include "wiringPi.h"
#endif

#define GPIO_INPUT   0
#define GPIO_OUTPUT  1

class Gpio : public QObject
{
    Q_OBJECT
public:
    explicit Gpio(int pin, int type, void (*isrInput)(void) = nullptr, QObject *parent = nullptr);
    void isrCallback();

private:
    int m_toggleStatus;
    int m_pin;

signals:
    void inputChanged(int value);

public slots:
    void pinHigh();
    void pinLow();
    void pinToggle();
};

#endif // GPIO_H
