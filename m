Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86FBDFD8FFA
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 19:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MCbjgYzJFkz4xvVSToR+yG/8UzWEaIR4Ya96q2o9rOo=; b=zzoZpusINQrM/1C3hHau4wf2Cx
	ww8T8q+dsEfxEPV0oII3tfmURJOhHwpd0ENYjQkNxP3eY0Ge/zDPQbJVzezCYCQ5HmJN43FUSrcKp
	OVVpaOD5JgEfp+1qa0dwpjNYqLA24NyZGBLTn+txOOHWasXMMWqmaizuDWbVRRdw21e7viFdh9Cmw
	MAvs1GMo9wpTqfsVi+XR6jMipf3uZ1yVMUxqiI6aWtlS/kmtAEuXtuWxvEKgg+LyO9v71XMznvPma
	4RUMFR/yK5W21hqiiHMcYrM5mjw9H/a64/Cni7Z2jniKcNr2/gK/clIGPjZzUA/82BnzepmQvkJ/c
	tyfTNt8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvgf0-000000070XS-3byg;
	Thu, 26 Feb 2026 19:04:30 +0000
Received: from mail-pl1-x662.google.com ([2607:f8b0:4864:20::662])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvget-000000070S8-0fuP
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 19:04:25 +0000
Received: by mail-pl1-x662.google.com with SMTP id d9443c01a7336-2aad6094702so820675ad.0
        for <linux-nvme@lists.infradead.org>; Thu, 26 Feb 2026 11:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1772132662; x=1772737462; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCbjgYzJFkz4xvVSToR+yG/8UzWEaIR4Ya96q2o9rOo=;
        b=G8krtmA/q7ayGiK1v0AgbVw7DKNq3WZNP1mN5XD1EW06/FxrF9c1c+nQG+SJU6FSY6
         b+6Z5WGEk+XLf/KtLt4O40RUqC0Fcn2WvqKoAg9A3VEAjWKKY9WdPLtbATSZQkXid8oL
         shyP6CzMFZCNUrvMoFdaTtivZ0nmDw8TTFcCgQoC7OUtp2QbBcjTbP30IGfjJBPVC/MS
         92ifYPIEystd9NmhsdmKkrhbAcx9xK32Lu6N9hjzpGJkjar9I1ewo8u5USRAm7iiVaRl
         Axa3McWwcp5W6sd/3vTBxWv0waAeu7meN+8RN0tAFmby/KJD2iVMzfXXfykPIXja9qPf
         OFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772132662; x=1772737462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MCbjgYzJFkz4xvVSToR+yG/8UzWEaIR4Ya96q2o9rOo=;
        b=gLSH8+f3mrDQ14O4wjW0Xw8qzTKxnVSJB5xpvwu/R3y6uNwD4Cp0h/UBoXzBDdTvwP
         gP4Gjq5eLN1aU2VdJcGuIq0XNVaVMlScPPWhAF9mUNX140EiU9RhM1+tB8wTO7VpsZdE
         DKGiBxOwuiWMxYYEkfGLnSPJR1EqaExT6B23i4vlFsZfcAz9P4E3K0M6FYwQEqwws1ZZ
         56AgFas9slJBGYJv5VRpphmJdl2v+A+J16E9V0xnYIveBoqilWIvGkzNXQqE0TGoQUxK
         VGxDVYS+D/AYReloY7zGdZ2LxHdQ1m166oIDJZSomtxqJixjNG73I+/6EcTizrIBqm4b
         ubKQ==
X-Gm-Message-State: AOJu0YycGNX0pfgp33JFNWfyoTV6zNfsgxW9XgzbQLzONHIvUtOVdxhE
	Qm4fr9bbx25mLoaFWT5mk3aJrc9vzGySKJ7z2PKYacscyawfnDZB0/kK+3k73vPsGgvCAejarpt
	MQnlUWY8KBRZbtmglTWdMozGbiy3V6iI3bNyQnFj0UZqo1iWnUk/+
X-Gm-Gg: ATEYQzwS13U8u4iwpdUft+/WyeKosmhh8FAUM9qxft3/eOlAmCDr0GOQ0C0FX/gOttF
	B1itF8e5jTQbx2NTqSINs4NwKUMGQ0bS1D9FX7pguvq6hCfjc5qusAV9lFLLnh8JxkaD9NH6Rwu
	KLXpHDgp2+CfvDAtPV5BlgDZknbPmHUW2bXwA/NVv3oONCGnuiM17VLdVWSP7PZFvsD+qR3ApOA
	EjjgYtritG/QKQUz1Ii2oiynJmQa3+MDvWUq+XK0E7rD0G63mkqul0kwtXqEk+HyAwMUEYx60Gj
	b3VqD9XcwvhJDRnB6r/qys31mMKF44hvFvZfdhjyfecgZlK1FvbsgWRWUtYcMfPi9h1jhngQLWr
	rvN8JWDJ/9PT0Pq6OWycKAhaaHEUVxqId0q5gOaU=
X-Received: by 2002:a17:90b:2d84:b0:358:f02c:b94e with SMTP id 98e67ed59e1d1-35965ce4b48mr126053a91.6.1772132661836;
        Thu, 26 Feb 2026 11:04:21 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2adfb16ae40sm3247365ad.13.2026.02.26.11.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 11:04:21 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id AD6D8342161;
	Thu, 26 Feb 2026 12:04:20 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id A8554E41254; Thu, 26 Feb 2026 12:04:20 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v4 6/8] nvme: set discard_granularity from NPDG/NPDA
Date: Thu, 26 Feb 2026 12:04:13 -0700
Message-ID: <20260226190416.297725-7-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260226190416.297725-1-csander@purestorage.com>
References: <20260226190416.297725-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_110423_212653_BA3B3D2F 
X-CRM114-Status: GOOD (  22.33  )
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
index 14e52b260f5d..20441985cad1 100644
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
@@ -2378,11 +2405,11 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
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


