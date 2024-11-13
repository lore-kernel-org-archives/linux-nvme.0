Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE8B4D462BF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 15:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aBCg3s5eYCwAXZGUfBTT3Ag4k4EUgvfCKCqQqYes0aE=; b=Y8KnY6Ev5XBqDqT052UlNo4/bK
	MQIMUbrsYTVBlmmKLhIdwuGLHjcPJLt1uD+iRkwlJX1KDqGm+ck/7neqqpEk/3DuWJYvwNa7jte1s
	c2FXlTpxxk2DGJMb+MB2QS7sy6iiZT8/yK7xbG+BCpS2VCNUkAciZ0846Ab0pdHy+fGY3Z6vAO4+7
	55rNdJnkyjwBbovE2ra5UKm8dvrikrG857Z2Z8Ys7755f8SrP7WyzssWhGMFRYAFQn53TNgsKr2jw
	fYTnliCrKYsAhcmnebzYTBMlwWjHlEVD9f0xzpIuuGHoE9D0AFwd3pmqXxwGtmySLka2P8o4aVRHi
	tKUvTBOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBFB3-00000007HOY-03aZ;
	Wed, 13 Nov 2024 15:21:05 +0000
Received: from 2a02-8389-2341-5b80-9e61-c6cf-2f07-a796.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:9e61:c6cf:2f07:a796] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tBFB0-00000007HMF-2pt7;
	Wed, 13 Nov 2024 15:21:03 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-block@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	io-uring@vger.kernel.org
Subject: [PATCH 3/6] block: remove rq_list_move
Date: Wed, 13 Nov 2024 16:20:43 +0100
Message-ID: <20241113152050.157179-4-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241113152050.157179-1-hch@lst.de>
References: <20241113152050.157179-1-hch@lst.de>
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

Unused now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blk-mq.h | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index a28264442948..ad26a41d13f9 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -268,23 +268,6 @@ static inline unsigned short req_get_ioprio(struct request *req)
 #define rq_list_next(rq)	(rq)->rq_next
 #define rq_list_empty(list)	((list) == (struct request *) NULL)
 
-/**
- * rq_list_move() - move a struct request from one list to another
- * @src: The source list @rq is currently in
- * @dst: The destination list that @rq will be appended to
- * @rq: The request to move
- * @prev: The request preceding @rq in @src (NULL if @rq is the head)
- */
-static inline void rq_list_move(struct request **src, struct request **dst,
-				struct request *rq, struct request *prev)
-{
-	if (prev)
-		prev->rq_next = rq->rq_next;
-	else
-		*src = rq->rq_next;
-	rq_list_add(dst, rq);
-}
-
 /**
  * enum blk_eh_timer_return - How the timeout handler should proceed
  * @BLK_EH_DONE: The block driver completed the command or will complete it at
-- 
2.45.2


