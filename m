Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2150C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Apr 2022 06:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AKl9JXUfxxF+9EOmQrMmSR3FidgpF623X4KAy/06rp8=; b=XIUYLPo8KUqGyX4XFKPgG74kHW
	exlHqvIkFl81qwlKmGBCgbT3ZQFLyKygWCXNEwsSUYEMtWkwwvzA4fAED3nzMzfo+f2Besuyr51j7
	pKUFfZkTONROnYml4k6x1JRrwxtLGrc3k2kNbZJHckHxiReSilDa7DeFdxXdTeFUhOHh9UedCm27+
	e1V7+3CAzc27p6mcb8SI5WWPe4GVX+HL1jzRiJib9A6gMb7nnl+Xf87/oXLq19ftxiUnV4O8KmBgE
	rVFaaKhu3gCAMZWc31qz9Opxj/Z/jQ7DFIdmqw5wTuhBndMyfEyD8JOk3dskDRFyn+fxVp+VQkzu6
	wk0gynyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ne9kZ-00BotE-CW; Tue, 12 Apr 2022 06:11:39 +0000
Received: from [2001:4bb8:18e:76f5:73f2:2aba:795d:ae99] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ne9kU-00Boqz-LQ; Tue, 12 Apr 2022 06:11:35 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 linux-nvme@lists.infradead.org,
 =?UTF-8?q?=E9=87=91=E9=9F=AC?= <me@kingtous.cn>
Subject: [PATCH 2/3] nvme-pci: disable namespace identifiers for the MAXIO
 MAP1202
Date: Tue, 12 Apr 2022 08:11:25 +0200
Message-Id: <20220412061126.244414-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220412061126.244414-1-hch@lst.de>
References: <20220412061126.244414-1-hch@lst.de>
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

The MAXIO MAP1202 controllers reports completely bogus Namespace
identifiers that even change after suspend cycles.  Disable using
the Identifiers entirely.

Reported-by: 金韬 <me@kingtous.cn>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: 金韬 <me@kingtous.cn>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d817ca17463ed..c386c91483505 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3447,6 +3447,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0x2646, 0x2263),   /* KINGSTON A2000 NVMe SSD  */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
+	{ PCI_DEVICE(0x1e4B, 0x1202),   /* MAXIO MAP1202 */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0061),
 		.driver_data = NVME_QUIRK_DMA_ADDRESS_BITS_48, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0065),
-- 
2.30.2


