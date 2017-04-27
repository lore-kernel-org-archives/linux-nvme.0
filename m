From: zouming.zouming@huawei.com (Zou Ming)
Date: Thu, 27 Apr 2017 08:05:01 +0000
Subject: [PATCH] nvme-cli: Huawei plug-in.
Message-ID: <1493280301-19648-1-git-send-email-zouming.zouming@huawei.com>

This patch adds support for Vendor unique commands for Huawei devices.
Following commands are supported in current version of this extension:

1.list  List addition info (such as namespace name and array name) for Huawei devices
---
 Documentation/nvme-huawei-list.1    |  54 +++
 Documentation/nvme-huawei-list.html | 806 ++++++++++++++++++++++++++++++++++++
 Documentation/nvme-huawei-list.txt  |  31 ++
 Makefile                            |   2 +-
 huawei-nvme.c                       | 382 +++++++++++++++++
 huawei-nvme.h                       |  17 +
 6 files changed, 1291 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/nvme-huawei-list.1
 create mode 100644 Documentation/nvme-huawei-list.html
 create mode 100644 Documentation/nvme-huawei-list.txt
 create mode 100644 huawei-nvme.c
 create mode 100644 huawei-nvme.h

diff --git a/Documentation/nvme-huawei-list.1 b/Documentation/nvme-huawei-list.1
new file mode 100644
index 0000000..8f0ca1c
--- /dev/null
+++ b/Documentation/nvme-huawei-list.1
@@ -0,0 +1,54 @@
+'\" t
+.\"     Title: nvme-huawei-list
+.\"    Author: [FIXME: author] [see http://docbook.sf.net/el/author]
+.\" Generator: DocBook XSL Stylesheets v1.78.1 <http://docbook.sf.net/>
+.\"      Date: 04/25/2017
+.\"    Manual: NVMe Manual
+.\"    Source: NVMe
+.\"  Language: English
+.\"
+.TH "NVME\-HUAWEI\-LIST" "1" "04/25/2017" "NVMe" "NVMe Manual"
+.\" -----------------------------------------------------------------
+.\" * Define some portability stuff
+.\" -----------------------------------------------------------------
+.\" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+.\" http://bugs.debian.org/507673
+.\" http://lists.gnu.org/archive/html/groff/2009-02/msg00013.html
+.\" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+.ie \n(.g .ds Aq \(aq
+.el       .ds Aq '
+.\" -----------------------------------------------------------------
+.\" * set default formatting
+.\" -----------------------------------------------------------------
+.\" disable hyphenation
+.nh
+.\" disable justification (adjust text to left margin only)
+.ad l
+.\" -----------------------------------------------------------------
+.\" * MAIN CONTENT STARTS HERE *
+.\" -----------------------------------------------------------------
+.SH "NAME"
+nvme-huawei-list \- List all recognized Huawei NVMe devices 
+.SH "SYNOPSIS"
+.sp
+.nf
+\fInvme list\fR [\-o <fmt> | \-\-output\-format=<fmt>]
+.fi
+.SH "DESCRIPTION"
+.sp
+Scan the sysfs tree for NVM Express devices and return the /dev node for those Huawei devices as well as some pertinent information about them\&.
+.SH "OPTIONS"
+.PP
+\-o <format>, \-\-output\-format=<format>
+.RS 4
+Set the reporting format to
+\fInormal\fR
+or
+\fIjson\fR\&. Only one output format can be used at a time\&.
+.RE
+.SH "EXAMPLES"
+.sp
+No examples yet\&.
+.SH "NVME"
+.sp
+Part of the nvme\-user suite
diff --git a/Documentation/nvme-huawei-list.html b/Documentation/nvme-huawei-list.html
new file mode 100644
index 0000000..425302e
--- /dev/null
+++ b/Documentation/nvme-huawei-list.html
@@ -0,0 +1,806 @@
+<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
+    "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
+<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
+<head>
+<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
+<meta name="generator" content="AsciiDoc 8.6.7" />
+<title>nvme-huawei-list(1)</title>
+<style type="text/css">
+/* Shared CSS for AsciiDoc xhtml11 and html5 backends */
+
+/* Default font. */
+body {
+  font-family: Georgia,serif;
+}
+
+/* Title font. */
+h1, h2, h3, h4, h5, h6,
+div.title, caption.title,
+thead, p.table.header,
+#toctitle,
+#author, #revnumber, #revdate, #revremark,
+#footer {
+  font-family: Arial,Helvetica,sans-serif;
+}
+
+body {
+  margin: 1em 5% 1em 5%;
+}
+
+a {
+  color: blue;
+  text-decoration: underline;
+}
+a:visited {
+  color: fuchsia;
+}
+
+em {
+  font-style: italic;
+  color: navy;
+}
+
+strong {
+  font-weight: bold;
+  color: #083194;
+}
+
+h1, h2, h3, h4, h5, h6 {
+  color: #527bbd;
+  margin-top: 1.2em;
+  margin-bottom: 0.5em;
+  line-height: 1.3;
+}
+
+h1, h2, h3 {
+  border-bottom: 2px solid silver;
+}
+h2 {
+  padding-top: 0.5em;
+}
+h3 {
+  float: left;
+}
+h3 + * {
+  clear: left;
+}
+h5 {
+  font-size: 1.0em;
+}
+
+div.sectionbody {
+  margin-left: 0;
+}
+
+hr {
+  border: 1px solid silver;
+}
+
+p {
+  margin-top: 0.5em;
+  margin-bottom: 0.5em;
+}
+
+ul, ol, li > p {
+  margin-top: 0;
+}
+ul > li     { color: #aaa; }
+ul > li > * { color: black; }
+
+pre {
+  padding: 0;
+  margin: 0;
+}
+
+#author {
+  color: #527bbd;
+  font-weight: bold;
+  font-size: 1.1em;
+}
+#email {
+}
+#revnumber, #revdate, #revremark {
+}
+
+#footer {
+  font-size: small;
+  border-top: 2px solid silver;
+  padding-top: 0.5em;
+  margin-top: 4.0em;
+}
+#footer-text {
+  float: left;
+  padding-bottom: 0.5em;
+}
+#footer-badges {
+  float: right;
+  padding-bottom: 0.5em;
+}
+
+#preamble {
+  margin-top: 1.5em;
+  margin-bottom: 1.5em;
+}
+div.imageblock, div.exampleblock, div.verseblock,
+div.quoteblock, div.literalblock, div.listingblock, div.sidebarblock,
+div.admonitionblock {
+  margin-top: 1.0em;
+  margin-bottom: 1.5em;
+}
+div.admonitionblock {
+  margin-top: 2.0em;
+  margin-bottom: 2.0em;
+  margin-right: 10%;
+  color: #606060;
+}
+
+div.content { /* Block element content. */
+  padding: 0;
+}
+
+/* Block element titles. */
+div.title, caption.title {
+  color: #527bbd;
+  font-weight: bold;
+  text-align: left;
+  margin-top: 1.0em;
+  margin-bottom: 0.5em;
+}
+div.title + * {
+  margin-top: 0;
+}
+
+td div.title:first-child {
+  margin-top: 0.0em;
+}
+div.content div.title:first-child {
+  margin-top: 0.0em;
+}
+div.content + div.title {
+  margin-top: 0.0em;
+}
+
+div.sidebarblock > div.content {
+  background: #ffffee;
+  border: 1px solid #dddddd;
+  border-left: 4px solid #f0f0f0;
+  padding: 0.5em;
+}
+
+div.listingblock > div.content {
+  border: 1px solid #dddddd;
+  border-left: 5px solid #f0f0f0;
+  background: #f8f8f8;
+  padding: 0.5em;
+}
+
+div.quoteblock, div.verseblock {
+  padding-left: 1.0em;
+  margin-left: 1.0em;
+  margin-right: 10%;
+  border-left: 5px solid #f0f0f0;
+  color: #888;
+}
+
+div.quoteblock > div.attribution {
+  padding-top: 0.5em;
+  text-align: right;
+}
+
+div.verseblock > pre.content {
+  font-family: inherit;
+  font-size: inherit;
+}
+div.verseblock > div.attribution {
+  padding-top: 0.75em;
+  text-align: left;
+}
+/* DEPRECATED: Pre version 8.2.7 verse style literal block. */
+div.verseblock + div.attribution {
+  text-align: left;
+}
+
+div.admonitionblock .icon {
+  vertical-align: top;
+  font-size: 1.1em;
+  font-weight: bold;
+  text-decoration: underline;
+  color: #527bbd;
+  padding-right: 0.5em;
+}
+div.admonitionblock td.content {
+  padding-left: 0.5em;
+  border-left: 3px solid #dddddd;
+}
+
+div.exampleblock > div.content {
+  border-left: 3px solid #dddddd;
+  padding-left: 0.5em;
+}
+
+div.imageblock div.content { padding-left: 0; }
+span.image img { border-style: none; }
+a.image:visited { color: white; }
+
+dl {
+  margin-top: 0.8em;
+  margin-bottom: 0.8em;
+}
+dt {
+  margin-top: 0.5em;
+  margin-bottom: 0;
+  font-style: normal;
+  color: navy;
+}
+dd > *:first-child {
+  margin-top: 0.1em;
+}
+
+ul, ol {
+    list-style-position: outside;
+}
+ol.arabic {
+  list-style-type: decimal;
+}
+ol.loweralpha {
+  list-style-type: lower-alpha;
+}
+ol.upperalpha {
+  list-style-type: upper-alpha;
+}
+ol.lowerroman {
+  list-style-type: lower-roman;
+}
+ol.upperroman {
+  list-style-type: upper-roman;
+}
+
+div.compact ul, div.compact ol,
+div.compact p, div.compact p,
+div.compact div, div.compact div {
+  margin-top: 0.1em;
+  margin-bottom: 0.1em;
+}
+
+tfoot {
+  font-weight: bold;
+}
+td > div.verse {
+  white-space: pre;
+}
+
+div.hdlist {
+  margin-top: 0.8em;
+  margin-bottom: 0.8em;
+}
+div.hdlist tr {
+  padding-bottom: 15px;
+}
+dt.hdlist1.strong, td.hdlist1.strong {
+  font-weight: bold;
+}
+td.hdlist1 {
+  vertical-align: top;
+  font-style: normal;
+  padding-right: 0.8em;
+  color: navy;
+}
+td.hdlist2 {
+  vertical-align: top;
+}
+div.hdlist.compact tr {
+  margin: 0;
+  padding-bottom: 0;
+}
+
+.comment {
+  background: yellow;
+}
+
+.footnote, .footnoteref {
+  font-size: 0.8em;
+}
+
+span.footnote, span.footnoteref {
+  vertical-align: super;
+}
+
+#footnotes {
+  margin: 20px 0 20px 0;
+  padding: 7px 0 0 0;
+}
+
+#footnotes div.footnote {
+  margin: 0 0 5px 0;
+}
+
+#footnotes hr {
+  border: none;
+  border-top: 1px solid silver;
+  height: 1px;
+  text-align: left;
+  margin-left: 0;
+  width: 20%;
+  min-width: 100px;
+}
+
+div.colist td {
+  padding-right: 0.5em;
+  padding-bottom: 0.3em;
+  vertical-align: top;
+}
+div.colist td img {
+  margin-top: 0.3em;
+}
+
+ at media print {
+  #footer-badges { display: none; }
+}
+
+#toc {
+  margin-bottom: 2.5em;
+}
+
+#toctitle {
+  color: #527bbd;
+  font-size: 1.1em;
+  font-weight: bold;
+  margin-top: 1.0em;
+  margin-bottom: 0.1em;
+}
+
+div.toclevel0, div.toclevel1, div.toclevel2, div.toclevel3, div.toclevel4 {
+  margin-top: 0;
+  margin-bottom: 0;
+}
+div.toclevel2 {
+  margin-left: 2em;
+  font-size: 0.9em;
+}
+div.toclevel3 {
+  margin-left: 4em;
+  font-size: 0.9em;
+}
+div.toclevel4 {
+  margin-left: 6em;
+  font-size: 0.9em;
+}
+
+span.aqua { color: aqua; }
+span.black { color: black; }
+span.blue { color: blue; }
+span.fuchsia { color: fuchsia; }
+span.gray { color: gray; }
+span.green { color: green; }
+span.lime { color: lime; }
+span.maroon { color: maroon; }
+span.navy { color: navy; }
+span.olive { color: olive; }
+span.purple { color: purple; }
+span.red { color: red; }
+span.silver { color: silver; }
+span.teal { color: teal; }
+span.white { color: white; }
+span.yellow { color: yellow; }
+
+span.aqua-background { background: aqua; }
+span.black-background { background: black; }
+span.blue-background { background: blue; }
+span.fuchsia-background { background: fuchsia; }
+span.gray-background { background: gray; }
+span.green-background { background: green; }
+span.lime-background { background: lime; }
+span.maroon-background { background: maroon; }
+span.navy-background { background: navy; }
+span.olive-background { background: olive; }
+span.purple-background { background: purple; }
+span.red-background { background: red; }
+span.silver-background { background: silver; }
+span.teal-background { background: teal; }
+span.white-background { background: white; }
+span.yellow-background { background: yellow; }
+
+span.big { font-size: 2em; }
+span.small { font-size: 0.6em; }
+
+span.underline { text-decoration: underline; }
+span.overline { text-decoration: overline; }
+span.line-through { text-decoration: line-through; }
+
+div.unbreakable { page-break-inside: avoid; }
+
+
+/*
+ * xhtml11 specific
+ *
+ * */
+
+tt {
+  font-family: "Courier New", Courier, monospace;
+  font-size: inherit;
+  color: navy;
+}
+
+div.tableblock {
+  margin-top: 1.0em;
+  margin-bottom: 1.5em;
+}
+div.tableblock > table {
+  border: 3px solid #527bbd;
+}
+thead, p.table.header {
+  font-weight: bold;
+  color: #527bbd;
+}
+p.table {
+  margin-top: 0;
+}
+/* Because the table frame attribute is overriden by CSS in most browsers. */
+div.tableblock > table[frame="void"] {
+  border-style: none;
+}
+div.tableblock > table[frame="hsides"] {
+  border-left-style: none;
+  border-right-style: none;
+}
+div.tableblock > table[frame="vsides"] {
+  border-top-style: none;
+  border-bottom-style: none;
+}
+
+
+/*
+ * html5 specific
+ *
+ * */
+
+.monospaced {
+  font-family: "Courier New", Courier, monospace;
+  font-size: inherit;
+  color: navy;
+}
+
+table.tableblock {
+  margin-top: 1.0em;
+  margin-bottom: 1.5em;
+}
+thead, p.tableblock.header {
+  font-weight: bold;
+  color: #527bbd;
+}
+p.tableblock {
+  margin-top: 0;
+}
+table.tableblock {
+  border-width: 3px;
+  border-spacing: 0px;
+  border-style: solid;
+  border-color: #527bbd;
+  border-collapse: collapse;
+}
+th.tableblock, td.tableblock {
+  border-width: 1px;
+  padding: 4px;
+  border-style: solid;
+  border-color: #527bbd;
+}
+
+table.tableblock.frame-topbot {
+  border-left-style: hidden;
+  border-right-style: hidden;
+}
+table.tableblock.frame-sides {
+  border-top-style: hidden;
+  border-bottom-style: hidden;
+}
+table.tableblock.frame-none {
+  border-style: hidden;
+}
+
+th.tableblock.halign-left, td.tableblock.halign-left {
+  text-align: left;
+}
+th.tableblock.halign-center, td.tableblock.halign-center {
+  text-align: center;
+}
+th.tableblock.halign-right, td.tableblock.halign-right {
+  text-align: right;
+}
+
+th.tableblock.valign-top, td.tableblock.valign-top {
+  vertical-align: top;
+}
+th.tableblock.valign-middle, td.tableblock.valign-middle {
+  vertical-align: middle;
+}
+th.tableblock.valign-bottom, td.tableblock.valign-bottom {
+  vertical-align: bottom;
+}
+
+
+/*
+ * manpage specific
+ *
+ * */
+
+body.manpage h1 {
+  padding-top: 0.5em;
+  padding-bottom: 0.5em;
+  border-top: 2px solid silver;
+  border-bottom: 2px solid silver;
+}
+body.manpage h2 {
+  border-style: none;
+}
+body.manpage div.sectionbody {
+  margin-left: 3em;
+}
+
+ at media print {
+  body.manpage div#toc { display: none; }
+}
+</style>
+<script type="text/javascript">
+/*<![CDATA[*/
+var asciidoc = {  // Namespace.
+
+/////////////////////////////////////////////////////////////////////
+// Table Of Contents generator
+/////////////////////////////////////////////////////////////////////
+
+/* Author: Mihai Bazon, September 2002
+ * http://students.infoiasi.ro/~mishoo
+ *
+ * Table Of Content generator
+ * Version: 0.4
+ *
+ * Feel free to use this script under the terms of the GNU General Public
+ * License, as long as you do not remove or alter this notice.
+ */
+
+ /* modified by Troy D. Hanson, September 2006. License: GPL */
+ /* modified by Stuart Rackham, 2006, 2009. License: GPL */
+
+// toclevels = 1..4.
+toc: function (toclevels) {
+
+  function getText(el) {
+    var text = "";
+    for (var i = el.firstChild; i != null; i = i.nextSibling) {
+      if (i.nodeType == 3 /* Node.TEXT_NODE */) // IE doesn't speak constants.
+        text += i.data;
+      else if (i.firstChild != null)
+        text += getText(i);
+    }
+    return text;
+  }
+
+  function TocEntry(el, text, toclevel) {
+    this.element = el;
+    this.text = text;
+    this.toclevel = toclevel;
+  }
+
+  function tocEntries(el, toclevels) {
+    var result = new Array;
+    var re = new RegExp('[hH]([1-'+(toclevels+1)+'])');
+    // Function that scans the DOM tree for header elements (the DOM2
+    // nodeIterator API would be a better technique but not supported by all
+    // browsers).
+    var iterate = function (el) {
+      for (var i = el.firstChild; i != null; i = i.nextSibling) {
+        if (i.nodeType == 1 /* Node.ELEMENT_NODE */) {
+          var mo = re.exec(i.tagName);
+          if (mo && (i.getAttribute("class") || i.getAttribute("className")) != "float") {
+            result[result.length] = new TocEntry(i, getText(i), mo[1]-1);
+          }
+          iterate(i);
+        }
+      }
+    }
+    iterate(el);
+    return result;
+  }
+
+  var toc = document.getElementById("toc");
+  if (!toc) {
+    return;
+  }
+
+  // Delete existing TOC entries in case we're reloading the TOC.
+  var tocEntriesToRemove = [];
+  var i;
+  for (i = 0; i < toc.childNodes.length; i++) {
+    var entry = toc.childNodes[i];
+    if (entry.nodeName.toLowerCase() == 'div'
+     && entry.getAttribute("class")
+     && entry.getAttribute("class").match(/^toclevel/))
+      tocEntriesToRemove.push(entry);
+  }
+  for (i = 0; i < tocEntriesToRemove.length; i++) {
+    toc.removeChild(tocEntriesToRemove[i]);
+  }
+
+  // Rebuild TOC entries.
+  var entries = tocEntries(document.getElementById("content"), toclevels);
+  for (var i = 0; i < entries.length; ++i) {
+    var entry = entries[i];
+    if (entry.element.id == "")
+      entry.element.id = "_toc_" + i;
+    var a = document.createElement("a");
+    a.href = "#" + entry.element.id;
+    a.appendChild(document.createTextNode(entry.text));
+    var div = document.createElement("div");
+    div.appendChild(a);
+    div.className = "toclevel" + entry.toclevel;
+    toc.appendChild(div);
+  }
+  if (entries.length == 0)
+    toc.parentNode.removeChild(toc);
+},
+
+
+/////////////////////////////////////////////////////////////////////
+// Footnotes generator
+/////////////////////////////////////////////////////////////////////
+
+/* Based on footnote generation code from:
+ * http://www.brandspankingnew.net/archive/2005/07/format_footnote.html
+ */
+
+footnotes: function () {
+  // Delete existing footnote entries in case we're reloading the footnodes.
+  var i;
+  var noteholder = document.getElementById("footnotes");
+  if (!noteholder) {
+    return;
+  }
+  var entriesToRemove = [];
+  for (i = 0; i < noteholder.childNodes.length; i++) {
+    var entry = noteholder.childNodes[i];
+    if (entry.nodeName.toLowerCase() == 'div' && entry.getAttribute("class") == "footnote")
+      entriesToRemove.push(entry);
+  }
+  for (i = 0; i < entriesToRemove.length; i++) {
+    noteholder.removeChild(entriesToRemove[i]);
+  }
+
+  // Rebuild footnote entries.
+  var cont = document.getElementById("content");
+  var spans = cont.getElementsByTagName("span");
+  var refs = {};
+  var n = 0;
+  for (i=0; i<spans.length; i++) {
+    if (spans[i].className == "footnote") {
+      n++;
+      var note = spans[i].getAttribute("data-note");
+      if (!note) {
+        // Use [\s\S] in place of . so multi-line matches work.
+        // Because JavaScript has no s (dotall) regex flag.
+        note = spans[i].innerHTML.match(/\s*\[([\s\S]*)]\s*/)[1];
+        spans[i].innerHTML =
+          "[<a id='_footnoteref_" + n + "' href='#_footnote_" + n +
+          "' title='View footnote' class='footnote'>" + n + "</a>]";
+        spans[i].setAttribute("data-note", note);
+      }
+      noteholder.innerHTML +=
+        "<div class='footnote' id='_footnote_" + n + "'>" +
+        "<a href='#_footnoteref_" + n + "' title='Return to text'>" +
+        n + "</a>. " + note + "</div>";
+      var id =spans[i].getAttribute("id");
+      if (id != null) refs["#"+id] = n;
+    }
+  }
+  if (n == 0)
+    noteholder.parentNode.removeChild(noteholder);
+  else {
+    // Process footnoterefs.
+    for (i=0; i<spans.length; i++) {
+      if (spans[i].className == "footnoteref") {
+        var href = spans[i].getElementsByTagName("a")[0].getAttribute("href");
+        href = href.match(/#.*/)[0];  // Because IE return full URL.
+        n = refs[href];
+        spans[i].innerHTML =
+          "[<a href='#_footnote_" + n +
+          "' title='View footnote' class='footnote'>" + n + "</a>]";
+      }
+    }
+  }
+},
+
+install: function(toclevels) {
+  var timerId;
+
+  function reinstall() {
+    asciidoc.footnotes();
+    if (toclevels) {
+      asciidoc.toc(toclevels);
+    }
+  }
+
+  function reinstallAndRemoveTimer() {
+    clearInterval(timerId);
+    reinstall();
+  }
+
+  timerId = setInterval(reinstall, 500);
+  if (document.addEventListener)
+    document.addEventListener("DOMContentLoaded", reinstallAndRemoveTimer, false);
+  else
+    window.onload = reinstallAndRemoveTimer;
+}
+
+}
+asciidoc.install();
+/*]]>*/
+</script>
+</head>
+<body class="manpage">
+<div id="header">
+<h1>
+nvme-huawei-list(1) Manual Page
+</h1>
+<h2>NAME</h2>
+<div class="sectionbody">
+<p>nvme-huawei-list -
+   List all recognized Huawei NVMe devices
+</p>
+</div>
+</div>
+<div id="content">
+<div class="sect1">
+<h2 id="_synopsis">SYNOPSIS</h2>
+<div class="sectionbody">
+<div class="verseblock">
+<pre class="content"><em>nvme huawei list</em> [-o &lt;fmt&gt; | --output-format=&lt;fmt&gt;]</pre>
+<div class="attribution">
+</div></div>
+</div>
+</div>
+<div class="sect1">
+<h2 id="_description">DESCRIPTION</h2>
+<div class="sectionbody">
+<div class="paragraph"><p>Scan the sysfs tree for NVM Express devices and return the /dev node
+for those Huawei devices as well as some pertinent information about them.</p></div>
+</div>
+</div>
+<div class="sect1">
+<h2 id="_options">OPTIONS</h2>
+<div class="sectionbody">
+<div class="dlist"><dl>
+<dt class="hdlist1">
+-o &lt;format&gt;
+</dt>
+<dt class="hdlist1">
+--output-format=&lt;format&gt;
+</dt>
+<dd>
+<p>
+        Set the reporting format to <em>normal</em> or <em>json</em>. Only one output
+        format can be used at a time.
+</p>
+</dd>
+</dl></div>
+</div>
+</div>
+<div class="sect1">
+<h2 id="_examples">EXAMPLES</h2>
+<div class="sectionbody">
+<div class="paragraph"><p>No examples yet.</p></div>
+</div>
+</div>
+<div class="sect1">
+<h2 id="_nvme">NVME</h2>
+<div class="sectionbody">
+<div class="paragraph"><p>Part of the nvme-user suite</p></div>
+</div>
+</div>
+</div>
+<div id="footnotes"><hr /></div>
+<div id="footer">
+<div id="footer-text">
+Last updated 2017-04-25 14:28:53 MDT
+</div>
+</div>
+</body>
+</html>
diff --git a/Documentation/nvme-huawei-list.txt b/Documentation/nvme-huawei-list.txt
new file mode 100644
index 0000000..65a6c21
--- /dev/null
+++ b/Documentation/nvme-huawei-list.txt
@@ -0,0 +1,31 @@
+nvme-list(1)
+============
+
+NAME
+----
+nvme-huawei-list - List all recognized Huawei NVMe devices
+
+SYNOPSIS
+--------
+[verse]
+'nvme huawei list' [-o <fmt> | --output-format=<fmt>]
+
+DESCRIPTION
+-----------
+Scan the sysfs tree for NVM Express devices and return the /dev node
+for those Huawei devices as well as some pertinent information about them.
+
+OPTIONS
+-------
+-o <format>::
+--output-format=<format>::
+	Set the reporting format to 'normal' or 'json'. Only one output
+	format can be used at a time.
+
+EXAMPLES
+--------
+No examples yet.
+
+NVME
+----
+Part of the nvme-user suite
diff --git a/Makefile b/Makefile
index 414c039..3f1d9aa 100644
--- a/Makefile
+++ b/Makefile
@@ -33,7 +33,7 @@ NVME_DPKG_VERSION=1~`lsb_release -sc`
 
 OBJS := argconfig.o suffix.o parser.o nvme-print.o nvme-ioctl.o \
 	nvme-lightnvm.o fabrics.o json.o plugin.o intel-nvme.o \
-	lnvm-nvme.o memblaze-nvme.o wdc-nvme.o nvme-models.o
+	lnvm-nvme.o memblaze-nvme.o wdc-nvme.o nvme-models.o huawei-nvme.o
 
 nvme: nvme.c nvme.h $(OBJS) NVME-VERSION-FILE
 	$(CC) $(CPPFLAGS) $(CFLAGS) nvme.c -o $(NVME) $(OBJS) $(LDFLAGS)
diff --git a/huawei-nvme.c b/huawei-nvme.c
new file mode 100644
index 0000000..8310798
--- /dev/null
+++ b/huawei-nvme.c
@@ -0,0 +1,382 @@
+/*
+ * Copyright (c) 2017-2019 Huawei Corporation or its affiliates.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ *   Author:  Zou Ming<zouming.zouming at huawei.com>,
+ *				Yang Feng <philip.yang at huawei.com>
+ */
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <inttypes.h>
+#include <errno.h>
+#include <limits.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <dirent.h>
+
+#include <sys/stat.h>
+
+#include "linux/nvme_ioctl.h"
+
+#include "nvme.h"
+#include "nvme-print.h"
+#include "nvme-ioctl.h"
+#include "plugin.h"
+#include "json.h"
+
+#include "argconfig.h"
+#include "suffix.h"
+#include <sys/ioctl.h>
+#define CREATE_CMD
+#include "huawei-nvme.h"
+
+#define ARRAY_NAME_LEN 80
+#define NS_NAME_LEN    40
+
+#define MIN_ARRAY_NAME_LEN 16
+#define MIN_NS_NAME_LEN 16
+
+struct huawei_list_item {
+	char                node[1024];
+	struct nvme_id_ctrl ctrl;
+	int                 nsid;
+	struct nvme_id_ns   ns;
+	unsigned            block;
+	char                ns_name[NS_NAME_LEN];
+	char                array_name[ARRAY_NAME_LEN];
+	bool                huawei_device; 
+};
+
+struct huawei_list_element_len {
+	unsigned int node;
+	unsigned int ns_name;
+	unsigned int nguid;
+	unsigned int ns_id;
+	unsigned int useage;
+	unsigned int array_name;
+};   
+
+static const char *dev = "/dev/";
+
+/* Assume every block device starting with /dev/nvme is an nvme namespace */
+static int huawei_scan_dev_filter(const struct dirent *d)
+{
+	char path[256];
+	struct stat bd;
+	int ctrl, ns, part;
+
+	if (d->d_name[0] == '.')
+		return 0;
+
+	if (strstr(d->d_name, "nvme")) {
+		snprintf(path, sizeof(path), "%s%s", dev, d->d_name);
+		if (stat(path, &bd))
+			return 0;
+		if (!S_ISBLK(bd.st_mode))
+			return 0;
+		if (sscanf(d->d_name, "nvme%dn%dp%d", &ctrl, &ns, &part) == 3)
+			return 0;
+		return 1;
+	}
+	return 0;
+}
+
+static int huawei_get_nvme_info(int fd, struct huawei_list_item *item, const char *node)
+{
+	int err;
+	int len;
+	struct stat nvme_stat_info;
+
+	memset(item, 0, sizeof(*item));
+	
+	err = nvme_identify_ctrl(fd, &item->ctrl);
+	if (err)
+		return err;
+	
+	/*identify huawei device*/
+	if (strstr(item->ctrl.mn, "Huawei") == NULL) {
+		item->huawei_device = false;
+		return 0;
+	}
+	else 
+		item->huawei_device = true;
+	
+	item->nsid = nvme_get_nsid(fd);
+	err = nvme_identify_ns(fd, item->nsid,
+							0, &item->ns);
+	if (err)
+		return err;
+	
+	err = fstat(fd, &nvme_stat_info);
+	if (err < 0)
+		return err;
+	
+	strcpy(item->node, node);
+	item->block = S_ISBLK(nvme_stat_info.st_mode);
+	
+	if (item->ns.vs[0] == 0) {
+		
+		len = snprintf(item->ns_name, NS_NAME_LEN, "%s", "----");
+		if (len < 0)
+			return -EINVAL;    
+	}
+	else {
+		memcpy(item->ns_name, item->ns.vs, NS_NAME_LEN);
+		item->ns_name[NS_NAME_LEN - 1] = '\0';
+	}   
+
+	if (item->ctrl.vs[0] == 0) {
+		
+		len = snprintf(item->array_name, ARRAY_NAME_LEN, "%s", "----");
+	if (len < 0)
+			return -EINVAL;    
+	}
+	else {
+		memcpy(item->array_name, item->ctrl.vs, ARRAY_NAME_LEN);
+		item->array_name[ARRAY_NAME_LEN - 1] = '\0';
+	}
+	return 0;
+}
+
+static void format(char *formatter, size_t fmt_sz, char *tofmt, size_t tofmtsz)
+{
+
+	fmt_sz = snprintf(formatter,fmt_sz, "%-*.*s",
+		 (int)tofmtsz, (int)tofmtsz, tofmt);
+	/* trim() the obnoxious trailing white lines */
+	while (fmt_sz) {
+		if (formatter[fmt_sz - 1] != ' ' && formatter[fmt_sz - 1] != '\0') {
+			formatter[fmt_sz] = '\0';
+			break;
+		}
+		fmt_sz--;
+	}
+}
+
+void huawei_json_print_list_items(struct huawei_list_item *list_items, unsigned len)
+{
+	struct json_object *root;
+	struct json_array *devices;
+	struct json_object *device_attrs;
+	char formatter[128] = { 0 };
+	int index, i = 0;
+
+	root = json_create_object();
+	devices = json_create_array();
+	for (i = 0; i < len; i++) {
+		device_attrs = json_create_object();
+
+		json_object_add_value_string(device_attrs,
+						 "DevicePath",
+						 list_items[i].node);
+
+		if (sscanf(list_items[i].node, "/dev/nvme%d", &index) == 1)
+			json_object_add_value_int(device_attrs,
+						  "Index",
+						  index);
+
+		format(formatter, sizeof(formatter),
+		       list_items[i].ns_name,
+		       sizeof(list_items[i].ns_name));
+
+		json_object_add_value_string(device_attrs,
+						 "NS Name",
+						 formatter);
+
+		format(formatter, sizeof(formatter),
+		       list_items[i].array_name,
+		       sizeof(list_items[i].array_name));
+
+		json_object_add_value_string(device_attrs,
+					     "Array Name",
+					     formatter);
+
+		json_array_add_value_object(devices, device_attrs);
+	}
+	json_object_add_value_array(root, "Devices", devices);
+	json_print_object(root, NULL);
+    printf("\n");
+	json_free_object(root);
+}
+
+static void huawei_print_list_head(struct huawei_list_element_len element_len)
+{
+	char dash[128];
+	int i;
+
+	for (i = 0; i < 128; i++)
+		dash[i] = '-';
+	dash[127] = '\0';
+	
+	printf("%-*.*s %-*.*s %-*.*s %-*.*s %-*.*s %-*.*s\n",
+		element_len.node, element_len.node, "Node", 
+		element_len.ns_name, element_len.ns_name, "NS Name", 
+		element_len.nguid, element_len.nguid, "Nguid", 
+		element_len.ns_id, element_len.ns_id, "NS ID", 
+		element_len.useage, element_len.useage, "Usage", 
+		element_len.array_name, element_len.array_name, "Array Name");
+    
+	printf("%-.*s %-.*s %-.*s %-.*s %-.*s %-.*s\n",
+		element_len.node, dash, element_len.ns_name, dash, 
+		element_len.nguid, dash, element_len.ns_id, dash, 
+		element_len.useage, dash, element_len.array_name, dash);
+}
+
+static void huawei_print_list_item(struct huawei_list_item list_item, 
+									struct huawei_list_element_len element_len)
+{
+	long long int lba = 1 << list_item.ns.lbaf[(list_item.ns.flbas & 0x0f)].ds;
+	double nsze       = le64_to_cpu(list_item.ns.nsze) * lba;
+	double nuse       = le64_to_cpu(list_item.ns.nuse) * lba;
+
+	const char *s_suffix = suffix_si_get(&nsze);
+	const char *u_suffix = suffix_si_get(&nuse);
+
+	char usage[128];
+	char nguid_buf[2 * sizeof(list_item.ns.nguid) + 1];
+	char *nguid = nguid_buf;
+	
+	sprintf(usage,"%6.2f %2sB / %6.2f %2sB", nuse, u_suffix,
+		nsze, s_suffix);
+
+	memset(nguid, 0, sizeof(nguid_buf));
+	for (int i = 0; i < sizeof(list_item.ns.nguid); i++)
+		nguid += sprintf(nguid, "%02x", list_item.ns.nguid[i]);
+
+	printf("%-*.*s %-*.*s %-*.*s %-*d %-*.*s %-*.*s\n",
+		element_len.node, element_len.node, list_item.node, 
+		element_len.ns_name, element_len.ns_name, list_item.ns_name, 
+		element_len.nguid, element_len.nguid, nguid_buf, 
+		element_len.ns_id, list_item.nsid, 
+		element_len.useage, element_len.useage, usage, 
+		element_len.array_name, element_len.array_name, list_item.array_name);
+	
+}
+
+static unsigned int choose_len(unsigned int old_len, unsigned int cur_len, unsigned int default_len)
+{
+	unsigned int temp_len;
+	
+	temp_len = (cur_len > default_len) ? cur_len : default_len;
+	if (temp_len > old_len)
+	{
+		return temp_len;
+	}   
+	return old_len;
+}
+
+static unsigned int huawei_get_ns_len(struct huawei_list_item *list_items, unsigned len, unsigned default_len)
+{
+	int i;
+	unsigned int min_len = default_len;
+	
+	for (i = 0 ; i < len ; i++)
+		min_len = choose_len(min_len , strlen(list_items->ns_name), default_len);
+
+	return min_len;
+}
+
+static int huawei_get_array_len(struct huawei_list_item *list_items, unsigned len, unsigned default_len)
+{
+	int i;
+	int min_len = default_len;
+	
+	for (i = 0 ; i < len ; i++)
+		min_len = choose_len(min_len , strlen(list_items->array_name), default_len);
+
+	return min_len;
+}
+
+static void huawei_print_list_items(struct huawei_list_item *list_items, unsigned len)
+{
+	unsigned i;
+	struct huawei_list_element_len element_len;
+
+	element_len.node = 16;
+	element_len.nguid = 2 * sizeof(list_items->ns.nguid) + 1;
+	element_len.ns_id = 9;
+	element_len.useage = 26;
+	element_len.ns_name = huawei_get_ns_len(list_items, len, MIN_NS_NAME_LEN);
+	element_len.array_name = huawei_get_array_len(list_items, len, MIN_ARRAY_NAME_LEN);
+
+	huawei_print_list_head(element_len);
+	
+	for (i = 0 ; i < len ; i++)
+		huawei_print_list_item(list_items[i], element_len);    
+}
+
+static int huawei_list(int argc, char **argv, struct command *command,
+		struct plugin *plugin)
+{
+	char path[256];
+	struct dirent **devices;
+	struct huawei_list_item *list_items;
+	unsigned int i, n, fd, ret;
+    unsigned int huawei_num = 0;
+	int fmt;
+	const char *desc = "Retrieve basic information for the given huawei device";
+	struct config {
+		char *output_format;
+	};
+
+	struct config cfg = {
+		.output_format = "normal",
+	};
+
+	const struct argconfig_commandline_options opts[] = {
+		{"output-format", 'o', "FMT", CFG_STRING, &cfg.output_format, required_argument, "Output Format: normal|json"},
+		{NULL}
+	};
+
+	argconfig_parse(argc, argv, desc, opts, &cfg, sizeof(cfg));
+	fmt = validate_output_format(cfg.output_format);
+
+	if (fmt != JSON && fmt != NORMAL)
+		return -EINVAL;
+
+	n = scandir(dev, &devices, huawei_scan_dev_filter, alphasort);
+	if (n <= 0)
+		return n;
+
+	list_items = calloc(n, sizeof(*list_items));
+	if (!list_items) {
+		fprintf(stderr, "can not allocate controller list payload\n");
+		return ENOMEM;
+	}
+
+	for (i = 0; i < n; i++) {
+		snprintf(path, sizeof(path), "%s%s", dev, devices[i]->d_name);
+		fd = open(path, O_RDONLY);
+		ret = huawei_get_nvme_info(fd, &list_items[huawei_num], path);
+		if (ret)
+			return ret;
+		if (list_items[huawei_num].huawei_device == true) {
+			huawei_num++;
+		}
+	}
+
+	if (huawei_num > 0){
+		if (fmt == JSON)
+			huawei_json_print_list_items(list_items, huawei_num);
+		else
+			huawei_print_list_items(list_items, huawei_num);
+	}
+
+	for (i = 0; i < n; i++)
+		free(devices[i]);
+	free(devices);
+	free(list_items);
+
+	return 0;
+}
+
diff --git a/huawei-nvme.h b/huawei-nvme.h
new file mode 100644
index 0000000..856a303
--- /dev/null
+++ b/huawei-nvme.h
@@ -0,0 +1,17 @@
+#undef CMD_INC_FILE
+#define CMD_INC_FILE huawei-nvme
+
+#if !defined(HUAWEI_NVME) || defined(CMD_HEADER_MULTI_READ)
+#define HUAWEI_NVME
+
+#include "cmd.h"
+
+PLUGIN(NAME("huawei", "Huawei vendor specific extensions"),
+	COMMAND_LIST(
+		ENTRY("list", "List all Huawei NVMe devices and namespaces on machine", huawei_list)
+	)
+);
+
+#endif
+
+#include "define_cmd.h"
-- 
2.6.4.windows.1
