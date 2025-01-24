#include "buttonbehavior.h"

#include <QDebug>

ButtonBehavior::ButtonBehavior(QObject *parent) : QObject(parent)
{
    timerArrowMove = new QTimer(this);
    connect(timerArrowMove, SIGNAL(timeout()),this,SLOT(ArrowMoveAnimation()));
    timerArrowMove->start(200);
}

void ButtonBehavior::ArrowMoveAnimation()
{


}

void ButtonBehavior::setButtonObject(QObject* obj, QVariant selectObject)
{

    switch(selectObject.toInt()){
    case 0: /* Button Navigation to unvisible */
        obj->setProperty("visible", false );
        break;
    case 1: /* Button Navigation to visible */
        obj->setProperty("visible", true );
        break;

    }

}

void ButtonBehavior::setScreenMoveObject(QObject* obj, QVariant selectObject)
{

    switch(selectObject.toInt()){
    case 0:
        obj->setProperty("running", false );
        break;
    case 1:
        obj->setProperty("running", true );
        break;
    }


}
