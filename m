From: zouming.zouming@huawei.com (Zou Ming)
Date: Fri, 16 Jun 2017 07:12:52 +0000
Subject: [PATCH] nvme-cli: add id-ctrl for nvme-huawei plug-in.
Message-ID: <1497597172-13576-1-git-send-email-zouming.zouming@huawei.com>

From: Zou <zouming.zouming@huawei.com>

add  Vendor unique command id-ctrl for Huawei devices.
Signed-off-by: Zou Ming <zouming.zouming at huawei.com>
---
 Documentation/nvme-huawei-id-ctrl.1    |  97 ++++
 Documentation/nvme-huawei-id-ctrl.html | 860 +++++++++++++++++++++++++++++++++
 Documentation/nvme-huawei-id-ctrl.txt  |  66 +++
 huawei-nvme.c                          |  15 +
 huawei-nvme.h                          |   1 +
 5 files changed, 1039 insertions(+)
 create mode 100644 Documentation/nvme-huawei-id-ctrl.1
 create mode 100644 Documentation/nvme-huawei-id-ctrl.html
 create mode 100644 Documentation/nvme-huawei-id-ctrl.txt

diff --git a/Documentation/nvme-huawei-id-ctrl.1 b/Documentation/nvme-huawei-id-ctrl.1
new file mode 100644
index 0000000..95b8a2b
--- /dev/null
+++ b/Documentation/nvme-huawei-id-ctrl.1
@@ -0,0 +1,97 @@
+'\" t
+.\"     Title: nvme-huawei-id-ctrl
+.\"    Author: [FIXME: author] [see http://docbook.sf.net/el/author]
+.\" Generator: DocBook XSL Stylesheets v1.78.1 <http://docbook.sf.net/>
+.\"      Date: 06/15/2017
+.\"    Manual: NVMe Manual
+.\"    Source: NVMe
+.\"  Language: English
+.\"
+.TH "NVME\-HUAWEI\-ID\-CTRL" "1" "06/15/2017" "NVMe" "NVMe Manual"
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
+nvme-huawei-id-ctrl \- Send NVMe Identify Controller, return result and structure
+.SH "SYNOPSIS"
+.sp
+.nf
+\fInvme huawei id\-ctrl\fR <device> [\-v | \-\-vendor\-specific] [\-b | \-\-raw\-binary]
+                        [\-o <fmt> | \-\-output\-format=<fmt>]
+.fi
+.SH "DESCRIPTION"
+.sp
+For the NVMe device given, sends an identify controller command and provides the result and returned structure\&.
+.sp
+The <device> parameter is mandatory and may be either the NVMe character device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1)\&.
+.sp
+This will only work on Huawei devices supporting this feature\&. Results for any other device are undefined\&.
+.sp
+On success, the structure may be returned in one of several ways depending on the option flags; the structure may be parsed by the program or the raw buffer may be printed to stdout\&.
+.sp
+If having the program decode the output for readability, this version will decode Huawei vendor unique portions of the structure\&.
+.SH "OPTIONS"
+.PP
+\-b, \-\-raw\-binary
+.RS 4
+Print the raw buffer to stdout\&. Structure is not parsed by program\&. This overrides the vendor specific and human readable options\&.
+.RE
+.PP
+\-v, \-\-vendor\-specific
+.RS 4
+In addition to parsing known fields, this option will dump the vendor specific region of the structure in hex with ascii interpretation\&.
+.RE
+.PP
+\-H, \-\-human\-readable
+.RS 4
+This option will parse and format many of the bit fields into human\-readable formats\&.
+.RE
+.PP
+\-o <format>, \-\-output\-format=<format>
+.RS 4
+Set the reporting format to
+\fInormal\fR,
+\fIjson\fR, or
+\fIbinary\fR\&. Only one output format can be used at a time\&.
+.RE
+.SH "EXAMPLES"
+.sp
+.RS 4
+.ie n \{\
+\h'-04'\(bu\h'+03'\c
+.\}
+.el \{\
+.sp -1
+.IP \(bu 2.3
+.\}
+Has the program interpret the returned buffer and display the known fields in a human readable format:
+.sp
+.if n \{\
+.RS 4
+.\}
+.nf
+# nvme huawei id\-ctrl /dev/nvme0
+.fi
+.if n \{\
+.RE
+.\}
+.RE
+.SH "NVME"
+.sp
+Part of the nvme\-user suite
diff --git a/Documentation/nvme-huawei-id-ctrl.html b/Documentation/nvme-huawei-id-ctrl.html
new file mode 100644
index 0000000..602c596
--- /dev/null
+++ b/Documentation/nvme-huawei-id-ctrl.html
@@ -0,0 +1,860 @@
+<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
+    "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
+<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
+<head>
+<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
+<meta name="generator" content="AsciiDoc 8.6.9" />
+<title>nvme-huawei-id-ctrl(1)</title>
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
+.monospaced, code, pre {
+  font-family: "Courier New", Courier, monospace;
+  font-size: inherit;
+  color: navy;
+  padding: 0;
+  margin: 0;
+}
+pre {
+  white-space: pre-wrap;
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
+span.image img { border-style: none; vertical-align: text-bottom; }
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
+
+
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
+nvme-huawei-id-ctrl(1) Manual Page
+</h1>
+<h2>NAME</h2>
+<div class="sectionbody">
+<p>nvme-huawei-id-ctrl -
+   Send NVMe Identify Controller, return result and structure
+</p>
+</div>
+</div>
+<div id="content">
+<div class="sect1">
+<h2 id="_synopsis">SYNOPSIS</h2>
+<div class="sectionbody">
+<div class="verseblock">
+<pre class="content"><em>nvme huawei id-ctrl</em> &lt;device&gt; [-v | --vendor-specific] [-b | --raw-binary]
+                        [-o &lt;fmt&gt; | --output-format=&lt;fmt&gt;]</pre>
+<div class="attribution">
+</div></div>
+</div>
+</div>
+<div class="sect1">
+<h2 id="_description">DESCRIPTION</h2>
+<div class="sectionbody">
+<div class="paragraph"><p>For the NVMe device given, sends an identify controller command and
+provides the result and returned structure.</p></div>
+<div class="paragraph"><p>The &lt;device&gt; parameter is mandatory and may be either the NVMe character
+device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1).</p></div>
+<div class="paragraph"><p>This will only work on Huawei devices supporting this feature.
+Results for any other device are undefined.</p></div>
+<div class="paragraph"><p>On success, the structure may be returned in one of several ways depending
+on the option flags; the structure may be parsed by the program or the
+raw buffer may be printed to stdout.</p></div>
+<div class="paragraph"><p>If having the program decode the output for readability, this version
+will decode Huawei vendor unique portions of the structure.</p></div>
+</div>
+</div>
+<div class="sect1">
+<h2 id="_options">OPTIONS</h2>
+<div class="sectionbody">
+<div class="dlist"><dl>
+<dt class="hdlist1">
+-b
+</dt>
+<dt class="hdlist1">
+--raw-binary
+</dt>
+<dd>
+<p>
+        Print the raw buffer to stdout. Structure is not parsed by
+        program. This overrides the vendor specific and human readable options.
+</p>
+</dd>
+<dt class="hdlist1">
+-v
+</dt>
+<dt class="hdlist1">
+--vendor-specific
+</dt>
+<dd>
+<p>
+        In addition to parsing known fields, this option will dump
+        the vendor specific region of the structure in hex with ascii
+        interpretation.
+</p>
+</dd>
+<dt class="hdlist1">
+-H
+</dt>
+<dt class="hdlist1">
+--human-readable
+</dt>
+<dd>
+<p>
+        This option will parse and format many of the bit fields
+        into human-readable formats.
+</p>
+</dd>
+<dt class="hdlist1">
+-o &lt;format&gt;
+</dt>
+<dt class="hdlist1">
+--output-format=&lt;format&gt;
+</dt>
+<dd>
+<p>
+              Set the reporting format to <em>normal</em>, <em>json</em>, or
+              <em>binary</em>. Only one output format can be used at a time.
+</p>
+</dd>
+</dl></div>
+</div>
+</div>
+<div class="sect1">
+<h2 id="_examples">EXAMPLES</h2>
+<div class="sectionbody">
+<div class="ulist"><ul>
+<li>
+<p>
+Has the program interpret the returned buffer and display the known
+fields in a human readable format:
+</p>
+<div class="listingblock">
+<div class="content">
+<pre><code># nvme huawei id-ctrl /dev/nvme0</code></pre>
+</div></div>
+</li>
+</ul></div>
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
+Last updated 2017-06-15 18:09:35 PST
+</div>
+</div>
+</body>
+</html>
diff --git a/Documentation/nvme-huawei-id-ctrl.txt b/Documentation/nvme-huawei-id-ctrl.txt
new file mode 100644
index 0000000..f2b2c05
--- /dev/null
+++ b/Documentation/nvme-huawei-id-ctrl.txt
@@ -0,0 +1,66 @@
+nvme-huawei-id-ctrl(1)
+=====================
+
+NAME
+----
+nvme-huawei-id-ctrl - Send NVMe Identify Controller, return result and structure
+
+SYNOPSIS
+--------
+[verse]
+'nvme huawei id-ctrl' <device> [-v | --vendor-specific] [-b | --raw-binary]
+			[-o <fmt> | --output-format=<fmt>]
+
+DESCRIPTION
+-----------
+For the NVMe device given, sends an identify controller command and
+provides the result and returned structure.
+
+The <device> parameter is mandatory and may be either the NVMe character
+device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1).
+
+This will only work on Huawei devices supporting this feature.
+Results for any other device are undefined.
+
+On success, the structure may be returned in one of several ways depending
+on the option flags; the structure may be parsed by the program or the
+raw buffer may be printed to stdout.
+
+If having the program decode the output for readability, this version
+will decode Huawei vendor unique portions of the structure.
+
+OPTIONS
+-------
+-b::
+--raw-binary::
+	Print the raw buffer to stdout. Structure is not parsed by
+	program. This overrides the vendor specific and human readable options.
+
+-v::
+--vendor-specific::
+	In addition to parsing known fields, this option will dump
+	the vendor specific region of the structure in hex with ascii
+	interpretation.
+
+-H::
+--human-readable::
+	This option will parse and format many of the bit fields
+	into human-readable formats.
+
+-o <format>::
+--output-format=<format>::
+              Set the reporting format to 'normal', 'json', or
+              'binary'. Only one output format can be used at a time.
+
+EXAMPLES
+--------
+* Has the program interpret the returned buffer and display the known
+fields in a human readable format:
++
+------------
+# nvme huawei id-ctrl /dev/nvme0
+------------
+
+NVME
+----
+Part of the nvme-user suite
diff --git a/huawei-nvme.c b/huawei-nvme.c
index f941533..f305405 100644
--- a/huawei-nvme.c
+++ b/huawei-nvme.c
@@ -380,3 +380,18 @@ static int huawei_list(int argc, char **argv, struct command *command,
 	return 0;
 }
 
+static void huawei_do_id_ctrl(__u8 *vs, struct json_object *root)
+{
+	char array_name[ARRAY_NAME_LEN + 1] = {0};
+
+	memcpy(array_name, vs, ARRAY_NAME_LEN);
+	if (root)
+		json_object_add_value_string(root, "array name", strlen(array_name) > 1 ? array_name : "NULL");
+	else
+		printf("array name : %s\n", strlen(array_name) > 1 ? array_name : "NULL");
+}
+
+static int huawei_id_ctrl(int argc, char **argv, struct command *cmd, struct plugin *plugin)
+{
+	return __id_ctrl(argc, argv, cmd, plugin, huawei_do_id_ctrl);
+}
diff --git a/huawei-nvme.h b/huawei-nvme.h
index 856a303..91e8dfb 100644
--- a/huawei-nvme.h
+++ b/huawei-nvme.h
@@ -9,6 +9,7 @@
 PLUGIN(NAME("huawei", "Huawei vendor specific extensions"),
 	COMMAND_LIST(
 		ENTRY("list", "List all Huawei NVMe devices and namespaces on machine", huawei_list)
+		ENTRY("id-ctrl", "Huawei identify controller", huawei_id_ctrl)
 	)
 );
 
-- 
1.8.5.2
