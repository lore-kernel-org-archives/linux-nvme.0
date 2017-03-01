From: chaitanya.kulkarni@hgst.com (Chaitanya Kulkarni)
Date: Tue, 28 Feb 2017 18:14:10 -0800
Subject: [PATCH 4/4] nvme-cli: Western Digital/HGST plug-in documentation.
In-Reply-To: <1488334450-13952-1-git-send-email-chaitanya.kulkarni@hgst.com>
References: <1488334450-13952-1-git-send-email-chaitanya.kulkarni@hgst.com>
Message-ID: <1488334450-13952-5-git-send-email-chaitanya.kulkarni@hgst.com>

This patch adds documentation for the commands present in
Western Digital/HGST plug-in.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
---
 Documentation/nvme-wdc-cap-diag.1          |  116 ++++
 Documentation/nvme-wdc-cap-diag.html       |  832 ++++++++++++++++++++++
 Documentation/nvme-wdc-cap-diag.txt        |   50 ++
 Documentation/nvme-wdc-drive-log.1         |  116 ++++
 Documentation/nvme-wdc-drive-log.html      |  834 ++++++++++++++++++++++
 Documentation/nvme-wdc-drive-log.txt       |   52 ++
 Documentation/nvme-wdc-get-crash-dump.1    |  116 ++++
 Documentation/nvme-wdc-get-crash-dump.html |  835 ++++++++++++++++++++++
 Documentation/nvme-wdc-get-crash-dump.txt  |   52 ++
 Documentation/nvme-wdc-id-ctrl.1           |   97 +++
 Documentation/nvme-wdc-id-ctrl.html        |  860 +++++++++++++++++++++++
 Documentation/nvme-wdc-id-ctrl.txt         |   66 ++
 Documentation/nvme-wdc-purge-monitor.1     |  126 ++++
 Documentation/nvme-wdc-purge-monitor.html  |  842 +++++++++++++++++++++++
 Documentation/nvme-wdc-purge-monitor.txt   |   63 ++
 Documentation/nvme-wdc-purge.1             |   73 ++
 Documentation/nvme-wdc-purge.html          |  804 ++++++++++++++++++++++
 Documentation/nvme-wdc-purge.txt           |   40 ++
 Documentation/nvme-wdc-smart-log-add.1     |  348 ++++++++++
 Documentation/nvme-wdc-smart-log-add.html  | 1028 ++++++++++++++++++++++++++++
 Documentation/nvme-wdc-smart-log-add.txt   |  190 +++++
 21 files changed, 7540 insertions(+)
 create mode 100644 Documentation/nvme-wdc-cap-diag.1
 create mode 100644 Documentation/nvme-wdc-cap-diag.html
 create mode 100644 Documentation/nvme-wdc-cap-diag.txt
 create mode 100644 Documentation/nvme-wdc-drive-log.1
 create mode 100644 Documentation/nvme-wdc-drive-log.html
 create mode 100644 Documentation/nvme-wdc-drive-log.txt
 create mode 100644 Documentation/nvme-wdc-get-crash-dump.1
 create mode 100644 Documentation/nvme-wdc-get-crash-dump.html
 create mode 100644 Documentation/nvme-wdc-get-crash-dump.txt
 create mode 100644 Documentation/nvme-wdc-id-ctrl.1
 create mode 100644 Documentation/nvme-wdc-id-ctrl.html
 create mode 100644 Documentation/nvme-wdc-id-ctrl.txt
 create mode 100644 Documentation/nvme-wdc-purge-monitor.1
 create mode 100644 Documentation/nvme-wdc-purge-monitor.html
 create mode 100644 Documentation/nvme-wdc-purge-monitor.txt
 create mode 100644 Documentation/nvme-wdc-purge.1
 create mode 100644 Documentation/nvme-wdc-purge.html
 create mode 100644 Documentation/nvme-wdc-purge.txt
 create mode 100644 Documentation/nvme-wdc-smart-log-add.1
 create mode 100644 Documentation/nvme-wdc-smart-log-add.html
 create mode 100644 Documentation/nvme-wdc-smart-log-add.txt

