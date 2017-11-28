From: jeff.lien@wdc.com (Jeff Lien)
Date: Tue, 28 Nov 2017 08:29:55 -0600
Subject: [PATCH 2/2] NVMe-CLI : WDC-Plugin Documentation for Updated Smart Log
 Command
Message-ID: <20171128142955.9747-1-jeff.lien@wdc.com>

Signed-off-by: Jeff Lien <jeff.lien at wdc.com>
---
 ...dc-smart-log-add.1 => nvme-wdc-smart-add-log.1} | 168 +++++++++++++++++++--
 ...rt-log-add.html => nvme-wdc-smart-add-log.html} | 140 +++++++++++++++--
 ...mart-log-add.txt => nvme-wdc-smart-add-log.txt} |  94 +++++++++++-
 3 files changed, 371 insertions(+), 31 deletions(-)
 rename Documentation/{nvme-wdc-smart-log-add.1 => nvme-wdc-smart-add-log.1} (69%)
 rename Documentation/{nvme-wdc-smart-log-add.html => nvme-wdc-smart-add-log.html} (79%)
 rename Documentation/{nvme-wdc-smart-log-add.txt => nvme-wdc-smart-add-log.txt} (68%)

diff --git a/Documentation/nvme-wdc-smart-log-add.1 b/Documentation/nvme-wdc-smart-add-log.1
similarity index 69%
rename from Documentation/nvme-wdc-smart-log-add.1
rename to Documentation/nvme-wdc-smart-add-log.1
index 52dcdd8..fade670 100644
--- a/Documentation/nvme-wdc-smart-log-add.1
+++ b/Documentation/nvme-wdc-smart-add-log.1
@@ -1,13 +1,13 @@
 '\" t
-.\"     Title: nvme-wdc-smart-log-add
-.\"    Author: [FIXME: author] [see http://www.docbook.org/tdg5/en/html/author]
-.\" Generator: DocBook XSL Stylesheets vsnapshot <http://docbook.sf.net/>
+.\"     Title: nvme-wdc-smart-add-log
+.\"    Author: [FIXME: author] [see http://docbook.sf.net/el/author]
+.\" Generator: DocBook XSL Stylesheets v1.78.1 <http://docbook.sf.net/>
 .\"      Date: 11/27/2017
 .\"    Manual: NVMe Manual
 .\"    Source: NVMe
 .\"  Language: English
 .\"
-.TH "NVME\-WDC\-SMART\-LO" "1" "11/27/2017" "NVMe" "NVMe Manual"
+.TH "NVME\-WDC\-SMART\-AD" "1" "11/27/2017" "NVMe" "NVMe Manual"
 .\" -----------------------------------------------------------------
 .\" * Define some portability stuff
 .\" -----------------------------------------------------------------
@@ -28,15 +28,15 @@
 .\" * MAIN CONTENT STARTS HERE *
 .\" -----------------------------------------------------------------
 .SH "NAME"
-nvme-wdc-smart-log-add \- Send NVMe WDC smart\-log\-add Vendor Unique Command, return result
+nvme-wdc-smart-add-log \- Send NVMe WDC smart\-add\-log Vendor Unique Command, return result
 .SH "SYNOPSIS"
 .sp
 .nf
-\fInvme wdc smart\-log\-add\fR <device> [\-\-interval=<NUM>, \-i <NUM>] [\-\-output\-format=<normal|json> \-o <normal|json>]
+\fInvme wdc smart\-add\-log\fR <device> [\-\-interval=<NUM>, \-i <NUM>] [\-\-output\-format=<normal|json> \-o <normal|json>]
 .fi
 .SH "DESCRIPTION"
 .sp
-For the NVMe device given, send a Vendor Unique WDC smart\-log\-add command and provide the additional smart log\&. The \-\-interval option will return performance statistics from the specified reporting interval\&.
+For the NVMe device given, send a Vendor Unique WDC smart\-add\-log command and provide the additional smart log\&. The \-\-interval option will return performance statistics from the specified reporting interval\&.
 .sp
 The <device> parameter is mandatory and may be either the NVMe character device (ex: /dev/nvme0)\&.
 .sp
