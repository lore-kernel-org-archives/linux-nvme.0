From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun,  4 Aug 2019 16:10:24 +0900
Subject: [PATCH 1/3] id-ctrl: add an indicator for get lba status capability
In-Reply-To: <20190804071026.16149-1-minwoo.im.dev@gmail.com>
References: <20190804071026.16149-1-minwoo.im.dev@gmail.com>
Message-ID: <20190804071026.16149-2-minwoo.im.dev@gmail.com>

NVMe 1.4 supports for the Get LBA Status Capability which can be
referred to 8.22.  The Identify Controller is now able to indicate
whether or not the Get LBA Status Capability is supported.

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 nvme-print.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/nvme-print.c b/nvme-print.c
index 2b6bc389015b..b6e18d488a8e 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -169,7 +169,8 @@ static void show_nvme_id_ctrl_ctratt(__le32 ctrl_ctratt)
 static void show_nvme_id_ctrl_oacs(__le16 ctrl_oacs)
 {
 	__u16 oacs = le16_to_cpu(ctrl_oacs);
-	__u16 rsvd = (oacs & 0xFE00) >> 9;
+	__u16 rsvd = (oacs & 0xFC00) >> 10;
+	__u16 glbas = (oacs & 0x200) >> 9;
 	__u16 dbc = (oacs & 0x100) >> 8;
 	__u16 vir = (oacs & 0x80) >> 7;
 	__u16 nmi = (oacs & 0x40) >> 6;
@@ -182,6 +183,8 @@ static void show_nvme_id_ctrl_oacs(__le16 ctrl_oacs)
 
 	if (rsvd)
 		printf(" [15:9] : %#x\tReserved\n", rsvd);
+	printf("  [9:9] : %#x\tGet LBA Status Capability %sSupported\n",
+		glbas, glbas ? "" : "Not ");
 	printf("  [8:8] : %#x\tDoorbell Buffer Config %sSupported\n",
 		dbc, dbc ? "" : "Not ");
 	printf("  [7:7] : %#x\tVirtualization Management %sSupported\n",
-- 
2.17.1
