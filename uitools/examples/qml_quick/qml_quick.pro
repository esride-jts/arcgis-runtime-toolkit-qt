#*******************************************************************************
#  Copyright 2012-2022 Esri
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at

#  http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
# ******************************************************************************/
mac {
    cache()
}

#-------------------------------------------------------------------------------

CONFIG += c++17

# additional modules are pulled in via arcgisruntime.pri
QT += opengl qml quick

ARCGIS_RUNTIME_VERSION = 200.0.0
include($$PWD/arcgisruntime.pri)
include($$PWD/../../toolkitqml.pri)

TEMPLATE = app
TARGET = qml_quick

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

#-------------------------------------------------------------------------------

SOURCES += \
    src/main.cpp

RESOURCES += \
    src/demos/demos.qrc \
    qtquick.qrc \
    $$absolute_path($$PWD/../../../calcite-qml/Calcite/calcite.qrc) \
    $$absolute_path($$PWD/../shared/qml/shared_demo_qml.qrc)

QML_IMPORT_PATH += $$absolute_path($$PWD/../shared/qml)

OTHER_FILES += \
    wizard.xml \
    wizard.png

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
