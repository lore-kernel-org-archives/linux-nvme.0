From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sat, 27 Jan 2018 02:20:48 +0900
Subject: [PATCH] nvme-cli: update documentations to sync up with subcommands
Message-ID: <1516987248-26845-1-git-send-email-minwoo.im.dev@gmail.com>

Update all documentations to sync up with built-in plugin subcommands.
Not only options supported by subcommands, But few descriptions have not
been updated with implementations.

Sync-up documentation with subcommands implementations.

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 Documentation/cmds-main.txt            |    6 +
 Documentation/nvme-admin-passthru.1    |   19 +-
 Documentation/nvme-admin-passthru.html |   27 +-
 Documentation/nvme-admin-passthru.txt  |   11 +-
 Documentation/nvme-compare.1           |  158 ++-
 Documentation/nvme-compare.html        |  267 ++++-
 Documentation/nvme-compare.txt         |  108 +-
 Documentation/nvme-format.1            |    6 +-
 Documentation/nvme-format.html         |   13 +-
 Documentation/nvme-format.txt          |    2 +-
 Documentation/nvme-get-feature.1       |   10 +-
 Documentation/nvme-get-feature.html    |   26 +-
 Documentation/nvme-get-feature.txt     |    6 +
 Documentation/nvme-get-log.1           |   16 +-
 Documentation/nvme-get-log.html        |   38 +-
 Documentation/nvme-get-log.txt         |   11 +
 Documentation/nvme-id-ns.1             |    5 +-
 Documentation/nvme-id-ns.html          |   12 +-
 Documentation/nvme-id-ns.txt           |    1 +
 Documentation/nvme-io-passthru.1       |   14 +-
 Documentation/nvme-io-passthru.html    |   20 +-
 Documentation/nvme-io-passthru.txt     |    9 +-
 Documentation/nvme-list-ns.1           |   10 +-
 Documentation/nvme-list-ns.html        |   26 +-
 Documentation/nvme-list-ns.txt         |    6 +
 Documentation/nvme-ns-descs.1          |  115 +++
 Documentation/nvme-ns-descs.html       |  863 ++++++++++++++++
 Documentation/nvme-ns-descs.txt        |   74 ++
 Documentation/nvme-read.1              |   41 +-
 Documentation/nvme-read.html           |   92 +-
 Documentation/nvme-read.txt            |   44 +-
 Documentation/nvme-resv-acquire.1      |   11 +-
 Documentation/nvme-resv-acquire.html   |   18 +-
 Documentation/nvme-resv-acquire.txt    |    7 +-
 Documentation/nvme-resv-register.1     |   11 +-
 Documentation/nvme-resv-register.html  |   18 +-
 Documentation/nvme-resv-register.txt   |    7 +-
 Documentation/nvme-resv-release.1      |   10 +-
 Documentation/nvme-resv-release.html   |   17 +-
 Documentation/nvme-resv-release.txt    |    6 +-
 Documentation/nvme-resv-report.1       |    9 +-
 Documentation/nvme-resv-report.html    |   16 +-
 Documentation/nvme-resv-report.txt     |    5 +-
 Documentation/nvme-sanitize-log.1      |   28 +-
 Documentation/nvme-sanitize-log.html   | 1735 ++++++++++++++++----------------
 Documentation/nvme-sanitize-log.txt    |   19 +-
 Documentation/nvme-security-recv.1     |   12 +-
 Documentation/nvme-security-recv.html  |   19 +-
 Documentation/nvme-security-recv.txt   |    8 +-
 Documentation/nvme-security-send.1     |    6 +-
 Documentation/nvme-security-send.html  |   13 +-
 Documentation/nvme-security-send.txt   |    2 +-
 Documentation/nvme-telemetry-log.1     |   82 ++
 Documentation/nvme-telemetry-log.html  |  831 +++++++++++++++
 Documentation/nvme-telemetry-log.txt   |   48 +
 Documentation/nvme-wdc-id-ctrl.1       |    5 +-
 Documentation/nvme-wdc-id-ctrl.html    |   12 +-
 Documentation/nvme-wdc-id-ctrl.txt     |    1 +
 Documentation/nvme-write.1             |   65 +-
 Documentation/nvme-write.html          |  125 ++-
 Documentation/nvme-write.txt           |   70 +-
 61 files changed, 4151 insertions(+), 1121 deletions(-)
 create mode 100644 Documentation/nvme-ns-descs.1
 create mode 100644 Documentation/nvme-ns-descs.html
 create mode 100644 Documentation/nvme-ns-descs.txt
 create mode 100644 Documentation/nvme-telemetry-log.1
 create mode 100644 Documentation/nvme-telemetry-log.html
 create mode 100644 Documentation/nvme-telemetry-log.txt

diff --git a/Documentation/cmds-main.txt b/Documentation/cmds-main.txt
index 5d5b8f6..3b40fa1 100644
--- a/Documentation/cmds-main.txt
+++ b/Documentation/cmds-main.txt
@@ -31,6 +31,9 @@ linknvme:nvme-get-feature[1]::
 linknvme:nvme-get-log[1]::
 	Generic Get Log
 
+linknvme:nvme-telemetry-log[1]::
+	Telemetry Host-Initiated Log
+
 linknvme:nvme-smart-log[1]::
 	Retrieve Smart Log
 
@@ -64,6 +67,9 @@ linknvme:nvme-io-passthru[1]::
 linknvme:nvme-list-ns[1]::
 	List all nvme namespaces
 
+linknvme:nvme-ns-descs[1]::
+	Identify Namespace Identification Descriptor
+
 linknvme:nvme-list[1]::
 	List all nvme controllers
 
diff --git a/Documentation/nvme-admin-passthru.1 b/Documentation/nvme-admin-passthru.1
index 4bddd8a..c56fd84 100644
--- a/Documentation/nvme-admin-passthru.1
+++ b/Documentation/nvme-admin-passthru.1
@@ -2,12 +2,12 @@
 .\"     Title: nvme-admin-passthru
 .\"    Author: [FIXME: author] [see http://docbook.sf.net/el/author]
 .\" Generator: DocBook XSL Stylesheets v1.79.1 <http://docbook.sf.net/>
-.\"      Date: 12/10/2017
+.\"      Date: 01/27/2018
 .\"    Manual: NVMe Manual
 .\"    Source: NVMe
 .\"  Language: English
 .\"
-.TH "NVME\-ADMIN\-PASSTHR" "1" "12/10/2017" "NVMe" "NVMe Manual"
+.TH "NVME\-ADMIN\-PASSTHR" "1" "01/27/2018" "NVMe" "NVMe Manual"
 .\" -----------------------------------------------------------------
 .\" * Define some portability stuff
 .\" -----------------------------------------------------------------
@@ -42,7 +42,8 @@ nvme-admin-passthru \- Submit an arbitrary admin command, return results
                 [\-\-input\-file=<file> | \-f <file>]
                 [\-\-read | \-r ] [\-\-write | \-w]
                 [\-\-timeout=<to> | \-t <to>]
-                [\-\-show\-command | \-\-dry\-run | \-s]
+                [\-\-show\-command | \-s]
+                [\-\-dry\-run | \-d]
                 [\-\-raw\-binary | \-b]
                 [\-\-prefill=<prefill> | \-p <prefill>]
 .fi
@@ -100,9 +101,17 @@ The data length for the buffer used for this command\&.
 The metadata length for the buffer used for this command\&.
 .RE
 .PP
-\-s, \-\-show\-cmd, \-\-dry\-run
+\-s, \-\-show\-cmd
 .RS 4
-Do not actually send the command; print out the command that would be sent\&.
+Print out the command to be sent\&.
+.RE
+.PP
+\-d, \-\-dry\-run
+.RS 4
+Do not actually send the command\&. If want to use \-\-dry\-run option, \-\-show\-cmd option
+\fImust\fR
+be set\&. Otherwise \-\-dry\-run optionn will be
+\fIignored\fR\&.
 .RE
 .PP
 \-b, \-\-raw\-binary
diff --git a/Documentation/nvme-admin-passthru.html b/Documentation/nvme-admin-passthru.html
index e74aee0..fd5d8a1 100644
--- a/Documentation/nvme-admin-passthru.html
+++ b/Documentation/nvme-admin-passthru.html
@@ -3,7 +3,7 @@
 <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
 <head>
 <meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
-<meta name="generator" content="AsciiDoc 8.6.8" />
+<meta name="generator" content="AsciiDoc 8.6.9" />
 <title>nvme-admin-passthru(1)</title>
 <style type="text/css">
 /* Shared CSS for AsciiDoc xhtml11 and html5 backends */
@@ -94,7 +94,9 @@ ul > li > * { color: black; }
   padding: 0;
   margin: 0;
 }
-
+pre {
+  white-space: pre-wrap;
+}
 
 #author {
   color: #527bbd;
@@ -223,7 +225,7 @@ div.exampleblock > div.content {
 }
 
 div.imageblock div.content { padding-left: 0; }
