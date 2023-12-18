Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D4EC46CD2
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Dec 2023 17:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=myPqtwxQvKW1pEITaUvFBo4oAKeIt8E2Re9GePozAVo=; b=nVdhgbJKZcU2AGEjxGPyV/Rp8p
	ia9iSOqGaZxFAYg+iEnVm3Ag2PwUT9Da9mWNSWMug20IwyZA17jqErNUN0wZ31AnN7fAl3HN12+MH
	j86nzZfMAtCOjqxvXnMLjNfsdd2hF4tRPSS4NPen3lWWHVYyeoLwxL8vF0fkvDctlNqYvRJuoAG5l
	KBXkYBsGTXqSxxMpbF30fwNz4DbVx1K+idRs5TSIw/zJuoSygi+TYJqfoo3q1beYr1QBiqgmi3nl4
	u790Nyq1hCAM+FIBJl+DToFwp7I0WNy3POMTR8lbAfBnsyZSz5ZqZXbx56U2W5y5TU/zNvmKNo1vV
	miSpja1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFGyS-00BY0F-1U;
	Mon, 18 Dec 2023 17:00:12 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFGyJ-00BXvi-2Y
	for linux-nvme@lists.infradead.org;
	Mon, 18 Dec 2023 17:00:07 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6344F21F14;
	Mon, 18 Dec 2023 17:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702918801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=myPqtwxQvKW1pEITaUvFBo4oAKeIt8E2Re9GePozAVo=;
	b=VolPUMZE+DP93hfWUiPBmBNuVun+ni4BdgHSVfduEUFAPfFOkGgTc1A/AmghUuALGdL0gZ
	ee98LmZS1N2j2OCjowJnsxP4cCOIH0ysuaS8/PwJX1/N9XDBhYMcgSeUH1fpkEFjGxRwNm
	w9KWhJuuUftuZUc3t1jw6urdjDuj3go=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702918801;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=myPqtwxQvKW1pEITaUvFBo4oAKeIt8E2Re9GePozAVo=;
	b=D8HJ19O1CVYn98OQELgdhTBDYXAvQV0i5GCtDcf0M38VLc1K/2luAhaSx0fIhlWDAvaW9u
	PYzXjl+8SXsMuhBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702918801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=myPqtwxQvKW1pEITaUvFBo4oAKeIt8E2Re9GePozAVo=;
	b=VolPUMZE+DP93hfWUiPBmBNuVun+ni4BdgHSVfduEUFAPfFOkGgTc1A/AmghUuALGdL0gZ
	ee98LmZS1N2j2OCjowJnsxP4cCOIH0ysuaS8/PwJX1/N9XDBhYMcgSeUH1fpkEFjGxRwNm
	w9KWhJuuUftuZUc3t1jw6urdjDuj3go=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702918801;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=myPqtwxQvKW1pEITaUvFBo4oAKeIt8E2Re9GePozAVo=;
	b=D8HJ19O1CVYn98OQELgdhTBDYXAvQV0i5GCtDcf0M38VLc1K/2luAhaSx0fIhlWDAvaW9u
	PYzXjl+8SXsMuhBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4BE2C13927;
	Mon, 18 Dec 2023 17:00:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id V2qREZF6gGVMDwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 18 Dec 2023 17:00:01 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v6 3/6] nvme: refactor ns info setup function
