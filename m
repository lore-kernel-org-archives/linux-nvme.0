Return-Path: <SRS0=xDof=EZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC30C388F9
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Nov 2020 19:00:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAAE424695
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Nov 2020 19:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eKSlmjrM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="EDeks+8y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAAE424695
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:From:Subject:Mime-Version:Message-Id:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=y7pbtl4ZAiAzhppiO2oycg0Tol69BLCVUgfhQVrGsvI=; b=eKSlmjrM0mK9/ah125Ol6SVvbQ
	v8eqlmvsuLzFCrq0fRt0glDXw15Kg9d2t8q/Cnh/VCOsDEUqxNuEYYgccL4dZHGJzXJYqjVGNMIS7
	0ljSJJJOo2aFSRD59iAoIwYvXBMJIM4S+9fzdGGHu3BN95pFtcGtKPtEZAHHUzCz3F0unwmafxtHH
	ls7FN0WSmUdPgI7RkyyoITqwMCw93hhLbOOjtoxapU0V96+ruPPzvOz4x+3YA3yjnz9B8vQd/DNuU
	jEADSxQovD4XCFmwOJPg183BFvYlTzymYx76nolNMhFHbUvk4kmGAkmktlWrtqx0yn+SnkhvvYH30
	+OlkD7Yw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kfpA5-0002om-D8; Thu, 19 Nov 2020 19:00:05 +0000
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kfpA1-0002nw-Ig
 for linux-nvme@lists.infradead.org; Thu, 19 Nov 2020 19:00:02 +0000
Received: by mail-pg1-x54a.google.com with SMTP id l7so4723947pgq.16
 for <linux-nvme@lists.infradead.org>; Thu, 19 Nov 2020 10:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:message-id:mime-version:subject:from:to:cc;
 bh=4NQ6c9PbczcRRj9m9KRIAxy4jOOsHq5Kj8nNFjb7lO4=;
 b=EDeks+8y/2oi8p/ZM9GfjZ4lFPQ4AbB77veyqzI763yelEmXmsp1veJYkFa97lw9ES
 2m1teZUTvcz0tSLLtbchbMlvcxGwKdIpDaWWrqSrSuJPdWX+ZD2sN8RzTBMJteMKHmw6
 Cj7AI5zwkBkxPygkHOBvt/1e4P1DKvvA+SxQ6w9auyczmqZwYh6l+aocYHICiAr10M4E
 Jpm0TIRIH6eLhE9BvuQpd6GmbrwyffsFe2TTx8DS09JyLdoa0akXaU+49XlkqeHEI+vO
 NukLo+VWEjmo9e+vJd+U9qDYJ0b8DkHyv+q8gPOb3F6caMc13zof9t15TlT1pFF6vlWo
 OdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
 :to:cc;
 bh=4NQ6c9PbczcRRj9m9KRIAxy4jOOsHq5Kj8nNFjb7lO4=;
 b=GxMAG9BDmkqwb5bHuSdzlypXx1p++ToHzv6UFbgPt64C25R5V/RHh5Fw573da8qJ8M
 ohwPhltPcWc+BD7w/uRTYzHwLYJGvCYAtLJDF8Pr5v+2lbLpYw0awiEY65LFURpfrfEi
 ku11XjZIRMP3AtrizqpfnfEIbfsJwf3/BLf4c54GMP6+OBHWSPRc1tpa/CBkPt1RMuYc
 sUTlqdhwYu/CUmnVejxzSHP8jKvLctFek6xtOkYwtTsOSQi+4zriaCEcX9Tz1hLijsmK
 x36VYtDHKSTqzyk4+mPNZXAFzrGzgJ4qqLRQ4BpEoc6iT2OziApMhPNRVOCgpLx15Iny
 kyJw==
X-Gm-Message-State: AOAM530F7P0TpKCjMBjBGDZ2dBhHIFerZM5xGOmOAri0+U03iRnjQU3h
 bwUIr9WMtB9aWIgiOHGzQ4ztRtIcqdAc8w==
X-Google-Smtp-Source: ABdhPJxkB4/gxQnf9XoWsnt47FLC9597nxJR/IWx2y1uaU/rGn9qnek8Oe/5gBPqVkiz7cDZmuQCLjMb6FSa6w==
X-Received: from tmroeder.kir.corp.google.com
 ([2620:0:1008:11:7220:84ff:fe09:dc21])
 (user=tmroeder job=sendgmr) by 2002:a17:902:6b07:b029:d8:ccb8:10c5 with SMTP
 id o7-20020a1709026b07b02900d8ccb810c5mr10265260plk.43.1605812397384; Thu, 19
 Nov 2020 10:59:57 -0800 (PST)
