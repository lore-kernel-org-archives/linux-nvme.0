From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Tue, 21 Mar 2017 22:09:03 +0800
Subject: [PATCH V2] nvme-cli: fix nvme-list-ns documentation to match list_ns
 function
Message-ID: <1490105343-13236-1-git-send-email-guanjunxiong@huawei.com>

From: Junxiong Guan <guanjunxiong@huawei.com>

The list_ns function implements two command line options which is located in the line 496 to 499 of the nvme.c file but the manpage documentations of the nvme list-ns command only demostrate the first option i.e. the given namespace-id , leaving the second option i.e. all namesapces out. Therefore nvme-list-ns.1 , nvme-list-ns.html and nvme-lsit-ns.txt are corrected to match the actual implementation of the list_ns function.
---
 Documentation/nvme-list-ns.1    |  6 ++++++
 Documentation/nvme-list-ns.html | 14 +++++++++++++-
 Documentation/nvme-list-ns.txt  |  7 ++++++-
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/nvme-list-ns.1 b/Documentation/nvme-list-ns.1
index 99e0d5d..b810f1a 100644
--- a/Documentation/nvme-list-ns.1
+++ b/Documentation/nvme-list-ns.1
@@ -33,6 +33,7 @@ nvme-list-ns \- Send NVMe Identify List Namespaces, return result and structure
 .sp
 .nf
 \fInvme list\-ns\fR <device> [\-\-namespace\-id=<nsid> | \-n <nsid>]
+                             [\-\-all | \-a ]
 .fi
 .SH "DESCRIPTION"
 .sp
@@ -47,6 +48,11 @@ On success, the namespace array is printed for each index and nsid for a valid n
 .RS 4
 Retrieve the identify list structure starting with the given nsid\&.
 .RE
+.PP
+\-a , \-\-all
+.RS 4
+Retrieve the identify list structure for all the namespaces in the subsystem whether attached or inactive\&.
+.RE
 .SH "EXAMPLES"
 .sp
 No examples yet\&.
diff --git a/Documentation/nvme-list-ns.html b/Documentation/nvme-list-ns.html
index e61f103..3ddb40b 100644
--- a/Documentation/nvme-list-ns.html
+++ b/Documentation/nvme-list-ns.html
@@ -752,7 +752,8 @@ nvme-id-ns(1) Manual Page
 <h2 id="_synopsis">SYNOPSIS</h2>
 <div class="sectionbody">
 <div class="verseblock">
-<pre class="content"><em>nvme list-ns</em> &lt;device&gt; [--namespace-id=&lt;nsid&gt; | -n &lt;nsid&gt;]</pre>
+<pre class="content"><em>nvme list-ns</em> &lt;device&gt; [--namespace-id=&lt;nsid&gt; | -n &lt;nsid&gt;]
+                                          [--all | -a]</pre>
 <div class="attribution">
 </div></div>
 </div>
@@ -785,6 +786,17 @@ a valid nsid.</p></div>
         Retrieve the identify list structure starting with the given nsid.
 </p>
 </dd>
+<dt class="hdlist1">
+-a
+</dt>
+<dt class="hdlist1">
+-all
+</dt>
+<dd>
+<p>
+       Retrieve the identify list structure for all the namespaces in the 
+       subsystem whether attached or inactive.
+</p>
 </dl></div>
 </div>
 </div>
diff --git a/Documentation/nvme-list-ns.txt b/Documentation/nvme-list-ns.txt
index 13a12d6..941b9aa 100644
--- a/Documentation/nvme-list-ns.txt
+++ b/Documentation/nvme-list-ns.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'nvme list-ns' <device> [--namespace-id=<nsid> | -n <nsid>]
-
+                        [--all | -a ]
 DESCRIPTION
 -----------
 For the NVMe device given, sends an identify command for namespace list
@@ -29,6 +29,11 @@ OPTIONS
 --namespace-id=<nsid>::
 	Retrieve the identify list structure starting with the given nsid.
 
+-a::
+--all::
+	Retrieve the identify list structure for all the namespaces in the
+    subsystem whether attached or inactive.
+
 EXAMPLES
 --------
 No examples yet.
-- 
2.11.1
