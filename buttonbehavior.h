#ifndef BUTTONBEHAVIOR_H
#define BUTTONBEHAVIOR_H

#include <QObject>
#include <QtCore>

class ButtonBehavior : public QObject
{
    Q_OBJECT
public:
    explicit ButtonBehavior(QObject *parent = nullptr);

    QTimer *timerArrowMove;
    int countertimerArrowMove = 0;

    QObject* myObject;
    Q_INVOKABLE void setButtonObject(QObject* obj, QVariant selectObject);
    Q_INVOKABLE void setScreenMoveObject(QObject* obj, QVariant selectObject);



signals:


public slots:

    void ArrowMoveAnimation();

private:

};

#endif // BUTTONBEHAVIOR_H
