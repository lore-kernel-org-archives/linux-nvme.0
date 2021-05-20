Return-Path: <SRS0=7pRJ=KP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D63BC433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 05:45:45 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 277E1610A2
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 05:45:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277E1610A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xZmxwZBM/LFkUQgGIJZzB1FTChmxJntks7i+dLcvAJA=; b=D6Cea6zWFVDmwQDzOzhvLdhrk
	qb56DOJOy3LqBwE8xSzFY7C6So5WY2Sq0uUgWFrFF+RJOHxVzpuNdK6xbQ8nlqQSquO7+xzfYCRCV
	MtfBP7R2Ocepy/yVogew7RxRHXZWa4VstTNGFPon08z5i7EM+o0IDgyaK9MECQ2xhdKfGtOSmJ8Bo
	srAJsg6+1v8JajeWNFkIQ0ak9wk4tu0AgpXtTfL/2WIy4eWrCTWvdFAVUuZ/HUpgxzZYXyeroVteG
	9GeYlp5xPv6U77en3ck47pDYtmPsnUlNEgApYIAcuWzZm/PggvFuBG9W9KYwPAbaLVIBbgNLaT/YK
	dpG1RIoRw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ljbV5-005ynn-K3; Thu, 20 May 2021 05:45:39 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljbUB-005ye8-Kn
 for linux-nvme@desiato.infradead.org; Thu, 20 May 2021 05:44:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=OBWU1lWHiGcCjbOXnaVpI9clSefNW+ML0YG47lzNlKI=; b=MkM2jmjJVncwnD2mMh1QXLfpHJ
 AlQI1RarTwFVdpUesUG7THv+iOLLFIqd0jjkfNc77J3Mw8S9QY31L8wVeiVmPaXQz2OgHmoCLs8Jl
 5ABfjhXIvmkkTDAXoqJobiwSCEFiVvdi4+yw2wTVjnxltHHn3RMTluPBzgThuA0Qc5J3+wvz8PzGS
 AGxH4jl29H9cH1Iakup8NLqY5BzepzcRR0aN2Mf99B9MSHh0p2saJyOK66vnjHLm0K5nUrqCzsNXJ
 XGiLmqkBdcGer0DoHQlS5J1AarmgXXvrLKTSJYX1Gt9+8cGRxIXxshN3PXKuvT1FT+mTgK8c9xDzy
 WNMl2smA==;
Received: from [2001:4bb8:180:5add:a633:7cce:5450:3d63] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1ljbUA-00FxMe-0D; Thu, 20 May 2021 05:44:42 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Minwoo Im <minwoo.im.dev@gmail.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 5/7] nvme: move the CSI sanity check into nvme_ns_report_zones
Date: Thu, 20 May 2021 07:44:24 +0200
Message-Id: <20210520054426.567241-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210520054426.567241-1-hch@lst.de>
References: <20210520054426.567241-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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

Move the CSI check into nvme_ns_report_zones to clean up the code
a little bit and prepare for further refactoring.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/zns.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 475dd45c3db4..31e789ecd940 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -180,6 +180,9 @@ static int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
 	unsigned int nz, i;
 	size_t buflen;
 
+	if (ns->head->ids.csi != NVME_CSI_ZNS)
+		return -EINVAL;
+
 	report = nvme_zns_alloc_report_buffer(ns, nr_zones, &buflen);
 	if (!report)
 		return -ENOMEM;
@@ -237,11 +240,7 @@ int nvme_report_zones(struct gendisk *disk, sector_t sector,
 	ns = nvme_get_ns_from_disk(disk, &head, &srcu_idx);
 	if (unlikely(!ns))
 		return -EWOULDBLOCK;
-
-	if (ns->head->ids.csi == NVME_CSI_ZNS)
-		ret = nvme_ns_report_zones(ns, sector, nr_zones, cb, data);
-	else
-		ret = -EINVAL;
+	ret = nvme_ns_report_zones(ns, sector, nr_zones, cb, data);
 	nvme_put_ns_from_disk(head, srcu_idx);
 
 	return ret;
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
