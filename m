Return-Path: <SRS0=jy92=BI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C842EC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 05:35:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9429020786
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 05:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W8s2JpJv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="glP8kW7t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9429020786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vkFbJNyMiY/YUacug8lNGnv1QIHQDF8CsFfHl3ING7U=; b=W8s2JpJvUfvW/GSRuTQE+HaSK9
	kXISBKdIG1youBa3Gnz+8MAXZq1RdR6rvNnRBw33rUXA44BV/KxgedawA7DRxX9UOkJgMDp820gGV
	CcHXB1MGPde/f+IisNuwEgyLxrFiYoiEf3Et9QAsRz4mu/KBy+nUv6zlUpW6Q3dapzTa6LRwwEg9k
	zvlIFDVGyQ2VBdPauRHOWieZQBO+4Niuk0MzAvhAfH6p09wkES6cS5XpvSPMEFGNq3xiQfsx9o7Ji
	Nd61YBPwW2ojuqN2CHbMIFpSmymhWPj0Gms817TA6BzTHu00M3B7t4cwRx0bm+NXNWS1f/BblQ407
	FuCp2NSQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0eke-0005nP-9E; Wed, 29 Jul 2020 05:35:40 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0ekc-0005nF-ER
 for linux-nvme@merlin.infradead.org; Wed, 29 Jul 2020 05:35:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=++LN5w+4q8mpel0z8lTozYgby+8/G3TXvK3Lxc+I+5Y=; b=glP8kW7t3fKLb7ecKB9SAsxK7T
 76FcmdKo9aCaJHuq0wGulzzhjlBNBUhpdou2sgLRDDvow61j2aXF93TC5ti/8ZKh7qhkJTviqyM51
 KJo9gYQxVkXMBFkt7W0DBbkTtk4t7A4UsSOFRywEj4OmanB627R7t7axdVNWT+1rgN7FzWCkMWqUl
 vdhY2fKzKQqQbabPNbVF0TmckxBI1nLA6P23VOVyU2QI6yMuA7ttOjp3Duyvnl7bNgr3q09X/1JoN
 7ORcJAIU1dhV2FufcxRGbUUgByuRrWrVH2wEFbf+sLyBM7rXw+Nw7XgsbjTKrwquiCAB8wO6np6CA
 1dXpgNkw==;
Received: from 089144218008.atnat0027.highway.a1.net ([89.144.218.8]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0eka-0001qV-0s; Wed, 29 Jul 2020 05:35:36 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: add a Identify Namespace Identification Descriptor list
 quirk
Date: Wed, 29 Jul 2020 07:35:32 +0200
Message-Id: <20200729053532.6588-1-hch@lst.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Ingo Brunberg <ingo_brunberg@web.de>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add a quirk for a device that does not support the Identify Namespace
Identification Descriptor list despite claiming 1.3 compliance.

Reported-by: Ingo Brunberg <ingo_brunberg@web.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Ingo Brunberg <ingo_brunberg@web.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 16 +++-------------
 drivers/nvme/host/nvme.h |  7 +++++++
 drivers/nvme/host/pci.c  |  2 ++
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 05aa568a60af62..0602e0f3e77de9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1287,18 +1287,6 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
 	if (status) {
 		dev_warn(ctrl->device,
 			"Identify Descriptors failed (%d)\n", status);
-		 /*
-		  * Don't treat non-retryable errors as fatal, as we potentially
-		  * already have a NGUID or EUI-64.  If we failed with DNR set,
-		  * we want to silently ignore the error as we can still
-		  * identify the device, but if the status has DNR set, we want
-		  * to propagate the error back specifically for the disk
-		  * revalidation flow to make sure we don't abandon the
-		  * device just because of a temporal retry-able error (such
-		  * as path of transport errors).
-		  */
-		if (status > 0 && (status & NVME_SC_DNR) && !nvme_multi_css(ctrl))
-			status = 0;
 		goto free_data;
 	}
 
@@ -1888,7 +1876,9 @@ static int nvme_report_ns_ids(struct nvme_ctrl *ctrl, unsigned int nsid,
 		memcpy(ids->eui64, id->eui64, sizeof(id->eui64));
 	if (ctrl->vs >= NVME_VS(1, 2, 0))
 		memcpy(ids->nguid, id->nguid, sizeof(id->nguid));
-	if (ctrl->vs >= NVME_VS(1, 3, 0) || nvme_multi_css(ctrl))
+	if (nvme_multi_css(ctrl) ||
+	    (ctrl->vs >= NVME_VS(1, 3, 0) &&
+	     !(ctrl->quirks & NVME_QUIRK_NO_NS_DESC_LIST)))
 		return nvme_identify_ns_descs(ctrl, nsid, ids);
 	return 0;
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index c5c1bac797aa5a..4cadaea9034ae4 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -137,6 +137,13 @@ enum nvme_quirks {
 	 * Don't change the value of the temperature threshold feature
 	 */
 	NVME_QUIRK_NO_TEMP_THRESH_CHANGE	= (1 << 14),
+
+	/*
+	 * The controller doesn't handle the Identify Namespace
+	 * Identification Descriptor list subcommand despite claiming
+	 * NVMe 1.3 compliance.
+	 */
+	NVME_QUIRK_NO_NS_DESC_LIST		= (1 << 15),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 61e612d52d61d6..bac3a3f9c79e0d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3181,6 +3181,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(0x1cc1, 0x8201),   /* ADATA SX8200PNP 512GB */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+	{ PCI_DEVICE(0x126f, 0x2263),
+		.driver_data = NVME_QUIRK_NO_NS_DESC_LIST, },
 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001),
 		.driver_data = NVME_QUIRK_SINGLE_VECTOR },
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
