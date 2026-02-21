Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0051FE9A049
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Feb 2026 03:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=egZynsCm9n4B9np5fFEbCgBHoufsRNA7TK4tbUKZ+oI=; b=nVt5HfxFSt8SqUDxtLEdBwuM/Q
	MCdRr4Y+aN66trgVLHPGTFZ1ftocHJQ+tWRvIUqWcVjEirbbdmIL9er5qHdGxC6J8oDVYzSDk3ZYr
	7YzC7/Nn0MxMojC4uc1bmt2UewV7OfIw7B1d5aK3u2yJOM4d7aM0CvfZlN++VC+/EC8MizytTLOAQ
	Kw8+9DqOpaHSszhoLZIdl0b/1FGl3xMLiEGdb0mmuEdj7RxB8IEwifIx4m3BtyOlD2ApQmXyAGShi
	0Ut84zBe0F2CQHHzsBMrroEtpIs06YPS48oznaMZztsFHhyIdzrrUtFzlUu40A0qigGV7RyVLg5l1
	BR2xEWsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtdjy-0000000FnZK-1w3U;
	Sat, 21 Feb 2026 03:33:10 +0000
Received: from mail-qv1-xf61.google.com ([2607:f8b0:4864:20::f61])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtdjv-0000000FnWQ-460D
	for linux-nvme@lists.infradead.org;
	Sat, 21 Feb 2026 03:33:09 +0000
Received: by mail-qv1-xf61.google.com with SMTP id 6a1803df08f44-8946d9872ebso2297526d6.1
        for <linux-nvme@lists.infradead.org>; Fri, 20 Feb 2026 19:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771644787; x=1772249587; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egZynsCm9n4B9np5fFEbCgBHoufsRNA7TK4tbUKZ+oI=;
        b=NMDrm08x8Qvb9Z00fw2sRXivH+ljGh4yCnT99+c2iZ1ANr3LDI5mVp+QlIktueRLI8
         VjW0oeeLC74m4cNBNbM6mUfoO5iixuR5GvTpf89uZ2kWDu1klZ3NMlmyn0YKvdO/ZZgs
         JUqQ/g5dsjKvBRXHfFg7lSnL9FMUC6HI0ElTd28h4Y5HIx3cr+MGxko1a8qvxOYpN5jR
         LK5TnAl5w5L7Vk29IywQ4WxUkbcRii1rboT6yKH4G+JNFWYGG3Rm4pvJNYDSgak2zI+d
         yC0Y101lW0hhKfRmzZbmjFPDgeJsgowFKRVOQ7/ALAxS+BqUUJlSO9qXTD+DNnvV+ivw
         CZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771644787; x=1772249587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=egZynsCm9n4B9np5fFEbCgBHoufsRNA7TK4tbUKZ+oI=;
        b=mxykv7LlMzuyxBGok0IrL6Da0vxdBFdiDf2i9VUvg1s39OwWeDQE+W1jV3I0OKHglZ
         9I1UBhKmdCo59b3JN47aO6Ja64UIvFfBYzmRn6vmEcvY1PY/nXMAVTzAJqAP8c6u3Zq8
         6RlSkOBhzw1bIpPyJ837qjbs7pfgnA1Yi5knnYsXPLHGDKr+i8LyN3N/123BU9bWnZrp
         O0KsCiGub8qDfAXbKq5WaTm2WiWkPWxzq/BpTOPJZrNzcT34yDkbzlFYNGBCWJ7KXYGa
         cu+85t9yHoC2Cr1oKoKO0AT++2jC7acmuP4hqmjWolXx4wN0ldZrFaxmECvrneIFc5GN
         XUDQ==
X-Gm-Message-State: AOJu0YyPypMX6cs6OTff+UMwYY7cpvJeNqcDrlQxvvdqZO8pUKwiRMpw
	ONkj28BVD+Wjf8+4JOKVsiNYU4MyNt4K4h4BDKp4DikMKWvsEcQxUd4RRtih4qgaUjuCVlaVxJM
	bm8CZorZUioMDmcO0MruJXEOrPkgPhwxsgBXa
X-Gm-Gg: AZuq6aJ6tTZKPQ3696xk/R9jxD5gKbeNayQLK+GmYSDP3pBuelo6+9FdxJCQkx4lY0x
	eMwrYKlrqL7S8+Aw9xr9RL9waQHDTCXhUzkJrU8TLkPFWv/Y6u126iIWUwVNQuXu6h2RWquCad7
	g+5ztN8dz65WtEqvI+rmRMyC3J3PjjydfjqmYrIOg4pfaEHiRnnfM1M+qD0zYcKBHfgls6iGLW0
	rvJLTnc9aoax4OXurF9pT8nDzcDuQL8QVJl26mUFYJbju6o0n7FYACC04iT5Tc79Eq6HgHuN0zS
	boMVsJJZ/lvY8S81UBiG3GPZtTHDg9EYWswSzzAEh0GQiPy+y2I1fns4gYCYB8oHf5mfTwj4fK6
	4hVJhiJ97RNMDG5muyCrjZOKs+UZRu4jtW+LmBdVsW6iI/8Qdiz/0xQ==
X-Received: by 2002:a05:6214:8088:b0:894:9d9b:84f9 with SMTP id 6a1803df08f44-89979c55249mr23184136d6.1.1771644786593;
        Fri, 20 Feb 2026 19:33:06 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8997c4887b7sm1385526d6.6.2026.02.20.19.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 19:33:06 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id EE4493409F2;
	Fri, 20 Feb 2026 20:33:05 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id E4857E427CB; Fri, 20 Feb 2026 20:33:05 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 5/7] nvme: set discard_granularity from NPDG/NPDA
Date: Fri, 20 Feb 2026 20:33:00 -0700
Message-ID: <20260221033302.1451669-6-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260221033302.1451669-1-csander@purestorage.com>
References: <20260221033302.1451669-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_193308_045095_6AC2AC29 
X-CRM114-Status: GOOD (  19.66  )
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
 drivers/nvme/host/core.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2b433478f328..35309dec1334 100644
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
@@ -2113,11 +2114,27 @@ static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
 	else if (ctrl->oncs & NVME_CTRL_ONCS_DSM)
 		lim->max_hw_discard_sectors = UINT_MAX;
 	else
 		lim->max_hw_discard_sectors = 0;
 
-	lim->discard_granularity = lim->logical_block_size;
+	if (ctrl->dmrsl && ctrl->dmrsl <= nvme_sect_to_lba(ns->head, UINT_MAX))
+		lim->max_hw_discard_sectors =
+			nvme_lba_to_sect(ns->head, ctrl->dmrsl);
+	else if (ctrl->oncs & NVME_CTRL_ONCS_DSM)
+		lim->max_hw_discard_sectors = UINT_MAX;
+	else
+		lim->max_hw_discard_sectors = 0;
+
+	if (optperf & 0x2 && nvm && nvm->npdgl)
+		npdg = le32_to_cpu(nvm->npdgl);
+	else if (optperf & 0x1)
+		npdg = (u32)le16_to_cpu(id->npdg) + 1;
+	if (optperf & 0x2 && nvm && nvm->npdal)
+		npda = le32_to_cpu(nvm->npdal);
+	else if (optperf)
+		npda = (u32)le16_to_cpu(id->npda) + 1;
+	lim->discard_granularity = max(npdg, npda) * lim->logical_block_size;
 
 	if (ctrl->dmrl)
 		lim->max_discard_segments = ctrl->dmrl;
 	else
 		lim->max_discard_segments = NVME_DSM_MAX_RANGES;
@@ -2380,11 +2397,11 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
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


