Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B301EC4332F
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Nov 2022 15:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3NJdEwMIuRZb08nHOAvQtOg+lx3fzQPcB610bVLxc18=; b=RTIuuKTWGCm5OCCTMou7oT/V2e
	5K/BE7HT9KKIBRGEe/yAtxhpWKukNWyNfUktj06U+ytJO1DJJT4saVippzYdd0TYAiYgF187di2oL
	W5mR6TRCQFZvjco5njQ8Rgk4H/Wco7apisWyt2LxvjAw/H0RcV2+rpJWRq9lYgu/EPIPMfPayqZWw
	91ow4aEQwj9Evq+9B064TGcMW1mNBy8XxnqsGqOFcVQfC+icJ/dqgbVI0tDDIPtr4wGt3yaXEEBYg
	kSrI4TKdUFfFMtDAUQiQeNc3YcIK31++0MXqY6xwCZ7kpxVWWT+4PnhT7EbgjndMjRFr3U3bi3vy4
	HFpeUpjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osQ9q-006Cdp-OD; Tue, 08 Nov 2022 15:04:58 +0000
Received: from [2001:4bb8:191:2450:b4e6:4796:2c38:d4bf] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osQ85-006BpP-KW; Tue, 08 Nov 2022 15:03:10 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 05/12] nvme-pci: move more teardown work to nvme_remove
Date: Tue,  8 Nov 2022 16:02:45 +0100
Message-Id: <20221108150252.2123727-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221108150252.2123727-1-hch@lst.de>
References: <20221108150252.2123727-1-hch@lst.de>
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

nvme_dbbuf_dma_free frees dma coherent memory, so it must not be called
after ->remove has returned.  Fortunately there is no way to use it
after shutdown as no more I/O is possible so it can be moved.  Similarly
the iod_mempool can't be used for a device kept alive after shutdown, so
move it next to freeing the PRP pools.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f526ad578088a..b638f43f2df26 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2773,9 +2773,7 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
 {
 	struct nvme_dev *dev = to_nvme_dev(ctrl);
 
-	nvme_dbbuf_dma_free(dev);
 	nvme_free_tagset(dev);
-	mempool_destroy(dev->iod_mempool);
 	put_device(dev->dev);
 	kfree(dev->queues);
 	kfree(dev);
@@ -3227,7 +3225,9 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_dev_disable(dev, true);
 	nvme_free_host_mem(dev);
 	nvme_dev_remove_admin(dev);
+	nvme_dbbuf_dma_free(dev);
 	nvme_free_queues(dev, 0);
+	mempool_destroy(dev->iod_mempool);
 	nvme_release_prp_pools(dev);
 	nvme_dev_unmap(dev);
 	nvme_uninit_ctrl(&dev->ctrl);
-- 
2.30.2


