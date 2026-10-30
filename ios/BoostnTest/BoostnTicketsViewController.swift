import UIKit
import WebKit

final class BoostnTicketsViewController: UIViewController, WKScriptMessageHandler {

    /// Called when the widget reports a finished purchase (the test app shows it in the bottom bar).
    var onPurchaseComplete: ((String) -> Void)?

    private var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let config = WKWebViewConfiguration()
        config.userContentController.add(self, name: "boostn")

        webView = WKWebView(frame: view.bounds, configuration: config)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(webView)

        // Test app only: lets you inspect the widget with Safari's Web Inspector (Develop menu on a Mac).
        if #available(iOS 16.4, *) {
            webView.isInspectable = true
        }

        webView.loadHTMLString(Self.widgetHTML, baseURL: URL(string: "https://boostn.nmdevai.com/"))
    }

    func userContentController(_ userContentController: WKUserContentController,
                               didReceive message: WKScriptMessage) {
        guard let body = message.body as? [String: Any],
              body["type"] as? String == "purchase-complete" else { return }
        // Tickets were bought — e.g. show a confirmation or close this screen.
        onPurchaseComplete?(body["orderId"] as? String ?? "")
    }

    private static let widgetHTML = """
    <!DOCTYPE html>
    <html lang="de">
    <head>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
    </head>
    <body style="margin:0">
      <div data-boostn-club="e2e-test-club-name-official-name"
           data-boostn-mode="event-list"
           data-boostn-grid-source="fe742f1a-0e12-4da8-a875-41cb43ed5a66"></div>
      <script src="https://boostn.nmdevai.com/widget/v1.js" async></script>
      <script>
        window.addEventListener('boostn:purchase-complete', function (e) {
          var orderId = (e.detail && e.detail.orderId) || '';
          if (window.BoostnApp) window.BoostnApp.onPurchaseComplete(orderId);
          if (window.webkit && window.webkit.messageHandlers && window.webkit.messageHandlers.boostn) {
            window.webkit.messageHandlers.boostn.postMessage({ type: 'purchase-complete', orderId: orderId });
          }
        });
      </script>
    </body>
    </html>
    """
}
