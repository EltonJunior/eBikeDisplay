#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QTimeLine>
#include <QQmlContext>
#include "gpio.h"
#include "animationtonumbers.h"
#include "animationtomap.h"
#include "buttonbehavior.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    Gpio gpio15(15, GPIO_OUTPUT);
    qmlRegisterType< AnimationToNumbers >("AnimationToNumbersClass", 1, 0, "AnimationToNumbers");
    qmlRegisterType< AnimationToMap >("AnimationToMapClass", 1, 0, "AnimationToMap");
    qmlRegisterType< ButtonBehavior >("ButtonBehaviorClass", 1, 0, "ButtonBehavior");

    QQmlContext* ctx = engine.rootContext();
    ctx->setContextProperty("output", &gpio15);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
