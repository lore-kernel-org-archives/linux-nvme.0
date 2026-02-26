Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14587FD8FFC
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 19:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ooHjh6HrTZHmSmxByDLdiCmY2zTnKYEXcZkNLfcMiWM=; b=4QKa0o6DggJRGmpceH1d16EKRE
	mHhF7yRP54uKGmHpYOjEWNW6C1GSvTQW5g8MyHjiZM8vlX6Ho0iwN+IgvlP4Hw1R/ckzgQMt+qfsu
	297QP3BG0iSPBxgouXzCQK860/QXuGw2zwFXRFbfVIFukBUwSLgieqci1K0zUJg6PUOk6YrfrOC3L
	VW7AzZi9kY9LmPnZVJgP+mVQlhXUbTU5+KkUziUGltm4sGWrMtposAqUaF52oIxYUq0qeR7d4j7p9
	NG5FWPKXgVPE91tBAqW2Pi9ewk5iLK4yIPWBM9hLEuvSJp5TzoHc7rwQw3YkAdrTw6EhLwtjG88dc
	O4wPdKuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvgex-000000070VI-29kg;
	Thu, 26 Feb 2026 19:04:27 +0000
Received: from mail-pl1-x661.google.com ([2607:f8b0:4864:20::661])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvges-000000070RD-1uZF
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 19:04:24 +0000
Received: by mail-pl1-x661.google.com with SMTP id d9443c01a7336-2ada9de70bcso2716625ad.2
        for <linux-nvme@lists.infradead.org>; Thu, 26 Feb 2026 11:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1772132661; x=1772737461; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ooHjh6HrTZHmSmxByDLdiCmY2zTnKYEXcZkNLfcMiWM=;
        b=b2ypIHJNzNfnuxEjj9hfLbQcQfBulxa4MRI/MwTO/YUVEoXycRcZJ3EqzrJe1vX+lB
         DJWczT+ycsWgXUCfhlXADK/AM4wOxw7pbK3EKHer1lQYq1757UaTh8EgNF+rQjONvlpk
         rDHJ2S6oBweF2KeWTCqtMu1OL95PVpShRM/tdy+wFgf7xvmm8kdMauGK82FSlbRUvubs
         6NwL6rLh8JxhqXwv7SNo3r8/IUMG0XPenrmWEbQsyLl0W5ndIuQlEtdcmwm1w82B8O3x
         Ki2uNrCPyNumbfQtkhJjMwWRsPB2fUCVS2wUbnZCk0+jq4D/nJ3z3Kb9hw4NmZvkbxFA
         g6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772132661; x=1772737461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ooHjh6HrTZHmSmxByDLdiCmY2zTnKYEXcZkNLfcMiWM=;
        b=FwmqjWAN7OQGYQ9sgDWVljOl3VodRBGMvt1NxpGtUtHL1pQ+6XaCXsYuyrP1pgwtcY
         drJMNuIH/3dLzEC2AxJ3xIEI9RIbQ2cjcnDOkX78yOPdC15z8VnZD3hh517mpQpVK8Zg
         YJglDvmgesZbE9Sn06hhvigJSq3GRxZiFydcfOjvsnkvGOh7O7EqqAhUkvDWzw5W5k9w
         IPq2EZu1ab4/reTxnMIrDuTHdAT26c4MHL/WTI/oTnj+G+btkOumHGrABTQeZSWJ7L3/
         D+B8fIKYcGJ/xtmb1z/x7oPmhVmmXcwKwqJwkQ5gUhxEIQL+lomj44GYLC9DGpHTdYkn
         4p1w==
X-Gm-Message-State: AOJu0Yyxu0fo9SzRtUYHetStz0sQ1HzuqcSwRiIP0ZPe6u53GfsPkj6t
	/Y9dxvAs4LzhTs902ctOgVAOD0IwlB7auiPcvgfZR2ebtUQbISBfNPqRGqGkeq2HwpKusneUwLY
	3hIa6xgQnOfvCIJUi6eTWy4SL4KdZ7Bt54XW0
X-Gm-Gg: ATEYQzxKcRmlHbng4DnJ/X7w9Ho6xliOPNzMC/oc/+Ubd8G/gK7Y/TBtrvde/bEHkYX
	Q60Sw04X/MYlsC4MH8egropLXs/5nXRlO/v2MQyfMHOGm56v3wDJeviVBnYJ5DDl6QDLZabI0e9
	/MU/Hxb6BTSWXWTv195Ykrr1OBZdSxYvsEAzRF9CKq6jUBYeaOBQ+qMwIwDtLitnoZ6r2Q1SNgl
	CDvSYKtx4zl+25XezLd3iiSSSHwyWoaK/vnPNwJSz0LC3Lg8FLUxs5w1CcDH+9A2AbPf2EPb6Q7
	q+D/E2YdleeqFygLqO+unSM7b8TN4VbFlYJwhr/idwGDte8VPr6h9XN2sBqns7hwStkHX+ovvJf
	AYjqgh9zxgbfw2QUk/3BHm1kJI1oN8sKNBPDFNXWPnm6QNBaGGFho4g==
