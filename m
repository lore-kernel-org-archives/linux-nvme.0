Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43F6F4BB63
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Feb 2026 17:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3NkdLz8yeL0qjqcdMwFc/Rt+8wFzIyO9CzdhRe+Sgx0=; b=wfpgo38BGoOBNX4PRy8/xmvj17
	97MFC2xwz7qlB4/FEaz0eVlz9KxJ2KanQaRhDjLwNO0rDN1OLuXtRAfr3upO3mS4EGnr9IwQhSopX
	VAVQokCdShUBw2DAZTsVlolvRiLznqwV4o4nd1EiujSlEyy61Awh394LWKp9R5ZP8bWslH01ahPTq
	fCkPzcCBj2jmu5WZjia0+r+CgcbdBOcXS0vAwsKuqiXMpyYIuBHoY1e/fAswHQXKHe6PjTby637p7
	lt288TlaSUo9xU6Urg5B93td3Dln2AQ7gpdWX8ynNICmQLb9rdEuwdJ0bJvYweLCmpUniV83FJkUu
	G56KVpYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuw06-00000002SLb-40GA;
	Tue, 24 Feb 2026 17:15:10 +0000
Received: from mail-dl1-x1261.google.com ([2607:f8b0:4864:20::1261])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuvzz-00000002SFK-42Yr
	for linux-nvme@lists.infradead.org;
	Tue, 24 Feb 2026 17:15:06 +0000
Received: by mail-dl1-x1261.google.com with SMTP id a92af1059eb24-1277863a912so102693c88.0
        for <linux-nvme@lists.infradead.org>; Tue, 24 Feb 2026 09:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771953303; x=1772558103; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3NkdLz8yeL0qjqcdMwFc/Rt+8wFzIyO9CzdhRe+Sgx0=;
        b=OSI2g62B06kvvTQ69AJ/fwppZS+mom6ZaolgNkCWNcm+sEW0Mj2aJWaj/DD25o0IPX
         ZFklJZrxPy9pF4ckI70qtkQRXS+4m8LUzL22yInDTHfI8hi0OO4FjBRfkcQXnnkkRdSS
         2FXeHyLVx1h1aUqzuoFLRz1+j6LX5NJ6QuEA9begjYcV8TcU3pY/Wo6eqJHFWUjO+EAA
         Vq+2IO011rincT6wKkXB7YhuAfHC/HyRxw6h7p7JljUjw7sdm1XUGmFGWNG4YQkeenOj
         Tw74bwLoRTRPodSAQS5JA/C7PgIcYYkAbtRqkmRlOBwUqN99dTJO+Ktjv2MAJah/mk/A
         Hplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771953303; x=1772558103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3NkdLz8yeL0qjqcdMwFc/Rt+8wFzIyO9CzdhRe+Sgx0=;
        b=HU8PV8RkQY0xWDGBklPpzaYiyFe9Wu4ivVMRxiOeiR5M7h0Tba4XVnxWIBUxHVQhYZ
         51ZEYMFxqqKzjPigAOgJKtLpc5lNHzQaS6TAW7wVdgB/fUDv33q7STMH/jEKmHNsyfQR
         /QUzQLW/bZmjxXhlHSAskJs6AJAngtHBOXeKRfOm8dXOPEKa4LjOt+0SprAlWDlNW+Gp
         HfkF2f2E6XcF/CVfTREj7ruk9BWMN213EKHJs8JWEXSS7jA44uUbnNRRnoI+NUXh7ge3
         BKjkIBXSaHtQZyhi4ZkDIf34SYiYZFOkfgKjHvLKDI9RI0LPIPnu9/qXWbP51aPcTYAR
         1CQg==
X-Gm-Message-State: AOJu0YzH0+8iPquM0cSxPrUYZO1CiqaugnLoB9k1AoWRs+IozZgs1NHC
	qvtRmrLZlvYeUT8nLRF3GlcyzlOZz8yh/fW9kfm/t6wfJ9SrAedJrXuicBghphGT/k9AeoDwC2O
	TXwabO0PxBkWNCt55fGCDoiVYR8QlZ+MU980C
X-Gm-Gg: AZuq6aK7RP5xSZIRuwjSPSWZYrhdtg5lhunXgVqyxn5S3uV1pP1hSzFAwlfDhVDXk7L
	h+pC4Hw2FYcicgkxH1lsH3usjhkTd1ib9sMFyIWVyrccu47W/Wd5uGeshqBDvGH5qRVsz5HbsRZ
	B2KbIX0QhorVDTZS0YC9yIWIlvlqi4oIOCgFlhkIlNFHlIuoqWYTmB4/5nsSZzxzHG4kSu/Q9Ts
	OFrYsmK9XlSVhtpXx+LJXIBg27a9w5UVOm7Nw2h0M841A50sJE8zdfzgY/xifYFzuaxKKIzUoHN
	AcMwdmnw4ZT+izIqkCnn7T/fOk+wycKHxtroJhdaWYETv2nEC7APAS00Omu0G2Za4c5plZOKinS
	Qk15IgmmX3YArkIqV7/ARj/BQmIN3MfeHCXqy8KmgZPZvfcKClEnC1Q==
X-Received: by 2002:a05:7022:2589:b0:11e:332:1e01 with SMTP id a92af1059eb24-1276ad03aa3mr2503487c88.3.1771953302910;
        Tue, 24 Feb 2026 09:15:02 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-1276af6346fsm1377580c88.5.2026.02.24.09.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 09:15:02 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id D4E3B340705;
	Tue, 24 Feb 2026 10:15:01 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id CFEBAE41254; Tue, 24 Feb 2026 10:15:01 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 6/8] nvme: set discard_granularity from NPDG/NPDA
Date: Tue, 24 Feb 2026 10:14:35 -0700
Message-ID: <20260224171437.3175993-7-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260224171437.3175993-1-csander@purestorage.com>
References: <20260224171437.3175993-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260224_091504_005529_26BD6BEC 
X-CRM114-Status: GOOD (  22.45  )
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
 drivers/nvme/host/core.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2b433478f328..a9e8936b480d 100644
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
@@ -2113,11 +2114,37 @@ static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
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
+	lim->discard_granularity = max(npdg, npda) * lim->logical_block_size;
 
 	if (ctrl->dmrl)
 		lim->max_discard_segments = ctrl->dmrl;
 	else
 		lim->max_discard_segments = NVME_DSM_MAX_RANGES;
@@ -2380,11 +2407,11 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
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


