Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01FA4C531F8
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 03:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D7v4Jlt69J0HoetHkHttpCb1bOrq9W3em9yk/dBmRx4=; b=zTX05hhyIO8MGARsWcAFHDQY5E
	RrP1IhyZWe2SA7fEEU15Q2EXENjDB75ZjLjN/0JDT1abXKCmUArDoJ2QvFPB5UGjldpqoC+E8KQCQ
	YuicaxNXLCRADMab7vpqDbGYMLm7HinqwFS8PCBzutC8vgCLAEN/GlUSxilCP/g+jc22k1VzkRjUz
	FhpfxTrmyURHql6gzhweXai7+j0dUvrzRbOD3n90Jmve0+HBZsG7P+7RBr+PXfzn8VTCsrnteIkAG
	Twq0Evz2/L+tfjpnkRDfuclGmzjB3wPJngk1wGXpDI2O3tLdwQGw5UNRpQiElj1OQJ+EVXad4/f5G
	29Pn/usA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtHBo-0000000DABE-3OlD;
	Fri, 20 Feb 2026 03:28:24 +0000
Received: from mail-dl1-x1264.google.com ([2607:f8b0:4864:20::1264])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtHBj-0000000DA81-1a6D
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 03:28:20 +0000
Received: by mail-dl1-x1264.google.com with SMTP id a92af1059eb24-124a7216c9cso166660c88.0
        for <linux-nvme@lists.infradead.org>; Thu, 19 Feb 2026 19:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771558098; x=1772162898; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7v4Jlt69J0HoetHkHttpCb1bOrq9W3em9yk/dBmRx4=;
        b=WfquboP1qAgkuaSXAtNdUYg7Def5s9/mTh9pAnjnzIFPwlWVG4ejMYVhsBlRCArss7
         GNK4gfJXMV8/nQ4mbTPpG0q41i+ShL1bjh4bcGafcQoDA77Vn5oh1JBb3ReMUs1YH+rR
         O8Y/QUjfFQfwc/83M/VazOjfMG5Nq45DKe9Olqx48AD7+m/k+5tHoUUgSq7gTYzl2MFn
         rCVH9xi0lcOURaQffmmBOi5RejhfL2ijWRWFvENYfbTt9xjnqwMP8wNST/jBSmgs0tcO
         t6MzROsXZDc7JUN1kMhKahrMdVetAQJDQAjihXd2As+Z0i7JcMpyzh0/fVq4rmiIf8+3
         rZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771558098; x=1772162898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D7v4Jlt69J0HoetHkHttpCb1bOrq9W3em9yk/dBmRx4=;
        b=BUn5IdD8AK64JXrriepy8xCkPpKeq4FklfpbLZ+ffWOhP/24Wu41ymSqctnFGkP/k+
         F5lnFiQ/53yAHkZ+4/MlDgDqqR6t7ZUmsEci9D+ss37ZLOKN6ifgyPZJoKZMQnwOV5r8
         LErzAwIuQweXWk9Ddf18QWp/ZKJV75tt3+aZzeRMU3KGgiUw9dqGpSR+OMZ7RiayMvG+
         LFCjoyALZMrVl0QLPSQA7pk25NbnfwDJboMJIqFwveG11oy/b2QcUu5yO2t64ygm1nlQ
         hDX0/L5R+s7NUiC//CRq1zSMhME2u/8zVbIx1akNP4xUSb7Okvem6In9bEgL8S6B3tA+
         n7uw==
X-Gm-Message-State: AOJu0YxoNEF29ebFajRP9+cpSSgOTs91Rvd1eIrJiCRwbqs74fOISfXl
	hVHcSpKxOooDc0XdyNzse4tgzGLfbGF0GCnmykNNS3KSxVScCpdNMYDUTOeqFfUtGMGAVc4YX6i
	yj4PIMba8S205JnCPdoFeTesjjotW6Sz5ZKhJJjh9JSkl61v6ARDc
