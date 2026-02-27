Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D7D81039894
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Feb 2026 20:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=molQjRNkREdyjvwmEw0xTnEivvMWYPvHvzLTsL4IEEk=; b=IoinGtV+foQ1itICbfWIeqtJzg
	vJMvUguA2iBGvOlaM3TnN9umb3gpfb8HQ2PY+JGaXZ79Wj+q/gXqpfmdSBPGaAy2Ibyt5UUlColCu
	EVjGcJNA3wncrmuJJSy3Rn+wn3r/aVRYVl5oIgYPaj99ck1fN8qU/kmF2KaNArh71LBUdGMaTFlfX
	lJOzl7XysUSqjENV4feK3IH4ZdkCTeLMIm79NqOtHXtQC8ngY2Lr3iVry9HwpD+idL+ta76YKrB/1
	gCXX8bCSFBO9pQmvmTOvS4++YUSJcPf93m4E2OMUd1A/c4OS/WEU75w2rRuQKL4ISj+6WRBbEu/Uy
	SO17KYEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw4Ni-000000096Tn-2J3Z;
	Fri, 27 Feb 2026 20:24:14 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw4Nh-000000096Sx-2obi
	for linux-nvme@bombadil.infradead.org;
	Fri, 27 Feb 2026 20:24:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=molQjRNkREdyjvwmEw0xTnEivvMWYPvHvzLTsL4IEEk=; b=d6yYb2nISDnzV5h57fcjcnckSS
	WrQpkfcUxnPAGoJ2KOLrO4EdkfS+7asb+lGEShiMyAUxhv6AGArjdnEosORl4Efx8a87WM9TgCwKl
	+wpPayiDGjw/gn9/T42sxQChQI/GTiclGcsSptLMmxwfUJEPbyW8bsfUdaLtsvkBVIamb30U47X8O
	V1x8JZWbj3KL4x27o/vQD/LfPOo+oM00LBud/wlTUa96YAaWjv8LZHqIIoOglVUB/GKgznZsSxG4n
	xMsrIPshv2/G47/aWd/W+FnwA29uOdw9ttrBjqvY+Id5wXLULact4XeRY1VcvyHOChqOPgaj9tUXJ
	PDzPzs9w==;
Received: from mail-qt1-x862.google.com ([2607:f8b0:4864:20::862])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw4NZ-0000000Dt7A-1Cvr
	for linux-nvme@lists.infradead.org;
	Fri, 27 Feb 2026 20:24:12 +0000
Received: by mail-qt1-x862.google.com with SMTP id d75a77b69052e-5032e59c8d3so2810021cf.2
        for <linux-nvme@lists.infradead.org>; Fri, 27 Feb 2026 12:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1772223842; x=1772828642; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=molQjRNkREdyjvwmEw0xTnEivvMWYPvHvzLTsL4IEEk=;
        b=WFaNQD5PaaH8EnGEOPirF7VzxWd/T3ebj3HF5kD27nZdGjieGA43r2SJWwhmu6nL6a
         3WNgaSyuqdJxozHIAo6muw0aATQuES1DAAp45mqSwm85+OaTVcan/xmztKDVb5LyLIZ6
         DnqsqCXAt2SQNU4MSLmF6tgEEFnh6JlO2r2I2WYL994e+wc7BAu6J0hcwTQ3P80YX45k
         JcRBJqB7BmN6cog/OJ9BAtxMMIzo+MFhotPttrd3oSigedqQz/KH/vtu/MjIIVLCd/It
         xkn6bZ4dHLdwueclM+DoT1iZZN1dXFDer4wikhMPrSXkv0hrdkP9w62I+yNbVnvHkUs3
         vkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772223842; x=1772828642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=molQjRNkREdyjvwmEw0xTnEivvMWYPvHvzLTsL4IEEk=;
        b=kpIrwlheq6biKkhvZZ+2IA+Jqwz6E7j33QdGzQ332Gr79Td1LK0im/RM+lNMMFqGmt
         MjuRm/vD/cA5hSJZtIlc0SNnF7o90cTe2CC03jUzTcmFg4IOVF4QwLG0d/m0LiMxr5EG
         vF6b2WjotcAHSaAatw2BpJ9rGwbQbh2dczngyk4ULP1JM0EcdlJtdbwLeiGSbUmeEn8i
         7kFAKtf6K5DjZ1F5I885qcTBRpwZGBkb3zNeJRpVv6c48YH6QZMKCRF9V7jW6EntTSXm
         ESCQI1mQaARvnyDtNKFI1t7Vz60ee8Uc6J59YFnRjaUl/LoygepyoYQcy0xm6jDD4KGx
         tqcQ==
