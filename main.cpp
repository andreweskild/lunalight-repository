#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QSurfaceFormat>
#include <QPalette>
#include <QColor>
#include <QtSvg>

#include "style/colorpalette.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif


    QSurfaceFormat format;
    format.setSamples(8);
    QSurfaceFormat::setDefaultFormat(format);

    QGuiApplication app(argc, argv);
    QPalette darkPalette;
    darkPalette.setColor(QPalette::ColorGroup::Active, QPalette::ColorRole::Button, QColor("#FF0000"));
    app.setPalette(darkPalette);

    QQmlApplicationEngine engine;
    ColorPalette::registerSingleton(&engine);
    engine.addImportPath("controls/");

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
