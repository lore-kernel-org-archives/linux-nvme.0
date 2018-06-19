From: revanth.rajashekar@intel.com (Revanth Rajashekar)
Date: Tue, 19 Jun 2018 10:50:02 -0600
Subject: [PATCH] nvme-cli: Printing the additional feature in OAES in Identify
 Ctrl
Message-ID: <20180619165002.5710-1-revanth.rajashekar@intel.com>

Signed-off-by: Revanth Rajashekar <revanth.rajashekar at intel.com>
---
 nvme-print.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/nvme-print.c b/nvme-print.c
index 8699d6c..81d5989 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -94,12 +94,15 @@ static void show_nvme_id_ctrl_cmic(__u8 cmic)
 static void show_nvme_id_ctrl_oaes(__le32 ctrl_oaes)
 {
 	__u32 oaes = le32_to_cpu(ctrl_oaes);
-	__u32 rsvd0 = (oaes & 0xFFFFFE00) >> 9;
+	__u32 rsvd0 = (oaes & 0xFFFFFC00) >> 10;
+	__u32 fan  = (oaes & 0x200) >> 9;
 	__u32 nace = (oaes & 0x100) >> 8;
 	__u32 rsvd1 = oaes & 0xFF;
 
 	if (rsvd0)
-		printf(" [31:9] : %#x\tReserved\n", rsvd0);
+		printf(" [31:10] : %#x\tReserved\n", rsvd0);
+	printf("[9:9] : %#x\t Firmware Activation Notices Event %sSupported\n",
+		fan, fan ? "" : "Not ");
 	printf("  [8:8] : %#x\tNamespace Attribute Changed Event %sSupported\n",
 		nace, nace ? "" : "Not ");
 	if (rsvd1)
-- 
2.17.1