X-Gm-Message-State: AOJu0YwSamKwOyU3CzBD/gDTo5m9qeiQ2JoUSDLP3MvdmOinscs+WPg1
	hPfKsUk1Haf35dXmJ8CAzcffrYkARZRzSMr1762gRDYUuTxbPTWH5PhQKoLSc+6j9usdSxBJJyJ
	tKnd1GSDfpN5+/Zv0ZJERnWGjUegAs6UEZHoZ
X-Gm-Gg: ATEYQzzzGFrkBO5LUDreFhUsj0kIywZsdW519cT4/JOYgjlzGlEcgck2dB1IfVAzijo
	jYwqXwPi6Www582GLx7UZZ07kQNuEc4SsPnypcTdbuSBm1mIfNFZSSW/BR7KXTi9Msn3RkC9g02
	oOo5fdaWCZKnypYA/08GtZQJsjRqUBgFXgMolLjPbaGG9MdHhXcoJ6/tw0XXDQ2k3Wn9pyB0nrB
	xIGAop6N9XiEoLiN8IpOZpVECRiqGnCGIATjAQo/t/w8qc1tsws8V6IDm60VKFjXryXVlxCP641
	Pef3Sj58l5ZSQVHC5UEIfVUkMEwOV03f6x6ZxtaW3LdI0uaxYklMZ33bVOiA2u9nRFvk3QyLLJ4
	hFFG1I/IWUVqyIcWxCN5Yswtqu/x7NJPvuRodi0hcDkeiR0/g6m9jlA==
X-Received: by 2002:a05:622a:1907:b0:4f1:dffa:7834 with SMTP id d75a77b69052e-507529a2b84mr38843961cf.7.1772223842069;
        Fri, 27 Feb 2026 12:24:02 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-50744a369d9sm7627921cf.5.2026.02.27.12.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 12:24:02 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 34BF93422B0;
	Fri, 27 Feb 2026 13:24:01 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 2E4D4E420D8; Fri, 27 Feb 2026 13:24:01 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v5 6/8] nvme: set discard_granularity from NPDG/NPDA
Date: Fri, 27 Feb 2026 13:23:51 -0700
Message-ID: <20260227202354.1012322-7-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260227202354.1012322-1-csander@purestorage.com>
References: <20260227202354.1012322-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_202410_545747_643258EC 
X-CRM114-Status: GOOD (  21.99  )
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

Currently, nvme_config_discard() always sets the discard_granularity
queue limit to the logical block size. However, NVMe namespaces can
advertise a larger preferred discard granularity in the NPDG or NPDA
field of the Identify Namespace structure or the NPDGL or NPDAL fields
of the I/O Command Set Specific Identify Namespace structure.

Use these fields to compute the discard_granularity limit. The logic is
somewhat involved. First, the fields are optional. NPDG is only reported
if the low bit of OPTPERF is set in NSFEAT. NPDA is reported if any bit
of OPTPERF is set. And NPDGL and NPDAL are reported if the high bit of
OPTPERF is set. NPDGL and NPDAL can also each be set to 0 to opt out of
reporting a limit. I/O Command Set Specific Identify Namespace may also
not be supported by older NVMe controllers. Another complication is that
multiple values may be reported among NPDG, NPDGL, NPDA, and NPDAL. The
spec says to prefer the values reported in the L variants. The spec says
NPDG should be a multiple of NPDA and NPDGL should be a multiple of
NPDAL, but it doesn't specify a relationship between NPDG and NPDAL or
NPDGL and NPDA. So use the maximum of the reported NPDG(L) and NPDA(L)
values as the discard_granularity.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/nvme/host/core.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c3b24fcb2274..84d7dad4aeed 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2055,16 +2055,17 @@ static void nvme_set_ctrl_limits(struct nvme_ctrl *ctrl,
 	lim->max_segment_size = UINT_MAX;
 	lim->dma_alignment = 3;
 }
 
 static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
