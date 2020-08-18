Return-Path: <SRS0=NqxM=B4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95361C433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 08:35:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6167B2067C
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 08:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="yNGKD+32"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6167B2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FF1VpiALCwftQg7OgvuIcQHnysYy/gURIBLKI1U5pVA=; b=yNGKD+32WBkg9qi4fSGzNlSuDr
	sLe/BOHDTEHbsrJPCvd7NyYVP8EPhYgSmZrJkXt+XXNuD09syv8reRS7N5btRyoRNltsZuDyYTiGu
	yRyQcMF62ijW869ViMjsqTUomPt5YgCBE4OGwpuC+DuchrOTvE1Ka9Z2cTFRLTYLM+lcTGMwHCLOA
	jo7r6ztJXiqmB6Bn1WxIvD2fa2yHq2hBZtlDowiQpsz65fhcvV3PPkFAqIxoXcoB80SUCbyijayD5
	xa31HgGsGQ/vPp1CxXsltq7t2yPIrRHTu/Or3JpMjFpO56nUDLfXjJ3pULYHW6FDMM3NQvP2CbrrW
	f6VjDcoA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k7x5o-0006eb-Ky; Tue, 18 Aug 2020 08:35:40 +0000
Received: from mga14.intel.com ([192.55.52.115])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7x5l-0006dv-95
 for linux-nvme@lists.infradead.org; Tue, 18 Aug 2020 08:35:38 +0000
IronPort-SDR: GjbtQ1fVT/5kDtcIOvyFY0BfNnszLTQwj/7i/LfO/vl43rJ7D8RVViHhb7sBzPtaghu1bb2iAm
 QPttumEA5MPA==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="154122252"
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; d="scan'208";a="154122252"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2020 01:35:35 -0700
IronPort-SDR: IaseEDAawqSif8XEKZqx+4chRtJ5xrvxRPN30ABlcjef+JDUgpr0IElsAHjmc7fhemQ0S9QbIa
 q1xKyaEFevaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; d="scan'208";a="441149232"
Received: from black.fi.intel.com ([10.237.72.28])
 by orsmga004.jf.intel.com with ESMTP; 18 Aug 2020 01:35:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id 8191526A; Tue, 18 Aug 2020 11:35:30 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 linux-nvme@lists.infradead.org
Subject: [PATCH v2] nvme-pci: Move enumeration by class to be last in the table
Date: Tue, 18 Aug 2020 11:35:30 +0300
Message-Id: <20200818083530.18983-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200818_043537_495094_DB43E4D2 
X-CRM114-Status: GOOD (  17.58  )
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
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

It's unusual that we have enumeration by class in the middle of the table.
It might potentially be problematic in the future if we add another entry
after it.

So, move class matching entry to be the last in the ID table.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
v2: appended tags and rebased on top of v5.9-rc1
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ba725ae47305..95ea671e5c9e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3185,7 +3185,6 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(0x1c5c, 0x1504),   /* SK Hynix PC400 */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
-	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001),
 		.driver_data = NVME_QUIRK_SINGLE_VECTOR },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
@@ -3193,6 +3192,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_SINGLE_VECTOR |
 				NVME_QUIRK_128_BYTES_SQES |
 				NVME_QUIRK_SHARED_TAGS },
+
+	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, nvme_id_table);
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
