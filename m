From: gwendal@chromium.org (Gwendal Grignou)
Date: Sat, 26 Aug 2017 18:25:40 -0700
Subject: [PATCH] nvme-cli: Describe action 3 of nvme activate
Message-ID: <20170827012540.12362-1-gwendal@chromium.org>

Action 3 is not reserved, it is allowed by NVMe 1.3 to upgrade firmware
without reset.

Check it works on a NVMe device.

Signed-off-by: Gwendal Grignou <gwendal at chromium.org>
---
 Documentation/nvme-fw-activate.1    |  6 +++---
 Documentation/nvme-fw-activate.html | 13 ++++++++-----
 Documentation/nvme-fw-activate.txt  |  3 ++-
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/Documentation/nvme-fw-activate.1 b/Documentation/nvme-fw-activate.1
index 334349f..4288147 100644
--- a/Documentation/nvme-fw-activate.1
+++ b/Documentation/nvme-fw-activate.1
@@ -2,12 +2,12 @@
 .\"     Title: nvme-fw-activate
 .\"    Author: [FIXME: author] [see http://docbook.sf.net/el/author]
 .\" Generator: DocBook XSL Stylesheets v1.78.1 <http://docbook.sf.net/>
-.\"      Date: 06/28/2017
+.\"      Date: 08/26/2017
 .\"    Manual: NVMe Manual
 .\"    Source: NVMe
 .\"  Language: English
 .\"
-.TH "NVME\-FW\-ACTIVATE" "1" "06/28/2017" "NVMe" "NVMe Manual"
+.TH "NVME\-FW\-ACTIVATE" "1" "08/26/2017" "NVMe" "NVMe Manual"
 .\" -----------------------------------------------------------------
 .\" * Define some portability stuff
 .\" -----------------------------------------------------------------
@@ -89,7 +89,7 @@ T}
 T{
 3
 T}:T{
-Reserved\&.
+The image specified by the Firmware Slot field is requested to be activated immediately without reset\&.
 T}
 .TE
 .sp 1
diff --git a/Documentation/nvme-fw-activate.html b/Documentation/nvme-fw-activate.html
index 8175777..f73c35c 100644
--- a/Documentation/nvme-fw-activate.html
+++ b/Documentation/nvme-fw-activate.html
@@ -3,7 +3,7 @@
 <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
 <head>
 <meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
-<meta name="generator" content="AsciiDoc 8.6.8" />
+<meta name="generator" content="AsciiDoc 8.6.9" />
 <title>nvme-fw-activate(1)</title>
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
@@ -822,7 +824,8 @@ next reset.</p></td>
 </tr>
 <tr>
 <td align="left" valign="top"><p class="table">3</p></td>
-<td align="left" valign="top"><p class="table">Reserved.</p></td>
+<td align="left" valign="top"><p class="table">The image specified by the Firmware Slot field is requested to be
+activated immediately without reset.</p></td>
 </tr>
 </tbody>
 </table>
@@ -871,7 +874,7 @@ Activate the last downloaded fw to slot 1.
 <div id="footnotes"><hr /></div>
 <div id="footer">
 <div id="footer-text">
-Last updated 2017-02-27 10:11:57 EST
+Last updated 2017-08-26 18:12:07 PDT
 </div>
 </div>
 </body>
diff --git a/Documentation/nvme-fw-activate.txt b/Documentation/nvme-fw-activate.txt
index 92d9116..55a23cd 100644
--- a/Documentation/nvme-fw-activate.txt
+++ b/Documentation/nvme-fw-activate.txt
@@ -54,7 +54,8 @@ field. This image is not activated.
 field. This image is activated at the next reset.
 |2|The image indicated by the Firmware Slot field is activated at the
 next reset.
-|3|Reserved.
+|3|The image specified by the Firmware Slot field is requested to be
+activated immediately without reset.
 |=================
 
 -s <slot>::
-- 
2.14.1.342.g6490525c54-goog
