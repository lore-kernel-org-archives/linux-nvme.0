Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E027DC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 00:39:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75D5C64DD1
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 00:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D5C64DD1
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:To:From:Subject:References:Mime-Version:Message-Id:In-Reply-To:Date:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fCdDsgStuMM+A8UfX4tYMBFEn7gw3qLSb3ekYW+w7jA=; b=aXRWeFvE+MUHy0o907+abx8Ujd
	suFmkdHaumsBlrWXBM8EWuNfUxu8oJ7jH09NW2WhkfOa+w3f3zm3FL1J9viMpD0TRYwnKsL9jTj4x
	LgTnjeW+qxIiwOQgH4Fr2A6Ut8A0b4tKxqDheJgMBeolzeq1mCSUezhtTl1up3xcYDBLCFPOLGahR
	C+chMgdHfawcXZEeMH78Y29KQAarR7qLVHakiEHZH8OWG4wPe2PcrR9VbfdF7gecH4iKprbeebC+I
	9QnzHqt9V6NQpe8p82LjR1+KOslfOIOgcgICQ2wOFMi5+dsd4hbBCwa+NWP/Ms6hVgxHm3Riayy0i
	DVQjCjlw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4vKs-0006Gm-AM; Thu, 28 Jan 2021 00:38:58 +0000
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4vKl-0006F0-HS
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 00:38:52 +0000
Received: by mail-pg1-x54a.google.com with SMTP id 18so2645022pgf.19
 for <linux-nvme@lists.infradead.org>; Wed, 27 Jan 2021 16:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to; bh=4W4Mz7FARh9nT3HFppHTQnTZcP4AiXiO2tmblYeh7WE=;
 b=Eb4iPku8cZ0Vn7Ei3aQgJpwqmbI/1Jr3DYPfQ13tzINxjrf9Ulm40ki5zV8pC9Yap9
 Yyx8MrkyRbwP9IyEhZZDYoXDExVmMYlIO4/QGrvet29VCDBr8Fo5W0XG1xpkCGb9O04K
 xPmVNDYGnaIhJadfgRiSdMkQKEL5jhQvVV+lnkcKlMlTnrSZc32FxCZ/3//vMJGZNUOj
 mRLa6hTfO8o/ei9CRZnNDxeT6NAfg8gLjKprLbSIk6CeI+rj6RW0JrVknZEcq2liQnb4
 F90qbiiR8ek5wnxSA8hUomCWoPKIyyueIiGtYwSWRTLU00HKIXkQSrTuuOtjJnqopyl3
 fZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to;
 bh=4W4Mz7FARh9nT3HFppHTQnTZcP4AiXiO2tmblYeh7WE=;
 b=qgO1Dcs/8rbDIvywy536jGSiuJoxg5r3h+TAR6njSe57NejqUOBulTxcNNb7U+xaWZ
 bXJb/US0a+FK9fC+4px5Z9BW3MgLTrLu6TMfWYSaDPDmch+HKTS4kd1L9Ok7D6hhiVQe
 cCaIZ/wqqYURdVWgZgjkf73nya/bbptZf86gjdER7pJQC2ZU08F0DQje2WfCV+rgVC0G
 EQbkD+HGTJO8kFGXXuKGpkyhT/J6f0EoNo5phoNgaaDORL+tXoN2RDN4L5SoOrxwhT/i
 1roba6gK+J3Gan1muEnXUS5SRkBEec0J+vd7dCKCuUWyx+gY+tWNcrNKh+FUWbOAPV+Y
 vi1w==
X-Gm-Message-State: AOAM530xOLiMNzj/9La2/JkupzODVhzT1c+DSvMcRRFK2MmY0KPjHNWT
 92JtXw8slADHCmbo4y08IBeUML12+Q==
X-Google-Smtp-Source: ABdhPJxLTPQsZ3ALIjHtj1aD58QbrBkOE/Y0s5GW7Sn3xRBoflafftwJdJ89PE1InRUmNhSb23g5V+c0sg==
X-Received: from jxgao.kir.corp.google.com
 ([2620:0:1008:11:4d90:620d:7a68:ffc5])
 (user=jxgao job=sendgmr) by 2002:a05:6a00:851:b029:1b3:fbb3:faed with SMTP id
 q17-20020a056a000851b02901b3fbb3faedmr13331958pfk.18.1611794323323; Wed, 27
 Jan 2021 16:38:43 -0800 (PST)
Date: Wed, 27 Jan 2021 16:38:27 -0800
In-Reply-To: <20210128003829.1892018-1-jxgao@google.com>
Message-Id: <20210128003829.1892018-2-jxgao@google.com>
Mime-Version: 1.0
References: <20210128003829.1892018-1-jxgao@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH 1/3] Adding page_offset_mask to device_dma_parameters
From: Jianxiong Gao <jxgao@google.com>
To: jxgao@google.com, erdemaktas@google.com, marcorr@google.com, hch@lst.de, 
 m.szyprowski@samsung.com, robin.murphy@arm.com, gregkh@linuxfoundation.org,
 saravanak@google.com, heikki.krogerus@linux.intel.com, 
 rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com, 
 dan.j.williams@intel.com, bgolaszewski@baylibre.com, jroedel@suse.de, 
 iommu@lists.linux-foundation.org, konrad.wilk@oracle.com, kbusch@kernel.org, 
 axboe@fb.com, sagi@grimberg.me, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210127_193851_641037_15FAF9B9 
X-CRM114-Status: GOOD (  16.73  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Some devices rely on the address offset in a page to function
correctly (NVMe driver as an example). These devices may use
a different page size than the Linux kernel. The address offset
has to be preserved upon mapping, and in order to do so, we
need to record the page_offset_mask first.

Signed-off-by: Jianxiong Gao <jxgao@google.com>
---
 include/linux/device.h      |  1 +
 include/linux/dma-mapping.h | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 1779f90eeb4c..f44e0659fc66 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -292,6 +292,7 @@ struct device_dma_parameters {
 	 */
 	unsigned int max_segment_size;
 	unsigned long segment_boundary_mask;
+	unsigned int page_offset_mask;
 };
 
 /**
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 2e49996a8f39..5529a31fefba 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -500,6 +500,23 @@ static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
 	return -EIO;
 }
 
+static inline unsigned int dma_get_page_offset_mask(struct device *dev)
+{
+	if (dev->dma_parms)
+		return dev->dma_parms->page_offset_mask;
+	return 0;
+}
+
+static inline int dma_set_page_offset_mask(struct device *dev,
+		unsigned int page_offset_mask)
+{
+	if (dev->dma_parms) {
+		dev->dma_parms->page_offset_mask = page_offset_mask;
+		return 0;
+	}
+	return -EIO;
+}
+
 static inline int dma_get_cache_alignment(void)
 {
 #ifdef ARCH_DMA_MINALIGN
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
