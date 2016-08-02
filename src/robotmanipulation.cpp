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

void RobotManipulation::sendCommand(const QString &action)
{
    // Here we send "pad <padId> <x> <y>" command.
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
    // Gracefully disconnecting from host.
    mSocket.disconnectFromHost();
    // Here we do not care for success or failure of operation since we will close anyway.
    mSocket.waitForDisconnected(3000);
}
