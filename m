Return-Path: <SRS0=Qryz=E2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8E8C63697
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2020 01:28:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B25022254
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2020 01:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EC23nKKy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="KQ4eOTwh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B25022254
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:From:Subject:Mime-Version:Message-Id:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=h0F7iVUkQeXdjzn1I327npNynehAVIIT8XeWISypQy0=; b=EC23nKKymZaqKbNTa9BLLwc/cg
	+KrOLOFRSnA8AslPI7pj4+DXWdfHKT0cbnn2yJbctp0WvWI4k7+hkXrKGB/JIuvG84RP53LMhnTS7
	bkPG7dRG5GknLcxMsVKqkAwTeunaw3vZgkZSARmOzCYtXKLDpqTxSVd6Q3/v6SlR65VXkx1I5mksP
	aSKUmZ9T4IXA3nzp4DkKnm59AoGKRYaDMtUicMXpUfQBXRgBz56x6XBbZ8A/R9mMJu4UvH6YHDKCt
	OzySfTef7wV5xBf6MR0choLpqH8fiBQ9PmMxWlABduegDSEaZf8YYljIilqc34NLDpsanLlze57f9
	mlH/XCvA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kfvDj-0001aL-Hf; Fri, 20 Nov 2020 01:28:15 +0000
Received: from mail-qv1-xf4a.google.com ([2607:f8b0:4864:20::f4a])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kfvDg-0001Zy-J1
 for linux-nvme@lists.infradead.org; Fri, 20 Nov 2020 01:28:13 +0000
Received: by mail-qv1-xf4a.google.com with SMTP id r5so2602549qvr.15
 for <linux-nvme@lists.infradead.org>; Thu, 19 Nov 2020 17:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:message-id:mime-version:subject:from:to:cc;
 bh=lK0xAgnqnFlKaValXVa+KwtGL7PSxTSCBTzwbu0iobI=;
 b=KQ4eOTwhgUo10eJlVVLVGUDH3sWNKajxu3x9BVxOBLT8YFeUdiXb9KqX7CC8fSQZn2
 Ib6zq2ftRSnDPAvCB35gqCoP8snEJTtPuFSxmmrSopU5llloGetTUTykmU5LnzzpS/Sd
 Eqc8VhXWNuv465Nqbmh5Mez1PuIVaFg8k92MKpmQjxCppNbbTRFOibip654xHkMDB2Tp
 U1GJKDO/KOjz1IHyjWqDr8iZIoLyMyzsWxO9U7/Mh+0g06k8nSw+cPFy2714dpuDCrVo
 3VJ9W5ws0hmXS2+Sklv0y0djPifhPSjaWJ/GxiVxdQrftP5RQkDVnXfnXOoq7uwxlXCN
 vp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
 :to:cc;
 bh=lK0xAgnqnFlKaValXVa+KwtGL7PSxTSCBTzwbu0iobI=;
 b=c+oZAADEevumrur0kJHI4N8hkLLHnlNH92R+3tgIrIJpSBmrAo2AhAiYRvmQLMwNpa
 6fOz3V4/dl2g2UMBhtPSyW0yTiStCK2bPTm41IppkxbHTrgyY9haW3FuIyX0GN4619mD
 edWyGgeu6WYkcKvs6mYUUYrXYSFaEvnDYGVhRHwQokshQPkjI8GPqQc+7xZA4XAXJO9X
 B08PaZs6ilX3Ncu2WgcTGqFfcp65YQmLAe7pkvI7r/ZmZZbrmT0k5GmHQZuLYnAxBZ6F
 1V8iOgWIMvg115t/jMqeHyIVlpapVk7MwFE9zAQZcZLTMoxG+3flbxrQP3UZZ38CgFLa
 9eQA==
X-Gm-Message-State: AOAM533RiBQE2Maq42npK7soiUqADODIPtqGdQ9JtbYiya9lWSZQhcc5
 F+/NVAuHRZASeFazi/MFbkbsLvD3Phchfw==
