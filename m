From: jeff.lien@wdc.com (jeffreyalien)
Date: Wed,  8 Nov 2017 10:50:29 -0600
Subject: [PATCH 2/2] NVMe-CLI : WDC-PLUGIN Updated documentation files for
 Smart Log Commands
Message-ID: <20171108165029.29048-1-jeff.lien@wdc.com>

From: Jeff Lien <jlien@ddtest-jeff.hgst.com>

Signed-off-by: Jeff Lien <jlien at ddtest-jeff.hgst.com>
---
 Documentation/nvme-wdc-vs-smart-add-log-c1.1    |  348 ++++++++
 Documentation/nvme-wdc-vs-smart-add-log-c1.html | 1026 +++++++++++++++++++++++
 Documentation/nvme-wdc-vs-smart-add-log-c1.txt  |  190 +++++
 Documentation/nvme-wdc-vs-smart-add-log.1       |  226 +++++
 Documentation/nvme-wdc-vs-smart-add-log.html    |  926 ++++++++++++++++++++
 Documentation/nvme-wdc-vs-smart-add-log.txt     |  123 +++
 6 files changed, 2839 insertions(+)
 create mode 100644 Documentation/nvme-wdc-vs-smart-add-log-c1.1
 create mode 100644 Documentation/nvme-wdc-vs-smart-add-log-c1.html
 create mode 100644 Documentation/nvme-wdc-vs-smart-add-log-c1.txt
 create mode 100644 Documentation/nvme-wdc-vs-smart-add-log.1
 create mode 100644 Documentation/nvme-wdc-vs-smart-add-log.html
 create mode 100644 Documentation/nvme-wdc-vs-smart-add-log.txt

