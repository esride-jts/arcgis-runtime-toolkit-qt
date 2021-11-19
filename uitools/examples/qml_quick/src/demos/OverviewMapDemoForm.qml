// Copyright 2021 ESRI
//
// All rights reserved under the copyright laws of the United States
// and applicable international laws, treaties, and conventions.
//
// You may freely redistribute and use this sample code, with or
// without modification, provided you include the original copyright
// notice and use restrictions.
//
// See the Sample code usage restrictions document for further information.
//

import QtQuick 2.12
import QtQuick.Controls 2.12
import Esri.ArcGISRuntime 100.13
import Esri.ArcGISRuntime.Toolkit 100.13


DemoPage {
    anchors.fill: parent
    // set focus to enable keyboard navigation
    focus: true
    sceneViewContents: Component {
        SceneView {
            Scene {
                initBasemapStyle: Enums.BasemapStyleArcGISCommunity
            }
            OverviewMap {
                anchors {
                    top: parent.top
                    left: parent.left
                    margins: 10
                }
                geoView: parent
            }
        }
    }
    mapViewContents : Component {
        MapView {
            Map {
                initBasemapStyle: Enums.BasemapStyleArcGISCommunity
            }
            OverviewMap {
                anchors {
                    top: parent.top
                    left: parent.left
                    margins: 10
                }
                geoView: parent
            }
        }
    }
}