-span.image img { border-style: none; }
+span.image img { border-style: none; vertical-align: text-bottom; }
 a.image:visited { color: white; }
 
 dl {
@@ -756,7 +758,8 @@ nvme-admin-passthru(1) Manual Page
                 [--input-file=&lt;file&gt; | -f &lt;file&gt;]
                 [--read | -r ] [--write | -w]
                 [--timeout=&lt;to&gt; | -t &lt;to&gt;]
-                [--show-command | --dry-run | -s]
+                [--show-command | -s]
+                [--dry-run | -d]
                 [--raw-binary | -b]
                 [--prefill=&lt;prefill&gt; | -p &lt;prefill&gt;]</pre>
 <div class="attribution">
@@ -895,13 +898,22 @@ printed to stdout for another program to parse.</p></div>
 <dt class="hdlist1">
 --show-cmd
 </dt>
+<dd>
+<p>
+        Print out the command to be sent.
+</p>
+</dd>
+<dt class="hdlist1">
+-d
+</dt>
 <dt class="hdlist1">
 --dry-run
 </dt>
 <dd>
 <p>
-        Do not actually send the command; print out the command that
-        would be sent.
+        Do not actually send the command. If want to use --dry-run option,
+        --show-cmd option <em>must</em> be set. Otherwise --dry-run optionn will be
+        <em>ignored</em>.
 </p>
 </dd>
 <dt class="hdlist1">
@@ -972,7 +984,8 @@ Or if you want to save that structure to a file:
 <div id="footnotes"><hr /></div>
 <div id="footer">
 <div id="footer-text">
-Last updated 2017-02-27 10:11:57 EST
+Last updated
+ 2018-01-27 01:39:13 KST
 </div>
 </div>
 </body>
diff --git a/Documentation/nvme-admin-passthru.txt b/Documentation/nvme-admin-passthru.txt
index df1c0fa..58c395e 100644
--- a/Documentation/nvme-admin-passthru.txt
+++ b/Documentation/nvme-admin-passthru.txt
@@ -18,7 +18,8 @@ SYNOPSIS
 		[--input-file=<file> | -f <file>]
 		[--read | -r ] [--write | -w]
 		[--timeout=<to> | -t <to>]
-		[--show-command | --dry-run | -s]
+		[--show-command | -s]
+		[--dry-run | -d]
 		[--raw-binary | -b]
 		[--prefill=<prefill> | -p <prefill>]
 
@@ -83,9 +84,13 @@ OPTIONS
 
 -s::
 --show-cmd::
+	Print out the command to be sent.
+
+-d::
 --dry-run::
-	Do not actually send the command; print out the command that
-	would be sent.
+	Do not actually send the command. If want to use --dry-run option,
+	--show-cmd option _must_ be set. Otherwise --dry-run optionn will be
+	_ignored_.
 
 -b::
 --raw-binary::
diff --git a/Documentation/nvme-compare.1 b/Documentation/nvme-compare.1
index b043c7e..06eecfb 100644
--- a/Documentation/nvme-compare.1
+++ b/Documentation/nvme-compare.1
@@ -2,12 +2,12 @@
 .\"     Title: nvme-compare
 .\"    Author: [FIXME: author] [see http://docbook.sf.net/el/author]
 .\" Generator: DocBook XSL Stylesheets v1.79.1 <http://docbook.sf.net/>
-.\"      Date: 12/10/2017
+.\"      Date: 01/27/2018
 .\"    Manual: NVMe Manual
 .\"    Source: NVMe
 .\"  Language: English
 .\"
-.TH "NVME\-COMPARE" "1" "12/10/2017" "NVMe" "NVMe Manual"
+.TH "NVME\-COMPARE" "1" "01/27/2018" "NVMe" "NVMe Manual"
 .\" -----------------------------------------------------------------
 .\" * Define some portability stuff
 .\" -----------------------------------------------------------------
@@ -35,22 +35,172 @@ nvme-compare \- Send an NVMe Compare command, provide results
 \fInvme\-compare\fR <device> [\-\-start\-block=<slba> | \-s <slba>]
                         [\-\-block\-count=<nlb> | \-c <nlb>]
                         [\-\-data\-size=<size> | \-z <size>]
+                        [\-\-metadata\-size=<metasize> | \-y <metasize>]
                         [\-\-ref\-tag=<reftag> | \-r <reftag>]
                         [\-\-data=<data\-file> | \-d <data\-file>]
+                        [\-\-metadata=<meta> | \-M <meta>]
                         [\-\-prinfo=<prinfo> | \-p <prinfo>]
                         [\-\-app\-tag\-mask=<appmask> | \-m <appmask>]
                         [\-\-app\-tag=<apptag> | \-a <apptag>]
                         [\-\-limited\-retry | \-l]
                         [\-\-force\-unit\-access | \-f]
+                        [\-\-dir\-type=<type> | \-T <type>]
+                        [\-\-dir\-spec=<spec> | \-S <spec>]
+                        [\-\-dsm=<dsm> | \-D <dsm>]
+                        [\-\-show\-command | \-v]
+                        [\-\-dry\-run | \-w]
+                        [\-\-latency | \-t]
 .fi
 .SH "DESCRIPTION"
 .sp
 The Compare command reads the logical blocks specified by the command from the medium and compares the data read to a comparison data buffer transferred as part of the command\&. If the data read from the controller and the comparison data buffer are equivalent with no miscompares, then the command completes successfully\&. If there is any miscompare, the command completes with an error of Compare Failure\&. If metadata is provided, then a comparison is also performed for the metadata\&.
 .SH "OPTIONS"
 .PP
-\-\-start\-block=<slba>, \-s <slba>
+\-s <slba>, \-\-start\-block=<slba>
 .RS 4
-Start block\&.
+64\-bit address of the first block to access\&.
+.RE
+.PP
+\-c <nlb>, \-\-block\-count=<nlb>
+.RS 4
+Number of blocks to be accessed (zero\-based)\&.
+.RE
+.PP
+\-z <size>, \-\-data\-size=<size>
+.RS 4
+Size of data to be compared in bytes\&.
+.RE
+.PP
+\-y <metasize>, \-\-metadata\-size=<metasize>
+.RS 4
+Size of metadata to be trasnferred in bytes\&.
+.RE
+.PP
+\-r <reftag>, \-\-ref\-tag=<regtag>
+.RS 4
+Reference Tag for Protection Information
+.RE
+.PP
+\-d <data\-file>, \-\-data=<data\-file>
+.RS 4
+Data file\&.
+.RE
+.PP
+\-M <meta>, \-\-metadata=<meta>
+.RS 4
+Metadata file\&.
+.RE
+.PP
+\-p <prinfo>, \-\-prinfo=<prinfo>
+.RS 4
+Protection Information and check field\&.
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
+Bit
+T}:T{
+.sp
+Description
+T}
+T{
+.sp
+3
+T}:T{
+.sp
+PRACT: Protection Information Action\&. When set to 1, PI is stripped/inserted on read/write when the block format\(cqs metadata size is 8\&. When set to 0, metadata is passes\&.
+T}
+T{
+.sp
+2:0
+T}:T{
+.sp
+PRCHK: Protection Information Check:
+T}
+T{
+.sp
+2
+T}:T{
+.sp
+Set to 1 enables checking the guard tag
+T}
+T{
+.sp
+1
+T}:T{
+.sp
+Set to 1 enables checking the application tag
+T}
+T{
+.sp
+0
+T}:T{
+.sp
+Set to 1 enables checking the reference tag
+T}
+.TE
+.sp 1
+.PP
+\-m <appmask>, \-\-app\-tag\-mask=<appmask>
+.RS 4
+App Tag Mask for Protection Information
+.RE
+.PP
+\-a <apptag>, \-\-app\-tag=<apptag>
+.RS 4
+App Tag for Protection Information
+.RE
+.PP
+\-l, \-\-limited\-retry
+.RS 4
+Number of limited attempts to media\&.
+.RE
+.PP
+\-f, \-\-force\-unit\-access
+.RS 4
+FUA option to guarantee that data is stored to media\&.
+.RE
+.PP
+\-T <type>, \-\-dir\-type=<type>
+.RS 4
+Optional directive type\&. The nvme\-cli only enforces the value be in the defined range for the directive type, though the NVMe specifcation (1\&.3a) defines only one directive, 01h, for write stream idenfiers\&.
+.RE
+.PP
+\-S <spec>, \-\-dir\-spec=<spec>
+.RS 4
+Optional field for directive specifics\&. When used with write streams, this value is defined to be the write stream identifier\&. The nvme\-cli will not validate the stream requested is within the controller\(cqs capabilities\&.
+.RE
+.PP
+\-D <dsm>, \-\-dsm=<dsm>
+.RS 4
+The optional data set management attributes for this command\&. The argument for this is the lower 16 bits of the DSM field in a write command; the upper 16 bits of the field come from the directive specific field, if used\&. This may be used to set attributes for the LBAs being written, like access frequency, type, latency, among other things, as well as yet to be defined types\&. Please consult the NVMe specification for detailed breakdown of how to use this field\&.
+.RE
+.PP
+\-v, \-\-show\-cmd
+.RS 4
+Print out the command to be sent\&.
+.RE
+.PP
+\-w, \-\-dry\-run
+.RS 4
+Do not actually send the command\&. If want to use \-\-dry\-run option, \-\-show\-cmd option
+\fImust\fR
+be set\&. Otherwise \-\-dry\-run optionn will be
+\fIignored\fR\&.
+.RE
+.PP
+\-t, \-\-latency
+.RS 4
+Print out the latency the IOCTL took (in us)\&.
 .RE
 .SH "EXAMPLES"
 .sp
diff --git a/Documentation/nvme-compare.html b/Documentation/nvme-compare.html
index e7413bb..4887bbd 100644
--- a/Documentation/nvme-compare.html
+++ b/Documentation/nvme-compare.html
@@ -3,7 +3,7 @@
 <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
 <head>
 <meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
-<meta name="generator" content="AsciiDoc 8.6.8" />
+<meta name="generator" content="AsciiDoc 8.6.9" />
 <title>nvme-compare(1)</title>
 <style type="text/css">
 /* Shared CSS for AsciiDoc xhtml11 and html5 backends */
@@ -94,7 +94,9 @@ ul > li > * { color: black; }
   padding: 0;
   margin: 0;
 }
-
+pre {
+  white-space: pre-wrap;
+}
 
 #author {
   color: #527bbd;
@@ -223,7 +225,7 @@ div.exampleblock > div.content {
 }
 
 div.imageblock div.content { padding-left: 0; }
-span.image img { border-style: none; }
+span.image img { border-style: none; vertical-align: text-bottom; }
 a.image:visited { color: white; }
 
 dl {
@@ -749,13 +751,21 @@ nvme-compare(1) Manual Page
 <pre class="content"><em>nvme-compare</em> &lt;device&gt; [--start-block=&lt;slba&gt; | -s &lt;slba&gt;]
                         [--block-count=&lt;nlb&gt; | -c &lt;nlb&gt;]
                         [--data-size=&lt;size&gt; | -z &lt;size&gt;]
+                        [--metadata-size=&lt;metasize&gt; | -y &lt;metasize&gt;]
                         [--ref-tag=&lt;reftag&gt; | -r &lt;reftag&gt;]
                         [--data=&lt;data-file&gt; | -d &lt;data-file&gt;]
+                        [--metadata=&lt;meta&gt; | -M &lt;meta&gt;]
                         [--prinfo=&lt;prinfo&gt; | -p &lt;prinfo&gt;]
                         [--app-tag-mask=&lt;appmask&gt; | -m &lt;appmask&gt;]
                         [--app-tag=&lt;apptag&gt; | -a &lt;apptag&gt;]
                         [--limited-retry | -l]
-                        [--force-unit-access | -f]</pre>
+                        [--force-unit-access | -f]
+                        [--dir-type=&lt;type&gt; | -T &lt;type&gt;]
+                        [--dir-spec=&lt;spec&gt; | -S &lt;spec&gt;]
+                        [--dsm=&lt;dsm&gt; | -D &lt;dsm&gt;]
+                        [--show-command | -v]
+                        [--dry-run | -w]
+                        [--latency | -t]</pre>
 <div class="attribution">
 </div></div>
 </div>
@@ -777,14 +787,256 @@ provided, then a comparison is also performed for the metadata.</p></div>
 <div class="sectionbody">
 <div class="dlist"><dl>
 <dt class="hdlist1">
+-s &lt;slba&gt;
+</dt>
+<dt class="hdlist1">
 --start-block=&lt;slba&gt;
 </dt>
+<dd>
+<p>
+        64-bit address of the first block to access.
+</p>
+</dd>
+<dt class="hdlist1">
+-c &lt;nlb&gt;
+</dt>
 <dt class="hdlist1">
--s &lt;slba&gt;
+--block-count=&lt;nlb&gt;
+</dt>
+<dd>
+<p>
+        Number of blocks to be accessed (zero-based).
+</p>
+</dd>
+<dt class="hdlist1">
+-z &lt;size&gt;
+</dt>
+<dt class="hdlist1">
+--data-size=&lt;size&gt;
+</dt>
+<dd>
+<p>
+        Size of data to be compared in bytes.
+</p>
+</dd>
+<dt class="hdlist1">
+-y &lt;metasize&gt;
+</dt>
+<dt class="hdlist1">
+--metadata-size=&lt;metasize&gt;
+</dt>
+<dd>
+<p>
+        Size of metadata to be trasnferred in bytes.
+</p>
+</dd>
+<dt class="hdlist1">
+-r &lt;reftag&gt;
+</dt>
+<dt class="hdlist1">
+--ref-tag=&lt;regtag&gt;
+</dt>
+<dd>
+<p>
+        Reference Tag for Protection Information
+</p>
+</dd>
+<dt class="hdlist1">
+-d &lt;data-file&gt;
+</dt>
+<dt class="hdlist1">
+--data=&lt;data-file&gt;
+</dt>
+<dd>
+<p>
+        Data file.
+</p>
+</dd>
+<dt class="hdlist1">
+-M &lt;meta&gt;
+</dt>
+<dt class="hdlist1">
+--metadata=&lt;meta&gt;
+</dt>
+<dd>
+<p>
+        Metadata file.
+</p>
+</dd>
+<dt class="hdlist1">
+-p &lt;prinfo&gt;
+</dt>
+<dt class="hdlist1">
+--prinfo=&lt;prinfo&gt;
+</dt>
+<dd>
+<p>
+        Protection Information and check field.
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
+<td align="left" valign="top"><p class="table">Bit</p></td>
+<td align="left" valign="top"><p class="table">Description</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table">3</p></td>
+<td align="left" valign="top"><p class="table">PRACT: Protection Information Action. When set to 1, PI is stripped/inserted
+on read/write when the block format&#8217;s metadata size is 8. When set to 0,
+metadata is passes.</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table">2:0</p></td>
+<td align="left" valign="top"><p class="table">PRCHK: Protection Information Check:</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table">2</p></td>
+<td align="left" valign="top"><p class="table">Set to 1 enables checking the guard tag</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table">1</p></td>
+<td align="left" valign="top"><p class="table">Set to 1 enables checking the application tag</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table">0</p></td>
+<td align="left" valign="top"><p class="table">Set to 1 enables checking the reference tag</p></td>
+</tr>
+</tbody>
+</table>
+</div>
+<div class="dlist"><dl>
+<dt class="hdlist1">
+-m &lt;appmask&gt;
+</dt>
+<dt class="hdlist1">
+--app-tag-mask=&lt;appmask&gt;
+</dt>
+<dd>
+<p>
+        App Tag Mask for Protection Information
+</p>
+</dd>
+<dt class="hdlist1">
+-a &lt;apptag&gt;
+</dt>
+<dt class="hdlist1">
+--app-tag=&lt;apptag&gt;
+</dt>
+<dd>
+<p>
+        App Tag for Protection Information
+</p>
+</dd>
+<dt class="hdlist1">
+-l
+</dt>
+<dt class="hdlist1">
+--limited-retry
+</dt>
+<dd>
+<p>
+        Number of limited attempts to media.
+</p>
+</dd>
+<dt class="hdlist1">
+-f
+</dt>
+<dt class="hdlist1">
+--force-unit-access
+</dt>
+<dd>
+<p>
+        FUA option to guarantee that data is stored to media.
+</p>
+</dd>
+<dt class="hdlist1">
+-T &lt;type&gt;
+</dt>
+<dt class="hdlist1">
+--dir-type=&lt;type&gt;
+</dt>
+<dd>
+<p>
+        Optional directive type. The nvme-cli only enforces the value
+        be in the defined range for the directive type, though the NVMe
+        specifcation (1.3a) defines only one directive, 01h, for write
+        stream idenfiers.
+</p>
+</dd>
+<dt class="hdlist1">
+-S &lt;spec&gt;
+</dt>
+<dt class="hdlist1">
+--dir-spec=&lt;spec&gt;
+</dt>
+<dd>
+<p>
+        Optional field for directive specifics. When used with
+        write streams, this value is defined to be the write stream
+        identifier. The nvme-cli will not validate the stream requested
+        is within the controller&#8217;s capabilities.
+</p>
+</dd>
+<dt class="hdlist1">
+-D &lt;dsm&gt;
+</dt>
+<dt class="hdlist1">
+--dsm=&lt;dsm&gt;
+</dt>
+<dd>
+<p>
+        The optional data set management attributes for this command. The
+        argument for this is the lower 16 bits of the DSM field in a write
+        command; the upper 16 bits of the field come from the directive
+        specific field, if used. This may be used to set attributes for
+        the LBAs being written, like access frequency, type, latency,
+        among other things, as well as yet to be defined types. Please
+        consult the NVMe specification for detailed breakdown of how to
+        use this field.
+</p>
+</dd>
+<dt class="hdlist1">
+-v
+</dt>
+<dt class="hdlist1">
+--show-cmd
+</dt>
+<dd>
+<p>
+        Print out the command to be sent.
+</p>
+</dd>
+<dt class="hdlist1">
+-w
+</dt>
+<dt class="hdlist1">
+--dry-run
+</dt>
+<dd>
+<p>
+        Do not actually send the command. If want to use --dry-run option,
+        --show-cmd option <em>must</em> be set. Otherwise --dry-run optionn will be
+        <em>ignored</em>.
+</p>
+</dd>
+<dt class="hdlist1">
+-t
+</dt>
+<dt class="hdlist1">
+--latency
 </dt>
 <dd>
 <p>
-        Start block.
+        Print out the latency the IOCTL took (in us).
 </p>
 </dd>
 </dl></div>
@@ -806,7 +1058,8 @@ provided, then a comparison is also performed for the metadata.</p></div>
 <div id="footnotes"><hr /></div>
 <div id="footer">
 <div id="footer-text">
-Last updated 2016-05-16 12:47:42 EDT
+Last updated
+ 2018-01-27 02:05:32 KST
 </div>
 </div>
 </body>
diff --git a/Documentation/nvme-compare.txt b/Documentation/nvme-compare.txt
index 81436d9..86dfcca 100644
--- a/Documentation/nvme-compare.txt
+++ b/Documentation/nvme-compare.txt
@@ -11,13 +11,21 @@ SYNOPSIS
 'nvme-compare' <device> [--start-block=<slba> | -s <slba>]
 			[--block-count=<nlb> | -c <nlb>]
 			[--data-size=<size> | -z <size>]
+			[--metadata-size=<metasize> | -y <metasize>]
 			[--ref-tag=<reftag> | -r <reftag>]
 			[--data=<data-file> | -d <data-file>]
+			[--metadata=<meta> | -M <meta>]
 			[--prinfo=<prinfo> | -p <prinfo>]
 			[--app-tag-mask=<appmask> | -m <appmask>]
 			[--app-tag=<apptag> | -a <apptag>]
 			[--limited-retry | -l]
 			[--force-unit-access | -f]
+			[--dir-type=<type> | -T <type>]
+			[--dir-spec=<spec> | -S <spec>]
+			[--dsm=<dsm> | -D <dsm>]
+			[--show-command | -v]
+			[--dry-run | -w]
+			[--latency | -t]
 
 DESCRIPTION
 -----------
@@ -31,9 +39,105 @@ provided, then a comparison is also performed for the metadata.
 
 OPTIONS
 -------
---start-block=<slba>::
 -s <slba>::
-	Start block.
+--start-block=<slba>::
+	64-bit address of the first block to access.
+
+-c <nlb>::
+--block-count=<nlb>::
+	Number of blocks to be accessed (zero-based).
+
+-z <size>::
+--data-size=<size>::
+	Size of data to be compared in bytes.
+
+-y <metasize>::
+--metadata-size=<metasize>::
+	Size of metadata to be trasnferred in bytes.
+
+-r <reftag>::
+--ref-tag=<regtag>::
+	Reference Tag for Protection Information
+
+-d <data-file>::
+--data=<data-file>::
+	Data file.
+
+-M <meta>::
+--metadata=<meta>::
+	Metadata file.
+
+-p <prinfo>::
+--prinfo=<prinfo>::
+	Protection Information and check field.
+
++
+[]
+|=================
+|Bit|Description
+|3|PRACT: Protection Information Action. When set to 1, PI is stripped/inserted
+on read/write when the block format's metadata size is 8. When set to 0,
+metadata is passes.
+|2:0|PRCHK: Protection Information Check:
+|2|Set to 1 enables checking the guard tag
+|1|Set to 1 enables checking the application tag
+|0|Set to 1 enables checking the reference tag
+|=================
+
+-m <appmask>::
+--app-tag-mask=<appmask>::
+	App Tag Mask for Protection Information
+
+-a <apptag>::
+--app-tag=<apptag>::
+	App Tag for Protection Information
+
+-l::
+--limited-retry::
+	Number of limited attempts to media.
+
+-f::
+--force-unit-access::
+	FUA option to guarantee that data is stored to media.
+
+-T <type>::
+--dir-type=<type>::
+	Optional directive type. The nvme-cli only enforces the value
+	be in the defined range for the directive type, though the NVMe
+	specifcation (1.3a) defines only one directive, 01h, for write
+	stream idenfiers.
+
+-S <spec>::
+--dir-spec=<spec>::
+	Optional field for directive specifics. When used with
+	write streams, this value is defined to be the write stream
+	identifier. The nvme-cli will not validate the stream requested
+	is within the controller's capabilities.
+
+-D <dsm>::
+--dsm=<dsm>::
+	The optional data set management attributes for this command. The
+	argument for this is the lower 16 bits of the DSM field in a write
+	command; the upper 16 bits of the field come from the directive
+	specific field, if used. This may be used to set attributes for
+	the LBAs being written, like access frequency, type, latency,
+	among other things, as well as yet to be defined types. Please
+	consult the NVMe specification for detailed breakdown of how to
+	use this field.
+
+-v::
+--show-cmd::
+	Print out the command to be sent.
+
+-w::
+--dry-run::
+	Do not actually send the command. If want to use --dry-run option,
+	--show-cmd option _must_ be set. Otherwise --dry-run optionn will be
+	_ignored_.
+
+-t::
+--latency::
+	Print out the latency the IOCTL took (in us).
 
 EXAMPLES
 --------
diff --git a/Documentation/nvme-format.1 b/Documentation/nvme-format.1
index a2a6976..40042c9 100644
--- a/Documentation/nvme-format.1
+++ b/Documentation/nvme-format.1
@@ -2,12 +2,12 @@
 .\"     Title: nvme-format
 .\"    Author: [FIXME: author] [see http://docbook.sf.net/el/author]
 .\" Generator: DocBook XSL Stylesheets v1.79.1 <http://docbook.sf.net/>
-.\"      Date: 12/10/2017
+.\"      Date: 01/27/2018
 .\"    Manual: NVMe Manual
 .\"    Source: NVMe
 .\"  Language: English
 .\"
-.TH "NVME\-FORMAT" "1" "12/10/2017" "NVMe" "NVMe Manual"
+.TH "NVME\-FORMAT" "1" "01/27/2018" "NVMe" "NVMe Manual"
 .\" -----------------------------------------------------------------
 .\" * Define some portability stuff
 .\" -----------------------------------------------------------------
@@ -39,7 +39,7 @@ nvme-format \- Format an NVMe device
                     [\-\-pi=<pi> | \-i <pi>]
                     [\-\-ms=<ms> | \-m <ms>]
                     [\-\-reset | \-r ]
-                    [\-\-timeout | \-t ]
+                    [\-\-timeout=<timeout> | \-t <timeout> ]
 .fi
 .SH "DESCRIPTION"
 .sp
diff --git a/Documentation/nvme-format.html b/Documentation/nvme-format.html
index 06484be..6fb1baf 100644
--- a/Documentation/nvme-format.html
+++ b/Documentation/nvme-format.html
@@ -3,7 +3,7 @@
 <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
 <head>
 <meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
-<meta name="generator" content="AsciiDoc 8.6.8" />
+<meta name="generator" content="AsciiDoc 8.6.9" />
 <title>nvme-format(1)</title>
 <style type="text/css">
 /* Shared CSS for AsciiDoc xhtml11 and html5 backends */
@@ -94,7 +94,9 @@ ul > li > * { color: black; }
   padding: 0;
   margin: 0;
 }
-
+pre {
+  white-space: pre-wrap;
+}
 
 #author {
   color: #527bbd;
@@ -223,7 +225,7 @@ div.exampleblock > div.content {
 }
 
 div.imageblock div.content { padding-left: 0; }
-span.image img { border-style: none; }
+span.image img { border-style: none; vertical-align: text-bottom; }
 a.image:visited { color: white; }
 
 dl {
@@ -753,7 +755,7 @@ nvme-format(1) Manual Page
                     [--pi=&lt;pi&gt; | -i &lt;pi&gt;]
                     [--ms=&lt;ms&gt; | -m &lt;ms&gt;]
                     [--reset | -r ]
-                    [--timeout | -t ]</pre>
+                    [--timeout=&lt;timeout&gt; | -t &lt;timeout&gt; ]</pre>
 <div class="attribution">
 </div></div>
 </div>
@@ -997,7 +999,8 @@ information:
 <div id="footnotes"><hr /></div>
 <div id="footer">
 <div id="footer-text">
-Last updated 2017-02-27 10:11:57 EST
+Last updated
+ 2018-01-27 01:32:58 KST
 </div>
 </div>
 </body>
diff --git a/Documentation/nvme-format.txt b/Documentation/nvme-format.txt
index a74a0dc..8597741 100644
--- a/Documentation/nvme-format.txt
+++ b/Documentation/nvme-format.txt
@@ -15,7 +15,7 @@ SYNOPSIS
 		    [--pi=<pi> | -i <pi>]
 		    [--ms=<ms> | -m <ms>]
 		    [--reset | -r ]
-		    [--timeout | -t ]
+		    [--timeout=<timeout> | -t <timeout> ]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/nvme-get-feature.1 b/Documentation/nvme-get-feature.1
index 82c3f69..1f52c37 100644
--- a/Documentation/nvme-get-feature.1
+++ b/Documentation/nvme-get-feature.1
@@ -2,12 +2,12 @@
 .\"     Title: nvme-get-feature
 .\"    Author: [FIXME: author] [see http://docbook.sf.net/el/author]
 .\" Generator: DocBook XSL Stylesheets v1.79.1 <http://docbook.sf.net/>
-.\"      Date: 12/10/2017
+.\"      Date: 01/27/2018
 .\"    Manual: NVMe Manual
 .\"    Source: NVMe
 .\"  Language: English
 .\"
-.TH "NVME\-GET\-FEATURE" "1" "12/10/2017" "NVMe" "NVMe Manual"
+.TH "NVME\-GET\-FEATURE" "1" "01/27/2018" "NVMe" "NVMe Manual"
 .\" -----------------------------------------------------------------
 .\" * Define some portability stuff
 .\" -----------------------------------------------------------------
@@ -37,6 +37,7 @@ nvme-get-feature \- Gets an NVMe feature, returns applicable results
                           [\-\-data\-len=<data\-len> | \-l <data\-len>]
                           [\-\-sel=<select> | \-s <select>]
                           [\-\-raw\-binary | \-b]
+                          [\-\-human\-readable | \-H]
 .fi
 .SH "DESCRIPTION"
 .sp
@@ -116,6 +117,11 @@ The value for command dword 11, if applicable\&.
 .RS 4
 Print the raw feature buffer to stdout if the feature returns a structure\&.
 .RE
+.PP
+\-H, \-\-human\-readable
+.RS 4
+This option will parse and format many of the bit fields into human\-readable formats\&.
+.RE
 .SH "EXAMPLES"
 .sp
 .RS 4
diff --git a/Documentation/nvme-get-feature.html b/Documentation/nvme-get-feature.html
index ec872ad..0c0f28b 100644
--- a/Documentation/nvme-get-feature.html
+++ b/Documentation/nvme-get-feature.html
@@ -3,7 +3,7 @@
 <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
 <head>
 <meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
-<meta name="generator" content="AsciiDoc 8.6.8" />
+<meta name="generator" content="AsciiDoc 8.6.9" />
 <title>nvme-get-feature(1)</title>
 <style type="text/css">
 /* Shared CSS for AsciiDoc xhtml11 and html5 backends */
@@ -94,7 +94,9 @@ ul > li > * { color: black; }
   padding: 0;
   margin: 0;
 }
-
+pre {
+  white-space: pre-wrap;
+}
 
 #author {
   color: #527bbd;
@@ -223,7 +225,7 @@ div.exampleblock > div.content {
 }
 
 div.imageblock div.content { padding-left: 0; }
-span.image img { border-style: none; }
+span.image img { border-style: none; vertical-align: text-bottom; }
 a.image:visited { color: white; }
 
 dl {
@@ -750,7 +752,8 @@ nvme-get-feature(1) Manual Page
                           [--feature-id=&lt;fid&gt; | -f &lt;fid&gt;] [--cdw11=&lt;cdw11&gt;]
                           [--data-len=&lt;data-len&gt; | -l &lt;data-len&gt;]
                           [--sel=&lt;select&gt; | -s &lt;select&gt;]
-                          [--raw-binary | -b]</pre>
+                          [--raw-binary | -b]
+                          [--human-readable | -H]</pre>
 <div class="attribution">
 </div></div>
 </div>
@@ -878,6 +881,18 @@ cellspacing="0" cellpadding="4">
         a structure.
 </p>
 </dd>
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
 </dl></div>
 </div>
 </div>
@@ -941,7 +956,8 @@ format:
 <div id="footnotes"><hr /></div>
 <div id="footer">
 <div id="footer-text">
-Last updated 2017-06-23 12:34:32 EDT
+Last updated
+ 2018-01-27 01:31:15 KST
 </div>
 </div>
 </body>
diff --git a/Documentation/nvme-get-feature.txt b/Documentation/nvme-get-feature.txt
index cdf6eef..56542dc 100644
--- a/Documentation/nvme-get-feature.txt
+++ b/Documentation/nvme-get-feature.txt
@@ -13,6 +13,7 @@ SYNOPSIS
 			  [--data-len=<data-len> | -l <data-len>]
 			  [--sel=<select> | -s <select>]
 			  [--raw-binary | -b]
+			  [--human-readable | -H]
 
 DESCRIPTION
 -----------
@@ -70,6 +71,11 @@ OPTIONS
 	Print the raw feature buffer to stdout if the feature returns
 	a structure.
 
+-H::
+--human-readable::
+	This option will parse and format many of the bit fields
+	into human-readable formats.
+
 EXAMPLES
 --------
 * Retrieves the feature for Number of Queues, or feature id 7:
diff --git a/Documentation/nvme-get-log.1 b/Documentation/nvme-get-log.1
index 7dc38bf..01f318c 100644
--- a/Documentation/nvme-get-log.1
+++ b/Documentation/nvme-get-log.1
@@ -2,12 +2,12 @@
 .\"     Title: nvme-get-log
 .\"    Author: [FIXME: author] [see http://docbook.sf.net/el/author]
 .\" Generator: DocBook XSL Stylesheets v1.79.1 <http://docbook.sf.net/>
-.\"      Date: 12/10/2017
+.\"      Date: 01/27/2018
 .\"    Manual: NVMe Manual
 .\"    Source: NVMe
 .\"  Language: English
 .\"
-.TH "NVME\-GET\-LOG" "1" "12/10/2017" "NVMe" "NVMe Manual"
+.TH "NVME\-GET\-LOG" "1" "01/27/2018" "NVMe" "NVMe Manual"
 .\" -----------------------------------------------------------------
 .\" * Define some portability stuff
 .\" -----------------------------------------------------------------
@@ -37,6 +37,8 @@ nvme-get-log \- Retrieves a log page from an NVMe device
                       [\-\-aen=<aen> | \-a <aen>]
                       [\-\-namespace\-id=<nsid> | \-n <nsid>]
                       [\-\-raw\-binary | \-b]
+                      [\-\-lpo=<offset> | \-o <offset>]
+                      [\-\-lsp=<field> | \-s <field>]
 .fi
 .SH "DESCRIPTION"
 .sp
@@ -71,6 +73,16 @@ Sets the command\(cqs nsid value to the given nsid\&. Defaults to 0xffffffff if
 .RS 4
 Print the raw log buffer to stdout\&.
 .RE
+.PP
+\-o <offset>, \-\-lpo=<offset>
+.RS 4
+The log page offset specifies the location within a log page to start returning data from\&. It\(cqs Dword\-aligned and 64\-bits\&.
+.RE
+.PP
+\-s <field>, \-\-lsp=<field>
+.RS 4
+The log specified field of LID\&.
+.RE
 .SH "EXAMPLES"
 .sp
 .RS 4
diff --git a/Documentation/nvme-get-log.html b/Documentation/nvme-get-log.html
index b4ee9a9..b5f01b6 100644
--- a/Documentation/nvme-get-log.html
+++ b/Documentation/nvme-get-log.html
@@ -3,7 +3,7 @@
 <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
 <head>
 <meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
-<meta name="generator" content="AsciiDoc 8.6.8" />
+<meta name="generator" content="AsciiDoc 8.6.9" />
 <title>nvme-get-log(1)</title>
 <style type="text/css">
 /* Shared CSS for AsciiDoc xhtml11 and html5 backends */
@@ -94,7 +94,9 @@ ul > li > * { color: black; }
   padding: 0;
   margin: 0;
 }
-
+pre {
+  white-space: pre-wrap;
+}
 
 #author {
   color: #527bbd;
@@ -223,7 +225,7 @@ div.exampleblock > div.content {
 }
 
 div.imageblock div.content { padding-left: 0; }
-span.image img { border-style: none; }
+span.image img { border-style: none; vertical-align: text-bottom; }
 a.image:visited { color: white; }
 
 dl {
@@ -750,7 +752,9 @@ nvme-get-log(1) Manual Page
                       [--log-len=&lt;log-len&gt; | -l &lt;log-len&gt;]
                       [--aen=&lt;aen&gt; | -a &lt;aen&gt;]
                       [--namespace-id=&lt;nsid&gt; | -n &lt;nsid&gt;]
-                      [--raw-binary | -b]</pre>
+                      [--raw-binary | -b]
+                      [--lpo=&lt;offset&gt; | -o &lt;offset&gt;]
+                      [--lsp=&lt;field&gt; | -s &lt;field&gt;]</pre>
 <div class="attribution">
 </div></div>
 </div>
@@ -834,6 +838,29 @@ program to parse.</p></div>
         Print the raw log buffer to stdout.
 </p>
 </dd>
+<dt class="hdlist1">
+-o &lt;offset&gt;
+</dt>
+<dt class="hdlist1">
+--lpo=&lt;offset&gt;
+</dt>
+<dd>
+<p>
+        The log page offset specifies the location within a log page to start
+        returning data from. It&#8217;s Dword-aligned and 64-bits.
+</p>
+</dd>
+<dt class="hdlist1">
+-s &lt;field&gt;
+</dt>
+<dt class="hdlist1">
+--lsp=&lt;field&gt;
+</dt>
+<dd>
+<p>
+        The log specified field of LID.
+</p>
+</dd>
 </dl></div>
 </div>
 </div>
@@ -877,7 +904,8 @@ Have the program return the raw log page in binary:
 <div id="footnotes"><hr /></div>
 <div id="footer">
 <div id="footer-text">
-Last updated 2017-10-20 15:09:05 MDT
+Last updated
+ 2018-01-27 01:15:13 KST
 </div>
 </div>
 </body>
diff --git a/Documentation/nvme-get-log.txt b/Documentation/nvme-get-log.txt
index 55ba5af..1df0a26 100644
--- a/Documentation/nvme-get-log.txt
+++ b/Documentation/nvme-get-log.txt
@@ -13,6 +13,8 @@ SYNOPSIS
 		      [--aen=<aen> | -a <aen>]
 		      [--namespace-id=<nsid> | -n <nsid>]
 		      [--raw-binary | -b]
+		      [--lpo=<offset> | -o <offset>]
+		      [--lsp=<field> | -s <field>]
 
 DESCRIPTION
 -----------
@@ -56,6 +58,15 @@ OPTIONS
 --raw-binary::
 	Print the raw log buffer to stdout.
 
+-o <offset>::
+--lpo=<offset>::
+	The log page offset specifies the location within a log page to start
+	returning data from. It's Dword-aligned and 64-bits.
+
+-s <field>::
+--lsp=<field>::
+	The log specified field of LID.
+
 EXAMPLES
 --------
 * Get 512 bytes from log page 2
diff --git a/Documentation/nvme-id-ns.1 b/Documentation/nvme-id-ns.1
index d10a48f..d528d1e 100644
--- a/Documentation/nvme-id-ns.1
+++ b/Documentation/nvme-id-ns.1
@@ -2,12 +2,12 @@
 .\"     Title: nvme-id-ns
 .\"    Author: [FIXME: author] [see http://docbook.sf.net/el/author]
 .\" Generator: DocBook XSL Stylesheets v1.79.1 <http://docbook.sf.net/>
-.\"      Date: 12/10/2017
+.\"      Date: 01/27/2018
 .\"    Manual: NVMe Manual
 .\"    Source: NVMe
 .\"  Language: English
 .\"
-.TH "NVME\-ID\-NS" "1" "12/10/2017" "NVMe" "NVMe Manual"
+.TH "NVME\-ID\-NS" "1" "01/27/2018" "NVMe" "NVMe Manual"
 .\" -----------------------------------------------------------------
 .\" * Define some portability stuff
 .\" -----------------------------------------------------------------
@@ -34,6 +34,7 @@ nvme-id-ns \- Send NVMe Identify Namespace, return result and structure
 .nf
 \fInvme id\-ns\fR <device> [\-v | \-\-vendor\-specific] [\-b | \-\-raw\-binary]
                     [\-\-namespace\-id=<nsid> | \-n <nsid>] [\-f | \-\-force]
+                    [\-\-human\-readable | \-H]
                     [\-\-output\-format=<fmt> | \-o <fmt>]
 .fi
 .SH "DESCRIPTION"
diff --git a/Documentation/nvme-id-ns.html b/Documentation/nvme-id-ns.html
index 171fda6..59befa7 100644
--- a/Documentation/nvme-id-ns.html
+++ b/Documentation/nvme-id-ns.html
@@ -3,7 +3,7 @@
 <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
 <head>
 <meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
-<meta name="generator" content="AsciiDoc 8.6.8" />
+<meta name="generator" content="AsciiDoc 8.6.9" />
 <title>nvme-id-ns(1)</title>
 <style type="text/css">
 /* Shared CSS for AsciiDoc xhtml11 and html5 backends */
@@ -94,7 +94,9 @@ ul > li > * { color: black; }
   padding: 0;
   margin: 0;
 }
-
+pre {
+  white-space: pre-wrap;
+}
 
 #author {
   color: #527bbd;
@@ -223,7 +225,7 @@ div.exampleblock > div.content {
 }
 
 div.imageblock div.content { padding-left: 0; }
-span.image img { border-style: none; }
+span.image img { border-style: none; vertical-align: text-bottom; }
 a.image:visited { color: white; }
 
 dl {
@@ -748,6 +750,7 @@ nvme-id-ns(1) Manual Page
 <div class="verseblock">
 <pre class="content"><em>nvme id-ns</em> &lt;device&gt; [-v | --vendor-specific] [-b | --raw-binary]
                     [--namespace-id=&lt;nsid&gt; | -n &lt;nsid&gt;] [-f | --force]
+                    [--human-readable | -H]
                     [--output-format=&lt;fmt&gt; | -o &lt;fmt&gt;]</pre>
 <div class="attribution">
 </div></div>
@@ -950,7 +953,8 @@ int main(int argc, char **argv)
 <div id="footnotes"><hr /></div>
 <div id="footer">
 <div id="footer-text">
-Last updated 2017-02-27 10:11:58 EST
+Last updated
+ 2018-01-27 00:45:23 KST
 </div>
 </div>
 </body>
diff --git a/Documentation/nvme-id-ns.txt b/Documentation/nvme-id-ns.txt
index d3eb893..f0eabec 100644
--- a/Documentation/nvme-id-ns.txt
+++ b/Documentation/nvme-id-ns.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 [verse]
 'nvme id-ns' <device> [-v | --vendor-specific] [-b | --raw-binary]
 		    [--namespace-id=<nsid> | -n <nsid>] [-f | --force]
+		    [--human-readable | -H]
 		    [--output-format=<fmt> | -o <fmt>]
 
 DESCRIPTION
diff --git a/Documentation/nvme-io-passthru.1 b/Documentation/nvme-io-passthru.1
index 7ee4a86..2453fc1 100644
--- a/Documentation/nvme-io-passthru.1
+++ b/Documentation/nvme-io-passthru.1
@@ -2,12 +2,12 @@
 .\"     Title: nvme-io-passthru
 .\"    Author: [FIXME: author] [see http://docbook.sf.net/el/author]
 .\" Generator: DocBook XSL Stylesheets v1.79.1 <http://docbook.sf.net/>
-.\"      Date: 12/10/2017
+.\"      Date: 01/27/2018
 .\"    Manual: NVMe Manual
 .\"    Source: NVMe
 .\"  Language: English
 .\"
-.TH "NVME\-IO\-PASSTHRU" "1" "12/10/2017" "NVMe" "NVMe Manual"
+.TH "NVME\-IO\-PASSTHRU" "1" "01/27/2018" "NVMe" "NVMe Manual"
 .\" -----------------------------------------------------------------
 .\" * Define some portability stuff
 .\" -----------------------------------------------------------------
@@ -41,9 +41,10 @@ nvme-io-passthru \- Submit an arbitrary io command, return results
                 [\-\-data\-len=<data\-len> | \-l <data\-len>]
                 [\-\-metadata\-len=<len> | \-m <len>]
                 [\-\-read | \-r ] [\-\-write | \-w]
-                [\-\-input\-file=<file> | \-f <file>]
+                [\-\-input\-file=<file> | \-i <file>]
                 [\-\-timeout=<to> | \-t <to>]
-                [\-\-show\-command | \-\-dry\-run | \-s]
+                [\-\-show\-command | \-s]
+                [\-\-dry\-run | \-d]
                 [\-\-raw\-binary | \-b]
                 [\-\-prefill=<prefill> | \-p <prefill>]
 .fi
@@ -109,7 +110,10 @@ Print out the command to be sent\&.
 .PP
 \-d, \-\-dry\-run
 .RS 4
-Do not actually send the command\&.
+Do not actually send the command\&. If want to use \-\-dry\-run option, \-\-show\-cmd option
+\fImust\fR
+be set\&. Otherwise \-\-dry\-run optionn will be
+\fIignored\fR\&.
 .RE
 .PP
 \-b, \-\-raw\-binary
diff --git a/Documentation/nvme-io-passthru.html b/Documentation/nvme-io-passthru.html
index 01a83f3..7f5bd2c 100644
--- a/Documentation/nvme-io-passthru.html
+++ b/Documentation/nvme-io-passthru.html
@@ -3,7 +3,7 @@
 <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
 <head>
 <meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
-<meta name="generator" content="AsciiDoc 8.6.8" />
+<meta name="generator" content="AsciiDoc 8.6.9" />
 <title>nvme-io-passthru(1)</title>
 <style type="text/css">
 /* Shared CSS for AsciiDoc xhtml11 and html5 backends */
@@ -94,7 +94,9 @@ ul > li > * { color: black; }
   padding: 0;
   margin: 0;
 }
-
+pre {
+  white-space: pre-wrap;
+}
 
 #author {
   color: #527bbd;
@@ -223,7 +225,7 @@ div.exampleblock > div.content {
 }
 
 div.imageblock div.content { padding-left: 0; }
-span.image img { border-style: none; }
+span.image img { border-style: none; vertical-align: text-bottom; }
 a.image:visited { color: white; }
 
 dl {
@@ -755,9 +757,10 @@ nvme-io-passthru(1) Manual Page
                 [--data-len=&lt;data-len&gt; | -l &lt;data-len&gt;]
                 [--metadata-len=&lt;len&gt; | -m &lt;len&gt;]
                 [--read | -r ] [--write | -w]
-                [--input-file=&lt;file&gt; | -f &lt;file&gt;]
+                [--input-file=&lt;file&gt; | -i &lt;file&gt;]
                 [--timeout=&lt;to&gt; | -t &lt;to&gt;]
-                [--show-command | --dry-run | -s]
+                [--show-command | -s]
+                [--dry-run | -d]
                 [--raw-binary | -b]
                 [--prefill=&lt;prefill&gt; | -p &lt;prefill&gt;]</pre>
 <div class="attribution">
@@ -909,7 +912,9 @@ printed to stdout for another program to parse.</p></div>
 </dt>
 <dd>
 <p>
-        Do not actually send the command.
+        Do not actually send the command. If want to use --dry-run option,
+        --show-cmd option <em>must</em> be set. Otherwise --dry-run optionn will be
+        <em>ignored</em>.
 </p>
 </dd>
 <dt class="hdlist1">
@@ -958,7 +963,8 @@ printed to stdout for another program to parse.</p></div>
 <div id="footnotes"><hr /></div>
 <div id="footer">
 <div id="footer-text">
-Last updated 2017-02-27 10:11:58 EST
+Last updated
+ 2018-01-27 01:39:14 KST
 </div>
 </div>
 </body>
diff --git a/Documentation/nvme-io-passthru.txt b/Documentation/nvme-io-passthru.txt
index 1a6dba2..11bda25 100644
--- a/Documentation/nvme-io-passthru.txt
+++ b/Documentation/nvme-io-passthru.txt
@@ -17,9 +17,10 @@ SYNOPSIS
 		[--data-len=<data-len> | -l <data-len>]
 		[--metadata-len=<len> | -m <len>]
 		[--read | -r ] [--write | -w]
-		[--input-file=<file> | -f <file>]
+		[--input-file=<file> | -i <file>]
 		[--timeout=<to> | -t <to>]
-		[--show-command | --dry-run | -s]
+		[--show-command | -s]
+		[--dry-run | -d]
 		[--raw-binary | -b]
 		[--prefill=<prefill> | -p <prefill>]
 
@@ -88,7 +89,9 @@ OPTIONS
 
 -d::
 --dry-run::
-	Do not actually send the command.
+	Do not actually send the command. If want to use --dry-run option,
+	--show-cmd option _must_ be set. Otherwise --dry-run optionn will be
+	_ignored_.
 
 -b::
 --raw-binary::
diff --git a/Documentation/nvme-list-ns.1 b/Documentation/nvme-list-ns.1
index 3453d2b..60db8fd 100644
--- a/Documentation/nvme-list-ns.1
+++ b/Documentation/nvme-list-ns.1
@@ -2,12 +2,12 @@
 .\"     Title: nvme-id-ns
 .\"    Author: [FIXME: author] [see http://docbook.sf.net/el/author]
 .\" Generator: DocBook XSL Stylesheets v1.79.1 <http://docbook.sf.net/>
-.\"      Date: 12/10/2017
+.\"      Date: 01/27/2018
 .\"    Manual: NVMe Manual
 .\"    Source: NVMe
 .\"  Language: English
 .\"
-.TH "NVME\-ID\-NS" "1" "12/10/2017" "NVMe" "NVMe Manual"
+.TH "NVME\-ID\-NS" "1" "01/27/2018" "NVMe" "NVMe Manual"
 .\" -----------------------------------------------------------------
 .\" * Define some portability stuff
 .\" -----------------------------------------------------------------
@@ -33,6 +33,7 @@ nvme-list-ns \- Send NVMe Identify List Namespaces, return result and structure
 .sp
 .nf
 \fInvme list\-ns\fR <device> [\-\-namespace\-id=<nsid> | \-n <nsid>]
+                        [\-\-all | \-a]
 .fi
 .SH "DESCRIPTION"
 .sp
@@ -47,6 +48,11 @@ On success, the namespace array is printed for each index and nsid for a valid n
 .RS 4
 Retrieve the identify list structure starting with the given nsid\&.
 .RE
+.PP
+\-a, \-\-all
+.RS 4
+Retrieve the identify list structure for all namespaces in the subsystem, whether attached or inactive\&.
+.RE
 .SH "EXAMPLES"
 .sp
 No examples yet\&.
diff --git a/Documentation/nvme-list-ns.html b/Documentation/nvme-list-ns.html
index 5094fae..a836767 100644
--- a/Documentation/nvme-list-ns.html
+++ b/Documentation/nvme-list-ns.html
@@ -3,7 +3,7 @@
 <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
 <head>
 <meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
-<meta name="generator" content="AsciiDoc 8.6.8" />
+<meta name="generator" content="AsciiDoc 8.6.9" />
 <title>nvme-id-ns(1)</title>
 <style type="text/css">
 /* Shared CSS for AsciiDoc xhtml11 and html5 backends */
@@ -94,7 +94,9 @@ ul > li > * { color: black; }
   padding: 0;
   margin: 0;
 }
-
+pre {
+  white-space: pre-wrap;
+}
 
 #author {
   color: #527bbd;
@@ -223,7 +225,7 @@ div.exampleblock > div.content {
 }
 
 div.imageblock div.content { padding-left: 0; }
-span.image img { border-style: none; }
+span.image img { border-style: none; vertical-align: text-bottom; }
 a.image:visited { color: white; }
 
 dl {
@@ -746,7 +748,8 @@ nvme-id-ns(1) Manual Page
 <h2 id="_synopsis">SYNOPSIS</h2>
 <div class="sectionbody">
 <div class="verseblock">
-<pre class="content"><em>nvme list-ns</em> &lt;device&gt; [--namespace-id=&lt;nsid&gt; | -n &lt;nsid&gt;]</pre>
+<pre class="content"><em>nvme list-ns</em> &lt;device&gt; [--namespace-id=&lt;nsid&gt; | -n &lt;nsid&gt;]
+                        [--all | -a]</pre>
 <div class="attribution">
 </div></div>
 </div>
@@ -779,6 +782,18 @@ a valid nsid.</p></div>
         Retrieve the identify list structure starting with the given nsid.
 </p>
 </dd>
+<dt class="hdlist1">
+-a
+</dt>
+<dt class="hdlist1">
+--all
+</dt>
+<dd>
+<p>
+        Retrieve the identify list structure for all namespaces in the
+        subsystem, whether attached or inactive.
+</p>
+</dd>
 </dl></div>
 </div>
 </div>
@@ -798,7 +813,8 @@ a valid nsid.</p></div>
 <div id="footnotes"><hr /></div>
 <div id="footer">
 <div id="footer-text">
-Last updated 2017-04-18 09:19:59 EDT
+Last updated
+ 2018-01-27 00:47:55 KST
 </div>
 </div>
 </body>
diff --git a/Documentation/nvme-list-ns.txt b/Documentation/nvme-list-ns.txt
index 13a12d6..7cc90d8 100644
--- a/Documentation/nvme-list-ns.txt
+++ b/Documentation/nvme-list-ns.txt
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'nvme list-ns' <device> [--namespace-id=<nsid> | -n <nsid>]
+			[--all | -a]
 
 DESCRIPTION
 -----------
@@ -29,6 +30,11 @@ OPTIONS
 --namespace-id=<nsid>::
 	Retrieve the identify list structure starting with the given nsid.
 
+-a::
+--all::
+	Retrieve the identify list structure for all namespaces in the
+	subsystem, whether attached or inactive.
+
 EXAMPLES
 --------
 No examples yet.
diff --git a/Documentation/nvme-ns-descs.1 b/Documentation/nvme-ns-descs.1
new file mode 100644
index 0000000..03e3188
--- /dev/null
+++ b/Documentation/nvme-ns-descs.1
@@ -0,0 +1,115 @@
+'\" t
+.\"     Title: nvme-ns-descs
+.\"    Author: [FIXME: author] [see http://docbook.sf.net/el/author]
+.\" Generator: DocBook XSL Stylesheets v1.79.1 <http://docbook.sf.net/>
+.\"      Date: 01/27/2018
+.\"    Manual: NVMe Manual
+.\"    Source: NVMe
+.\"  Language: English
+.\"
+.TH "NVME\-NS\-DESCS" "1" "01/27/2018" "NVMe" "NVMe Manual"
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
+nvme-ns-descs \- Send NVMe Identify for a list of Namespace Identification Descriptor structure, return result and structure
+.SH "SYNOPSIS"
+.sp
+.nf
+\fInvme ns\-descs\fR <device> [\-\-namespace\-id=<nsid> | \-n <nsid>]
+                        [\-\-raw\-binary | \-b]
+                        [\-\-output\-format=<fmt> | \-o <fmt>]
+.fi
+.SH "DESCRIPTION"
+.sp
+For the NVMe device given, sends an identify for a list of namespace identification descriptor structures command and provides the result and returned structure\&.
+.sp
+The <device> parameter is mandatory and may be either the NVMe character device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1)\&. If the character device is given, the \*(Aq\-\-namespace\-id\*(Aq option is mandatory, otherwise it will use the ns\-id of the namespace for the block device you opened\&. For block devices, the ns\-id used can be overridden with the same option\&.
+.sp
+On success, the structure may be returned in one of several ways depending on the option flags; the structure may be parsed by the program or the raw buffer may be printed to stdout\&.
+.SH "OPTIONS"
+.PP
+\-n <nsid>, \-\-namespace\-id=<nsid>
+.RS 4
+Retrieve the identify namespace identification descriptor structure for the given nsid\&. This is required for the character devices, or overrides the block nsid if given\&.
+.RE
+.PP
+\-b, \-\-raw\-binary
+.RS 4
+Print the raw buffer to stdout\&. Structure is not parsed by program\&.
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
+If using the character device or overriding namespace #2:
+.sp
+.if n \{\
+.RS 4
+.\}
+.nf
+# nvme ns\-descs /dev/nvme0 \-n 1
+# nvme ns\-descs /dev/nvme0n1 \-n 2
+# nvme ns\-descs /dev/nvme0 \-\-namespace\-id=1
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
+Have the program return the raw structure in binary:
+.sp
+.if n \{\
+.RS 4
+.\}
+.nf
+# nvme ns\-descs /dev/nvme0n1 \-\-raw\-binary > ns_descs\&.raw
+# nvme ns\-descs /dev/nvme0n1 \-b > ns_descs\&.raw
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
diff --git a/Documentation/nvme-ns-descs.html b/Documentation/nvme-ns-descs.html
new file mode 100644
index 0000000..59b731e
--- /dev/null
+++ b/Documentation/nvme-ns-descs.html
@@ -0,0 +1,863 @@
+<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
+    "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
+<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
+<head>
+<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
+<meta name="generator" content="AsciiDoc 8.6.9" />
+<title>nvme-ns-descs(1)</title>
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
+nvme-ns-descs(1) Manual Page
+</h1>
+<h2>NAME</h2>
+<div class="sectionbody">
+<p>nvme-ns-descs -
+   Send NVMe Identify for a list of Namespace Identification                 Descriptor structure, return result and structure
+</p>
+</div>
+</div>
+<div id="content">
+<div class="sect1">
+<h2 id="_synopsis">SYNOPSIS</h2>
+<div class="sectionbody">
+<div class="verseblock">
+<pre class="content"><em>nvme ns-descs</em> &lt;device&gt; [--namespace-id=&lt;nsid&gt; | -n &lt;nsid&gt;]
+                        [--raw-binary | -b]
+                        [--output-format=&lt;fmt&gt; | -o &lt;fmt&gt;]</pre>
+<div class="attribution">
+</div></div>
+</div>
+</div>
+<div class="sect1">
+<h2 id="_description">DESCRIPTION</h2>
+<div class="sectionbody">
+<div class="paragraph"><p>For the NVMe device given, sends an identify for a list of namespace
+identification descriptor structures command and provides the result and
+returned structure.</p></div>
+<div class="paragraph"><p>The &lt;device&gt; parameter is mandatory and may be either the NVMe character
+device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1).
+If the character device is given, the <code>'--namespace-id'</code> option is
+mandatory, otherwise it will use the ns-id of the namespace for the block
+device you opened. For block devices, the ns-id used can be overridden
+with the same option.</p></div>
+<div class="paragraph"><p>On success, the structure may be returned in one of several ways depending
+on the option flags; the structure may be parsed by the program or the
+raw buffer may be printed to stdout.</p></div>
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
+        Retrieve the identify namespace identification descriptor structure
+        for the given nsid. This is required for the character devices, or
+        overrides the block nsid if given.
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
+        Print the raw buffer to stdout. Structure is not parsed by
+        program.
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
+        Set the reporting format to <em>normal</em>, <em>json</em>, or <em>binary</em>.
+        Only one output format can be used at a time.
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
+If using the character device or overriding namespace #2:
+</p>
+<div class="listingblock">
+<div class="content">
+<pre><code># nvme ns-descs /dev/nvme0 -n 1
+# nvme ns-descs /dev/nvme0n1 -n 2
+# nvme ns-descs /dev/nvme0 --namespace-id=1</code></pre>
+</div></div>
+</li>
+<li>
+<p>
+Have the program return the raw structure in binary:
+</p>
+<div class="listingblock">
+<div class="content">
+<pre><code># nvme ns-descs /dev/nvme0n1 --raw-binary &gt; ns_descs.raw
+# nvme ns-descs /dev/nvme0n1 -b &gt; ns_descs.raw</code></pre>
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
+ 2018-01-27 01:07:48 KST
+</div>
+</div>
+</body>
+</html>
diff --git a/Documentation/nvme-ns-descs.txt b/Documentation/nvme-ns-descs.txt
new file mode 100644
index 0000000..8afeba5
--- /dev/null
+++ b/Documentation/nvme-ns-descs.txt
@@ -0,0 +1,74 @@
+nvme-ns-descs(1)
+================
+
+NAME
+----
+nvme-ns-descs - Send NVMe Identify for a list of Namespace Identification
+		Descriptor structure, return result and structure
+
+SYNOPSIS
+--------
+[verse]
+'nvme ns-descs' <device> [--namespace-id=<nsid> | -n <nsid>]
+			[--raw-binary | -b]
+			[--output-format=<fmt> | -o <fmt>]
+
+DESCRIPTION
+-----------
+For the NVMe device given, sends an identify for a list of namespace
+identification descriptor structures command and provides the result and
+returned structure.
+
+The <device> parameter is mandatory and may be either the NVMe character
+device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1).
+If the character device is given, the `'--namespace-id'` option is
+mandatory, otherwise it will use the ns-id of the namespace for the block
+device you opened. For block devices, the ns-id used can be overridden
+with the same option.
+
+On success, the structure may be returned in one of several ways depending
+on the option flags; the structure may be parsed by the program or the
+raw buffer may be printed to stdout.
+
+OPTIONS
+-------
+-n <nsid>::
+--namespace-id=<nsid>::
+	Retrieve the identify namespace identification descriptor structure
+	for the given nsid. This is required for the character devices, or
+	overrides the block nsid if given.
+
+-b::
+--raw-binary::
+	Print the raw buffer to stdout. Structure is not parsed by
+	program.
+
+-o <format>::
+--output-format=<format>::
+	Set the reporting format to 'normal', 'json', or 'binary'.
+	Only one output format can be used at a time.
+
+
+EXAMPLES
+--------
+* If using the character device or overriding namespace #2:
++
+------------
+# nvme ns-descs /dev/nvme0 -n 1
+# nvme ns-descs /dev/nvme0n1 -n 2
+# nvme ns-descs /dev/nvme0 --namespace-id=1
+------------
++
+
+* Have the program return the raw structure in binary:
++
+------------
+# nvme ns-descs /dev/nvme0n1 --raw-binary > ns_descs.raw
+# nvme ns-descs /dev/nvme0n1 -b > ns_descs.raw
+------------
++
+It is probably a bad idea to not redirect stdout when using this mode.
+
+NVME
+----
+Part of the nvme-user suite
diff --git a/Documentation/nvme-read.1 b/Documentation/nvme-read.1
index c53f1a5..bf6c08a 100644
--- a/Documentation/nvme-read.1
+++ b/Documentation/nvme-read.1
@@ -2,12 +2,12 @@
 .\"     Title: nvme-read
 .\"    Author: [FIXME: author] [see http://docbook.sf.net/el/author]
 .\" Generator: DocBook XSL Stylesheets v1.79.1 <http://docbook.sf.net/>
-.\"      Date: 12/10/2017
+.\"      Date: 01/27/2018
 .\"    Manual: NVMe Manual
 .\"    Source: NVMe
 .\"  Language: English
 .\"
-.TH "NVME\-READ" "1" "12/10/2017" "NVMe" "NVMe Manual"
+.TH "NVME\-READ" "1" "01/27/2018" "NVMe" "NVMe Manual"
 .\" -----------------------------------------------------------------
 .\" * Define some portability stuff
 .\" -----------------------------------------------------------------
@@ -43,8 +43,13 @@ nvme-read \- Send an NVMe Read command, provide results
                         [\-\-app\-tag\-mask=<appmask> | \-m <appmask>]
                         [\-\-app\-tag=<apptag> | \-a <apptag>]
                         [\-\-limited\-retry | \-l]
-                        [\-\-latency | \-t]
                         [\-\-force\-unit\-access | \-f]
+                        [\-\-dir\-type=<type> | \-T <type>]
+                        [\-\-dir\-spec=<spec> | \-S <spec>]
+                        [\-\-dsm=<dsm> | \-D <dsm>]
+                        [\-\-show\-command | \-v]
+                        [\-\-dry\-run | \-w]
+                        [\-\-latency | \-t]
 .fi
 .SH "DESCRIPTION"
 .sp
@@ -141,7 +146,35 @@ Optional application tag mask when used with protection information\&.
 Set the force\-unit access flag\&.
 .RE
 .PP
-\-\-latency, \-t
+\-T <type>, \-\-dir\-type=<type>
+.RS 4
+Optional directive type\&. The nvme\-cli only enforces the value be in the defined range for the directive type, though the NVMe specifcation (1\&.3a) defines only one directive, 01h, for write stream idenfiers\&.
+.RE
+.PP
+\-S <spec>, \-\-dir\-spec=<spec>
+.RS 4
+Optional field for directive specifics\&. When used with write streams, this value is defined to be the write stream identifier\&. The nvme\-cli will not validate the stream requested is within the controller\(cqs capabilities\&.
+.RE
+.PP
+\-D <dsm>, \-\-dsm=<dsm>
+.RS 4
+The optional data set management attributes for this command\&. The argument for this is the lower 16 bits of the DSM field in a write command; the upper 16 bits of the field come from the directive specific field, if used\&. This may be used to set attributes for the LBAs being written, like access frequency, type, latency, among other things, as well as yet to be defined types\&. Please consult the NVMe specification for detailed breakdown of how to use this field\&.
+.RE
+.PP
+\-v, \-\-show\-cmd
+.RS 4
+Print out the command to be sent\&.
+.RE
+.PP
+\-w, \-\-dry\-run
+.RS 4
+Do not actually send the command\&. If want to use \-\-dry\-run option, \-\-show\-cmd option
+\fImust\fR
+be set\&. Otherwise \-\-dry\-run optionn will be
+\fIignored\fR\&.
+.RE
+.PP
+\-t, \-\-latency
 .RS 4
 Print out the latency the IOCTL took (in us)\&.
 .RE
diff --git a/Documentation/nvme-read.html b/Documentation/nvme-read.html
index c9d0c1b..2178472 100644
--- a/Documentation/nvme-read.html
+++ b/Documentation/nvme-read.html
@@ -3,7 +3,7 @@
 <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
 <head>
 <meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
-<meta name="generator" content="AsciiDoc 8.6.8" />
+<meta name="generator" content="AsciiDoc 8.6.9" />
 <title>nvme-read(1)</title>
 <style type="text/css">
 /* Shared CSS for AsciiDoc xhtml11 and html5 backends */
@@ -94,7 +94,9 @@ ul > li > * { color: black; }
   padding: 0;
   margin: 0;
 }
-
+pre {
+  white-space: pre-wrap;
+}
 
 #author {
   color: #527bbd;
@@ -223,7 +225,7 @@ div.exampleblock > div.content {
 }
 
 div.imageblock div.content { padding-left: 0; }
-span.image img { border-style: none; }
+span.image img { border-style: none; vertical-align: text-bottom; }
 a.image:visited { color: white; }
 
 dl {
@@ -757,8 +759,13 @@ nvme-read(1) Manual Page
                         [--app-tag-mask=&lt;appmask&gt; | -m &lt;appmask&gt;]
                         [--app-tag=&lt;apptag&gt; | -a &lt;apptag&gt;]
                         [--limited-retry | -l]
-                        [--latency | -t]
-                        [--force-unit-access | -f]</pre>
+                        [--force-unit-access | -f]
+                        [--dir-type=&lt;type&gt; | -T &lt;type&gt;]
+                        [--dir-spec=&lt;spec&gt; | -S &lt;spec&gt;]
+                        [--dsm=&lt;dsm&gt; | -D &lt;dsm&gt;]
+                        [--show-command | -v]
+                        [--dry-run | -w]
+                        [--latency | -t]</pre>
 <div class="attribution">
 </div></div>
 </div>
@@ -925,11 +932,81 @@ metadata is passes.</p></td>
 </p>
 </dd>
 <dt class="hdlist1">
---latency
+-T &lt;type&gt;
+</dt>
+<dt class="hdlist1">
+--dir-type=&lt;type&gt;
+</dt>
+<dd>
+<p>
+        Optional directive type. The nvme-cli only enforces the value
+        be in the defined range for the directive type, though the NVMe
+        specifcation (1.3a) defines only one directive, 01h, for write
+        stream idenfiers.
+</p>
+</dd>
+<dt class="hdlist1">
+-S &lt;spec&gt;
+</dt>
+<dt class="hdlist1">
+--dir-spec=&lt;spec&gt;
+</dt>
+<dd>
+<p>
+        Optional field for directive specifics. When used with
+        write streams, this value is defined to be the write stream
+        identifier. The nvme-cli will not validate the stream requested
+        is within the controller&#8217;s capabilities.
+</p>
+</dd>
+<dt class="hdlist1">
+-D &lt;dsm&gt;
+</dt>
+<dt class="hdlist1">
+--dsm=&lt;dsm&gt;
+</dt>
+<dd>
+<p>
+        The optional data set management attributes for this command. The
+        argument for this is the lower 16 bits of the DSM field in a write
+        command; the upper 16 bits of the field come from the directive
+        specific field, if used. This may be used to set attributes for
+        the LBAs being written, like access frequency, type, latency,
+        among other things, as well as yet to be defined types. Please
+        consult the NVMe specification for detailed breakdown of how to
+        use this field.
+</p>
+</dd>
+<dt class="hdlist1">
+-v
+</dt>
+<dt class="hdlist1">
+--show-cmd
+</dt>
+<dd>
+<p>
+        Print out the command to be sent.
+</p>
+</dd>
+<dt class="hdlist1">
+-w
 </dt>
 <dt class="hdlist1">
+--dry-run
+</dt>
+<dd>
+<p>
+        Do not actually send the command. If want to use --dry-run option,
+        --show-cmd option <em>must</em> be set. Otherwise --dry-run optionn will be
+        <em>ignored</em>.
+</p>
+</dd>
+<dt class="hdlist1">
 -t
 </dt>
+<dt class="hdlist1">
+--latency
+</dt>
 <dd>
 <p>
         Print out the latency the IOCTL took (in us).
@@ -954,7 +1031,8 @@ metadata is passes.</p></td>
 <div id="footnotes"><hr /></div>
 <div id="footer">
 <div id="footer-text">
-Last updated 2017-02-27 10:11:58 EST
+Last updated
+ 2018-01-27 02:05:13 KST
 </div>
 </div>
 </body>
diff --git a/Documentation/nvme-read.txt b/Documentation/nvme-read.txt
index 1d07a0e..186bd8c 100644
--- a/Documentation/nvme-read.txt
+++ b/Documentation/nvme-read.txt
@@ -19,8 +19,13 @@ SYNOPSIS
 			[--app-tag-mask=<appmask> | -m <appmask>]
 			[--app-tag=<apptag> | -a <apptag>]
 			[--limited-retry | -l]
-			[--latency | -t]
 			[--force-unit-access | -f]
+			[--dir-type=<type> | -T <type>]
+			[--dir-spec=<spec> | -S <spec>]
+			[--dsm=<dsm> | -D <dsm>]
+			[--show-command | -v]
+			[--dry-run | -w]
+			[--latency | -t]
 
 DESCRIPTION
 -----------
@@ -84,8 +89,43 @@ metadata is passes.
 -f::
 	Set the force-unit access flag.
 
---latency::
+-T <type>::
+--dir-type=<type>::
+	Optional directive type. The nvme-cli only enforces the value
+	be in the defined range for the directive type, though the NVMe
+	specifcation (1.3a) defines only one directive, 01h, for write
+	stream idenfiers.
+
+-S <spec>::
+--dir-spec=<spec>::
+	Optional field for directive specifics. When used with
+	write streams, this value is defined to be the write stream
+	identifier. The nvme-cli will not validate the stream requested
+	is within the controller's capabilities.
+
+-D <dsm>::
+--dsm=<dsm>::
+	The optional data set management attributes for this command. The
+	argument for this is the lower 16 bits of the DSM field in a write
+	command; the upper 16 bits of the field come from the directive
+	specific field, if used. This may be used to set attributes for
+	the LBAs being written, like access frequency, type, latency,
+	among other things, as well as yet to be defined types. Please
+	consult the NVMe specification for detailed breakdown of how to
+	use this field.
+
+-v::
+--show-cmd::
+	Print out the command to be sent.
+
+-w::
+--dry-run::
+	Do not actually send the command. If want to use --dry-run option,
+	--show-cmd option _must_ be set. Otherwise --dry-run optionn will be
+	_ignored_.
+
 -t::
+--latency::
 	Print out the latency the IOCTL took (in us).
 
 EXAMPLES
diff --git a/Documentation/nvme-resv-acquire.1 b/Documentation/nvme-resv-acquire.1
index 14f3244..5907acf 100644
--- a/Documentation/nvme-resv-acquire.1
+++ b/Documentation/nvme-resv-acquire.1
@@ -2,12 +2,12 @@
 .\"     Title: nvme-resv-acquire
 .\"    Author: [FIXME: author] [see http://docbook.sf.net/el/author]
 .\" Generator: DocBook XSL Stylesheets v1.79.1 <http://docbook.sf.net/>
-.\"      Date: 12/10/2017
+.\"      Date: 01/27/2018
 .\"    Manual: NVMe Manual
 .\"    Source: NVMe
 .\"  Language: English
 .\"
-.TH "NVME\-RESV\-ACQUIRE" "1" "12/10/2017" "NVMe" "NVMe Manual"
+.TH "NVME\-RESV\-ACQUIRE" "1" "01/27/2018" "NVMe" "NVMe Manual"
 .\" -----------------------------------------------------------------
 .\" * Define some portability stuff
 .\" -----------------------------------------------------------------
@@ -32,7 +32,12 @@ nvme-resv-acquire \- Acquire an nvme reservation
 .SH "SYNOPSIS"
 .sp
 .nf
-\fInvme resv\-acquire\fR <device>
+\fInvme resv\-acquire\fR <device> [\-\-namespace\-id=<nsid> | \-n <nsid>]
+                             [\-\-crkey=<crkey> | \-c <crkey>]
+                             [\-\-prkey=<prkey> | \-p <prkey>]
+                             [\-\-rtype=<rtype> | \-t <rtype>]
+                             [\-\-racqa=<racqa> | \-a <racqa>]
+                             [\-\-iekey | \-i]
 .fi
 .SH "DESCRIPTION"
 .sp
diff --git a/Documentation/nvme-resv-acquire.html b/Documentation/nvme-resv-acquire.html
index d30196e..5e57709 100644
--- a/Documentation/nvme-resv-acquire.html
+++ b/Documentation/nvme-resv-acquire.html
@@ -3,7 +3,7 @@
 <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
 <head>
 <meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
-<meta name="generator" content="AsciiDoc 8.6.8" />
+<meta name="generator" content="AsciiDoc 8.6.9" />
 <title>nvme-resv-acquire(1)</title>
 <style type="text/css">
 /* Shared CSS for AsciiDoc xhtml11 and html5 backends */
@@ -94,7 +94,9 @@ ul > li > * { color: black; }
   padding: 0;
   margin: 0;
 }
-
+pre {
+  white-space: pre-wrap;
+}
 
 #author {
   color: #527bbd;
@@ -223,7 +225,7 @@ div.exampleblock > div.content {
 }
 
 div.imageblock div.content { padding-left: 0; }
-span.image img { border-style: none; }
+span.image img { border-style: none; vertical-align: text-bottom; }
 a.image:visited { color: white; }
 
 dl {
@@ -746,7 +748,12 @@ nvme-resv-acquire(1) Manual Page
 <h2 id="_synopsis">SYNOPSIS</h2>
 <div class="sectionbody">
 <div class="verseblock">
-<pre class="content"><em>nvme resv-acquire</em> &lt;device&gt;</pre>
+<pre class="content"><em>nvme resv-acquire</em> &lt;device&gt; [--namespace-id=&lt;nsid&gt; | -n &lt;nsid&gt;]
+                             [--crkey=&lt;crkey&gt; | -c &lt;crkey&gt;]
+                             [--prkey=&lt;prkey&gt; | -p &lt;prkey&gt;]
+                             [--rtype=&lt;rtype&gt; | -t &lt;rtype&gt;]
+                             [--racqa=&lt;racqa&gt; | -a &lt;racqa&gt;]
+                             [--iekey | -i]</pre>
 <div class="attribution">
 </div></div>
 </div>
@@ -939,7 +946,8 @@ cellspacing="0" cellpadding="4">
 <div id="footnotes"><hr /></div>
 <div id="footer">
 <div id="footer-text">
-Last updated 2016-05-16 12:47:42 EDT
+Last updated
+ 2018-01-27 01:46:31 KST
 </div>
 </div>
 </body>
diff --git a/Documentation/nvme-resv-acquire.txt b/Documentation/nvme-resv-acquire.txt
index 6433f7d..41cbf8f 100644
--- a/Documentation/nvme-resv-acquire.txt
+++ b/Documentation/nvme-resv-acquire.txt
@@ -8,7 +8,12 @@ nvme-resv-acquire - Acquire an nvme reservation
 SYNOPSIS
 --------
 [verse]
-'nvme resv-acquire' <device>
+'nvme resv-acquire' <device> [--namespace-id=<nsid> | -n <nsid>]
+			     [--crkey=<crkey> | -c <crkey>]
+			     [--prkey=<prkey> | -p <prkey>]
+			     [--rtype=<rtype> | -t <rtype>]
+			     [--racqa=<racqa> | -a <racqa>]
+			     [--iekey | -i]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/nvme-resv-register.1 b/Documentation/nvme-resv-register.1
index dc9ef09..afc56b1 100644
--- a/Documentation/nvme-resv-register.1
+++ b/Documentation/nvme-resv-register.1
@@ -2,12 +2,12 @@
 .\"     Title: nvme-resv-register
 .\"    Author: [FIXME: author] [see http://docbook.sf.net/el/author]
 .\" Generator: DocBook XSL Stylesheets v1.79.1 <http://docbook.sf.net/>
-.\"      Date: 12/10/2017
+.\"      Date: 01/27/2018
 .\"    Manual: NVMe Manual
 .\"    Source: NVMe
 .\"  Language: English
 .\"
-.TH "NVME\-RESV\-REGISTER" "1" "12/10/2017" "NVMe" "NVMe Manual"
+.TH "NVME\-RESV\-REGISTER" "1" "01/27/2018" "NVMe" "NVMe Manual"
 .\" -----------------------------------------------------------------
 .\" * Define some portability stuff
 .\" -----------------------------------------------------------------
@@ -32,7 +32,12 @@ nvme-resv-register \- Register an nvme reservation
 .SH "SYNOPSIS"
 .sp
 .nf
-\fInvme resv\-register\fR <device>
+\fInvme resv\-register\fR <device> [\-\-namespace\-id=<nsid> | \-n <nsid>]
+                              [\-\-crkey=<crkey> | \-c <crkey>]
+                              [\-\-nrkey=<nrkey> | \-k <nrkey>]
+                              [\-\-rrega=<rrega> | \-r <rrega>]
+                              [\-\-cptpl=<cptpl> | \-p <cptpl>]
+                              [\-\-iekey | \-i]
 .fi
 .SH "DESCRIPTION"
 .sp
diff --git a/Documentation/nvme-resv-register.html b/Documentation/nvme-resv-register.html
index fb97720..e60c78d 100644
--- a/Documentation/nvme-resv-register.html
+++ b/Documentation/nvme-resv-register.html
@@ -3,7 +3,7 @@
 <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
 <head>
 <meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
-<meta name="generator" content="AsciiDoc 8.6.8" />
+<meta name="generator" content="AsciiDoc 8.6.9" />
 <title>nvme-resv-register(1)</title>
 <style type="text/css">
 /* Shared CSS for AsciiDoc xhtml11 and html5 backends */
@@ -94,7 +94,9 @@ ul > li > * { color: black; }
   padding: 0;
   margin: 0;
 }
-
+pre {
+  white-space: pre-wrap;
+}
 
 #author {
   color: #527bbd;
@@ -223,7 +225,7 @@ div.exampleblock > div.content {
 }
 
 div.imageblock div.content { padding-left: 0; }
-span.image img { border-style: none; }
+span.image img { border-style: none; vertical-align: text-bottom; }
 a.image:visited { color: white; }
 
 dl {
@@ -746,7 +748,12 @@ nvme-resv-register(1) Manual Page
 <h2 id="_synopsis">SYNOPSIS</h2>
 <div class="sectionbody">
 <div class="verseblock">
-<pre class="content"><em>nvme resv-register</em> &lt;device&gt;</pre>
+<pre class="content"><em>nvme resv-register</em> &lt;device&gt; [--namespace-id=&lt;nsid&gt; | -n &lt;nsid&gt;]
+                              [--crkey=&lt;crkey&gt; | -c &lt;crkey&gt;]
+                              [--nrkey=&lt;nrkey&gt; | -k &lt;nrkey&gt;]
+                              [--rrega=&lt;rrega&gt; | -r &lt;rrega&gt;]
+                              [--cptpl=&lt;cptpl&gt; | -p &lt;cptpl&gt;]
+                              [--iekey | -i]</pre>
 <div class="attribution">
 </div></div>
 </div>
@@ -928,7 +935,8 @@ cellspacing="0" cellpadding="4">
 <div id="footnotes"><hr /></div>
 <div id="footer">
 <div id="footer-text">
-Last updated 2016-05-16 12:47:42 EDT
+Last updated
+ 2018-01-27 01:46:24 KST
 </div>
 </div>
 </body>
diff --git a/Documentation/nvme-resv-register.txt b/Documentation/nvme-resv-register.txt
index 89d6d53..076e979 100644
--- a/Documentation/nvme-resv-register.txt
+++ b/Documentation/nvme-resv-register.txt
@@ -8,7 +8,12 @@ nvme-resv-register - Register an nvme reservation
 SYNOPSIS
 --------
 [verse]
-'nvme resv-register' <device>
+'nvme resv-register' <device> [--namespace-id=<nsid> | -n <nsid>]
+			      [--crkey=<crkey> | -c <crkey>]
+			      [--nrkey=<nrkey> | -k <nrkey>]
+			      [--rrega=<rrega> | -r <rrega>]
+			      [--cptpl=<cptpl> | -p <cptpl>]
+			      [--iekey | -i]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/nvme-resv-release.1 b/Documentation/nvme-resv-release.1
index c51375b..c288eb7 100644
--- a/Documentation/nvme-resv-release.1
+++ b/Documentation/nvme-resv-release.1
@@ -2,12 +2,12 @@
 .\"     Title: nvme-resv-release
 .\"    Author: [FIXME: author] [see http://docbook.sf.net/el/author]
 .\" Generator: DocBook XSL Stylesheets v1.79.1 <http://docbook.sf.net/>
-.\"      Date: 12/10/2017
+.\"      Date: 01/27/2018
 .\"    Manual: NVMe Manual
 .\"    Source: NVMe
 .\"  Language: English
 .\"
-.TH "NVME\-RESV\-RELEASE" "1" "12/10/2017" "NVMe" "NVMe Manual"
+.TH "NVME\-RESV\-RELEASE" "1" "01/27/2018" "NVMe" "NVMe Manual"
 .\" -----------------------------------------------------------------
 .\" * Define some portability stuff
 .\" -----------------------------------------------------------------
@@ -32,7 +32,11 @@ nvme-resv-release \- Release an nvme reservation
 .SH "SYNOPSIS"
 .sp
 .nf
-\fInvme resv\-release\fR <device>
+\fInvme resv\-release\fR <device> [\-\-namespace\-id=<nsid> | \-n <nsid>]
+                             [\-\-crkey=<crkey> | \-c <crkey>]
+                             [\-\-rtype=<rtype> | \-t <rtype>]
+                             [\-\-rrela=<rrela> | \-a <rrela>]
+                             [\-\-iekey | \-i]
 .fi
 .SH "DESCRIPTION"
 .sp
diff --git a/Documentation/nvme-resv-release.html b/Documentation/nvme-resv-release.html
index 6f45da9..aed1fc5 100644
--- a/Documentation/nvme-resv-release.html
+++ b/Documentation/nvme-resv-release.html
@@ -3,7 +3,7 @@
 <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
 <head>
 <meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
-<meta name="generator" content="AsciiDoc 8.6.8" />
+<meta name="generator" content="AsciiDoc 8.6.9" />
 <title>nvme-resv-release(1)</title>
 <style type="text/css">
 /* Shared CSS for AsciiDoc xhtml11 and html5 backends */
@@ -94,7 +94,9 @@ ul > li > * { color: black; }
   padding: 0;
   margin: 0;
 }
-
+pre {
+  white-space: pre-wrap;
+}
 
 #author {
   color: #527bbd;
@@ -223,7 +225,7 @@ div.exampleblock > div.content {
 }
 
 div.imageblock div.content { padding-left: 0; }
-span.image img { border-style: none; }
+span.image img { border-style: none; vertical-align: text-bottom; }
 a.image:visited { color: white; }
 
 dl {
@@ -746,7 +748,11 @@ nvme-resv-release(1) Manual Page
 <h2 id="_synopsis">SYNOPSIS</h2>
 <div class="sectionbody">
 <div class="verseblock">
-<pre class="content"><em>nvme resv-release</em> &lt;device&gt;</pre>
+<pre class="content"><em>nvme resv-release</em> &lt;device&gt; [--namespace-id=&lt;nsid&gt; | -n &lt;nsid&gt;]
+                             [--crkey=&lt;crkey&gt; | -c &lt;crkey&gt;]
+                             [--rtype=&lt;rtype&gt; | -t &lt;rtype&gt;]
+                             [--rrela=&lt;rrela&gt; | -a &lt;rrela&gt;]
+                             [--iekey | -i]</pre>
 <div class="attribution">
 </div></div>
 </div>
@@ -922,7 +928,8 @@ cellspacing="0" cellpadding="4">
 <div id="footnotes"><hr /></div>
 <div id="footer">
 <div id="footer-text">
-Last updated 2016-05-16 12:47:42 EDT
+Last updated
+ 2018-01-27 01:48:53 KST
 </div>
 </div>
 </body>
diff --git a/Documentation/nvme-resv-release.txt b/Documentation/nvme-resv-release.txt
index dee3bda..a6a895e 100644
--- a/Documentation/nvme-resv-release.txt
+++ b/Documentation/nvme-resv-release.txt
@@ -8,7 +8,11 @@ nvme-resv-release - Release an nvme reservation
 SYNOPSIS
 --------
 [verse]
-'nvme resv-release' <device>
+'nvme resv-release' <device> [--namespace-id=<nsid> | -n <nsid>]
+			     [--crkey=<crkey> | -c <crkey>]
+			     [--rtype=<rtype> | -t <rtype>]
+			     [--rrela=<rrela> | -a <rrela>]
+			     [--iekey | -i]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/nvme-resv-report.1 b/Documentation/nvme-resv-report.1
index 4aed145..cdf30e5 100644
--- a/Documentation/nvme-resv-report.1
+++ b/Documentation/nvme-resv-report.1
@@ -2,12 +2,12 @@
 .\"     Title: nvme-resv-report
 .\"    Author: [FIXME: author] [see http://docbook.sf.net/el/author]
 .\" Generator: DocBook XSL Stylesheets v1.79.1 <http://docbook.sf.net/>
-.\"      Date: 12/10/2017
+.\"      Date: 01/27/2018
 .\"    Manual: NVMe Manual
 .\"    Source: NVMe
 .\"  Language: English
 .\"
-.TH "NVME\-RESV\-REPORT" "1" "12/10/2017" "NVMe" "NVMe Manual"
+.TH "NVME\-RESV\-REPORT" "1" "01/27/2018" "NVMe" "NVMe Manual"
 .\" -----------------------------------------------------------------
 .\" * Define some portability stuff
 .\" -----------------------------------------------------------------
@@ -34,8 +34,9 @@ nvme-resv-report \- Send NVMe Reservation Report, parse the result
 .nf
 \fInvme resv\-report\fR <device> [\-\-namespace\-id=<nsid> | \-n <nsid>]
                         [\-\-numd=<num\-dwords> | \-d <num\-dwords>]
-                        [\-b | \-\-raw\-binary]
-                        [\-o <fmt> | \-\-output\-format=<fmt>]
+                        [\-\-cdw11=<cdw11> | \-c <cdw11>]
+                        [\-\-raw\-binary | \-b]
+                        [\-\-output\-format=<fmt> | \-o <fmt>]
 .fi
 .SH "DESCRIPTION"
 .sp
diff --git a/Documentation/nvme-resv-report.html b/Documentation/nvme-resv-report.html
index 4bb9f85..6447b06 100644
--- a/Documentation/nvme-resv-report.html
+++ b/Documentation/nvme-resv-report.html
@@ -3,7 +3,7 @@
 <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
 <head>
 <meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
-<meta name="generator" content="AsciiDoc 8.6.8" />
+<meta name="generator" content="AsciiDoc 8.6.9" />
 <title>nvme-resv-report(1)</title>
 <style type="text/css">
 /* Shared CSS for AsciiDoc xhtml11 and html5 backends */
@@ -94,7 +94,9 @@ ul > li > * { color: black; }
   padding: 0;
   margin: 0;
 }
-
+pre {
+  white-space: pre-wrap;
+}
 
 #author {
   color: #527bbd;
@@ -223,7 +225,7 @@ div.exampleblock > div.content {
 }
 
 div.imageblock div.content { padding-left: 0; }
-span.image img { border-style: none; }
+span.image img { border-style: none; vertical-align: text-bottom; }
 a.image:visited { color: white; }
 
 dl {
@@ -748,8 +750,9 @@ nvme-resv-report(1) Manual Page
 <div class="verseblock">
 <pre class="content"><em>nvme resv-report</em> &lt;device&gt; [--namespace-id=&lt;nsid&gt; | -n &lt;nsid&gt;]
                         [--numd=&lt;num-dwords&gt; | -d &lt;num-dwords&gt;]
-                        [-b | --raw-binary]
-                        [-o &lt;fmt&gt; | --output-format=&lt;fmt&gt;]</pre>
+                        [--cdw11=&lt;cdw11&gt; | -c &lt;cdw11&gt;]
+                        [--raw-binary | -b]
+                        [--output-format=&lt;fmt&gt; | -o &lt;fmt&gt;]</pre>
 <div class="attribution">
 </div></div>
 </div>
@@ -850,7 +853,8 @@ Controller data structure for each such controller).</p></div>
 <div id="footnotes"><hr /></div>
 <div id="footer">
 <div id="footer-text">
-Last updated 2017-06-28 15:53:33 EDT
+Last updated
+ 2018-01-27 01:49:42 KST
 </div>
 </div>
 </body>
diff --git a/Documentation/nvme-resv-report.txt b/Documentation/nvme-resv-report.txt
index e207102..b53c141 100644
--- a/Documentation/nvme-resv-report.txt
+++ b/Documentation/nvme-resv-report.txt
@@ -10,8 +10,9 @@ SYNOPSIS
 [verse]
 'nvme resv-report' <device> [--namespace-id=<nsid> | -n <nsid>]
 			[--numd=<num-dwords> | -d <num-dwords>]
-			[-b | --raw-binary]
-			[-o <fmt> | --output-format=<fmt>]
+			[--cdw11=<cdw11> | -c <cdw11>]
+			[--raw-binary | -b]
+			[--output-format=<fmt> | -o <fmt>]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/nvme-sanitize-log.1 b/Documentation/nvme-sanitize-log.1
index fd0365b..2c85af0 100644
--- a/Documentation/nvme-sanitize-log.1
+++ b/Documentation/nvme-sanitize-log.1
@@ -2,12 +2,12 @@
 .\"     Title: nvme-sanitize-log
 .\"    Author: [FIXME: author] [see http://docbook.sf.net/el/author]
 .\" Generator: DocBook XSL Stylesheets v1.79.1 <http://docbook.sf.net/>
-.\"      Date: 12/10/2017
+.\"      Date: 01/27/2018
 .\"    Manual: NVMe Manual
 .\"    Source: NVMe
 .\"  Language: English
 .\"
-.TH "NVME\-SANITIZE\-LOG" "1" "12/10/2017" "NVMe" "NVMe Manual"
+.TH "NVME\-SANITIZE\-LOG" "1" "01/27/2018" "NVMe" "NVMe Manual"
 .\" -----------------------------------------------------------------
 .\" * Define some portability stuff
 .\" -----------------------------------------------------------------
@@ -32,7 +32,9 @@ nvme-sanitize-log \- Send NVMe sanitize\-log Command, return result
 .SH "SYNOPSIS"
 .sp
 .nf
-\fInvme sanitize\-log\fR <device>
+\fInvme sanitize\-log\fR <device> [\-\-output\-format=<fmt> | \-o <fmt>]
+                             [\-\-human\-readable | \-H]
+                             [\-\-raw\-binary | \-b]
 .fi
 .SH "DESCRIPTION"
 .sp
@@ -97,8 +99,24 @@ Sanitize Progress \- percentage complete
 .sp
 On success it returns 0, error code otherwise\&.
 .SH "OPTIONS"
-.sp
-No options yet\&.
+.PP
+\-o <format>, \-\-output\-format=<format>
+.RS 4
+Set the reporting format to
+\fInormal\fR,
+\fIjson\fR, or
+\fIbinary\fR\&. Only one output format can be used at a time\&.
+.RE
+.PP
+\-H, \-\-human\-readable
+.RS 4
+This option will parse and format many of the bit fields into human\-readable formats\&.
+.RE
+.PP
+\-b, \-\-raw\-binary
+.RS 4
+Print the raw buffer to stdout\&. Structure is not parsed by program\&. This overrides the vendor specific and human readable options\&.
+.RE
 .SH "EXAMPLES"
 .sp
 .RS 4
diff --git a/Documentation/nvme-sanitize-log.html b/Documentation/nvme-sanitize-log.html
index 2b2c5f0..2887cd0 100644
--- a/Documentation/nvme-sanitize-log.html
+++ b/Documentation/nvme-sanitize-log.html
@@ -1,848 +1,887 @@
-<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
-    "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
-<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
-<head>
-<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
-<meta name="generator" content="AsciiDoc 8.6.9" />
-<title>nvme-sanitize-log(1)</title>
-<style type="text/css">
-/* Shared CSS for AsciiDoc xhtml11 and html5 backends */
-
-/* Default font. */
-body {
-  font-family: Georgia,serif;
-}
-
-/* Title font. */
-h1, h2, h3, h4, h5, h6,
-div.title, caption.title,
-thead, p.table.header,
-#toctitle,
-#author, #revnumber, #revdate, #revremark,
-#footer {
-  font-family: Arial,Helvetica,sans-serif;
-}
-
-body {
-  margin: 1em 5% 1em 5%;
-}
-
-a {
-  color: blue;
-  text-decoration: underline;
-}
-a:visited {
-  color: fuchsia;
-}
-
-em {
-  font-style: italic;
-  color: navy;
-}
-
-strong {
-  font-weight: bold;
-  color: #083194;
-}
-
-h1, h2, h3, h4, h5, h6 {
-  color: #527bbd;
-  margin-top: 1.2em;
-  margin-bottom: 0.5em;
-  line-height: 1.3;
-}
-
-h1, h2, h3 {
-  border-bottom: 2px solid silver;
-}
-h2 {
-  padding-top: 0.5em;
-}
-h3 {
-  float: left;
-}
-h3 + * {
-  clear: left;
-}
-h5 {
-  font-size: 1.0em;
-}
-
-div.sectionbody {
-  margin-left: 0;
-}
-
-hr {
-  border: 1px solid silver;
-}
-
-p {
-  margin-top: 0.5em;
-  margin-bottom: 0.5em;
-}
-
-ul, ol, li > p {
-  margin-top: 0;
-}
-ul > li     { color: #aaa; }
-ul > li > * { color: black; }
-
-.monospaced, code, pre {
-  font-family: "Courier New", Courier, monospace;
-  font-size: inherit;
-  color: navy;
-  padding: 0;
-  margin: 0;
-}
-pre {
-  white-space: pre-wrap;
-}
-
-#author {
-  color: #527bbd;
-  font-weight: bold;
-  font-size: 1.1em;
-}
-#email {
-}
-#revnumber, #revdate, #revremark {
-}
-
-#footer {
-  font-size: small;
-  border-top: 2px solid silver;
-  padding-top: 0.5em;
-  margin-top: 4.0em;
-}
-#footer-text {
-  float: left;
-  padding-bottom: 0.5em;
-}
-#footer-badges {
-  float: right;
-  padding-bottom: 0.5em;
-}
-
-#preamble {
-  margin-top: 1.5em;
-  margin-bottom: 1.5em;
-}
-div.imageblock, div.exampleblock, div.verseblock,
-div.quoteblock, div.literalblock, div.listingblock, div.sidebarblock,
-div.admonitionblock {
-  margin-top: 1.0em;
-  margin-bottom: 1.5em;
-}
-div.admonitionblock {
-  margin-top: 2.0em;
-  margin-bottom: 2.0em;
-  margin-right: 10%;
-  color: #606060;
-}
-
-div.content { /* Block element content. */
-  padding: 0;
-}
-
-/* Block element titles. */
-div.title, caption.title {
-  color: #527bbd;
-  font-weight: bold;
-  text-align: left;
-  margin-top: 1.0em;
-  margin-bottom: 0.5em;
-}
-div.title + * {
-  margin-top: 0;
-}
-
-td div.title:first-child {
-  margin-top: 0.0em;
-}
-div.content div.title:first-child {
-  margin-top: 0.0em;
-}
-div.content + div.title {
-  margin-top: 0.0em;
-}
-
-div.sidebarblock > div.content {
-  background: #ffffee;
-  border: 1px solid #dddddd;
-  border-left: 4px solid #f0f0f0;
-  padding: 0.5em;
-}
-
-div.listingblock > div.content {
-  border: 1px solid #dddddd;
-  border-left: 5px solid #f0f0f0;
-  background: #f8f8f8;
-  padding: 0.5em;
-}
-
-div.quoteblock, div.verseblock {
-  padding-left: 1.0em;
-  margin-left: 1.0em;
-  margin-right: 10%;
-  border-left: 5px solid #f0f0f0;
-  color: #888;
-}
-
-div.quoteblock > div.attribution {
-  padding-top: 0.5em;
-  text-align: right;
-}
-
-div.verseblock > pre.content {
-  font-family: inherit;
-  font-size: inherit;
-}
-div.verseblock > div.attribution {
-  padding-top: 0.75em;
-  text-align: left;
-}
-/* DEPRECATED: Pre version 8.2.7 verse style literal block. */
-div.verseblock + div.attribution {
-  text-align: left;
-}
-
-div.admonitionblock .icon {
-  vertical-align: top;
-  font-size: 1.1em;
-  font-weight: bold;
-  text-decoration: underline;
-  color: #527bbd;
-  padding-right: 0.5em;
-}
-div.admonitionblock td.content {
-  padding-left: 0.5em;
-  border-left: 3px solid #dddddd;
-}
-
-div.exampleblock > div.content {
-  border-left: 3px solid #dddddd;
-  padding-left: 0.5em;
-}
-
-div.imageblock div.content { padding-left: 0; }
-span.image img { border-style: none; vertical-align: text-bottom; }
-a.image:visited { color: white; }
-
-dl {
-  margin-top: 0.8em;
-  margin-bottom: 0.8em;
-}
-dt {
-  margin-top: 0.5em;
-  margin-bottom: 0;
-  font-style: normal;
-  color: navy;
-}
-dd > *:first-child {
-  margin-top: 0.1em;
-}
-
-ul, ol {
-    list-style-position: outside;
-}
-ol.arabic {
-  list-style-type: decimal;
-}
-ol.loweralpha {
-  list-style-type: lower-alpha;
-}
-ol.upperalpha {
-  list-style-type: upper-alpha;
-}
-ol.lowerroman {
-  list-style-type: lower-roman;
-}
-ol.upperroman {
-  list-style-type: upper-roman;
-}
-
-div.compact ul, div.compact ol,
-div.compact p, div.compact p,
-div.compact div, div.compact div {
-  margin-top: 0.1em;
-  margin-bottom: 0.1em;
-}
-
-tfoot {
-  font-weight: bold;
-}
-td > div.verse {
-  white-space: pre;
-}
-
-div.hdlist {
-  margin-top: 0.8em;
-  margin-bottom: 0.8em;
-}
-div.hdlist tr {
-  padding-bottom: 15px;
-}
-dt.hdlist1.strong, td.hdlist1.strong {
-  font-weight: bold;
-}
-td.hdlist1 {
-  vertical-align: top;
-  font-style: normal;
-  padding-right: 0.8em;
-  color: navy;
-}
-td.hdlist2 {
-  vertical-align: top;
-}
-div.hdlist.compact tr {
-  margin: 0;
-  padding-bottom: 0;
-}
-
-.comment {
-  background: yellow;
-}
-
-.footnote, .footnoteref {
-  font-size: 0.8em;
-}
-
-span.footnote, span.footnoteref {
-  vertical-align: super;
-}
-
-#footnotes {
-  margin: 20px 0 20px 0;
-  padding: 7px 0 0 0;
-}
-
-#footnotes div.footnote {
-  margin: 0 0 5px 0;
-}
-
-#footnotes hr {
-  border: none;
-  border-top: 1px solid silver;
-  height: 1px;
-  text-align: left;
-  margin-left: 0;
-  width: 20%;
-  min-width: 100px;
-}
-
-div.colist td {
-  padding-right: 0.5em;
-  padding-bottom: 0.3em;
-  vertical-align: top;
-}
-div.colist td img {
-  margin-top: 0.3em;
-}
-
- at media print {
-  #footer-badges { display: none; }
-}
-
-#toc {
-  margin-bottom: 2.5em;
-}
-
-#toctitle {
-  color: #527bbd;
-  font-size: 1.1em;
-  font-weight: bold;
-  margin-top: 1.0em;
-  margin-bottom: 0.1em;
-}
-
-div.toclevel0, div.toclevel1, div.toclevel2, div.toclevel3, div.toclevel4 {
-  margin-top: 0;
-  margin-bottom: 0;
-}
-div.toclevel2 {
-  margin-left: 2em;
-  font-size: 0.9em;
-}
-div.toclevel3 {
-  margin-left: 4em;
-  font-size: 0.9em;
-}
-div.toclevel4 {
-  margin-left: 6em;
-  font-size: 0.9em;
-}
-
-span.aqua { color: aqua; }
-span.black { color: black; }
-span.blue { color: blue; }
-span.fuchsia { color: fuchsia; }
-span.gray { color: gray; }
-span.green { color: green; }
-span.lime { color: lime; }
-span.maroon { color: maroon; }
-span.navy { color: navy; }
-span.olive { color: olive; }
-span.purple { color: purple; }
-span.red { color: red; }
-span.silver { color: silver; }
-span.teal { color: teal; }
-span.white { color: white; }
-span.yellow { color: yellow; }
-
-span.aqua-background { background: aqua; }
-span.black-background { background: black; }
-span.blue-background { background: blue; }
-span.fuchsia-background { background: fuchsia; }
-span.gray-background { background: gray; }
-span.green-background { background: green; }
-span.lime-background { background: lime; }
-span.maroon-background { background: maroon; }
-span.navy-background { background: navy; }
-span.olive-background { background: olive; }
-span.purple-background { background: purple; }
-span.red-background { background: red; }
-span.silver-background { background: silver; }
-span.teal-background { background: teal; }
-span.white-background { background: white; }
-span.yellow-background { background: yellow; }
-
-span.big { font-size: 2em; }
-span.small { font-size: 0.6em; }
-
-span.underline { text-decoration: underline; }
-span.overline { text-decoration: overline; }
-span.line-through { text-decoration: line-through; }
-
-div.unbreakable { page-break-inside: avoid; }
-
-
-/*
- * xhtml11 specific
- *
- * */
-
-div.tableblock {
-  margin-top: 1.0em;
-  margin-bottom: 1.5em;
-}
-div.tableblock > table {
-  border: 3px solid #527bbd;
-}
-thead, p.table.header {
-  font-weight: bold;
-  color: #527bbd;
-}
-p.table {
-  margin-top: 0;
-}
-/* Because the table frame attribute is overriden by CSS in most browsers. */
-div.tableblock > table[frame="void"] {
-  border-style: none;
-}
-div.tableblock > table[frame="hsides"] {
-  border-left-style: none;
-  border-right-style: none;
-}
-div.tableblock > table[frame="vsides"] {
-  border-top-style: none;
-  border-bottom-style: none;
-}
-
-
-/*
- * html5 specific
- *
- * */
-
-table.tableblock {
-  margin-top: 1.0em;
-  margin-bottom: 1.5em;
-}
-thead, p.tableblock.header {
-  font-weight: bold;
-  color: #527bbd;
-}
-p.tableblock {
-  margin-top: 0;
-}
-table.tableblock {
-  border-width: 3px;
-  border-spacing: 0px;
-  border-style: solid;
-  border-color: #527bbd;
-  border-collapse: collapse;
-}
-th.tableblock, td.tableblock {
-  border-width: 1px;
-  padding: 4px;
-  border-style: solid;
-  border-color: #527bbd;
-}
-
-table.tableblock.frame-topbot {
-  border-left-style: hidden;
-  border-right-style: hidden;
-}
-table.tableblock.frame-sides {
-  border-top-style: hidden;
-  border-bottom-style: hidden;
-}
-table.tableblock.frame-none {
-  border-style: hidden;
-}
-
-th.tableblock.halign-left, td.tableblock.halign-left {
-  text-align: left;
-}
-th.tableblock.halign-center, td.tableblock.halign-center {
-  text-align: center;
-}
-th.tableblock.halign-right, td.tableblock.halign-right {
-  text-align: right;
-}
-
-th.tableblock.valign-top, td.tableblock.valign-top {
-  vertical-align: top;
-}
-th.tableblock.valign-middle, td.tableblock.valign-middle {
-  vertical-align: middle;
-}
-th.tableblock.valign-bottom, td.tableblock.valign-bottom {
-  vertical-align: bottom;
-}
-
-
-/*
- * manpage specific
- *
- * */
-
-body.manpage h1 {
-  padding-top: 0.5em;
-  padding-bottom: 0.5em;
-  border-top: 2px solid silver;
-  border-bottom: 2px solid silver;
-}
-body.manpage h2 {
-  border-style: none;
-}
-body.manpage div.sectionbody {
-  margin-left: 3em;
-}
-
- at media print {
-  body.manpage div#toc { display: none; }
-}
-
-
-</style>
-<script type="text/javascript">
-/*<![CDATA[*/
-var asciidoc = {  // Namespace.
-
-/////////////////////////////////////////////////////////////////////
-// Table Of Contents generator
-/////////////////////////////////////////////////////////////////////
-
-/* Author: Mihai Bazon, September 2002
- * http://students.infoiasi.ro/~mishoo
- *
- * Table Of Content generator
- * Version: 0.4
- *
- * Feel free to use this script under the terms of the GNU General Public
- * License, as long as you do not remove or alter this notice.
- */
-
- /* modified by Troy D. Hanson, September 2006. License: GPL */
- /* modified by Stuart Rackham, 2006, 2009. License: GPL */
-
-// toclevels = 1..4.
-toc: function (toclevels) {
-
-  function getText(el) {
-    var text = "";
-    for (var i = el.firstChild; i != null; i = i.nextSibling) {
-      if (i.nodeType == 3 /* Node.TEXT_NODE */) // IE doesn't speak constants.
-        text += i.data;
-      else if (i.firstChild != null)
-        text += getText(i);
-    }
-    return text;
-  }
-
-  function TocEntry(el, text, toclevel) {
-    this.element = el;
-    this.text = text;
-    this.toclevel = toclevel;
-  }
-
-  function tocEntries(el, toclevels) {
-    var result = new Array;
-    var re = new RegExp('[hH]([1-'+(toclevels+1)+'])');
-    // Function that scans the DOM tree for header elements (the DOM2
-    // nodeIterator API would be a better technique but not supported by all
-    // browsers).
-    var iterate = function (el) {
-      for (var i = el.firstChild; i != null; i = i.nextSibling) {
-        if (i.nodeType == 1 /* Node.ELEMENT_NODE */) {
-          var mo = re.exec(i.tagName);
-          if (mo && (i.getAttribute("class") || i.getAttribute("className")) != "float") {
-            result[result.length] = new TocEntry(i, getText(i), mo[1]-1);
-          }
-          iterate(i);
-        }
-      }
-    }
-    iterate(el);
-    return result;
-  }
-
-  var toc = document.getElementById("toc");
-  if (!toc) {
-    return;
-  }
-
-  // Delete existing TOC entries in case we're reloading the TOC.
-  var tocEntriesToRemove = [];
-  var i;
-  for (i = 0; i < toc.childNodes.length; i++) {
-    var entry = toc.childNodes[i];
-    if (entry.nodeName.toLowerCase() == 'div'
-     && entry.getAttribute("class")
-     && entry.getAttribute("class").match(/^toclevel/))
-      tocEntriesToRemove.push(entry);
-  }
-  for (i = 0; i < tocEntriesToRemove.length; i++) {
-    toc.removeChild(tocEntriesToRemove[i]);
-  }
-
-  // Rebuild TOC entries.
-  var entries = tocEntries(document.getElementById("content"), toclevels);
-  for (var i = 0; i < entries.length; ++i) {
-    var entry = entries[i];
-    if (entry.element.id == "")
-      entry.element.id = "_toc_" + i;
-    var a = document.createElement("a");
-    a.href = "#" + entry.element.id;
-    a.appendChild(document.createTextNode(entry.text));
-    var div = document.createElement("div");
-    div.appendChild(a);
-    div.className = "toclevel" + entry.toclevel;
-    toc.appendChild(div);
-  }
-  if (entries.length == 0)
-    toc.parentNode.removeChild(toc);
-},
-
-
-/////////////////////////////////////////////////////////////////////
-// Footnotes generator
-/////////////////////////////////////////////////////////////////////
-
-/* Based on footnote generation code from:
- * http://www.brandspankingnew.net/archive/2005/07/format_footnote.html
- */
-
-footnotes: function () {
-  // Delete existing footnote entries in case we're reloading the footnodes.
-  var i;
-  var noteholder = document.getElementById("footnotes");
-  if (!noteholder) {
-    return;
-  }
-  var entriesToRemove = [];
-  for (i = 0; i < noteholder.childNodes.length; i++) {
-    var entry = noteholder.childNodes[i];
-    if (entry.nodeName.toLowerCase() == 'div' && entry.getAttribute("class") == "footnote")
-      entriesToRemove.push(entry);
-  }
-  for (i = 0; i < entriesToRemove.length; i++) {
-    noteholder.removeChild(entriesToRemove[i]);
-  }
-
-  // Rebuild footnote entries.
-  var cont = document.getElementById("content");
-  var spans = cont.getElementsByTagName("span");
-  var refs = {};
-  var n = 0;
-  for (i=0; i<spans.length; i++) {
-    if (spans[i].className == "footnote") {
-      n++;
-      var note = spans[i].getAttribute("data-note");
-      if (!note) {
-        // Use [\s\S] in place of . so multi-line matches work.
-        // Because JavaScript has no s (dotall) regex flag.
-        note = spans[i].innerHTML.match(/\s*\[([\s\S]*)]\s*/)[1];
-        spans[i].innerHTML =
-          "[<a id='_footnoteref_" + n + "' href='#_footnote_" + n +
-          "' title='View footnote' class='footnote'>" + n + "</a>]";
-        spans[i].setAttribute("data-note", note);
-      }
-      noteholder.innerHTML +=
-        "<div class='footnote' id='_footnote_" + n + "'>" +
-        "<a href='#_footnoteref_" + n + "' title='Return to text'>" +
-        n + "</a>. " + note + "</div>";
-      var id =spans[i].getAttribute("id");
-      if (id != null) refs["#"+id] = n;
-    }
-  }
-  if (n == 0)
-    noteholder.parentNode.removeChild(noteholder);
-  else {
-    // Process footnoterefs.
-    for (i=0; i<spans.length; i++) {
-      if (spans[i].className == "footnoteref") {
-        var href = spans[i].getElementsByTagName("a")[0].getAttribute("href");
-        href = href.match(/#.*/)[0];  // Because IE return full URL.
-        n = refs[href];
-        spans[i].innerHTML =
-          "[<a href='#_footnote_" + n +
-          "' title='View footnote' class='footnote'>" + n + "</a>]";
-      }
-    }
-  }
-},
-
-install: function(toclevels) {
-  var timerId;
-
-  function reinstall() {
-    asciidoc.footnotes();
-    if (toclevels) {
-      asciidoc.toc(toclevels);
-    }
-  }
-
-  function reinstallAndRemoveTimer() {
-    clearInterval(timerId);
-    reinstall();
-  }
-
-  timerId = setInterval(reinstall, 500);
-  if (document.addEventListener)
-    document.addEventListener("DOMContentLoaded", reinstallAndRemoveTimer, false);
-  else
-    window.onload = reinstallAndRemoveTimer;
-}
-
-}
-asciidoc.install();
-/*]]>*/
-</script>
-</head>
-<body class="manpage">
-<div id="header">
-<h1>
-nvme-sanitize-log(1) Manual Page
-</h1>
-<h2>NAME</h2>
-<div class="sectionbody">
-<p>nvme-sanitize-log -
-   Send NVMe sanitize-log Command, return result
-</p>
-</div>
-</div>
-<div id="content">
-<div class="sect1">
-<h2 id="_synopsis">SYNOPSIS</h2>
-<div class="sectionbody">
-<div class="verseblock">
-<pre class="content"><em>nvme sanitize-log</em> &lt;device&gt;</pre>
-<div class="attribution">
-</div></div>
-</div>
-</div>
-<div class="sect1">
-<h2 id="_description">DESCRIPTION</h2>
-<div class="sectionbody">
-<div class="paragraph"><p>Retrieves the NVMe Sanitize log page from an NVMe device and provides the
-status of sanitize command.</p></div>
-<div class="paragraph"><p>The &lt;device&gt; parameter is mandatory NVMe character device (ex: /dev/nvme0).</p></div>
-<div class="paragraph"><p>Expected status and description :-</p></div>
-<div class="tableblock">
-<table rules="all"
-width="100%"
-frame="border"
-cellspacing="0" cellpadding="4">
-<col width="50%" />
-<col width="50%" />
-<thead>
-<tr>
-<th align="left" valign="top">Status Code </th>
-<th align="left" valign="top">Description</th>
-</tr>
-</thead>
-<tbody>
-<tr>
-<td align="left" valign="top"><p class="table">0x0000</p></td>
-<td align="left" valign="top"><p class="table">NVM subsystem has never been sanitized.</p></td>
-</tr>
-<tr>
-<td align="left" valign="top"><p class="table">0x0001</p></td>
-<td align="left" valign="top"><p class="table">The most recent sanitize operation completed successfully.</p></td>
-</tr>
-<tr>
-<td align="left" valign="top"><p class="table">0x0002</p></td>
-<td align="left" valign="top"><p class="table">A sanitize operation is currently in progress.</p></td>
-</tr>
-<tr>
-<td align="left" valign="top"><p class="table">0x0003</p></td>
-<td align="left" valign="top"><p class="table">The most recent sanitize operation failed.</p></td>
-</tr>
-<tr>
-<td align="left" valign="top"><p class="table">0x0100</p></td>
-<td align="left" valign="top"><p class="table">Global Data Erased bit
-If set to 1 then non-volatile storage in the NVM subsystem has
-not been written to:
-    a) since being manufactured and the NVM subsystem has never been sanitized; or
-    b) since the most recent successful sanitize operation.
-If cleared to 0, then non-volatile storage in the NVM subsystem has been written to:
-    a) since being manufactured and the NVM subsystem has never been sanitized; or
-    b) since the most recent successful sanitize operation of the NVM subsystem.</p></td>
-</tr>
-</tbody>
-</table>
-</div>
-<div class="paragraph"><p>Sanitize Progress - percentage complete</p></div>
-<div class="paragraph"><p>On success it returns 0, error code otherwise.</p></div>
-</div>
-</div>
-<div class="sect1">
-<h2 id="_options">OPTIONS</h2>
-<div class="sectionbody">
-<div class="paragraph"><p>No options yet.</p></div>
-</div>
-</div>
-<div class="sect1">
-<h2 id="_examples">EXAMPLES</h2>
-<div class="sectionbody">
-<div class="ulist"><ul>
-<li>
-<p>
-Has the program issue Sanitize-log Command :
-</p>
-<div class="listingblock">
-<div class="content">
-<pre><code># nvme sanitize-log /dev/nvme0</code></pre>
-</div></div>
-</li>
-</ul></div>
-</div>
-</div>
-<div class="sect1">
-<h2 id="_nvme">NVME</h2>
-<div class="sectionbody">
-<div class="paragraph"><p>Part of the nvme-user suite.</p></div>
-</div>
-</div>
-</div>
-<div id="footnotes"><hr /></div>
-<div id="footer">
-<div id="footer-text">
-Last updated
- 2017-06-28 11:25:21 PDT
-</div>
-</div>
-</body>
-</html>
+<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
+    "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
+<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
+<head>
+<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
+<meta name="generator" content="AsciiDoc 8.6.9" />
+<title>nvme-sanitize-log(1)</title>
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
+nvme-sanitize-log(1) Manual Page
+</h1>
+<h2>NAME</h2>
+<div class="sectionbody">
+<p>nvme-sanitize-log -
+   Send NVMe sanitize-log Command, return result
+</p>
+</div>
+</div>
+<div id="content">
+<div class="sect1">
+<h2 id="_synopsis">SYNOPSIS</h2>
+<div class="sectionbody">
+<div class="verseblock">
+<pre class="content"><em>nvme sanitize-log</em> &lt;device&gt; [--output-format=&lt;fmt&gt; | -o &lt;fmt&gt;]
+                             [--human-readable | -H]
+                             [--raw-binary | -b]</pre>
+<div class="attribution">
+</div></div>
+</div>
+</div>
+<div class="sect1">
+<h2 id="_description">DESCRIPTION</h2>
+<div class="sectionbody">
+<div class="paragraph"><p>Retrieves the NVMe Sanitize log page from an NVMe device and provides the
+status of sanitize command.</p></div>
+<div class="paragraph"><p>The &lt;device&gt; parameter is mandatory NVMe character device (ex: /dev/nvme0).</p></div>
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
+<td align="left" valign="top"><p class="table">0x0000</p></td>
+<td align="left" valign="top"><p class="table">NVM subsystem has never been sanitized.</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table">0x0001</p></td>
+<td align="left" valign="top"><p class="table">The most recent sanitize operation completed successfully.</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table">0x0002</p></td>
+<td align="left" valign="top"><p class="table">A sanitize operation is currently in progress.</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table">0x0003</p></td>
+<td align="left" valign="top"><p class="table">The most recent sanitize operation failed.</p></td>
+</tr>
+<tr>
+<td align="left" valign="top"><p class="table">0x0100</p></td>
+<td align="left" valign="top"><p class="table">Global Data Erased bit
+If set to 1 then non-volatile storage in the NVM subsystem has
+not been written to:
+    a) since being manufactured and the NVM subsystem has never been sanitized; or
+    b) since the most recent successful sanitize operation.
+If cleared to 0, then non-volatile storage in the NVM subsystem has been written to:
+    a) since being manufactured and the NVM subsystem has never been sanitized; or
+    b) since the most recent successful sanitize operation of the NVM subsystem.</p></td>
+</tr>
+</tbody>
+</table>
+</div>
+<div class="paragraph"><p>Sanitize Progress - percentage complete</p></div>
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
+              Set the reporting format to <em>normal</em>, <em>json</em>, or
+              <em>binary</em>. Only one output format can be used at a time.
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
+</dl></div>
+</div>
+</div>
+<div class="sect1">
+<h2 id="_examples">EXAMPLES</h2>
+<div class="sectionbody">
+<div class="ulist"><ul>
+<li>
+<p>
+Has the program issue Sanitize-log Command :
+</p>
+<div class="listingblock">
+<div class="content">
+<pre><code># nvme sanitize-log /dev/nvme0</code></pre>
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
+Last updated
+ 2018-01-27 02:09:06 KST
+</div>
+</div>
+</body>
+</html>
diff --git a/Documentation/nvme-sanitize-log.txt b/Documentation/nvme-sanitize-log.txt
index a4ff729..3c3b73e 100644
--- a/Documentation/nvme-sanitize-log.txt
+++ b/Documentation/nvme-sanitize-log.txt
@@ -8,7 +8,9 @@ nvme-sanitize-log - Send NVMe sanitize-log Command, return result
 SYNOPSIS
 --------
 [verse]
