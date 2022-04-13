Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C83EC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Apr 2022 04:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5/HnauVdufjRnO8ObbzmRx290lutXEaoUbEi2BEnvYQ=; b=uD19TgYP/xIMbzctsoC2P4i4Z7
	5P3iYiseOU7KPzWs+XwzKXHC3oORVd86DlUns4xL/+6K/zdDjKgK7lOugNZ1SkHpzanAHHHyhsf7/
	kPAcgrDZMktCoZhwhxrtB6fC7Vo/f2Bx8yVCuhUlpluHm9LntMS6zOuYWA06B6HYiIOcPq10GKNSA
	wd7lUZ74gJE670JKmP6yhPuszUy1DpVuJEgqC0OcGKcGBQn7VaxlPvfXwTyJcHmE8iJwiLHH3P9HH
	Rbp+T6LUUAzWInhDhkeO9o+pEpuHBZghq0/jVm5/FMPjZJkmdS6XTOcmYHGTHe5nTOb3RueZvxvr7
	KnRD9B3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1neUwU-00GlbP-T7; Wed, 13 Apr 2022 04:49:22 +0000
Received: from [2a02:1205:504b:4280:f5dd:42a4:896c:d877] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1neUwP-00GlZ3-Ah; Wed, 13 Apr 2022 04:49:17 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 linux-nvme@lists.infradead.org,
 =?UTF-8?q?=E9=87=91=E9=9F=AC?= <me@kingtous.cn>
Subject: [PATCH 2/3] nvme-pci: disable namespace identifiers for the MAXIO
 MAP1002/1202
Date: Wed, 13 Apr 2022 06:49:04 +0200
Message-Id: <20220413044905.376785-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220413044905.376785-1-hch@lst.de>
References: <20220413044905.376785-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The MAXIO MAP1002/1202 controllers reports completely bogus Namespace
identifiers that even change after suspend cycles.  Disable using
the Identifiers entirely.

Reported-by: 金韬 <me@kingtous.cn>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: 金韬 <me@kingtous.cn>
---
 drivers/nvme/host/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d817ca17463ed..c45dbe8a7dcd7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3447,6 +3447,10 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0x2646, 0x2263),   /* KINGSTON A2000 NVMe SSD  */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
+	{ PCI_DEVICE(0x1e4B, 0x1002),   /* MAXIO MAP1002 */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1e4B, 0x1202),   /* MAXIO MAP1202 */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0061),
 		.driver_data = NVME_QUIRK_DMA_ADDRESS_BITS_48, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0065),
-- 
2.30.2


