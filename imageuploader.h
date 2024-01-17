// imageuploader.h
#ifndef IMAGEUPLOADER_H
#define IMAGEUPLOADER_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QFile>

class ImageUploader : public QObject
{
    Q_OBJECT
public:
    explicit ImageUploader(QObject *parent = nullptr);
    Q_INVOKABLE void setFilePermissions(const QString &filePath);

signals:
    void fileSaved(const QString &filePath);

public slots:
    void uploadImage(const QString &imageUrl);
    void uploadCapturedImage(const QString &capturedImagePath);

private slots:
    void replyFinished(QNetworkReply *reply);

private:
    QNetworkAccessManager *networkManager;
};


#endif // IMAGEUPLOADER_H
