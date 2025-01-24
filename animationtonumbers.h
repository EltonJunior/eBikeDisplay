#ifndef ANIMATIONTONUMBERS_H
#define ANIMATIONTONUMBERS_H

#include <QObject>
#include <QtCore>

class AnimationToNumbers : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString OdometerIncreaseVar READ OdometerIncreaseVar WRITE setOdometerIncreaseVar NOTIFY OdometerIncreaseVarChanged)
    Q_PROPERTY(QString SpeedIncreaseVar READ SpeedIncreaseVar WRITE setSpeedIncreaseVar NOTIFY SpeedIncreaseVarChanged)
    Q_PROPERTY(QString OdoAnalogIncreaseVar READ OdoAnalogIncreaseVar WRITE setOdoAnalogIncreaseVar NOTIFY OdoAnalogIncreaseVarChanged)
    Q_PROPERTY(QString BatteryIncreaseVar READ BatteryIncreaseVar WRITE setBatteryIncreaseVar NOTIFY BatteryIncreaseVarChanged)
    Q_PROPERTY(QString AlertLowBatteryVar READ AlertLowBatteryVar WRITE setAlertLowBatteryVar NOTIFY AlertLowBatteryVarChanged)
    Q_PROPERTY(QString AlertLowBaterryToDigitVar READ AlertLowBaterryToDigitVar WRITE setAlertLowBaterryToDigitVar NOTIFY AlertLowBaterryToDigitVarChanged)
public:
    explicit AnimationToNumbers(QObject *parent = nullptr);
    QString OdometerIncreaseVar();
    QString SpeedIncreaseVar();
    QString OdoAnalogIncreaseVar();
    QString BatteryIncreaseVar();
    QString AlertLowBatteryVar();
    QString AlertLowBaterryToDigitVar();

    QTimer *timer, *timerToSpeed, *timerToBattery;
    int counter = 0, counterToSpeed = 0, ClockWise = 0, BatteryClockWise = 0, batteryIncreaseCounter = 0;

    int valueToDigitalSpeed[91]={0,1,1,2,2,3,4,4,5,6,6,7,8,8,9,10,10,11,12,12,13,14,14,15,15,16,17,17,18,19,19,20,21,21,22,23,23,24,25,25,26,27,27,28,28,29,30,30,31,32,32,33,34,34,35,36,36,37,38,38,39,40,40,41,41,42,43,43,44,45,45,46,47,47,48,49,50,51,51,52,53,53,54,54,55,56,56,57,58,59,60};

    int valueToAnalog[91]={0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90};

signals:
    void OdometerIncreaseVarChanged();
    void SpeedIncreaseVarChanged();
    void OdoAnalogIncreaseVarChanged();
    void BatteryIncreaseVarChanged();
    void AlertLowBatteryVarChanged();
    void AlertLowBaterryToDigitVarChanged();

public slots:
    void setOdometerIncreaseVar( QString );
    void setSpeedIncreaseVar( QString );
    void setOdoAnalogIncreaseVar( QString );
    void setBatteryIncreaseVar( QString );
    void setAlertLowBatteryVar( QString );
    void setAlertLowBaterryToDigitVar( QString );

    void OdometerIncreaseAnimation();
    void SpeedIncreaseAnimation();
    void BatteryIncreaseAnimation();

private:
    QString m_OdometerIncreaseVar;
    QString m_SpeedIncreaseVar;
    QString m_OdoAnalogIncreaseVar;
    QString m_BatteryIncreaseVar;
    QString m_AlertLowBatteryVar;
    QString m_AlertLowBaterryToDigitVar;

};

#endif // ANIMATIONTONUMBERS_H