diff --git a/Documentation/nvme-wdc-vs-smart-add-log-c1.1 b/Documentation/nvme-wdc-vs-smart-add-log-c1.1
new file mode 100644
index 0000000..ad06774
--- /dev/null
+++ b/Documentation/nvme-wdc-vs-smart-add-log-c1.1
@@ -0,0 +1,348 @@
+'\" t
+.\"     Title: nvme-wdc-vs-smart-add-log-c1
+.\"    Author: [FIXME: author] [see http://docbook.sf.net/el/author]
+.\" Generator: DocBook XSL Stylesheets v1.78.1 <http://docbook.sf.net/>
+.\"      Date: 08/07/2017
+.\"    Manual: NVMe Manual
+.\"    Source: NVMe
+.\"  Language: English
+.\"
+.TH "NVME\-WDC\-VS\-SMART" "1" "08/07/2017" "NVMe" "NVMe Manual"
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
+nvme-wdc-vs-smart-add-log-c1 \- Send NVMe WDC vs\-smart\-add\-log\-c1 Vendor Unique Command, return result
+.SH "SYNOPSIS"
+.sp
+.nf
+\fInvme wdc vs\-smart\-add\-log\-c1\fR <device> [\-\-interval=<NUM>, \-i <NUM>] [\-\-output\-format=<normal|json> \-o <normal|json>]
+.fi
+.SH "DESCRIPTION"
+.sp
+For the NVMe device given, send a Vendor Unique WDC vs\-smart\-add\-log\-c1 command and provide the additional smart log\&. The \-\-interval option will return performance statistics from the specified reporting interval\&.
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
+Has the program issue WDC vs\-smart\-add\-log\-c1 Vendor Unique Command with default interval (14) :
+.sp
+.if n \{\
+.RS 4
+.\}
+.nf
+# nvme wdc vs\-smart\-add\-log\-c1 /dev/nvme0
+.fi
+.if n \{\
+.RE
+.\}
+.RE
+.SH "NVME"
+.sp
+Part of the nvme\-user suite\&.
diff --git a/Documentation/nvme-wdc-vs-smart-add-log-c1.html b/Documentation/nvme-wdc-vs-smart-add-log-c1.html
new file mode 100644
index 0000000..9bc730d
--- /dev/null
+++ b/Documentation/nvme-wdc-vs-smart-add-log-c1.html
@@ -0,0 +1,1026 @@
+<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
+    "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
+<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
+<head>
+<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
+<meta name="generator" content="AsciiDoc 8.6.8" />
+<title>nvme-wdc-vs-smart-add-log-c1(1)</title>
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
+
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
+nvme-wdc-vs-smart-add-log-c1(1) Manual Page
+</h1>
+<h2>NAME</h2>
+<div class="sectionbody">
+<p>nvme-wdc-vs-smart-add-log-c1 -
+   Send NVMe WDC vs-smart-add-log-c1 Vendor Unique Command, return result
+</p>
+</div>
+</div>
+<div id="content">
+<div class="sect1">
+<h2 id="_synopsis">SYNOPSIS</h2>
+<div class="sectionbody">
+<div class="verseblock">
+<pre class="content"><em>nvme wdc vs-smart-add-log-c1</em> &lt;device&gt; [--interval=&lt;NUM&gt;, -i &lt;NUM&gt;] [--output-format=&lt;normal|json&gt; -o &lt;normal|json&gt;]</pre>
+<div class="attribution">
+</div></div>
+</div>
+</div>
+<div class="sect1">
+<h2 id="_description">DESCRIPTION</h2>
+<div class="sectionbody">
+<div class="paragraph"><p>For the NVMe device given, send a Vendor Unique WDC vs-smart-add-log-c1 command and
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
+Has the program issue WDC vs-smart-add-log-c1 Vendor Unique Command with default interval (14) :
+</p>
+<div class="listingblock">
+<div class="content">
+<pre><code># nvme wdc vs-smart-add-log-c1 /dev/nvme0</code></pre>
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
+Last updated 2017-08-07 14:03:47 CDT
+</div>
+</div>
+</body>
+</html>
diff --git a/Documentation/nvme-wdc-vs-smart-add-log-c1.txt b/Documentation/nvme-wdc-vs-smart-add-log-c1.txt
new file mode 100644
index 0000000..b71a72b
--- /dev/null
+++ b/Documentation/nvme-wdc-vs-smart-add-log-c1.txt
@@ -0,0 +1,190 @@
+nvme-wdc-vs-smart-add-log-c1(1)
+===============================
+
+NAME
+----
+nvme-wdc-vs-smart-add-log-c1 - Send NVMe WDC vs-smart-add-log-c1 Vendor Unique Command, return result
+
+SYNOPSIS
+--------
+[verse]
+'nvme wdc vs-smart-add-log-c1' <device> [--interval=<NUM>, -i <NUM>] [--output-format=<normal|json> -o <normal|json>]
+
+DESCRIPTION
+-----------
+For the NVMe device given, send a Vendor Unique WDC vs-smart-add-log-c1 command and
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
+* Has the program issue WDC vs-smart-add-log-c1 Vendor Unique Command with default interval (14) :
++
+------------
+# nvme wdc vs-smart-add-log-c1 /dev/nvme0
+------------
+
+NVME
+----
+Part of the nvme-user suite.
diff --git a/Documentation/nvme-wdc-vs-smart-add-log.1 b/Documentation/nvme-wdc-vs-smart-add-log.1
new file mode 100644
index 0000000..f618183
--- /dev/null
+++ b/Documentation/nvme-wdc-vs-smart-add-log.1
@@ -0,0 +1,226 @@
+'\" t
+.\"     Title: nvme-wdc-vs-smart-add-log
+.\"    Author: [FIXME: author] [see http://docbook.sf.net/el/author]
+.\" Generator: DocBook XSL Stylesheets v1.78.1 <http://docbook.sf.net/>
+.\"      Date: 08/07/2017
+.\"    Manual: NVMe Manual
+.\"    Source: NVMe
+.\"  Language: English
+.\"
+.TH "NVME\-WDC\-VS\-SMART" "1" "08/07/2017" "NVMe" "NVMe Manual"
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
+nvme-wdc-vs-smart-add-log \- Send NVMe WDC vs\-smart\-add\-log Vendor Unique Command, return result
+.SH "SYNOPSIS"
+.sp
+.nf
+\fInvme wdc vs\-smart\-add\-log\fR <device> [\-\-output\-format=<normal|json> \-o <normal|json>]
+.fi
+.SH "DESCRIPTION"
+.sp
+For the NVMe device given, send a Vendor Unique WDC vs\-smart\-add\-log command and provide the additional smart CA log\&.
+.sp
+The <device> parameter is mandatory and may be either the NVMe character device (ex: /dev/nvme0)\&.
+.sp
+This will only work on WDC devices supporting this feature\&. Results for any other device are undefined\&.
+.sp
+On success it returns 0, error code otherwise\&.
+.SH "OPTIONS"
+.PP
+\-o <format>, \-\-output\-format=<format>
+.RS 4
+Set the reporting format to
+\fIhuman\fR, or
+\fIjson\fR\&. Only one output format can be used at a time\&. Default is human\&.
+.RE
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
+lt lt.
+T{
+.sp
+\fBPhysical NAND bytes written\&.\fR
+T}:T{
+.sp
+The number of bytes written to NAND\&. 16 bytes \- hi/lo
+T}
+T{
+.sp
+\fBPhysical NAND bytes read\fR
+T}:T{
+.sp
+The number of bytes read from NAND\&. 16 bytes \- hi/lo
+T}
+T{
+.sp
+\fBBad NAND Block Count\fR
+T}:T{
+.sp
+Raw and normalized count of the number of NAND blocks that have been retired after the drives manufacturing tests (i\&.e\&. grown back blocks)\&. 2 bytes normalized, 6 bytes raw count
+T}
+T{
+.sp
+\fBUncorrectable Read Error Count\fR
+T}:T{
+.sp
+Total count of NAND reads that were not correctable by read retries, all levels of ECC, or XOR (as applicable)\&. 8 bytes
+T}
+T{
+.sp
+\fBSoft ECC Error Count\fR
+T}:T{
+.sp
+Total count of NAND reads that were not correctable by read retries, or first\-level ECC\&. 8 bytes
+T}
+T{
+.sp
+\fBSSD End to End Detection Count\fR
+T}:T{
+.sp
+A count of the detected errors by the SSD end to end error correction which includes DRAM, SRAM, or other storage element ECC/CRC protection mechanism (not NAND ECC)\&. 4 bytes
+T}
+T{
+.sp
+\fBSSD End to End Correction Count\fR
+T}:T{
+.sp
+A count of the corrected errors by the SSD end to end error correction which includes DRAM, SRAM, or other storage element ECC/CRC protection mechanism (not NAND ECC)\&. 4 bytes
+T}
+T{
+.sp
+\fBSystem Data % Used\fR
+T}:T{
+.sp
+A normalized cumulative count of the number of erase cycles per block since leaving the factory for the system (FW and metadata) area\&. Starts at 0 and increments\&. 100 indicates that the estimated endurance has been consumed\&.
+T}
+T{
+.sp
+\fBUser Data Max Erase Count\fR
+T}:T{
+.sp
+The maximum erase count across all NAND blocks in the drive\&. 4 bytes
+T}
+T{
+.sp
+\fBUser Data Min Erase Count\fR
+T}:T{
+.sp
+The minimum erase count across all NAND blocks in the drive\&. 4 bytes
+T}
+T{
+.sp
+\fBRefresh Count\fR
+T}:T{
+.sp
+A count of the number of blocks that have been re\-allocated due to background operations only\&. 8 bytes
+T}
+T{
+.sp
+\fBProgram Fail Count\fR
+T}:T{
+.sp
+Raw and normalized count of total program failures\&. Normalized count starts at 100 and shows the percent of remaining allowable failures\&. 2 bytes normalized, 6 bytes raw count
+T}
+T{
+.sp
+\fBUser Data Erase Fail Count\fR
+T}:T{
+.sp
+Raw and normalized count of total erase failures in the user area\&. Normalized count starts at 100 and shows the percent of remaining allowable failures\&. 2 bytes normalized, 6 bytes raw count
+T}
+T{
+.sp
+\fBSystem Area Erase Fail Count\fR
+T}:T{
+.sp
+Raw and normalized count of total erase failures in the system area\&. Normalized count starts at 100 and shows the percent of remaining allowable failures\&. 2 bytes normalized, 6 bytes raw count
+T}
+T{
+.sp
+\fBThermal Throttling Status\fR
+T}:T{
+.sp
+The current status of thermal throttling (enabled or disabled)\&. 2 bytes
+T}
+T{
+.sp
+\fBThermal Throttling Count\fR
+T}:T{
+.sp
+A count of the number of thermal throttling events\&. 2 bytes
+T}
+T{
+.sp
+\fBPCIe Correctable Error Count\fR
+T}:T{
+.sp
+Summation counter of all PCIe correctable errors (Bad TLP, Bad DLLP, Receiver error, Replay timeouts, Replay rollovers)\&. 8 bytes
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
+Has the program issue WDC vs\-smart\-add\-log Vendor Unique Command :
+.sp
+.if n \{\
+.RS 4
+.\}
+.nf
+# nvme wdc vs\-smart\-add\-log /dev/nvme0
+.fi
+.if n \{\
+.RE
+.\}
+.RE
+.SH "NVME"
+.sp
+Part of the nvme\-user suite\&.
diff --git a/Documentation/nvme-wdc-vs-smart-add-log.html b/Documentation/nvme-wdc-vs-smart-add-log.html
new file mode 100644
index 0000000..62148eb
--- /dev/null
+++ b/Documentation/nvme-wdc-vs-smart-add-log.html
@@ -0,0 +1,926 @@
+<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
+    "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
+<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
+<head>
+<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
+<meta name="generator" content="AsciiDoc 8.6.8" />
+<title>nvme-wdc-vs-smart-add-log(1)</title>
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
+
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
+nvme-wdc-vs-smart-add-log(1) Manual Page
+</h1>
+<h2>NAME</h2>
+<div class="sectionbody">
+<p>nvme-wdc-vs-smart-add-log -
+   Send NVMe WDC vs-smart-add-log Vendor Unique Command, return result
+</p>
+</div>
+</div>
+<div id="content">
+<div class="sect1">
+<h2 id="_synopsis">SYNOPSIS</h2>
+<div class="sectionbody">
+<div class="verseblock">
+<pre class="content"><em>nvme wdc vs-smart-add-log</em> &lt;device&gt; [--output-format=&lt;normal|json&gt; -o &lt;normal|json&gt;]</pre>
+<div class="attribution">
+</div></div>
+</div>
+</div>
+<div class="sect1">
+<h2 id="_description">DESCRIPTION</h2>
+<div class="sectionbody">
+<div class="paragraph"><p>For the NVMe device given, send a Vendor Unique WDC vs-smart-add-log command and
+provide the additional smart CA log.</p></div>
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
+<td align="left" valign="top"><p class="table"><strong>Physical NAND bytes written.</strong></p></td>
+<td align="left" valign="top"><p class="table">The number of bytes written to NAND.  16 bytes - hi/lo</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table"><strong>Physical NAND bytes read</strong></p></td>
+<td align="left" valign="top"><p class="table">The number of bytes read from NAND.  16 bytes - hi/lo</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table"><strong>Bad NAND Block Count</strong></p></td>
+<td align="left" valign="top"><p class="table">Raw and normalized count of the number of NAND blocks that have been
+retired after the drives manufacturing tests (i.e. grown back blocks).
+2 bytes normalized, 6 bytes raw count</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table"><strong>Uncorrectable Read Error Count</strong></p></td>
+<td align="left" valign="top"><p class="table">Total count of NAND reads that were not correctable by read retries, all
+levels of ECC, or XOR (as applicable).  8 bytes</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table"><strong>Soft ECC Error Count</strong></p></td>
+<td align="left" valign="top"><p class="table">Total count of NAND reads that were not correctable by read retries, or
+first-level ECC.  8 bytes</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table"><strong>SSD End to End Detection Count</strong></p></td>
+<td align="left" valign="top"><p class="table">A count of the detected errors by the SSD end to end error correction which
+includes DRAM, SRAM, or other storage element ECC/CRC protection mechanism (not
+NAND ECC).  4 bytes</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table"><strong>SSD End to End Correction Count</strong></p></td>
+<td align="left" valign="top"><p class="table">A count of the corrected errors by the SSD end to end error correction which
+includes DRAM, SRAM, or other storage element ECC/CRC protection mechanism (not
+NAND ECC).  4 bytes</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table"><strong>System Data % Used</strong></p></td>
+<td align="left" valign="top"><p class="table">A normalized cumulative count of the number of erase cycles per block since
+leaving the factory for the system (FW and metadata) area. Starts at 0 and
+increments. 100 indicates that the estimated endurance has been consumed.</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table"><strong>User Data Max Erase Count</strong></p></td>
+<td align="left" valign="top"><p class="table">The maximum erase count across all NAND blocks in the drive.  4 bytes</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table"><strong>User Data Min Erase Count</strong></p></td>
+<td align="left" valign="top"><p class="table">The minimum erase count across all NAND blocks in the drive.  4 bytes</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table"><strong>Refresh Count</strong></p></td>
+<td align="left" valign="top"><p class="table">A count of the number of blocks that have been re-allocated due to
+background operations only.  8 bytes</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table"><strong>Program Fail Count</strong></p></td>
+<td align="left" valign="top"><p class="table">Raw and normalized count of total program failures. Normalized count
+starts at 100 and shows the percent of remaining allowable failures.
+2 bytes normalized, 6 bytes raw count</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table"><strong>User Data Erase Fail Count</strong></p></td>
+<td align="left" valign="top"><p class="table">Raw and normalized count of total erase failures in the user area.
+Normalized count starts at 100 and shows the percent of remaining
+allowable failures.  2 bytes normalized, 6 bytes raw count</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table"><strong>System Area Erase Fail Count</strong></p></td>
+<td align="left" valign="top"><p class="table">Raw and normalized count of total erase failures in the system area.
+Normalized count starts at 100 and shows the percent of remaining
+allowable failures.  2 bytes normalized, 6 bytes raw count</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table"><strong>Thermal Throttling Status</strong></p></td>
+<td align="left" valign="top"><p class="table">The current status of thermal throttling (enabled or disabled).
+2 bytes</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table"><strong>Thermal Throttling Count</strong></p></td>
+<td align="left" valign="top"><p class="table">A count of the number of thermal throttling events.  2 bytes</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table"><strong>PCIe Correctable Error Count</strong></p></td>
+<td align="left" valign="top"><p class="table">Summation counter of all PCIe correctable errors (Bad TLP, Bad
+DLLP, Receiver error, Replay timeouts, Replay rollovers).  8 bytes</p></td>
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
+Has the program issue WDC vs-smart-add-log Vendor Unique Command :
+</p>
+<div class="listingblock">
+<div class="content">
+<pre><code># nvme wdc vs-smart-add-log /dev/nvme0</code></pre>
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
+Last updated 2017-08-07 14:03:47 CDT
+</div>
+</div>
+</body>
+</html>
diff --git a/Documentation/nvme-wdc-vs-smart-add-log.txt b/Documentation/nvme-wdc-vs-smart-add-log.txt
new file mode 100644
index 0000000..b3e1a8f
--- /dev/null
+++ b/Documentation/nvme-wdc-vs-smart-add-log.txt
@@ -0,0 +1,123 @@
+nvme-wdc-vs-smart-add-log(1)
+============================
+
+NAME
+----
+nvme-wdc-vs-smart-add-log - Send NVMe WDC vs-smart-add-log Vendor Unique Command, return result
+
+SYNOPSIS
+--------
+[verse]
+'nvme wdc vs-smart-add-log' <device> [--output-format=<normal|json> -o <normal|json>]
+
+DESCRIPTION
+-----------
+For the NVMe device given, send a Vendor Unique WDC vs-smart-add-log command and
+provide the additional smart CA log.
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
+-o <format>::
+--output-format=<format>::
+	Set the reporting format to 'human', or
+	'json'. Only one output format can be used at a time.
+	Default is human.
+
+Output Explanation
+------------------
+[cols="2*", frame="topbot", align="center", options="header"]
+|===
+|Field |Description
+
+|*Physical NAND bytes written.*
+|The number of bytes written to NAND.  16 bytes - hi/lo
+
+|*Physical NAND bytes read*
+|The number of bytes read from NAND.  16 bytes - hi/lo
+
+|*Bad NAND Block Count*
+|Raw and normalized count of the number of NAND blocks that have been
+retired after the drives manufacturing tests (i.e. grown back blocks).
+2 bytes normalized, 6 bytes raw count
+
+|*Uncorrectable Read Error Count*
+|Total count of NAND reads that were not correctable by read retries, all
+levels of ECC, or XOR (as applicable).  8 bytes
+
+|*Soft ECC Error Count*
+|Total count of NAND reads that were not correctable by read retries, or
+first-level ECC.  8 bytes
+
+|*SSD End to End Detection Count*
+|A count of the detected errors by the SSD end to end error correction which
+includes DRAM, SRAM, or other storage element ECC/CRC protection mechanism (not
+NAND ECC).  4 bytes
+
+|*SSD End to End Correction Count*
+|A count of the corrected errors by the SSD end to end error correction which
+includes DRAM, SRAM, or other storage element ECC/CRC protection mechanism (not
+NAND ECC).  4 bytes
+
+|*System Data % Used*
+|A normalized cumulative count of the number of erase cycles per block since
+leaving the factory for the system (FW and metadata) area. Starts at 0 and
+increments. 100 indicates that the estimated endurance has been consumed.
+
+|*User Data Max Erase Count*
+|The maximum erase count across all NAND blocks in the drive.  4 bytes
+
+|*User Data Min Erase Count*
+|The minimum erase count across all NAND blocks in the drive.  4 bytes
+
+|*Refresh Count*
+|A count of the number of blocks that have been re-allocated due to
+background operations only.  8 bytes
+
+|*Program Fail Count*
+|Raw and normalized count of total program failures. Normalized count
+starts at 100 and shows the percent of remaining allowable failures.
+2 bytes normalized, 6 bytes raw count
+
+|*User Data Erase Fail Count*
+|Raw and normalized count of total erase failures in the user area.
+Normalized count starts at 100 and shows the percent of remaining
+allowable failures.  2 bytes normalized, 6 bytes raw count
+
+|*System Area Erase Fail Count*
+|Raw and normalized count of total erase failures in the system area.
+Normalized count starts at 100 and shows the percent of remaining
+allowable failures.  2 bytes normalized, 6 bytes raw count
+
+|*Thermal Throttling Status*
+|The current status of thermal throttling (enabled or disabled).
+2 bytes
+
+|*Thermal Throttling Count*
+|A count of the number of thermal throttling events.  2 bytes
+
+|*PCIe Correctable Error Count*
+|Summation counter of all PCIe correctable errors (Bad TLP, Bad
+DLLP, Receiver error, Replay timeouts, Replay rollovers).  8 bytes
+
+|===
+
+
+EXAMPLES
+--------
+* Has the program issue WDC vs-smart-add-log Vendor Unique Command :
++
+------------
+# nvme wdc vs-smart-add-log /dev/nvme0
+------------
+
+NVME
+----
+Part of the nvme-user suite.
-- 
2.14.2.746.g8fb8a94
