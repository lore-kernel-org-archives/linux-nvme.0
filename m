Return-Path: <SRS0=1xwY=4M=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981F8C38BE0
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2020 18:49:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C99120836
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2020 18:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PXfoEi57";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJt2omhV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C99120836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=443u9wswZSwI2MSPGpM/ye0OwEzSFQmSl1N58+EA3PA=; b=PXfoEi57OOmMgUg+b1peIZINO2
	z0TPlV4L06CO6Te/lL8N8O036USUmOxLQVpWrOhNL0kp1tQONtQuYbLpuhmqT2tRHyJJ9KX9RvcDA
	mkfFoZTG7k97/160cwU9GVeIpDmvT05kKwzNNpuvyf+Q1h7Nk3+2WMEbd26gdbjHUqxSVDz7UUxJf
	B31Mu9uOS5B9euoD+5agtFSgj033HieZr8JKN0GdzPh7/PO8wk4+lnvAK74Mz9I0fTGSA/3EjEkU/
	M/2u1nXH9D/sXjiiYdHEkXjOEzvPAXff5HvV1rJXpSaXKjGPdrKQuVTGlHFM0qzqILx+R0rjuHG+N
	GfjAz0WQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j6Inb-0007oQ-24; Mon, 24 Feb 2020 18:49:47 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j6In6-0007K7-Qr
 for linux-nvme@lists.infradead.org; Mon, 24 Feb 2020 18:49:18 +0000
Received: by mail-wr1-x442.google.com with SMTP id y17so2847709wrn.6
 for <linux-nvme@lists.infradead.org>; Mon, 24 Feb 2020 10:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=W11iLnPbdBm1gLHAvqDARl/jbqVvN2VJyZIooLfyqEQ=;
 b=SJt2omhVhigWqb6cc9B7wwGNmHQxs+Bi4jbcC6UNElEvkQeva8xQ0LoeGc+MltQSyL
 rxffKv7wVOO9EPD8jLENB/RXohAUw++PByccyqL6/xKS2Bd1g6EJBWydA3MWnjv2Oknc
 40jBkBNAnHKsA+YmGD3BgQSnZ0yo8A+0yweNBIcP9FmQFkGXX6YpyFj1jj0u1+vMuxyf
 KF0j5Vg5E/m3pRRJ3cHdEkuLkalU0OXAMgaefxM8IFldL7+4TxHy3RyerEx87Rjg/KYb
 x7AtjMpX05EXHJzm2DjZSe1PHzr4LfgUCqB5mS3wrLHVYjKdSLd5whTKL7IVx7bbNdvW
 4kCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=W11iLnPbdBm1gLHAvqDARl/jbqVvN2VJyZIooLfyqEQ=;
 b=YPG2sRulYd64z/ovHFrO2vrduhOVRHAzti/6e6Qq0fk1QSTh9NbWDRKRln0Y+HsuyM
 Zxlg4l3YNhDi/xcQx1XOx1x11Q/cHk/YcMeyJLefjH8WiMMGvf/PTY4b2rBScOd8PABB
 ene95q/EtxARZ3WYdKAgzOOC6+56DJLlURe/BP+Du1YBDDa2zsjx8pDGXTmMW7fEFKpf
 84m2gxbQGlLHYBT3wM/FLTbZPzQj/5OOwEIz2/VLsI95YWEfstBcj1fTK8QjpcL7OYOp
 ysPWuUPcLRb1F7ZnLNqJDWqyEk5IumYNQnbebdHsLVppybNlE4bPRnq5f1yS0XbNt2zD
 J3Cw==
X-Gm-Message-State: APjAAAXlTUG1YP6YphD89F7hNmK/51kVXxUvCraq6ISkRdJ90Duw3d1O
 ff/j/Z8bboqG49v33OabbasnISrD
X-Google-Smtp-Source: APXvYqy4lBf/XBPwqiIrGtmc5oNbhXXfZDa2Rui8VbHEMWxDIzrh+Qd3fMD/SMu8YK+2KR+4WqL3FQ==
X-Received: by 2002:adf:fe4d:: with SMTP id m13mr71582157wrs.179.1582570154771; 
 Mon, 24 Feb 2020 10:49:14 -0800 (PST)
