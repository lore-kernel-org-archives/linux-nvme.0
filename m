Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB0ACC4332F
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Nov 2022 15:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mv9bQ7ZmAARDju/NAsXvF40fcOwLRcYL+Jwo+Wq3egA=; b=o99a43wUuQ3XOSMCwaiq7a7Kla
	ndSLvRK6IF2UZBNoe67bbHkJ2Lkjn723wIhxB/hSi0OOIQUqeO2TEpCNmKdRJWbBOeAaom36w6/UF
	ZaqGtqUzJWMj3MWsHRi5EfRq/TtW6F2VkvMVKZ9pyHnW4LJ8bcGbUoFb/BPYmQAmF3/vcJ90u3Z40
	Z8aw+9x0wfcUq5TM9ahfXFqJKXSGXBaJ1TLuuJlG15Ox3+x9I30qf6819vbyOq9gL+qol07n1b16O
	Hi+UVG4zM78OB1wPBsYEsL/K7t+8DzKMKa9nmZXlH6qeRukJxbvtVe4tYOCHdlDMJXgDwXhXmrVsz
	7X2p4fDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osQBk-006DwD-EJ; Tue, 08 Nov 2022 15:06:56 +0000
Received: from [2001:4bb8:191:2450:b4e6:4796:2c38:d4bf] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osQ8G-006Bsv-Ia; Tue, 08 Nov 2022 15:03:21 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 09/12] nvme-pci: call nvme_pci_configure_admin_queue from nvme_pci_enable
Date: Tue,  8 Nov 2022 16:02:49 +0100
Message-Id: <20221108150252.2123727-10-hch@lst.de>
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

nvme_pci_configure_admin_queue is called right after nvme_pci_enable, and
it's work is undone by nvme_dev_disable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 87f7c8f5699ec..64e2bd2d4f61e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2639,7 +2639,8 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 
 	pci_enable_pcie_error_reporting(pdev);
 	pci_save_state(pdev);
-	return 0;
+
+	return nvme_pci_configure_admin_queue(dev);
 
  disable:
 	pci_disable_device(pdev);
@@ -2829,10 +2830,6 @@ static void nvme_reset_work(struct work_struct *work)
 	if (result)
 		goto out_unlock;
 
-	result = nvme_pci_configure_admin_queue(dev);
-	if (result)
-		goto out_unlock;
-
 	if (!dev->ctrl.admin_q) {
 		result = nvme_pci_alloc_admin_tag_set(dev);
 		if (result)
-- 
2.30.2


