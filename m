Return-Path: <SRS0=2FDT=7Y=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AA4C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jun 2020 03:39:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C25DD2072F
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jun 2020 03:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mlYPgn10"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C25DD2072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=qtefD75GBMpeCNYqyhj/YuA2vyT2NA+IUcpyfETF4Ow=; b=mlY
	Pgn10ZxnHyH34pM5KNZnQ5ftBkd8hPFe1IzUrLZo8V/WUBU0UrGif9OIyhX+Ew0jPpzecj8m3gQqu
	JcBENHNHkLRilybeLfEZf/jWInyQf0eVK7X4VkB1BcmtNtrnGNiS7D4Z0Y6WuDDRKFTpevhyqTIKY
	O4unytJ05gtB0whOdUA8hvllYmCInCCjcgT+u0xX3tUrHANVeUwE+W1Af5Ulto5h/O8fB4wEsZnU6
	6Und/W95IwH3qdQ/dnHkiEGbZIEZDFh0b3yjzJ7uwyICc8hzr6DATOqHRCrLlm/sJ3/VwY/wqMrFb
	6KQ+91igWniedaNKqxkQIIxaa8+WCFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jjE3f-0004VA-SE; Thu, 11 Jun 2020 03:39:15 +0000
Received: from mga14.intel.com ([192.55.52.115])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jjE3d-0004SE-6I
 for linux-nvme@lists.infradead.org; Thu, 11 Jun 2020 03:39:14 +0000
IronPort-SDR: LQG1xTDol3qd4ZlDcnzLp9xFuNqDXpNOw+vgo2AK+MNnQ8zMKrmqVyaLJahGmqRqsKnwAEJbP7
 PuvXFZXrnytw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2020 20:39:11 -0700
IronPort-SDR: syaw149zO+sDOBfxXm3h3Hk2JGXP/AZrxshI3jy6xzu8SEO8UazsQ2RMP9Ee0zpo5JZCg+U086
 u9Nj7pjJylXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,498,1583222400"; d="scan'208";a="271455333"
Received: from dfugate-mobl1.amr.corp.intel.com (HELO localhost.localdomain)
 ([10.209.73.242])
 by orsmga003.jf.intel.com with ESMTP; 10 Jun 2020 20:39:10 -0700
From: David Fugate <david.fugate@linux.intel.com>
To: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@fb.com,
 hch@lst.de, sagi@grimberg.me
Subject: [PATCH] nvme: associate stripe size quirk with D4512
Date: Wed, 10 Jun 2020 21:38:36 -0600
Message-Id: <20200611033836.45701-1-david.fugate@linux.intel.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200610_203913_241944_89082505 
X-CRM114-Status: GOOD (  10.13  )
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
Cc: david.fugate@intel.com, David Fugate <david.fugate@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Intel's D4512 dual-port SSD is based on the older Intel P4500 SSDs
whose development predated the NOIOB feature. Based on a customer
request, the D4512's device ID was changed from the P4500s'. This
patch associates D4512's device ID with the stripe size quirk to
improve its performance.

Signed-off-by: David Fugate <david.fugate@linux.intel.com>
---
 drivers/nvme/host/pci.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5577c8cbb3e0..80afc8b3344d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3070,16 +3070,19 @@ static const struct pci_error_handlers nvme_err_handler = {
 };
 
 static const struct pci_device_id nvme_id_table[] = {
-	{ PCI_VDEVICE(INTEL, 0x0953),
+	{ PCI_VDEVICE(INTEL, 0x0953),	/* Intel 750/P3500/P3600/P3700 */
 		.driver_data = NVME_QUIRK_STRIPE_SIZE |
 				NVME_QUIRK_DEALLOCATE_ZEROES, },
-	{ PCI_VDEVICE(INTEL, 0x0a53),
+	{ PCI_VDEVICE(INTEL, 0x0a53),	/* Intel P3520 */
 		.driver_data = NVME_QUIRK_STRIPE_SIZE |
 				NVME_QUIRK_DEALLOCATE_ZEROES, },
-	{ PCI_VDEVICE(INTEL, 0x0a54),
+	{ PCI_VDEVICE(INTEL, 0x0a54),	/* Intel P4500/P4600 */
 		.driver_data = NVME_QUIRK_STRIPE_SIZE |
 				NVME_QUIRK_DEALLOCATE_ZEROES, },
-	{ PCI_VDEVICE(INTEL, 0x0a55),
+	{ PCI_VDEVICE(INTEL, 0x0a55),	/* Dell Express Flash P4600 */
+		.driver_data = NVME_QUIRK_STRIPE_SIZE |
+				NVME_QUIRK_DEALLOCATE_ZEROES, },
+	{ PCI_VDEVICE(INTEL, 0x0d54),	/* Intel D4512 */
 		.driver_data = NVME_QUIRK_STRIPE_SIZE |
 				NVME_QUIRK_DEALLOCATE_ZEROES, },
 	{ PCI_VDEVICE(INTEL, 0xf1a5),	/* Intel 600P/P3100 */
-- 
2.17.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
