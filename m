Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E80D462B9
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 15:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RU60UgvAWZdtjyyk0hAKOkebdmlSvPmCWHzttyHTGIw=; b=asylxBlgtsN3N2699/NmlgEvux
	U/pp2oSW9vsFfbKWxHnFdVx1ETfxSCqxxhD77Doqh2gPwkvwuwGLsWuvIrpOhSKmbrKeLRo/tCN75
	cjwTHp5Y2NjpsQ1HVK7li4rKMBtVAHE0fO/YcEo86bJrMF2vJGQLsgEX4vFnfDOcKzGAQcO1uPva3
	c2NlegcLHuS/Q1PrHTfrlANAmZVZ1hnofeA4xIIa8PHG0a9I56RGTYw2AtjD5m/tle7wf41vT+UNN
	HLSVWT3xziDFkOJt9rDXw0B9+HVh8A/TNgK4X+qML3vYjm0x7IMVlZvVRpNc7IvBoDnLAy/du8LIH
	qPXHKmvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBFAz-00000007HMW-338H;
	Wed, 13 Nov 2024 15:21:01 +0000
Received: from 2a02-8389-2341-5b80-9e61-c6cf-2f07-a796.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:9e61:c6cf:2f07:a796] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tBFAx-00000007HKx-3UbT;
	Wed, 13 Nov 2024 15:21:00 +0000
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
Subject: [PATCH 2/6] virtio_blk: reverse request order in virtio_queue_rqs
Date: Wed, 13 Nov 2024 16:20:42 +0100
Message-ID: <20241113152050.157179-3-hch@lst.de>
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

blk_mq_flush_plug_list submits requests in the reverse order that they
were submitted, which leads to a rather suboptimal I/O pattern especially
in rotational devices.  Fix this by rewriting nvme_queue_rqs so that it
always pops the requests from the passed in request list, and then adds
them to the head of a local submit list.  This actually simplifies the
code a bit as it removes the complicated list splicing, at the cost of
extra updates of the rq_next pointer.  As that should be cache hot
anyway it should be an easy price to pay.

Fixes: 0e9911fa768f ("virtio-blk: support mq_ops->queue_rqs()")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/virtio_blk.c | 46 +++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 0e99a4714928..b25f7c06a28e 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -471,18 +471,18 @@ static bool virtblk_prep_rq_batch(struct request *req)
 	return virtblk_prep_rq(req->mq_hctx, vblk, req, vbr) == BLK_STS_OK;
 }
 
-static bool virtblk_add_req_batch(struct virtio_blk_vq *vq,
+static void virtblk_add_req_batch(struct virtio_blk_vq *vq,
 					struct request **rqlist)
 {
+	struct request *req;
 	unsigned long flags;
-	int err;
 	bool kick;
 
 	spin_lock_irqsave(&vq->lock, flags);
 
-	while (!rq_list_empty(*rqlist)) {
-		struct request *req = rq_list_pop(rqlist);
+	while ((req = rq_list_pop(rqlist))) {
 		struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
+		int err;
 
 		err = virtblk_add_req(vq->vq, vbr);
 		if (err) {
@@ -495,37 +495,33 @@ static bool virtblk_add_req_batch(struct virtio_blk_vq *vq,
 	kick = virtqueue_kick_prepare(vq->vq);
 	spin_unlock_irqrestore(&vq->lock, flags);
 
-	return kick;
+	if (kick)
+		virtqueue_notify(vq->vq);
 }
 
 static void virtio_queue_rqs(struct request **rqlist)
 {
-	struct request *req, *next, *prev = NULL;
+	struct request *submit_list = NULL;
 	struct request *requeue_list = NULL;
+	struct request **requeue_lastp = &requeue_list;
+	struct virtio_blk_vq *vq = NULL;
+	struct request *req;
 
-	rq_list_for_each_safe(rqlist, req, next) {
-		struct virtio_blk_vq *vq = get_virtio_blk_vq(req->mq_hctx);
-		bool kick;
-
-		if (!virtblk_prep_rq_batch(req)) {
-			rq_list_move(rqlist, &requeue_list, req, prev);
-			req = prev;
-			if (!req)
-				continue;
-		}
+	while ((req = rq_list_pop(rqlist))) {
+		struct virtio_blk_vq *this_vq = get_virtio_blk_vq(req->mq_hctx);
 
-		if (!next || req->mq_hctx != next->mq_hctx) {
-			req->rq_next = NULL;
-			kick = virtblk_add_req_batch(vq, rqlist);
-			if (kick)
-				virtqueue_notify(vq->vq);
+		if (vq && vq != this_vq)
+			virtblk_add_req_batch(vq, &submit_list);
+		vq = this_vq;
 
-			*rqlist = next;
-			prev = NULL;
-		} else
-			prev = req;
+		if (virtblk_prep_rq_batch(req))
+			rq_list_add(&submit_list, req); /* reverse order */
+		else
+			rq_list_add_tail(&requeue_lastp, req);
 	}
 
+	if (vq)
+		virtblk_add_req_batch(vq, &submit_list);
 	*rqlist = requeue_list;
 }
 
-- 
2.45.2


