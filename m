Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A10C54EAA
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jan 2023 10:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wlFSh/OciQQ9rjIWSi3nRdvi5egms/rHRCSNPaLSoYM=; b=tqCszmiXy50XcNOXsKe50tkf4D
	qqn6CJi6g2APw83h3MhJdeR/5ZmUkhvjEKv/iDTvhW33OFfpjLbXS+ZcqIyBAiHUGS88I+tUepP2z
	iVub/N78hLiYFfmWvlhfwD6jCXyQUpTGG88Kbm63kMgzNJ9JLet7+0V+GLjdLdYsn5jDhHyOgMjUl
	P/GLvqH3r33Qd4YmJCm40BWIiKKKuViSjHBbk3uPMuRO5WnAOIi836haL4iWweVgxWrLOTD5zeB7E
	3eylfx4KGCuDtKXQ+Uoy9tw5qwUtHx0tP87tQjRW5TU/C8m/nDMp7Tm6s72mdMtb2CGohc4zY6z0z
	52mTlPYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMRBd-0034wi-Lw; Mon, 30 Jan 2023 10:14:53 +0000
Received: from [2001:4bb8:19a:272a:732e:e417:47d7:2f4a] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMRBa-0034vF-VN; Mon, 30 Jan 2023 10:14:51 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	Maciej Grochowski <Maciej.Grochowski@sony.com>
Subject: [PATCH] nvme-pci: fix resume after AER recovery
Date: Mon, 30 Jan 2023 11:14:49 +0100
Message-Id: <20230130101449.1772800-1-hch@lst.de>
X-Mailer: git-send-email 2.39.0
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

All I/O on a nvme controllers hangs after injecting a malformed TLP error
using aer-inject with an error file like:

--- snip ---
AER
PCI_ID WWWW:XX.YY.Z
UNCOR_STATUS COMP_TIME
HEADER_LOG 0 1 2 3
--- snip ---

This is because in this case the ->resume method will be called after
->error_injected and not ->slot_reset, leaving the controller in disabled
state and the queue frozen.  Fix this by doing a controller reset to
resume as well.

Fixes: a0a3408ee614 ("NVMe: Add pci error handlers")
Reported-by: Maciej Grochowski <Maciej.Grochowski@sony.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Maciej Grochowski <Maciej.Grochowski@sony.com>
---
 drivers/nvme/host/pci.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c734934c407ccf..ec1e95d1a8c236 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3336,21 +3336,19 @@ static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
 	return PCI_ERS_RESULT_NEED_RESET;
 }
 
-static pci_ers_result_t nvme_slot_reset(struct pci_dev *pdev)
+static void nvme_error_resume(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
 
 	dev_info(dev->ctrl.device, "restart after slot reset\n");
 	pci_restore_state(pdev);
 	nvme_reset_ctrl(&dev->ctrl);
-	return PCI_ERS_RESULT_RECOVERED;
 }
 
-static void nvme_error_resume(struct pci_dev *pdev)
+static pci_ers_result_t nvme_slot_reset(struct pci_dev *pdev)
 {
-	struct nvme_dev *dev = pci_get_drvdata(pdev);
-
-	flush_work(&dev->ctrl.reset_work);
+	nvme_error_resume(pdev);
+	return PCI_ERS_RESULT_RECOVERED;
 }
 
 static const struct pci_error_handlers nvme_err_handler = {
-- 
2.39.0