-'nvme sanitize-log' <device>
+'nvme sanitize-log' <device> [--output-format=<fmt> | -o <fmt>]
+			     [--human-readable | -H]
+			     [--raw-binary | -b]
 
 DESCRIPTION
 -----------
@@ -52,7 +54,20 @@ On success it returns 0, error code otherwise.
 
 OPTIONS
 -------
-No options yet.
+-o <format>::
+--output-format=<format>::
+              Set the reporting format to 'normal', 'json', or
+              'binary'. Only one output format can be used at a time.
+
+-H::
+--human-readable::
+	This option will parse and format many of the bit fields
+	into human-readable formats.
+
+-b::
+--raw-binary::
+	Print the raw buffer to stdout. Structure is not parsed by
+	program. This overrides the vendor specific and human readable options.
 
 EXAMPLES
 --------
diff --git a/Documentation/nvme-security-recv.1 b/Documentation/nvme-security-recv.1
index f866bba..2d0f925 100644
--- a/Documentation/nvme-security-recv.1
+++ b/Documentation/nvme-security-recv.1
@@ -2,12 +2,12 @@
 .\"     Title: nvme-security-recv
 .\"    Author: [FIXME: author] [see http://docbook.sf.net/el/author]
 .\" Generator: DocBook XSL Stylesheets v1.79.1 <http://docbook.sf.net/>
