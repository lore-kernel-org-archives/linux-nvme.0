Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A86D2C433FE
	for <linux-nvme@archiver.kernel.org>; Fri,  6 May 2022 10:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NcBBQwmWlH6xqsycDtIZaSzw22yenWKb2ZT8W08Y634=; b=2674qTqoJ3lH0eAHCVLM8vIG/W
	lZnblTa5VCCGZc+amhfm8tNCRyYvgcb5vSBowYkTljiOWkuzSEGG7fAIz2AjSGkEpwUmlptZn5u+f
	gXAGTiQrs9Mgd1zBz64UQhwnWsHrdn7BllLZRzIkxb9kf65v/pxhlr8TsI5imKNf0M109co0PrcEo
	+N9gqifhcerQo+fUATKh9VXOWN1PgXeDZbbMebMe30D9wbvZ/9hwhciFfaQtcJ2NIDW+sI/mSz7vF
	S/15vdKnQqTl4sk7xLAYCgNrzV12FysZrZVwjGDxIsW5wXGZwo9wh0wYGX8W7EUkpci0z+F/veEw4
	PMHYmpXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmv2q-002eqj-RB; Fri, 06 May 2022 10:18:44 +0000
Received: from mout-u-204.mailbox.org ([91.198.250.253])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmv2o-002epC-Gl
 for linux-nvme@lists.infradead.org; Fri, 06 May 2022 10:18:43 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4Kvmfg0dSqz9sTy;
 Fri,  6 May 2022 12:15:39 +0200 (CEST)
From: Stefan Roese <sr@denx.de>
To: linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>
Subject: [PATCH] nvme-pci: Harden drive presence detect in nvme_dev_disable()
Date: Fri,  6 May 2022 12:15:34 +0200
Message-Id: <20220506101534.1728011-1-sr@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220506_031842_735310_409EDE84 
X-CRM114-Status: GOOD (  15.38  )
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

On our ZynqMP system we observe, that a NVMe drive that resets itself
while doing a firmware update causes a Kernel crash like this:

[ 67.720772] pcieport 0000:02:02.0: pciehp: Slot(2): Link Down
[ 67.720783] pcieport 0000:02:02.0: pciehp: Slot(2): Card not present
[ 67.720795] nvme 0000:04:00.0: PME# disabled
[ 67.720849] Internal error: synchronous external abort: 96000010 [#1] PREEMPT SMP
[ 67.720853] nwl-pcie fd0e0000.pcie: Slave error

Analysis: When nvme_dev_disable() is called because of this PCIe hotplug
event, pci_is_enabled() is still true. And accessing the NVMe drive
which is currently not available as it's in reboot process causes this
"synchronous external abort" on this ARM64 platform.

This patch adds the pci_device_is_present() check as well, which returns
false in this "Card not present" hot-plug case. With this change, the
NVMe driver does not try to access the NVMe registers any more and the
FW update finishes without any problems.

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 97afeb898b25..c764a2a1d7f1 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2473,7 +2473,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
 	mutex_lock(&dev->shutdown_lock);
-	if (pci_is_enabled(pdev)) {
+	if (pci_device_is_present(pdev) && pci_is_enabled(pdev)) {
 		u32 csts = readl(dev->bar + NVME_REG_CSTS);
 
 		if (dev->ctrl.state == NVME_CTRL_LIVE ||
-- 
2.36.0


