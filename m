Return-Path: <SRS0=tyWw=HF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_ALL,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9020C433DB
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 09:44:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C9B764F76
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 09:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C9B764F76
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gqEEWpiHa0S441FL//i28g5gRVCovxVj4j8T/pu63nk=; b=qKLAn0OcYSffleJfYLYoJZLPsa
	nrckm0FCwoI4Pu1bVLdozS0rKaX8Yg0FDZ5apYEmtqzOAeX/K0A7nprjB5Mv92qAhG0YzbA/AA83x
	JIhQeH9sHyxFxBzBIJEbgIZ3fiP0b9lG/imCdXYfGUXxjgWhnSuobYYnMl64x7Tt9xgb6JnLXrIWD
	+nNQvH1hyvUrY6Sgo4ptbuPmHKFWqX7Yk0pEASSe60KmDJCNT1LOMFoASqUUAMkZdle7sgCTRoHPE
	hY9t7VcUJ2VFUagqtMkgh+dHTWESIcAUkAQlGtyg7yGnf/9RucOQ/uiWT4F5m0HQYkiiNBO1ZCw7v
	16EyJzGg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7Ehw-0006Qj-FG; Wed, 03 Feb 2021 09:44:20 +0000
Received: from smtp-fw-2101.amazon.com ([72.21.196.25])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7Ehr-0006QJ-IU
 for linux-nvme@lists.infradead.org; Wed, 03 Feb 2021 09:44:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
 t=1612345455; x=1643881455;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=qzmORu6TPDMtpaBxAL0UiJI+S5JTnIvY28f0uCb5OQA=;
 b=VvhviqNCi98q6XJyfZuuyWVFUraY5iPoittTkM+R7PEU8DuPD0y2gPqi
 Y2p9EjpDUjG2MUWN6EEgqIKi7Hta390sDi7X5w3/7/bM5JBdBFl5sytg+
 /Q9rPZuzTlzjp/jUY2wSqOLdlGGpZN81Ym727o2qznd9+57NFwTLX8nfp Q=;
X-IronPort-AV: E=Sophos;i="5.79,398,1602547200"; d="scan'208";a="79372647"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com) ([10.43.8.6])
 by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP;
 03 Feb 2021 09:44:05 +0000
Received: from EX13D02EUC001.ant.amazon.com
 (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
 by email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com (Postfix) with ESMTPS
 id 25F95A185A; Wed,  3 Feb 2021 09:44:04 +0000 (UTC)
Received: from u2196cf9297dc59.ant.amazon.com (10.43.160.66) by
 EX13D02EUC001.ant.amazon.com (10.43.164.92) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 3 Feb 2021 09:43:59 +0000
From: Filippo Sironi <sironi@amazon.de>
To: <serebrin@amazon.com>, <dwmw@amazon.co.uk>, <kbusch@kernel.org>,
 <axboe@fb.com>, <hch@lst.de>, <sagi@grimberg.me>,
 <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] nvme: Add 48-bit DMA address quirk
Date: Wed, 3 Feb 2021 10:43:38 +0100
Message-ID: <20210203094338.19473-1-sironi@amazon.de>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.43.160.66]
X-ClientProxiedBy: EX13D04UWA001.ant.amazon.com (10.43.160.47) To
 EX13D02EUC001.ant.amazon.com (10.43.164.92)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210203_044415_767733_D5BDB20D 
X-CRM114-Status: GOOD (  15.32  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Filippo Sironi <sironi@amazon.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Certain NVMe controllers don't support 64-bit DMA addresses.  Instead,
they are limited to 48-bit DMA addresses.  Let's add a quirk to use them
properly.

Signed-off-by: Filippo Sironi <sironi@amazon.de>
---
 drivers/nvme/host/nvme.h |  5 +++++
 drivers/nvme/host/pci.c  | 12 +++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 88a6b97247f5..dae747b4ac35 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -144,6 +144,11 @@ enum nvme_quirks {
 	 * NVMe 1.3 compliance.
 	 */
 	NVME_QUIRK_NO_NS_DESC_LIST		= (1 << 15),
+
+	/*
+	 * The controller supports up to 48-bit DMA address.
+	 */
+	NVME_QUIRK_DMA_ADDRESS_BITS_48		= (1 << 16),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 81e6389b2042..5716ae16c7a7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2362,13 +2362,16 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 {
 	int result = -ENOMEM;
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	int dma_address_bits = 64;
 
 	if (pci_enable_device_mem(pdev))
 		return result;
 
 	pci_set_master(pdev);
 
-	if (dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(64)))
+	if (dev->ctrl.quirks & NVME_QUIRK_DMA_ADDRESS_BITS_48)
+		dma_address_bits = 48;
+	if (dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(dma_address_bits)))
 		goto disable;
 
 	if (readl(dev->bar + NVME_REG_CSTS) == -1) {
@@ -3259,6 +3262,13 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x1d97, 0x2263),   /* SPCC */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ .vendor = PCI_VENDOR_ID_AMAZON,
+	  .device = PCI_ANY_ID,
+	  .subvendor = PCI_ANY_ID,
+	  .subdevice = PCI_ANY_ID,
+	  .class = PCI_CLASS_STORAGE_EXPRESS,
+	  .class_mask = 0xffffff,
+	  .driver_data = NVME_QUIRK_DMA_ADDRESS_BITS_48 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001),
 		.driver_data = NVME_QUIRK_SINGLE_VECTOR },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
-- 
2.17.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