Received: from localhost.localdomain.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id l8sm460047wmj.2.2020.02.24.10.49.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 24 Feb 2020 10:49:14 -0800 (PST)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [RFC 4/6] nvme: Add t_flags and pi_blkszs ctrl and ops attributes
Date: Mon, 24 Feb 2020 10:48:57 -0800
Message-Id: <20200224184859.20995-5-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200224184859.20995-1-jsmart2021@gmail.com>
References: <20200224184859.20995-1-jsmart2021@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200224_104916_958279_D9F13CD5 
X-CRM114-Status: GOOD (  25.46  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: James Smart <jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

To prepare for fabric PI support, the ops->flags handling needed to be
reworked and the addition of a new field, pi_blkszs is needed.

The nvme_ctrl_ops flags defines were moved to an enum, and values were
added to cover PI types that the host transport supports, as well as a
flag on whether the transport can insert/strip PI data for payload
received without pi data. A new field, pi_blkszs, was added. The field
parallels ns->lba_shift - each bit is a power of 2 block size, and if set,
is a block size the transport knows how to do pi operations on.

The new fields were also added to nvme_ctrl. This allows the default
values to be loaded from the ops via nvme_init_ctrl, but the transport
is allowed to tune the value on a per-controller basis if needed (directly
writes the field after nvme_init_ctrl). For example, the same transport
may have two host ports that have hw with different capabilities.

The PCI driver's ops struct was updated for the new pi flags and the
new pi_blkszs field. As all pci devices will behave the same, the ops
structure is all that needed to change.

The core code was updated to take the transport flags from the controller
rather than the ops structure.  nvme_update_disk_info() was revised to
better check the support of the transport when there is metadata.

Signed-off-by: James Smart <jsmart2021@gmail.com>

---
 I don't believe the following check, added by this patch, is necessary
 with the code in this new form. Meaning: in all cases now, if we reach this
 point, nvme_init_integrity() is called. So I don't think we need to check
 blk_get_integrity() any more.
 Please review:
  @@ -1805,12 +1806,32 @@ static void nvme_update_disk_info(struct gendisk *disk,
  ...
  +               if (!nvme_ns_has_pi(ns) && !blk_get_integrity(disk))
  +                       capacity = 0;
---
 drivers/nvme/host/core.c | 41 ++++++++++++++++++++++++++++++++---------
 drivers/nvme/host/nvme.h | 33 +++++++++++++++++++++++++++++----
 drivers/nvme/host/pci.c  |  6 +++++-
 3 files changed, 66 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8421eafa81c6..ab03311105c3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1762,6 +1762,7 @@ static bool nvme_ns_ids_equal(struct nvme_ns_ids *a, struct nvme_ns_ids *b)
 static void nvme_update_disk_info(struct gendisk *disk,
 		struct nvme_ns *ns, struct nvme_id_ns *id)
 {
+	struct nvme_ctrl *ctrl = ns->ctrl;
 	sector_t capacity = nvme_lba_to_sect(ns, le64_to_cpu(id->nsze));
 	unsigned short bs = 1 << ns->lba_shift;
 	u32 atomic_bs, phys_bs, io_opt;
@@ -1782,7 +1783,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 		if (id->nsfeat & (1 << 1) && id->nawupf)
 			atomic_bs = (1 + le16_to_cpu(id->nawupf)) * bs;
 		else
-			atomic_bs = (1 + ns->ctrl->subsys->awupf) * bs;
+			atomic_bs = (1 + ctrl->subsys->awupf) * bs;
 	} else {
 		atomic_bs = bs;
 	}
@@ -1805,12 +1806,32 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	blk_queue_io_min(disk->queue, phys_bs);
 	blk_queue_io_opt(disk->queue, io_opt);
 
-	if (ns->ms && !ns->ext &&
-	    (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
+	if (ns->ms) {
+		/*
+		 * Ensure transport supports separate metadata. If not,
+		 * only allowable configuration is with pi enabled and
+		 * using PRACT=1 or the host transport to insert/strip.
+		 */
+		if (!(ctrl->t_flags & NVME_F_METADATA_SUPPORTED) &&
+		    !nvme_ns_has_pi(ns))
+			goto set_0_capacity;
+
+		/* Check controller requirements:
+		 *  PCI requires separate metadata support.
+		 *  Fabrics do not support separate metadata.
+		 */
+		if ((!ns->ext && ctrl->t_flags & NVME_F_FABRICS) ||
+		    (ns->ext && !(ctrl->t_flags & NVME_F_FABRICS)))
+			goto set_0_capacity;
+
 		nvme_init_integrity(disk, ns->ms, ns->pi_type,
-				    ns->ctrl->max_meta_segments);
-	if ((ns->ms && !nvme_ns_has_pi(ns) && !blk_get_integrity(disk)) ||
-	    ns->lba_shift > PAGE_SHIFT)
+				    ctrl->max_meta_segments);
+
+		if (!nvme_ns_has_pi(ns) && !blk_get_integrity(disk))
+			capacity = 0;
+	}
+	if (ns->lba_shift > PAGE_SHIFT)
+set_0_capacity:
 		capacity = 0;
 
 	set_capacity(disk, capacity);
@@ -2764,7 +2785,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 			goto out_free;
 	}
 
-	if (!(ctrl->ops->flags & NVME_F_FABRICS))
+	if (!(ctrl->t_flags & NVME_F_FABRICS))
 		ctrl->cntlid = le16_to_cpu(id->cntlid);
 
 	if (!ctrl->identified) {
@@ -2848,7 +2869,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	}
 	memcpy(ctrl->psd, id->psd, sizeof(ctrl->psd));
 
-	if (ctrl->ops->flags & NVME_F_FABRICS) {
+	if (ctrl->t_flags & NVME_F_FABRICS) {
 		ctrl->icdoff = le16_to_cpu(id->icdoff);
 		ctrl->ioccsz = le32_to_cpu(id->ioccsz);
 		ctrl->iorcsz = le32_to_cpu(id->iorcsz);
@@ -3530,7 +3551,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 			|= BDI_CAP_STABLE_WRITES;
 
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, ns->queue);
-	if (ctrl->ops->flags & NVME_F_PCI_P2PDMA)
+	if (ctrl->t_flags & NVME_F_PCI_P2PDMA)
 		blk_queue_flag_set(QUEUE_FLAG_PCI_P2PDMA, ns->queue);
 
 	ns->queue->queuedata = ns;
@@ -4061,7 +4082,9 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	init_rwsem(&ctrl->namespaces_rwsem);
 	ctrl->dev = dev;
 	ctrl->ops = ops;
+	ctrl->t_flags = ops->flags;
 	ctrl->max_meta_segments = ops->max_meta_segments;
+	ctrl->pi_blkszs = ops->pi_blkszs;
 	ctrl->quirks = quirks;
 	INIT_WORK(&ctrl->scan_work, nvme_scan_work);
 	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 4c6b6fc18560..88e82250bb3d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -262,7 +262,10 @@ struct nvme_ctrl {
 	struct work_struct fw_act_work;
 	unsigned long events;
 
+	/* host transport attributes */
+	u32 t_flags;	/* transport flags: see enum nvme_transport_flags */
 	u32 max_meta_segments;
+	u32 pi_blkszs;	/* each bit is a power of 2. See ns->lba_shift */
 
 #ifdef CONFIG_NVME_MULTIPATH
 	/* asymmetric namespace access: */
@@ -402,13 +405,34 @@ static inline bool nvme_ns_has_pi(struct nvme_ns *ns)
 	return ns->pi_type && ns->ms == sizeof(struct t10_pi_tuple);
 }
 
+enum nvme_transport_flags {
+	NVME_F_FABRICS			= 1 << 0,
+	NVME_F_PCI_P2PDMA		= 1 << 1,
+
+	/* Metadata requires use of a separate blk_integrity_rq buffer */
+	NVME_F_METADATA_SUPPORTED	= 1 << 8,
+
+	/*
+	 * The PI types supported by the host transport, if it participates
+	 * in PI checking or can insert/strip PI on behalf of the OS.
+	 */
+	NVME_F_PI_TYPE_MASK		= 0x7 << 9,
+	NVME_F_PI_TYPE1_PROTECTION	= 1 << 9,
+	NVME_F_PI_TYPE2_PROTECTION	= 1 << 10,
+	NVME_F_PI_TYPE3_PROTECTION	= 1 << 11,
+
+	/* Indicates that the host transport can insert/strip PI for
+	 * presentation to the controller. I.E. OS does not have metadata/PI.
+	 * Transport will insert PI/meta on TX and strip PI/meta on RX.
+	 * Similar to PRACT=1.
+	 */
+	NVME_F_PI_TXINSERT_RXSTRIP	= 1 << 12,
+};
+
 struct nvme_ctrl_ops {
 	const char *name;
 	struct module *module;
-	unsigned int flags;
-#define NVME_F_FABRICS			(1 << 0)
-#define NVME_F_METADATA_SUPPORTED	(1 << 1)
-#define NVME_F_PCI_P2PDMA		(1 << 2)
+	unsigned int flags;		/* see enum nvme_transport_flags */
 	int (*reg_read32)(struct nvme_ctrl *ctrl, u32 off, u32 *val);
 	int (*reg_write32)(struct nvme_ctrl *ctrl, u32 off, u32 val);
 	int (*reg_read64)(struct nvme_ctrl *ctrl, u32 off, u64 *val);
@@ -417,6 +441,7 @@ struct nvme_ctrl_ops {
 	void (*delete_ctrl)(struct nvme_ctrl *ctrl);
 	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
 	u32 max_meta_segments;
+	u32 pi_blkszs;	/* each bit is a power of 2. See ns->lba_shift */
 };
 
 #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7cbd2fbda743..f56038294c23 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2683,6 +2683,9 @@ static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
 	.name			= "pcie",
 	.module			= THIS_MODULE,
 	.flags			= NVME_F_METADATA_SUPPORTED |
+				  NVME_F_PI_TYPE_MASK | /* all types presented
+							 * by the controller
+							 */
 				  NVME_F_PCI_P2PDMA,
 	.reg_read32		= nvme_pci_reg_read32,
 	.reg_write32		= nvme_pci_reg_write32,
@@ -2692,7 +2695,8 @@ static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
 	.get_address		= nvme_pci_get_address,
 	/* PCI supports metadata via single segment separate buffer only */
 	.max_meta_segments	= 1,
-
+	/* Support is whatever the controller presents */
+	.pi_blkszs		= 0xFFFFFFFF,
 };
 
 static int nvme_dev_map(struct nvme_dev *dev)
-- 
2.16.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
