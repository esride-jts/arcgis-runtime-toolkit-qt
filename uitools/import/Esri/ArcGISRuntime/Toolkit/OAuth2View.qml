/*******************************************************************************
 *  Copyright 2012-2020 Esri
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 ******************************************************************************/

import Esri.ArcGISRuntime.Toolkit.Controller

import QtQuick
import QtQuick.Controls
import QtWebView
import QtQuick.Window

Dialog {
    id: oAuthView

    property AuthenticationController controller: null

    title: webView.title

    closePolicy: Popup.NoAutoClose

    header: Label {
        text: `<h2>${webView.title}</h2>`
        horizontalAlignment: Text.AlignHCenter
    }

    footer: DialogButtonBox {
        standardButtons: +DialogButtonBox.Close
        onRejected: controller.cancel();
    }

    implicitWidth: Screen.width
    implicitHeight: Screen.height

    WebView {
        id: webView
        anchors {
            centerIn: parent
            fill: parent
        }

        url: controller.currentChallengeUrl

        onLoadingChanged: (loadRequest) => {
            if (loadRequest.status === WebView.LoadSucceededStatus) {
                forceActiveFocus();
            } else if (loadRequest.status === WebView.LoadFailedStatus) {
                controller.cancelWithError("Failed to load");
            }
        }

        onTitleChanged: {
            // If the title contains "SUCCESS", get the authorization code from the title and continue authenticationChallenge.
            if (isSuccess()) {
                const authCode = title.replace("SUCCESS code=", "");
                controller.continueWithOAuthAuthorizationCode(authCode);
                return;
            } else if (isInvalidRequest()) {
                // If the title contains "Denied error=invalid_request", get the HTML content.
                readHtmlContent();
                return;
            }

            // If there is an error, cancel with error.
            if (isError()) {
                controller.cancelWithError(title, html);
            }
        }

        // Property to get HTML content when necessary.
        property string html: ""
        onHtmlChanged: {
            controller.cancelWithError(title, html);
        }

        // Helper functions
        function isSuccess() {
            return title.indexOf("SUCCESS code=") > -1;
        }

        function isInvalidRequest() {
            return (title.indexOf("Denied error=invalid_request") > -1);
        }

        function isError() {
            return (title.indexOf("Denied error=") > -1) || (title.indexOf("Error: ") > -1);
        }

        function readHtmlContent() {
            const js = "document.documentElement.outerHTML";
            webview.runJavaScript(js, function(result) { html = result; });
        }
    }
}
