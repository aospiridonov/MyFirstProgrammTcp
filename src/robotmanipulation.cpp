#include "robotmanipulation.h"
#include <QTimer>
RobotManipulation::RobotManipulation(QObject *parent) : QObject(parent)
{

}

void RobotManipulation::connect()
{
    mSocket.connectToHost(QString("192.168.77.1"), 4444);
    if (!mSocket.waitForConnected(3000)) {
        // If not, warn user.
        qDebug() <<"Connection failed.";
    } else {
        qDebug() <<"Ok, connection is established";
    }
}

void RobotManipulation::connectIP(const QString &ipDevice)
{
    mSocket.connectToHost(ipDevice, 4444);
    if (!mSocket.waitForConnected(3000)) {
        // If not, warn user.
        qDebug() <<"Connection failed.";
    } else {
        qDebug() <<"Ok, connection is established";
    }
}
void RobotManipulation::connectIPport(const QString &ipDevice, quint16 port)
{
    mSocket.connectToHost(ipDevice, port);
    if (!mSocket.waitForConnected(3000)) {
        qDebug() <<"Connection failed.";
    } else {
        qDebug() <<"Ok, connection is established";
    }
}

void RobotManipulation::sendCommand(const QString &action)
{
    if (mSocket.state() != QTcpSocket::ConnectedState) {
        qDebug() <<"send failed.";
        return;
    }

    if (mSocket.write((action + "\n").toLatin1()) == -1) {
        qDebug() <<"Connection failed.";
    }
}

RobotManipulation::~RobotManipulation()
{
    mSocket.disconnectFromHost();
    mSocket.waitForDisconnected(3000);
}
