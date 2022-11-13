Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5167C433FE
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Nov 2022 16:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A76JdcFGl9LxRJ6UZ4vu/ALvnB2ze2HwPvZ4m1X8KwQ=; b=gtdTMAIzehpK4ZCfE/3fJoWAY3
	NkJdUNPtdalzxRV/2ZvWBzIC+F6WkbjDqTvhyvV25kW9PVGso3/BgNvPHY1/s/DwUDhe0BfAxgnvh
	/cV3RMrw9OottFVTN0jtfD9rJF7ab0+VKjFdSHkLaxOj+7LvhvE3Cdpbd48kAYlBl77WlA6jqO5kM
	qy+6mkDKZZVMqywTnX/vRw7Pns40Aqft1bCHsxwMIndEyst/uoFA62gPCu0yJGwYGzXabqYDk909z
	zPdS5PoQrHPA6Qnel7C9mQ6FK4EZdIVH+kKUroOkRAwUJNhKzkl4vdmj0vyLjG53ooVGvXUdDESDz
	ryoEKPZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouFbN-00CCWS-LA; Sun, 13 Nov 2022 16:12:57 +0000
Received: from 213-225-8-167.nat.highway.a1.net ([213.225.8.167] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouFar-00CC8M-Q5; Sun, 13 Nov 2022 16:12:26 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	asahi@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: [PATCH 11/13] nvme-pci: move the HMPRE check into nvme_setup_host_mem
Date: Sun, 13 Nov 2022 17:11:36 +0100
Message-Id: <20221113161138.883195-12-hch@lst.de>
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

Check that a HMB is wanted into the allocation helper instead of the
caller.  This makes life simpler for an upcoming second caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4da339690ec67..54e16cf1590c3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2102,6 +2102,9 @@ static int nvme_setup_host_mem(struct nvme_dev *dev)
 	u32 enable_bits = NVME_HOST_MEM_ENABLE;
 	int ret;
 
+	if (dev->ctrl.hmpre)
+		return 0;
+
 	preferred = min(preferred, max);
 	if (min > max) {
 		dev_warn(dev->ctrl.device,
@@ -2862,11 +2865,9 @@ static void nvme_reset_work(struct work_struct *work)
 
 	nvme_dbbuf_dma_alloc(dev);
 
-	if (dev->ctrl.hmpre) {
-		result = nvme_setup_host_mem(dev);
-		if (result < 0)
-			goto out;
-	}
+	result = nvme_setup_host_mem(dev);
+	if (result < 0)
+		goto out;
 
 	result = nvme_setup_io_queues(dev);
 	if (result)
-- 
2.30.2