Date: Thu, 19 Nov 2020 10:59:19 -0800
Message-Id: <20201119185919.2742954-1-tmroeder@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH] nvme: Cache DMA descriptors to prevent corruption.
From: Tom Roeder <tmroeder@google.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201119_140001_701790_34F94D11 
X-CRM114-Status: GOOD (  22.76  )
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
 drivers/nvme/host/pci.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3be352403839..28ebe1304cae 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -148,6 +148,10 @@ struct nvme_dev {
 	u32 nr_host_mem_descs;
 	dma_addr_t host_mem_descs_dma;
 	struct nvme_host_mem_buf_desc *host_mem_descs;
+	/* Cache the host_mem_descs in non-DMA memory so a malicious hypervisor
+	 * can't change them.
+	 */
+	struct nvme_host_mem_buf_desc *host_mem_descs_cache;
 	void **host_mem_desc_bufs;
 	unsigned int nr_allocated_queues;
 	unsigned int nr_write_queues;
@@ -1874,7 +1878,11 @@ static void nvme_free_host_mem(struct nvme_dev *dev)
 	int i;
 
 	for (i = 0; i < dev->nr_host_mem_descs; i++) {
-		struct nvme_host_mem_buf_desc *desc = &dev->host_mem_descs[i];
+		/* Use the cached version to free the DMA allocations, not a
+		 * version that could be controlled by a malicious hypervisor.
+		 */
+		struct nvme_host_mem_buf_desc *desc =
+			&dev->host_mem_descs_cache[i];
 		size_t size = le32_to_cpu(desc->size) * NVME_CTRL_PAGE_SIZE;
 
 		dma_free_attrs(dev->dev, size, dev->host_mem_desc_bufs[i],
@@ -1888,6 +1896,8 @@ static void nvme_free_host_mem(struct nvme_dev *dev)
 			dev->nr_host_mem_descs * sizeof(*dev->host_mem_descs),
 			dev->host_mem_descs, dev->host_mem_descs_dma);
 	dev->host_mem_descs = NULL;
+	kfree(dev->host_mem_descs_cache);
+	dev->host_mem_descs_cache = NULL;
 	dev->nr_host_mem_descs = 0;
 }
 
@@ -1895,6 +1905,7 @@ static int __nvme_alloc_host_mem(struct nvme_dev *dev, u64 preferred,
 		u32 chunk_size)
 {
 	struct nvme_host_mem_buf_desc *descs;
+	struct nvme_host_mem_buf_desc *descs_cache;
 	u32 max_entries, len;
 	dma_addr_t descs_dma;
 	int i = 0;
@@ -1913,9 +1924,13 @@ static int __nvme_alloc_host_mem(struct nvme_dev *dev, u64 preferred,
 	if (!descs)
 		goto out;
 
+	descs_cache = kcalloc(max_entries, sizeof(*descs), GFP_KERNEL);
+	if (!descs_cache)
+		goto out_free_descs;
+
 	bufs = kcalloc(max_entries, sizeof(*bufs), GFP_KERNEL);
 	if (!bufs)
-		goto out_free_descs;
+		goto out_free_descs_cache;
 
 	for (size = 0; size < preferred && i < max_entries; size += len) {
 		dma_addr_t dma_addr;
@@ -1928,6 +1943,8 @@ static int __nvme_alloc_host_mem(struct nvme_dev *dev, u64 preferred,
 
 		descs[i].addr = cpu_to_le64(dma_addr);
 		descs[i].size = cpu_to_le32(len / NVME_CTRL_PAGE_SIZE);
+		descs_cache[i].addr = cpu_to_le64(dma_addr);
+		descs_cache[i].size = cpu_to_le32(len / NVME_CTRL_PAGE_SIZE);
 		i++;
 	}
 
@@ -1937,20 +1954,24 @@ static int __nvme_alloc_host_mem(struct nvme_dev *dev, u64 preferred,
 	dev->nr_host_mem_descs = i;
 	dev->host_mem_size = size;
 	dev->host_mem_descs = descs;
+	dev->host_mem_descs_cache = descs_cache;
 	dev->host_mem_descs_dma = descs_dma;
 	dev->host_mem_desc_bufs = bufs;
 	return 0;
 
 out_free_bufs:
 	while (--i >= 0) {
-		size_t size = le32_to_cpu(descs[i].size) * NVME_CTRL_PAGE_SIZE;
+		size_t size =
+			le32_to_cpu(descs_cache[i].size) * NVME_CTRL_PAGE_SIZE;
 
 		dma_free_attrs(dev->dev, size, bufs[i],
-			       le64_to_cpu(descs[i].addr),
+			       le64_to_cpu(descs_cache[i].addr),
 			       DMA_ATTR_NO_KERNEL_MAPPING | DMA_ATTR_NO_WARN);
 	}
 
 	kfree(bufs);
+out_free_descs_cache:
+	kfree(descs_cache);
 out_free_descs:
 	dma_free_coherent(dev->dev, max_entries * sizeof(*descs), descs,
 			descs_dma);
-- 
2.29.2.299.gdc1121823c-goog


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
