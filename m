Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696C5C5321D
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Aug 2024 18:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:To:From:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1Hlc/i1KYMFZn1UW3B36jY0bAKWAgeG5KXhGYCaItEQ=; b=20F4yBH49dpvXwPrJJdVq/wjF0
	GMoWngXz6Ki4bcbvQVcGLOBitcLjUOGH9BRtA8ig7GDyB6qFu09OOyvoVcO07DYVW4O7GVbYdqoUv
	GG+C3MVuqJUVuJagMCi7Xsi7j/Auj9S6lbqkC0kHCpufCPhcpmt51CxwNyrDzhyV3pxf9/9AFPwVS
	tWIHM6bAbxtgxE4bg0kA+QzEGtWJA+EK8kNabcRuY6bWZ6cpu+wtY93lfrHoTYyPh0p5jIua5xFFY
	t0lhxSXoEGYzjQaa4gaZpjWMNm/eu5OOxULCNGTbBphOyiRy4D8ee91yJumsqLzfirLICU88+KqI8
	SEbIKzJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shCh7-0000000DyG1-3W6a;
	Thu, 22 Aug 2024 18:38:01 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shCh0-0000000DyAE-3UQh
	for linux-nvme@lists.infradead.org;
	Thu, 22 Aug 2024 18:37:57 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-201f2b7fe0dso10988975ad.1
        for <linux-nvme@lists.infradead.org>; Thu, 22 Aug 2024 11:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724351874; x=1724956674; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Hlc/i1KYMFZn1UW3B36jY0bAKWAgeG5KXhGYCaItEQ=;
        b=eyHjDG45rw3sb6qu6UO9jQ/TPm0vSE9GA6pm4f7mdcFO/8QASeoWiBza6jvdWSPIjt
         mOYr0/+srrdJg9QUQQLVILm6X9DUb8tJ+1Tb0DSiVrOGL/6clKG5DBNQGop8zpzKqiKb
         s1hqQsM6He2rFVr3bCzUqpRdBtD9OTAB8iHwQHYZ4aZakPkf7m7CZyE+PPc6Tah2ufLn
         a/cRKnlO8k3QdAxirE6IDG9jp2yNtXRwLAKtTTPv3JOKe7K5FFXz64StS1pDvoHTzkkf
         4TeLtZhHuyQ9SE1kgqJZu9QhUsYA73UzwSXzrDOF5yQ2CAMlOrXkSRiVook0YXg2+k9N
         OHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724351874; x=1724956674;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1Hlc/i1KYMFZn1UW3B36jY0bAKWAgeG5KXhGYCaItEQ=;
        b=o+JllZQg2X+DP6KOOKAMlvOnwW+oVGALYlJEUAYkmuLRCqpfs8wZzKqSh9PH47vMO8
         cCyuVF5KtwkkDGaTnmiJc5zUixkNcw0Ag3ivydcrRkiUrSxk3Q4v4McXAzQa8unERkZQ
         fYHPzZUws6DLLUl9Z027MDbvJtmStAyaGm2a98tBYRaVuBnuB2jiLsilSoxk7GRD8yNR
         FCV345Xu4V9p0oWz87FUneXqH27qmKh9vj+NGXOB8noGHsz51kZ6VfltQoTCvIwjMDpi
         LqXv91rCIYhhWnJybjv3VEJ6Xbrao2KZWeRWm+omocovijrR3xmsXAVlY3lMxsdcr6/J
         h7cw==
X-Forwarded-Encrypted: i=1; AJvYcCUG6TiIruwMQXe7FI05zq1gzWj3u8U91IWeapqi4cCAjzedw7guu1COYvb4xPWvBW0kjHPImnhdUK1U@lists.infradead.org
X-Gm-Message-State: AOJu0Yy3M7YgKcU2D6bwF9McnNWTNpZch7KlRtVnFW+tVwcHneLTQXsu
	SdHNO3pT4kD4+nSTOcYJtNDXpjy4IBBJiNektMMqqXfvUqTQUrCT
X-Google-Smtp-Source: AGHT+IE+oTsuXbaq9ZvaSNrcslYkvt3uX+Tvp8+A11rBrdRfV8hOJKmntJKX/3gWBiFYZVMV3hYEuw==
X-Received: by 2002:a17:902:d2ce:b0:202:13ca:d73e with SMTP id d9443c01a7336-20388240fbcmr30142745ad.28.1724351873947;
        Thu, 22 Aug 2024 11:37:53 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038557e4f9sm15667145ad.65.2024.08.22.11.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 11:37:53 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kbusch@kernel.org,
	axboe@kernel.dk,
	sagi@grimberg.me,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	robin.murphy@arm.com,
	hch@lst.de,
	m.szyprowski@samsung.com,
	petr@tesarici.cz,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-coco@lists.linux.dev
