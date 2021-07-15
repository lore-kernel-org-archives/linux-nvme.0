Return-Path: <SRS0=3azT=MH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CF9C1B08C
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Jul 2021 12:09:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A7916120A
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Jul 2021 12:09:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A7916120A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EbGd+ZsvMAP/Utrj95/27Ep1G/ybjHP33Wjj7sLjMLk=; b=3rFijOjXVWaXJV
	rtmgOVYgU2uZEB4/wzHg7z2SLyDfTKCR2zseY52PNY4ITPfTGGDmypjKD2/WDlytMwvq4CZByanom
	OcAybqXzHPuV247bWLUkIsZbcGbDRndTHCYDPYGV5VcFzoc2iHoaX7eHulJyrnRr6fgt2uEuL3N2y
	J+nJpacHVa1AfNGSP2sjklp5HazztfMB8ngv1JCpA1wRBnxP82m8avNUhSr3GPqnVg3UC76+jxONy
	L9evUUNquXk8L0LpUlXcSg5X73xYW33VZx1nb//VEoTXydQnUWW8pstalmAzkUXhyJFN9INPlAn9U
	QwpxY9fnOf4NmD3vbIrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m40B4-000hg7-8Q; Thu, 15 Jul 2021 12:09:18 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m40Aw-000hcP-G1
 for linux-nvme@lists.infradead.org; Thu, 15 Jul 2021 12:09:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626350949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pMdTzJHNKVWe9GNkdImtqswTDriEuMcivsx+NF2L4oM=;
 b=eHoE2dCJAumbT0ib4Kg9WWRKRZzrZl+hsm8lKIt/RWx4b9JEIGWxLtWNDfhLc9XRvjhing
 joJWwv/ovHyxILiO4kCjZ8EOyadhZo0210cnwgvZY5ozkSRFW9+jE8lsmnsiUYE/Qa640U
 Fhrd7nqvRJIhWLhAs7laq1l1CelweUM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-OJhv6rFHMpmzMXH3APQCSQ-1; Thu, 15 Jul 2021 08:09:05 -0400
X-MC-Unique: OJhv6rFHMpmzMXH3APQCSQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF41D1835AC4;
 Thu, 15 Jul 2021 12:09:03 +0000 (UTC)
Received: from localhost (ovpn-12-61.pek2.redhat.com [10.72.12.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 71A2E1002D71;
 Thu, 15 Jul 2021 12:08:58 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Sagi Grimberg <sagi@grimberg.me>,
 Daniel Wagner <dwagner@suse.de>, Wen Xiong <wenxiong@us.ibm.com>,
 John Garry <john.garry@huawei.com>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 1/3] driver core: mark device as irq affinity managed if
 any irq is managed
Date: Thu, 15 Jul 2021 20:08:42 +0800
Message-Id: <20210715120844.636968-2-ming.lei@redhat.com>
In-Reply-To: <20210715120844.636968-1-ming.lei@redhat.com>
References: <20210715120844.636968-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210715_050910_624527_A7022F35 
X-CRM114-Status: GOOD (  18.04  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

irq vector allocation with managed affinity may be used by driver, and
blk-mq needs this info because managed irq will be shutdown when all
CPUs in the affinity mask are offline.

The info of using managed irq is often produced by drivers(pci subsystem,
platform device, ...), and it is consumed by blk-mq, so different subsystems
are involved in this info flow

Address this issue by adding one field of .irq_affinity_managed into
'struct device'.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/base/platform.c | 7 +++++++
 drivers/pci/msi.c       | 3 +++
 include/linux/device.h  | 1 +
 3 files changed, 11 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 8640578f45e9..d28cb91d5cf9 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -388,6 +388,13 @@ int devm_platform_get_irqs_affinity(struct platform_device *dev,
 				ptr->irq[i], ret);
 			goto err_free_desc;
 		}
+
+		/*
+		 * mark the device as irq affinity managed if any irq affinity
+		 * descriptor is managed
+		 */
+		if (desc[i].is_managed)
+			dev->dev.irq_affinity_managed = true;
 	}
 
 	devres_add(&dev->dev, ptr);
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 3d6db20d1b2b..7ddec90b711d 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1197,6 +1197,7 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 	if (flags & PCI_IRQ_AFFINITY) {
 		if (!affd)
 			affd = &msi_default_affd;
+		dev->dev.irq_affinity_managed = true;
 	} else {
 		if (WARN_ON(affd))
 			affd = NULL;
@@ -1215,6 +1216,8 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 			return nvecs;
 	}
 
+	dev->dev.irq_affinity_managed = false;
+
 	/* use legacy IRQ if allowed */
 	if (flags & PCI_IRQ_LEGACY) {
 		if (min_vecs == 1 && dev->irq) {
diff --git a/include/linux/device.h b/include/linux/device.h
index 59940f1744c1..9ec6e671279e 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -569,6 +569,7 @@ struct device {
 #ifdef CONFIG_DMA_OPS_BYPASS
 	bool			dma_ops_bypass : 1;
 #endif
+	bool			irq_affinity_managed : 1;
 };
 
 /**
-- 
2.31.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
