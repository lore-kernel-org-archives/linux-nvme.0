Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FFBFC6FA99
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Mar 2023 20:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Gxfk7DErXqJylOQ62Ty+VgbNgF9YFiRAze69ZvPyN6w=; b=qX9a237j+Wq+pPI2dTUB8VkRY4
	XiJKxQz+a0Niyu+50+WQYYWsbGA6ZIRQ5cjhry1DkH34ER5yF6ezF4EQsHKAq79yJuB1kqNbOwrcG
	7340V1f6VVljoTsdhw3lI9CCHiHBnjSUmqoUwjq0m4GhqnLx0ewNJmPUNwunpw/iTPOnwhtHg1kxt
	Ed0KaG8i+f6vkWU3/lV5nAVqFVlWkX/wZoDq6cos3b28n5qAnjYlGasI0wIS7nygZCEMTg8CMJbFS
	iNfeP1yAMLynlTUcxYo8C+/oXTQgeph7cHcKK5887++6iz5QGeGiIRAHIPP964UxI19H8cyM+GjLW
	I1X/QxiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZdzR-002OBl-K9; Tue, 07 Mar 2023 20:32:53 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZdzP-002O9W-32
	for linux-nvme@lists.infradead.org; Tue, 07 Mar 2023 20:32:52 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id BE990B81A16;
	Tue,  7 Mar 2023 20:32:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE08C433EF;
	Tue,  7 Mar 2023 20:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678221167;
	bh=dOTQs3qUPCCs/2oObN0aBuTrcl21WTjanP9C3iDpiNw=;
	h=From:To:Cc:Subject:Date:From;
	b=b8gZp7QE+PyHxvTNOOtZ1stvmH6lZipLHmGOjZrPqwF/uXGgLFFgFgQ8wpGlpVh11
	 bBkDFG6dLwUebSLXJusVcnneeife93sgDFzR1Z1Mt+r7odTsJgh2y85e+/MqYML8ip
	 yfRPLWc5BZI3bK6PSPcBdX1FhWRlTa4YTTxrGe4fwANjwaW6l4E48tCm3GldloB4qz
	 2Z9IVQBh8KDfRN5f/0ezwX3rz6GI4qsai8czdb7FXQ62JDuJdI+UuAloxSqrqweiWA
	 RUrMhAktDlwo2Nb/WJk0afDLRbUfOOtLCDRUHTg0KYat/ylfYDFjJoXoZOhb/jyy8W
	 tndSFbtYtw/4g==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] nvme-pci: drop redundant pci_enable_pcie_error_reporting()
Date: Tue,  7 Mar 2023 14:32:43 -0600
Message-Id: <20230307203243.882202-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230307_123251_321058_74E0D3B0 
X-CRM114-Status: GOOD (  15.26  )
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

From: Bjorn Helgaas <bhelgaas@google.com>

pci_enable_pcie_error_reporting() enables the device to send ERR_*
Messages.  Since f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is
native"), the PCI core does this for all devices during enumeration, so the
driver doesn't need to do it itself.

Remove the redundant pci_enable_pcie_error_reporting() call from the
driver.  Also remove the corresponding pci_disable_pcie_error_reporting()
from the driver .remove() path.

Note that this only controls ERR_* Messages from the device.  An ERR_*
Message may cause the Root Port to generate an interrupt, depending on the
AER Root Error Command register managed by the AER service driver.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/nvme/host/pci.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5b95c94ee40f..593f86323e25 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -5,7 +5,6 @@
  */
 
 #include <linux/acpi.h>
-#include <linux/aer.h>
 #include <linux/async.h>
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
@@ -2535,7 +2534,6 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 
 	nvme_map_cmb(dev);
 
-	pci_enable_pcie_error_reporting(pdev);
 	pci_save_state(pdev);
 
 	result = nvme_pci_configure_admin_queue(dev);
@@ -2600,10 +2598,8 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	nvme_suspend_io_queues(dev);
 	nvme_suspend_queue(dev, 0);
 	pci_free_irq_vectors(pdev);
-	if (pci_is_enabled(pdev)) {
-		pci_disable_pcie_error_reporting(pdev);
+	if (pci_is_enabled(pdev))
 		pci_disable_device(pdev);
-	}
 	nvme_reap_pending_cqes(dev);
 
 	nvme_cancel_tagset(&dev->ctrl);
-- 
2.25.1


