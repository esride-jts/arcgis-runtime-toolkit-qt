# Copyright 2012-2022 Esri
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

CONFIG += c++17 warn_on qmltestcase

TEMPLATE = app

ARCGIS_RUNTIME_VERSION = 200.0.0
include($$PWD/../../shared/arcgisruntime.pri)
include($$PWD/../../../../../uitools/toolkitqml.pri)

macx {
    cache()
}

TARGET = qml_quick

DISTFILES += \
    tst_floorfiltercontroller.qml

SOURCES += \
    tst_main.cpp

QML2_IMPORT_PATH += $$absolute_path($$PWD/../../../uitools/import)
