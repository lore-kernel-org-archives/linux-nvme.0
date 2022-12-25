Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A36B0C4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Dec 2022 11:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eLMxW429k4M8LG/7EmQGDasehq5y7hCEhjY1UqeokWo=; b=oJEYv+xNddcVhQRbnLPnC/u5rT
	VyDIHRO7TmOo5GDG9DQq9nOvyzmQ6DDgn7ttTCgZJrU5yuPgA9W4kVqBP4cNbtwlg7vYgsDck4Kbw
	W61JDXDM4IXj/1zfKupPe+4/8Blx7Iw/e023jALNQOyfxaCR9pJKtS+bQ2egRYc6oIaF1x7oqdhwL
	azMD1EuAY1WssKBOrlnHgat9/dkkn0km4fbbBrWaJvK42QeEy9f4qacG67BPXAYQjcV6kxirTyueU
	kiRzSwJedu+FmP2EyG/uRruXb2xAYm4uJp8F4xsQlynPHLQJc/JCsL5u6nCYnvySBziJiORJaOnVy
	5FsijRzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9OxB-00AMqv-4t; Sun, 25 Dec 2022 11:14:05 +0000
Received: from [88.128.92.76] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9OJ9-00A2ap-QA; Sun, 25 Dec 2022 10:32:44 +0000
From: Christoph Hellwig <hch@lst.de>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Jens Axboe <axboe@fb.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hugh Dickins <hughd@google.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 2/4] nvme-pci: update sqsize when adjusting the queue depth
Date: Sun, 25 Dec 2022 11:32:32 +0100
Message-Id: <20221225103234.226794-3-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221225103234.226794-1-hch@lst.de>
References: <20221225103234.226794-1-hch@lst.de>
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

Update the core sqsize field in addition to the PCIe-specific
q_depth field as the core tagset allocation helpers rely on it.

Fixes: 0da7feaa5913 ("nvme-pci: use the tagset alloc/free helpers")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 804b6a6cb43a9c..b13baccedb4a95 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2333,10 +2333,12 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	if (dev->cmb_use_sqes) {
 		result = nvme_cmb_qdepth(dev, nr_io_queues,
 				sizeof(struct nvme_command));
-		if (result > 0)
+		if (result > 0) {
 			dev->q_depth = result;
-		else
+			dev->ctrl.sqsize = result - 1;
+		} else {
 			dev->cmb_use_sqes = false;
+		}
 	}
 
 	do {
@@ -2537,7 +2539,6 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 
 	dev->q_depth = min_t(u32, NVME_CAP_MQES(dev->ctrl.cap) + 1,
 				io_queue_depth);
-	dev->ctrl.sqsize = dev->q_depth - 1; /* 0's based queue depth */
 	dev->db_stride = 1 << NVME_CAP_STRIDE(dev->ctrl.cap);
 	dev->dbs = dev->bar + 4096;
 
@@ -2578,7 +2579,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 		dev_warn(dev->ctrl.device, "IO queue depth clamped to %d\n",
 			 dev->q_depth);
 	}
-
+	dev->ctrl.sqsize = dev->q_depth - 1; /* 0's based queue depth */
 
 	nvme_map_cmb(dev);
 
-- 
2.35.1