X-Google-Smtp-Source: ABdhPJy3thbcQda3qTSamHoN14zSoMqlE5FrSw5T5Rl4P3mib92c8R3jPpQikTCaiYgC8wczkE5ClkRj7537vQ==
X-Received: from tmroeder.kir.corp.google.com
 ([2620:0:1008:11:7220:84ff:fe09:dc21])
 (user=tmroeder job=sendgmr) by 2002:a05:6214:aab:: with SMTP id
 ew11mr14234348qvb.4.1605835688035; Thu, 19 Nov 2020 17:28:08 -0800 (PST)
Date: Thu, 19 Nov 2020 17:27:37 -0800
Message-Id: <20201120012738.2953282-1-tmroeder@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2] nvme: Cache DMA descriptors to prevent corruption.
From: Tom Roeder <tmroeder@google.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201119_202812_711288_5611B8CA 
X-CRM114-Status: GOOD (  23.68  )
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
Cc: linux-kernel@vger.kernel.org, Tom Roeder <tmroeder@google.com>,
 linux-nvme@lists.infradead.org, Peter Gonda <pgonda@google.com>,
 Marios Pomonis <pomonis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This patch changes the NVMe PCI implementation to cache host_mem_descs
in non-DMA memory instead of depending on descriptors stored in DMA
memory. This change is needed under the malicious-hypervisor threat
model assumed by the AMD SEV and Intel TDX architectures, which encrypt
guest memory to make it unreadable. Some versions of these architectures
also make it cryptographically hard to modify guest memory without
detection.

On these architectures, Linux generally leaves DMA memory unencrypted so
that devices can still communicate directly with the kernel: DMA memory
remains readable to and modifiable by devices. This means that this
memory is also accessible to a hypervisor.

However, this means that a malicious hypervisor could modify the addr or
size fields of descriptors and cause the NVMe driver to call
dma_free_attrs on arbitrary addresses or on the right addresses but with
the wrong size. To prevent this attack, this commit changes the code to
cache those descriptors in non-DMA memory and to use the cached values
when freeing the memory they describe.

Tested: Built and ran with Google-internal NVMe tests.
Tested-by: Tom Roeder <tmroeder@google.com>
Signed-off-by: Tom Roeder <tmroeder@google.com>
---
Changes from v1:
- Use native integers instead of __le{32,64} for the addr and size.
- Rename added fields/variables for better consistency.
- Make comment style consistent with other comments in pci.c.

 drivers/nvme/host/pci.c | 35 ++++++++++++++++++++++++++++-------
 include/linux/nvme.h    |  5 +++++
 2 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3be352403839..4c55a96f9e34 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -148,6 +148,11 @@ struct nvme_dev {
 	u32 nr_host_mem_descs;
 	dma_addr_t host_mem_descs_dma;
 	struct nvme_host_mem_buf_desc *host_mem_descs;
+	/*
+	 * A cache for the host_mem_descs in non-DMA memory so a malicious
+	 * hypervisor can't change them.
+	 */
+	struct nvme_host_mem_buf_cached_desc *host_mem_cached_descs;
 	void **host_mem_desc_bufs;
 	unsigned int nr_allocated_queues;
 	unsigned int nr_write_queues;
@@ -1874,11 +1879,16 @@ static void nvme_free_host_mem(struct nvme_dev *dev)
 	int i;
 
 	for (i = 0; i < dev->nr_host_mem_descs; i++) {
-		struct nvme_host_mem_buf_desc *desc = &dev->host_mem_descs[i];
-		size_t size = le32_to_cpu(desc->size) * NVME_CTRL_PAGE_SIZE;
+		/*
+		 * Use the cached version to free the DMA allocations, not a
+		 * version that could be controlled by a malicious hypervisor.
+		 */
+		struct nvme_host_mem_buf_cached_desc *desc =
+			&dev->host_mem_cached_descs[i];
+		size_t size = desc->size * NVME_CTRL_PAGE_SIZE;
 
 		dma_free_attrs(dev->dev, size, dev->host_mem_desc_bufs[i],
-			       le64_to_cpu(desc->addr),
+			       desc->addr,
 			       DMA_ATTR_NO_KERNEL_MAPPING | DMA_ATTR_NO_WARN);
 	}
 
@@ -1888,6 +1898,8 @@ static void nvme_free_host_mem(struct nvme_dev *dev)
 			dev->nr_host_mem_descs * sizeof(*dev->host_mem_descs),
 			dev->host_mem_descs, dev->host_mem_descs_dma);
 	dev->host_mem_descs = NULL;