-.\"      Date: 12/10/2017
+.\"      Date: 01/27/2018
 .\"    Manual: NVMe Manual
 .\"    Source: NVMe
 .\"  Language: English
 .\"
-.TH "NVME\-SECURITY\-RECV" "1" "12/10/2017" "NVMe" "NVMe Manual"
+.TH "NVME\-SECURITY\-RECV" "1" "01/27/2018" "NVMe" "NVMe Manual"
 .\" -----------------------------------------------------------------
 .\" * Define some portability stuff
 .\" -----------------------------------------------------------------
@@ -32,13 +32,13 @@ nvme-security-recv \- Security Recv command
 .SH "SYNOPSIS"
 .sp
 .nf
-\fInvme security\-recv\fR [<device>] [\-\-size=<size> | \-x <size>]
+\fInvme security\-recv\fR <device> [\-\-size=<size> | \-x <size>]
                     [\-\-secp=<security\-protocol> | \-p <security\-protocol>]
                     [\-\-spsp=<protocol\-specific> | \-s <protocol\-specific>]
                     [\-\-nssf=<nvme\-specific> | \-N <nvme\-specific>]
-                    [\-\-tl=<transfer\-length> | \-t <transfer\-length>]
+                    [\-\-al=<allocation\-length> | \-t <allocation\-length>]
                     [\-\-namespace\-id=<nsid> | \-n <nsid>]
