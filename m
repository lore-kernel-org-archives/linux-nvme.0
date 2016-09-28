From: james_p_freyensee@linux.intel.com (Jay Freyensee)
Date: Wed, 28 Sep 2016 16:49:44 -0700
Subject: [PATCH 4/4] nvme-cli: Add discover connect cmds to main list
In-Reply-To: <1475106584-14961-1-git-send-email-james_p_freyensee@linux.intel.com>
References: <1475106584-14961-1-git-send-email-james_p_freyensee@linux.intel.com>
Message-ID: <1475106584-14961-5-git-send-email-james_p_freyensee@linux.intel.com>

Signed-off-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
---
 Documentation/cmds-main.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/cmds-main.txt b/Documentation/cmds-main.txt
index 7916216..5d5b8f6 100644
--- a/Documentation/cmds-main.txt
+++ b/Documentation/cmds-main.txt
@@ -106,3 +106,9 @@ linknvme:nvme-set-feature[1]::
 linknvme:nvme-show-regs[1]::
 	Show NVMe Controller Registers
 
+linknvme:nvme-discover[1]::
+	Send Get Log Page request to Discovery Controller
+
+linknvme:nvme-connect[1]::
+	Connect to an NVMe-over-Fabrics subsystem
+
-- 
2.7.4
