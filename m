Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2384ED44148
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Nov 2024 12:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QST484Rjm0qjanP7JHElr8kCM2HEOEq9yFeGtbndeP0=; b=sS6sGCwyAv8vJITpa+VIFTUMk+
	X36sfqEz/DW+4c22HlON0tjf7UjhpunhDa7Pt9uOJAWdnAQ4cV5Mr2sOGFoOC3hJVB1nmWO3fpUfn
	sKIjfxgoK69+p8DgMAjRXwbgEtME/NMUe6peG6aIsnb8UwLEktANOjX8WBh+HbnFW4/W6XicbfI2k
	czZXxpIt9vMdyZbB7T24g0FyN0Vd/9QJOhlhPx7/fnai/xR2rIMRSXb68K312ELuLQXoh6X1iBOVQ
	myBSfGhCAGDgP5wrCKNojXWRxKL2cEoz/7yoyxH8lp0V4otUVhDyJTi7o+AD+U4N1JqzL91GVbfdT
	Je4QY6VA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDNA2-0000000CIxG-2ZbZ;
	Tue, 19 Nov 2024 12:16:50 +0000
Received: from 2a02-8389-2341-5b80-1731-a089-d2b1-3edf.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:1731:a089:d2b1:3edf] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDNA0-0000000CIv8-3seG;
	Tue, 19 Nov 2024 12:16:49 +0000
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
	io-uring@vger.kernel.org
Subject: [PATCH 04/15] block: don't bother checking the data direction for merges
Date: Tue, 19 Nov 2024 13:16:18 +0100
Message-ID: <20241119121632.1225556-5-hch@lst.de>
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

Because it already is encoded in the opcode.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-merge.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index e0b28e9298c9..64860cbd5e27 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -864,9 +864,6 @@ static struct request *attempt_merge(struct request_queue *q,
 	if (req_op(req) != req_op(next))
 		return NULL;
 
-	if (rq_data_dir(req) != rq_data_dir(next))
-		return NULL;
-
 	if (req->bio && next->bio) {
 		/* Don't merge requests with different write hints. */
 		if (req->bio->bi_write_hint != next->bio->bi_write_hint)
@@ -986,10 +983,6 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 	if (req_op(rq) != bio_op(bio))
 		return false;
 
-	/* different data direction or already started, don't merge */
-	if (bio_data_dir(bio) != rq_data_dir(rq))
-		return false;
-
 	/* don't merge across cgroup boundaries */
 	if (!blk_cgroup_mergeable(rq, bio))
 		return false;
-- 
2.45.2


