// imageuploader.cpp
#include "imageuploader.h"
#include <QCoreApplication>
#include <QDebug>
#include <QHttpMultiPart>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QFile>
#include <QFileInfo>

ImageUploader::ImageUploader(QObject *parent) : QObject(parent)
{
    networkManager = new QNetworkAccessManager(this);
}

void ImageUploader::uploadImage(const QString &imageUrl)
{
    QHttpMultiPart *multiPart = new QHttpMultiPart(QHttpMultiPart::FormDataType);

    QHttpPart imagePart;
    imagePart.setHeader(QNetworkRequest::ContentTypeHeader, QVariant("multipart/form-data"));

    qDebug() << "Image URL:" << imageUrl;

    // Tách tên file từ imageUrl
    QString fileName = QFileInfo(imageUrl).fileName();

    imagePart.setHeader(QNetworkRequest::ContentDispositionHeader,
                        QVariant("form-data; name=\"file\"; filename=\"" + fileName + "\""));

    QFile *file = new QFile(imageUrl);

    // Check file tồn tại
    if (!file->exists()) {
        qWarning() << "File does not exist:" << imageUrl;
        return;
    }

    //Check mở folder
    if (!file->open(QIODevice::ReadOnly)) {
        qWarning() << "Failed to open file:" << file->errorString();
        return;
    }

    imagePart.setBodyDevice(file);
    file->setParent(multiPart);

    multiPart->append(imagePart);

    QUrl url("https://d3b3-42-116-6-42.ngrok-free.app/upload-image/");
    // QUrl url ("http://localhost:8080/");
    QNetworkRequest request(url);

    QNetworkAccessManager *networkManager = new QNetworkAccessManager(this);
    QNetworkReply *reply = networkManager->post(request, multiPart);

    connect(reply, &QNetworkReply::finished, this, [this, reply, multiPart, file, imageUrl]() {
        replyFinished(reply);
        file->close(); // Đóng file sau khi gửi xong
        multiPart->deleteLater();
        reply->deleteLater();

        emit fileSaved(imageUrl);
    });
}

void ImageUploader::uploadCapturedImage(const QString &capturedImagePath)
{
    uploadImage(capturedImagePath);
}

void ImageUploader::replyFinished(QNetworkReply *reply)
{
    if (reply->error() == QNetworkReply::NoError) {
        qDebug() << "Upload successful!";
        qDebug() << "Response:" << reply->readAll();
        qDebug() << "HTTP status code: " << reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt();
    } else {
        qDebug() << "Error: " << reply->errorString();
        qDebug() << "Detailed error: " << reply->attribute(QNetworkRequest::HttpReasonPhraseAttribute).toString();
        qDebug() << "HTTP status code: " << reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt();
    }
}
void ImageUploader::setFilePermissions(const QString &filePath)
{
    QFile file(filePath);

    if (file.exists()) {
        QFileInfo fileInfo(file);
        QFile::Permissions permissions = fileInfo.permissions();

        // Set your desired permissions here
        permissions |= QFile::ReadOwner | QFile::WriteOwner | QFile::ReadGroup | QFile::ReadOther;

        // Set the permissions for the file
        if (!file.setPermissions(permissions)) {
            qWarning() << "Failed to set permissions for the file:" << file.errorString();
        }
    } else {
        qWarning() << "File does not exist:" << filePath;
    }
}