-                    [\-b | \-\-raw\-binary]
+                    [\-\-raw\-binary | \-b]
 .fi
 .SH "DESCRIPTION"
 .sp
@@ -74,7 +74,7 @@ Security Protocol: This field specifies the security protocol as defined in SPC\
 SP Specific: The value of this field is specific to the Security Protocol as defined in SPC\-4\&.
 .RE
 .PP
-\-a <allocation\-length>, \-\-al=<allocation\-length>
+\-t <allocation\-length>, \-\-al=<allocation\-length>
 .RS 4
 Allocation Length: The value of this field is specific to the Security Protocol as defined in SPC\-4\&.
 .RE
diff --git a/Documentation/nvme-security-recv.html b/Documentation/nvme-security-recv.html
index 7c668bc..5c548d4 100644
--- a/Documentation/nvme-security-recv.html
+++ b/Documentation/nvme-security-recv.html
@@ -3,7 +3,7 @@
 <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
 <head>
 <meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
-<meta name="generator" content="AsciiDoc 8.6.8" />
+<meta name="generator" content="AsciiDoc 8.6.9" />
 <title>nvme-security-recv(1)</title>
 <style type="text/css">
 /* Shared CSS for AsciiDoc xhtml11 and html5 backends */
@@ -94,7 +94,9 @@ ul > li > * { color: black; }
   padding: 0;
   margin: 0;
 }
