//
//  WKWebView+Extension.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 26.03.2025.
//

import WebKit

extension WKWebView {
    // Will disable zoom by adding a meta tag to the page
    func disableZoom() {
        let script = """
        var meta = document.createElement('meta');
        meta.name = 'viewport';
        meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';
        document.getElementsByTagName('head')[0].appendChild(meta);
        """
        let userScript = WKUserScript(source: script, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        self.configuration.userContentController.addUserScript(userScript)
        self.scrollView.backgroundColor = .clear
    }
}
