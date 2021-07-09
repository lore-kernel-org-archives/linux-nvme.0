Return-Path: <SRS0=jeJI=MB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F07C07E9B
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jul 2021 08:12:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9415F613C7
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jul 2021 08:12:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9415F613C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=81kzXhI/ckcg3TIX0jKBBaSXxrscxC9HaGSDLhwh9Ew=; b=17m3P5luNn9Wa6
	Fo6PJyuhR1w9oVsr8dRTNbFJYo4+rKIcFB14mImv4DJrEL/et0WP9cvtx+q7bCQQtITi6PWU/PHzW
	iZXttQkd54j04NkeSuC/5EA49+J4n7AVEUMSigjfobgIo+r2MqOVq+S64+nBFmkKHlnjh9ZwSF1G9
	iOISkEjUs3XHHGV6yJ4e9xTynWkc2VAdUE0ZWx39AfJG+0E+VdiE1N+72BABvPf6PEu7gSn8tmP+z
	jh4RHBi+EffUZDQgw0bt7WtB921ZFKzV29qyBeVIkSxcrJ+BAkDYf/dm11VyTE5sBhSTGaP3Emn7h
	sPFuRXuRddfDYWsjBBOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m1lc3-0014Fg-Mj; Fri, 09 Jul 2021 08:11:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m1lbN-0013uE-K3
 for linux-nvme@lists.infradead.org; Fri, 09 Jul 2021 08:11:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625818272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jm4OK+kJW+IbN57HQi1K1eGMDSFWIwNIJiAc3mqthkg=;
 b=EKirPiWchIGibzGnnPBlBoJT8PiupdupBjisDmrcc+L2BmwRqtLwPO827Y1izIMRemmTbE
 odw+9lXQpZdZqdKTpUItQxgiIPgYo1nPi1lc7VIDP5FVSTFJe+qA3A+B6ki5fQdYnKJw18
 MOXb7wvbc+m/QfEStMl4J5vVKro7QQQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-wEX9Y4jMMsSWbad_rSB2pQ-1; Fri, 09 Jul 2021 04:11:08 -0400
X-MC-Unique: wEX9Y4jMMsSWbad_rSB2pQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 054061007273;
 Fri,  9 Jul 2021 08:11:07 +0000 (UTC)
Received: from localhost (ovpn-13-13.pek2.redhat.com [10.72.13.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 30F031346F;
 Fri,  9 Jul 2021 08:11:05 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>, John Garry <john.garry@huawei.com>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 Damien Le Moal <damien.lemoal@wdc.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 05/10] nvme: replace blk_mq_pci_map_queues with
 blk_mq_dev_map_queues
Date: Fri,  9 Jul 2021 16:10:00 +0800
Message-Id: <20210709081005.421340-6-ming.lei@redhat.com>
In-Reply-To: <20210709081005.421340-1-ming.lei@redhat.com>
References: <20210709081005.421340-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210709_011113_795795_1221479A 
X-CRM114-Status: GOOD (  15.50  )
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

Replace blk_mq_pci_map_queues with blk_mq_dev_map_queues which is more
generic from blk-mq viewpoint, so we can unify all map queue via
blk_mq_dev_map_queues().

Meantime we can pass 'use_manage_irq' info to blk-mq via
blk_mq_dev_map_queues(), this info needn't be 100% accurate, and what
we need is that true has to be passed in if the hba really uses managed
irq.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/pci.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d3c5086673bc..d16ba661560d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -433,6 +433,14 @@ static int nvme_init_request(struct blk_mq_tag_set *set, struct request *req,
 	return 0;
 }
 
+static const struct cpumask *nvme_pci_get_queue_affinity(
+		void *dev_data, int offset, int queue)
+{
+	struct pci_dev *pdev = dev_data;
+
+	return pci_irq_get_affinity(pdev, offset + queue);
+}
+
 static int queue_irq_offset(struct nvme_dev *dev)
 {
 	/* if we have more than 1 vec, admin queue offsets us by 1 */
@@ -463,7 +471,9 @@ static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
 		 */
 		map->queue_offset = qoff;
 		if (i != HCTX_TYPE_POLL && offset)
-			blk_mq_pci_map_queues(map, to_pci_dev(dev->dev), offset);
+			blk_mq_dev_map_queues(map, to_pci_dev(dev->dev), offset,
+					nvme_pci_get_queue_affinity, false,
+					true);
 		else
 			blk_mq_map_queues(map);
 		qoff += map->nr_queues;
-- 
2.31.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
