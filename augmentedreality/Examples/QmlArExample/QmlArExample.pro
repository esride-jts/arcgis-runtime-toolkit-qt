###############################################################################
# Copyright 2012-2019 Esri
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
###############################################################################

mac {
    cache()
}

#-------------------------------------------------------------------------------

CONFIG += c++17

QT += core gui opengl network positioning sensors qml quick

lessThan(QT_MAJOR_VERSION, 6) {
    error("This version of the ArcGIS Maps SDK for Qt requires at least Qt 6.2.4")
}

equals(QT_MAJOR_VERSION, 6) {
    lessThan(QT_MINOR_VERSION, 2) {
        error("This version of the ArcGIS Maps SDK for Qt requires at least Qt 6.2.4")
    }
  equals(QT_MINOR_VERSION, 2) : lessThan(QT_PATCH_VERSION, 4) {
    error("This version of the ArcGIS Maps SDK for Qt requires at least Qt 6.2.4")
  }
}

ARCGIS_RUNTIME_VERSION = 200.0.0
include($$PWD/arcgisruntime.pri)

TEMPLATE = app
TARGET = QmlArExample

HEADERS += \
    AppInfo.h

SOURCES += \
    main.cpp

RESOURCES += \
    qml/qml.qrc \
    Resources/Resources.qrc

OTHER_FILES += \
    wizard.xml \
    wizard.png \
    qml/*.qml \
    qml/scenes/*.qml \
    qml/*.js

#-------------------------------------------------------------------------------
# AR configuration

# The path to the ArcGIS Maps SDK toolkit for Qt sources, corresponding to the files downloaded
# from the GitHub repo: https://github.com/Esri/arcgis-runtime-toolkit-qt

ARCGIS_TOOLKIT_PATH = # must be set to the root path of the toolkit folder

isEmpty(ARCGIS_TOOLKIT_PATH) {
    error(ARCGIS_TOOLKIT_PATH is not set)
}

include($$ARCGIS_TOOLKIT_PATH/augmentedreality/QmlApi/ArQmlApi.pri)

#-------------------------------------------------------------------------------

win32 {
    include (Win/Win.pri)
}

macx {
    include (Mac/Mac.pri)
}

ios {
    include (iOS/iOS.pri)
}

android {
    include (Android/Android.pri)
}
