Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0088C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 27 May 2022 05:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Qi4/A9D72yj54sO39rszMqoFmqCB/Rv4ZWvvDCURCkA=; b=KhbG638NzIXftFOc9/dJvNLzwD
	Ct2hUSaTGcCokzPzFRABIqUOBZ4L+tLiij8rnExa4IvLp09EHv8x0DAmbEd8PJn5D5rLITxfS+xVm
	VengyIKA/w+1YnNMTDzsDFS20DIboAr40oB+vsf9z69IZyLDMEg/GheuX7uhRxXRGJQQvjZ2YwYZ/
	08LGwcsAEkEW3fshDa8dOjfdFz4wOfR3NhDiIqaQDc5s9YByqZj3guyp87HQazrtsnqPIQYg89IPo
	Sr8B8hicp10bwjjUIKni/4wdEMgq1yaoA8/m8CZZctw4CDOj6go1OkqAC1mDThTZJIAN2cr8rvq8g
	W6KQjDKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nuSr0-00Ghm2-BQ; Fri, 27 May 2022 05:49:42 +0000
Received: from [2001:4bb8:18c:7298:b5ab:7d49:c6be:2011] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nuSqy-00GhlH-Ef; Fri, 27 May 2022 05:49:40 +0000
From: Christoph Hellwig <hch@lst.de>
To: sagi@grimberg.me,
	kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org,
	Arman Hajishafieha <arman.hajishafieha@hotmail.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH] nvme-pci: disable namespace identifiers for the MAXIO MAP1001
Date: Fri, 27 May 2022 07:49:38 +0200
Message-Id: <20220527054938.1969665-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
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

The MAXIO MAP1001 controllers reports completely bogus Namespace
identifiers that even change after suspend cycles.  Disable using
the Identifiers entirely.

Reported-by: Arman Hajishafieha <arman.hajishafieha@hotmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Tested-by: Arman Hajishafieha <arman.hajishafieha@hotmail.com>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5a98a7de09642..cb4adc0c22843 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3453,6 +3453,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0x2646, 0x2263),   /* KINGSTON A2000 NVMe SSD  */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
+	{ PCI_DEVICE(0x1e4B, 0x1001),   /* MAXIO MAP1001 */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1e4B, 0x1002),   /* MAXIO MAP1002 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1e4B, 0x1202),   /* MAXIO MAP1202 */
-- 
2.30.2


