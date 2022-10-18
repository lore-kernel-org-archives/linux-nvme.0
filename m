Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF205C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Oct 2022 13:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eekyZCIfHhfYX5y+4YGgD1bvKKiVf3yXGGqVRjhh6U4=; b=HkSrogtk/Xel18eWwDfiYaY4o5
	I76MFML+Spq9ABDx2WYk67cAFWnJ0lD54/BaaTcj5/lw3IMhg9f5XMyJOaUozcbCb/EtPyNe/Yjj3
	2n/4jhKnQ6dGTuAqHeiNWMsWGmEWc6XmVhNzWFXd5YJffvqvtsOh/XZcL9Pgzsw9DrLqNzdw3QRfU
	xiMUF3ve018EsLMIVO4sR399TkUAEwdGqOB9ypuEHgBf2660vc4FwSWjhchakW5BcMSJkfY+lqw+B
	T9VRlBpU+WHSYef3k1wk1dNBKCq3O94okZ1aGX0EPNzNhD9QbNDpLbixGu06WkQmw+6JhmuEhHYnD
	ceqMAK5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okn6L-007CHC-Fh; Tue, 18 Oct 2022 13:57:49 +0000
Received: from [2001:4bb8:199:ad84:3a05:173d:d0f5:e725] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okn66-007C8I-IX; Tue, 18 Oct 2022 13:57:34 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH 3/4] nvme-pci: remove an extra queue reference
Date: Tue, 18 Oct 2022 15:57:19 +0200
Message-Id: <20221018135720.670094-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221018135720.670094-1-hch@lst.de>
References: <20221018135720.670094-1-hch@lst.de>
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

Now that blk_mq_destroy_queue does not release the queue reference, there
is no need for a second admin queue reference to be held by the nvme_dev.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 16509b8d92e59..efea468a2a5bb 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1749,7 +1749,6 @@ static void nvme_dev_remove_admin(struct nvme_dev *dev)
 		 */
 		nvme_start_admin_queue(&dev->ctrl);
 		blk_mq_destroy_queue(dev->ctrl.admin_q);
-		blk_put_queue(dev->ctrl.admin_q);
 		blk_mq_free_tag_set(&dev->admin_tagset);
 	}
 }
@@ -1778,11 +1777,6 @@ static int nvme_pci_alloc_admin_tag_set(struct nvme_dev *dev)
 		dev->ctrl.admin_q = NULL;
 		return -ENOMEM;
 	}
-	if (!blk_get_queue(dev->ctrl.admin_q)) {
-		nvme_dev_remove_admin(dev);
-		dev->ctrl.admin_q = NULL;
-		return -ENODEV;
-	}
 	return 0;
 }
 
-- 
2.30.2


