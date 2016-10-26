From: hch@lst.de (Christoph Hellwig)
Date: Wed, 26 Oct 2016 17:01:16 +0200
Subject: [PATCH] nvme-cli: endian swap mmio access
Message-ID: <1477494076-13968-1-git-send-email-hch@lst.de>

PCIe is always defined as little endian, so swap the data read from the
register to native endian.

Use the opportunity to also apply the no 64-bit access workaround to
all of the register accesses and not just some and dump struct nvme_reg.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 nvme.c | 128 +++++++++++++++++++++++++++++++++++------------------------------
 nvme.h |  16 ---------
 2 files changed, 70 insertions(+), 74 deletions(-)

diff --git a/nvme.c b/nvme.c
index a238b2e..220a57a 100644
--- a/nvme.c
+++ b/nvme.c
@@ -703,7 +703,7 @@ static char *nvme_char_from_block(char *block)
 	return block;
 }
 
-static void get_registers(struct nvme_bar **bar)
+static void *get_registers(void)
 {
 	int pci_fd;
 	char *base, path[512];
@@ -726,7 +726,7 @@ static void get_registers(struct nvme_bar **bar)
 		fprintf(stderr, "%s failed to map\n", base);
 		exit(ENODEV);
 	}
-	*bar = membase;
+	return membase;
 }
 
 static void print_list_item(struct list_item list_item)
@@ -1334,9 +1334,19 @@ static int reset(int argc, char **argv, struct command *cmd, struct plugin *plug
 	return err;
 }
 
-static void print_lo_hi_64(uint32_t *val)
+static inline uint32_t mmio_read32(void *addr)
 {
-	printf("%x%08x\n", val[1], val[0]);
+	__le32 *p = addr;
+
+	return le32_to_cpu(*p);
+}
+
+/* Access 64-bit registers as 2 32-bit; Some devices fail 64-bit MMIO. */
+static inline __u64 mmio_read64(void *addr)
+{
+	__le32 *p = addr;
+
+	return le32_to_cpu(*p) | ((uint64_t)le32_to_cpu(*(p + 1)) << 32);
 }
 
 static int show_registers(int argc, char **argv, struct command *cmd, struct plugin *plugin)
