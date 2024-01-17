#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "imageuploader.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    qputenv("QML_XHR_ALLOW_FILE_READ", QByteArray("1"));

    ImageUploader imageUploader;
    engine.rootContext()->setContextProperty("imageUploader", &imageUploader);

    const QUrl url(QStringLiteral("qrc:/QML_RESOURCES/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