-
+pre {
+  white-space: pre-wrap;
+}
 
 #author {
   color: #527bbd;
@@ -223,7 +225,7 @@ div.exampleblock > div.content {
 }
 
 div.imageblock div.content { padding-left: 0; }
-span.image img { border-style: none; }
+span.image img { border-style: none; vertical-align: text-bottom; }
 a.image:visited { color: white; }
 
 dl {
@@ -746,13 +748,13 @@ nvme-security-recv(1) Manual Page
 <h2 id="_synopsis">SYNOPSIS</h2>
 <div class="sectionbody">
 <div class="verseblock">
-<pre class="content"><em>nvme security-recv</em> [&lt;device&gt;] [--size=&lt;size&gt; | -x &lt;size&gt;]
+<pre class="content"><em>nvme security-recv</em> &lt;device&gt; [--size=&lt;size&gt; | -x &lt;size&gt;]
                     [--secp=&lt;security-protocol&gt; | -p &lt;security-protocol&gt;]
                     [--spsp=&lt;protocol-specific&gt; | -s &lt;protocol-specific&gt;]
                     [--nssf=&lt;nvme-specific&gt; | -N &lt;nvme-specific&gt;]
-                    [--tl=&lt;transfer-length&gt; | -t &lt;transfer-length&gt;]
+                    [--al=&lt;allocation-length&gt; | -t &lt;allocation-length&gt;]
                     [--namespace-id=&lt;nsid&gt; | -n &lt;nsid&gt;]
-                    [-b | --raw-binary]</pre>
+                    [--raw-binary | -b]</pre>
 <div class="attribution">
 </div></div>
 </div>
@@ -841,7 +843,7 @@ controller reset occurs.</p></div>
 </p>
 </dd>
 <dt class="hdlist1">
--a &lt;allocation-length&gt;
+-t &lt;allocation-length&gt;
 </dt>
 <dt class="hdlist1">
 --al=&lt;allocation-length&gt;
@@ -882,7 +884,8 @@ controller reset occurs.</p></div>
 <div id="footnotes"><hr /></div>
 <div id="footer">
 <div id="footer-text">
-Last updated 2016-05-16 12:47:42 EDT
+Last updated
+ 2018-01-27 01:41:46 KST
 </div>
 </div>
 </body>
diff --git a/Documentation/nvme-security-recv.txt b/Documentation/nvme-security-recv.txt
index 56f876a..0b9fe99 100644
--- a/Documentation/nvme-security-recv.txt
+++ b/Documentation/nvme-security-recv.txt
@@ -8,13 +8,13 @@ nvme-security-recv - Security Recv command
 SYNOPSIS
 --------
 [verse]
-'nvme security-recv' [<device>] [--size=<size> | -x <size>]
+'nvme security-recv' <device> [--size=<size> | -x <size>]
 		    [--secp=<security-protocol> | -p <security-protocol>]
 		    [--spsp=<protocol-specific> | -s <protocol-specific>]
 		    [--nssf=<nvme-specific> | -N <nvme-specific>]
-		    [--tl=<transfer-length> | -t <transfer-length>]
+		    [--al=<allocation-length> | -t <allocation-length>]
 		    [--namespace-id=<nsid> | -n <nsid>]
-		    [-b | --raw-binary]
+		    [--raw-binary | -b]
 
 DESCRIPTION
 -----------
@@ -62,7 +62,7 @@ OPTIONS
 	SP Specific: The value of this field is specific to the Security
 	Protocol as defined in SPC-4.
 
--a <allocation-length>::
+-t <allocation-length>::
 --al=<allocation-length>::
 	Allocation Length: The value of this field is specific to the
 	Security Protocol as defined in SPC-4.
diff --git a/Documentation/nvme-security-send.1 b/Documentation/nvme-security-send.1
index d3c3bcd..c41f3a7 100644
--- a/Documentation/nvme-security-send.1
+++ b/Documentation/nvme-security-send.1
@@ -2,12 +2,12 @@
 .\"     Title: nvme-security-send
 .\"    Author: [FIXME: author] [see http://docbook.sf.net/el/author]
 .\" Generator: DocBook XSL Stylesheets v1.79.1 <http://docbook.sf.net/>
-.\"      Date: 12/10/2017
+.\"      Date: 01/27/2018
 .\"    Manual: NVMe Manual
 .\"    Source: NVMe
 .\"  Language: English
 .\"
-.TH "NVME\-SECURITY\-SEND" "1" "12/10/2017" "NVMe" "NVMe Manual"
+.TH "NVME\-SECURITY\-SEND" "1" "01/27/2018" "NVMe" "NVMe Manual"
 .\" -----------------------------------------------------------------
 .\" * Define some portability stuff
 .\" -----------------------------------------------------------------
@@ -32,7 +32,7 @@ nvme-security-send \- Security Send command
 .SH "SYNOPSIS"
 .sp
 .nf
-\fInvme security\-send\fR [<device>] [\-\-file=<file> | \-f <file>]
+\fInvme security\-send\fR <device> [\-\-file=<file> | \-f <file>]
                     [\-\-secp=<security\-protocol> | \-p <security\-protocol>]
                     [\-\-spsp=<protocol\-specific> | \-s <protocol\-specific>]
                     [\-\-tl=<transfer\-length> | \-t <transfer\-length>]
diff --git a/Documentation/nvme-security-send.html b/Documentation/nvme-security-send.html
index d3bd117..6e16e74 100644
--- a/Documentation/nvme-security-send.html
+++ b/Documentation/nvme-security-send.html
@@ -3,7 +3,7 @@
 <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
 <head>
 <meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
-<meta name="generator" content="AsciiDoc 8.6.8" />
+<meta name="generator" content="AsciiDoc 8.6.9" />
 <title>nvme-security-send(1)</title>
 <style type="text/css">
 /* Shared CSS for AsciiDoc xhtml11 and html5 backends */
@@ -94,7 +94,9 @@ ul > li > * { color: black; }
   padding: 0;
   margin: 0;
 }