@@ -1344,7 +1354,9 @@ static int show_registers(int argc, char **argv, struct command *cmd, struct plu
 	const char *desc = "Reads and shows the defined NVMe controller registers "\
 					"in binary or human-readable format";
 	const char *human_readable = "show info in readable format";
-	struct nvme_bar *bar;
+	uint64_t cap, asq, acq;
+	uint32_t vs, intms, intmc, cc, csts, nssr, aqa, cmbsz, cmbloc;
+	void *bar;
 
 	struct config {
 		int human_readable;
@@ -1361,71 +1373,71 @@ static int show_registers(int argc, char **argv, struct command *cmd, struct plu
 
 	parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
 
-	get_registers(&bar);
+	bar = get_registers();
+	cap = mmio_read64(bar + NVME_REG_CAP);
+	vs = mmio_read32(bar + NVME_REG_VS);
+	intms = mmio_read32(bar + NVME_REG_INTMS);
+	intmc = mmio_read32(bar + NVME_REG_INTMC);
+	cc = mmio_read32(bar + NVME_REG_CC);
+	csts = mmio_read32(bar + NVME_REG_CSTS);
+	nssr = mmio_read32(bar + NVME_REG_NSSR);
+	aqa = mmio_read32(bar + NVME_REG_AQA);
+	asq = mmio_read64(bar + NVME_REG_ASQ);
+	acq = mmio_read64(bar + NVME_REG_ACQ);
+	cmbloc = mmio_read32(bar + NVME_REG_CMBLOC);
+	cmbsz = mmio_read32(bar + NVME_REG_CMBSZ);
 
 	if (cfg.human_readable) {
-		printf("cap     : ");
-		print_lo_hi_64((uint32_t *)&bar->cap);
-		show_registers_cap((struct nvme_bar_cap *)&bar->cap);
+		printf("cap     : %"PRIx64"\n", cap);
+		show_registers_cap((struct nvme_bar_cap *)&cap);
 
-		printf("version : %x\n", bar->vs);
-		show_registers_version(bar->vs);
-
-		printf("intms   : %x\n", bar->intms);
-		printf("\tInterrupt Vector Mask Set (IVMS): %x\n\n", bar->intms); 
+		printf("version : %x\n", vs);
+		show_registers_version(vs);
+	
+		printf("intms   : %x\n", intms);
+		printf("\tInterrupt Vector Mask Set (IVMS): %x\n\n", intms);
 
-		printf("intmc   : %x\n", bar->intmc);
-		printf("\tInterrupt Vector Mask Clear (IVMC): %x\n\n", bar->intmc); 
+		printf("intmc   : %x\n", intmc);
+		printf("\tInterrupt Vector Mask Clear (IVMC): %x\n\n", intmc);
 
-		printf("cc      : %x\n", bar->cc);
-		show_registers_cc(bar->cc);
+		printf("cc      : %x\n", cc);
+		show_registers_cc(cc);
 
-		printf("csts    : %x\n", bar->csts);
-		show_registers_csts(bar->csts);
+		printf("csts    : %x\n", csts);
+		show_registers_csts(csts);
 
-		printf("nssr    : %x\n", bar->nssr);
-		printf("\tNVM Subsystem Reset Control (NSSRC): %u\n\n", bar->nssr); 
+		printf("nssr    : %x\n", nssr);
+		printf("\tNVM Subsystem Reset Control (NSSRC): %u\n\n", nssr);
 
-		printf("aqa     : %x\n", bar->aqa);
-		show_registers_aqa(bar->aqa);
+		printf("aqa     : %x\n", aqa);
+		show_registers_aqa(aqa);
 
-		printf("asq     : ");
-		print_lo_hi_64((uint32_t *)&bar->asq);
-		printf("\tAdmin Submission Queue Base (ASQB): ");
-		print_lo_hi_64((uint32_t *)&bar->asq);
-		printf("\n");
+		printf("asq     : %"PRIx64"\n", asq);
+		printf("\tAdmin Submission Queue Base (ASQB): %"PRIx64"\n",
+				asq);
 
-		printf("acq     : ");
-		print_lo_hi_64((uint32_t *)&bar->acq);
-		printf("\tAdmin Completion Queue Base (ACQB): ");
-		print_lo_hi_64((uint32_t *)&bar->acq);
-		printf("\n");
+		printf("acq     : %"PRIx64"\n", acq);
+		printf("\tAdmin Completion Queue Base (ACQB): %"PRIx64"\n",
+				acq);
 
-		printf("cmbloc  : %x\n", bar->cmbloc);
-		show_registers_cmbloc(bar->cmbloc, bar->cmbsz);
+		printf("cmbloc  : %x\n", cmbloc);
+		show_registers_cmbloc(cmbloc, cmbsz);
 
-		printf("cmbsz   : %x\n", bar->cmbsz);
-		show_registers_cmbsz(bar->cmbsz);
-	}
-	else {
-		printf("cap     : ");
-		print_lo_hi_64((uint32_t *)&bar->cap);
-
-		printf("version : %x\n", bar->vs);
-		printf("intms   : %x\n", bar->intms);
-		printf("intmc   : %x\n", bar->intmc);
-		printf("cc      : %x\n", bar->cc);
-		printf("csts    : %x\n", bar->csts);
-		printf("nssr    : %x\n", bar->nssr);
-		printf("aqa     : %x\n", bar->aqa);
-		printf("asq     : ");
-		print_lo_hi_64((uint32_t *)&bar->asq);
-
-		printf("acq     : ");
-		print_lo_hi_64((uint32_t *)&bar->acq);
-
-		printf("cmbloc  : %x\n", bar->cmbloc);
-		printf("cmbsz   : %x\n", bar->cmbsz);
+		printf("cmbsz   : %x\n", cmbsz);
+		show_registers_cmbsz(cmbsz);
+	} else {
+		printf("cap     : %"PRIx64"\n", cap);
+		printf("version : %x\n", vs);
+		printf("intms   : %x\n", intms);
+		printf("intmc   : %x\n", intmc);
+		printf("cc      : %x\n", cc);
+		printf("csts    : %x\n", csts);
+		printf("nssr    : %x\n", nssr);
+		printf("aqa     : %x\n", aqa);
+		printf("asq     : %"PRIx64"\n", asq);
+		printf("acq     : %"PRIx64"\n", acq);
+		printf("cmbloc  : %x\n", cmbloc);
+		printf("cmbsz   : %x\n", cmbsz);
 	}
 
 	return 0;
diff --git a/nvme.h b/nvme.h
index f53800b..6623505 100644
--- a/nvme.h
+++ b/nvme.h
@@ -109,22 +109,6 @@ struct nvme_controller_list {
 	__le16 identifier[];
 };
 
-struct nvme_bar {
-	__u64			cap;	/* Controller Capabilities */
-	__u32			vs;	/* Version */
-	__u32			intms;	/* Interrupt Mask Set */
-	__u32			intmc;	/* Interrupt Mask Clear */
-	__u32			cc;	/* Controller Configuration */
-	__u32			rsvd1;	/* Reserved */
-	__u32			csts;	/* Controller Status */
-	__u32			nssr;	/* NVM Subsystem Reset */
-	__u32			aqa;	/* Admin Queue Attributes */
-	__u64			asq;	/* Admin SQ Base Address */
-	__u64			acq;	/* Admin CQ Base Address */
-	__u32			cmbloc;	/* Controller Memory Buffer Location */
-	__u32			cmbsz;	/* Controller Memory Buffer Size */
-};
-
 struct nvme_bar_cap {
 	__u16	mqes;
 	__u8	ams_cqr;
-- 
2.1.4