@@ -109,7 +109,155 @@ The statistical set accumulated during the entire lifetime of the device\&.
 T}
 .TE
 .sp 1
-.SH "OUTPUT EXPLANATION"
+.SH "CA LOG PAGE DATA OUTPUT EXPLANATION"
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
+.SH "C1 LOG PAGE DATA OUTPUT EXPLANATION"
 .TS
 allbox tab(:);
 ltB ltB.
@@ -331,13 +479,13 @@ T}
 .sp -1
 .IP \(bu 2.3
 .\}
-Has the program issue WDC smart\-log\-add Vendor Unique Command with default interval (14) :
+Has the program issue WDC smart\-add\-log Vendor Unique Command with default interval (14) :
 .sp
 .if n \{\
 .RS 4
 .\}
 .nf
-# nvme wdc smart\-log\-add /dev/nvme0
+# nvme wdc smart\-add\-log /dev/nvme0
 .fi
 .if n \{\
 .RE
diff --git a/Documentation/nvme-wdc-smart-log-add.html b/Documentation/nvme-wdc-smart-add-log.html
similarity index 79%
rename from Documentation/nvme-wdc-smart-log-add.html
rename to Documentation/nvme-wdc-smart-add-log.html
index 9698063..9d06a09 100644
--- a/Documentation/nvme-wdc-smart-log-add.html
+++ b/Documentation/nvme-wdc-smart-add-log.html
@@ -1,10 +1,11 @@
+<?xml version="1.0" encoding="UTF-8"?>
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
     "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
 <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
 <head>
 <meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
-<meta name="generator" content="AsciiDoc 8.6.8" />
-<title>nvme-wdc-smart-log-add(1)</title>
+<meta name="generator" content="AsciiDoc 8.6.10" />
+<title>nvme-wdc-smart-add-log(1)</title>
 <style type="text/css">
 /* Shared CSS for AsciiDoc xhtml11 and html5 backends */
 
@@ -94,7 +95,9 @@ ul > li > * { color: black; }
   padding: 0;
   margin: 0;
 }
-
+pre {
+  white-space: pre-wrap;
+}
 
 #author {
   color: #527bbd;
@@ -223,7 +226,7 @@ div.exampleblock > div.content {
 }
 
 div.imageblock div.content { padding-left: 0; }
