Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E0BBC6FD1F
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 08:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RXv4UFOhoo/zXR8R86dhGqOSvsPBdfl/bnIzArzV6B0=; b=i7G8yxs6pWo0mnp19KLpYUGFrc
	maL0/zepEwWTLEcSBmL9bg0Z8GwG7NAvVY17igadUb3eg4OAOp5ck8vzpbyQQ6Kx2GHNjyEt/FhU5
	LYyaH+E9L2MIUQjL8mehqwQZ53GMbosIzRcslYd5Z4XifylBwv5Xosbaoob/Ry4QC2z1VVWen0ibc
	ZJUWX3aDFzemJcz0VNTVoXoHx7DPl1d2aizrYqe6DV+CV+/rrGtSOLXkB3fZhZQX0NkMpPiR9fQw+
	YVaPo5wDKzK7GfYQhZ7qDXsg16leE5k5VyRyVNXmNkanWm7KfukPIBJ2rP8Wsax8MAm2A5/d3th54
	bT5qGXvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrwD7-0000000EymY-2bZb;
	Wed, 03 Apr 2024 08:43:09 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrwCw-0000000EycM-2etd
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 08:43:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0447B61349;
	Wed,  3 Apr 2024 08:42:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A4BC43390;
	Wed,  3 Apr 2024 08:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712133777;
	bh=qXjGHVWjqr2orY91/Ggfq1GwyhXXkL7+eIYmUkoNTtc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qnocDY2nWpqIHsLzg62VbQ/9I5csk1aJLi460L3JNpSaRryb9xuRLQnu+kY2DEa3V
	 bnAXguSv80t8YnjifAleke7Lh1+9LHzJ/6omzmS4TXorzzcCU6CtOle94epM1PVHgf
	 RNFBb4hjXgs+uvDEqJxf68Y/xJLLEpylxWB0ANxfReZEdxVLSAyhcQpWh6rN5czInt
	 6memPzSMPKvCvOV4iQbDUdxQLqxlr6X0NfROoivYSmZ9ZuIcWNrkmDHr+aCR/iMR81
	 HbQoA0E+WH409bAVBmW5R3eQsiPLmeUDVT7lsZlL5ybH4U+GgVUsfNgCd5UAE14084
	 LuLZwkAPiTi7g==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 05/28] block: Allow using bio_attempt_back_merge() internally
Date: Wed,  3 Apr 2024 17:42:24 +0900
Message-ID: <20240403084247.856481-6-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403084247.856481-1-dlemoal@kernel.org>
References: <20240403084247.856481-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240403_014258_807935_BADD5284 
X-CRM114-Status: GOOD (  12.50  )
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

Remove "static" from the definition of bio_attempt_back_merge() and
declare this function in block/blk.h to allow using it internally from
other block layer files. The definition of enum bio_merge_status is
also moved to block/blk.h.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-merge.c | 8 +-------
 block/blk.h       | 8 ++++++++
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 4e3483a16b75..3363b1321908 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -972,13 +972,7 @@ static void blk_account_io_merge_bio(struct request *req)
 	part_stat_unlock();
 }
 
-enum bio_merge_status {
-	BIO_MERGE_OK,
-	BIO_MERGE_NONE,
-	BIO_MERGE_FAILED,
-};
-
-static enum bio_merge_status bio_attempt_back_merge(struct request *req,
+enum bio_merge_status bio_attempt_back_merge(struct request *req,
 		struct bio *bio, unsigned int nr_segs)
 {
 	const blk_opf_t ff = bio_failfast(bio);
diff --git a/block/blk.h b/block/blk.h
index 17786052f32d..bca50a9510c8 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -269,6 +269,14 @@ static inline void bio_integrity_free(struct bio *bio)
 unsigned long blk_rq_timeout(unsigned long timeout);
 void blk_add_timer(struct request *req);
 
+enum bio_merge_status {
+	BIO_MERGE_OK,
+	BIO_MERGE_NONE,
+	BIO_MERGE_FAILED,
+};
+
+enum bio_merge_status bio_attempt_back_merge(struct request *req,
+		struct bio *bio, unsigned int nr_segs);
 bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs);
 bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
-- 
2.44.0


