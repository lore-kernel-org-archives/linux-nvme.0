Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F98D462B9
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 15:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t1k1en1ffmPqOLYLWn7gwg/fiy5HhmQhs9d2dWbdlh8=; b=VRwvKwraUE9SfhaAZywrm06vKU
	ePDy/0yPiRkKPgSnAU2hBAyo4Q08Scc5FPugzlX8Vt0sXUfU9uWbxAZczh8T1szay7Hg/Qyj3/gMp
	E5jmJhR/LUHqkUn0w66jogSGPNDi9f47rNdUjYVLPYiLP/Z/VvNaTlNOhyblDfZeuZfHzWrrnIxrM
	V1mR+W9wbUCM2IEC+GPd/LR8ROqlGC1qZ/iK2m2ProvGkCaIRzLma8ERawSGe6CJpO8QYOW5vr4dk
	vJ2wefwH9hO6Jg8Vf5mIy5uRQzwtHzjOziEM/qgtx3bdFTFRvq/gF2qfXsvTELF7cr1z+rdTAjIMF
	2jNsZSIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBFB9-00000007HSi-0Q23;
	Wed, 13 Nov 2024 15:21:11 +0000
Received: from 2a02-8389-2341-5b80-9e61-c6cf-2f07-a796.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:9e61:c6cf:2f07:a796] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tBFB6-00000007HPr-1ybM;
	Wed, 13 Nov 2024 15:21:09 +0000
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
Subject: [PATCH 5/6] block: don't reorder requests in blk_add_rq_to_plug
Date: Wed, 13 Nov 2024 16:20:45 +0100
Message-ID: <20241113152050.157179-6-hch@lst.de>
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

Add requests to the tail of the list instead of the front so that they
are queued up in submission order.

Remove the re-reordering in blk_mq_dispatch_plug_list, virtio_queue_rqs
and nvme_queue_rqs now that the list is ordered as expected.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c             | 4 ++--
 drivers/block/virtio_blk.c | 2 +-
 drivers/nvme/host/pci.c    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ff0b819e35fc..270cfd9fc6b0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1392,7 +1392,7 @@ static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
 	 */
 	if (!plug->has_elevator && (rq->rq_flags & RQF_SCHED_TAGS))
 		plug->has_elevator = true;
-	rq_list_add_head(&plug->mq_list, rq);
+	rq_list_add_tail(&plug->mq_list, rq);
 	plug->rq_count++;
 }
 
@@ -2844,7 +2844,7 @@ static void blk_mq_dispatch_plug_list(struct blk_plug *plug, bool from_sched)
 			rq_list_add_tail(&requeue_list, rq);
 			continue;
 		}
-		list_add(&rq->queuelist, &list);
+		list_add_tail(&rq->queuelist, &list);
 		depth++;
 	} while (!rq_list_empty(&plug->mq_list));
 
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index a19f24c19140..c0cdba71f436 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -514,7 +514,7 @@ static void virtio_queue_rqs(struct rq_list *rqlist)
 		vq = this_vq;
 
 		if (virtblk_prep_rq_batch(req))
-			rq_list_add_head(&submit_list, req); /* reverse order */
+			rq_list_add_tail(&submit_list, req);
 		else
 			rq_list_add_tail(&requeue_list, req);
 	}
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c3a00a13946d..39ba1d0c287d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -943,7 +943,7 @@ static void nvme_queue_rqs(struct rq_list *rqlist)
 		nvmeq = req->mq_hctx->driver_data;
 
 		if (nvme_prep_rq_batch(nvmeq, req))
-			rq_list_add_head(&submit_list, req); /* reverse order */
+			rq_list_add_tail(&submit_list, req);
 		else
 			rq_list_add_tail(&requeue_list, req);
 	}
-- 
2.45.2