+	kfree(dev->host_mem_cached_descs);
+	dev->host_mem_cached_descs = NULL;
 	dev->nr_host_mem_descs = 0;
 }
 
@@ -1895,6 +1907,7 @@ static int __nvme_alloc_host_mem(struct nvme_dev *dev, u64 preferred,
 		u32 chunk_size)
 {
 	struct nvme_host_mem_buf_desc *descs;
+	struct nvme_host_mem_buf_cached_desc *cached_descs;
 	u32 max_entries, len;
 	dma_addr_t descs_dma;
 	int i = 0;
@@ -1913,9 +1926,13 @@ static int __nvme_alloc_host_mem(struct nvme_dev *dev, u64 preferred,
 	if (!descs)
 		goto out;
 
+	cached_descs = kcalloc(max_entries, sizeof(*cached_descs), GFP_KERNEL);
+	if (!cached_descs)
+		goto out_free_descs;
+
 	bufs = kcalloc(max_entries, sizeof(*bufs), GFP_KERNEL);
 	if (!bufs)
-		goto out_free_descs;
+		goto out_free_cached_descs;
 
 	for (size = 0; size < preferred && i < max_entries; size += len) {
 		dma_addr_t dma_addr;
@@ -1928,6 +1945,8 @@ static int __nvme_alloc_host_mem(struct nvme_dev *dev, u64 preferred,
 
 		descs[i].addr = cpu_to_le64(dma_addr);
 		descs[i].size = cpu_to_le32(len / NVME_CTRL_PAGE_SIZE);
+		cached_descs[i].addr = dma_addr;
+		cached_descs[i].size = len / NVME_CTRL_PAGE_SIZE;
 		i++;
 	}
 
@@ -1937,20 +1956,22 @@ static int __nvme_alloc_host_mem(struct nvme_dev *dev, u64 preferred,
 	dev->nr_host_mem_descs = i;
 	dev->host_mem_size = size;
 	dev->host_mem_descs = descs;
+	dev->host_mem_cached_descs = cached_descs;
 	dev->host_mem_descs_dma = descs_dma;
 	dev->host_mem_desc_bufs = bufs;
 	return 0;
 
 out_free_bufs:
 	while (--i >= 0) {
-		size_t size = le32_to_cpu(descs[i].size) * NVME_CTRL_PAGE_SIZE;
+		size_t size = cached_descs[i].size * NVME_CTRL_PAGE_SIZE;
 
-		dma_free_attrs(dev->dev, size, bufs[i],
-			       le64_to_cpu(descs[i].addr),
+		dma_free_attrs(dev->dev, size, bufs[i], cached_descs[i].addr,
 			       DMA_ATTR_NO_KERNEL_MAPPING | DMA_ATTR_NO_WARN);
 	}
 
 	kfree(bufs);
+out_free_cached_descs:
+	kfree(cached_descs);
 out_free_descs:
 	dma_free_coherent(dev->dev, max_entries * sizeof(*descs), descs,
 			descs_dma);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index d92535997687..e9e14df417bc 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1114,6 +1114,11 @@ struct nvme_host_mem_buf_desc {
 	__u32			rsvd;
 };
 
+struct nvme_host_mem_buf_cached_desc {
+	__u64			addr;
+	__u32			size;
+};
+
 struct nvme_create_cq {
 	__u8			opcode;
 	__u8			flags;
-- 
2.29.2.454.gaff20da3a2-goog


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
