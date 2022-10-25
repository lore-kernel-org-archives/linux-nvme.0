Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6024C04A95
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 14:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G18MsieJsOrNp1Fytemcz8cUlIxG4bfMDX9pF8+dvVo=; b=m1iVXEFX6I+RvF9HRe6DYL/gq4
	ELksV56vgmN0NilEOZ1W1C/uASUSPPjhNtiB826VuUVRR5tudz+bquDNmzHLUT5DsoNz/iInWNeiB
	7+dTsWMFqpapJbaCyesjI9wSQLAJt/SyCT3h8FD2y86h8cA2j76y2XqqiTaxAFJPBnDytkLVyyCqk
	G8Ji9MLmyeiIEinfvbXKzAgzRaGGORyCOke3A0DAoGhfn2x/YBFS2f+nsR6gz/UO72Io5jNv69R/a
	PyJ2xPcqAqebehV7/xHA+fmXvjYukhQDumBACWn1q8AcI4KIOumX0NLWKrhbR0Ud4+tE33m297fFp
	C/y5Gn4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onL7H-005qLl-NS; Tue, 25 Oct 2022 14:41:19 +0000
Received: from [12.47.128.130] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onL6N-005pnf-IP; Tue, 25 Oct 2022 14:40:23 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 10/17] nvme-pci: mark the namespaces dead earlier in nvme_remove
Date: Tue, 25 Oct 2022 07:40:13 -0700
Message-Id: <20221025144020.260458-11-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221025144020.260458-1-hch@lst.de>
References: <20221025144020.260458-1-hch@lst.de>
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

When we have a non-present controller there is no reason to wait in
marking the namespaces dead, so do it ASAP.  Also remove the superflous
call to nvme_start_queues as nvme_dev_disable already did that for us.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8ab54857cfd50..bef98f6e1396c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3244,25 +3244,19 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
 	pci_set_drvdata(pdev, NULL);
 
+	/*
+	 * Mark the namespaces dead as we can't flush the data, and disable the
+	 * controller ASAP as we can't shut it down properly if it was surprise
+	 * removed.
+	 */
 	if (!pci_device_is_present(pdev)) {
 		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DEAD);
+		nvme_mark_namespaces_dead(&dev->ctrl);
 		nvme_dev_disable(dev, true);
 	}
 
 	flush_work(&dev->ctrl.reset_work);
 	nvme_stop_ctrl(&dev->ctrl);
-
-	/*
-	 * The dead states indicates the controller was not gracefully
-	 * disconnected. In that case, we won't be able to flush any data while
-	 * removing the namespaces' disks; fail all the queues now to avoid
-	 * potentially having to clean up the failed sync later.
-	 */
-	if (dev->ctrl.state == NVME_CTRL_DEAD) {
-		nvme_mark_namespaces_dead(&dev->ctrl);
-		nvme_start_queues(&dev->ctrl);
-	}
-
 	nvme_remove_namespaces(&dev->ctrl);
 	nvme_dev_disable(dev, true);
 	nvme_remove_attrs(dev);
-- 
2.30.2


