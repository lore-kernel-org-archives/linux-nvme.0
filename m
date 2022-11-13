Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0486BC4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Nov 2022 16:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d4y9CJwLVJ91ugribnIUaGmc0GKqSNoJlHsWOuP77Gw=; b=p1FKGuQ74ij5bbxzz9fUM647+K
	MV4nOVdUBuBPFtuzFSJWgSVqc1msaPsiWGQFVcf+PoPfRxzN7S4cvADHsfFwxwu8npdYMHFu5bZv2
	RjpGbeI5zR/XRuQKBz0HTNrCAYtvM4L3BT8YnNSNCS/pWCef+OQ6CwdDe+e4rBaAwGvcGkIKnN458
	8iKFkzhjAQaJXNgij7+ati64xBjKB+PCtnh6Uig2s23IVGoCzLbkMt4Mg/WZYWHsa8URrtO7Z5yk9
	2kwM/OsDi6uSLISYH/cCiOAtBGUNZS2PIResRJgtKEn/mKIAfvBhyB3FFuUdxG4y0KBCjsAjmzfRS
	cEowpgfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouFb7-00CCLw-Kt; Sun, 13 Nov 2022 16:12:41 +0000
Received: from 213-225-8-167.nat.highway.a1.net ([213.225.8.167] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouFaj-00CC27-D7; Sun, 13 Nov 2022 16:12:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	asahi@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: [PATCH 09/13] nvme-pci: call nvme_pci_configure_admin_queue from nvme_pci_enable
Date: Sun, 13 Nov 2022 17:11:34 +0100
Message-Id: <20221113161138.883195-10-hch@lst.de>
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

nvme_pci_configure_admin_queue is called right after nvme_pci_enable, and
it's work is undone by nvme_dev_disable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Tested-by Gerd Bayer <gbayer@linxu.ibm.com>
---
 drivers/nvme/host/pci.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9dcb35f148009..c2e3a87237da8 100644
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


