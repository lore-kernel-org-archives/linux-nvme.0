Return-Path: <SRS0=oPks=75=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C007AC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jun 2020 09:34:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E2EA20707
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jun 2020 09:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QCfpvYpA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E2EA20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ok9rM+Er4J/xUOE3tdGb7YipowrcQNt0jReL3u8tV3o=; b=QCfpvYpAqalLch
	TRLKJ6+cdFB3MFK6pknF9VS9y5Y55isv4rRU+1rVO58cBneG7hmiN6c1vF9TjfqRWKNOzDz7YyLMq
	6AQdzWB58iQOGeWGWU8J0J96uum3UFnfd8feSAxoo3+4BKmxtame4TyqOyYwGyVV/hApEOWfAfNMg
	CJ3Qh8mQPW3rcyj46yl8WIcO81UAiTBn3+HnT6kfvwfAoQUf/qx5l8Ud89VE7yZqysGQSYBTKkGX6
	7f+b6Py34L3NusRBedhypxZTLjPVWnwgI84mzId290GvowqI7CvWOJLwvuhql1xMES8+aNEu8kicp
	AwtQ/L9LPh803kyRSjDw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jl7zX-0006mp-O1; Tue, 16 Jun 2020 09:34:51 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jl7zG-0006YS-TH
 for linux-nvme@lists.infradead.org; Tue, 16 Jun 2020 09:34:41 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com) with SMTP; 16 Jun 2020 12:34:26 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 05G9YPqn030330;
 Tue, 16 Jun 2020 12:34:26 +0300
From: Max Gurtovoy <maxg@mellanox.com>
To: sagi@grimberg.me, linux-nvme@lists.infradead.org, kbusch@kernel.org,
 hch@lst.de, james.smart@broadcom.com
Subject: [PATCH 3/5 v2] nvme-pci: initialize tagset numa value to the value of
 the ctrl
Date: Tue, 16 Jun 2020 12:34:23 +0300
Message-Id: <20200616093425.169309-3-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200616093425.169309-1-maxg@mellanox.com>
References: <20200616093425.169309-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200616_023435_384555_E222F5FF 
X-CRM114-Status: UNSURE (   7.45  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Max Gurtovoy <maxg@mellanox.com>, israelr@mellanox.com,
 shlomin@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Both admin's and drive's tagsets should be set according the numa node
of the controller.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/nvme/host/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 46dc530..b1d18f0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1593,7 +1593,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 
 		dev->admin_tagset.queue_depth = NVME_AQ_MQ_TAG_DEPTH;
 		dev->admin_tagset.timeout = ADMIN_TIMEOUT;
-		dev->admin_tagset.numa_node = dev_to_node(dev->dev);
+		dev->admin_tagset.numa_node = dev->ctrl.numa_node;
 		dev->admin_tagset.cmd_size = sizeof(struct nvme_iod);
 		dev->admin_tagset.flags = BLK_MQ_F_NO_SCHED;
 		dev->admin_tagset.driver_data = dev;
@@ -2259,7 +2259,7 @@ static void nvme_dev_add(struct nvme_dev *dev)
 		if (dev->io_queues[HCTX_TYPE_POLL])
 			dev->tagset.nr_maps++;
 		dev->tagset.timeout = NVME_IO_TIMEOUT;
-		dev->tagset.numa_node = dev_to_node(dev->dev);
+		dev->tagset.numa_node = dev->ctrl.numa_node;
 		dev->tagset.queue_depth =
 				min_t(int, dev->q_depth, BLK_MQ_MAX_DEPTH) - 1;
 		dev->tagset.cmd_size = sizeof(struct nvme_iod);
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
