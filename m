From: kwan.huen@samsung.com (kwan.huen@samsung.com)
Date: Thu, 10 Aug 2017 19:54:11 -0700
Subject: [PATCH 2/2] nvme-cli: add documentation for directive commands
In-Reply-To: <1502420051-12378-1-git-send-email-kwan.huen@samsung.com>
References: <1502420051-12378-1-git-send-email-kwan.huen@samsung.com>
 <CGME20170811025056epcas1p30aae5c55b4c1dc7a6ae9142a11bf41ed@epcas1p3.samsung.com>
Message-ID: <1502420051-12378-3-git-send-email-kwan.huen@samsung.com>

From: "Kwan (Hingkwan) Huen-SSI" <kwan.huen@samsung.com>

Signed-off-by: Kwan (Hingkwan) Huen-SSI <kwan.huen at samsung.com>
---
 Documentation/nvme-dir-receive.1    | 235 +++++++++
 Documentation/nvme-dir-receive.html | 975 +++++++++++++++++++++++++++++++++++
 Documentation/nvme-dir-receive.txt  | 118 +++++
 Documentation/nvme-dir-send.1       | 241 +++++++++
 Documentation/nvme-dir-send.html    | 988 ++++++++++++++++++++++++++++++++++++
 Documentation/nvme-dir-send.txt     | 124 +++++
 6 files changed, 2681 insertions(+)
 create mode 100644 Documentation/nvme-dir-receive.1
 create mode 100644 Documentation/nvme-dir-receive.html
 create mode 100644 Documentation/nvme-dir-receive.txt
 create mode 100644 Documentation/nvme-dir-send.1
 create mode 100644 Documentation/nvme-dir-send.html
 create mode 100644 Documentation/nvme-dir-send.txt

