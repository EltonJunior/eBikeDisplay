#include "animationtomap.h"

AnimationToMap::AnimationToMap(QObject *parent) : QObject(parent),
    m_ArrowMoveInXVar("284"),
    m_ArrowMoveInYVar("148"),
    m_ArrowMoveInRVar("89")
{
    timerArrowMove = new QTimer(this);
    connect(timerArrowMove, SIGNAL(timeout()),this,SLOT(ArrowMoveAnimation()));
    timerArrowMove->start(200);
}

QString AnimationToMap::ArrowMoveInXVar()
{
    return m_ArrowMoveInXVar;
}

QString AnimationToMap::ArrowMoveInYVar()
{
    return m_ArrowMoveInYVar;
}

QString AnimationToMap::ArrowMoveInRVar()
{
    return m_ArrowMoveInRVar;
}

void AnimationToMap::setArrowMoveInXVar(QString newArrowMoveInXVar )
{
    if( m_ArrowMoveInXVar != newArrowMoveInXVar )
    {
        m_ArrowMoveInXVar = newArrowMoveInXVar;
        emit ArrowMoveInXVarChanged();
    }
}

void AnimationToMap::setArrowMoveInYVar(QString newArrowMoveInYVar )
{
    if( m_ArrowMoveInYVar != newArrowMoveInYVar )
    {
        m_ArrowMoveInYVar = newArrowMoveInYVar;
        emit ArrowMoveInYVarChanged();
    }
}

void AnimationToMap::setArrowMoveInRVar(QString newArrowMoveInRVar )
{
    if( m_ArrowMoveInRVar != newArrowMoveInRVar )
    {
        m_ArrowMoveInRVar = newArrowMoveInRVar;
        emit ArrowMoveInRVarChanged();
    }
}

void AnimationToMap::ArrowMoveAnimation()
{

    setArrowMoveInXVar( QString::number(valueInX[countertimerArrowMove]) );
    setArrowMoveInYVar( QString::number(valueInY[countertimerArrowMove]) );
    setArrowMoveInRVar( QString::number(valueInR[countertimerArrowMove]) );

    if(countertimerArrowMove++ >= 897)
        countertimerArrowMove = 0;

}