Subject: [RFC 7/7] nvme: Enable swiotlb throttling for NVMe PCI devices
Date: Thu, 22 Aug 2024 11:37:18 -0700
Message-Id: <20240822183718.1234-8-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240822183718.1234-1-mhklinux@outlook.com>
References: <20240822183718.1234-1-mhklinux@outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_113755_376985_9B872175 
X-CRM114-Status: GOOD (  18.20  )
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
Reply-To: mhklinux@outlook.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Michael Kelley <mhklinux@outlook.com>

In a CoCo VM, all DMA-based I/O must use swiotlb bounce buffers
because DMA cannot be done to private (encrypted) portions of VM
memory. The bounce buffer memory is marked shared (decrypted) at
boot time, so I/O is done to/from the bounce buffer memory and then
copied by the CPU to/from the final target memory (i.e, "bounced").
Storage devices can be large consumers of bounce buffer memory because
it is possible to have large numbers of I/Os in flight across multiple
devices. Bounce buffer memory must be pre-allocated at boot time, and
it is difficult to know how much memory to allocate to handle peak
storage I/O loads. Consequently, bounce buffer memory is typically
over-provisioned, which wastes memory, and may still not avoid a peak
that exhausts bounce buffer memory and cause storage I/O errors.

For Coco VMs running with NVMe PCI devices, update the driver to
permit bounce buffer throttling. Gate the throttling behavior
on a DMA layer check indicating that throttling is useful, so that
no change occurs in a non-CoCo VM. If throttling is useful, enable
the BLK_MQ_F_BLOCKING flag, and pass the DMA_ATTR_MAY_BLOCK attribute
into dma_map_bvec() and dma_map_sgtable() calls. With these options in
place, DMA map requests are pended when necessary to reduce the
likelihood of usage peaks caused by the NVMe driver that could exhaust
bounce buffer memory and generate errors.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/nvme/host/pci.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6cd9395ba9ec..2c39943a87f8 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -156,6 +156,7 @@ struct nvme_dev {
 	dma_addr_t host_mem_descs_dma;
 	struct nvme_host_mem_buf_desc *host_mem_descs;
 	void **host_mem_desc_bufs;
+	unsigned long dma_attrs;
 	unsigned int nr_allocated_queues;
 	unsigned int nr_write_queues;
 	unsigned int nr_poll_queues;
@@ -735,7 +736,8 @@ static blk_status_t nvme_setup_prp_simple(struct nvme_dev *dev,
 	unsigned int offset = bv->bv_offset & (NVME_CTRL_PAGE_SIZE - 1);
 	unsigned int first_prp_len = NVME_CTRL_PAGE_SIZE - offset;
 
-	iod->first_dma = dma_map_bvec(dev->dev, bv, rq_dma_dir(req), 0);
+	iod->first_dma = dma_map_bvec(dev->dev, bv, rq_dma_dir(req),
+					dev->dma_attrs);
 	if (dma_mapping_error(dev->dev, iod->first_dma))
 		return BLK_STS_RESOURCE;
 	iod->dma_len = bv->bv_len;
@@ -754,7 +756,8 @@ static blk_status_t nvme_setup_sgl_simple(struct nvme_dev *dev,
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 
-	iod->first_dma = dma_map_bvec(dev->dev, bv, rq_dma_dir(req), 0);
+	iod->first_dma = dma_map_bvec(dev->dev, bv, rq_dma_dir(req),
+					dev->dma_attrs);
 	if (dma_mapping_error(dev->dev, iod->first_dma))
 		return BLK_STS_RESOURCE;
 	iod->dma_len = bv->bv_len;
@@ -800,7 +803,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		goto out_free_sg;
 
 	rc = dma_map_sgtable(dev->dev, &iod->sgt, rq_dma_dir(req),
-			     DMA_ATTR_NO_WARN);
+			     dev->dma_attrs | DMA_ATTR_NO_WARN);
 	if (rc) {
 		if (rc == -EREMOTEIO)
 			ret = BLK_STS_TARGET;
@@ -828,7 +831,8 @@ static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req,
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct bio_vec bv = rq_integrity_vec(req);
 
-	iod->meta_dma = dma_map_bvec(dev->dev, &bv, rq_dma_dir(req), 0);
+	iod->meta_dma = dma_map_bvec(dev->dev, &bv, rq_dma_dir(req),
+					dev->dma_attrs);
 	if (dma_mapping_error(dev->dev, iod->meta_dma))
 		return BLK_STS_IOERR;
 	cmnd->rw.metadata = cpu_to_le64(iod->meta_dma);
@@ -3040,6 +3044,12 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 	 * a single integrity segment for the separate metadata pointer.
 	 */
 	dev->ctrl.max_integrity_segments = 1;
+
+	if (dma_recommend_may_block(dev->dev)) {
+		dev->ctrl.blocking = true;
+		dev->dma_attrs = DMA_ATTR_MAY_BLOCK;
+	}
+
 	return dev;
 
 out_put_device:
-- 
2.25.1