X-Gm-Gg: AZuq6aJDnj9K7Y4A60qATuho7VpaMQfG+5KQNi69IoH2/NiALIq/AfqJVeEMatbvjxm
	t/2Ojp9zChry0cbLaxe+rxcZkcxoLwQYWU30Wax8o9U8eeQUUDD0kK6uH54IEl64kxzno/PJtzI
	5c2ZNrLipsqgE3SqLxCuiAL/Qd4rzVN3Zu1hHx9Mnpa2J6A9cS7eC8yqMPPeWSmzyHPXAG31lBi
	tI3jqe403c4MXoBWZifzcElGLNMBeJp1vP59btbpSEf0TtY9miAiCnmxR5cnjvXn5Grk3pvT55/
	IZLE/dR5yteKj2tzYV1L8DaeW5H+QYiG9SDnAV9krj66/003nKh9Kq1BkfSCj7YJd5c2ILeK74R
	C4cXpDDH4f2BJLJnatwisJwEtiSvR7CmX8WtVbKA=
X-Received: by 2002:a05:7022:920:b0:119:e55a:95a1 with SMTP id a92af1059eb24-1273985ace2mr4639274c88.3.1771558098352;
        Thu, 19 Feb 2026 19:28:18 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2bacb62d781sm2279296eec.6.2026.02.19.19.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 19:28:18 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 55861341BBA;
	Thu, 19 Feb 2026 20:28:16 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 534BFE420F8; Thu, 19 Feb 2026 20:28:16 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 4/6] nvme: set discard_granularity from NPDG/NPDA
Date: Thu, 19 Feb 2026 20:28:07 -0700
Message-ID: <20260220032809.758089-5-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260220032809.758089-1-csander@purestorage.com>
References: <20260220032809.758089-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260219_192819_413928_F12EA08A 
X-CRM114-Status: GOOD (  16.57  )
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
 drivers/nvme/host/core.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 70ff14a56a01..7ac11c40ca9f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1880,23 +1880,33 @@ static bool nvme_init_integrity(struct nvme_ns_head *head,
 		bi->pi_offset = info->pi_offset;
 	}
 	return true;
 }
 
-static void nvme_config_discard(struct nvme_ns *ns, struct queue_limits *lim)
+static void nvme_config_discard(struct nvme_ns *ns, struct nvme_id_ns *id,
+				struct nvme_id_ns_nvm *nvm,
+				struct queue_limits *lim)
 {
 	struct nvme_ctrl *ctrl = ns->ctrl;
+	u32 npdg, npda;
+	u8 optperf;
 
 	if (ctrl->dmrsl && ctrl->dmrsl <= nvme_sect_to_lba(ns->head, UINT_MAX))
 		lim->max_hw_discard_sectors =
 			nvme_lba_to_sect(ns->head, ctrl->dmrsl);
 	else if (ctrl->oncs & NVME_CTRL_ONCS_DSM)
 		lim->max_hw_discard_sectors = UINT_MAX;
 	else
 		lim->max_hw_discard_sectors = 0;
 
-	lim->discard_granularity = lim->logical_block_size;
+	optperf = id->nsfeat >> NVME_NS_FEAT_OPTPERF_SHIFT &
+		  NVME_NS_FEAT_OPTPERF_MASK;
+	npdg = optperf & 0x2 && nvm && nvm->npdgl ? le32_to_cpu(nvm->npdgl) :
+	       optperf & 0x1 ? le16_to_cpu(id->npdg) + 1 : 1;
+	npda = optperf & 0x2 && nvm && nvm->npdal ? le32_to_cpu(nvm->npdal) :
+	       optperf ? le16_to_cpu(id->npda) + 1 : 1;
+	lim->discard_granularity = max(npdg, npda) * lim->logical_block_size;
 
 	if (ctrl->dmrl)
 		lim->max_discard_segments = ctrl->dmrl;
 	else
 		lim->max_discard_segments = NVME_DSM_MAX_RANGES;
@@ -2382,11 +2392,11 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	nvme_configure_metadata(ns->ctrl, ns->head, id, nvm, info);
 	nvme_set_chunk_sectors(ns, id, &lim);
 	if (!nvme_update_disk_info(ns, id, &lim))
 		capacity = 0;
 
-	nvme_config_discard(ns, &lim);
+	nvme_config_discard(ns, id, nvm, &lim);
 	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
 	    ns->head->ids.csi == NVME_CSI_ZNS)
 		nvme_update_zone_info(ns, &lim, &zi);
 
 	if ((ns->ctrl->vwc & NVME_CTRL_VWC_PRESENT) && !info->no_vwc)
-- 
2.45.2


