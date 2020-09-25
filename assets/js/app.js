// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.css";

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
//     import socket from "./socket"
//
import "alpinejs";
import "phoenix_html";
import { Socket } from "phoenix";
import NProgress from "nprogress";
import { LiveSocket } from "phoenix_live_view";

import * as CodeMirror from "codemirror";
import "codemirror/mode/xml/xml.js";
import "codemirror/lib/codemirror.css";
import "codemirror/theme/dracula.css";
import "codemirror/mode/javascript/javascript.js";
import "codemirror/mode/htmlmixed/htmlmixed.js";

import * as Beautify from "js-beautify";

let Hooks = {};
Hooks.InitializeEditor = {
  initEditor() {
    const hook = this;
    const mimetype = this.el.dataset.mimetype.split(";")[0];

    const editor = CodeMirror.fromTextArea(this.el, {
      mode: this.mode(mimetype),
      lineNumbers: true,
      readOnly: !!this.el.dataset.readonly,
    });

    const code = editor.getValue();
    const beautified = this.beautify(code, mimetype);
    editor.setValue(beautified);
  },

  mounted() {
    this.initEditor();
  },

  updated() {
    this.initEditor();
  },

  mode(mimetype) {
    if (mimetype == "application/json") {
      return { name: "javascript", json: true };
    }

    return mimetype;
  },

  beautify(code, mimetype) {
    if (mimetype == "text/html") {
      return Beautify.html_beautify(code);
    } else if (mimetype == "application/json") {
      return Beautify.js_beautify(code);
    }

    return code;
  },
};

let csrfToken = document
  .querySelector("meta[name='csrf-token']")
  .getAttribute("content");

let liveSocket = new LiveSocket("/live", Socket, {
  params: { _csrf_token: csrfToken },
  hooks: Hooks,
  dom: {
    onBeforeElUpdated(from, to) {
      if (from.__x) {
        window.Alpine.clone(from.__x, to);
      }
    },
  },
});

// Show progress bar on live navigation and form submits
window.addEventListener("phx:page-loading-start", (info) => NProgress.start());
window.addEventListener("phx:page-loading-stop", (info) => NProgress.done());

// connect if there are any LiveViews on the page
liveSocket.connect();

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)
window.liveSocket = liveSocket;
