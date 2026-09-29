Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E220DCA5FAE
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2026 11:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z9FzaE2/vE57jFZUzt6CPVImLGkzEatjHZfpe8jCTLc=; b=4RT4JCVN8AN4qd/E+CWxvame/g
	NkjI/QdImbwEtD76+xN3n1bg0KtALpoOqbiL8COIA83fLyxrphkV4FMA7g9n5m/mx60pjx5rd/j/y
	BOV//CidOmDsR/4fAc0blD7pW+5MhrTeDVAmUWSh5BgjQhFxydHXxSaRfNacbe8FcbWf3sBEtbFyd
	WUsil2laFkKmIUuidvvPuey45K4yW89vR5hpapRbNaLSlrbY19uestO9PnTf1WxO2EF74YACzYZ8I
	Aaqr+1H4xR+TGenB4UH283ysbNPwRtJPTPcdZeJaGv+u23m0gwlaj7TpEnww6e8w6qvaBywPr+Uh0
	IB2JK/yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBVqq-00000003Nzc-25Cd;
	Tue, 29 Sep 2026 11:18:24 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBVqo-00000003NyL-2IWg
	for linux-nvme@lists.infradead.org;
	Tue, 29 Sep 2026 11:18:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DC502435FB;
	Tue, 29 Sep 2026 11:18:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6261E1F00893;
	Tue, 29 Sep 2026 11:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790680701;
	bh=Z9FzaE2/vE57jFZUzt6CPVImLGkzEatjHZfpe8jCTLc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=A+hsNPpt+KqZi0h0f+QX6XZHJy14T+jHPd4fjRpAR/jNG9si/jWixW7UsJ6YboqAE
	 9w48wmozmGMxWVkl2CmWLJsG0PUlql8X4Qhedg67XgQ5DT/YlgXTmtSD3/X8l8e+q8
	 7OQ60RUFeDCFpVblYN2RzC0qcya/RWg01RgSHNF4DgouAwooYD59YkSJH0hd5/7Hay
	 nW00roAOanws78CegCKSKGwCe7Z99mPdF0zOS28YxZzBDK5TLvaXPLKb4/PdhF1Ux3
	 wchmCXVRMoRVY1kzYatxMycQWLJ022FIjAtH63JW2CMcGzCF6lPn6lvi9THk2fAKwq
	 huWekYFumbHHg==
From: Daniel Gomez <da.gomez@kernel.org>
Date: Tue, 29 Sep 2026 13:17:11 +0200
Subject: [PATCH RFC 1/2] block: add BLK_FEAT_ATOMIC_WRITE_MULTI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-nvme-mam-v1-1-48dcbe79cece@samsung.com>
References: <20260929-nvme-mam-v1-0-48dcbe79cece@samsung.com>
In-Reply-To: <20260929-nvme-mam-v1-0-48dcbe79cece@samsung.com>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Andres Freund <andres@anarazel.de>, 
 Pankaj Raghav <pankaj.raghav@linux.dev>, Daniel Gomez <da.gomez@kernel.org>, 
 GOST <gost.dev@samsung.com>, Daniel Gomez <da.gomez@samsung.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790680695; l=3935;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=yoyFUIrMHmQeQh2snWMLq7ZrNXZ8ZVDsypAM/FUTxIo=;
 b=hSczr9HuueniJU4EilQSHKKeVFV5rfSohn1WkHOEiQ+Tg5VuHOtKzcL0coVxMSvsG+V0jcomf
 qRFzS31Hk+2CPsoZmWi2HFO0yJZ3kbrZuLl467yoW2lCYArzDckVc40
X-Developer-Key: i=da.gomez@samsung.com; a=ed25519;
 pk=BqYk31UHkmv0WZShES6pIZcdmPPGay5LbzifAdZ2Ia4=
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

From: Daniel Gomez <da.gomez@samsung.com>

Add a feature flag that allows the block layer to merge atomic write
commands into larger ones that are not atomic as a whole but are later
divided by the device at the atomic write boundaries, with each subrange
treated as atomic. NVMe calls this Multiple Atomicity Mode (MAM).

