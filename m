From: hch@lst.de (Christoph Hellwig)
Date: Thu, 22 Sep 2016 20:22:58 -0700
Subject: [PATCH 07/18] add support for checking endianess annotations using
 sparse
In-Reply-To: <1474600989-16657-1-git-send-email-hch@lst.de>
References: <1474600989-16657-1-git-send-email-hch@lst.de>
Message-ID: <1474600989-16657-8-git-send-email-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 fabrics.c       |   6 +--
 memblaze-nvme.c |  16 ++++----
 nvme-ioctl.c    |  18 ++++-----
 nvme-lightnvm.c |  52 +++++++++++++-------------
 nvme-print.c    | 114 ++++++++++++++++++++++++++++----------------------------
 nvme.c          |   4 +-
 nvme.h          |  20 ++++++++++
 7 files changed, 125 insertions(+), 105 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index ad06392..935f2d0 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -304,8 +304,8 @@ static int nvmf_get_log_page_discovery(const char *dev_path,
 	}
 
 	/* check numrec limits */
-	*numrec = le64toh(log->numrec);
-	genctr = le64toh(log->genctr);
+	*numrec = le64_to_cpu(log->numrec);
+	genctr = le64_to_cpu(log->genctr);
 	free(log);
 
 	if (*numrec == 0) {
@@ -338,7 +338,7 @@ static int nvmf_get_log_page_discovery(const char *dev_path,
 		goto out_free_log;
 	}
 
-	if (*numrec != le32toh(log->numrec) || genctr != le64toh(log->genctr)) {
+	if (*numrec != le32_to_cpu(log->numrec) || genctr != le64_to_cpu(log->genctr)) {
 		error = DISC_NOT_EQUAL;
 		goto out_free_log;
 	}
diff --git a/memblaze-nvme.c b/memblaze-nvme.c
index 50f11bd..0f73e81 100644
--- a/memblaze-nvme.c
+++ b/memblaze-nvme.c
@@ -115,24 +115,24 @@ static int show_memblaze_smart_log(int fd, __u32 nsid, const char *devname,
 		smart->items[THERMAL_THROTTLE].thermal_throttle.count);
 
 	printf("Maximum temperature in Kelvin since last factory reset		: %u\n",
-		le16toh(smart->items[TEMPT_SINCE_RESET].temperature.max));
+		le16_to_cpu(smart->items[TEMPT_SINCE_RESET].temperature.max));
 	printf("Minimum temperature in Kelvin since last factory reset		: %u\n",
-		le16toh(smart->items[TEMPT_SINCE_RESET].temperature.min));
+		le16_to_cpu(smart->items[TEMPT_SINCE_RESET].temperature.min));
 	if (compare_fw_version(fw_ver, "0.09.0300") != 0) {
 		printf("Maximum temperature in Kelvin since power on			: %u\n",
-			le16toh(smart->items[TEMPT_SINCE_BOOTUP].temperature_p.max));
+			le16_to_cpu(smart->items[TEMPT_SINCE_BOOTUP].temperature_p.max));
 		printf("Minimum temperature in Kelvin since power on			: %u\n",
-			le16toh(smart->items[TEMPT_SINCE_BOOTUP].temperature_p.min));
+			le16_to_cpu(smart->items[TEMPT_SINCE_BOOTUP].temperature_p.min));
 	}
 	printf("Current temperature in Kelvin					: %u\n",
-		le16toh(smart->items[TEMPT_SINCE_RESET].temperature.curr));
+		le16_to_cpu(smart->items[TEMPT_SINCE_RESET].temperature.curr));
 
 	printf("Maximum power in watt since power on				: %u\n",
-		le16toh(smart->items[POWER_CONSUMPTION].power.max));
+		le16_to_cpu(smart->items[POWER_CONSUMPTION].power.max));
 	printf("Minimum power in watt since power on				: %u\n",
-		le16toh(smart->items[POWER_CONSUMPTION].power.min));
+		le16_to_cpu(smart->items[POWER_CONSUMPTION].power.min));
 	printf("Current power in watt						: %u\n",
-		le16toh(smart->items[POWER_CONSUMPTION].power.curr));
+		le16_to_cpu(smart->items[POWER_CONSUMPTION].power.curr));
 
 	return err;
 }
diff --git a/nvme-ioctl.c b/nvme-ioctl.c
index f2c72f5..db9c332 100644
--- a/nvme-ioctl.c
+++ b/nvme-ioctl.c
@@ -234,9 +234,9 @@ struct nvme_dsm_range *nvme_setup_dsm_range(__u32 *ctx_attrs, __u32 *llbas,
 	if (!dsm)
 		exit(ENOMEM);
 	for (i = 0; i < nr_ranges; i++) {
-		dsm[i].cattr = htole32(ctx_attrs[i]);
-		dsm[i].nlb = htole32(llbas[i]);
-		dsm[i].slba = htole64(slbas[i]);
+		dsm[i].cattr = cpu_to_le32(ctx_attrs[i]);
+		dsm[i].nlb = cpu_to_le32(llbas[i]);
+		dsm[i].slba = cpu_to_le64(slbas[i]);
 	}
 	return dsm;
 }
