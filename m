Return-Path: <SRS0=jeJI=MB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14B4C07E99
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jul 2021 08:13:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54D1E613C8
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jul 2021 08:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D1E613C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Tu4KwH+TDPggpS54c+wOGRtCBjE0d9VTqaA6f9xjBSI=; b=asygWG9Ne0lZAw
	1DAKk4LuM46Iu2REQJ3jmO/Oz0dk0YRIYlWZsS3OqudnIFLRkla8YMQy0M6+sW61W5iT8RNMGQCp5
	8cWkPokRtxtZJClQrIkRPhu0ZLbuUttnrrb6705iuwWXyoF+2ZGPCx52omAt9NbkyXYv/t3VJ+eFR
	M7y5B8/pXe5wJeTW3K680FifJ254r+KXl88iK0Di/bEX6PDmpN+2p8w2Untq/r1JkE8wGbqqz4Y0S
	+kME+785UEr2d+4PPJ1A2wbj2JaBWCI2Ac+cKYGTjARMzLeLovGkaKQ1zeRdtC9YAiDIP9Nl6GvBe
	zmwzJRaZX0wkjk7RcAbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m1ld4-0014fB-F6; Fri, 09 Jul 2021 08:12:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m1lba-00141b-4j
 for linux-nvme@lists.infradead.org; Fri, 09 Jul 2021 08:11:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625818285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2pWtjFqz4jcPDiQr4SNjA0YIVAycnQdj9d42Z4ShVyU=;
 b=XQJXUGo7iwWPEaCDI6qIS063jurqMdTxIW+E+fyJXMyQ5iu8dkRF872G0VXPRd6toY7+jG
 Z8rDoiTtXoA8Qkki9VT6JqvZtjD/lCK2rASFW6NPk1XqoKrJWuacobhWVTBV3mn5EvjYZ1
 luN58oXwttBMTr9iZ9wrO4Gj2p/Kxkk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-9u95PXq0PKmRu83R5m5DqA-1; Fri, 09 Jul 2021 04:11:23 -0400
X-MC-Unique: 9u95PXq0PKmRu83R5m5DqA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD89C8042FE;
 Fri,  9 Jul 2021 08:11:21 +0000 (UTC)
Received: from localhost (ovpn-13-13.pek2.redhat.com [10.72.13.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0E73B5D6D3;
 Fri,  9 Jul 2021 08:11:20 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>, John Garry <john.garry@huawei.com>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 Damien Le Moal <damien.lemoal@wdc.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 08/10] nvme: rdma: replace blk_mq_rdma_map_queues with
 blk_mq_dev_map_queues
Date: Fri,  9 Jul 2021 16:10:03 +0800
Message-Id: <20210709081005.421340-9-ming.lei@redhat.com>
In-Reply-To: <20210709081005.421340-1-ming.lei@redhat.com>
References: <20210709081005.421340-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210709_011126_307998_197383A1 
X-CRM114-Status: GOOD (  14.84  )
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

Replace blk_mq_virtio_map_queues with blk_mq_dev_map_queues which is more
generic from blk-mq viewpoint, so we can unify all map queue
implementation.

Meantime we can pass 'use_manage_irq' info to blk-mq via
blk_mq_dev_map_queues(), this info needn't be 100% accurate, and what
we need is that true has to be passed in if the hba really uses managed
irq.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/rdma.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index a9e70cefd7ed..dc47df03a39a 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2169,6 +2169,14 @@ static void nvme_rdma_complete_rq(struct request *rq)
 	nvme_complete_rq(rq);
 }
 
+static const struct cpumask *nvme_rdma_get_queue_affinity(
+		void *dev_data, int offset, int queue)
+{
+	struct ib_device *dev = dev_data;
+
+	return ib_get_vector_affinity(dev, offset + queue);
+}
+
 static int nvme_rdma_map_queues(struct blk_mq_tag_set *set)
 {
 	struct nvme_rdma_ctrl *ctrl = set->driver_data;
@@ -2192,10 +2200,12 @@ static int nvme_rdma_map_queues(struct blk_mq_tag_set *set)
 			ctrl->io_queues[HCTX_TYPE_DEFAULT];
 		set->map[HCTX_TYPE_READ].queue_offset = 0;
 	}
-	blk_mq_rdma_map_queues(&set->map[HCTX_TYPE_DEFAULT],
-			ctrl->device->dev, 0);
-	blk_mq_rdma_map_queues(&set->map[HCTX_TYPE_READ],
-			ctrl->device->dev, 0);
+	blk_mq_dev_map_queues(&set->map[HCTX_TYPE_DEFAULT],
+			ctrl->device->dev, 0, nvme_rdma_get_queue_affinity,
+			true, false);
+	blk_mq_dev_map_queues(&set->map[HCTX_TYPE_READ],
+			ctrl->device->dev, 0, nvme_rdma_get_queue_affinity,
+			true, false);
 
 	if (opts->nr_poll_queues && ctrl->io_queues[HCTX_TYPE_POLL]) {
 		/* map dedicated poll queues only if we have queues left */
-- 
2.31.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