-
+pre {
+  white-space: pre-wrap;
+}
 
 #author {
   color: #527bbd;
@@ -223,7 +225,7 @@ div.exampleblock > div.content {
 }
 
 div.imageblock div.content { padding-left: 0; }
-span.image img { border-style: none; }
+span.image img { border-style: none; vertical-align: text-bottom; }
 a.image:visited { color: white; }
 
 dl {
@@ -746,7 +748,7 @@ nvme-security-send(1) Manual Page
 <h2 id="_synopsis">SYNOPSIS</h2>
 <div class="sectionbody">
 <div class="verseblock">
-<pre class="content"><em>nvme security-send</em> [&lt;device&gt;] [--file=&lt;file&gt; | -f &lt;file&gt;]
+<pre class="content"><em>nvme security-send</em> &lt;device&gt; [--file=&lt;file&gt; | -f &lt;file&gt;]
                     [--secp=&lt;security-protocol&gt; | -p &lt;security-protocol&gt;]
                     [--spsp=&lt;protocol-specific&gt; | -s &lt;protocol-specific&gt;]
                     [--tl=&lt;transfer-length&gt; | -t &lt;transfer-length&gt;]
@@ -868,7 +870,8 @@ Receive command is Security Protocol field dependent as defined in SPC-4.</p></d
 <div id="footnotes"><hr /></div>
 <div id="footer">
 <div id="footer-text">
-Last updated 2016-05-16 12:47:42 EDT
+Last updated
+ 2018-01-27 01:39:50 KST
 </div>
 </div>
 </body>
diff --git a/Documentation/nvme-security-send.txt b/Documentation/nvme-security-send.txt
index 183bc8e..ae22628 100644
--- a/Documentation/nvme-security-send.txt
+++ b/Documentation/nvme-security-send.txt
@@ -8,7 +8,7 @@ nvme-security-send - Security Send command
 SYNOPSIS
 --------
 [verse]
-'nvme security-send' [<device>] [--file=<file> | -f <file>]
+'nvme security-send' <device> [--file=<file> | -f <file>]
 		    [--secp=<security-protocol> | -p <security-protocol>]
 		    [--spsp=<protocol-specific> | -s <protocol-specific>]
 		    [--tl=<transfer-length> | -t <transfer-length>]
diff --git a/Documentation/nvme-telemetry-log.1 b/Documentation/nvme-telemetry-log.1
new file mode 100644
index 0000000..6fafb9a
--- /dev/null
+++ b/Documentation/nvme-telemetry-log.1
@@ -0,0 +1,82 @@
+'\" t
+.\"     Title: nvme-telemetry-log
+.\"    Author: [FIXME: author] [see http://docbook.sf.net/el/author]
+.\" Generator: DocBook XSL Stylesheets v1.79.1 <http://docbook.sf.net/>
+.\"      Date: 01/27/2018
+.\"    Manual: NVMe Manual
+.\"    Source: NVMe
+.\"  Language: English
+.\"
+.TH "NVME\-TELEMETRY\-LOG" "1" "01/27/2018" "NVMe" "NVMe Manual"
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
+nvme-telemetry-log \- Retrieves a Telemetry Host\-Initiated log page from an NVMe device
+.SH "SYNOPSIS"
+.sp
+.nf
+\fInvme telemetry\-log\fR <device> [\-\-output\-file=<file> | \-o <file>]
+                      [\-\-host\-generate=<gen> | \-h <gen>]
+.fi
+.SH "DESCRIPTION"
+.sp
+Retrieves an Telemetry Host\-Initiated log page from an NVMe device and provides the retuned structure\&.
+.sp
+The <device> parameter is mandatory and may be either the NVMe character device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1)\&.
+.sp
+On success, the returned log structure will be in raw binary format \fIonly\fR with \-\-output\-file option which is mandatory\&.
+.SH "OPTIONS"
+.PP
+\-o <file>, \-\-output\-file=<file>
+.RS 4
+File name to which raw binary data will be saved to\&.
+.RE
+.PP
+\-h <gen>, \-\-host\-generate=<gen>
+.RS 4
+If set to 1, controller shall capture the Telemetry Host\-Initiated data representing the internal state of the controller at the time the associated Get Log Page command is processed\&. If cleated to 0, controller shall
+\fInot\fR
+update this data\&.
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
+Retrieve Telemetry Host\-Initiated data to telemetry_log\&.bin
+.sp
+.if n \{\
+.RS 4
+.\}
+.nf
+# nvme telemetry\-log /dev/nvme0 \-\-output\-file=telemetry_log\&.bin
+.fi
+.if n \{\
+.RE
+.\}
+.RE
+.SH "NVME"
+.sp
+Part of the nvme\-user suite
diff --git a/Documentation/nvme-telemetry-log.html b/Documentation/nvme-telemetry-log.html
new file mode 100644
index 0000000..8ea6e2e
--- /dev/null
+++ b/Documentation/nvme-telemetry-log.html
@@ -0,0 +1,831 @@
+<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
+    "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
+<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
+<head>
+<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
+<meta name="generator" content="AsciiDoc 8.6.9" />
+<title>nvme-telemetry-log(1)</title>
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
+nvme-telemetry-log(1) Manual Page
+</h1>
+<h2>NAME</h2>
+<div class="sectionbody">
+<p>nvme-telemetry-log -
+   Retrieves a Telemetry Host-Initiated log page from an NVMe device
+</p>
+</div>
+</div>
+<div id="content">
+<div class="sect1">
+<h2 id="_synopsis">SYNOPSIS</h2>
+<div class="sectionbody">
+<div class="verseblock">
+<pre class="content"><em>nvme telemetry-log</em> &lt;device&gt; [--output-file=&lt;file&gt; | -o &lt;file&gt;]
+                      [--host-generate=&lt;gen&gt; | -h &lt;gen&gt;]</pre>
+<div class="attribution">
+</div></div>
+</div>
+</div>
+<div class="sect1">
+<h2 id="_description">DESCRIPTION</h2>
+<div class="sectionbody">
+<div class="paragraph"><p>Retrieves an Telemetry Host-Initiated log page from an NVMe device and provides
+the retuned structure.</p></div>
+<div class="paragraph"><p>The &lt;device&gt; parameter is mandatory and may be either the NVMe character
+device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1).</p></div>
+<div class="paragraph"><p>On success, the returned log structure will be in raw binary format <em>only</em> with
+--output-file option which is mandatory.</p></div>
+</div>
+</div>
+<div class="sect1">
+<h2 id="_options">OPTIONS</h2>
+<div class="sectionbody">
+<div class="dlist"><dl>
+<dt class="hdlist1">
+-o &lt;file&gt;
+</dt>
+<dt class="hdlist1">
+--output-file=&lt;file&gt;
+</dt>
+<dd>
+<p>
+        File name to which raw binary data will be saved to.
+</p>
+</dd>
+<dt class="hdlist1">
+-h &lt;gen&gt;
+</dt>
+<dt class="hdlist1">
+--host-generate=&lt;gen&gt;
+</dt>
+<dd>
+<p>
+        If set to 1, controller shall capture the Telemetry Host-Initiated data
+        representing the internal state of the controller at the time the
+        associated Get Log Page command is processed.
+        If cleated to 0, controller shall <em>not</em> update this data.
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
+Retrieve Telemetry Host-Initiated data to telemetry_log.bin
+</p>
+<div class="listingblock">
+<div class="content">
+<pre><code># nvme telemetry-log /dev/nvme0 --output-file=telemetry_log.bin</code></pre>
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
+Last updated
+ 2018-01-27 01:29:13 KST
+</div>
+</div>
+</body>
+</html>
diff --git a/Documentation/nvme-telemetry-log.txt b/Documentation/nvme-telemetry-log.txt
new file mode 100644
index 0000000..804c241
--- /dev/null
+++ b/Documentation/nvme-telemetry-log.txt
@@ -0,0 +1,48 @@
+nvme-telemetry-log(1)
+=====================
+
+NAME
+----
+nvme-telemetry-log - Retrieves a Telemetry Host-Initiated log page from an NVMe device
+
+SYNOPSIS
+--------
+[verse]
+'nvme telemetry-log' <device> [--output-file=<file> | -o <file>]
+		      [--host-generate=<gen> | -h <gen>]
+
+DESCRIPTION
+-----------
+Retrieves an Telemetry Host-Initiated log page from an NVMe device and provides
+the retuned structure.
+
+The <device> parameter is mandatory and may be either the NVMe character
+device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1).
+
+On success, the returned log structure will be in raw binary format _only_ with
+--output-file option which is mandatory.
+
+OPTIONS
+-------
+-o <file>::
+--output-file=<file>::
+	File name to which raw binary data will be saved to.
+
+-h <gen>::
+--host-generate=<gen>::
+	If set to 1, controller shall capture the Telemetry Host-Initiated data
+	representing the internal state of the controller at the time the
+	associated Get Log Page command is processed.
+	If cleated to 0, controller shall _not_ update this data.
+
+EXAMPLES
+--------
+* Retrieve Telemetry Host-Initiated data to telemetry_log.bin
++
+------------
+# nvme telemetry-log /dev/nvme0 --output-file=telemetry_log.bin
+------------
+
+NVME
+----
+Part of the nvme-user suite
diff --git a/Documentation/nvme-wdc-id-ctrl.1 b/Documentation/nvme-wdc-id-ctrl.1
index 6be1f74..8d00613 100644
--- a/Documentation/nvme-wdc-id-ctrl.1
+++ b/Documentation/nvme-wdc-id-ctrl.1
@@ -2,12 +2,12 @@
 .\"     Title: nvme-wdc-id-ctrl
 .\"    Author: [FIXME: author] [see http://docbook.sf.net/el/author]
 .\" Generator: DocBook XSL Stylesheets v1.79.1 <http://docbook.sf.net/>