When the flag is set, stop limiting merged atomic writes at
the atomic write boundary and cap them at max(max_sectors,
atomic_write_max_sectors). Each individual atomic write still fits one
boundary window and every window is written atomically by the device, so
each merged write stays untorn.

The feature flag can only be enabled when an atomic write boundary
is set.

No consumer yet, so no behavior changes.

Assisted-by: LLM
Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 block/blk-merge.c      | 9 ++++++++-
 block/blk-settings.c   | 5 +++++
 block/blk.h            | 6 +++++-
 include/linux/blkdev.h | 3 +++
 4 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 258a726071d12..e3c6aae2b3125 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -523,7 +523,14 @@ static inline unsigned int blk_rq_get_max_sectors(struct request *rq,
 	struct request_queue *q = rq->q;
 	struct queue_limits *lim = &q->limits;
 	unsigned int max_sectors, boundary_sectors;
-	bool is_atomic = rq->cmd_flags & REQ_ATOMIC;
+	/*
+	 * The merged command is itself one atomic write and must not cross the
+	 * atomic write boundary. But in the BLK_FEAT_ATOMIC_WRITE_MULTI case,
+	 * the device writes each boundary window atomically, so its merged
+	 * commands are not atomic as a whole and may cross the boundary.
+	 */
+	bool is_atomic = (rq->cmd_flags & REQ_ATOMIC) &&
+			 !(lim->features & BLK_FEAT_ATOMIC_WRITE_MULTI);
 
 	if (blk_rq_is_passthrough(rq))
 		return q->limits.max_hw_sectors;
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 1f5ee2453269f..f0488dedb0b80 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -309,6 +309,10 @@ static void blk_validate_atomic_write_limits(struct queue_limits *lim)
 
 	boundary_sectors = lim->atomic_write_hw_boundary >> SECTOR_SHIFT;
 
+	if (WARN_ON_ONCE((lim->features & BLK_FEAT_ATOMIC_WRITE_MULTI) &&
+			 !boundary_sectors))
+		lim->features &= ~BLK_FEAT_ATOMIC_WRITE_MULTI;
+
 	if (boundary_sectors) {
 		if (WARN_ON_ONCE(lim->atomic_write_hw_max >
 				 lim->atomic_write_hw_boundary))
@@ -333,6 +337,7 @@ static void blk_validate_atomic_write_limits(struct queue_limits *lim)
 	return;
 
 unsupported:
+	lim->features &= ~BLK_FEAT_ATOMIC_WRITE_MULTI;
 	lim->atomic_write_max_sectors = 0;
 	lim->atomic_write_boundary_sectors = 0;
 	lim->atomic_write_unit_min = 0;
diff --git a/block/blk.h b/block/blk.h
index 2cc03aa54c532..8d902f41d93c0 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -241,8 +241,12 @@ static inline unsigned int blk_queue_get_max_sectors(struct request *rq)
 	if (unlikely(op == REQ_OP_WRITE_ZEROES))
 		return q->limits.max_write_zeroes_sectors;
 
-	if (rq->cmd_flags & REQ_ATOMIC)
+	if (rq->cmd_flags & REQ_ATOMIC) {
+		if (q->limits.features & BLK_FEAT_ATOMIC_WRITE_MULTI)
+			return max(q->limits.max_sectors,
+				   q->limits.atomic_write_max_sectors);
 		return q->limits.atomic_write_max_sectors;
+	}
 
 	return q->limits.max_sectors;
 }
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d003a9d2d1f6c..92efd4ff67f26 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -360,6 +360,9 @@ typedef unsigned int __bitwise blk_features_t;
 #define BLK_FEAT_RAID_PARTIAL_STRIPES_EXPENSIVE \
 	((__force blk_features_t)(1u << 15))
 
+/* device writes each atomic write boundary window of a command atomically */
+#define BLK_FEAT_ATOMIC_WRITE_MULTI	((__force blk_features_t)(1u << 16))
+
 /*
  * Flags automatically inherited when stacking limits.
  */

-- 
2.55.0


