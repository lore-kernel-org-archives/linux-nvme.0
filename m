Return-Path: <SRS0=8G/6=PA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C197C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 11:36:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDE9B610C9
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 11:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DDE9B610C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r9etc2gIpMK3Lpy64bwXdUUTM8L6HpGAlXyRNEKIjHY=; b=cmMEo6sUcnV3Mo
	agPmqbHYzPJQ6zZhWkdTKFrP+9z8z0zgBgASrY0wkJzhVQWQKa3TFMKjejbWlgRCIGAsEhVfiK1Xi
	Oz9jHv6xOziJGAp+ZFanEjeAZRDxu2t8NigxjoAzldEgXzbaMVp/Jue5db3/u3I/HM7a5aVjgMlkR
	RTj4zGQEY4yNG42xqKgaeJKgzVuulYm0+lR20Tl/37iK6Uv+iLf6+PjVNkSh53Cdfzd0fXHudwzMz
	JcExt/4dHGL/dMFcfP9j/WlTKs+3nfGZf7WAb5ZHtEPavN/tSweaSaZTYJBIobI0PrXOPlpWbcGs2
	KAsgUL0v2T+COkJZkIaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maG4u-00CeLk-7u; Tue, 12 Oct 2021 11:36:16 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maG2t-00Cdfq-MG
 for linux-nvme@bombadil.infradead.org; Tue, 12 Oct 2021 11:34:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=Ww+Ty4M+5zg/6wB4vhxhfQ/Y0ChJVLWnI6STKNcR1EI=; b=h359ZifKSODfVXcNXExLeBAuZ6
 owLMPSJo8jyUmWBC0YBM5UYQr/YGl+tE6ziIP58Vy9a7eJO3PllGMLVOL8HrkkWniusP2V2YpfH9s
 w8+lu7k+tZtjrc4llqDdOf5+2yQHcHaltANwPmU7pY9Xuxq+CxdhzT/Z5pAyRQZZrsctLW6sunyLF
 caJ0e3Q0r/gktJd7G+6ente47vEUPYeNvBVUFjIKyX9aemeN8fGk7QcPged9attmdHp8EVOxQ6aE8
 VajanxrWgt6HZseacppVuKFKKaiazA++atMhBBFpMDFj0EwywRbTmXFGmBFxOX87Njuc7oWZG7Iph
 as+DL7pA==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maG21-006SXv-A7; Tue, 12 Oct 2021 11:33:36 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH 16/16] nvme-multipath: enable polled I/O
Date: Tue, 12 Oct 2021 13:12:26 +0200
Message-Id: <20211012111226.760968-17-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012111226.760968-1-hch@lst.de>
References: <20211012111226.760968-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Set the poll queue flag to enable polling, given that the multipath
node just dispatches the bios to a lower queue.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Mark Wunderlich <mark.wunderlich@intel.com>
---
 drivers/nvme/host/multipath.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 4a3252651f69e..d5d7bbb1bc6ab 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -85,8 +85,13 @@ void nvme_failover_req(struct request *req)
 	}
 
 	spin_lock_irqsave(&ns->head->requeue_lock, flags);
-	for (bio = req->bio; bio; bio = bio->bi_next)
+	for (bio = req->bio; bio; bio = bio->bi_next) {
 		bio_set_dev(bio, ns->head->disk->part0);
+		if (bio->bi_opf & REQ_POLLED) {
+			bio->bi_opf &= ~REQ_POLLED;
+			bio->bi_cookie = BLK_QC_T_NONE;
+		}
+	}
 	blk_steal_bios(&ns->head->requeue_list, req);
 	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
 
@@ -479,6 +484,15 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, head->disk->queue);
 	blk_queue_flag_set(QUEUE_FLAG_NOWAIT, head->disk->queue);
+	/*
+	 * This assumes all controllers that refer to a namespace either
+	 * support poll queues or not.  That is not a strict guarantee,
+	 * but if the assumption is wrong the effect is only suboptimal
+	 * performance but not correctness problem.
+	 */
+	if (ctrl->tagset->nr_maps > HCTX_TYPE_POLL &&
+	    ctrl->tagset->map[HCTX_TYPE_POLL].nr_queues)
+		blk_queue_flag_set(QUEUE_FLAG_POLL, head->disk->queue);
 
 	/* set to a default value of 512 until the disk is validated */
 	blk_queue_logical_block_size(head->disk->queue, 512);
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