Date: Mon, 18 Dec 2023 17:59:51 +0100
Message-ID: <20231218165954.29652-4-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218165954.29652-1-dwagner@suse.de>
References: <20231218165954.29652-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Bar: /
X-Spamd-Result: default: False [-0.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VolPUMZE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=D8HJ19O1
X-Rspamd-Queue-Id: 6344F21F14
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_090004_734474_61937076 
X-CRM114-Status: GOOD (  23.86  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Use nvme_ns_head instead of nvme_ns where possible. This reduces the
coupling between the different data structures.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/core.c | 106 +++++++++++++++++++--------------------
 drivers/nvme/host/zns.c  |  16 +++---
 2 files changed, 62 insertions(+), 60 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7be1db8caff4..e3e997a437d9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1665,14 +1665,14 @@ int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 }
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
-static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns *ns,
-				u32 max_integrity_segments)
+static void nvme_init_integrity(struct gendisk *disk,
+		struct nvme_ns_head *head, u32 max_integrity_segments)
 {
 	struct blk_integrity integrity = { };
 
-	switch (ns->head->pi_type) {
+	switch (head->pi_type) {
 	case NVME_NS_DPS_PI_TYPE3:
-		switch (ns->head->guard_type) {
+		switch (head->guard_type) {
 		case NVME_NVM_NS_16B_GUARD:
 			integrity.profile = &t10_pi_type3_crc;
 			integrity.tag_size = sizeof(u16) + sizeof(u32);
@@ -1690,7 +1690,7 @@ static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns *ns,
 		break;
 	case NVME_NS_DPS_PI_TYPE1:
 	case NVME_NS_DPS_PI_TYPE2:
-		switch (ns->head->guard_type) {
+		switch (head->guard_type) {
 		case NVME_NVM_NS_16B_GUARD:
 			integrity.profile = &t10_pi_type1_crc;
 			integrity.tag_size = sizeof(u16);
@@ -1711,26 +1711,26 @@ static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns *ns,
 		break;
 	}
 
-	integrity.tuple_size = ns->head->ms;
+	integrity.tuple_size = head->ms;
 	blk_integrity_register(disk, &integrity);
 	blk_queue_max_integrity_segments(disk->queue, max_integrity_segments);
 }
 #else
-static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns *ns,
-				u32 max_integrity_segments)
+static void nvme_init_integrity(struct gendisk *disk,
+		struct nvme_ns_head *head, u32 max_integrity_segments)
 {
 }
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
 
-static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
+static void nvme_config_discard(struct nvme_ctrl *ctrl, struct gendisk *disk,
+		struct nvme_ns_head *head)
 {
-	struct nvme_ctrl *ctrl = ns->ctrl;
 	struct request_queue *queue = disk->queue;
 	u32 size = queue_logical_block_size(queue);
 
-	if (ctrl->dmrsl && ctrl->dmrsl <= nvme_sect_to_lba(ns->head, UINT_MAX))
+	if (ctrl->dmrsl && ctrl->dmrsl <= nvme_sect_to_lba(head, UINT_MAX))
 		ctrl->max_discard_sectors =
-			nvme_lba_to_sect(ns->head, ctrl->dmrsl);
+			nvme_lba_to_sect(head, ctrl->dmrsl);
 
 	if (ctrl->max_discard_sectors == 0) {
 		blk_queue_max_discard_sectors(queue, 0);
@@ -1761,21 +1761,21 @@ static bool nvme_ns_ids_equal(struct nvme_ns_ids *a, struct nvme_ns_ids *b)
 		a->csi == b->csi;
 }
 
-static int nvme_init_ms(struct nvme_ns *ns, struct nvme_id_ns *id)
+static int nvme_init_ms(struct nvme_ctrl *ctrl, struct nvme_ns_head *head,
+		struct nvme_id_ns *id)
 {
 	bool first = id->dps & NVME_NS_DPS_PI_FIRST;
 	unsigned lbaf = nvme_lbaf_index(id->flbas);
-	struct nvme_ctrl *ctrl = ns->ctrl;
 	struct nvme_command c = { };
 	struct nvme_id_ns_nvm *nvm;
 	int ret = 0;
 	u32 elbaf;
 
-	ns->head->pi_size = 0;
-	ns->head->ms = le16_to_cpu(id->lbaf[lbaf].ms);
+	head->pi_size = 0;
+	head->ms = le16_to_cpu(id->lbaf[lbaf].ms);
 	if (!(ctrl->ctratt & NVME_CTRL_ATTR_ELBAS)) {
-		ns->head->pi_size = sizeof(struct t10_pi_tuple);
-		ns->head->guard_type = NVME_NVM_NS_16B_GUARD;
+		head->pi_size = sizeof(struct t10_pi_tuple);
+		head->guard_type = NVME_NVM_NS_16B_GUARD;
 		goto set_pi;
 	}
 
@@ -1784,11 +1784,11 @@ static int nvme_init_ms(struct nvme_ns *ns, struct nvme_id_ns *id)
 		return -ENOMEM;
 
 	c.identify.opcode = nvme_admin_identify;
-	c.identify.nsid = cpu_to_le32(ns->head->ns_id);
+	c.identify.nsid = cpu_to_le32(head->ns_id);
 	c.identify.cns = NVME_ID_CNS_CS_NS;
 	c.identify.csi = NVME_CSI_NVM;
 
-	ret = nvme_submit_sync_cmd(ns->ctrl->admin_q, &c, nvm, sizeof(*nvm));
+	ret = nvme_submit_sync_cmd(ctrl->admin_q, &c, nvm, sizeof(*nvm));
 	if (ret)
 		goto free_data;
 
@@ -1798,13 +1798,13 @@ static int nvme_init_ms(struct nvme_ns *ns, struct nvme_id_ns *id)
 	if (nvme_elbaf_sts(elbaf))
 		goto free_data;
 
-	ns->head->guard_type = nvme_elbaf_guard_type(elbaf);
-	switch (ns->head->guard_type) {
+	head->guard_type = nvme_elbaf_guard_type(elbaf);
+	switch (head->guard_type) {
 	case NVME_NVM_NS_64B_GUARD:
-		ns->head->pi_size = sizeof(struct crc64_pi_tuple);
+		head->pi_size = sizeof(struct crc64_pi_tuple);
 		break;
 	case NVME_NVM_NS_16B_GUARD:
-		ns->head->pi_size = sizeof(struct t10_pi_tuple);
+		head->pi_size = sizeof(struct t10_pi_tuple);
 		break;
 	default:
 		break;
@@ -1813,25 +1813,25 @@ static int nvme_init_ms(struct nvme_ns *ns, struct nvme_id_ns *id)
 free_data:
 	kfree(nvm);
 set_pi:
-	if (ns->head->pi_size && (first || ns->head->ms == ns->head->pi_size))
-		ns->head->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
+	if (head->pi_size && (first || head->ms == head->pi_size))
+		head->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
 	else
-		ns->head->pi_type = 0;
+		head->pi_type = 0;
 
 	return ret;
 }
 
-static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
+static int nvme_configure_metadata(struct nvme_ctrl *ctrl,
+		struct nvme_ns_head *head, struct nvme_id_ns *id)
 {
-	struct nvme_ctrl *ctrl = ns->ctrl;
 	int ret;
 
-	ret = nvme_init_ms(ns, id);
+	ret = nvme_init_ms(ctrl, head, id);
 	if (ret)
 		return ret;
 
-	ns->head->features &= ~(NVME_NS_METADATA_SUPPORTED | NVME_NS_EXT_LBAS);
-	if (!ns->head->ms || !(ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
+	head->features &= ~(NVME_NS_METADATA_SUPPORTED | NVME_NS_EXT_LBAS);
+	if (!head->ms || !(ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
 		return 0;
 
 	if (ctrl->ops->flags & NVME_F_FABRICS) {
@@ -1843,7 +1843,7 @@ static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
 		if (WARN_ON_ONCE(!(id->flbas & NVME_NS_FLBAS_META_EXT)))
 			return 0;
 
-		ns->head->features |= NVME_NS_EXT_LBAS;
+		head->features |= NVME_NS_EXT_LBAS;
 
 		/*
 		 * The current fabrics transport drivers support namespace
@@ -1854,8 +1854,8 @@ static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
 		 * Note, this check will need to be modified if any drivers
 		 * gain the ability to use other metadata formats.
 		 */
-		if (ctrl->max_integrity_segments && nvme_ns_has_pi(ns->head))
-			ns->head->features |= NVME_NS_METADATA_SUPPORTED;
+		if (ctrl->max_integrity_segments && nvme_ns_has_pi(head))
+			head->features |= NVME_NS_METADATA_SUPPORTED;
 	} else {
 		/*
 		 * For PCIe controllers, we can't easily remap the separate
@@ -1864,9 +1864,9 @@ static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
 		 * We allow extended LBAs for the passthrough interface, though.
 		 */
 		if (id->flbas & NVME_NS_FLBAS_META_EXT)
-			ns->head->features |= NVME_NS_EXT_LBAS;
+			head->features |= NVME_NS_EXT_LBAS;
 		else
-			ns->head->features |= NVME_NS_METADATA_SUPPORTED;
+			head->features |= NVME_NS_METADATA_SUPPORTED;
 	}
 	return 0;
 }
@@ -1889,18 +1889,18 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
 	blk_queue_write_cache(q, vwc, vwc);
 }
 
-static void nvme_update_disk_info(struct gendisk *disk,
-		struct nvme_ns *ns, struct nvme_id_ns *id)
+static void nvme_update_disk_info(struct nvme_ctrl *ctrl, struct gendisk *disk,
+		struct nvme_ns_head *head, struct nvme_id_ns *id)
 {
-	sector_t capacity = nvme_lba_to_sect(ns->head, le64_to_cpu(id->nsze));
-	u32 bs = 1U << ns->head->lba_shift;
+	sector_t capacity = nvme_lba_to_sect(head, le64_to_cpu(id->nsze));
+	u32 bs = 1U << head->lba_shift;
 	u32 atomic_bs, phys_bs, io_opt = 0;
 
 	/*
 	 * The block layer can't support LBA sizes larger than the page size
 	 * yet, so catch this early and don't allow block I/O.
 	 */
-	if (ns->head->lba_shift > PAGE_SHIFT) {
+	if (head->lba_shift > PAGE_SHIFT) {
 		capacity = 0;
 		bs = (1 << 9);
 	}
@@ -1917,7 +1917,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 		if (id->nsfeat & NVME_NS_FEAT_ATOMICS && id->nawupf)
 			atomic_bs = (1 + le16_to_cpu(id->nawupf)) * bs;
 		else
-			atomic_bs = (1 + ns->ctrl->subsys->awupf) * bs;
+			atomic_bs = (1 + ctrl->subsys->awupf) * bs;
 	}
 
 	if (id->nsfeat & NVME_NS_FEAT_IO_OPT) {
@@ -1943,20 +1943,20 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	 * I/O to namespaces with metadata except when the namespace supports
 	 * PI, as it can strip/insert in that case.
 	 */
-	if (ns->head->ms) {
+	if (head->ms) {
 		if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
-		    (ns->head->features & NVME_NS_METADATA_SUPPORTED))
-			nvme_init_integrity(disk, ns,
-					    ns->ctrl->max_integrity_segments);
-		else if (!nvme_ns_has_pi(ns->head))
+		    (head->features & NVME_NS_METADATA_SUPPORTED))
+			nvme_init_integrity(disk, head,
+					    ctrl->max_integrity_segments);
+		else if (!nvme_ns_has_pi(head))
 			capacity = 0;
 	}
 
 	set_capacity_and_notify(disk, capacity);
 
-	nvme_config_discard(disk, ns);
+	nvme_config_discard(ctrl, disk, head);
 	blk_queue_max_write_zeroes_sectors(disk->queue,
-					   ns->ctrl->max_zeroes_sectors);
+					   ctrl->max_zeroes_sectors);
 }
 
 static bool nvme_ns_is_readonly(struct nvme_ns *ns, struct nvme_ns_info *info)
@@ -2042,13 +2042,13 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	ns->head->lba_shift = id->lbaf[lbaf].ds;
 	nvme_set_queue_limits(ns->ctrl, ns->queue);
 
-	ret = nvme_configure_metadata(ns, id);
+	ret = nvme_configure_metadata(ns->ctrl, ns->head, id);
 	if (ret < 0) {
 		blk_mq_unfreeze_queue(ns->disk->queue);
 		goto out;
 	}
 	nvme_set_chunk_sectors(ns, id);
-	nvme_update_disk_info(ns->disk, ns, id);
+	nvme_update_disk_info(ns->ctrl, ns->disk, ns->head, id);
 
 	if (ns->head->ids.csi == NVME_CSI_ZNS) {
 		ret = nvme_update_zone_info(ns, lbaf);
@@ -2078,7 +2078,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 
 	if (nvme_ns_head_multipath(ns->head)) {
 		blk_mq_freeze_queue(ns->head->disk->queue);
-		nvme_update_disk_info(ns->head->disk, ns, id);
+		nvme_update_disk_info(ns->ctrl, ns->head->disk, ns->head, id);
 		set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
 		nvme_mpath_revalidate_paths(ns);
 		blk_stack_limits(&ns->head->disk->queue->limits,
diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index ded52ab05424..56b27aabcad9 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -148,7 +148,8 @@ static void *nvme_zns_alloc_report_buffer(struct nvme_ns *ns,
 	return NULL;
 }
 
-static int nvme_zone_parse_entry(struct nvme_ns *ns,
+static int nvme_zone_parse_entry(struct nvme_ctrl *ctrl,
+				 struct nvme_ns_head *head,
 				 struct nvme_zone_descriptor *entry,
 				 unsigned int idx, report_zones_cb cb,
 				 void *data)
@@ -156,20 +157,20 @@ static int nvme_zone_parse_entry(struct nvme_ns *ns,
 	struct blk_zone zone = { };
 
 	if ((entry->zt & 0xf) != NVME_ZONE_TYPE_SEQWRITE_REQ) {
-		dev_err(ns->ctrl->device, "invalid zone type %#x\n",
+		dev_err(ctrl->device, "invalid zone type %#x\n",
 				entry->zt);
 		return -EINVAL;
 	}
 
 	zone.type = BLK_ZONE_TYPE_SEQWRITE_REQ;
 	zone.cond = entry->zs >> 4;
-	zone.len = ns->head->zsze;
-	zone.capacity = nvme_lba_to_sect(ns->head, le64_to_cpu(entry->zcap));
-	zone.start = nvme_lba_to_sect(ns->head, le64_to_cpu(entry->zslba));
+	zone.len = head->zsze;
+	zone.capacity = nvme_lba_to_sect(head, le64_to_cpu(entry->zcap));
+	zone.start = nvme_lba_to_sect(head, le64_to_cpu(entry->zslba));
 	if (zone.cond == BLK_ZONE_COND_FULL)
 		zone.wp = zone.start + zone.len;
 	else
-		zone.wp = nvme_lba_to_sect(ns->head, le64_to_cpu(entry->wp));
+		zone.wp = nvme_lba_to_sect(head, le64_to_cpu(entry->wp));
 
 	return cb(&zone, idx, data);
 }
@@ -214,7 +215,8 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
 			break;
 
 		for (i = 0; i < nz && zone_idx < nr_zones; i++) {
-			ret = nvme_zone_parse_entry(ns, &report->entries[i],
+			ret = nvme_zone_parse_entry(ns->ctrl, ns->head,
+						    &report->entries[i],
 						    zone_idx, cb, data);
 			if (ret)
 				goto out_free;
-- 
2.43.0