-		struct queue_limits *lim)
+		struct nvme_id_ns_nvm *nvm, struct queue_limits *lim)
 {
 	struct nvme_ns_head *head = ns->head;
 	struct nvme_ctrl *ctrl = ns->ctrl;
 	u32 bs = 1U << head->lba_shift;
 	u32 atomic_bs, phys_bs, io_opt = 0;
+	u32 npdg = 1, npda = 1;
 	bool valid = true;
 	u8 optperf;
 
 	/*
 	 * The block layer can't support LBA sizes larger than the page size
@@ -2113,11 +2114,39 @@ static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
 	else if (ctrl->oncs & NVME_CTRL_ONCS_DSM)
 		lim->max_hw_discard_sectors = UINT_MAX;
 	else
 		lim->max_hw_discard_sectors = 0;
 
-	lim->discard_granularity = lim->logical_block_size;
+	/*
+	 * NVMe namespaces advertise both a preferred deallocate granularity
+	 * (for a discard length) and alignment (for a discard starting offset).
+	 * However, Linux block devices advertise a single discard_granularity.
+	 * From NVM Command Set specification 1.1 section 5.2.2, the NPDGL/NPDAL
+	 * fields in the NVM Command Set Specific Identify Namespace structure
+	 * are preferred to NPDG/NPDA in the Identify Namespace structure since
+	 * they can represent larger values. However, NPDGL or NPDAL may be 0 if
+	 * unsupported. NPDG and NPDA are 0's based.
+	 * From Figure 115 of NVM Command Set specification 1.1, NPDGL and NPDAL
+	 * are supported if the high bit of OPTPERF is set. NPDG is supported if
+	 * the low bit of OPTPERF is set. NPDA is supported if either is set.
+	 * NPDG should be a multiple of NPDA, and likewise NPDGL should be a
+	 * multiple of NPDAL, but the spec doesn't say anything about NPDG vs.
+	 * NPDAL or NPDGL vs. NPDA. So compute the maximum instead of assuming
+	 * NPDG(L) is the larger. If neither NPDG, NPDGL, NPDA, nor NPDAL are
+	 * supported, default the discard_granularity to the logical block size.
+	 */
+	if (optperf & 0x2 && nvm && nvm->npdgl)
+		npdg = le32_to_cpu(nvm->npdgl);
+	else if (optperf & 0x1)
+		npdg = from0based(id->npdg);
+	if (optperf & 0x2 && nvm && nvm->npdal)
+		npda = le32_to_cpu(nvm->npdal);
+	else if (optperf)
+		npda = from0based(id->npda);
+	if (check_mul_overflow(max(npdg, npda), lim->logical_block_size,
+			       &lim->discard_granularity))
+		lim->discard_granularity = lim->logical_block_size;
 
 	if (ctrl->dmrl)
 		lim->max_discard_segments = ctrl->dmrl;
 	else
 		lim->max_discard_segments = NVME_DSM_MAX_RANGES;
@@ -2380,11 +2409,11 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	ns->head->nuse = le64_to_cpu(id->nuse);
 	capacity = nvme_lba_to_sect(ns->head, le64_to_cpu(id->nsze));
 	nvme_set_ctrl_limits(ns->ctrl, &lim, false);
 	nvme_configure_metadata(ns->ctrl, ns->head, id, nvm, info);
 	nvme_set_chunk_sectors(ns, id, &lim);
-	if (!nvme_update_disk_info(ns, id, &lim))
+	if (!nvme_update_disk_info(ns, id, nvm, &lim))
 		capacity = 0;
 
 	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
 	    ns->head->ids.csi == NVME_CSI_ZNS)
 		nvme_update_zone_info(ns, &lim, &zi);
-- 
2.45.2


