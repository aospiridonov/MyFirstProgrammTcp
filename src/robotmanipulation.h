#ifndef ROBOTMANIPULATION_H
#define ROBOTMANIPULATION_H

#include <QObject>
#include <QtNetwork/QTcpSocket>
#include <QDebug>
class RobotManipulation : public QObject
{
    Q_OBJECT
public:
    explicit RobotManipulation(QObject *parent = 0);
    ~RobotManipulation();
    QTcpSocket mSocket;
    Q_INVOKABLE void connect();
    Q_INVOKABLE void connectIP(const QString &ipDevice);
    Q_INVOKABLE void connectIPport(const QString &ipDevice, quint16 port);
    Q_INVOKABLE void sendCommand(const QString &action);
signals:

public slots:

};

#endif // ROBOTMANIPULATION_H
