From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun,  4 Aug 2019 16:10:25 +0900
Subject: [PATCH 2/3] id-ctrl: add 1.4 features to OAES
In-Reply-To: <20190804071026.16149-1-minwoo.im.dev@gmail.com>
References: <20190804071026.16149-1-minwoo.im.dev@gmail.com>
Message-ID: <20190804071026.16149-3-minwoo.im.dev@gmail.com>

Optional Asynchronous Events Supported now has few more fields from 1.4.

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 nvme-print.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/nvme-print.c b/nvme-print.c
index b6e18d488a8e..91eb326157f2 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -122,13 +122,27 @@ static void show_nvme_id_ctrl_cmic(__u8 cmic)
 static void show_nvme_id_ctrl_oaes(__le32 ctrl_oaes)
 {
 	__u32 oaes = le32_to_cpu(ctrl_oaes);
-	__u32 rsvd0 = (oaes & 0xFFFFFC00) >> 10;
+	__u32 rsvd0 = (oaes & 0xFFFF8000) >> 15;
 	__u32 nace = (oaes & 0x100) >> 8;
 	__u32 fan = (oaes & 0x200) >> 9;
+	__u32 anacn = (oaes & 800) >> 11;
+	__u32 plealcn = (oaes & 0x1000) >> 12;
+	__u32 lbasin = (oaes & 0x2000) >> 13;
+	__u32 egealpcn = (oaes & 0x4000) >> 14;
 	__u32 rsvd1 = oaes & 0xFF;
 
 	if (rsvd0)
 		printf(" [31:10] : %#x\tReserved\n", rsvd0);
+	printf("[14:14] : %#x\tEndurance Group Event Aggregate Log Page"\
+			" Change Notice %sSupported\n",
+			egealpcn, egealpcn ? "" : "Not ");
+	printf("[13:13] : %#x\tLBA Status Information Notices %sSupported\n",
+			lbasin, lbasin ? "" : "Not ");
+	printf("[12:12] : %#x\tPredictable Latency Event Aggregate Log Change"\
+			" Notices %sSupported\n",
+			plealcn, plealcn ? "" : "Not ");
+	printf("[11:11] : %#x\tAsymmetric Namespace Access Change Notices"\
+			" %sSupported\n", anacn, anacn ? "" : "Not ");
 	printf("  [9:9] : %#x\tFirmware Activation Notices %sSupported\n",
 		fan, fan ? "" : "Not ");
 	printf("  [8:8] : %#x\tNamespace Attribute Changed Event %sSupported\n",
-- 
2.17.1
