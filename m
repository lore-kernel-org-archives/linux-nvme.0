Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62395C25B76
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 06:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d3AwxBu+VkFli34awimWaaFVvEWHaqxKTv0UwQ9CRyc=; b=wbunHU5fyI3NTWaQHtNQIcytm7
	6EWx25sFIOkcZW2AXtL8NMscBvx8UMQ/14jMK6u4tP2A6BICFn28saEqv8pDH1y73Avpeh/pNTHqZ
	T2V1w7Jn07Uo/qWhFigIgLBxd5yXPsl7eN8rG/rd18kyymIgxWSqLOTyYZrk6uAYbOtXgXuDadprV
	IYpKpVlXm/rIJBx4oLXz72mwyBRatGx+TJeM1z5+xNoM2VWRqGX1AHF/rp/K8VBLhTEiowfaXI6XI
	2dvWiocInXJDH6inneBguBCvo1pRrdFVPUfywKK7GX+fTHd014H6cNP6CknUpNB5yPRi3uZyxUxDO
	rgtmo8pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGv3v-00000007hIK-0Mvc;
	Tue, 11 Jun 2024 06:32:55 +0000
Received: from 2a02-8389-2341-5b80-cdb4-8e7d-405d-6b77.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:cdb4:8e7d:405d:6b77] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGtvT-00000007R7j-1fbd;
	Tue, 11 Jun 2024 05:20:07 +0000
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
Subject: [PATCH 12/26] block: remove blk_flush_policy
Date: Tue, 11 Jun 2024 07:19:12 +0200
Message-ID: <20240611051929.513387-13-hch@lst.de>
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

Fold blk_flush_policy into the only caller to prepare for pending changes
to it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-flush.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index c17cf8ed8113db..2234f8b3fc05f2 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -100,23 +100,6 @@ blk_get_flush_queue(struct request_queue *q, struct blk_mq_ctx *ctx)
 	return blk_mq_map_queue(q, REQ_OP_FLUSH, ctx)->fq;
 }
 
-static unsigned int blk_flush_policy(unsigned long fflags, struct request *rq)
-{
-	unsigned int policy = 0;
-
-	if (blk_rq_sectors(rq))
-		policy |= REQ_FSEQ_DATA;
-
-	if (fflags & (1UL << QUEUE_FLAG_WC)) {
-		if (rq->cmd_flags & REQ_PREFLUSH)
-			policy |= REQ_FSEQ_PREFLUSH;
-		if (!(fflags & (1UL << QUEUE_FLAG_FUA)) &&
-		    (rq->cmd_flags & REQ_FUA))
-			policy |= REQ_FSEQ_POSTFLUSH;
-	}
-	return policy;
-}
-
 static unsigned int blk_flush_cur_seq(struct request *rq)
 {
 	return 1 << ffz(rq->flush.seq);
@@ -399,12 +382,26 @@ bool blk_insert_flush(struct request *rq)
 {
 	struct request_queue *q = rq->q;
 	unsigned long fflags = q->queue_flags;	/* may change, cache */
-	unsigned int policy = blk_flush_policy(fflags, rq);
 	struct blk_flush_queue *fq = blk_get_flush_queue(q, rq->mq_ctx);
+	unsigned int policy = 0;
 
 	/* FLUSH/FUA request must never be merged */
 	WARN_ON_ONCE(rq->bio != rq->biotail);
 
+	if (blk_rq_sectors(rq))
+		policy |= REQ_FSEQ_DATA;
+
+	/*
+	 * Check which flushes we need to sequence for this operation.
+	 */
+	if (fflags & (1UL << QUEUE_FLAG_WC)) {
+		if (rq->cmd_flags & REQ_PREFLUSH)
+			policy |= REQ_FSEQ_PREFLUSH;
+		if (!(fflags & (1UL << QUEUE_FLAG_FUA)) &&
+		    (rq->cmd_flags & REQ_FUA))
+			policy |= REQ_FSEQ_POSTFLUSH;
+	}
+
 	/*
 	 * @policy now records what operations need to be done.  Adjust
 	 * REQ_PREFLUSH and FUA for the driver.
-- 
2.43.0


