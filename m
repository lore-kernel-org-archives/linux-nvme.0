Return-Path: <SRS0=dOZ+=AN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2C6C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 21:31:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98A46208FE
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 21:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YiwDcAVE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A46208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YYZN8iQ27VVnxWKXAPD/g9GAxMCnqNlneUbOB6Dvk6g=; b=YiwDcAVEnhBY/oOx9MfMHIOnST
	6r/NVMIxKkWsyPnU5FaKfBrQyZgQuTvX6dIe1eWk/30o3hk+bKkNeVt3tISjNLULyC4JpYT2mfeuk
	ysYDNpWZY+YemdAWqGgYT7x+mwy9IrEMbf6Np+hpGUibg3XbVRDtQlgpwUp1EAa8vXsZRijXIbPZN
	CR9YcRXP8zUMLegCz/zNhCj4EiZAPZddrVdrYO5TjcGhJ8ozNR5OIgFJMZ5OjY03O2AlbVfmaCBv3
	llX5Kp496SpCKllzBxdDZwE5eM+kXpGOL0Wovn8a3/I1/yM8phMviXfJePyKsR8z/sflzVz219B4d
	mlyuSS1w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jr6oC-0005tJ-8b; Thu, 02 Jul 2020 21:31:52 +0000
Received: from mga12.intel.com ([192.55.52.136])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jr6o8-0005sS-Pk
 for linux-nvme@lists.infradead.org; Thu, 02 Jul 2020 21:31:49 +0000
IronPort-SDR: 8nWtu7lseNkja51HnVzXtujLP83YB+tSgOieFCyrgKnZ7yd2ba3s7YGTSyWL7RV0Hl2O7w94wU
 a4366xt/KrnA==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="126644261"
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; d="scan'208";a="126644261"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 14:31:46 -0700
IronPort-SDR: K7kGyCSU0/2b1bZ6uCi86C79KbiXDZX+0SAs+rd86YGWgQjdyXuIINfPSafs3049NNp4CS+mCT
 y/dhNR8N7P5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; d="scan'208";a="304373114"
Received: from unknown (HELO dwf-u18040.localdomain) ([10.232.115.11])
 by fmsmga004.fm.intel.com with ESMTP; 02 Jul 2020 14:31:46 -0700
From: David Fugate <david.fugate@linux.intel.com>
To: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@fb.com,
 hch@lst.de, sagi@grimberg.me
Subject: [PATCH] nvme: document quirked Intel models
Date: Thu,  2 Jul 2020 15:31:22 -0600
Message-Id: <20200702213122.50167-1-david.fugate@linux.intel.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200702_173149_010510_96BC8841 
X-CRM114-Status: GOOD (  11.05  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Documented model names of Intel SSDs requiring quirks.

Signed-off-by: David Fugate <david.fugate@linux.intel.com>
---
 drivers/nvme/host/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c283e8dbfb86..9be54ba063c4 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3078,16 +3078,16 @@ static const struct pci_error_handlers nvme_err_handler = {
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
 		.driver_data = NVME_QUIRK_STRIPE_SIZE |
 				NVME_QUIRK_DEALLOCATE_ZEROES, },
 	{ PCI_VDEVICE(INTEL, 0xf1a5),	/* Intel 600P/P3100 */
-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
