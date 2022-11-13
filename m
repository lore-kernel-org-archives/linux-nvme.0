Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD3B2C4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Nov 2022 16:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z/496XWmLG04QR1nhtjNp6iP9ePF3Za9i6CLzDD5GF8=; b=SD0zDEAhV1xVkftORfH/KUMHrx
	4QrK4o9ibHXsNdG1tC9P2+iVRrJ6B690T9wOTJ+aEg77m3Gmxh8pNWQgccX27aYNplqlzSHN+Xvj9
	a0VkVyyzpa7CHjQPSIv6yAlq5tXWn1eIFHhjHB9hurfdONlOWrGPgyZgYfhgYPAdbpJEa6nyruvgI
	cXcLOLYwnQHBvgXCu0vIaiKEdiK+aWbJDggjuS1bjvhto0If7kiHAFhWqSeBtlNcQZ0lirtzzCnU5
	D7U9TW1UR7qlfS27rH1huUsqxuMyMds/UkRFkK4ROlyGRGzh7LAQzfPn8uwZG8tjSOLxzq9XxEbMX
	te8MZl6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouFac-00CBzZ-EI; Sun, 13 Nov 2022 16:12:10 +0000
Received: from 213-225-8-167.nat.highway.a1.net ([213.225.8.167] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouFaS-00CBsj-Px; Sun, 13 Nov 2022 16:12:01 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	asahi@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: [PATCH 05/13] nvme-pci: move more teardown work to nvme_remove
Date: Sun, 13 Nov 2022 17:11:30 +0100
Message-Id: <20221113161138.883195-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221113161138.883195-1-hch@lst.de>
References: <20221113161138.883195-1-hch@lst.de>
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
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Tested-by Gerd Bayer <gbayer@linxu.ibm.com>
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


