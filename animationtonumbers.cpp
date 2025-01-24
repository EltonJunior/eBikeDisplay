#include "animationtonumbers.h"

AnimationToNumbers::AnimationToNumbers(QObject *parent) : QObject(parent),
    m_OdometerIncreaseVar("000000"),
    m_SpeedIncreaseVar("899"),
    m_OdoAnalogIncreaseVar("0"),
    m_BatteryIncreaseVar("100"),
    m_AlertLowBatteryVar("qrc:/images/right-arc-main.png")
{
    timer = new QTimer(this);
    connect(timer, SIGNAL(timeout()),this,SLOT(OdometerIncreaseAnimation()));
    timer->start(3600);

    timerToSpeed = new QTimer(this);
    connect(timerToSpeed, SIGNAL(timeout()),this,SLOT(SpeedIncreaseAnimation()));
    timerToSpeed->start(100);

    timerToBattery = new QTimer(this);
    connect(timerToBattery, SIGNAL(timeout()),this,SLOT(BatteryIncreaseAnimation()));
    timerToBattery->start(100);
}

QString AnimationToNumbers::OdometerIncreaseVar()
{
    return m_OdometerIncreaseVar;
}

QString AnimationToNumbers::SpeedIncreaseVar()
{
    return m_SpeedIncreaseVar;
}

QString AnimationToNumbers::OdoAnalogIncreaseVar()
{
    return m_OdoAnalogIncreaseVar;
}

QString AnimationToNumbers::BatteryIncreaseVar()
{
    return m_BatteryIncreaseVar;
}

QString AnimationToNumbers::AlertLowBatteryVar()
{
    return m_AlertLowBatteryVar;
}

QString AnimationToNumbers::AlertLowBaterryToDigitVar()
{
    return m_AlertLowBaterryToDigitVar;
}

void AnimationToNumbers::setOdometerIncreaseVar(QString newOdometerIncrease )
{
    if( m_OdometerIncreaseVar != newOdometerIncrease )
    {
        m_OdometerIncreaseVar = newOdometerIncrease;
        emit OdometerIncreaseVarChanged();
    }
}

void AnimationToNumbers::setSpeedIncreaseVar(QString newSpeedIncrease )
{
    if( m_SpeedIncreaseVar != newSpeedIncrease )
    {
        m_SpeedIncreaseVar = newSpeedIncrease;
        emit SpeedIncreaseVarChanged();
    }
}

void AnimationToNumbers::setOdoAnalogIncreaseVar(QString newOdoAnalogIncreaseVar )
{
    if( m_OdoAnalogIncreaseVar != newOdoAnalogIncreaseVar )
    {
        m_OdoAnalogIncreaseVar = newOdoAnalogIncreaseVar;
        emit OdoAnalogIncreaseVarChanged();
    }
}

void AnimationToNumbers::setBatteryIncreaseVar(QString newBatteryIncreaseVar )
{
    if( m_BatteryIncreaseVar != newBatteryIncreaseVar )
    {
        m_BatteryIncreaseVar = newBatteryIncreaseVar;
        emit BatteryIncreaseVarChanged();
    }
}

void AnimationToNumbers::setAlertLowBatteryVar(QString newAlertLowBatteryVar )
{
    if( m_AlertLowBatteryVar != newAlertLowBatteryVar )
    {
        m_AlertLowBatteryVar = newAlertLowBatteryVar;
        emit AlertLowBatteryVarChanged();
    }
}

void AnimationToNumbers::setAlertLowBaterryToDigitVar(QString newAlertLowBaterryToDigitVar )
{
    if( m_AlertLowBaterryToDigitVar != newAlertLowBaterryToDigitVar )
    {
        m_AlertLowBaterryToDigitVar = newAlertLowBaterryToDigitVar;
        emit AlertLowBaterryToDigitVarChanged();
    }
}

void AnimationToNumbers::OdometerIncreaseAnimation()
{
    setOdometerIncreaseVar( QString::number(counter) );

    if( counter++ >= 999999)
    {
        counter = 0;
    }
}

void AnimationToNumbers::SpeedIncreaseAnimation()
{
    setSpeedIncreaseVar( QString::number(valueToDigitalSpeed[counterToSpeed]) );
    setOdoAnalogIncreaseVar( QString::number(valueToAnalog[counterToSpeed]) );

    if( ClockWise == 0 )
    {
        if( counterToSpeed++ >= 90)
        {
            ClockWise = 1;
            counterToSpeed = 90;
        }
    }
    if (ClockWise == 1 )
    {
        if( counterToSpeed-- <= 0 )
        {
            ClockWise = 0;
            counterToSpeed = 0;
        }
    }

}

void AnimationToNumbers::BatteryIncreaseAnimation()
{
    setBatteryIncreaseVar( QString::number(90-batteryIncreaseCounter) );

    if( BatteryClockWise == 0 )
    {
        if( batteryIncreaseCounter++ >= 90)
        {
            BatteryClockWise = 1;
            batteryIncreaseCounter = 90;
        }
    }
    if (BatteryClockWise == 1 )
    {
        if( batteryIncreaseCounter-- <= 0 )
        {
            BatteryClockWise = 0;
            batteryIncreaseCounter = 0;
        }
    }

    if((90-batteryIncreaseCounter) >= 40)
    {
        setAlertLowBatteryVar( QString("qrc:/images/right-arc-main.png"));
        setAlertLowBaterryToDigitVar( QString("#52576b"));
    }
    else if((90-batteryIncreaseCounter) <= 39 && (90-batteryIncreaseCounter) >= 30)
    {
    setAlertLowBatteryVar( QString("qrc:/images/right-arc-main-30-percent.png"));
    setAlertLowBaterryToDigitVar( QString("#a77e7e"));
    }
    else if((90-batteryIncreaseCounter) <= 29 && (90-batteryIncreaseCounter) >= 20)
    {
        setAlertLowBatteryVar("qrc:/images/right-arc-main-60-percent.png");
        setAlertLowBaterryToDigitVar( QString("#ae3a3a"));
    }
    else if((90-batteryIncreaseCounter) <= 19 && (90-batteryIncreaseCounter) >= 10)
    {
        setAlertLowBatteryVar("qrc:/images/right-arc-main-100-percent.png");
        setAlertLowBaterryToDigitVar( QString("#b00303"));
    }

}