X-Received: by 2002:a17:903:1a4d:b0:2ad:c651:46f with SMTP id d9443c01a7336-2ae2e1322d5mr254715ad.0.1772132661273;
        Thu, 26 Feb 2026 11:04:21 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2adfb05e386sm3591335ad.1.2026.02.26.11.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 11:04:21 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 1F2E63407D1;
	Thu, 26 Feb 2026 12:04:20 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 19D67E41254; Thu, 26 Feb 2026 12:04:20 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v4 3/8] nvme: update nvme_id_ns OPTPERF constants
Date: Thu, 26 Feb 2026 12:04:10 -0700
Message-ID: <20260226190416.297725-4-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260226190416.297725-1-csander@purestorage.com>
References: <20260226190416.297725-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_110422_519407_F0145968 
X-CRM114-Status: GOOD (  15.77  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In NVMe verson 2.0 and below, OPTPERF comprises only bit 4 of NSFEAT in
the Identify Namespace structure. Since version 2.1, OPTPERF includes
both bits 4 and 5 of NSFEAT. Replace the NVME_NS_FEAT_IO_OPT constant
with NVME_NS_FEAT_OPTPERF_SHIFT, NVME_NS_FEAT_OPTPERF_MASK, and
NVME_NS_FEAT_OPTPERF_MASK_2_1, representing the first bit, pre-2.1 bit
width, and post-2.1 bit width of OPTPERF.

Update nvme_update_disk_info() to check both OPTPERF bits for
controllers that report version 2.1 or newer, as NPWG and NOWS are
supported even if only bit 5 is set.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/nvme/host/core.c | 8 +++++++-
 include/linux/nvme.h     | 6 +++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8dda2fe69789..bff6f26d7bcf 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2062,10 +2062,11 @@ static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
 	struct nvme_ns_head *head = ns->head;
 	struct nvme_ctrl *ctrl = ns->ctrl;
 	u32 bs = 1U << head->lba_shift;
 	u32 atomic_bs, phys_bs, io_opt = 0;
 	bool valid = true;
+	u8 optperf;
 
 	/*
 	 * The block layer can't support LBA sizes larger than the page size
 	 * or smaller than a sector size yet, so catch this early and don't
 	 * allow block I/O.
@@ -2076,11 +2077,16 @@ static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
 	}
 
 	phys_bs = bs;
 	atomic_bs = nvme_configure_atomic_write(ns, id, lim, bs);
 
-	if (id->nsfeat & NVME_NS_FEAT_IO_OPT) {
+	optperf = id->nsfeat >> NVME_NS_FEAT_OPTPERF_SHIFT;
+	if (ctrl->vs >= NVME_VS(2, 1, 0))
+		optperf &= NVME_NS_FEAT_OPTPERF_MASK_2_1;
+	else
+		optperf &= NVME_NS_FEAT_OPTPERF_MASK;
+	if (optperf) {
 		/* NPWG = Namespace Preferred Write Granularity */
 		phys_bs = bs * (1 + le16_to_cpu(id->npwg));
 		/* NOWS = Namespace Optimal Write Size */
 		if (id->nows)
 			io_opt = bs * (1 + le16_to_cpu(id->nows));
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 1134e6bf2d5c..d840f5fe79fa 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -595,11 +595,15 @@ enum {
 };
 
 enum {
 	NVME_NS_FEAT_THIN	= 1 << 0,
 	NVME_NS_FEAT_ATOMICS	= 1 << 1,
-	NVME_NS_FEAT_IO_OPT	= 1 << 4,
+	NVME_NS_FEAT_OPTPERF_SHIFT = 4,
+	/* In NVMe version 2.0 and below, OPTPERF is only bit 4 of NSFEAT */
+	NVME_NS_FEAT_OPTPERF_MASK = 0x1,
+	/* Since version 2.1, OPTPERF is bits 4 and 5 of NSFEAT */
+	NVME_NS_FEAT_OPTPERF_MASK_2_1 = 0x3,
 	NVME_NS_ATTR_RO		= 1 << 0,
 	NVME_NS_FLBAS_LBA_MASK	= 0xf,
 	NVME_NS_FLBAS_LBA_UMASK	= 0x60,
 	NVME_NS_FLBAS_LBA_SHIFT	= 1,
 	NVME_NS_FLBAS_META_EXT	= 0x10,
-- 
2.45.2