@@ -244,7 +244,7 @@ struct nvme_dsm_range *nvme_setup_dsm_range(__u32 *ctx_attrs, __u32 *llbas,
 int nvme_resv_acquire(int fd, __u32 nsid, __u8 rtype, __u8 racqa,
 		      bool iekey, __u64 crkey, __u64 nrkey)
 {
-	__le64 payload[2] = { htole64(crkey), htole64(nrkey) };
+	__le64 payload[2] = { cpu_to_le64(crkey), cpu_to_le64(nrkey) };
 	__u32 cdw10 = racqa | (iekey ? 1 << 3 : 0) | rtype << 8;
 	struct nvme_passthru_cmd cmd = {
 		.opcode		= nvme_cmd_resv_acquire,
@@ -260,7 +260,7 @@ int nvme_resv_acquire(int fd, __u32 nsid, __u8 rtype, __u8 racqa,
 int nvme_resv_register(int fd, __u32 nsid, __u8 rrega, __u8 cptpl,
 		       bool iekey, __u64 crkey, __u64 nrkey)
 {
-	__le64 payload[2] = { htole64(crkey), htole64(nrkey) };
+	__le64 payload[2] = { cpu_to_le64(crkey), cpu_to_le64(nrkey) };
 	__u32 cdw10 = rrega | (iekey ? 1 << 3 : 0) | cptpl << 30;
 
 	struct nvme_passthru_cmd cmd = {
@@ -277,7 +277,7 @@ int nvme_resv_register(int fd, __u32 nsid, __u8 rrega, __u8 cptpl,
 int nvme_resv_release(int fd, __u32 nsid, __u8 rtype, __u8 rrela,
 		      bool iekey, __u64 crkey)
 {
-	__le64 payload[1] = { htole64(crkey) };
+	__le64 payload[1] = { cpu_to_le64(crkey) };
 	__u32 cdw10 = rrela | (iekey ? 1 << 3 : 0) | rtype << 8;
 
 	struct nvme_passthru_cmd cmd = {
@@ -455,8 +455,8 @@ int nvme_ns_create(int fd, __u64 nsze, __u64 ncap, __u8 flbas,
 		   __u8 dps, __u8 nmic, __u32 *result)
 {
 	struct nvme_id_ns ns = {
-		.nsze		= htole64(nsze),
-		.ncap		= htole64(ncap),
+		.nsze		= cpu_to_le64(nsze),
+		.ncap		= cpu_to_le64(ncap),
 		.flbas		= flbas,
 		.dps		= dps,
 		.nmic		= nmic,
@@ -504,7 +504,7 @@ int nvme_ns_attachment(int fd, __u32 nsid, __u16 num_ctrls, __u16 *ctrlist,
 	memset(buf, 0, sizeof(buf));
 	cntlist->num = num_ctrls;
 	for (i = 0; i < cntlist->num; i++)
-		cntlist->identifier[i] = htole16((__u16) ctrlist[i]);
+		cntlist->identifier[i] = cpu_to_le16(ctrlist[i]);
 
 	return nvme_submit_admin_passthru(fd, &cmd);
 }
diff --git a/nvme-lightnvm.c b/nvme-lightnvm.c
index 970976b..ddb8a3e 100644
--- a/nvme-lightnvm.c
+++ b/nvme-lightnvm.c
@@ -224,20 +224,20 @@ static void show_lnvm_id_grp(struct nvme_nvm_id_group *grp)
 	printf(" chnls   : %d\n", grp->num_ch);
 	printf(" luns    : %d\n", grp->num_lun);
 	printf(" plns    : %d\n", grp->num_pln);
-	printf(" blks    : %d\n", (uint16_t)le16toh(grp->num_blk));
-	printf(" pgs     : %d\n", (uint16_t)le16toh(grp->num_pg));
-	printf(" fpg_sz  : %d\n", (uint16_t)le16toh(grp->fpg_sz));
-	printf(" csecs   : %d\n", (uint16_t)le16toh(grp->csecs));
-	printf(" sos     : %d\n", (uint16_t)le16toh(grp->sos));
-	printf(" trdt    : %d\n", (uint32_t)le32toh(grp->trdt));
-	printf(" trdm    : %d\n", (uint32_t)le32toh(grp->trdm));
-	printf(" tprt    : %d\n", (uint32_t)le32toh(grp->tprt));
-	printf(" tprm    : %d\n", (uint32_t)le32toh(grp->tprm));
-	printf(" tbet    : %d\n", (uint32_t)le32toh(grp->tbet));
-	printf(" tbem    : %d\n", (uint32_t)le32toh(grp->tbem));
-	printf(" mpos    : %#x\n", (uint32_t)le32toh(grp->mpos));
-	printf(" mccap   : %#x\n", (uint32_t)le32toh(grp->mccap));
-	printf(" cpar    : %#x\n", (uint16_t)le16toh(grp->cpar));
+	printf(" blks    : %d\n", (uint16_t)le16_to_cpu(grp->num_blk));
+	printf(" pgs     : %d\n", (uint16_t)le16_to_cpu(grp->num_pg));
+	printf(" fpg_sz  : %d\n", (uint16_t)le16_to_cpu(grp->fpg_sz));
+	printf(" csecs   : %d\n", (uint16_t)le16_to_cpu(grp->csecs));
+	printf(" sos     : %d\n", (uint16_t)le16_to_cpu(grp->sos));
+	printf(" trdt    : %d\n", (uint32_t)le32_to_cpu(grp->trdt));
+	printf(" trdm    : %d\n", (uint32_t)le32_to_cpu(grp->trdm));
+	printf(" tprt    : %d\n", (uint32_t)le32_to_cpu(grp->tprt));
+	printf(" tprm    : %d\n", (uint32_t)le32_to_cpu(grp->tprm));
+	printf(" tbet    : %d\n", (uint32_t)le32_to_cpu(grp->tbet));
+	printf(" tbem    : %d\n", (uint32_t)le32_to_cpu(grp->tbem));
+	printf(" mpos    : %#x\n", (uint32_t)le32_to_cpu(grp->mpos));
+	printf(" mccap   : %#x\n", (uint32_t)le32_to_cpu(grp->mccap));
+	printf(" cpar    : %#x\n", (uint16_t)le16_to_cpu(grp->cpar));
 }
 
 static void show_lnvm_ppaf(struct nvme_nvm_addr_format *ppaf)
@@ -269,8 +269,8 @@ static void show_lnvm_id_ns(struct nvme_nvm_id *id)
 	printf("verid    : %#x\n", id->ver_id);
 	printf("vmnt     : %#x\n", id->vmnt);
 	printf("cgrps    : %d\n", id->cgrps);
-	printf("cap      : %#x\n", (uint32_t)le32toh(id->cap));
-	printf("dom      : %#x\n", (uint32_t)le32toh(id->dom));
+	printf("cap      : %#x\n", (uint32_t)le32_to_cpu(id->cap));
+	printf("dom      : %#x\n", (uint32_t)le32_to_cpu(id->dom));
 	show_lnvm_ppaf(&id->ppaf);
 
 	for (i = 0; i < id->cgrps; i++) {
@@ -313,12 +313,12 @@ int lnvm_do_id_ns(int fd, int nsid, unsigned int flags)
 
 static void show_lnvm_bbtbl(struct nvme_nvm_bb_tbl *tbl)
 {
-	printf("verid    : %#x\n", (uint16_t)le16toh(tbl->verid));
-	printf("tblks    : %d\n", (uint32_t)le32toh(tbl->tblks));
-	printf("tfact    : %d\n", (uint32_t)le32toh(tbl->tfact));
-	printf("tgrown   : %d\n", (uint32_t)le32toh(tbl->tgrown));
-	printf("tdresv   : %d\n", (uint32_t)le32toh(tbl->tdresv));
-	printf("thresv   : %d\n", (uint32_t)le32toh(tbl->thresv));
+	printf("verid    : %#x\n", (uint16_t)le16_to_cpu(tbl->verid));
+	printf("tblks    : %d\n", (uint32_t)le32_to_cpu(tbl->tblks));
+	printf("tfact    : %d\n", (uint32_t)le32_to_cpu(tbl->tfact));
+	printf("tgrown   : %d\n", (uint32_t)le32_to_cpu(tbl->tgrown));
+	printf("tdresv   : %d\n", (uint32_t)le32_to_cpu(tbl->tdresv));
+	printf("thresv   : %d\n", (uint32_t)le32_to_cpu(tbl->thresv));
 	printf("Use raw output to retrieve table.\n");
 }
 
@@ -327,7 +327,7 @@ static int __lnvm_do_get_bbtbl(int fd, struct nvme_nvm_id *id,
 						unsigned int flags)
 {
 	struct nvme_nvm_id_group *grp = &id->groups[0];
-	int bbtblsz = ((uint16_t)le16toh(grp->num_blk) * grp->num_pln);
+	int bbtblsz = ((uint16_t)le16_to_cpu(grp->num_blk) * grp->num_pln);
 	int bufsz = bbtblsz + sizeof(struct nvme_nvm_bb_tbl);
 	struct nvme_nvm_bb_tbl *bbtbl;
 	int err;
@@ -341,7 +341,7 @@ static int __lnvm_do_get_bbtbl(int fd, struct nvme_nvm_id *id,
 		.nsid		= 1,
 		.addr		= (__u64)(uintptr_t)bbtbl,
 		.data_len	= bufsz,
-		.ppa		= htole64(ppa.ppa),
+		.ppa		= cpu_to_le64(ppa.ppa),
 	};
 
 	err = nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD,
@@ -399,8 +399,8 @@ static int __lnvm_do_set_bbtbl(int fd, struct ppa_addr ppa, __u8 value)
 	struct nvme_nvm_setbbtbl cmd = {
 		.opcode		= nvme_nvm_admin_set_bb_tbl,
 		.nsid		= 1,
-		.ppa		= htole64(ppa.ppa),
-		.nlb		= htole16(0),
+		.ppa		= cpu_to_le64(ppa.ppa),
+		.nlb		= cpu_to_le16(0),
 		.value		= value,
 	};
 
diff --git a/nvme-print.c b/nvme-print.c
index 89413e0..95afdf9 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -76,7 +76,7 @@ static void show_nvme_id_ctrl_cmic(__u8 cmic)
 
 static void show_nvme_id_ctrl_oaes(__le32 ctrl_oaes)
 {
-	__u32 oaes = le32toh(ctrl_oaes);
+	__u32 oaes = le32_to_cpu(ctrl_oaes);
 	__u32 rsvd0 = (oaes & 0xFFFFFE00) >> 9;
 	__u32 nace = (oaes & 0x100) >> 8;
 	__u32 rsvd1 = oaes & 0xFF;
@@ -92,7 +92,7 @@ static void show_nvme_id_ctrl_oaes(__le32 ctrl_oaes)
 
 static void show_nvme_id_ctrl_oacs(__le16 ctrl_oacs)
 {
-	__u16 oacs = le16toh(ctrl_oacs);
+	__u16 oacs = le16_to_cpu(ctrl_oacs);
 	__u16 rsvd = (oacs & 0xFFF0) >> 4;
 	__u16 nsm = (oacs & 0x8) >> 3;
 	__u16 fwc = (oacs & 0x4) >> 2;
@@ -166,7 +166,7 @@ static void show_nvme_id_ctrl_apsta(__u8 apsta)
 
 static void show_nvme_id_ctrl_rpmbs(__le32 ctrl_rpmbs)
 {
-	__u32 rpmbs = le32toh(ctrl_rpmbs);
+	__u32 rpmbs = le32_to_cpu(ctrl_rpmbs);
 	__u32 asz = (rpmbs & 0xFF000000) >> 24;
 	__u32 tsz = (rpmbs & 0xFF0000) >> 16;
 	__u32 rsvd = (rpmbs & 0xFFC0) >> 6;
@@ -202,7 +202,7 @@ static void show_nvme_id_ctrl_cqes(__u8 cqes)
 
 static void show_nvme_id_ctrl_oncs(__le16 ctrl_oncs)
 {
-	__u16 oncs = le16toh(ctrl_oncs);
+	__u16 oncs = le16_to_cpu(ctrl_oncs);
 	__u16 rsvd = (oncs & 0xFFC0) >> 6;
 	__u16 resv = (oncs & 0x20) >> 5;
 	__u16 save = (oncs & 0x10) >> 4;
@@ -230,7 +230,7 @@ static void show_nvme_id_ctrl_oncs(__le16 ctrl_oncs)
 
 static void show_nvme_id_ctrl_fuses(__le16 ctrl_fuses)
 {
-	__u16 fuses = le16toh(ctrl_fuses);
+	__u16 fuses = le16_to_cpu(ctrl_fuses);
 	__u16 rsvd = (fuses & 0xFE) >> 1;
 	__u16 cmpw = fuses & 0x1;
 
@@ -282,7 +282,7 @@ static void show_nvme_id_ctrl_nvscc(__u8 nvscc)
 
 static void show_nvme_id_ctrl_sgls(__le32 ctrl_sgls)
 {
-	__u32 sgls = le32toh(ctrl_sgls);
+	__u32 sgls = le32_to_cpu(ctrl_sgls);
 	__u32 rsvd0 = (sgls & 0xFFF80000) >> 19;
 	__u32 sglltb = (sgls & 0x40000) >> 18;
 	__u32 bacmdb = (sgls & 0x20000) >> 17;
@@ -450,9 +450,9 @@ void show_nvme_id_ns(struct nvme_id_ns *ns, unsigned int mode)
 	int human = mode&HUMAN,
 		vs = mode&VS;
 
-	printf("nsze    : %#"PRIx64"\n", (uint64_t)le64toh(ns->nsze));
-	printf("ncap    : %#"PRIx64"\n", (uint64_t)le64toh(ns->ncap));
-	printf("nuse    : %#"PRIx64"\n", (uint64_t)le64toh(ns->nuse));
+	printf("nsze    : %#"PRIx64"\n", (uint64_t)le64_to_cpu(ns->nsze));
+	printf("ncap    : %#"PRIx64"\n", (uint64_t)le64_to_cpu(ns->ncap));
+	printf("nuse    : %#"PRIx64"\n", (uint64_t)le64_to_cpu(ns->nuse));
 	printf("nsfeat  : %#x\n", ns->nsfeat);
 	if (human)
 		show_nvme_id_ns_nsfeat(ns->nsfeat);
@@ -478,12 +478,12 @@ void show_nvme_id_ns(struct nvme_id_ns *ns, unsigned int mode)
 	printf("fpi     : %#x\n", ns->fpi);
 	if (human)
 		show_nvme_id_ns_fpi(ns->fpi);
-	printf("nawun   : %d\n", le16toh(ns->nawun));
-	printf("nawupf  : %d\n", le16toh(ns->nawupf));
-	printf("nacwu   : %d\n", le16toh(ns->nacwu));
-	printf("nabsn   : %d\n", le16toh(ns->nabsn));
-	printf("nabo    : %d\n", le16toh(ns->nabo));
-	printf("nabspf  : %d\n", le16toh(ns->nabspf));
+	printf("nawun   : %d\n", le16_to_cpu(ns->nawun));
+	printf("nawupf  : %d\n", le16_to_cpu(ns->nawupf));
+	printf("nacwu   : %d\n", le16_to_cpu(ns->nacwu));
+	printf("nabsn   : %d\n", le16_to_cpu(ns->nabsn));
+	printf("nabo    : %d\n", le16_to_cpu(ns->nabo));
+	printf("nabspf  : %d\n", le16_to_cpu(ns->nabspf));
 	printf("nvmcap  : %.0Lf\n", int128_to_double(ns->nvmcap));
 
 	printf("nguid   : ");
@@ -500,14 +500,14 @@ void show_nvme_id_ns(struct nvme_id_ns *ns, unsigned int mode)
 		if (human)
 			printf("LBA Format %2d : Metadata Size: %-3d bytes - "
 				"Data Size: %-2d bytes - Relative Performance: %#x %s %s\n", i,
-				le16toh(ns->lbaf[i].ms), 1 << ns->lbaf[i].ds, ns->lbaf[i].rp,
+				le16_to_cpu(ns->lbaf[i].ms), 1 << ns->lbaf[i].ds, ns->lbaf[i].rp,
 				ns->lbaf[i].rp == 3 ? "Degraded" :
 				ns->lbaf[i].rp == 2 ? "Good" :
 				ns->lbaf[i].rp == 1 ? "Better" : "Best",
 				i == (ns->flbas & 0xf) ? "(in use)" : "");
 		else
 			printf("lbaf %2d : ms:%-3d lbads:%-2d rp:%#x %s\n", i,
-				le16toh(ns->lbaf[i].ms), ns->lbaf[i].ds, ns->lbaf[i].rp,
+				le16_to_cpu(ns->lbaf[i].ms), ns->lbaf[i].ds, ns->lbaf[i].rp,
 				i == (ns->flbas & 0xf) ? "(in use)" : "");
 	}
 	if (vs) {
@@ -518,7 +518,7 @@ void show_nvme_id_ns(struct nvme_id_ns *ns, unsigned int mode)
 
 static void print_ps_power_and_scale(__le16 ctr_power, __u8 scale)
 {
-	__u16 power = le16toh(ctr_power);
+	__u16 power = le16_to_cpu(ctr_power);
 
 	switch (scale & 0x3) {
 	case 0:
@@ -547,7 +547,7 @@ static void show_nvme_id_ctrl_power(struct nvme_id_ctrl *ctrl)
 
 
 	for (i = 0; i <= ctrl->npss; i++) {
-		__u16 max_power = le16toh(ctrl->psd[i].max_power);
+		__u16 max_power = le16_to_cpu(ctrl->psd[i].max_power);
 
 		printf("ps %4d : mp:", i);
 
@@ -561,7 +561,7 @@ static void show_nvme_id_ctrl_power(struct nvme_id_ctrl *ctrl)
 
 		printf("operational enlat:%d exlat:%d rrt:%d rrl:%d\n"
 			"          rwt:%d rwl:%d idle_power:",
-			le32toh(ctrl->psd[i].entry_lat), le32toh(ctrl->psd[i].exit_lat),
+			le32_to_cpu(ctrl->psd[i].entry_lat), le32_to_cpu(ctrl->psd[i].exit_lat),
 			ctrl->psd[i].read_tput, ctrl->psd[i].read_lat,
 			ctrl->psd[i].write_tput, ctrl->psd[i].write_lat);
 		print_ps_power_and_scale(ctrl->psd[i].idle_power,
@@ -578,8 +578,8 @@ void __show_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode, void (*ve
 {
 	int human = mode & HUMAN, vs = mode & VS;
 
-	printf("vid     : %#x\n", le16toh(ctrl->vid));
-	printf("ssvid   : %#x\n", le16toh(ctrl->ssvid));
+	printf("vid     : %#x\n", le16_to_cpu(ctrl->vid));
+	printf("ssvid   : %#x\n", le16_to_cpu(ctrl->ssvid));
 	printf("sn      : %-.*s\n", (int)sizeof(ctrl->sn), ctrl->sn);
 	printf("mn      : %-.*s\n", (int)sizeof(ctrl->mn), ctrl->mn);
 	printf("fr      : %-.*s\n", (int)sizeof(ctrl->fr), ctrl->fr);
@@ -590,14 +590,14 @@ void __show_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode, void (*ve
 	if (human)
 		show_nvme_id_ctrl_cmic(ctrl->cmic);
 	printf("mdts    : %d\n", ctrl->mdts);
-	printf("cntlid  : %x\n", le16toh(ctrl->cntlid));
-	printf("ver     : %x\n", le32toh(ctrl->ver));
-	printf("rtd3r   : %x\n", le32toh(ctrl->rtd3r));
-	printf("rtd3e   : %x\n", le32toh(ctrl->rtd3e));
-	printf("oaes    : %#x\n", le32toh(ctrl->oaes));
+	printf("cntlid  : %x\n", le16_to_cpu(ctrl->cntlid));
+	printf("ver     : %x\n", le32_to_cpu(ctrl->ver));
+	printf("rtd3r   : %x\n", le32_to_cpu(ctrl->rtd3r));
+	printf("rtd3e   : %x\n", le32_to_cpu(ctrl->rtd3e));
+	printf("oaes    : %#x\n", le32_to_cpu(ctrl->oaes));
 	if (human)
 		show_nvme_id_ctrl_oaes(ctrl->oaes);
-	printf("oacs    : %#x\n", le16toh(ctrl->oacs));
+	printf("oacs    : %#x\n", le16_to_cpu(ctrl->oacs));
 	if (human)
 		show_nvme_id_ctrl_oacs(ctrl->oacs);
 	printf("acl     : %d\n", ctrl->acl);
@@ -616,14 +616,14 @@ void __show_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode, void (*ve
 	printf("apsta   : %#x\n", ctrl->apsta);
 	if (human)
 		show_nvme_id_ctrl_apsta(ctrl->apsta);
-	printf("wctemp  : %d\n", le16toh(ctrl->wctemp));
-	printf("cctemp  : %d\n", le16toh(ctrl->cctemp));
-	printf("mtfa    : %d\n", le16toh(ctrl->mtfa));
-	printf("hmpre   : %d\n", le32toh(ctrl->hmpre));
-	printf("hmmin   : %d\n", le32toh(ctrl->hmmin));
+	printf("wctemp  : %d\n", le16_to_cpu(ctrl->wctemp));
+	printf("cctemp  : %d\n", le16_to_cpu(ctrl->cctemp));
+	printf("mtfa    : %d\n", le16_to_cpu(ctrl->mtfa));
+	printf("hmpre   : %d\n", le32_to_cpu(ctrl->hmpre));
+	printf("hmmin   : %d\n", le32_to_cpu(ctrl->hmmin));
 	printf("tnvmcap : %.0Lf\n", int128_to_double(ctrl->tnvmcap));
 	printf("unvmcap : %.0Lf\n", int128_to_double(ctrl->unvmcap));
-	printf("rpmbs   : %#x\n", le32toh(ctrl->rpmbs));
+	printf("rpmbs   : %#x\n", le32_to_cpu(ctrl->rpmbs));
 	if (human)
 		show_nvme_id_ctrl_rpmbs(ctrl->rpmbs);
 	printf("sqes    : %#x\n", ctrl->sqes);
@@ -632,11 +632,11 @@ void __show_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode, void (*ve
 	printf("cqes    : %#x\n", ctrl->cqes);
 	if (human)
 		show_nvme_id_ctrl_cqes(ctrl->cqes);
-	printf("nn      : %d\n", le32toh(ctrl->nn));
-	printf("oncs    : %#x\n", le16toh(ctrl->oncs));
+	printf("nn      : %d\n", le32_to_cpu(ctrl->nn));
+	printf("oncs    : %#x\n", le16_to_cpu(ctrl->oncs));
 	if (human)
 		show_nvme_id_ctrl_oncs(ctrl->oncs);
-	printf("fuses   : %#x\n", le16toh(ctrl->fuses));
+	printf("fuses   : %#x\n", le16_to_cpu(ctrl->fuses));
 	if (human)
 		show_nvme_id_ctrl_fuses(ctrl->fuses);
 	printf("fna     : %#x\n", ctrl->fna);
@@ -645,13 +645,13 @@ void __show_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode, void (*ve
 	printf("vwc     : %#x\n", ctrl->vwc);
 	if (human)
 		show_nvme_id_ctrl_vwc(ctrl->vwc);
-	printf("awun    : %d\n", le16toh(ctrl->awun));
-	printf("awupf   : %d\n", le16toh(ctrl->awupf));
+	printf("awun    : %d\n", le16_to_cpu(ctrl->awun));
+	printf("awupf   : %d\n", le16_to_cpu(ctrl->awupf));
 	printf("nvscc   : %d\n", ctrl->nvscc);
 	if (human)
 		show_nvme_id_ctrl_nvscc(ctrl->nvscc);
-	printf("acwu    : %d\n", le16toh(ctrl->acwu));
-	printf("sgls    : %x\n", le32toh(ctrl->sgls));
+	printf("acwu    : %d\n", le16_to_cpu(ctrl->acwu));
+	printf("sgls    : %x\n", le32_to_cpu(ctrl->sgls));
 	if (human)
 		show_nvme_id_ctrl_sgls(ctrl->sgls);
 
@@ -679,13 +679,13 @@ void show_error_log(struct nvme_error_log_page *err_log, int entries, const char
 	for (i = 0; i < entries; i++) {
 		printf(" Entry[%2d]   \n", i);
 		printf(".................\n");
-		printf("error_count  : %"PRIu64"\n", (uint64_t)le64toh(err_log[i].error_count));
+		printf("error_count  : %"PRIu64"\n", (uint64_t)le64_to_cpu(err_log[i].error_count));
 		printf("sqid         : %d\n", err_log[i].sqid);
 		printf("cmdid        : %#x\n", err_log[i].cmdid);
 		printf("status_field : %#x(%s)\n", err_log[i].status_field,
 			nvme_status_to_string(err_log[i].status_field >> 1));
 		printf("parm_err_loc : %#x\n", err_log[i].parm_error_location);
-		printf("lba          : %#"PRIx64"\n",(uint64_t)le64toh(err_log[i].lba));
+		printf("lba          : %#"PRIx64"\n",(uint64_t)le64_to_cpu(err_log[i].lba));
 		printf("nsid         : %#x\n", err_log[i].nsid);
 		printf("vs           : %d\n", err_log[i].vs);
 		printf(".................\n");
@@ -699,17 +699,17 @@ void show_nvme_resv_report(struct nvme_reservation_status *status)
 	regctl = status->regctl[0] | (status->regctl[1] << 8);
 
 	printf("\nNVME Reservation status:\n\n");
-	printf("gen       : %d\n", le32toh(status->gen));
+	printf("gen       : %d\n", le32_to_cpu(status->gen));
 	printf("regctl    : %d\n", regctl);
 	printf("rtype     : %d\n", status->rtype);
 	printf("ptpls     : %d\n", status->ptpls);
 
 	for (i = 0; i < regctl; i++) {
 		printf("regctl[%d] :\n", i);
-		printf("  cntlid  : %x\n", le16toh(status->regctl_ds[i].cntlid));
+		printf("  cntlid  : %x\n", le16_to_cpu(status->regctl_ds[i].cntlid));
 		printf("  rcsts   : %x\n", status->regctl_ds[i].rcsts);
-		printf("  hostid  : %"PRIx64"\n", (uint64_t)le64toh(status->regctl_ds[i].hostid));
-		printf("  rkey    : %"PRIx64"\n", (uint64_t)le64toh(status->regctl_ds[i].rkey));
+		printf("  hostid  : %"PRIx64"\n", (uint64_t)le64_to_cpu(status->regctl_ds[i].hostid));
+		printf("  rkey    : %"PRIx64"\n", (uint64_t)le64_to_cpu(status->regctl_ds[i].rkey));
 	}
 	printf("\n");
 }
@@ -784,10 +784,10 @@ void show_smart_log(struct nvme_smart_log *smart, unsigned int nsid, const char
 		int128_to_double(smart->media_errors));
 	printf("num_err_log_entries                 : %'.0Lf\n",
 		int128_to_double(smart->num_err_log_entries));
-	printf("Warning Temperature Time            : %u\n", le32toh(smart->warning_temp_time));
-	printf("Critical Composite Temperature Time : %u\n", le32toh(smart->critical_comp_time));
+	printf("Warning Temperature Time            : %u\n", le32_to_cpu(smart->warning_temp_time));
+	printf("Critical Composite Temperature Time : %u\n", le32_to_cpu(smart->critical_comp_time));
 	for (c=0; c < 8; c++) {
-		__u16 temp = le16toh(smart->temp_sensor[c]);
+		__u16 temp = le16_to_cpu(smart->temp_sensor[c]);
 		printf("Temperature Sensor %d                : %u C\n", c + 1,
 			temp ? temp - 273 : 0);
 	}
@@ -805,9 +805,9 @@ void show_intel_smart_log(struct nvme_additional_smart_log *smart, unsigned int
 		int48_to_long(smart->erase_fail_cnt.raw));
 	printf("wear_leveling                   : %3d%%       min: %u, max: %u, avg: %u\n",
 		smart->wear_leveling_cnt.norm,
-		le16toh(smart->wear_leveling_cnt.wear_level.min),
-		le16toh(smart->wear_leveling_cnt.wear_level.max),
-		le16toh(smart->wear_leveling_cnt.wear_level.avg));
+		le16_to_cpu(smart->wear_leveling_cnt.wear_level.min),
+		le16_to_cpu(smart->wear_leveling_cnt.wear_level.max),
+		le16_to_cpu(smart->wear_leveling_cnt.wear_level.avg));
 	printf("end_to_end_error_detection_count: %3d%%       %lu\n",
 		smart->e2e_err_cnt.norm,
 		int48_to_long(smart->e2e_err_cnt.raw));
@@ -1306,7 +1306,7 @@ void json_nvme_resv_report(struct nvme_reservation_status *status)
 
 	root = json_create_object();
 
-	json_object_add_value_int(root, "gen", le32toh(status->gen));
+	json_object_add_value_int(root, "gen", le32_to_cpu(status->gen));
 	json_object_add_value_int(root, "regctl", regctl);
 	json_object_add_value_int(root, "rtype", status->rtype);
 	json_object_add_value_int(root, "ptpls", status->ptpls);
@@ -1317,10 +1317,10 @@ void json_nvme_resv_report(struct nvme_reservation_status *status)
 	for (i = 0; i < regctl; i++) {
 		struct json_object *rc = json_create_object();
 
-		json_object_add_value_int(rc, "cntlid", le16toh(status->regctl_ds[i].cntlid));
+		json_object_add_value_int(rc, "cntlid", le16_to_cpu(status->regctl_ds[i].cntlid));
 		json_object_add_value_int(rc, "rcsts", status->regctl_ds[i].rcsts);
-		json_object_add_value_int(rc, "hostid", (uint64_t)le64toh(status->regctl_ds[i].hostid));
-		json_object_add_value_int(rc, "rkey", (uint64_t)le64toh(status->regctl_ds[i].rkey));
+		json_object_add_value_int(rc, "hostid", (uint64_t)le64_to_cpu(status->regctl_ds[i].hostid));
+		json_object_add_value_int(rc, "rkey", (uint64_t)le64_to_cpu(status->regctl_ds[i].rkey));
 
 		json_array_add_value_object(rcs, rc);
 	}
diff --git a/nvme.c b/nvme.c
index 66ce668..f263e50 100644
--- a/nvme.c
+++ b/nvme.c
@@ -466,10 +466,10 @@ static int list_ctrl(int argc, char **argv, struct command *cmd, struct plugin *
 
 	err = nvme_identify_ctrl_list(fd, cfg.namespace_id, cfg.cntid, cntlist);
 	if (!err) {
-		__u16 num = le16toh(cntlist->num);
+		__u16 num = le16_to_cpu(cntlist->num);
 
 		for (i = 0; i < (min(num, 2048)); i++)
-			printf("[%4u]:%#x\n", i, le16toh(cntlist->identifier[i]));
+			printf("[%4u]:%#x\n", i, le16_to_cpu(cntlist->identifier[i]));
 	}
 	else if (err > 0)
 		fprintf(stderr, "NVMe Status:%s(%x) cntid:%d\n",
diff --git a/nvme.h b/nvme.h
index 76b7576..2250e56 100644
--- a/nvme.h
+++ b/nvme.h
@@ -134,6 +134,26 @@ struct nvme_bar_cap {
 	__u8	reserved;
 };
 
+#ifdef __CHECKER__
+#define __force       __attribute__((force))
+#else
+#define __force
+#endif
+
+#define cpu_to_le16(x) \
+	((__force __le16)htole16(x))
+#define cpu_to_le32(x) \
+	((__force __le32)htole32(x))
+#define cpu_to_le64(x) \
+	((__force __le64)htole64(x))
+
+#define le16_to_cpu(x) \
+	le16toh((__force __u16)(x))
+#define le32_to_cpu(x) \
+	le32toh((__force __u32)(x))
+#define le64_to_cpu(x) \
+	le64toh((__force __u64)(x))
+
 void register_extension(struct plugin *plugin);
 
 #include "argconfig.h"
-- 
2.1.4