-span.image img { border-style: none; }
+span.image img { border-style: none; vertical-align: text-bottom; }
 a.image:visited { color: white; }
 
 dl {
@@ -732,12 +735,12 @@ asciidoc.install();
 <body class="manpage">
 <div id="header">
 <h1>
-nvme-wdc-smart-log-add(1) Manual Page
+nvme-wdc-smart-add-log(1) Manual Page
 </h1>
 <h2>NAME</h2>
 <div class="sectionbody">
-<p>nvme-wdc-smart-log-add -
-   Send NVMe WDC smart-log-add Vendor Unique Command, return result
+<p>nvme-wdc-smart-add-log -
+   Send NVMe WDC smart-add-log Vendor Unique Command, return result
 </p>
 </div>
 </div>
@@ -746,7 +749,7 @@ nvme-wdc-smart-log-add(1) Manual Page
 <h2 id="_synopsis">SYNOPSIS</h2>
 <div class="sectionbody">
 <div class="verseblock">
-<pre class="content"><em>nvme wdc smart-log-add</em> &lt;device&gt; [--interval=&lt;NUM&gt;, -i &lt;NUM&gt;] [--output-format=&lt;normal|json&gt; -o &lt;normal|json&gt;]</pre>
+<pre class="content"><em>nvme wdc smart-add-log</em> &lt;device&gt; [--interval=&lt;NUM&gt;, -i &lt;NUM&gt;] [--output-format=&lt;normal|json&gt; -o &lt;normal|json&gt;]</pre>
 <div class="attribution">
 </div></div>
 </div>
@@ -754,7 +757,7 @@ nvme-wdc-smart-log-add(1) Manual Page
 <div class="sect1">
 <h2 id="_description">DESCRIPTION</h2>
 <div class="sectionbody">
-<div class="paragraph"><p>For the NVMe device given, send a Vendor Unique WDC smart-log-add command and
+<div class="paragraph"><p>For the NVMe device given, send a Vendor Unique WDC smart-add-log command and
 provide the additional smart log. The --interval option will return performance
 statistics from the specified reporting interval.</p></div>
 <div class="paragraph"><p>The &lt;device&gt; parameter is mandatory and may be either the NVMe character
@@ -836,7 +839,117 @@ accumulated statistics.</p></td>
 </div>
 </div>
 <div class="sect1">
-<h2 id="_output_explanation">Output Explanation</h2>
+<h2 id="_ca_log_page_data_output_explanation">CA Log Page Data Output Explanation</h2>
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
+<h2 id="_c1_log_page_data_output_explanation">C1 Log Page Data Output Explanation</h2>
 <div class="sectionbody">
 <div class="tableblock">
 <table rules="all"
@@ -999,11 +1112,11 @@ a detrimental effect on the overall performance of the device.</p></td>
 <div class="ulist"><ul>
 <li>
 <p>
-Has the program issue WDC smart-log-add Vendor Unique Command with default interval (14) :
+Has the program issue WDC smart-add-log Vendor Unique Command with default interval (14) :
 </p>
 <div class="listingblock">
 <div class="content">
-<pre><code># nvme wdc smart-log-add /dev/nvme0</code></pre>
+<pre><code># nvme wdc smart-add-log /dev/nvme0</code></pre>
 </div></div>
 </li>
 </ul></div>
@@ -1019,7 +1132,8 @@ Has the program issue WDC smart-log-add Vendor Unique Command with default inter
 <div id="footnotes"><hr /></div>
 <div id="footer">
 <div id="footer-text">
-Last updated 2017-03-01 10:14:21 EST
+Last updated
+ 2017-11-27 16:01:02 CST
 </div>
 </div>
 </body>
diff --git a/Documentation/nvme-wdc-smart-log-add.txt b/Documentation/nvme-wdc-smart-add-log.txt
similarity index 68%
rename from Documentation/nvme-wdc-smart-log-add.txt
rename to Documentation/nvme-wdc-smart-add-log.txt
index 1c924be..5abb914 100644
--- a/Documentation/nvme-wdc-smart-log-add.txt
+++ b/Documentation/nvme-wdc-smart-add-log.txt
@@ -1,18 +1,18 @@
-nvme-wdc-smart-log-add(1)
+nvme-wdc-smart-add-log(1)
 =========================
 
 NAME
 ----
-nvme-wdc-smart-log-add - Send NVMe WDC smart-log-add Vendor Unique Command, return result
+nvme-wdc-smart-add-log - Send NVMe WDC smart-add-log Vendor Unique Command, return result
 
 SYNOPSIS
 --------
 [verse]
-'nvme wdc smart-log-add' <device> [--interval=<NUM>, -i <NUM>] [--output-format=<normal|json> -o <normal|json>]
+'nvme wdc smart-add-log' <device> [--interval=<NUM>, -i <NUM>] [--output-format=<normal|json> -o <normal|json>]
 
 DESCRIPTION
 -----------
-For the NVMe device given, send a Vendor Unique WDC smart-log-add command and
+For the NVMe device given, send a Vendor Unique WDC smart-add-log command and
 provide the additional smart log. The --interval option will return performance
 statistics from the specified reporting interval.
 
@@ -59,8 +59,86 @@ accumulated statistics.
 |The statistical set accumulated during the entire lifetime of the device.
 |===
 
-Output Explanation
-------------------
+CA Log Page Data Output Explanation
+-----------------------------------
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
+|===
+
+
+C1 Log Page Data Output Explanation
+-----------------------------------
 [cols="2*", frame="topbot", align="center", options="header"]
 |===
 |Field |Description
@@ -179,10 +257,10 @@ a detrimental effect on the overall performance of the device.
 
 EXAMPLES
 --------
-* Has the program issue WDC smart-log-add Vendor Unique Command with default interval (14) :
+* Has the program issue WDC smart-add-log Vendor Unique Command with default interval (14) :
 +
 ------------
-# nvme wdc smart-log-add /dev/nvme0
+# nvme wdc smart-add-log /dev/nvme0
 ------------
 
 NVME
-- 
2.14.2.746.g8fb8a94