-.\"      Date: 12/10/2017
+.\"      Date: 01/27/2018
 .\"    Manual: NVMe Manual
 .\"    Source: NVMe
 .\"  Language: English
 .\"
-.TH "NVME\-WDC\-ID\-CTRL" "1" "12/10/2017" "NVMe" "NVMe Manual"
+.TH "NVME\-WDC\-ID\-CTRL" "1" "01/27/2018" "NVMe" "NVMe Manual"
 .\" -----------------------------------------------------------------
 .\" * Define some portability stuff
 .\" -----------------------------------------------------------------
@@ -33,6 +33,7 @@ nvme-wdc-id-ctrl \- Send NVMe Identify Controller, return result and structure
 .sp
 .nf
 \fInvme wdc id\-ctrl\fR <device> [\-v | \-\-vendor\-specific] [\-b | \-\-raw\-binary]
+                        [\-H | \-\-human\-readable]
                         [\-o <fmt> | \-\-output\-format=<fmt>]
 .fi
 .SH "DESCRIPTION"
diff --git a/Documentation/nvme-wdc-id-ctrl.html b/Documentation/nvme-wdc-id-ctrl.html
index dbbe29e..e7ee6ec 100644
--- a/Documentation/nvme-wdc-id-ctrl.html
+++ b/Documentation/nvme-wdc-id-ctrl.html
@@ -3,7 +3,7 @@
 <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
 <head>
 <meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
-<meta name="generator" content="AsciiDoc 8.6.8" />
+<meta name="generator" content="AsciiDoc 8.6.9" />
 <title>nvme-wdc-id-ctrl(1)</title>
 <style type="text/css">
 /* Shared CSS for AsciiDoc xhtml11 and html5 backends */
@@ -94,7 +94,9 @@ ul > li > * { color: black; }
   padding: 0;
   margin: 0;
 }
-
+pre {
+  white-space: pre-wrap;
+}
 
 #author {
   color: #527bbd;
@@ -223,7 +225,7 @@ div.exampleblock > div.content {
 }
 
 div.imageblock div.content { padding-left: 0; }
-span.image img { border-style: none; }
+span.image img { border-style: none; vertical-align: text-bottom; }
 a.image:visited { color: white; }
 
 dl {
@@ -747,6 +749,7 @@ nvme-wdc-id-ctrl(1) Manual Page
 <div class="sectionbody">
 <div class="verseblock">
 <pre class="content"><em>nvme wdc id-ctrl</em> &lt;device&gt; [-v | --vendor-specific] [-b | --raw-binary]
+                        [-H | --human-readable]
                         [-o &lt;fmt&gt; | --output-format=&lt;fmt&gt;]</pre>
 <div class="attribution">
 </div></div>
@@ -851,7 +854,8 @@ fields in a human readable format:
 <div id="footnotes"><hr /></div>
 <div id="footer">
 <div id="footer-text">
-Last updated 2017-03-01 10:14:21 EST
+Last updated
+ 2018-01-27 00:43:26 KST
 </div>
 </div>
 </body>
diff --git a/Documentation/nvme-wdc-id-ctrl.txt b/Documentation/nvme-wdc-id-ctrl.txt
index d0bbc13..a44c7e5 100644
--- a/Documentation/nvme-wdc-id-ctrl.txt
+++ b/Documentation/nvme-wdc-id-ctrl.txt
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'nvme wdc id-ctrl' <device> [-v | --vendor-specific] [-b | --raw-binary]
+			[-H | --human-readable]
 			[-o <fmt> | --output-format=<fmt>]
 
 DESCRIPTION
diff --git a/Documentation/nvme-write.1 b/Documentation/nvme-write.1
index fac4802..4b65cad 100644
--- a/Documentation/nvme-write.1
+++ b/Documentation/nvme-write.1
@@ -1,13 +1,13 @@
 '\" t
 .\"     Title: nvme-write
-.\"    Author: [FIXME: author] [see http://www.docbook.org/tdg5/en/html/author]
-.\" Generator: DocBook XSL Stylesheets vsnapshot <http://docbook.sf.net/>
-.\"      Date: 12/13/2017
+.\"    Author: [FIXME: author] [see http://docbook.sf.net/el/author]
+.\" Generator: DocBook XSL Stylesheets v1.79.1 <http://docbook.sf.net/>
+.\"      Date: 01/27/2018
 .\"    Manual: NVMe Manual
 .\"    Source: NVMe
 .\"  Language: English
 .\"
-.TH "NVME\-WRITE" "1" "12/13/2017" "NVMe" "NVMe Manual"
+.TH "NVME\-WRITE" "1" "01/27/2018" "NVMe" "NVMe Manual"
 .\" -----------------------------------------------------------------
 .\" * Define some portability stuff
 .\" -----------------------------------------------------------------
@@ -36,18 +36,20 @@ nvme-write \- Send an NVMe write command, provide results
                         [\-\-block\-count=<nlb> | \-c <nlb>]
                         [\-\-data\-size=<size> | \-z <size>]
                         [\-\-metadata\-size=<size> | \-y <size>]
+                        [\-\-ref\-tag=<reftag> | \-r <reftag>]
                         [\-\-data=<data\-file> | \-d <data\-file>]
                         [\-\-metadata=<metadata\-file> | \-M <metadata\-file>]
                         [\-\-prinfo=<prinfo> | \-p <prinfo>]
-                        [\-\-ref\-tag=<reftag> | \-r <reftag>]
                         [\-\-app\-tag\-mask=<appmask> | \-m <appmask>]
                         [\-\-app\-tag=<apptag> | \-a <apptag>]
-                        [\-\-dtype=<dtype> | \-T <dtype>]
-                        [\-\-dspec=<dspec> | \-S <dspec>]
-                        [\-\-dsm=<dsm> | \-D <dsm>]
                         [\-\-limited\-retry | \-l]
-                        [\-\-latency | \-t]
                         [\-\-force\-unit\-access | \-f]
+                        [\-\-dir\-type=<type> | \-T <type>]
+                        [\-\-dir\-spec=<spec> | \-S <spec>]
+                        [\-\-dsm=<dsm> | \-D <dsm>]
+                        [\-\-show\-command | \-v]
+                        [\-\-dry\-run | \-w]
+                        [\-\-latency | \-t]
 .fi
 .SH "DESCRIPTION"
 .sp
@@ -129,21 +131,6 @@ T}
 .sp 1
 .RE
 .PP
-\-\-dtype=<dtype>, \-T <dtype>
-.RS 4
-Optional directive type\&. The nvme\-cli only enforces the value be in the defined range for the directive type, though the NVMe specifcation (1\&.3a) defines only one directive, 01h, for write stream idenfiers\&.
-.RE
-.PP
-\-\-dspec=<dspec>, \-S <dspec>
-.RS 4
-Optional field for directive specifics\&. When used with write streams, this value is defined to be the write stream identifier\&. The nvme\-cli will not validate the stream requested is within the controller\(cqs capabilities\&.
-.RE
-.PP
-\-\-dsm=<dsm>, \-D <dsm>
-.RS 4
-The optional data set management attributes for this command\&. The argument for this is the lower 16 bits of the DSM field in a write command; the upper 16 bits of the field come from the directive specific field, if used\&. This may be used to set attributes for the LBAs being written, like access frequency, type, latency, among other things, as well as yet to be defined types\&. Please consult the NVMe specification for detailed breakdown of how to use this field\&.
-.RE
-.PP
 \-\-ref\-tag=<reftag>, \-r <reftag>
 .RS 4
 Optional reftag when used with protection information\&.
@@ -169,7 +156,35 @@ Sets the limited retry flag\&.
 Set the force\-unit access flag\&.
 .RE
 .PP
-\-\-latency, \-t
+\-T <type>, \-\-dir\-type=<type>
+.RS 4
+Optional directive type\&. The nvme\-cli only enforces the value be in the defined range for the directive type, though the NVMe specifcation (1\&.3a) defines only one directive, 01h, for write stream idenfiers\&.
+.RE
+.PP
+\-S <spec>, \-\-dir\-spec=<spec>
+.RS 4
+Optional field for directive specifics\&. When used with write streams, this value is defined to be the write stream identifier\&. The nvme\-cli will not validate the stream requested is within the controller\(cqs capabilities\&.
+.RE
+.PP
+\-D <dsm>, \-\-dsm=<dsm>
+.RS 4
+The optional data set management attributes for this command\&. The argument for this is the lower 16 bits of the DSM field in a write command; the upper 16 bits of the field come from the directive specific field, if used\&. This may be used to set attributes for the LBAs being written, like access frequency, type, latency, among other things, as well as yet to be defined types\&. Please consult the NVMe specification for detailed breakdown of how to use this field\&.
+.RE
+.PP
+\-v, \-\-show\-cmd
+.RS 4
+Print out the command to be sent\&.
+.RE
+.PP
+\-w, \-\-dry\-run
+.RS 4
+Do not actually send the command\&. If want to use \-\-dry\-run option, \-\-show\-cmd option
+\fImust\fR
+be set\&. Otherwise \-\-dry\-run optionn will be
+\fIignored\fR\&.
+.RE
+.PP
+\-t, \-\-latency
 .RS 4
 Print out the latency the IOCTL took (in us)\&.
 .RE
diff --git a/Documentation/nvme-write.html b/Documentation/nvme-write.html
index 9a4a179..020b04c 100644
--- a/Documentation/nvme-write.html
+++ b/Documentation/nvme-write.html
@@ -3,7 +3,7 @@
 <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
 <head>
 <meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
-<meta name="generator" content="AsciiDoc 8.6.8" />
+<meta name="generator" content="AsciiDoc 8.6.9" />
 <title>nvme-write(1)</title>
 <style type="text/css">
 /* Shared CSS for AsciiDoc xhtml11 and html5 backends */
@@ -94,7 +94,9 @@ ul > li > * { color: black; }
   padding: 0;
   margin: 0;
 }
-
+pre {
+  white-space: pre-wrap;
+}
 
 #author {
   color: #527bbd;
@@ -223,7 +225,7 @@ div.exampleblock > div.content {
 }
 
 div.imageblock div.content { padding-left: 0; }
-span.image img { border-style: none; }
+span.image img { border-style: none; vertical-align: text-bottom; }
 a.image:visited { color: white; }
 
 dl {
@@ -750,18 +752,20 @@ nvme-write(1) Manual Page
                         [--block-count=&lt;nlb&gt; | -c &lt;nlb&gt;]
                         [--data-size=&lt;size&gt; | -z &lt;size&gt;]
                         [--metadata-size=&lt;size&gt; | -y &lt;size&gt;]
+                        [--ref-tag=&lt;reftag&gt; | -r &lt;reftag&gt;]
                         [--data=&lt;data-file&gt; | -d &lt;data-file&gt;]
                         [--metadata=&lt;metadata-file&gt; | -M &lt;metadata-file&gt;]
                         [--prinfo=&lt;prinfo&gt; | -p &lt;prinfo&gt;]
-                        [--ref-tag=&lt;reftag&gt; | -r &lt;reftag&gt;]
                         [--app-tag-mask=&lt;appmask&gt; | -m &lt;appmask&gt;]
                         [--app-tag=&lt;apptag&gt; | -a &lt;apptag&gt;]
-                        [--dtype=&lt;dtype&gt; | -T &lt;dtype&gt;]
-                        [--dspec=&lt;dspec&gt; | -S &lt;dspec&gt;]
-                        [--dsm=&lt;dsm&gt; | -D &lt;dsm&gt;]
                         [--limited-retry | -l]
-                        [--latency | -t]
-                        [--force-unit-access | -f]</pre>
+                        [--force-unit-access | -f]
+                        [--dir-type=&lt;type&gt; | -T &lt;type&gt;]
+                        [--dir-spec=&lt;spec&gt; | -S &lt;spec&gt;]
+                        [--dsm=&lt;dsm&gt; | -D &lt;dsm&gt;]
+                        [--show-command | -v]
+                        [--dry-run | -w]
+                        [--latency | -t]</pre>
 <div class="attribution">
 </div></div>
 </div>
@@ -895,112 +899,136 @@ metadata is passes.</p></td>
 </div>
 </dd>
 <dt class="hdlist1">
---dtype=&lt;dtype&gt;
+--ref-tag=&lt;reftag&gt;
 </dt>
 <dt class="hdlist1">
--T &lt;dtype&gt;
+-r &lt;reftag&gt;
 </dt>
 <dd>
 <p>
-        Optional directive type. The nvme-cli only enforces the value
-        be in the defined range for the directive type, though the NVMe
-        specifcation (1.3a) defines only one directive, 01h, for write
-        stream idenfiers.
+        Optional reftag when used with protection information.
 </p>
 </dd>
 <dt class="hdlist1">
---dspec=&lt;dspec&gt;
+--app-tag-mask=&lt;appmask&gt;
 </dt>
 <dt class="hdlist1">
--S &lt;dspec&gt;
+-m &lt;appmask&gt;
 </dt>
 <dd>
 <p>
-        Optional field for directive specifics. When used with
-        write streams, this value is defined to be the write stream
-        identifier. The nvme-cli will not validate the stream requested
-        is within the controller&#8217;s capabilities.
+        Optional application tag mask when used with protection information.
 </p>
 </dd>
 <dt class="hdlist1">
---dsm=&lt;dsm&gt;
+--app-tag=&lt;apptag&gt;
 </dt>
 <dt class="hdlist1">
--D &lt;dsm&gt;
+-a &lt;apptag&gt;
 </dt>
 <dd>
 <p>
-        The optional data set management attributes for this command. The
-        argument for this is the lower 16 bits of the DSM field in a write
-        command; the upper 16 bits of the field come from the directive
-        specific field, if used. This may be used to set attributes for
-        the LBAs being written, like access frequency, type, latency,
-        among other things, as well as yet to be defined types. Please
-        consult the NVMe specification for detailed breakdown of how to
-        use this field.
+        Optional application tag when used with protection information.
 </p>
 </dd>
 <dt class="hdlist1">
---ref-tag=&lt;reftag&gt;
+--limited-retry
 </dt>
 <dt class="hdlist1">
--r &lt;reftag&gt;
+-l
 </dt>
 <dd>
 <p>
-        Optional reftag when used with protection information.
+        Sets the limited retry flag.
 </p>
 </dd>
 <dt class="hdlist1">
---app-tag-mask=&lt;appmask&gt;
+--force-unit-access
 </dt>
 <dt class="hdlist1">
--m &lt;appmask&gt;
+-f
 </dt>
 <dd>
 <p>
-        Optional application tag mask when used with protection information.
+        Set the force-unit access flag.
 </p>
 </dd>
 <dt class="hdlist1">
---app-tag=&lt;apptag&gt;
+-T &lt;type&gt;
 </dt>
 <dt class="hdlist1">
--a &lt;apptag&gt;
+--dir-type=&lt;type&gt;
 </dt>
 <dd>
 <p>
-        Optional application tag when used with protection information.
+        Optional directive type. The nvme-cli only enforces the value
+        be in the defined range for the directive type, though the NVMe
+        specifcation (1.3a) defines only one directive, 01h, for write
+        stream idenfiers.
 </p>
 </dd>
 <dt class="hdlist1">
---limited-retry
+-S &lt;spec&gt;
 </dt>
 <dt class="hdlist1">
--l
+--dir-spec=&lt;spec&gt;
 </dt>
 <dd>
 <p>
-        Sets the limited retry flag.
+        Optional field for directive specifics. When used with
+        write streams, this value is defined to be the write stream
+        identifier. The nvme-cli will not validate the stream requested
+        is within the controller&#8217;s capabilities.
 </p>
 </dd>
 <dt class="hdlist1">
---force-unit-access
+-D &lt;dsm&gt;
 </dt>
 <dt class="hdlist1">
--f
+--dsm=&lt;dsm&gt;
 </dt>
 <dd>
 <p>
-        Set the force-unit access flag.
+        The optional data set management attributes for this command. The
+        argument for this is the lower 16 bits of the DSM field in a write
+        command; the upper 16 bits of the field come from the directive
+        specific field, if used. This may be used to set attributes for
+        the LBAs being written, like access frequency, type, latency,
+        among other things, as well as yet to be defined types. Please
+        consult the NVMe specification for detailed breakdown of how to
+        use this field.
 </p>
 </dd>
 <dt class="hdlist1">
---latency
+-v
+</dt>
+<dt class="hdlist1">
+--show-cmd
+</dt>
+<dd>
+<p>
+        Print out the command to be sent.
+</p>
+</dd>
+<dt class="hdlist1">
+-w
 </dt>
 <dt class="hdlist1">
+--dry-run
+</dt>
+<dd>
+<p>
+        Do not actually send the command. If want to use --dry-run option,
+        --show-cmd option <em>must</em> be set. Otherwise --dry-run optionn will be
+        <em>ignored</em>.
+</p>
+</dd>
+<dt class="hdlist1">
 -t
 </dt>
+<dt class="hdlist1">
+--latency
+</dt>
 <dd>
 <p>
         Print out the latency the IOCTL took (in us).
@@ -1025,7 +1053,8 @@ metadata is passes.</p></td>
 <div id="footnotes"><hr /></div>
 <div id="footer">
 <div id="footer-text">
-Last updated 2017-12-10 09:41:18 MST
+Last updated
+ 2018-01-27 02:06:28 KST
 </div>
 </div>
 </body>
diff --git a/Documentation/nvme-write.txt b/Documentation/nvme-write.txt
index 2fe9b28..fc7636d 100644
--- a/Documentation/nvme-write.txt
+++ b/Documentation/nvme-write.txt
@@ -12,18 +12,20 @@ SYNOPSIS
 			[--block-count=<nlb> | -c <nlb>]
 			[--data-size=<size> | -z <size>]
 			[--metadata-size=<size> | -y <size>]
+			[--ref-tag=<reftag> | -r <reftag>]
 			[--data=<data-file> | -d <data-file>]
 			[--metadata=<metadata-file> | -M <metadata-file>]
 			[--prinfo=<prinfo> | -p <prinfo>]
-			[--ref-tag=<reftag> | -r <reftag>]
 			[--app-tag-mask=<appmask> | -m <appmask>]
 			[--app-tag=<apptag> | -a <apptag>]
-			[--dtype=<dtype> | -T <dtype>]
-			[--dspec=<dspec> | -S <dspec>]
-			[--dsm=<dsm> | -D <dsm>]
 			[--limited-retry | -l]
-			[--latency | -t]
 			[--force-unit-access | -f]
+			[--dir-type=<type> | -T <type>]
+			[--dir-spec=<spec> | -S <spec>]
+			[--dsm=<dsm> | -D <dsm>]
+			[--show-command | -v]
+			[--dry-run | -w]
+			[--latency | -t]
 
 DESCRIPTION
 -----------
@@ -75,22 +77,42 @@ metadata is passes.
 |0|Set to 1 enables checking the reference tag
 |=================
 
---dtype=<dtype>::
--T <dtype>::
+--ref-tag=<reftag>::
+-r <reftag>::
+	Optional reftag when used with protection information.
+
+--app-tag-mask=<appmask>::
+-m <appmask>::
+	Optional application tag mask when used with protection information.
+
+--app-tag=<apptag>::
+-a <apptag>::
+	Optional application tag when used with protection information.
+
+--limited-retry::
+-l::
+	Sets the limited retry flag.
+
+--force-unit-access::
+-f::
+	Set the force-unit access flag.
+
+-T <type>::
+--dir-type=<type>::
 	Optional directive type. The nvme-cli only enforces the value
 	be in the defined range for the directive type, though the NVMe
 	specifcation (1.3a) defines only one directive, 01h, for write
 	stream idenfiers.
 
---dspec=<dspec>::
--S <dspec>::
+-S <spec>::
+--dir-spec=<spec>::
 	Optional field for directive specifics. When used with
 	write streams, this value is defined to be the write stream
 	identifier. The nvme-cli will not validate the stream requested
 	is within the controller's capabilities.
 
---dsm=<dsm>::
 -D <dsm>::
+--dsm=<dsm>::
 	The optional data set management attributes for this command. The
 	argument for this is the lower 16 bits of the DSM field in a write
 	command; the upper 16 bits of the field come from the directive
@@ -100,28 +122,18 @@ metadata is passes.
 	consult the NVMe specification for detailed breakdown of how to
 	use this field.
 
---ref-tag=<reftag>::
--r <reftag>::
-	Optional reftag when used with protection information.
-
---app-tag-mask=<appmask>::
--m <appmask>::
-	Optional application tag mask when used with protection information.
-
---app-tag=<apptag>::
--a <apptag>::
-	Optional application tag when used with protection information.
-
---limited-retry::
--l::
-	Sets the limited retry flag.
+-v::
+--show-cmd::
+	Print out the command to be sent.
 
---force-unit-access::
--f::
-	Set the force-unit access flag.
+-w::
+--dry-run::
+	Do not actually send the command. If want to use --dry-run option,
+	--show-cmd option _must_ be set. Otherwise --dry-run optionn will be
+	_ignored_.
 
---latency::
 -t::
+--latency::
 	Print out the latency the IOCTL took (in us).
 
 EXAMPLES
-- 
2.7.4
