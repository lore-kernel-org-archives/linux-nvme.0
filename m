From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sat, 16 Dec 2017 01:12:06 +0900
Subject: [PATCH] nvme-cli: add BPS bit field to CAP controller register
Message-ID: <1513354326-9924-1-git-send-email-minwoo.im.dev@gmail.com>

NVMe 1.3 spec introduced BPS(Boot Partition Support) bit field in CAP of
controller register.
Add this bit field to "struct nvme_bar_cap" by changing
"css_nssrs_dstrd" field to "bps_css_nssrs_dstrd".
Also add a print for BPS bit field to print CAP properly when show-regs
command with human-readable.

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 nvme-print.c | 7 ++++---
 nvme.h       | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/nvme-print.c b/nvme-print.c
index 87f0766..4968af4 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1953,10 +1953,11 @@ void show_registers_cap(struct nvme_bar_cap *cap)
 {
 	printf("\tMemory Page Size Maximum      (MPSMAX): %u bytes\n", 1 <<  (12 + ((cap->mpsmax_mpsmin & 0xf0) >> 4)));
 	printf("\tMemory Page Size Minimum      (MPSMIN): %u bytes\n", 1 <<  (12 + (cap->mpsmax_mpsmin & 0x0f)));
+	printf("\tBoot Partition Support           (BPS): %s\n", (cap->bps_css_nssrs_dstrd & 0x2000) ? "Yes":"No");
 	printf("\tCommand Sets Supported           (CSS): NVM command set is %s\n",
-			(cap->css_nssrs_dstrd & 0x0020) ? "supported":"not supported");
-	printf("\tNVM Subsystem Reset Supported  (NSSRS): %s\n", (cap->css_nssrs_dstrd & 0x0010) ? "Yes":"No");
-	printf("\tDoorbell Stride                (DSTRD): %u bytes\n", 1 << (2 + (cap->css_nssrs_dstrd & 0x000f)));
+			(cap->bps_css_nssrs_dstrd & 0x0020) ? "supported":"not supported");
+	printf("\tNVM Subsystem Reset Supported  (NSSRS): %s\n", (cap->bps_css_nssrs_dstrd & 0x0010) ? "Yes":"No");
+	printf("\tDoorbell Stride                (DSTRD): %u bytes\n", 1 << (2 + (cap->bps_css_nssrs_dstrd & 0x000f)));
 	printf("\tTimeout                           (TO): %u ms\n", cap->to * 500);
 	printf("\tArbitration Mechanism Supported  (AMS): Weighted Round Robin with Urgent Priority Class is %s\n",
 			(cap->ams_cqr & 0x02) ? "supported":"not supported");
diff --git a/nvme.h b/nvme.h
index b134be1..b84378e 100644
--- a/nvme.h
+++ b/nvme.h
@@ -83,7 +83,7 @@ struct nvme_bar_cap {
 	__u16	mqes;
 	__u8	ams_cqr;
 	__u8	to;
-	__u16	css_nssrs_dstrd;
+	__u16	bps_css_nssrs_dstrd;
 	__u8	mpsmax_mpsmin;
 	__u8	reserved;
 };
-- 
2.7.4
