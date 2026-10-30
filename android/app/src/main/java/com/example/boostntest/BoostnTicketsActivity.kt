package com.example.boostntest

import android.annotation.SuppressLint
import android.os.Bundle
import android.util.Log
import android.webkit.CookieManager
import android.webkit.JavascriptInterface
import android.webkit.WebChromeClient
import android.webkit.WebView
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity

class BoostnTicketsActivity : AppCompatActivity() {

    @SuppressLint("SetJavaScriptEnabled")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_boostn_tickets)

        val webView = findViewById<WebView>(R.id.boostnWebView)
        val purchaseStatus = findViewById<TextView>(R.id.purchaseStatus)

        // Test app only: lets you inspect the widget from desktop Chrome via chrome://inspect.
        WebView.setWebContentsDebuggingEnabled(true)

        webView.settings.javaScriptEnabled = true
        webView.settings.domStorageEnabled = true
        webView.webChromeClient = WebChromeClient()
        // The widget runs in an iframe; the payment form inside it needs cookies.
        CookieManager.getInstance().setAcceptThirdPartyCookies(webView, true)

        webView.addJavascriptInterface(object {
            @JavascriptInterface
            fun onPurchaseComplete(orderId: String) {
                // Tickets were bought. This runs on a background thread, so hop to the UI thread.
                Log.d(TAG, "Purchase complete, orderId=$orderId")
                runOnUiThread { purchaseStatus.text = "Purchase complete ✅ order: $orderId" }
            }
        }, "BoostnApp")

        webView.loadDataWithBaseURL("https://boostn.nmdevai.com/", WIDGET_HTML, "text/html", "UTF-8", null)
    }

    companion object {
        private const val TAG = "BoostnTest"

        private val WIDGET_HTML = """
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
        """.trimIndent()
    }
}
