From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sat, 16 Dec 2017 00:17:59 +0900
Subject: [PATCH] nvme-cli: add prints of boot partition feature to show-regs
Message-ID: <1513351079-7141-1-git-send-email-minwoo.im.dev@gmail.com>

Add prints of Boot Partition feature.

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 linux/nvme.h |  3 +++
 nvme-print.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/linux/nvme.h b/linux/nvme.h
index e21610f..984f4df 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
@@ -112,6 +112,9 @@ enum {
 	NVME_REG_ACQ	= 0x0030,	/* Admin CQ Base Address */
 	NVME_REG_CMBLOC = 0x0038,	/* Controller Memory Buffer Location */
 	NVME_REG_CMBSZ	= 0x003c,	/* Controller Memory Buffer Size */
+	NVME_REG_BPINFO	= 0x0040,	/* Boot Partition Information */
+	NVME_REG_BPRSEL	= 0x0044,	/* Boot Partition Read Select */
+	NVME_REG_BPMBL	= 0x0048,	/* Boot Partition Memory Buffer Location */
 	NVME_REG_DBS	= 0x1000,	/* SQ 0 Tail Doorbell */
 };
 
diff --git a/nvme-print.c b/nvme-print.c
index 87f0766..cfa1ca5 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -2097,6 +2097,61 @@ static void show_registers_cmbsz(__u32 cmbsz)
 			(cmbsz & 0x00000001) ? "Supported":"Not supported");
 }
 
+static void show_registers_bpinfo_brs(__u8 brs)
+{
+	printf("\tBoot Read Status                (BRS): ");
+	switch (brs) {
+	case 0:
+		printf("No Boot Partition read operation requested\n");
+		break;
+	case 1:
+		printf("Boot Partition read in progres\n");
+		break;
+	case 2:
+		printf("Boot Partition read completed successfully\n");
+		break;
+	case 3:
+		printf("Error completing Boot Partition read\n");
+		break;
+	default:
+		printf("Invalid\n");
+	}
+}
+
+static void show_registers_bpinfo(__u32 bpinfo)
+{
+	if (bpinfo == 0) {
+		printf("\tBoot Partition feature is not supported\n\n");
+		return;
+	}
+
+	printf("\tActive Boot Partition ID      (ABPID): %u\n", (bpinfo & 0x80000000) >> 31);
+	show_registers_bpinfo_brs((bpinfo & 0x03000000) >> 24);
+	printf("\tBoot Partition Size            (BPSZ): %u\n", bpinfo & 0x00007fff);
+}
+
+static void show_registers_bprsel(__u32 bprsel)
+{
+	if (bprsel == 0) {
+		printf("\tBoot Partition feature is not supported\n\n");
+		return;
+	}
+
+	printf("\tBoot Partition Identifier      (BPID): %u\n", (bprsel & 0x80000000) >> 31);
+	printf("\tBoot Partition Read Offset    (BPROF): %x\n", (bprsel & 0x3ffffc00) >> 10);
+	printf("\tBoot Partition Read Size      (BPRSZ): %x\n", bprsel & 0x000003ff);
+}
+
+static void show_registers_bpmbl(uint64_t bpmbl)
+{
+	if (bpmbl == 0) {
+		printf("\tBoot Partition feature is not supported\n\n");
+		return;
+	}
+
+	printf("\tBoot Partition Memory Buffer Base Address (BMBBA): %"PRIx64"\n", bpmbl);
+}
+
 static inline uint32_t mmio_read32(void *addr)
 {
 	__le32 *p = addr;
@@ -2114,8 +2169,8 @@ static inline __u64 mmio_read64(void *addr)
 
 void show_ctrl_registers(void *bar, unsigned int mode, bool fabrics)
 {
-	uint64_t cap, asq, acq;
-	uint32_t vs, intms, intmc, cc, csts, nssr, aqa, cmbsz, cmbloc;
+	uint64_t cap, asq, acq, bpmbl;
+	uint32_t vs, intms, intmc, cc, csts, nssr, aqa, cmbsz, cmbloc, bpinfo, bprsel;
 
 	int human = mode & HUMAN;
 
@@ -2131,6 +2186,9 @@ void show_ctrl_registers(void *bar, unsigned int mode, bool fabrics)
 	acq = mmio_read64(bar + NVME_REG_ACQ);
 	cmbloc = mmio_read32(bar + NVME_REG_CMBLOC);
 	cmbsz = mmio_read32(bar + NVME_REG_CMBSZ);
+	bpinfo = mmio_read32(bar + NVME_REG_BPINFO);
+	bprsel = mmio_read32(bar + NVME_REG_BPRSEL);
+	bpmbl = mmio_read64(bar + NVME_REG_BPMBL);
 
 	if (human) {
 		if (cap != 0xffffffff) {
@@ -2177,6 +2235,15 @@ void show_ctrl_registers(void *bar, unsigned int mode, bool fabrics)
 
 			printf("cmbsz   : %x\n", cmbsz);
 			show_registers_cmbsz(cmbsz);
+
+			printf("bpinfo  : %x\n", bpinfo);
+			show_registers_bpinfo(bpinfo);
+
+			printf("bprsel  : %x\n", bprsel);
+			show_registers_bprsel(bprsel);
+
+			printf("bpmbl   : %"PRIx64"\n", bpmbl);
+			show_registers_bpmbl(bpmbl);
 		}
 	} else {
 		if (cap != 0xffffffff)
@@ -2197,6 +2264,9 @@ void show_ctrl_registers(void *bar, unsigned int mode, bool fabrics)
 			printf("acq     : %"PRIx64"\n", acq);
 			printf("cmbloc  : %x\n", cmbloc);
 			printf("cmbsz   : %x\n", cmbsz);
+			printf("bpinfo  : %x\n", bpinfo);
+			printf("bprsel  : %x\n", bprsel);
+			printf("bpmbl   : %"PRIx64"\n", bpmbl);
 		}
 	}
 }
-- 
2.7.4
