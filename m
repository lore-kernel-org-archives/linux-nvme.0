Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5C0C433B4
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 12:21:40 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15B4C61159
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 12:21:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15B4C61159
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZFJCRGZ9kcG1604dQ9Xl2RzSGWXvdkFAyBIfX8P7NIs=; b=gLFpVNPGR4yt+r5wSjapHAQJr
	cgvXQqsxG/3lWOMGAMBgW1ah13sZLZWKF3fgNDClwn/kJSTgOUrw+v/YvjAmg56gyO9gJocP1wtFm
	OEP/O75hD5248U7MoVlLgthAKAZtvrDehiuJrCImQC+MUfG872Ah3bmr7MSd6HIyW/FE8QtQNAiWq
	IRkTdzCUl1DDWB5YAjcu3R0HK8BOEfqLRXz5802PNFOCCuqUp1AXGVmbxnzLw+/VZANvAIq0pTRju
	HNpuK9uKQMWMNN4jv980iCJChuF+vfViIbMXWb3JR0OHk0PnPEYXmZpB1U7E2Ldtu+Yz43qVA6QeM
	jVXaXbaXw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUTfD-007xh8-O4; Thu, 08 Apr 2021 12:21:35 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUTdk-007xMy-1S
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 12:20:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=pg26BQIyu0VjrMGWu/ArS3FYgsreYBDzCz93KORJArk=; b=iFj1b8kZBmG3THgBUWsdLS9Nik
 jdvCBl9fPGiAfrc9vpp2xVHU8SzYvMeUM/Cqqk1eHbDibp/nCfMaoMqcXbF+llYKEyfeuCMDAuRgt
 f/u+kFB9Ernho03cN5GjLaoTjNa55suBDh69dgpm+1Ls5gvXWQAe+7r4yZAFeE8NLGQqvNJBq7FM1
 CyEE4Q/OtPuWFaTEzShXelI8ztCZ4VaWGrp/wSKerWlsP/rB0k2YTnabNcGnUoac8b8MC7J7wAdMG
 U27/jxREz+u87cXWzoABCEenNjlWKuXGalwLqfskOdsbmxdRFgIuHmmaOzEM58056uRGhcYbLPg3X
 VrMj26qw==;
Received: from [2001:4bb8:188:4907:196e:5227:9015:fba2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lUTdg-00HAU2-HQ; Thu, 08 Apr 2021 12:20:00 +0000
From: Christoph Hellwig <hch@lst.de>
To: Minwoo Im <minwoo.im.dev@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Kanchan Joshi <joshiiitr@gmail.com>,
 Javier Gonz??lez <javier.gonz@samsung.com>, linux-nvme@lists.infradead.org
Subject: [PATCH 09/13] nvme: factor out a nvme_tryget_ns_head helper
Date: Thu,  8 Apr 2021 14:08:38 +0200
Message-Id: <20210408120842.1450092-10-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210408120842.1450092-1-hch@lst.de>
References: <20210408120842.1450092-1-hch@lst.de>
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

Add a helper to avoid opencoding ns_head->ref manipulations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 98d87bff4ca37f..9637f2e5e9232c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -549,6 +549,11 @@ static void nvme_free_ns_head(struct kref *ref)
 	kfree(head);
 }
 
+static bool nvme_tryget_ns_head(struct nvme_ns_head *head)
+{
+	return kref_get_unless_zero(&head->ref);
+}
+
 static void nvme_put_ns_head(struct nvme_ns_head *head)
 {
 	kref_put(&head->ref, nvme_free_ns_head);
@@ -1975,9 +1980,7 @@ static const struct block_device_operations nvme_bdev_ops = {
 #ifdef CONFIG_NVME_MULTIPATH
 static int nvme_ns_head_open(struct block_device *bdev, fmode_t mode)
 {
-	struct nvme_ns_head *head = bdev->bd_disk->private_data;
-
-	if (!kref_get_unless_zero(&head->ref))
+	if (!nvme_tryget_ns_head(bdev->bd_disk->private_data))
 		return -ENXIO;
 	return 0;
 }
-- 
2.30.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