diff --git a/Documentation/nvme-wdc-cap-diag.1 b/Documentation/nvme-wdc-cap-diag.1
new file mode 100644
index 0000000..f962c9c
--- /dev/null
+++ b/Documentation/nvme-wdc-cap-diag.1
@@ -0,0 +1,116 @@
+'\" t
+.\"     Title: nvme-wdc-cap-diag
+.\"    Author: [FIXME: author] [see http://docbook.sf.net/el/author]
+.\" Generator: DocBook XSL Stylesheets v1.78.1 <http://docbook.sf.net/>
+.\"      Date: 02/28/2017
+.\"    Manual: NVMe Manual
+.\"    Source: NVMe
+.\"  Language: English
+.\"
+.TH "NVME\-WDC\-CAP\-DIAG" "1" "02/28/2017" "NVMe" "NVMe Manual"
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
+nvme-wdc-cap-diag \- Retrieve WDC device\*(Aqs diagnostic log and save to file\&.
+.SH "SYNOPSIS"
+.sp
+.nf
+\fInvme wdc cap\-diag\fR <device> [\-\-output\-file=<FILE>, \-o <FILE>]
+.fi
+.SH "DESCRIPTION"
+.sp
+For the NVMe device given, sends the WDC Vendor Unique Capture\-Diagnostics request and saves the result to a file\&.
+.sp
+The <device> parameter is mandatory NVMe character device (ex: /dev/nvme0)\&.
+.sp
+This will only work on WDC devices supporting this feature\&. Results for any other device are undefined\&.
+.SH "OPTIONS"
+.PP
+\-o <FILE>, \-\-output\-file=<FILE>
+.RS 4
+Output file; defaults to device serial number followed by "cap_diag" suffix
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
+Gets the capture diagnostics log from the device and saves to default file in current directory (e\&.g\&. STM00019F3F9cap_diag\&.bin):
+.sp
+.if n \{\
+.RS 4
+.\}
+.nf
+# nvme wdc cap\-diag /dev/nvme0
+.fi
+.if n \{\
+.RE
+.\}
+.RE
+.sp
+.RS 4
+.ie n \{\
+\h'-04'\(bu\h'+03'\c
+.\}
+.el \{\
+.sp -1
+.IP \(bu 2.3
+.\}
+Gets the capture diagnostics log from the device and saves to defined file in current directory (e\&.g\&. testSTM00019F3F9cap_diag\&.bin):
+.sp
+.if n \{\
+.RS 4
+.\}
+.nf
+# nvme wdc cap\-diag /dev/nvme0 \-o test
+.fi
+.if n \{\
+.RE
+.\}
+.RE
+.sp
+.RS 4
+.ie n \{\
+\h'-04'\(bu\h'+03'\c
+.\}
+.el \{\
+.sp -1
+.IP \(bu 2.3
+.\}
+Gets the capture diagnostics log from the device and saves to defined file with pathname (e\&.g\&. /tmp/testSTM00019F3F9cap_diag\&.bin):
+.sp
+.if n \{\
+.RS 4
+.\}
+.nf
+# nvme wdc cap\-diag /dev/nvme0 \-o /tmp/test
+.fi
+.if n \{\
+.RE
+.\}
+.RE
+.SH "NVME"
+.sp
+Part of the nvme\-user suite\&.
diff --git a/Documentation/nvme-wdc-cap-diag.html b/Documentation/nvme-wdc-cap-diag.html
new file mode 100644
index 0000000..45c328a
--- /dev/null
+++ b/Documentation/nvme-wdc-cap-diag.html
@@ -0,0 +1,832 @@
+<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
+    "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
+<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
+<head>
+<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
+<meta name="generator" content="AsciiDoc 8.6.9" />
+<title>nvme-wdc-cap-diag(1)</title>
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
+nvme-wdc-cap-diag(1) Manual Page
+</h1>
+<h2>NAME</h2>
+<div class="sectionbody">
+<p>nvme-wdc-cap-diag -
+   Retrieve WDC device's diagnostic log and save to file.
+</p>
+</div>
+</div>
+<div id="content">
+<div class="sect1">
+<h2 id="_synopsis">SYNOPSIS</h2>
+<div class="sectionbody">
+<div class="verseblock">
+<pre class="content"><em>nvme wdc cap-diag</em> &lt;device&gt; [--output-file=&lt;FILE&gt;, -o &lt;FILE&gt;]</pre>
+<div class="attribution">
+</div></div>
+</div>
+</div>
+<div class="sect1">
+<h2 id="_description">DESCRIPTION</h2>
+<div class="sectionbody">
+<div class="paragraph"><p>For the NVMe device given, sends the WDC Vendor Unique Capture-Diagnostics
+request and saves the result to a file.</p></div>
+<div class="paragraph"><p>The &lt;device&gt; parameter is mandatory NVMe character device (ex: /dev/nvme0).</p></div>
+<div class="paragraph"><p>This will only work on WDC devices supporting this feature.
+Results for any other device are undefined.</p></div>
+</div>
+</div>
+<div class="sect1">
+<h2 id="_options">OPTIONS</h2>
+<div class="sectionbody">
+<div class="dlist"><dl>
+<dt class="hdlist1">
+-o &lt;FILE&gt;
+</dt>
+<dt class="hdlist1">
+--output-file=&lt;FILE&gt;
+</dt>
+<dd>
+<p>
+        Output file; defaults to device serial number followed by "cap_diag" suffix
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
+Gets the capture diagnostics log from the device and saves to default file in current directory (e.g. STM00019F3F9cap_diag.bin):
+</p>
+<div class="listingblock">
+<div class="content">
+<pre><code># nvme wdc cap-diag /dev/nvme0</code></pre>
+</div></div>
+</li>
+<li>
+<p>
+Gets the capture diagnostics log from the device and saves to defined file in current directory (e.g. testSTM00019F3F9cap_diag.bin):
+</p>
+<div class="listingblock">
+<div class="content">
+<pre><code># nvme wdc cap-diag /dev/nvme0 -o test</code></pre>
+</div></div>
+</li>
+<li>
+<p>
+Gets the capture diagnostics log from the device and saves to defined file with pathname (e.g. /tmp/testSTM00019F3F9cap_diag.bin):
+</p>
+<div class="listingblock">
+<div class="content">
+<pre><code># nvme wdc cap-diag /dev/nvme0 -o /tmp/test</code></pre>
+</div></div>
+</li>
+</ul></div>
+</div>
+</div>
+<div class="sect1">
+<h2 id="_nvme">NVME</h2>
+<div class="sectionbody">
+<div class="paragraph"><p>Part of the nvme-user suite.</p></div>
+</div>
+</div>
+</div>
+<div id="footnotes"><hr /></div>
+<div id="footer">
+<div id="footer-text">
+Last updated 2017-02-28 18:09:35 PST
+</div>
+</div>
+</body>
+</html>
diff --git a/Documentation/nvme-wdc-cap-diag.txt b/Documentation/nvme-wdc-cap-diag.txt
new file mode 100644
index 0000000..f9d232d
--- /dev/null
+++ b/Documentation/nvme-wdc-cap-diag.txt
@@ -0,0 +1,50 @@
+nvme-wdc-cap-diag(1)
+====================
+
+NAME
+----
+nvme-wdc-cap-diag - Retrieve WDC device's diagnostic log and save to file.
+
+SYNOPSIS
+--------
+[verse]
+'nvme wdc cap-diag' <device> [--output-file=<FILE>, -o <FILE>]
+
+DESCRIPTION
+-----------
+
+For the NVMe device given, sends the WDC Vendor Unique Capture-Diagnostics
+request and saves the result to a file.
+
+The <device> parameter is mandatory NVMe character device (ex: /dev/nvme0).
+
+This will only work on WDC devices supporting this feature.
+Results for any other device are undefined.
+
+OPTIONS
+-------
+-o <FILE>::
+--output-file=<FILE>::
+	Output file; defaults to device serial number followed by "cap_diag" suffix
+
+EXAMPLES
+--------
+* Gets the capture diagnostics log from the device and saves to default file in current directory (e.g. STM00019F3F9cap_diag.bin):
++
+------------
+# nvme wdc cap-diag /dev/nvme0
+------------
+* Gets the capture diagnostics log from the device and saves to defined file in current directory (e.g. testSTM00019F3F9cap_diag.bin):
++
+------------
+# nvme wdc cap-diag /dev/nvme0 -o test
+------------
+* Gets the capture diagnostics log from the device and saves to defined file with pathname (e.g. /tmp/testSTM00019F3F9cap_diag.bin):
++
+------------
+# nvme wdc cap-diag /dev/nvme0 -o /tmp/test
+------------
+
+NVME
+----
+Part of the nvme-user suite.
diff --git a/Documentation/nvme-wdc-drive-log.1 b/Documentation/nvme-wdc-drive-log.1
new file mode 100644
index 0000000..ff90989
--- /dev/null
+++ b/Documentation/nvme-wdc-drive-log.1
@@ -0,0 +1,116 @@
+'\" t
+.\"     Title: nvme-wdc-drive-log
+.\"    Author: [FIXME: author] [see http://docbook.sf.net/el/author]
+.\" Generator: DocBook XSL Stylesheets v1.78.1 <http://docbook.sf.net/>
+.\"      Date: 02/28/2017
+.\"    Manual: NVMe Manual
+.\"    Source: NVMe
+.\"  Language: English
+.\"
+.TH "NVME\-WDC\-DRIVE\-LO" "1" "02/28/2017" "NVMe" "NVMe Manual"
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
+nvme-wdc-drive-log \- Retrieve WDC device\*(Aqs drive log and save to file\&.
+.SH "SYNOPSIS"
+.sp
+.nf
+\fInvme wdc drive\-log\fR <device> [\-\-output\-file=<FILE>, \-o <FILE>]
+.fi
+.SH "DESCRIPTION"
+.sp
+For the NVMe device given, sends the wdc vendor unique drive log request and saves the result to a file\&.
+.sp
+The <device> parameter is mandatory and may be either the NVMe character device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1)\&.
+.sp
+This will only work on WDC devices supporting this feature\&. Results for any other device are undefined\&.
+.SH "OPTIONS"
+.PP
+\-o <FILE>, \-\-output\-file=<FILE>
+.RS 4
+Output file; defaults to device serial number followed by "drive_log" suffix
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
+Gets the drive log from the device and saves to default file in current directory (e\&.g\&. STM00019F3F9drive_log\&.bin):
+.sp
+.if n \{\
+.RS 4
+.\}
+.nf
+# nvme wdc drive\-log /dev/nvme0
+.fi
+.if n \{\
+.RE
+.\}
+.RE
+.sp
+.RS 4
+.ie n \{\
+\h'-04'\(bu\h'+03'\c
+.\}
+.el \{\
+.sp -1
+.IP \(bu 2.3
+.\}
+Gets the drive log from the device and saves to defined file in current directory (e\&.g\&. testSTM00019F3F9drive_log\&.bin):
+.sp
+.if n \{\
+.RS 4
+.\}
+.nf
+# nvme wdc drive\-log /dev/nvme0 \-o test
+.fi
+.if n \{\
+.RE
+.\}
+.RE
+.sp
+.RS 4
+.ie n \{\
+\h'-04'\(bu\h'+03'\c
+.\}
+.el \{\
+.sp -1
+.IP \(bu 2.3
+.\}
+Gets the drive log from the device and saves to defined file with pathname (e\&.g\&. /tmp/testSTM00019F3F9drive_log\&.bin):
+.sp
+.if n \{\
+.RS 4
+.\}
+.nf
+# nvme wdc drive\-log /dev/nvme0 \-o /tmp/test
+.fi
+.if n \{\
+.RE
+.\}
+.RE
+.SH "NVME"
+.sp
+Part of the nvme\-user suite
diff --git a/Documentation/nvme-wdc-drive-log.html b/Documentation/nvme-wdc-drive-log.html
new file mode 100644
index 0000000..ec572a8
--- /dev/null
+++ b/Documentation/nvme-wdc-drive-log.html
@@ -0,0 +1,834 @@
+<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
+    "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
+<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
+<head>
+<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
+<meta name="generator" content="AsciiDoc 8.6.9" />
+<title>nvme-wdc-drive-log(1)</title>
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
+nvme-wdc-drive-log(1) Manual Page
+</h1>
+<h2>NAME</h2>
+<div class="sectionbody">
+<p>nvme-wdc-drive-log -
+   Retrieve WDC device's drive log and save to file.
+</p>
+</div>
+</div>
+<div id="content">
+<div class="sect1">
+<h2 id="_synopsis">SYNOPSIS</h2>
+<div class="sectionbody">
+<div class="verseblock">
+<pre class="content"><em>nvme wdc drive-log</em> &lt;device&gt; [--output-file=&lt;FILE&gt;, -o &lt;FILE&gt;]</pre>
+<div class="attribution">
+</div></div>
+</div>
+</div>
+<div class="sect1">
+<h2 id="_description">DESCRIPTION</h2>
+<div class="sectionbody">
+<div class="paragraph"><p>For the NVMe device given, sends the wdc vendor unique drive log
+request and saves the result to a file.</p></div>
+<div class="paragraph"><p>The &lt;device&gt; parameter is mandatory and may be either the NVMe
+character device (ex: /dev/nvme0), or a namespace block device (ex:
+/dev/nvme0n1).</p></div>
+<div class="paragraph"><p>This will only work on WDC devices supporting this feature.
+Results for any other device are undefined.</p></div>
+</div>
+</div>
+<div class="sect1">
+<h2 id="_options">OPTIONS</h2>
+<div class="sectionbody">
+<div class="dlist"><dl>
+<dt class="hdlist1">
+-o &lt;FILE&gt;
+</dt>
+<dt class="hdlist1">
+--output-file=&lt;FILE&gt;
+</dt>
+<dd>
+<p>
+        Output file; defaults to device serial number followed by "drive_log" suffix
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
+Gets the drive log from the device and saves to default file in current directory (e.g. STM00019F3F9drive_log.bin):
+</p>
+<div class="listingblock">
+<div class="content">
+<pre><code># nvme wdc drive-log /dev/nvme0</code></pre>
+</div></div>
+</li>
+<li>
+<p>
+Gets the drive log from the device and saves to defined file in current directory (e.g. testSTM00019F3F9drive_log.bin):
+</p>
+<div class="listingblock">
+<div class="content">
+<pre><code># nvme wdc drive-log /dev/nvme0 -o test</code></pre>
+</div></div>
+</li>
+<li>
+<p>
+Gets the drive log from the device and saves to defined file with pathname (e.g. /tmp/testSTM00019F3F9drive_log.bin):
+</p>
+<div class="listingblock">
+<div class="content">
+<pre><code># nvme wdc drive-log /dev/nvme0 -o /tmp/test</code></pre>
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
+Last updated 2017-02-28 18:09:35 PST
+</div>
+</div>
+</body>
+</html>
diff --git a/Documentation/nvme-wdc-drive-log.txt b/Documentation/nvme-wdc-drive-log.txt
new file mode 100644
index 0000000..3c6a589
--- /dev/null
+++ b/Documentation/nvme-wdc-drive-log.txt
@@ -0,0 +1,52 @@
+nvme-wdc-drive-log(1)
+=====================
+
+NAME
+----
+nvme-wdc-drive-log - Retrieve WDC device's drive log and save to file.
+
+SYNOPSIS
+--------
+[verse]
+'nvme wdc drive-log' <device> [--output-file=<FILE>, -o <FILE>]
+
+DESCRIPTION
+-----------
+For the NVMe device given, sends the wdc vendor unique drive log
+request and saves the result to a file.
+
+The <device> parameter is mandatory and may be either the NVMe
+character device (ex: /dev/nvme0), or a namespace block device (ex:
+/dev/nvme0n1).
+
+This will only work on WDC devices supporting this feature.
+Results for any other device are undefined.
+
+OPTIONS
+-------
+-o <FILE>::
+--output-file=<FILE>::
+	Output file; defaults to device serial number followed by "drive_log" suffix
+
+
+EXAMPLES
+--------
+* Gets the drive log from the device and saves to default file in current directory (e.g. STM00019F3F9drive_log.bin):
++
+------------
+# nvme wdc drive-log /dev/nvme0
+------------
+* Gets the drive log from the device and saves to defined file in current directory (e.g. testSTM00019F3F9drive_log.bin):
++
+------------
+# nvme wdc drive-log /dev/nvme0 -o test
+------------
+* Gets the drive log from the device and saves to defined file with pathname (e.g. /tmp/testSTM00019F3F9drive_log.bin):
++
+------------
+# nvme wdc drive-log /dev/nvme0 -o /tmp/test
+------------
+
+NVME
+----
+Part of the nvme-user suite
diff --git a/Documentation/nvme-wdc-get-crash-dump.1 b/Documentation/nvme-wdc-get-crash-dump.1
new file mode 100644
index 0000000..0de08bc
--- /dev/null
+++ b/Documentation/nvme-wdc-get-crash-dump.1
@@ -0,0 +1,116 @@
+'\" t
+.\"     Title: nvme-wdc-get-crash-dump
+.\"    Author: [FIXME: author] [see http://docbook.sf.net/el/author]
+.\" Generator: DocBook XSL Stylesheets v1.78.1 <http://docbook.sf.net/>
+.\"      Date: 02/28/2017
+.\"    Manual: NVMe Manual
+.\"    Source: NVMe
+.\"  Language: English
+.\"
+.TH "NVME\-WDC\-GET\-CRAS" "1" "02/28/2017" "NVMe" "NVMe Manual"
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
+nvme-wdc-get-crash-dump \- Retrieve WDC device\*(Aqs crash dump\&.
+.SH "SYNOPSIS"
+.sp
+.nf
+\fInvme wdc get\-crash\-dump\fR <device> [\-\-output\-file=<FILE>, \-o <FILE>]
+.fi
+.SH "DESCRIPTION"
+.sp
+For the NVMe device given, sends the WDC vendor unique crash dump request and saves the result to file\&. In current implementation crash dump is captured if it is present\&. On success it will save the dump in file with appropriate suffix\&. Note that this command will clear the available dump from the device on success\&.
+.sp
+The <device> parameter is mandatory NVMe character device (ex: /dev/nvme0)\&.
+.sp
+This will only work on WDC devices supporting this feature\&. Results for any other device are undefined\&.
+.SH "OPTIONS"
+.PP
+\-o <FILE>, \-\-output\-file=<FILE>
+.RS 4
+Output file; defaults to device serial number followed by "crash_dump" suffix
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
+Gets the crash dump from the device and saves to default file in current directory (e\&.g\&. STM00019F3F9crash_dump\&.bin):
+.sp
+.if n \{\
+.RS 4
+.\}
+.nf
+# nvme wdc get\-crash\-dump /dev/nvme0
+.fi
+.if n \{\
+.RE
+.\}
+.RE
+.sp
+.RS 4
+.ie n \{\
+\h'-04'\(bu\h'+03'\c
+.\}
+.el \{\
+.sp -1
+.IP \(bu 2.3
+.\}
+Gets the crash dump from the device and saves to defined file in current directory (e\&.g\&. testSTM00019F3F9crash_dump\&.bin):
+.sp
+.if n \{\
+.RS 4
+.\}
+.nf
+# nvme wdc get\-crash\-dump /dev/nvme0 \-o test
+.fi
+.if n \{\
+.RE
+.\}
+.RE
+.sp
+.RS 4
+.ie n \{\
+\h'-04'\(bu\h'+03'\c
+.\}
+.el \{\
+.sp -1
+.IP \(bu 2.3
+.\}
+Gets the crash dump from the device and saves to defined file with pathname (e\&.g\&. /tmp/testSTM00019F3F9crash_dump\&.bin):
+.sp
+.if n \{\
+.RS 4
+.\}
+.nf
+# nvme wdc get\-crash\-dump /dev/nvme0 \-o /tmp/test
+.fi
+.if n \{\
+.RE
+.\}
+.RE
+.SH "NVME"
+.sp
+Part of the nvme\-user suite
diff --git a/Documentation/nvme-wdc-get-crash-dump.html b/Documentation/nvme-wdc-get-crash-dump.html
new file mode 100644
index 0000000..603270a
--- /dev/null
+++ b/Documentation/nvme-wdc-get-crash-dump.html
@@ -0,0 +1,835 @@
+<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
+    "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
+<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
+<head>
+<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
+<meta name="generator" content="AsciiDoc 8.6.9" />
+<title>nvme-wdc-get-crash-dump(1)</title>
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
+nvme-wdc-get-crash-dump(1) Manual Page
+</h1>
+<h2>NAME</h2>
+<div class="sectionbody">
+<p>nvme-wdc-get-crash-dump -
+   Retrieve WDC device's crash dump.
+</p>
+</div>
+</div>
+<div id="content">
+<div class="sect1">
+<h2 id="_synopsis">SYNOPSIS</h2>
+<div class="sectionbody">
+<div class="verseblock">
+<pre class="content"><em>nvme wdc get-crash-dump</em> &lt;device&gt; [--output-file=&lt;FILE&gt;, -o &lt;FILE&gt;]</pre>
+<div class="attribution">
+</div></div>
+</div>
+</div>
+<div class="sect1">
+<h2 id="_description">DESCRIPTION</h2>
+<div class="sectionbody">
+<div class="paragraph"><p>For the NVMe device given, sends the WDC vendor unique crash dump
+request and saves the result to file. In current implementation crash dump is
+captured if it is present. On success it will save the dump in file with
+appropriate suffix. Note that this command will clear the available
+dump from the device on success.</p></div>
+<div class="paragraph"><p>The &lt;device&gt; parameter is mandatory NVMe character device (ex: /dev/nvme0).</p></div>
+<div class="paragraph"><p>This will only work on WDC devices supporting this feature.
+Results for any other device are undefined.</p></div>
+</div>
+</div>
+<div class="sect1">
+<h2 id="_options">OPTIONS</h2>
+<div class="sectionbody">
+<div class="dlist"><dl>
+<dt class="hdlist1">
+-o &lt;FILE&gt;
+</dt>
+<dt class="hdlist1">
+--output-file=&lt;FILE&gt;
+</dt>
+<dd>
+<p>
+        Output file; defaults to device serial number followed by "crash_dump" suffix
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
+Gets the crash dump from the device and saves to default file in current directory (e.g. STM00019F3F9crash_dump.bin):
+</p>
+<div class="listingblock">
+<div class="content">
+<pre><code># nvme wdc get-crash-dump /dev/nvme0</code></pre>
+</div></div>
+</li>
+<li>
+<p>
+Gets the crash dump from the device and saves to defined file in current directory (e.g. testSTM00019F3F9crash_dump.bin):
+</p>
+<div class="listingblock">
+<div class="content">
+<pre><code># nvme wdc get-crash-dump /dev/nvme0 -o test</code></pre>
+</div></div>
+</li>
+<li>
+<p>
+Gets the crash dump from the device and saves to defined file with pathname (e.g. /tmp/testSTM00019F3F9crash_dump.bin):
+</p>
+<div class="listingblock">
+<div class="content">
+<pre><code># nvme wdc get-crash-dump /dev/nvme0 -o /tmp/test</code></pre>
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
+Last updated 2017-02-28 18:09:35 PST
+</div>
+</div>
+</body>
+</html>
diff --git a/Documentation/nvme-wdc-get-crash-dump.txt b/Documentation/nvme-wdc-get-crash-dump.txt
new file mode 100644
index 0000000..109daca
--- /dev/null
+++ b/Documentation/nvme-wdc-get-crash-dump.txt
@@ -0,0 +1,52 @@
+nvme-wdc-get-crash-dump(1)
+==========================
+
+NAME
+----
+nvme-wdc-get-crash-dump - Retrieve WDC device's crash dump.
+
+SYNOPSIS
+--------
+[verse]
+'nvme wdc get-crash-dump' <device> [--output-file=<FILE>, -o <FILE>]
+
+DESCRIPTION
+-----------
+For the NVMe device given, sends the WDC vendor unique crash dump
+request and saves the result to file. In current implementation crash dump is
+captured if it is present. On success it will save the dump in file with
+appropriate suffix. Note that this command will clear the available
+dump from the device on success.
+
+The <device> parameter is mandatory NVMe character device (ex: /dev/nvme0).
+
+This will only work on WDC devices supporting this feature.
+Results for any other device are undefined.
+
+OPTIONS
+-------
+-o <FILE>::
+--output-file=<FILE>::
+	Output file; defaults to device serial number followed by "crash_dump" suffix
+
+EXAMPLES
+--------
+* Gets the crash dump from the device and saves to default file in current directory (e.g. STM00019F3F9crash_dump.bin):
++
+------------
+# nvme wdc get-crash-dump /dev/nvme0
+------------
+* Gets the crash dump from the device and saves to defined file in current directory (e.g. testSTM00019F3F9crash_dump.bin):
++
+------------
+# nvme wdc get-crash-dump /dev/nvme0 -o test
+------------
+* Gets the crash dump from the device and saves to defined file with pathname (e.g. /tmp/testSTM00019F3F9crash_dump.bin):
++
+------------
+# nvme wdc get-crash-dump /dev/nvme0 -o /tmp/test
+------------
+
+NVME
+----
+Part of the nvme-user suite
diff --git a/Documentation/nvme-wdc-id-ctrl.1 b/Documentation/nvme-wdc-id-ctrl.1
new file mode 100644
index 0000000..6e4a7b7
--- /dev/null
+++ b/Documentation/nvme-wdc-id-ctrl.1
@@ -0,0 +1,97 @@
+'\" t
+.\"     Title: nvme-wdc-id-ctrl
+.\"    Author: [FIXME: author] [see http://docbook.sf.net/el/author]
+.\" Generator: DocBook XSL Stylesheets v1.78.1 <http://docbook.sf.net/>
+.\"      Date: 02/28/2017
+.\"    Manual: NVMe Manual
+.\"    Source: NVMe
+.\"  Language: English
+.\"
+.TH "NVME\-WDC\-ID\-CTRL" "1" "02/28/2017" "NVMe" "NVMe Manual"
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
+nvme-wdc-id-ctrl \- Send NVMe Identify Controller, return result and structure
+.SH "SYNOPSIS"
+.sp
+.nf
+\fInvme wdc id\-ctrl\fR <device> [\-v | \-\-vendor\-specific] [\-b | \-\-raw\-binary]
+                        [\-o <fmt> | \-\-output\-format=<fmt>]
+.fi
+.SH "DESCRIPTION"
+.sp
+For the NVMe device given, sends an identify controller command and provides the result and returned structure\&.
+.sp
+The <device> parameter is mandatory and may be either the NVMe character device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1)\&.
+.sp
+This will only work on WDC devices supporting this feature\&. Results for any other device are undefined\&.
+.sp
+On success, the structure may be returned in one of several ways depending on the option flags; the structure may be parsed by the program or the raw buffer may be printed to stdout\&.
+.sp
+If having the program decode the output for readability, this version will decode WDC vendor unique portions of the structure\&.
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
+# nvme wdc id\-ctrl /dev/nvme0
+.fi
+.if n \{\
+.RE
+.\}
+.RE
+.SH "NVME"
+.sp
+Part of the nvme\-user suite
diff --git a/Documentation/nvme-wdc-id-ctrl.html b/Documentation/nvme-wdc-id-ctrl.html
new file mode 100644
index 0000000..6373705
--- /dev/null
+++ b/Documentation/nvme-wdc-id-ctrl.html
@@ -0,0 +1,860 @@
+<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
+    "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
+<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
+<head>
+<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
+<meta name="generator" content="AsciiDoc 8.6.9" />
+<title>nvme-wdc-id-ctrl(1)</title>
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
+nvme-wdc-id-ctrl(1) Manual Page
+</h1>
+<h2>NAME</h2>
+<div class="sectionbody">
+<p>nvme-wdc-id-ctrl -
+   Send NVMe Identify Controller, return result and structure
+</p>
+</div>
+</div>
+<div id="content">
+<div class="sect1">
+<h2 id="_synopsis">SYNOPSIS</h2>
+<div class="sectionbody">
+<div class="verseblock">
+<pre class="content"><em>nvme wdc id-ctrl</em> &lt;device&gt; [-v | --vendor-specific] [-b | --raw-binary]
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
+<div class="paragraph"><p>This will only work on WDC devices supporting this feature.
+Results for any other device are undefined.</p></div>
+<div class="paragraph"><p>On success, the structure may be returned in one of several ways depending
+on the option flags; the structure may be parsed by the program or the
+raw buffer may be printed to stdout.</p></div>
+<div class="paragraph"><p>If having the program decode the output for readability, this version
+will decode WDC vendor unique portions of the structure.</p></div>
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
+<pre><code># nvme wdc id-ctrl /dev/nvme0</code></pre>
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
+Last updated 2017-02-28 18:09:35 PST
+</div>
+</div>
+</body>
+</html>
diff --git a/Documentation/nvme-wdc-id-ctrl.txt b/Documentation/nvme-wdc-id-ctrl.txt
new file mode 100644
index 0000000..d0bbc13
--- /dev/null
+++ b/Documentation/nvme-wdc-id-ctrl.txt
@@ -0,0 +1,66 @@
+nvme-wdc-id-ctrl(1)
+=====================
+
+NAME
+----
+nvme-wdc-id-ctrl - Send NVMe Identify Controller, return result and structure
+
+SYNOPSIS
+--------
+[verse]
+'nvme wdc id-ctrl' <device> [-v | --vendor-specific] [-b | --raw-binary]
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
+This will only work on WDC devices supporting this feature.
+Results for any other device are undefined.
+
+On success, the structure may be returned in one of several ways depending
+on the option flags; the structure may be parsed by the program or the
+raw buffer may be printed to stdout.
+
+If having the program decode the output for readability, this version
+will decode WDC vendor unique portions of the structure.
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
+# nvme wdc id-ctrl /dev/nvme0
+------------
+
+NVME
+----
+Part of the nvme-user suite
diff --git a/Documentation/nvme-wdc-purge-monitor.1 b/Documentation/nvme-wdc-purge-monitor.1
new file mode 100644
index 0000000..bc6e464
--- /dev/null
+++ b/Documentation/nvme-wdc-purge-monitor.1
@@ -0,0 +1,126 @@
+'\" t
+.\"     Title: nvme-wdc-purge-monitor
+.\"    Author: [FIXME: author] [see http://docbook.sf.net/el/author]
+.\" Generator: DocBook XSL Stylesheets v1.78.1 <http://docbook.sf.net/>
+.\"      Date: 02/28/2017
+.\"    Manual: NVMe Manual
+.\"    Source: NVMe
+.\"  Language: English
+.\"
+.TH "NVME\-WDC\-PURGE\-MO" "1" "02/28/2017" "NVMe" "NVMe Manual"
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
+nvme-wdc-purge-monitor \- Send NVMe WDC Purge\-Monitor Vendor Unique Command, return result
+.SH "SYNOPSIS"
+.sp
+.nf
+\fInvme wdc purge\-monitor\fR <device>
+.fi
+.SH "DESCRIPTION"
+.sp
+For the NVMe device given, send a Vendor Unique WDC Purge\-Monitor command and provide the status of the purge command\&.
+.sp
+Expected status and description :\-
+.TS
+allbox tab(:);
+ltB ltB.
+T{
+Status Code
+T}:T{
+Description
+T}
+.T&
+lt lt
+lt lt
+lt lt
+lt lt
+lt lt.
+T{
+.sp
+0x00
+T}:T{
+.sp
+Purge State Idle\&.
+T}
+T{
+.sp
+0x01
+T}:T{
+.sp
+Purge State Done\&.
+T}
+T{
+.sp
+0x02
+T}:T{
+.sp
+Purge State Busy\&.
+T}
+T{
+.sp
+0x03
+T}:T{
+.sp
+Purge State Error : Purge operation resulted in error, power cycle required\&.
+T}
+T{
+.sp
+0x04
+T}:T{
+.sp
+Purge State Error : Purge operation interrupted by power cycle or reset\&.
+T}
+.TE
+.sp 1
+.sp
+The <device> parameter is mandatory and may be either the NVMe character device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1)\&.
+.sp
+This will only work on WDC devices supporting this feature\&. Results for any other device are undefined\&.
+.sp
+On success it returns 0, error code otherwise\&.
+.SH "OPTIONS"
+.sp
+No options yet\&.
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
+Has the program issue WDC Purge\-Monitor Vendor Unique Command :
+.sp
+.if n \{\
+.RS 4
+.\}
+.nf
+# nvme wdc purge\-monitor /dev/nvme0
+.fi
+.if n \{\
+.RE
+.\}
+.RE
+.SH "NVME"
+.sp
+Part of the nvme\-user suite\&.
diff --git a/Documentation/nvme-wdc-purge-monitor.html b/Documentation/nvme-wdc-purge-monitor.html
new file mode 100644
index 0000000..7729fdf
--- /dev/null
+++ b/Documentation/nvme-wdc-purge-monitor.html
@@ -0,0 +1,842 @@
+<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
+    "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
+<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
+<head>
+<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
+<meta name="generator" content="AsciiDoc 8.6.9" />
+<title>nvme-wdc-purge-monitor(1)</title>
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
+nvme-wdc-purge-monitor(1) Manual Page
+</h1>
+<h2>NAME</h2>
+<div class="sectionbody">
+<p>nvme-wdc-purge-monitor -
+   Send NVMe WDC Purge-Monitor Vendor Unique Command, return result
+</p>
+</div>
+</div>
+<div id="content">
+<div class="sect1">
+<h2 id="_synopsis">SYNOPSIS</h2>
+<div class="sectionbody">
+<div class="verseblock">
+<pre class="content"><em>nvme wdc purge-monitor</em> &lt;device&gt;</pre>
+<div class="attribution">
+</div></div>
+</div>
+</div>
+<div class="sect1">
+<h2 id="_description">DESCRIPTION</h2>
+<div class="sectionbody">
+<div class="paragraph"><p>For the NVMe device given, send a Vendor Unique WDC Purge-Monitor command and
+provide the status of the purge command.</p></div>
+<div class="paragraph"><p>Expected status and description :-</p></div>
+<div class="tableblock">
+<table rules="all"
+width="100%"
+frame="border"
+cellspacing="0" cellpadding="4">
+<col width="50%" />
+<col width="50%" />
+<thead>
+<tr>
+<th align="left" valign="top">Status Code </th>
+<th align="left" valign="top">Description</th>
+</tr>
+</thead>
+<tbody>
+<tr>
+<td align="left" valign="top"><p class="table">0x00</p></td>
+<td align="left" valign="top"><p class="table">Purge State Idle.</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table">0x01</p></td>
+<td align="left" valign="top"><p class="table">Purge State Done.</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table">0x02</p></td>
+<td align="left" valign="top"><p class="table">Purge State Busy.</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table">0x03</p></td>
+<td align="left" valign="top"><p class="table">Purge State Error : Purge operation resulted in error, power cycle required.</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table">0x04</p></td>
+<td align="left" valign="top"><p class="table">Purge State Error : Purge operation interrupted by power cycle or reset.</p></td>
+</tr>
+</tbody>
+</table>
+</div>
+<div class="paragraph"><p>The &lt;device&gt; parameter is mandatory and may be either the NVMe character
+device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1).</p></div>
+<div class="paragraph"><p>This will only work on WDC devices supporting this feature.
+Results for any other device are undefined.</p></div>
+<div class="paragraph"><p>On success it returns 0, error code otherwise.</p></div>
+</div>
+</div>
+<div class="sect1">
+<h2 id="_options">OPTIONS</h2>
+<div class="sectionbody">
+<div class="paragraph"><p>No options yet.</p></div>
+</div>
+</div>
+<div class="sect1">
+<h2 id="_examples">EXAMPLES</h2>
+<div class="sectionbody">
+<div class="ulist"><ul>
+<li>
+<p>
+Has the program issue WDC Purge-Monitor Vendor Unique Command :
+</p>
+<div class="listingblock">
+<div class="content">
+<pre><code># nvme wdc purge-monitor /dev/nvme0</code></pre>
+</div></div>
+</li>
+</ul></div>
+</div>
+</div>
+<div class="sect1">
+<h2 id="_nvme">NVME</h2>
+<div class="sectionbody">
+<div class="paragraph"><p>Part of the nvme-user suite.</p></div>
+</div>
+</div>
+</div>
+<div id="footnotes"><hr /></div>
+<div id="footer">
+<div id="footer-text">
+Last updated 2017-02-28 18:09:35 PST
+</div>
+</div>
+</body>
+</html>
diff --git a/Documentation/nvme-wdc-purge-monitor.txt b/Documentation/nvme-wdc-purge-monitor.txt
new file mode 100644
index 0000000..df54c62
--- /dev/null
+++ b/Documentation/nvme-wdc-purge-monitor.txt
@@ -0,0 +1,63 @@
+nvme-wdc-purge-monitor(1)
+==========================
+
+NAME
+----
+nvme-wdc-purge-monitor - Send NVMe WDC Purge-Monitor Vendor Unique Command, return result
+
+SYNOPSIS
+--------
+[verse]
+'nvme wdc purge-monitor' <device>
+
+DESCRIPTION
+-----------
+For the NVMe device given, send a Vendor Unique WDC Purge-Monitor command and
+provide the status of the purge command.
+
+Expected status and description :-
+
+[cols="2*", options="header"]
+|===
+|Status Code |Description
+
+|0x00
+|Purge State Idle.
+
+|0x01
+|Purge State Done.
+
+|0x02
+|Purge State Busy.
+
+|0x03
+|Purge State Error : Purge operation resulted in error, power cycle required.
+
+|0x04
+|Purge State Error : Purge operation interrupted by power cycle or reset.
+|===
+
+
+The <device> parameter is mandatory and may be either the NVMe character
+device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1).
+
+This will only work on WDC devices supporting this feature.
+Results for any other device are undefined.
+
+On success it returns 0, error code otherwise.
+
+OPTIONS
+-------
+No options yet.
+
+EXAMPLES
+--------
+* Has the program issue WDC Purge-Monitor Vendor Unique Command :
++
+------------
+# nvme wdc purge-monitor /dev/nvme0
+------------
+
+NVME
+----
+Part of the nvme-user suite.
diff --git a/Documentation/nvme-wdc-purge.1 b/Documentation/nvme-wdc-purge.1
new file mode 100644
index 0000000..91c461e
--- /dev/null
+++ b/Documentation/nvme-wdc-purge.1
@@ -0,0 +1,73 @@
+'\" t
+.\"     Title: nvme-wdc-purge
+.\"    Author: [FIXME: author] [see http://docbook.sf.net/el/author]
+.\" Generator: DocBook XSL Stylesheets v1.78.1 <http://docbook.sf.net/>
+.\"      Date: 02/28/2017
+.\"    Manual: NVMe Manual
+.\"    Source: NVMe
+.\"  Language: English
+.\"
+.TH "NVME\-WDC\-PURGE" "1" "02/28/2017" "NVMe" "NVMe Manual"
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
+nvme-wdc-purge \- Send NVMe WDC Purge Vendor Unique Command, return result
+.SH "SYNOPSIS"
+.sp
+.nf
+\fInvme wdc purge\fR <device>
+.fi
+.SH "DESCRIPTION"
+.sp
+For the NVMe device given, sends a Vendor Unique WDC Purge command and provides the result\&.
+.sp
+The <device> parameter is mandatory and may be either the NVMe character device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1)\&.
+.sp
+This will only work on WDC devices supporting this feature\&. Results for any other device are undefined\&.
+.sp
+On success it returns 0, error code otherwise\&.
+.SH "OPTIONS"
+.sp
+No options yet\&.
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
+Has the program issue WDC Purge Vendor Unique Command :
+.sp
+.if n \{\
+.RS 4
+.\}
+.nf
+# nvme wdc purge /dev/nvme0n1
+.fi
+.if n \{\
+.RE
+.\}
+.RE
+.SH "NVME"
+.sp
+Part of the nvme\-user suite\&.
diff --git a/Documentation/nvme-wdc-purge.html b/Documentation/nvme-wdc-purge.html
new file mode 100644
index 0000000..410798a
--- /dev/null
+++ b/Documentation/nvme-wdc-purge.html
@@ -0,0 +1,804 @@
+<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
+    "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
+<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
+<head>
+<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
+<meta name="generator" content="AsciiDoc 8.6.9" />
+<title>nvme-wdc-purge(1)</title>
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
+nvme-wdc-purge(1) Manual Page
+</h1>
+<h2>NAME</h2>
+<div class="sectionbody">
+<p>nvme-wdc-purge -
+   Send NVMe WDC Purge Vendor Unique Command, return result
+</p>
+</div>
+</div>
+<div id="content">
+<div class="sect1">
+<h2 id="_synopsis">SYNOPSIS</h2>
+<div class="sectionbody">
+<div class="verseblock">
+<pre class="content"><em>nvme wdc purge</em> &lt;device&gt;</pre>
+<div class="attribution">
+</div></div>
+</div>
+</div>
+<div class="sect1">
+<h2 id="_description">DESCRIPTION</h2>
+<div class="sectionbody">
+<div class="paragraph"><p>For the NVMe device given, sends a Vendor Unique WDC Purge command and
+provides the result.</p></div>
+<div class="paragraph"><p>The &lt;device&gt; parameter is mandatory and may be either the NVMe character
+device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1).</p></div>
+<div class="paragraph"><p>This will only work on WDC devices supporting this feature.
+Results for any other device are undefined.</p></div>
+<div class="paragraph"><p>On success it returns 0, error code otherwise.</p></div>
+</div>
+</div>
+<div class="sect1">
+<h2 id="_options">OPTIONS</h2>
+<div class="sectionbody">
+<div class="paragraph"><p>No options yet.</p></div>
+</div>
+</div>
+<div class="sect1">
+<h2 id="_examples">EXAMPLES</h2>
+<div class="sectionbody">
+<div class="ulist"><ul>
+<li>
+<p>
+Has the program issue WDC Purge Vendor Unique Command :
+</p>
+<div class="listingblock">
+<div class="content">
+<pre><code># nvme wdc purge /dev/nvme0n1</code></pre>
+</div></div>
+</li>
+</ul></div>
+</div>
+</div>
+<div class="sect1">
+<h2 id="_nvme">NVME</h2>
+<div class="sectionbody">
+<div class="paragraph"><p>Part of the nvme-user suite.</p></div>
+</div>
+</div>
+</div>
+<div id="footnotes"><hr /></div>
+<div id="footer">
+<div id="footer-text">
+Last updated 2017-02-28 18:09:35 PST
+</div>
+</div>
+</body>
+</html>
diff --git a/Documentation/nvme-wdc-purge.txt b/Documentation/nvme-wdc-purge.txt
new file mode 100644
index 0000000..3449c34
--- /dev/null
+++ b/Documentation/nvme-wdc-purge.txt
@@ -0,0 +1,40 @@
+nvme-wdc-purge(1)
+==================
+
+NAME
+----
+nvme-wdc-purge - Send NVMe WDC Purge Vendor Unique Command, return result
+
+SYNOPSIS
+--------
+[verse]
+'nvme wdc purge' <device>
+
+DESCRIPTION
+-----------
+For the NVMe device given, sends a Vendor Unique WDC Purge command and
+provides the result.
+
+The <device> parameter is mandatory and may be either the NVMe character
+device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1).
+
+This will only work on WDC devices supporting this feature.
+Results for any other device are undefined.
+
+On success it returns 0, error code otherwise.
+
+OPTIONS
+-------
+No options yet.
+
+EXAMPLES
+--------
+* Has the program issue WDC Purge Vendor Unique Command :
++
+------------
+# nvme wdc purge /dev/nvme0n1
+------------
+
+NVME
+----
+Part of the nvme-user suite.
diff --git a/Documentation/nvme-wdc-smart-log-add.1 b/Documentation/nvme-wdc-smart-log-add.1
new file mode 100644
index 0000000..23b6217
--- /dev/null
+++ b/Documentation/nvme-wdc-smart-log-add.1
@@ -0,0 +1,348 @@
+'\" t
+.\"     Title: nvme-wdc-smart-log-add
+.\"    Author: [FIXME: author] [see http://docbook.sf.net/el/author]
+.\" Generator: DocBook XSL Stylesheets v1.78.1 <http://docbook.sf.net/>
+.\"      Date: 02/28/2017
+.\"    Manual: NVMe Manual
+.\"    Source: NVMe
+.\"  Language: English
+.\"
+.TH "NVME\-WDC\-SMART\-LO" "1" "02/28/2017" "NVMe" "NVMe Manual"
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
+nvme-wdc-smart-log-add \- Send NVMe WDC smart\-log\-add Vendor Unique Command, return result
+.SH "SYNOPSIS"
+.sp
+.nf
+\fInvme wdc smart\-log\-add\fR <device> [\-\-interval=<NUM>, \-i <NUM>] [\-\-output\-format=<normal|json> \-o <normal|json>]
+.fi
+.SH "DESCRIPTION"
+.sp
+For the NVMe device given, send a Vendor Unique WDC smart\-log\-add command and provide the additional smart log\&. The \-\-interval option will return performance statistics from the specified reporting interval\&.
+.sp
+The <device> parameter is mandatory and may be either the NVMe character device (ex: /dev/nvme0)\&.
+.sp
+This will only work on WDC devices supporting this feature\&. Results for any other device are undefined\&.
+.sp
+On success it returns 0, error code otherwise\&.
+.SH "OPTIONS"
+.PP
+\-i <NUM>, \-\-interval=<NUM>
+.RS 4
+Return the statistics from specific interval, defaults to 14
+.RE
+.PP
+\-o <format>, \-\-output\-format=<format>
+.RS 4
+Set the reporting format to
+\fIhuman\fR, or
+\fIjson\fR\&. Only one output format can be used at a time\&. Default is human\&.
+.RE
+.sp
+Valid Interval values and description :\-
+.TS
+allbox tab(:);
+ltB ltB.
+T{
+Value
+T}:T{
+Description
+T}
+.T&
+lt lt
+lt lt
+lt lt
+lt lt
+lt lt.
+T{
+.sp
+\fB1\fR
+T}:T{
+.sp
+Most recent five (5) minute accumulated set\&.
+T}
+T{
+.sp
+\fB2\-12\fR
+T}:T{
+.sp
+Previous five (5) minute accumulated sets\&.
+T}
+T{
+.sp
+\fB13\fR
+T}:T{
+.sp
+The accumulated total of sets 1 through 12 that contain the previous hour of accumulated statistics\&.
+T}
+T{
+.sp
+\fB14\fR
+T}:T{
+.sp
+The statistical set accumulated since power\-up\&.
+T}
+T{
+.sp
+\fB15\fR
+T}:T{
+.sp
+The statistical set accumulated during the entire lifetime of the device\&.
+T}
+.TE
+.sp 1
+.SH "OUTPUT EXPLANATION"
+.TS
+allbox tab(:);
+ltB ltB.
+T{
+Field
+T}:T{
+Description
+T}
+.T&
+lt lt
+lt lt
+lt lt
+lt lt
+lt lt
+lt lt
+lt lt
+lt lt
+lt lt
+lt lt
+lt lt
+lt lt
+lt lt
+lt lt
+lt lt
+lt lt
+lt lt
+lt lt
+lt lt
+lt lt
+lt lt
+lt lt
+lt lt
+lt lt
+lt lt.
+T{
+.sp
+\fBHost Read Commands\fR
+T}:T{
+.sp
+Number of host read commands received during the reporting period\&.
+T}
+T{
+.sp
+\fBHost Read Blocks\fR
+T}:T{
+.sp
+Number of 512\-byte blocks requested during the reporting period\&.
+T}
+T{
+.sp
+\fBAverage Read Size\fR
+T}:T{
+.sp
+Average Read size is calculated using (Host Read Blocks/Host Read Commands)\&.
+T}
+T{
+.sp
+\fBHost Read Cache Hit Commands\fR
+T}:T{
+.sp
+Number of host read commands that serviced entirely from the on\-board read cache during the reporting period\&. No access to the NAND flash memory was required\&. This count is only updated if the entire command was serviced from the cache memory\&.
+T}
+T{
+.sp
+\fBHost Read Cache Hit Percentage\fR
+T}:T{
+.sp
+Percentage of host read commands satisfied from the cache\&.
+T}
+T{
+.sp
+\fBHost Read Cache Hit Blocks\fR
+T}:T{
+.sp
+Number of 512\-byte blocks of data that have been returned for Host Read Cache Hit Commands during the reporting period\&. This count is only updated with the blocks returned for host read commands that were serviced entirely from cache memory\&.
+T}
+T{
+.sp
+\fBAverage Read Cache Hit Size\fR
+T}:T{
+.sp
+Average size of read commands satisfied from the cache\&.
+T}
+T{
+.sp
+\fBHost Read Commands Stalled\fR
+T}:T{
+.sp
+Number of host read commands that were stalled due to a lack of resources within the SSD during the reporting period (NAND flash command queue full, low cache page count, cache page contention, etc\&.)\&. Commands are not considered stalled if the only reason for the delay was waiting for the data to be physically read from the NAND flash\&. It is normal to expect this count to equal zero on heavily utilized systems\&.
+T}
+T{
+.sp
+\fBHost Read Commands Stalled Percentage\fR
+T}:T{
+.sp
+Percentage of read commands that were stalled\&. If the figure is consistently high, then consideration should be given to spreading the data across multiple SSDs\&.
+T}
+T{
+.sp
+\fBHost Write Commands\fR
+T}:T{
+.sp
+Number of host write commands received during the reporting period\&.
+T}
+T{
+.sp
+\fBHost Write Blocks\fR
+T}:T{
+.sp
+Number of 512\-byte blocks written during the reporting period\&.
+T}
+T{
+.sp
+\fBAverage Write Size\fR
+T}:T{
+.sp
+Average Write size calculated using (Host Write Blocks/Host Write Commands)\&.
+T}
+T{
+.sp
+\fBHost Write Odd Start Commands\fR
+T}:T{
+.sp
+Number of host write commands that started on a non\-aligned boundary during the reporting period\&. The size of the boundary alignment is normally 4K; therefore this returns the number of commands that started on a non\-4K aligned boundary\&. The SSD requires slightly more time to process non\-aligned write commands than it does to process aligned write commands\&.
+T}
+T{
+.sp
+\fBHost Write Odd Start Commands Percentage\fR
+T}:T{
+.sp
+Percentage of host write commands that started on a non\-aligned boundary\&. If this figure is equal to or near 100%, and the NAND Read Before Write value is also high, then the user should investigate the possibility of offsetting the file system\&. For Microsoft Windows systems, the user can use Diskpart\&. For Unix\-based operating systems, there is normally a method whereby file system partitions can be placed where required\&.
+T}
+T{
+.sp
+\fBHost Write Odd End Commands\fR
+T}:T{
+.sp
+Number of host write commands that ended on a non\-aligned boundary during the reporting period\&. The size of the boundary alignment is normally 4K; therefore this returns the number of commands that ended on a non\-4K aligned boundary\&.
+T}
+T{
+.sp
+\fBHost Write Odd End Commands Percentage\fR
+T}:T{
+.sp
+Percentage of host write commands that ended on a non\-aligned boundary\&.
+T}
+T{
+.sp
+\fBHost Write Commands Stalled\fR
+T}:T{
+.sp
+Number of host write commands that were stalled due to a lack of resources within the SSD during the reporting period\&. The most likely cause is that the write data was being received faster than it could be saved to the NAND flash memory\&. If there was a large volume of read commands being processed simultaneously, then other causes might include the NAND flash command queue being full, low cache page count, or cache page contention, etc\&. It is normal to expect this count to be non\-zero on heavily utilized systems\&.
+T}
+T{
+.sp
+\fBHost Write Commands Stalled Percentage\fR
+T}:T{
+.sp
+Percentage of write commands that were stalled\&. If the figure is consistently high, then consideration should be given to spreading the data across multiple SSDs\&.
+T}
+T{
+.sp
+\fBNAND Read Commands\fR
+T}:T{
+.sp
+Number of read commands issued to the NAND devices during the reporting period\&. This figure will normally be much higher than the host read commands figure, as the data needed to satisfy a single host read command may be spread across several NAND flash devices\&.
+T}
+T{
+.sp
+\fBNAND Read Blocks\fR
+T}:T{
+.sp
+Number of 512\-byte blocks requested from NAND flash devices during the reporting period\&. This figure would normally be about the same as the host read blocks figure
+T}
+T{
+.sp
+\fBAverage NAND Read Size\fR
+T}:T{
+.sp
+Average size of NAND read commands\&.
+T}
+T{
+.sp
+\fBNAND Write Commands\fR
+T}:T{
+.sp
+Number of write commands issued to the NAND devices during the reporting period\&. There is no real correlation between the number of host write commands issued and the number of NAND Write Commands\&.
+T}
+T{
+.sp
+\fBNAND Write Blocks\fR
+T}:T{
+.sp
+Number of 512\-byte blocks written to the NAND flash devices during the reporting period\&. This figure would normally be about the same as the host write blocks figure\&.
+T}
+T{
+.sp
+\fBAverage NAND Write Size\fR
+T}:T{
+.sp
+Average size of NAND write commands\&. This figure should never be greater than 128K, as this is the maximum size write that is ever issued to a NAND device\&.
+T}
+T{
+.sp
+\fBNAND Read Before Write\fR
+T}:T{
+.sp
+This is the number of read before write operations that were required to process non\-aligned host write commands during the reporting period\&. See Host Write Odd Start Commands and Host Write Odd End Commands\&. NAND Read Before Write operations have a detrimental effect on the overall performance of the device\&.
+T}
+.TE
+.sp 1
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
+Has the program issue WDC smart\-log\-add Vendor Unique Command with default interval (14) :
+.sp
+.if n \{\
+.RS 4
+.\}
+.nf
+# nvme wdc smart\-log\-add /dev/nvme0
+.fi
+.if n \{\
+.RE
+.\}
+.RE
+.SH "NVME"
+.sp
+Part of the nvme\-user suite\&.
diff --git a/Documentation/nvme-wdc-smart-log-add.html b/Documentation/nvme-wdc-smart-log-add.html
new file mode 100644
index 0000000..54ad949
--- /dev/null
+++ b/Documentation/nvme-wdc-smart-log-add.html
@@ -0,0 +1,1028 @@
+<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
+    "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
+<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
+<head>
+<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
+<meta name="generator" content="AsciiDoc 8.6.9" />
+<title>nvme-wdc-smart-log-add(1)</title>
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
+nvme-wdc-smart-log-add(1) Manual Page
+</h1>
+<h2>NAME</h2>
+<div class="sectionbody">
+<p>nvme-wdc-smart-log-add -
+   Send NVMe WDC smart-log-add Vendor Unique Command, return result
+</p>
+</div>
+</div>
+<div id="content">
+<div class="sect1">
+<h2 id="_synopsis">SYNOPSIS</h2>
+<div class="sectionbody">
+<div class="verseblock">
+<pre class="content"><em>nvme wdc smart-log-add</em> &lt;device&gt; [--interval=&lt;NUM&gt;, -i &lt;NUM&gt;] [--output-format=&lt;normal|json&gt; -o &lt;normal|json&gt;]</pre>
+<div class="attribution">
+</div></div>
+</div>
+</div>
+<div class="sect1">
+<h2 id="_description">DESCRIPTION</h2>
+<div class="sectionbody">
+<div class="paragraph"><p>For the NVMe device given, send a Vendor Unique WDC smart-log-add command and
+provide the additional smart log. The --interval option will return performance
+statistics from the specified reporting interval.</p></div>
+<div class="paragraph"><p>The &lt;device&gt; parameter is mandatory and may be either the NVMe character
+device (ex: /dev/nvme0).</p></div>
+<div class="paragraph"><p>This will only work on WDC devices supporting this feature.
+Results for any other device are undefined.</p></div>
+<div class="paragraph"><p>On success it returns 0, error code otherwise.</p></div>
+</div>
+</div>
+<div class="sect1">
+<h2 id="_options">OPTIONS</h2>
+<div class="sectionbody">
+<div class="dlist"><dl>
+<dt class="hdlist1">
+-i &lt;NUM&gt;
+</dt>
+<dt class="hdlist1">
+--interval=&lt;NUM&gt;
+</dt>
+<dd>
+<p>
+        Return the statistics from specific interval, defaults to 14
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
+        Set the reporting format to <em>human</em>, or
+        <em>json</em>. Only one output format can be used at a time.
+        Default is human.
+</p>
+</dd>
+</dl></div>
+<div class="paragraph"><p>Valid Interval values and description :-</p></div>
+<div class="tableblock">
+<table rules="all"
+style="margin-left:auto; margin-right:auto;"
+width="100%"
+frame="hsides"
+cellspacing="0" cellpadding="4">
+<col width="50%" />
+<col width="50%" />
+<thead>
+<tr>
+<th align="left" valign="top">Value </th>
+<th align="left" valign="top">Description</th>
+</tr>
+</thead>
+<tbody>
+<tr>
+<td align="left" valign="top"><p class="table"><strong>1</strong></p></td>
+<td align="left" valign="top"><p class="table">Most recent five (5) minute accumulated set.</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table"><strong>2-12</strong></p></td>
+<td align="left" valign="top"><p class="table">Previous five (5) minute accumulated sets.</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table"><strong>13</strong></p></td>
+<td align="left" valign="top"><p class="table">The accumulated total of sets 1 through 12 that contain the previous hour of
+accumulated statistics.</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table"><strong>14</strong></p></td>
+<td align="left" valign="top"><p class="table">The statistical set accumulated since power-up.</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table"><strong>15</strong></p></td>
+<td align="left" valign="top"><p class="table">The statistical set accumulated during the entire lifetime of the device.</p></td>
+</tr>
+</tbody>
+</table>
+</div>
+</div>
+</div>
+<div class="sect1">
+<h2 id="_output_explanation">Output Explanation</h2>
+<div class="sectionbody">
+<div class="tableblock">
+<table rules="all"
+style="margin-left:auto; margin-right:auto;"
+width="100%"
+frame="hsides"
+cellspacing="0" cellpadding="4">
+<col width="50%" />
+<col width="50%" />
+<thead>
+<tr>
+<th align="left" valign="top">Field </th>
+<th align="left" valign="top">Description</th>
+</tr>
+</thead>
+<tbody>
+<tr>
+<td align="left" valign="top"><p class="table"><strong>Host Read Commands</strong></p></td>
+<td align="left" valign="top"><p class="table">Number of host read commands received during the reporting period.</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table"><strong>Host Read Blocks</strong></p></td>
+<td align="left" valign="top"><p class="table">Number of 512-byte blocks requested during the reporting period.</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table"><strong>Average Read Size</strong></p></td>
+<td align="left" valign="top"><p class="table">Average Read size is calculated using (Host Read Blocks/Host Read Commands).</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table"><strong>Host Read Cache Hit Commands</strong></p></td>
+<td align="left" valign="top"><p class="table">Number of host read commands that serviced entirely from the on-board read
+cache during the reporting period. No access to the NAND flash memory was required.
+This count is only updated if the entire command was serviced from the cache memory.</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table"><strong>Host Read Cache Hit Percentage</strong></p></td>
+<td align="left" valign="top"><p class="table">Percentage of host read commands satisfied from the cache.</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table"><strong>Host Read Cache Hit Blocks</strong></p></td>
+<td align="left" valign="top"><p class="table">Number of 512-byte blocks of data that have been returned for Host Read Cache Hit
+Commands during the reporting period. This count is only updated with the blocks
+returned for host read commands that were serviced entirely from cache memory.</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table"><strong>Average Read Cache Hit Size</strong></p></td>
+<td align="left" valign="top"><p class="table">Average size of read commands satisfied from the cache.</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table"><strong>Host Read Commands Stalled</strong></p></td>
+<td align="left" valign="top"><p class="table">Number of host read commands that were stalled due to a lack of resources within
+the SSD during the reporting period (NAND flash command queue full, low cache page count,
+cache page contention, etc.). Commands are not considered stalled if the only reason for
+the delay was waiting for the data to be physically read from the NAND flash. It is normal
+to expect this count to equal zero on heavily utilized systems.</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table"><strong>Host Read Commands Stalled Percentage</strong></p></td>
+<td align="left" valign="top"><p class="table">Percentage of read commands that were stalled. If the figure is consistently high,
+then consideration should be given to spreading the data across multiple SSDs.</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table"><strong>Host Write Commands</strong></p></td>
+<td align="left" valign="top"><p class="table">Number of host write commands received during the reporting period.</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table"><strong>Host Write Blocks</strong></p></td>
+<td align="left" valign="top"><p class="table">Number of 512-byte blocks written during the reporting period.</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table"><strong>Average Write Size</strong></p></td>
+<td align="left" valign="top"><p class="table">Average Write size calculated using (Host Write Blocks/Host Write Commands).</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table"><strong>Host Write Odd Start Commands</strong></p></td>
+<td align="left" valign="top"><p class="table">Number of host write commands that started on a non-aligned boundary during
+the reporting period. The size of the boundary alignment is normally 4K; therefore
+this returns the number of commands that started on a non-4K aligned boundary.
+The SSD requires slightly more time to process non-aligned write commands than it
+does to process aligned write commands.</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table"><strong>Host Write Odd Start Commands Percentage</strong></p></td>
+<td align="left" valign="top"><p class="table">Percentage of host write commands that started on a non-aligned boundary. If this
+figure is equal to or near 100%, and the NAND Read Before Write value is also high,
+then the user should investigate the possibility of offsetting the file system. For
+Microsoft Windows systems, the user can use Diskpart. For Unix-based operating systems,
+there is normally a method whereby file system partitions can be placed where required.</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table"><strong>Host Write Odd End Commands</strong></p></td>
+<td align="left" valign="top"><p class="table">Number of host write commands that ended on a non-aligned boundary during the
+reporting period. The size of the boundary alignment is normally 4K; therefore this
+returns the number of commands that ended on a non-4K aligned boundary.</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table"><strong>Host Write Odd End Commands Percentage</strong></p></td>
+<td align="left" valign="top"><p class="table">Percentage of host write commands that ended on a non-aligned boundary.</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table"><strong>Host Write Commands Stalled</strong></p></td>
+<td align="left" valign="top"><p class="table">Number of host write commands that were stalled due to a lack of resources within the
+SSD during the reporting period. The most likely cause is that the write data was being
+received faster than it could be saved to the NAND flash memory. If there was a large
+volume of read commands being processed simultaneously, then other causes might include
+the NAND flash command queue being full, low cache page count, or cache page contention, etc.
+It is normal to expect this count to be non-zero on heavily utilized systems.</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table"><strong>Host Write Commands Stalled Percentage</strong></p></td>
+<td align="left" valign="top"><p class="table">Percentage of write commands that were stalled. If the figure is consistently high, then
+consideration should be given to spreading the data across multiple SSDs.</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table"><strong>NAND Read Commands</strong></p></td>
+<td align="left" valign="top"><p class="table">Number of read commands issued to the NAND devices during the reporting period.
+This figure will normally be much higher than the host read commands figure, as the data
+needed to satisfy a single host read command may be spread across several NAND flash devices.</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table"><strong>NAND Read Blocks</strong></p></td>
+<td align="left" valign="top"><p class="table">Number of 512-byte blocks requested from NAND flash devices during the reporting period.
+This figure would normally be about the same as the host read blocks figure</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table"><strong>Average NAND Read Size</strong></p></td>
+<td align="left" valign="top"><p class="table">Average size of NAND read commands.</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table"><strong>NAND Write Commands</strong></p></td>
+<td align="left" valign="top"><p class="table">Number of write commands issued to the NAND devices during the reporting period.
+There is no real correlation between the number of host write commands issued and the
+number of NAND Write Commands.</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table"><strong>NAND Write Blocks</strong></p></td>
+<td align="left" valign="top"><p class="table">Number of 512-byte blocks written to the NAND flash devices during the reporting period.
+This figure would normally be about the same as the host write blocks figure.</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table"><strong>Average NAND Write Size</strong></p></td>
+<td align="left" valign="top"><p class="table">Average size of NAND write commands. This figure should never be greater than 128K, as
+this is the maximum size write that is ever issued to a NAND device.</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table"><strong>NAND Read Before Write</strong></p></td>
+<td align="left" valign="top"><p class="table">This is the number of read before write operations that were required to process
+non-aligned host write commands during the reporting period. See Host Write Odd Start
+Commands and Host Write Odd End Commands. NAND Read Before Write operations have
+a detrimental effect on the overall performance of the device.</p></td>
+</tr>
+</tbody>
+</table>
+</div>
+</div>
+</div>
+<div class="sect1">
+<h2 id="_examples">EXAMPLES</h2>
+<div class="sectionbody">
+<div class="ulist"><ul>
+<li>
+<p>
+Has the program issue WDC smart-log-add Vendor Unique Command with default interval (14) :
+</p>
+<div class="listingblock">
+<div class="content">
+<pre><code># nvme wdc smart-log-add /dev/nvme0</code></pre>
+</div></div>
+</li>
+</ul></div>
+</div>
+</div>
+<div class="sect1">
+<h2 id="_nvme">NVME</h2>
+<div class="sectionbody">
+<div class="paragraph"><p>Part of the nvme-user suite.</p></div>
+</div>
+</div>
+</div>
+<div id="footnotes"><hr /></div>
+<div id="footer">
+<div id="footer-text">
+Last updated 2017-02-28 18:09:35 PST
+</div>
+</div>
+</body>
+</html>
diff --git a/Documentation/nvme-wdc-smart-log-add.txt b/Documentation/nvme-wdc-smart-log-add.txt
new file mode 100644
index 0000000..1c924be
--- /dev/null
+++ b/Documentation/nvme-wdc-smart-log-add.txt
@@ -0,0 +1,190 @@
+nvme-wdc-smart-log-add(1)
+=========================
+
+NAME
+----
+nvme-wdc-smart-log-add - Send NVMe WDC smart-log-add Vendor Unique Command, return result
+
+SYNOPSIS
+--------
+[verse]
+'nvme wdc smart-log-add' <device> [--interval=<NUM>, -i <NUM>] [--output-format=<normal|json> -o <normal|json>]
+
+DESCRIPTION
+-----------
+For the NVMe device given, send a Vendor Unique WDC smart-log-add command and
+provide the additional smart log. The --interval option will return performance
+statistics from the specified reporting interval.
+
+The <device> parameter is mandatory and may be either the NVMe character
+device (ex: /dev/nvme0).
+
+This will only work on WDC devices supporting this feature.
+Results for any other device are undefined.
+
+On success it returns 0, error code otherwise.
+
+OPTIONS
+-------
+-i <NUM>::
+--interval=<NUM>::
+	Return the statistics from specific interval, defaults to 14
+
+-o <format>::
+--output-format=<format>::
+	Set the reporting format to 'human', or
+	'json'. Only one output format can be used at a time.
+	Default is human.
+
+Valid Interval values and description :-
+
+[cols="2*", frame="topbot", align="center", options="header"]
+|===
+|Value |Description
+
+|*1*
+|Most recent five (5) minute accumulated set.
+
+|*2-12*
+|Previous five (5) minute accumulated sets.
+
+|*13*
+|The accumulated total of sets 1 through 12 that contain the previous hour of
+accumulated statistics.
+
+|*14*
+|The statistical set accumulated since power-up.
+
+|*15*
+|The statistical set accumulated during the entire lifetime of the device.
+|===
+
+Output Explanation
+------------------
+[cols="2*", frame="topbot", align="center", options="header"]
+|===
+|Field |Description
+
+|*Host Read Commands*
+|Number of host read commands received during the reporting period.
+
+|*Host Read Blocks*
+|Number of 512-byte blocks requested during the reporting period.
+
+|*Average Read Size*
+|Average Read size is calculated using (Host Read Blocks/Host Read Commands).
+
+|*Host Read Cache Hit Commands*
+|Number of host read commands that serviced entirely from the on-board read
+cache during the reporting period. No access to the NAND flash memory was required.
+This count is only updated if the entire command was serviced from the cache memory.
+
+|*Host Read Cache Hit Percentage*
+|Percentage of host read commands satisfied from the cache.
+
+|*Host Read Cache Hit Blocks*
+|Number of 512-byte blocks of data that have been returned for Host Read Cache Hit
+Commands during the reporting period. This count is only updated with the blocks
+returned for host read commands that were serviced entirely from cache memory.
+
+|*Average Read Cache Hit Size*
+|Average size of read commands satisfied from the cache.
+
+|*Host Read Commands Stalled*
+|Number of host read commands that were stalled due to a lack of resources within
+the SSD during the reporting period (NAND flash command queue full, low cache page count,
+cache page contention, etc.). Commands are not considered stalled if the only reason for
+the delay was waiting for the data to be physically read from the NAND flash. It is normal
+to expect this count to equal zero on heavily utilized systems.
+
+|*Host Read Commands Stalled Percentage*
+|Percentage of read commands that were stalled. If the figure is consistently high,
+then consideration should be given to spreading the data across multiple SSDs.
+
+|*Host Write Commands*
+|Number of host write commands received during the reporting period.
+
+|*Host Write Blocks*
+|Number of 512-byte blocks written during the reporting period.
+
+|*Average Write Size*
+|Average Write size calculated using (Host Write Blocks/Host Write Commands).
+
+|*Host Write Odd Start Commands*
+|Number of host write commands that started on a non-aligned boundary during
+the reporting period. The size of the boundary alignment is normally 4K; therefore
+this returns the number of commands that started on a non-4K aligned boundary.
+The SSD requires slightly more time to process non-aligned write commands than it
+does to process aligned write commands.
+
+|*Host Write Odd Start Commands Percentage*
+|Percentage of host write commands that started on a non-aligned boundary. If this
+figure is equal to or near 100%, and the NAND Read Before Write value is also high,
+then the user should investigate the possibility of offsetting the file system. For
+Microsoft Windows systems, the user can use Diskpart. For Unix-based operating systems,
+there is normally a method whereby file system partitions can be placed where required.
+
+|*Host Write Odd End Commands*
+|Number of host write commands that ended on a non-aligned boundary during the
+reporting period. The size of the boundary alignment is normally 4K; therefore this
+returns the number of commands that ended on a non-4K aligned boundary.
+
+|*Host Write Odd End Commands Percentage*
+|Percentage of host write commands that ended on a non-aligned boundary.
+
+|*Host Write Commands Stalled*
+|Number of host write commands that were stalled due to a lack of resources within the
+SSD during the reporting period. The most likely cause is that the write data was being
+received faster than it could be saved to the NAND flash memory. If there was a large
+volume of read commands being processed simultaneously, then other causes might include
+the NAND flash command queue being full, low cache page count, or cache page contention, etc.
+It is normal to expect this count to be non-zero on heavily utilized systems.
+
+|*Host Write Commands Stalled Percentage*
+|Percentage of write commands that were stalled. If the figure is consistently high, then
+consideration should be given to spreading the data across multiple SSDs.
+
+|*NAND Read Commands*
+|Number of read commands issued to the NAND devices during the reporting period.
+This figure will normally be much higher than the host read commands figure, as the data
+needed to satisfy a single host read command may be spread across several NAND flash devices.
+
+|*NAND Read Blocks*
+|Number of 512-byte blocks requested from NAND flash devices during the reporting period.
+This figure would normally be about the same as the host read blocks figure
+
+|*Average NAND Read Size*
+|Average size of NAND read commands.
+
+|*NAND Write Commands*
+|Number of write commands issued to the NAND devices during the reporting period.
+There is no real correlation between the number of host write commands issued and the
+number of NAND Write Commands.
+
+|*NAND Write Blocks*
+|Number of 512-byte blocks written to the NAND flash devices during the reporting period.
+This figure would normally be about the same as the host write blocks figure.
+
+|*Average NAND Write Size*
+|Average size of NAND write commands. This figure should never be greater than 128K, as
+this is the maximum size write that is ever issued to a NAND device.
+
+|*NAND Read Before Write*
+|This is the number of read before write operations that were required to process
+non-aligned host write commands during the reporting period. See Host Write Odd Start
+Commands and Host Write Odd End Commands. NAND Read Before Write operations have
+a detrimental effect on the overall performance of the device.
+|===
+
+
+EXAMPLES
+--------
+* Has the program issue WDC smart-log-add Vendor Unique Command with default interval (14) :
++
+------------
+# nvme wdc smart-log-add /dev/nvme0
+------------
+
+NVME
+----
+Part of the nvme-user suite.
-- 
1.9.1
