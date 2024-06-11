Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF4FBC27C5E
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 05:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MPwremY8Q7NX1Ef8RTwP3wepSQ5hhCHGmRWL/QC9GrI=; b=p8t3wT1frt8btLBFOr2uCYoZWl
	oLyFgqnuvTfFXC1ZAF0aE3dYjkLqLjbNVo1z/2J8bSw2xjyLfybFp9iACUHyl0SdnUlq2wf+eN1gy
	AGEticqQ7/aOrtt6HkxbNyy+Nebfa+rGr5cR6TDr57QikAzOSaNp46vTSi8TG/AY46RBPrkcxQ5I2
	U5lWLBzlIRZBod0D1Zih66WvaHdTmTy+KP5hJYaRh8NyiKsulbArtqYHq1aUvdcbFduYpkh6DoRI8
	9RDzxZGzuk6lDSAZXLYD5W9f0EDjzop3qPQNegegOEm3HiSwTX2NzymAHqcS+jgpmxSkHBkMk1xlT
	T7/MhVgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGu0b-00000007VAI-3aVd;
	Tue, 11 Jun 2024 05:25:25 +0000
Received: from 2a02-8389-2341-5b80-cdb4-8e7d-405d-6b77.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:cdb4:8e7d:405d:6b77] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGtw4-00000007Rfx-3Hsc;
	Tue, 11 Jun 2024 05:20:45 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Richard Weinberger <richard@nod.at>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Ming Lei <ming.lei@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-m68k@lists.linux-m68k.org,
	linux-um@lists.infradead.org,
	drbd-dev@lists.linbit.com,
	nbd@other.debian.org,
	linuxppc-dev@lists.ozlabs.org,
	ceph-devel@vger.kernel.org,
	virtualization@lists.linux.dev,
	xen-devel@lists.xenproject.org,
	linux-bcache@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	nvdimm@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 24/26] block: move the pci_p2pdma flag to queue_limits
Date: Tue, 11 Jun 2024 07:19:24 +0200
Message-ID: <20240611051929.513387-25-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240611051929.513387-1-hch@lst.de>
References: <20240611051929.513387-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Jun 2024 22:22:01 -0700
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

Move the pci_p2pdma flag into the queue_limits feature field so that it
can be set atomically and all I/O is frozen when changing the flag.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-debugfs.c   | 1 -
 drivers/nvme/host/core.c | 8 +++-----
 include/linux/blkdev.h   | 7 ++++---
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index f2fd72f4414ae8..8b5a68861c119b 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -90,7 +90,6 @@ static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(STATS),
 	QUEUE_FLAG_NAME(REGISTERED),
 	QUEUE_FLAG_NAME(QUIESCED),
-	QUEUE_FLAG_NAME(PCI_P2PDMA),
 	QUEUE_FLAG_NAME(RQ_ALLOC_TIME),
 	QUEUE_FLAG_NAME(HCTX_ACTIVE),
 	QUEUE_FLAG_NAME(SQ_SCHED),
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5ecf762d7c8837..31e752e8d632cd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3735,6 +3735,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 
 	if (ctrl->opts && ctrl->opts->data_digest)
 		lim.features |= BLK_FEAT_STABLE_WRITES;
+	if (ctrl->ops->supports_pci_p2pdma &&
+	    ctrl->ops->supports_pci_p2pdma(ctrl))
+		lim.features |= BLK_FEAT_PCI_P2PDMA;
 
 	disk = blk_mq_alloc_disk(ctrl->tagset, &lim, ns);
 	if (IS_ERR(disk))
@@ -3744,11 +3747,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 
 	ns->disk = disk;
 	ns->queue = disk->queue;
-
-	if (ctrl->ops->supports_pci_p2pdma &&
-	    ctrl->ops->supports_pci_p2pdma(ctrl))
-		blk_queue_flag_set(QUEUE_FLAG_PCI_P2PDMA, ns->queue);
-
 	ns->ctrl = ctrl;
 	kref_init(&ns->kref);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ffb7a42871b4ed..cc4f6e64e8e3f5 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -319,6 +319,9 @@ enum {
 
 	/* supports Zone Reset All */
 	BLK_FEAT_ZONE_RESETALL			= (1u << 11),
+
+	/* supports PCI(e) p2p requests */
+	BLK_FEAT_PCI_P2PDMA			= (1u << 12),
 };
 
 /*
@@ -588,7 +591,6 @@ struct request_queue {
 #define QUEUE_FLAG_STATS	20	/* track IO start and completion times */
 #define QUEUE_FLAG_REGISTERED	22	/* queue has been registered to a disk */
 #define QUEUE_FLAG_QUIESCED	24	/* queue has been quiesced */
-#define QUEUE_FLAG_PCI_P2PDMA	25	/* device supports PCI p2p requests */
 #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
 #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
 #define QUEUE_FLAG_SQ_SCHED     30	/* single queue style io dispatch */
@@ -611,8 +613,7 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 #define blk_queue_zone_resetall(q)	\
 	((q)->limits.features & BLK_FEAT_ZONE_RESETALL)
 #define blk_queue_dax(q)	((q)->limits.features & BLK_FEAT_DAX)
-#define blk_queue_pci_p2pdma(q)	\
-	test_bit(QUEUE_FLAG_PCI_P2PDMA, &(q)->queue_flags)
+#define blk_queue_pci_p2pdma(q)	((q)->limits.features & BLK_FEAT_PCI_P2PDMA)
 #ifdef CONFIG_BLK_RQ_ALLOC_TIME
 #define blk_queue_rq_alloc_time(q)	\
 	test_bit(QUEUE_FLAG_RQ_ALLOC_TIME, &(q)->queue_flags)
-- 
2.43.0


