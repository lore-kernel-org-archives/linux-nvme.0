Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1662C433FE
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Nov 2022 16:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xrSuVjoJKPWKossIIa7GnKFUG740em2sGVUOn5M9Gb0=; b=nGn7RWsNV4RtwTtCItV7EBxEKZ
	neBpPHzcnISJ58x03qzRCGOOnHi9/Nvvv3Y2s1Qnl8az2ipsbyhxxA9BDIKDIP4pS3KCv/+MwbQkk
	1SpTXEOvh4dbUhJm2wb5LlQMbK5zFceENLLtKdS4nvD2mT3hYbKRiG5akk5Mq9+74tmC7HlFABaY1
	9Rapo2epYv7rHPcAscq3/T54Ww6hC7jIIQ05uZBRx6zQvDsrFl2yviNS2mgTUmGGoUWVCKnBCLQDk
	BKgflsQ6hZC9gapIfOGe6LnmHF0aBtkp9UvdtcEjbHzMPE2llktjBb5tNpggxRdSjy7QvXjSmQ5rw
	x7UUFEqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1os52j-00GCvB-8U; Mon, 07 Nov 2022 16:32:13 +0000
Received: from [2001:4bb8:191:2450:bd6a:c86c:b287:8b99] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1os4s4-00G87i-Mc; Mon, 07 Nov 2022 16:21:13 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2] nvme: implement the DEAC bit for the Write Zeroes command
Date: Mon,  7 Nov 2022 17:21:08 +0100
Message-Id: <20221107162108.1777681-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

While the specification allows devices to either deallocate data
or to actually write zeroes on any Write Zeroes command, many SSDs
only do the sensible thing and deallocate data when the DEAC bit
is specific.  Set it when it is suppored and the caller doesn't
explicitly opt out of deallocation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---

Changes since v1:
 - add a sanity check that deallocate returns zeroes

 drivers/nvme/host/core.c | 13 ++++++++++++-
 drivers/nvme/host/nvme.h |  1 +
 include/linux/nvme.h     |  1 +
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f94b05c585cbc..1a87a072fbed3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -850,8 +850,11 @@ static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns,
 	cmnd->write_zeroes.length =
 		cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
 
+	if (!(req->cmd_flags & REQ_NOUNMAP) && (ns->features & NVME_NS_DEAC))
+		cmnd->write_zeroes.control |= cpu_to_le16(NVME_WZ_DEAC);
+
 	if (nvme_ns_has_pi(ns)) {
-		cmnd->write_zeroes.control = cpu_to_le16(NVME_RW_PRINFO_PRACT);
+		cmnd->write_zeroes.control |= cpu_to_le16(NVME_RW_PRINFO_PRACT);
 
 		switch (ns->pi_type) {
 		case NVME_NS_DPS_PI_TYPE1:
@@ -2003,6 +2006,14 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 		}
 	}
 
+	/*
+	 * Only set the DEAC bit if the device guarantees that reads from
+	 * deallocated data return zeroes.  While the DEAC bit does not
+	 * require that, it must be a no-op if reads from deallocated data
+	 * do not return zeroes.
+	 */
+	if ((id->dlfeat & 0x7) == 0x1 && (id->dlfeat & (1 << 3)))
+		ns->features |= NVME_NS_DEAC;
 	set_disk_ro(ns->disk, nvme_ns_is_readonly(ns, info));
 	set_bit(NVME_NS_READY, &ns->flags);
 	blk_mq_unfreeze_queue(ns->disk->queue);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f9df10653f3c5..16b34a4914959 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -455,6 +455,7 @@ static inline bool nvme_ns_head_multipath(struct nvme_ns_head *head)
 enum nvme_ns_features {
 	NVME_NS_EXT_LBAS = 1 << 0, /* support extended LBA format */
 	NVME_NS_METADATA_SUPPORTED = 1 << 1, /* support getting generated md */
+	NVME_NS_DEAC,		/* DEAC bit in Write Zeores supported */
 };
 
 struct nvme_ns {
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 050d7d0cd81b0..c96930b2c28fe 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -963,6 +963,7 @@ enum {
 	NVME_RW_PRINFO_PRCHK_GUARD	= 1 << 12,
 	NVME_RW_PRINFO_PRACT		= 1 << 13,
 	NVME_RW_DTYPE_STREAMS		= 1 << 4,
+	NVME_WZ_DEAC			= 1 << 9,
 };
 
 struct nvme_dsm_cmd {
-- 
2.30.2


