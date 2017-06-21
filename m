From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Wed, 21 Jun 2017 13:09:24 +0800
Subject: [PATCH 3/3] nvme-cli: add output-format discription for smart-log
In-Reply-To: <1498021764-12092-1-git-send-email-guanjunxiong@huawei.com>
References: <1498021764-12092-1-git-send-email-guanjunxiong@huawei.com>
Message-ID: <1498021764-12092-4-git-send-email-guanjunxiong@huawei.com>

The nvme smart-log command has implemented output-format option,
but the documentation of the command doesn't reflect this. This
patch synchronizes the documentation with the implemenation.

Signed-off-by: Guan Junxiong <guanjunxiong at huawei.com>
---

I don't know why nvme-smart-log.html fails when applied.
It sounds like this file's end of line is in Windows format in a whole
and git has a bug about processing the EOL.
Maybe maintainer should apply this patch manually.

 Documentation/nvme-smart-log.1    |  8 ++++++++
 Documentation/nvme-smart-log.html | 12 ++++++++++++
 Documentation/nvme-smart-log.txt  |  5 +++++
 3 files changed, 25 insertions(+)

diff --git a/Documentation/nvme-smart-log.1 b/Documentation/nvme-smart-log.1
index 40edd10..793c0bf 100644
--- a/Documentation/nvme-smart-log.1
+++ b/Documentation/nvme-smart-log.1
@@ -54,6 +54,14 @@ Retrieve the SMART log for the given nsid\&. This is optional and its success ma
 .RS 4
 Print the raw SMART log buffer to stdout\&.
 .RE
+.PP
+\-o <format>, \-\-output\-format=<format>
+.RS 4
+Set the reporting format to
+\fInormal\fR,
+\fIjson\fR, or
+\fIbinary\fR\&. Only one output format can be used at a time\&.
+.RE
 .SH "EXAMPLES"
 .sp
 .RS 4
diff --git a/Documentation/nvme-smart-log.html b/Documentation/nvme-smart-log.html
index 6cdebba..2bf7545 100644
--- a/Documentation/nvme-smart-log.html
+++ b/Documentation/nvme-smart-log.html
@@ -801,6 +801,18 @@ printed to stdout for another program to parse.</p></div>
         Print the raw SMART log buffer to stdout.
 </p>
 </dd>
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
 </dl></div>
 </div>
 </div>
diff --git a/Documentation/nvme-smart-log.txt b/Documentation/nvme-smart-log.txt
index a9d1eac..2971c94 100644
--- a/Documentation/nvme-smart-log.txt
+++ b/Documentation/nvme-smart-log.txt
@@ -38,6 +38,11 @@ OPTIONS
 --raw-binary::
 	Print the raw SMART log buffer to stdout.
 
+-o <format>::
+--output-format=<format>::
+              Set the reporting format to 'normal', 'json', or
+              'binary'. Only one output format can be used at a time.
+
 EXAMPLES
 --------
 * Print the SMART log page in a human readable format:
-- 
2.11.1