diff --git a/Documentation/nvme-dir-receive.1 b/Documentation/nvme-dir-receive.1
new file mode 100644
index 0000000..7b6c1db
--- /dev/null
+++ b/Documentation/nvme-dir-receive.1
@@ -0,0 +1,235 @@
+'\" t
+.\"     Title: nvme-dir-receive
+.\"    Author: [FIXME: author] [see http://docbook.sf.net/el/author]
+.\" Generator: DocBook XSL Stylesheets v1.79.1 <http://docbook.sf.net/>
+.\"      Date: 08/10/2017
+.\"    Manual: NVMe Manual
+.\"    Source: NVMe
+.\"  Language: English
+.\"
+.TH "NVME\-DIR\-RECEIVE" "1" "08/10/2017" "NVMe" "NVMe Manual"
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
+nvme-dir-receive \- Send a directive receive command, returns applicable results
+.SH "SYNOPSIS"
+.sp
+.nf
+\fInvme dir\-receive\fR <device> [\-\-namespace\-id=<nsid> | \-n <nsid>]
+                          [\-\-data\-len=<data\-len> | \-l <data\-len>]
+                          [\-\-dir\-type=<dtype> | \-D <dtype>]
+                          [\-\-dir\-spec=<dspec> | \-S <dspec>]
+                          [\-\-dir\-oper=<doper> | \-O <doper>]
+                          [\-\-req\-resource=<nsr> | \-r <nsr>]
+                          [\-\-human\-readable | \-H]
+                          [\-\-raw\-binary | \-b]
+.fi
+.SH "DESCRIPTION"
+.sp
+Submits an NVMe Directive Receive admin command and returns the applicable results\&. This may be the combination of directive type, and operation, as well as number of requested resource if specific operation needs it\&.
+.sp
+The <device> parameter is mandatory and may be either the NVMe character device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1)\&.
+.sp
+On success, the returned directive\(cqs parameter structure (if applicable) is returned in one of several ways depending on the option flags; the structure may parsed by the program and printed in a readable format if it is a known structure, displayed in hex, or the raw buffer may be printed to stdout for another program to parse\&.
+.SH "OPTIONS"
+.PP
+\-n <nsid>, \-\-namespace\-id=<nsid>
+.RS 4
+Retrieve the feature for the given nsid\&. This is optional and most features do not use this value\&.
+.RE
+.PP
+\-D <dtype>, \-\-dir\-type=<dtype>
+.RS 4
+Directive type
+.RE
+.PP
+\-S <dspec>, \-\-dir\-spec=<dspec>
+.RS 4
+Directive specific
+.RE
+.PP
+\-O <doper>, \-\-dir\-oper=<doper>
+.RS 4
+Directive operation
+.RE
+.PP
+\-r <nsr>, \-\-req\-resource=<nsr>
+.RS 4
+Directive requested resource count
+.RE
+.sp
++
+.TS
+allbox tab(:);
+lt lt
+lt lt
+lt lt
+lt lt
+lt lt
+lt lt.
+T{
+.sp
+Select
+T}:T{
+.sp
+Description
+T}
+T{
+.sp
+0
+T}:T{
+.sp
+Current
+T}
+T{
+.sp
+1
+T}:T{
+.sp
+Default
+T}
+T{
+.sp
+2
+T}:T{
+.sp
+Saved
+T}
+T{
+.sp
+3
+T}:T{
+.sp
+Supported capabilities
+T}
+T{
+.sp
+4\(en7
+T}:T{
+.sp
+Reserved
+T}
+.TE
+.sp 1
+.PP
+\-l <data\-len>, \-\-data\-len=<data\-len>
+.RS 4
+The data length for the buffer returned for this feature\&. Most known features do not use this value\&. The exception is LBA Range Type
+.RE
+.PP
+\-b, \-\-raw\-binary
+.RS 4
+Print the raw receive buffer to stdout if the command returns a structure\&.
+.RE
+.PP
+\-H, \-\-human\-readable
+.RS 4
+Print the decoded receive buffer to stdout if the command returns a structure\&.
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
+Identify directive type supported :
+.sp
+.if n \{\
+.RS 4
+.\}
+.nf
+# nvme dir\-receive /dev/nvme0 \-\-dir\-type 0 \-\-dir\-oper 1 \-\-human\-readable
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
+Get stream directive parameters :
+.sp
+.if n \{\
+.RS 4
+.\}
+.nf
+# nvme dir\-receive /dev/nvme0 \-\-dir\-type 1 \-\-dir\-oper 1 \-\-human\-readable
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
+Allocate 3 streams for namespace 1
+.sp
+.if n \{\
+.RS 4
+.\}
+.nf
+# nvme dir\-receive /dev/nvme0n1 \-\-dir\-type 1 \-\-dir\-oper 3 \-\-req\-resource 3 \-\-human\-readable
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
+Get streams directive status :
+.sp
+.if n \{\
+.RS 4
+.\}
+.nf
+# nvme dir\-receive /dev/nvme0 \-\-dir\-type 1 \-\-dir\-oper 2 \-\-human\-readable
+.fi
+.if n \{\
+.RE
+.\}
+.sp
+It is probably a bad idea to not redirect stdout when using this mode\&.
+.RE
+.SH "NVME"
+.sp
+Part of the nvme\-user suite
diff --git a/Documentation/nvme-dir-receive.html b/Documentation/nvme-dir-receive.html
new file mode 100644
index 0000000..c704e5f
--- /dev/null
+++ b/Documentation/nvme-dir-receive.html
@@ -0,0 +1,975 @@
+<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
+    "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
+<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
+<head>
+<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
+<meta name="generator" content="AsciiDoc 8.6.9" />
+<title>nvme-dir-receive(1)</title>
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
+nvme-dir-receive(1) Manual Page
+</h1>
+<h2>NAME</h2>
+<div class="sectionbody">
+<p>nvme-dir-receive -
+   Send a directive receive command, returns applicable results
+</p>
+</div>
+</div>
+<div id="content">
+<div class="sect1">
+<h2 id="_synopsis">SYNOPSIS</h2>
+<div class="sectionbody">
+<div class="verseblock">
+<pre class="content"><em>nvme dir-receive</em> &lt;device&gt; [--namespace-id=&lt;nsid&gt; | -n &lt;nsid&gt;]
+                          [--data-len=&lt;data-len&gt; | -l &lt;data-len&gt;]
+                          [--dir-type=&lt;dtype&gt; | -D &lt;dtype&gt;]
+                          [--dir-spec=&lt;dspec&gt; | -S &lt;dspec&gt;]
+                          [--dir-oper=&lt;doper&gt; | -O &lt;doper&gt;]
+                          [--req-resource=&lt;nsr&gt; | -r &lt;nsr&gt;]
+                          [--human-readable | -H]
+                          [--raw-binary | -b]</pre>
+<div class="attribution">
+</div></div>
+</div>
+</div>
+<div class="sect1">
+<h2 id="_description">DESCRIPTION</h2>
+<div class="sectionbody">
+<div class="paragraph"><p>Submits an NVMe Directive Receive admin command and returns the applicable
+results. This may be the combination of directive type, and operation, as
+well as number of requested resource if specific operation needs it.</p></div>
+<div class="paragraph"><p>The &lt;device&gt; parameter is mandatory and may be either the NVMe character
+device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1).</p></div>
+<div class="paragraph"><p>On success, the returned directive&#8217;s parameter structure (if applicable) is
+returned in one of several ways depending on the option flags; the
+structure may parsed by the program and printed in a readable format
+if it is a known structure, displayed in hex, or the raw buffer may be
+printed to stdout for another program to parse.</p></div>
+</div>
+</div>
+<div class="sect1">
+<h2 id="_options">OPTIONS</h2>
+<div class="sectionbody">
+<div class="dlist"><dl>
+<dt class="hdlist1">
+-n &lt;nsid&gt;
+</dt>
+<dt class="hdlist1">
+--namespace-id=&lt;nsid&gt;
+</dt>
+<dd>
+<p>
+        Retrieve the feature for the given nsid. This is optional and
+        most features do not use this value.
+</p>
+</dd>
+<dt class="hdlist1">
+-D &lt;dtype&gt;
+</dt>
+<dt class="hdlist1">
+--dir-type=&lt;dtype&gt;
+</dt>
+<dd>
+<p>
+        Directive type
+</p>
+</dd>
+<dt class="hdlist1">
+-S &lt;dspec&gt;
+</dt>
+<dt class="hdlist1">
+--dir-spec=&lt;dspec&gt;
+</dt>
+<dd>
+<p>
+        Directive specific
+</p>
+</dd>
+<dt class="hdlist1">
+-O &lt;doper&gt;
+</dt>
+<dt class="hdlist1">
+--dir-oper=&lt;doper&gt;
+</dt>
+<dd>
+<p>
+        Directive operation
+</p>
+</dd>
+<dt class="hdlist1">
+-r &lt;nsr&gt;
+</dt>
+<dt class="hdlist1">
+--req-resource=&lt;nsr&gt;
+</dt>
+<dd>
+<p>
+        Directive requested resource count
+</p>
+</dd>
+</dl></div>
+<div class="paragraph"><p>+</p></div>
+<div class="tableblock">
+<table rules="all"
+width="100%"
+frame="border"
+cellspacing="0" cellpadding="4">
+<col width="50%" />
+<col width="50%" />
+<tbody>
+<tr>
+<td align="left" valign="top"><p class="table">Select</p></td>
+<td align="left" valign="top"><p class="table">Description</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table">0</p></td>
+<td align="left" valign="top"><p class="table">Current</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table">1</p></td>
+<td align="left" valign="top"><p class="table">Default</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table">2</p></td>
+<td align="left" valign="top"><p class="table">Saved</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table">3</p></td>
+<td align="left" valign="top"><p class="table">Supported capabilities</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table">4?7</p></td>
+<td align="left" valign="top"><p class="table">Reserved</p></td>
+</tr>
+</tbody>
+</table>
+</div>
+<div class="dlist"><dl>
+<dt class="hdlist1">
+-l &lt;data-len&gt;
+</dt>
+<dt class="hdlist1">
+--data-len=&lt;data-len&gt;
+</dt>
+<dd>
+<p>
+        The data length for the buffer returned for this feature. Most
+        known features do not use this value. The exception is LBA
+        Range Type
+</p>
+</dd>
+<dt class="hdlist1">
+-b
+</dt>
+<dt class="hdlist1">
+--raw-binary
+</dt>
+<dd>
+<p>
+        Print the raw receive buffer to stdout if the command returns
+        a structure.
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
+        Print the decoded receive buffer to stdout if the command returns
+        a structure.
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
+Identify directive type supported :
+</p>
+<div class="listingblock">
+<div class="content">
+<pre><code># nvme dir-receive /dev/nvme0 --dir-type 0 --dir-oper 1 --human-readable</code></pre>
+</div></div>
+</li>
+<li>
+<p>
+Get stream directive parameters :
+</p>
+<div class="listingblock">
+<div class="content">
+<pre><code># nvme dir-receive /dev/nvme0 --dir-type 1 --dir-oper 1 --human-readable</code></pre>
+</div></div>
+</li>
+<li>
+<p>
+Allocate 3 streams for namespace 1
+</p>
+<div class="listingblock">
+<div class="content">
+<pre><code># nvme dir-receive /dev/nvme0n1 --dir-type 1 --dir-oper 3 --req-resource 3 --human-readable</code></pre>
+</div></div>
+</li>
+<li>
+<p>
+Get streams directive status :
+</p>
+<div class="listingblock">
+<div class="content">
+<pre><code># nvme dir-receive /dev/nvme0 --dir-type 1 --dir-oper 2 --human-readable</code></pre>
+</div></div>
+<div class="paragraph"><p>It is probably a bad idea to not redirect stdout when using this mode.</p></div>
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
+Last updated
+ 2017-08-10 18:23:42 PDT
+</div>
+</div>
+</body>
+</html>
diff --git a/Documentation/nvme-dir-receive.txt b/Documentation/nvme-dir-receive.txt
new file mode 100644
index 0000000..b412c0b
--- /dev/null
+++ b/Documentation/nvme-dir-receive.txt
@@ -0,0 +1,118 @@
+nvme-dir-receive(1)
+===================
+
+NAME
+----
+nvme-dir-receive - Send a directive receive command, returns applicable results
+
+SYNOPSIS
+--------
+[verse]
+'nvme dir-receive' <device> [--namespace-id=<nsid> | -n <nsid>]
+			  [--data-len=<data-len> | -l <data-len>]
+			  [--dir-type=<dtype> | -D <dtype>]
+			  [--dir-spec=<dspec> | -S <dspec>]
+			  [--dir-oper=<doper> | -O <doper>]
+			  [--req-resource=<nsr> | -r <nsr>]
+			  [--human-readable | -H]
+			  [--raw-binary | -b]
+
+DESCRIPTION
+-----------
+Submits an NVMe Directive Receive admin command and returns the applicable
+results. This may be the combination of directive type, and operation, as 
+well as number of requested resource if specific operation needs it.
+
+The <device> parameter is mandatory and may be either the NVMe character
+device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1).
+
+On success, the returned directive's parameter structure (if applicable) is 
+returned in one of several ways depending on the option flags; the
+structure may parsed by the program and printed in a readable format
+if it is a known structure, displayed in hex, or the raw buffer may be
+printed to stdout for another program to parse.
+
+OPTIONS
+-------
+-n <nsid>::
+--namespace-id=<nsid>::
+	Retrieve the feature for the given nsid. This is optional and
+	most features do not use this value.
+
+-D <dtype>::
+--dir-type=<dtype>::
+	Directive type	
+
+-S <dspec>::
+--dir-spec=<dspec>::
+	Directive specific	
+
+-O <doper>::
+--dir-oper=<doper>::
+	Directive operation	
+
+-r <nsr>::
+--req-resource=<nsr>::
+	Directive requested resource count
+
++
+[]
+|==================
+|Select|Description
+|0|Current 
+|1|Default 
+|2|Saved
+|3|Supported capabilities
+|4?7|Reserved
+|==================
+
+-l <data-len>::
+--data-len=<data-len>::
+	The data length for the buffer returned for this feature. Most
+	known features do not use this value. The exception is LBA
+	Range Type
+
+-b::
+--raw-binary::
+	Print the raw receive buffer to stdout if the command returns
+	a structure.
+
+-H::
+--human-readable::
+	Print the decoded receive buffer to stdout if the command returns
+	a structure.
+
+EXAMPLES
+--------
+* Identify directive type supported :
++
+------------
+# nvme dir-receive /dev/nvme0 --dir-type 0 --dir-oper 1 --human-readable
+------------
++
+
+* Get stream directive parameters : 
++
+------------
+# nvme dir-receive /dev/nvme0 --dir-type 1 --dir-oper 1 --human-readable 
+------------
++
+
+* Allocate 3 streams for namespace 1
++
+------------
+# nvme dir-receive /dev/nvme0n1 --dir-type 1 --dir-oper 3 --req-resource 3 --human-readable 
+------------
++
+
+* Get streams directive status :
++
+------------
+# nvme dir-receive /dev/nvme0 --dir-type 1 --dir-oper 2 --human-readable 
+------------
++
+It is probably a bad idea to not redirect stdout when using this mode.
+
+NVME
+----
+Part of the nvme-user suite
diff --git a/Documentation/nvme-dir-send.1 b/Documentation/nvme-dir-send.1
new file mode 100644
index 0000000..4da11bd
--- /dev/null
+++ b/Documentation/nvme-dir-send.1
@@ -0,0 +1,241 @@
+'\" t
+.\"     Title: nvme-dir-send
+.\"    Author: [FIXME: author] [see http://docbook.sf.net/el/author]
+.\" Generator: DocBook XSL Stylesheets v1.79.1 <http://docbook.sf.net/>
+.\"      Date: 08/10/2017
+.\"    Manual: NVMe Manual
+.\"    Source: NVMe
+.\"  Language: English
+.\"
+.TH "NVME\-DIR\-SEND" "1" "08/10/2017" "NVMe" "NVMe Manual"
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
+nvme-dir-send \- Issue a directive send command, returns applicable results
+.SH "SYNOPSIS"
+.sp
+.nf
+\fInvme dir\-send\fR <device> [\-\-namespace\-id=<nsid> | \-n <nsid>]
+                          [\-\-data\-len=<data\-len> | \-l <data\-len>]
+                          [\-\-dir\-type=<dtype> | \-D <dtype>]
+                          [\-\-dir\-spec=<dspec> | \-S <dspec>]
+                          [\-\-dir\-oper=<doper> | \-O <doper>]
+                          [\-\-endir=<endir> | \-e <endir>]
+                          [\-\-target\-dir=<tdir> | \-T <tdir>]
+                          [\-\-human\-readable | \-H]
+                          [\-\-raw\-binary | \-b]
+.fi
+.SH "DESCRIPTION"
+.sp
+Submits an NVMe Directive Send admin command and returns the applicable results\&. This may be the combination of directive type, and operation, as well as target directive and its enable/disable status of the operation, if specific operation needs it\&.
+.sp
+The <device> parameter is mandatory and may be either the NVMe character device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1)\&.
+.sp
+On success, the returned directive\(cqs parameter structure (if applicable) is returned in one of several ways depending on the option flags; the structure may parsed by the program and printed in a readable format if it is a known structure, displayed in hex, or the raw buffer may be printed to stdout for another program to parse\&.
+.SH "OPTIONS"
+.PP
+\-n <nsid>, \-\-namespace\-id=<nsid>
+.RS 4
+Retrieve the feature for the given nsid\&. This is optional and most features do not use this value\&.
+.RE
+.PP
+\-D <dtype>, \-\-dir\-type=<dtype>
+.RS 4
+Directive type
+.RE
+.PP
+\-S <dspec>, \-\-dir\-spec=<dspec>
+.RS 4
+Directive specific
+.RE
+.PP
+\-O <doper>, \-\-dir\-oper=<doper>
+.RS 4
+Directive operation
+.RE
+.PP
+\-T <tdir>, \-\-target\-dir=<nsr>
+.RS 4
+Target directive of the operation
+.RE
+.PP
+\-e <endir>, \-\-endir=<endir>
+.RS 4
+Target directive enable(1) or disable (0) operation
+.RE
+.sp
++
+.TS
+allbox tab(:);
+lt lt
+lt lt
+lt lt
+lt lt
+lt lt
+lt lt.
+T{
+.sp
+Select
+T}:T{
+.sp
+Description
+T}
+T{
+.sp
+0
+T}:T{
+.sp
+Current
+T}
+T{
+.sp
+1
+T}:T{
+.sp
+Default
+T}
+T{
+.sp
+2
+T}:T{
+.sp
+Saved
+T}
+T{
+.sp
+3
+T}:T{
+.sp
+Supported capabilities
+T}
+T{
+.sp
+4\(en7
+T}:T{
+.sp
+Reserved
+T}
+.TE
+.sp 1
+.PP
+\-l <data\-len>, \-\-data\-len=<data\-len>
+.RS 4
+The data length for the buffer returned for this feature\&. Most known features do not use this value\&. The exception is LBA Range Type
+.RE
+.PP
+\-b, \-\-raw\-binary
+.RS 4
+Print the raw receive buffer to stdout if the command returns a structure\&.
+.RE
+.PP
+\-H, \-\-human\-readable
+.RS 4
+Print the decoded receive buffer to stdout if the command returns a structure\&.
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
+Enable streams directive :
+.sp
+.if n \{\
+.RS 4
+.\}
+.nf
+# nvme dir\-send /dev/nvme0n1 \-\-dir\-type 0 \-\-dir\-oper 1 \-\-target\-dir 1 \-\-endir 1
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
+Disable streams directive :
+.sp
+.if n \{\
+.RS 4
+.\}
+.nf
+# nvme dir\-send /dev/nvme0n1 \-\-dir\-type 0 \-\-dir\-oper 1 \-\-target\-dir 1 \-\-endir 0
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
+Release all allocated streams resource :
+.sp
+.if n \{\
+.RS 4
+.\}
+.nf
+# nvme dir\-send /dev/nvme0n1 \-\-dir\-type 1 \-\-dir\-oper 2
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
+Release stream ID 3 :
+.sp
+.if n \{\
+.RS 4
+.\}
+.nf
+# nvme dir\-send /dev/nvme0 \-\-dir\-type 1 \-\-dir\-oper 1 \-\-dir\-spec 3
+.fi
+.if n \{\
+.RE
+.\}
+.sp
+It is probably a bad idea to not redirect stdout when using this mode\&.
+.RE
+.SH "NVME"
+.sp
+Part of the nvme\-user suite
diff --git a/Documentation/nvme-dir-send.html b/Documentation/nvme-dir-send.html
new file mode 100644
index 0000000..5aa7cdd
--- /dev/null
+++ b/Documentation/nvme-dir-send.html
@@ -0,0 +1,988 @@
+<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
+    "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
+<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
+<head>
+<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
+<meta name="generator" content="AsciiDoc 8.6.9" />
+<title>nvme-dir-send(1)</title>
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
+nvme-dir-send(1) Manual Page
+</h1>
+<h2>NAME</h2>
+<div class="sectionbody">
+<p>nvme-dir-send -
+   Issue a directive send command, returns applicable results
+</p>
+</div>
+</div>
+<div id="content">
+<div class="sect1">
+<h2 id="_synopsis">SYNOPSIS</h2>
+<div class="sectionbody">
+<div class="verseblock">
+<pre class="content"><em>nvme dir-send</em> &lt;device&gt; [--namespace-id=&lt;nsid&gt; | -n &lt;nsid&gt;]
+                          [--data-len=&lt;data-len&gt; | -l &lt;data-len&gt;]
+                          [--dir-type=&lt;dtype&gt; | -D &lt;dtype&gt;]
+                          [--dir-spec=&lt;dspec&gt; | -S &lt;dspec&gt;]
+                          [--dir-oper=&lt;doper&gt; | -O &lt;doper&gt;]
+                          [--endir=&lt;endir&gt; | -e &lt;endir&gt;]
+                          [--target-dir=&lt;tdir&gt; | -T &lt;tdir&gt;]
+                          [--human-readable | -H]
+                          [--raw-binary | -b]</pre>
+<div class="attribution">
+</div></div>
+</div>
+</div>
+<div class="sect1">
+<h2 id="_description">DESCRIPTION</h2>
+<div class="sectionbody">
+<div class="paragraph"><p>Submits an NVMe Directive Send admin command and returns the applicable
+results. This may be the combination of directive type, and operation, as
+well as target directive and its enable/disable status of the operation,
+if specific operation needs it.</p></div>
+<div class="paragraph"><p>The &lt;device&gt; parameter is mandatory and may be either the NVMe character
+device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1).</p></div>
+<div class="paragraph"><p>On success, the returned directive&#8217;s parameter structure (if applicable) is
+returned in one of several ways depending on the option flags; the
+structure may parsed by the program and printed in a readable format
+if it is a known structure, displayed in hex, or the raw buffer may be
+printed to stdout for another program to parse.</p></div>
+</div>
+</div>
+<div class="sect1">
+<h2 id="_options">OPTIONS</h2>
+<div class="sectionbody">
+<div class="dlist"><dl>
+<dt class="hdlist1">
+-n &lt;nsid&gt;
+</dt>
+<dt class="hdlist1">
+--namespace-id=&lt;nsid&gt;
+</dt>
+<dd>
+<p>
+        Retrieve the feature for the given nsid. This is optional and
+        most features do not use this value.
+</p>
+</dd>
+<dt class="hdlist1">
+-D &lt;dtype&gt;
+</dt>
+<dt class="hdlist1">
+--dir-type=&lt;dtype&gt;
+</dt>
+<dd>
+<p>
+        Directive type
+</p>
+</dd>
+<dt class="hdlist1">
+-S &lt;dspec&gt;
+</dt>
+<dt class="hdlist1">
+--dir-spec=&lt;dspec&gt;
+</dt>
+<dd>
+<p>
+        Directive specific
+</p>
+</dd>
+<dt class="hdlist1">
+-O &lt;doper&gt;
+</dt>
+<dt class="hdlist1">
+--dir-oper=&lt;doper&gt;
+</dt>
+<dd>
+<p>
+        Directive operation
+</p>
+</dd>
+<dt class="hdlist1">
+-T &lt;tdir&gt;
+</dt>
+<dt class="hdlist1">
+--target-dir=&lt;nsr&gt;
+</dt>
+<dd>
+<p>
+        Target directive of the operation
+</p>
+</dd>
+<dt class="hdlist1">
+-e &lt;endir&gt;
+</dt>
+<dt class="hdlist1">
+--endir=&lt;endir&gt;
+</dt>
+<dd>
+<p>
+        Target directive enable(1) or disable (0) operation
+</p>
+</dd>
+</dl></div>
+<div class="paragraph"><p>+</p></div>
+<div class="tableblock">
+<table rules="all"
+width="100%"
+frame="border"
+cellspacing="0" cellpadding="4">
+<col width="50%" />
+<col width="50%" />
+<tbody>
+<tr>
+<td align="left" valign="top"><p class="table">Select</p></td>
+<td align="left" valign="top"><p class="table">Description</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table">0</p></td>
+<td align="left" valign="top"><p class="table">Current</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table">1</p></td>
+<td align="left" valign="top"><p class="table">Default</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table">2</p></td>
+<td align="left" valign="top"><p class="table">Saved</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table">3</p></td>
+<td align="left" valign="top"><p class="table">Supported capabilities</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table">4?7</p></td>
+<td align="left" valign="top"><p class="table">Reserved</p></td>
+</tr>
+</tbody>
+</table>
+</div>
+<div class="dlist"><dl>
+<dt class="hdlist1">
+-l &lt;data-len&gt;
+</dt>
+<dt class="hdlist1">
+--data-len=&lt;data-len&gt;
+</dt>
+<dd>
+<p>
+        The data length for the buffer returned for this feature. Most
+        known features do not use this value. The exception is LBA
+        Range Type
+</p>
+</dd>
+<dt class="hdlist1">
+-b
+</dt>
+<dt class="hdlist1">
+--raw-binary
+</dt>
+<dd>
+<p>
+        Print the raw receive buffer to stdout if the command returns
+        a structure.
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
+        Print the decoded receive buffer to stdout if the command returns
+        a structure.
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
+Enable streams directive :
+</p>
+<div class="listingblock">
+<div class="content">
+<pre><code># nvme dir-send /dev/nvme0n1 --dir-type 0 --dir-oper 1 --target-dir 1 --endir 1</code></pre>
+</div></div>
+</li>
+<li>
+<p>
+Disable streams directive :
+</p>
+<div class="listingblock">
+<div class="content">
+<pre><code># nvme dir-send /dev/nvme0n1 --dir-type 0 --dir-oper 1 --target-dir 1 --endir 0</code></pre>
+</div></div>
+</li>
+<li>
+<p>
+Release all allocated streams resource :
+</p>
+<div class="listingblock">
+<div class="content">
+<pre><code># nvme dir-send /dev/nvme0n1 --dir-type 1 --dir-oper 2</code></pre>
+</div></div>
+</li>
+<li>
+<p>
+Release stream ID 3 :
+</p>
+<div class="listingblock">
+<div class="content">
+<pre><code># nvme dir-send /dev/nvme0 --dir-type 1 --dir-oper 1 --dir-spec 3</code></pre>
+</div></div>
+<div class="paragraph"><p>It is probably a bad idea to not redirect stdout when using this mode.</p></div>
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
+Last updated
+ 2017-08-10 19:09:21 PDT
+</div>
+</div>
+</body>
+</html>
diff --git a/Documentation/nvme-dir-send.txt b/Documentation/nvme-dir-send.txt
new file mode 100644
index 0000000..eb5dad0
--- /dev/null
+++ b/Documentation/nvme-dir-send.txt
@@ -0,0 +1,124 @@
+nvme-dir-send(1)
+================
+
+NAME
+----
+nvme-dir-send - Issue a directive send command, returns applicable results
+
+SYNOPSIS
+--------
+[verse]
+'nvme dir-send' <device> [--namespace-id=<nsid> | -n <nsid>]
+			  [--data-len=<data-len> | -l <data-len>]
+			  [--dir-type=<dtype> | -D <dtype>]
+			  [--dir-spec=<dspec> | -S <dspec>]
+			  [--dir-oper=<doper> | -O <doper>]
+			  [--endir=<endir> | -e <endir>]
+			  [--target-dir=<tdir> | -T <tdir>]
+			  [--human-readable | -H]
+			  [--raw-binary | -b]
+
+DESCRIPTION
+-----------
+Submits an NVMe Directive Send admin command and returns the applicable
+results. This may be the combination of directive type, and operation, as
+well as target directive and its enable/disable status of the operation,
+if specific operation needs it.
+
+The <device> parameter is mandatory and may be either the NVMe character
+device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1).
+
+On success, the returned directive's parameter structure (if applicable) is
+returned in one of several ways depending on the option flags; the
+structure may parsed by the program and printed in a readable format
+if it is a known structure, displayed in hex, or the raw buffer may be
+printed to stdout for another program to parse.
+
+OPTIONS
+-------
+-n <nsid>::
+--namespace-id=<nsid>::
+	Retrieve the feature for the given nsid. This is optional and
+	most features do not use this value.
+
+-D <dtype>::
+--dir-type=<dtype>::
+	Directive type	
+
+-S <dspec>::
+--dir-spec=<dspec>::
+	Directive specific	
+
+-O <doper>::
+--dir-oper=<doper>::
+	Directive operation	
+
+-T <tdir>::
+--target-dir=<nsr>::
+	Target directive of the operation
+
+-e <endir>::
+--endir=<endir>::
+	Target directive enable(1) or disable (0) operation
+
++
+[]
+|==================
+|Select|Description
+|0|Current 
+|1|Default 
+|2|Saved
+|3|Supported capabilities
+|4?7|Reserved
+|==================
+
+-l <data-len>::
+--data-len=<data-len>::
+	The data length for the buffer returned for this feature. Most
+	known features do not use this value. The exception is LBA
+	Range Type
+
+-b::
+--raw-binary::
+	Print the raw receive buffer to stdout if the command returns
+	a structure.
+
+-H::
+--human-readable::
+	Print the decoded receive buffer to stdout if the command returns
+	a structure.
+
+EXAMPLES
+--------
+* Enable streams directive :
++
+------------
+# nvme dir-send /dev/nvme0n1 --dir-type 0 --dir-oper 1 --target-dir 1 --endir 1
+------------
++
+
+* Disable streams directive :
++
+------------
+# nvme dir-send /dev/nvme0n1 --dir-type 0 --dir-oper 1 --target-dir 1 --endir 0
+------------
++
+
+* Release all allocated streams resource :
++
+------------
+# nvme dir-send /dev/nvme0n1 --dir-type 1 --dir-oper 2
+------------
++
+
+* Release stream ID 3 :
++
+------------
+# nvme dir-send /dev/nvme0 --dir-type 1 --dir-oper 1 --dir-spec 3
+------------
++
+It is probably a bad idea to not redirect stdout when using this mode.
+
+NVME
+----
+Part of the nvme-user suite
-- 
2.7.4
