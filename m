Return-Path: <SRS0=DeHG=HD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC87C433E9
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 18:30:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77DA864E2C
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 18:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77DA864E2C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:To:From:Subject:References:Mime-Version:Message-Id:In-Reply-To:Date:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+VuPwnZamrG9XpXalIFCMdTXGow2t15UtzwfvKqtTQc=; b=a+r+E60K8mtW93rhVnaDftuAyb
	4V8NaDG1RICrx0eaNrVMmyLvRbWKlTqcBQH2KOWPg+DRQwAgb3IxAh/kfirXyWWilpuOtaktWMmk6
	OCDtNJEBJ5mmRz3qFMZPSd02vibd4aOQMo7jJr1bKXSoXwFcepszPVLpBc4Jm4IeeTOrNflhAhDUX
	ItgoWPWErL2ahoGV8I4kCLfI88P4s9libyoUgiMQydt44x1S8l1n3+CPRNOtUW7MeO4hH5W2khReo
	TdyCxADeLhpoSQLhrTnFnvi+Iin/3r0r9YCAdzEtqz4KGkly9jVz+HUgJFfjoK39/cP4+IOD+oTlp
	XZ1cQR4g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6dy2-0000ea-VK; Mon, 01 Feb 2021 18:30:31 +0000
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6dxy-0000cs-Da
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 18:30:28 +0000
Received: by mail-pf1-x449.google.com with SMTP id t13so11326860pfg.13
 for <linux-nvme@lists.infradead.org>; Mon, 01 Feb 2021 10:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to; bh=dv/wJr+V9NRV+lolRhI4CVLaEjJrVVBI8C3cibP+WBU=;
 b=Lj3UyKxA8lOIDGcPlpqgpnIQ+ae5rtq8GZJ3tw2mo4cgWWi5PDLt0PQL1ceiR7DkDT
 fsn7U8UN+bqxxlHbLikEDWaglidRgQkkFYiDgTHcsS82JHwwx7gJtiYdyllzS5oNcaWC
 Eg/jeZpIVEEtoFwS/sAagES8+4KsAUqFWJauvb3OSw+rWHAxuwBZDOO2pzJYGxTwRa3i
 6b9k7zhAfI8DOS7uaEO/5PWyeY3tCZ/Y8/padIigVO7e+pLSphaeaBtA4lxv18bUw0Hb
 T0XuC3AQhuA5yRyaXcr1PL8TRMjE6yZNayj7+MSPQdQWYa+Q1XTmQ8XLb4lcAkkwvub7
 l3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to;
 bh=dv/wJr+V9NRV+lolRhI4CVLaEjJrVVBI8C3cibP+WBU=;
 b=OB+taTFJBzMCXiXMXBP34d8KdqggD/x42eqXqMMPyQ+x3OOkJPb1q+xSD8Wk7F1qCB
 pv5ljyTBjmqcOQWapXx/QxzMdHkxt3fQ65cUKsWQvxH7lKiq7xX0yFK9fDSwRYb8M9lz
 xCCSGYcQpcB1gEsWwKbR0IIlfuQNhnArE+3T5QPP98B2AtU8UiFJWVUE8pS1dYoyTu8w
 zNN6JiOv8LV+ASBgyLixpa3ObX2Bo/eXgbIoK+hOHBYG9tE8q2rCnvBeYpEC05aRxn/c
 c1nTHmtL9PVAZyFa7kXTiHCBur+q+1Za5TPj877YvLDGz/nwlQWN9C5X4R4lz45LvtW/
 EuiQ==
X-Gm-Message-State: AOAM532SKrpXa0gyaUVrO4N134HP+sSvLr66uDohyH7OP2wi0EsMa3RT
 Aiwyj2N9Jh38NtFuzQLx0EMGNmNTSw==
X-Google-Smtp-Source: ABdhPJyh03Hh5IPZa/NXKVXEfxYK+v8U+Q/6t0H4LGYsfl6XIq6w4GCzICateDGeGMpAGtpLIcmYglBU8Q==
X-Received: from jxgao.kir.corp.google.com
 ([2620:0:1008:11:695f:7f9e:413c:e3c7])
 (user=jxgao job=sendgmr) by 2002:a17:90a:d58a:: with SMTP id
 v10mr196883pju.9.1612204223378; Mon, 01 Feb 2021 10:30:23 -0800 (PST)
Date: Mon,  1 Feb 2021 10:30:15 -0800
In-Reply-To: <20210201183017.3339130-1-jxgao@google.com>
Message-Id: <20210201183017.3339130-2-jxgao@google.com>
Mime-Version: 1.0
References: <20210201183017.3339130-1-jxgao@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH V2 1/3] Adding page_offset_mask to device_dma_parameters
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
X-CRM114-CacheID: sfid-20210201_133026_578634_5AE7C019 
X-CRM114-Status: GOOD (  18.13  )
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
index 1779f90eeb4c..7960bf516dd7 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -291,6 +291,7 @@ struct device_dma_parameters {
 	 * sg limitations.
 	 */
 	unsigned int max_segment_size;
+	unsigned int min_align_mask;
 	unsigned long segment_boundary_mask;
 };
 
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 2e49996a8f39..27ec3cab8cbd 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -500,6 +500,23 @@ static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
 	return -EIO;
 }
 
+static inline unsigned int dma_get_min_align_mask(struct device *dev)
+{
+	if (dev->dma_parms)
+		return dev->dma_parms->min_align_mask;
+	return 0;
+}
+
+static inline int dma_set_min_align_mask(struct device *dev,
+		unsigned int min_align_mask)
+{
+	if (dev->dma_parms) {
+		dev->dma_parms->min_align_mask = min_align_mask;
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
