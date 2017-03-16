# Webcamoid, webcam capture application.
# Copyright (C) 2011-2017  Gonzalo Exequiel Pedone
#
# Webcamoid is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Webcamoid is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Webcamoid. If not, see <http://www.gnu.org/licenses/>.
#
# Web-Site: http://webcamoid.github.io/

exists(commons.pri) {
    include(commons.pri)
} else {
    exists(../../../../commons.pri) {
        include(../../../../commons.pri)
    } else {
        error("commons.pri file not found.")
    }
}

CONFIG += plugin

HEADERS = \
    src/plugin.h \
    src/mediasourceffmpeg.h \
    src/abstractstream.h \
    src/audiostream.h \
    src/subtitlestream.h \
    src/videostream.h \
    src/clock.h \
    ../mediasource.h

INCLUDEPATH += \
    ../../../../Lib/src \
    ../

LIBS += -L$${PWD}/../../../../Lib/ -l$${COMMONS_TARGET}

OTHER_FILES += pspec.json

DEFINES += __STDC_CONSTANT_MACROS

!isEmpty(FFMPEGINCLUDES): INCLUDEPATH += $${FFMPEGINCLUDES}
!isEmpty(FFMPEGLIBS): LIBS += $${FFMPEGLIBS}

isEmpty(FFMPEGLIBS) {
    CONFIG += link_pkgconfig

    PKGCONFIG += \
        libavdevice \
        libavformat \
        libavcodec \
        libswscale \
        libavutil
}

CONFIG(config_sampleformat64): DEFINES += HAVE_SAMPLEFORMAT64

QT += qml concurrent widgets

SOURCES = \
    src/plugin.cpp \
    src/mediasourceffmpeg.cpp \
    src/abstractstream.cpp \
    src/audiostream.cpp \
    src/subtitlestream.cpp \
    src/videostream.cpp \
    src/clock.cpp \
    ../mediasource.cpp

DESTDIR = $${OUT_PWD}/../../submodules/MultiSrc

TEMPLATE = lib

INSTALLS += target

target.path = $${LIBDIR}/$${COMMONS_TARGET}/submodules/MultiSrc
