Return-Path: <SRS0=Gy4h=HM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_ALL,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A769C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 00:40:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A850464E4F
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 00:40:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A850464E4F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tp5cZuPTfvwkl1nzQD1pgQx0mam/WpYOpCYZBqpqMmY=; b=kR62fYX1bYb9nJO36fc5s45Mr
	HTYteKxovQG4HEdAG/zXNd0hxd1wWbJYFbnbK9jj1+m1vedswN5k61qLMYGlfqMxFIlcDjSWp9vfW
	94tuUxSKm2nGO3vch9oQGc74y890k5n7fuEavwwgp0Li4eqkxWaml0GDIUfWwo6LPI55aTxYGzpUd
	qbvhf0jaqwBhkOUq6K+KqTxFEOrfC4fj+1rtc8VdrfcXsiP6xLvUrp1GDYMJAlbXMEDNZTUnHfUHw
	P62dx2IJQLGLqf6dAc8hrj91SG3Tra/6IBxq3XxIIo/rShlORN2fEeeO4lpbXUTRDYtqL0v9FWiee
	Q7iMfe2MQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9dYH-00015a-PJ; Wed, 10 Feb 2021 00:40:17 +0000
Received: from smtp-fw-2101.amazon.com ([72.21.196.25])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9dYG-00015H-0k
 for linux-nvme@lists.infradead.org; Wed, 10 Feb 2021 00:40:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
 t=1612917616; x=1644453616;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=nankUMrNk1jmGMTceQpek9gK36swyK5+qE/O39IiF20=;
 b=mXRD9uteANsNaYSn8ccaoTdChDISkqz9t6aUN5Ck0HKav1fzacMVfNs1
 uypDQ9Ik5rR7L/rRF1rNezVNYx3SMbYlvPTTqhWsp/afW6VOFcTn+6R1q
 kFESo2TNGCyGhfh/QFO77he3kpKk7Lc4MEAm0PjPjTW3O7KdHXC1YXzLd Q=;
X-IronPort-AV: E=Sophos;i="5.81,166,1610409600"; d="scan'208";a="81114973"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com) ([10.43.8.6])
 by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP;
 10 Feb 2021 00:40:06 +0000
Received: from EX13D02EUC001.ant.amazon.com
 (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
 by email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com (Postfix) with ESMTPS
 id 86061A1DA9; Wed, 10 Feb 2021 00:40:04 +0000 (UTC)
Received: from u2196cf9297dc59.ant.amazon.com (10.43.161.87) by
 EX13D02EUC001.ant.amazon.com (10.43.164.92) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 10 Feb 2021 00:39:59 +0000
From: Filippo Sironi <sironi@amazon.de>
To: <serebrin@amazon.com>, <dwmw@amazon.co.uk>, <benh@amazon.com>,
 <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>, <sagi@grimberg.me>
Subject: [PATCH v2] nvme: Add 48-bit DMA address quirk for Amazon NVMe
 controllers
Date: Wed, 10 Feb 2021 01:39:42 +0100
Message-ID: <20210210003942.25700-1-sironi@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210203094338.19473-1-sironi@amazon.de>
References: <20210203094338.19473-1-sironi@amazon.de>
MIME-Version: 1.0
X-Originating-IP: [10.43.161.87]
X-ClientProxiedBy: EX13D43UWA001.ant.amazon.com (10.43.160.44) To
 EX13D02EUC001.ant.amazon.com (10.43.164.92)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210209_194016_225752_77FCBEE7 
X-CRM114-Status: GOOD (  16.13  )
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
Cc: Filippo Sironi <sironi@amazon.de>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Amazon NVMe controllers do not support 64-bit DMA addresses; they are
limited to 48-bit DMA addresses.  Let's add a quirk to ensure that we
make use of 48-bit DMA addresses to avoid misbehavior.

This affects all Amazon NVMe controllers that expose EBS volumes
(0x0061, 0x0065, 0x8061) and local instance storage (0xcd00, 0xcd01,
0xcd02).

Signed-off-by: Filippo Sironi <sironi@amazon.de>
---
 drivers/nvme/host/nvme.h |  5 +++++
 drivers/nvme/host/pci.c  | 17 ++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

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
index 6bad4d4dcdf0..e7001f5ed6e4 100644
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
@@ -3263,6 +3266,18 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x2646, 0x2263),   /* KINGSTON A2000 NVMe SSD  */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0061),
+		.driver_data = NVME_QUIRK_DMA_ADDRESS_BITS_48, },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0065),
+		.driver_data = NVME_QUIRK_DMA_ADDRESS_BITS_48, },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x8061),
+		.driver_data = NVME_QUIRK_DMA_ADDRESS_BITS_48, },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0xcd00),
+		.driver_data = NVME_QUIRK_DMA_ADDRESS_BITS_48, },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0xcd01),
+		.driver_data = NVME_QUIRK_DMA_ADDRESS_BITS_48, },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0xcd02),
+		.driver_data = NVME_QUIRK_DMA_ADDRESS_BITS_48, },
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
