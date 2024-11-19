Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75C3D44148
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Nov 2024 12:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UMJbKREIuMD5uCy3FOcLgHhasA9Umujy7x7rg1JjQ9g=; b=uSmzeQ4JLtnZNwKZ2PY6FAm1i7
	foCAlWKtyl7Ls4JRQ1bNWyGBQX3GIrBDmVYs+pOJvDYYvRmS6c/wR7V9thb51m8EyRT9/oKZtosqZ
	Qf4AlDv7h76UUSNwtx7DGDSFrOKnVDgUAzs6YWmAxYNFkAl2Ekzmd+fmzcSy7Up6nDv2VInJ8xAGs
	bFoSicB0n+LoXGLjqDpY1pDVUvI+bNPbKb3jr8mRDtbBJjpxq0HHXC1Wsja1rFHcI1PElDU06k3mi
	kmNwshFdul8l4y/HRezibSTELgPrEfe77UQbL/yqkgMztD6Dizwdfkp9t0q2J3Fvog+CD2gRGtG0b
	1QAMOqZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDNA5-0000000CIzb-0xw5;
	Tue, 19 Nov 2024 12:16:53 +0000
Received: from 2a02-8389-2341-5b80-1731-a089-d2b1-3edf.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:1731:a089:d2b1:3edf] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDNA3-0000000CIwW-20Ae;
	Tue, 19 Nov 2024 12:16:52 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Hui Qi <hui81.qi@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Jan Kara <jack@suse.cz>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH 05/15] block: req->bio is always set in the merge code
Date: Tue, 19 Nov 2024 13:16:19 +0100
Message-ID: <20241119121632.1225556-6-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241119121632.1225556-1-hch@lst.de>
References: <20241119121632.1225556-1-hch@lst.de>
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

As smatch, which is a lot smarter than me noticed.  So remove the checks
for it, and condense these checks a bit including the comments stating
the obvious.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-merge.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 64860cbd5e27..e01383c6e534 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -864,14 +864,10 @@ static struct request *attempt_merge(struct request_queue *q,
 	if (req_op(req) != req_op(next))
 		return NULL;
 
-	if (req->bio && next->bio) {
-		/* Don't merge requests with different write hints. */
-		if (req->bio->bi_write_hint != next->bio->bi_write_hint)
-			return NULL;
-		if (req->bio->bi_ioprio != next->bio->bi_ioprio)
-			return NULL;
-	}
-
+	if (req->bio->bi_write_hint != next->bio->bi_write_hint)
+		return NULL;
+	if (req->bio->bi_ioprio != next->bio->bi_ioprio)
+		return NULL;
 	if (!blk_atomic_write_mergeable_rqs(req, next))
 		return NULL;
 
@@ -983,26 +979,16 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 	if (req_op(rq) != bio_op(bio))
 		return false;
 
-	/* don't merge across cgroup boundaries */
 	if (!blk_cgroup_mergeable(rq, bio))
 		return false;
-
-	/* only merge integrity protected bio into ditto rq */
 	if (blk_integrity_merge_bio(rq->q, rq, bio) == false)
 		return false;
-
-	/* Only merge if the crypt contexts are compatible */
 	if (!bio_crypt_rq_ctx_compatible(rq, bio))
 		return false;
-
-	if (rq->bio) {
-		/* Don't merge requests with different write hints. */
-		if (rq->bio->bi_write_hint != bio->bi_write_hint)
-			return false;
-		if (rq->bio->bi_ioprio != bio->bi_ioprio)
-			return false;
-	}
-
+	if (rq->bio->bi_write_hint != bio->bi_write_hint)
+		return false;
+	if (rq->bio->bi_ioprio != bio->bi_ioprio)
+		return false;
 	if (blk_atomic_write_mergeable_rq_bio(rq, bio) == false)
 		return false;
 
-- 
2.45.2


