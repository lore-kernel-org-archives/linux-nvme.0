Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B48C54F9C
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 02:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kIFE0vMpUJ1dmAiCPJaILFb8BXNtIaKcrv79dEKWPKA=; b=2Mqf93Vq+kaipTjqwSB7ApiKDQ
	nGZG2eb8Kuv/DKcSxKwCEp/9xQwRQl+faFJau2NV2QajllIGxmq3BjsI1e9lrsE2mWf0HlgCHrHR2
	eltjotQtzdV+t0k9MCWxDuxtPxxFya4AKJZlzV01/g2UIDr7poZqs8GuLqMHdsqLAwgt4kgR3y+58
	w8wIrdI6ZrJoVRULykoY4Yx/T+kHobJo23FuG953RCWFLXqmjIdkS2cDT5d8M+2OYpUxPOTjKwba/
	k46jMaluOViMTy8W2isWrsjMrYX0KgNwAsPJpTolR7yv8lae0xLnzVnyGFKX1G3vSJE9O40kG1fL9
	Ilz3bOKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wotqJ-00000006fTZ-1s1j;
	Wed, 29 Jul 2026 02:16:23 +0000
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wopNC-00000006KPc-212Y
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jul 2026 21:30:03 +0000
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-47f81a3ccf9so227995f8f.0
        for <linux-nvme@lists.infradead.org>; Tue, 28 Jul 2026 14:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785274200; x=1785879000; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kIFE0vMpUJ1dmAiCPJaILFb8BXNtIaKcrv79dEKWPKA=;
        b=swo4Q03SI73rQP8v7Xb2/zzXf9AbZnDx/Y6orvmjptNwqK41LoNswaMKMdkIVqET/D
         RbkwScZpMl0M/+3aliI8SD5fn3yijWgK7aaEuk+Zcs28X+0MmvCQirnDpjwhELiVvjRv
         oJB8xwvcq56EbQX4KB66uaW5/t9USUKFZPoLTX2xpvGAln1vddCLY4ngYCYrA25DRkax
         VJ9V+QXLgK2XBtDICl3XHh+lmE6McYCxj5vlYWsnK+HIWCBw2aY3aD2JygMKE5Lw7U+Q
         eHgdrOTUrq43D23AmgSzhaKsgbbSjA97uG3TDXn274TWHd/7uSn64k6LVBFSMU4s7JjV
         eD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785274200; x=1785879000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kIFE0vMpUJ1dmAiCPJaILFb8BXNtIaKcrv79dEKWPKA=;
        b=D4+S7CWkgZ/W5NBFQH2TInA0RxN7yweaP0tJFXg9lKxcG+6Y0zp0KxwsOPe99HClmq
         bxH6rZHWjtI7ZRVrrxDIMxHQ4dIxZAdMzw1vNHHWVn0YS0/HyYUll9L37iaDlq/h2Xr3
         fN3/8eMl6WnKSawaHtwr87CiFjy0L8UV3sqHwNDnWwAhha/wRzVkGWvjJLNKsXjp9S7X
         nxAc07iYkY3OYHvSynCN2wSKZbuCfS/yC3I8HLa5LBOWXkeqSi3cTJG8hSo0wj9SEJqD
         qOojsqP4LHpcJuFcCZrx/W8g2EAm2nOo5ATjHfNQ6+NQA+cqUXRhVFfORtWhXCjUqhQP
         EN/Q==
X-Forwarded-Encrypted: i=1; AHgh+RqXSVqcScMPy9RHIAVcaIaR1tHwOhaK4ekHi7Jk8vCaoaPAnMc5U8H/iQwurnbinj91nKJephrIa7v4@lists.infradead.org
X-Gm-Message-State: AOJu0YyBiTjdmTQ31269OvbT57wuxpzAWsbV96BBpsNFhP5Ia7nHnec3
	ZWKkjEEOZqflcqmryO7zoFPTavlkh/noHAta8fbJ/q6EQi8LIvwGWLLK
X-Gm-Gg: AR+sD12aGDS1Cj1KC8vvt3wG+Ebxg73gD17YTeg4JEwSdXQ0T5Nr3EG3oAm2dhT8sZ+
	RXsGnT68SoPa6unkKQhDvVV74L6YcwpyF/WjVWyqDagFyATYrGJfoeyq5dVypYct6sO95EGZVx3
	SE9LXYzYjk1UnA/QzqZlJAwrmrqChin48y/P2GearJ+E8q7YDgVYODXUFGUMONEnxgxsq3UH/LY
	k2IQuIINlenLP/WGDapBik9SnRgv5dOXL1hu/KU58I1yqX+lSlJ5+qW7LEPttuEKfOtmIHPmXEg
	sy/YE2p8kcOWG46nLA/hfcqRVjA7aCMvFiv8W65CrNq1KXyFRJZEWD1RbRrSFKwVokYJ0/fMlkp
	aDp7MhkSjIWNh0fKou+lbiqL/vbFv9KvycKjNpyLF1d8u0KH/LrnPqr5vNUMzNSSBiymGD0lUga
	E7IgddPLP7jmxVISevAJMewUxa+VtTjHs4i0ERGApAti/Pnw7Y0lGJFycCWNwc612Gdf/AnmGyC
	xuD9rAD
X-Received: by 2002:a05:6000:430c:b0:47f:9254:d453 with SMTP id ffacd0b85a97d-47fb1ec8030mr4347905f8f.8.1785274200459;
        Tue, 28 Jul 2026 14:30:00 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6ac44bcsm2245329f8f.11.2026.07.28.14.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 14:29:59 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Cc: asml.silence@gmail.com,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	David Sterba <dsterba@suse.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	dm-devel@lists.linux.dev,
	nvdimm@lists.linux.dev,
	linux-btrfs@vger.kernel.org,
	ceph-devel@vger.kernel.org
Subject: [PATCH v4 09/14] nvme-pci: add SGL support for the dmabuf path
Date: Tue, 28 Jul 2026 22:29:21 +0100
Message-ID: <5c2e9c3bdd3e87c0c9a6e4395ea199002b83fd36.1785274111.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785274111.git.asml.silence@gmail.com>
References: <cover.1785274111.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260728_143002_610359_CF6809BB 
X-CRM114-Status: GOOD (  19.05  )
X-Mailman-Approved-At: Tue, 28 Jul 2026 19:16:17 -0700
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

From: Anuj Gupta <anuj20.g@samsung.com>

Add SGL support in addition to PRP for dmabuf-backed requests,
coalescing the mapping's sg_table into NVMe SGL data descriptors.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
[pavel: rebased]
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/nvme/host/pci.c | 191 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 187 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f1b67c191892..cbb321fb7c50 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1287,12 +1287,18 @@ static blk_status_t nvme_pci_setup_data_prp(struct request *req,
 	return BLK_STS_IOERR;
 }
 
+static void nvme_pci_sgl_set_data_addr(struct nvme_sgl_desc *sge,
+				       dma_addr_t addr, u32 len)
+{
+	sge->addr = cpu_to_le64(addr);
+	sge->length = cpu_to_le32(len);
+	sge->type = NVME_SGL_FMT_DATA_DESC << 4;
+}
+
 static void nvme_pci_sgl_set_data(struct nvme_sgl_desc *sge,
 		struct blk_dma_iter *iter)
 {
-	sge->addr = cpu_to_le64(iter->addr);
-	sge->length = cpu_to_le32(iter->len);
-	sge->type = NVME_SGL_FMT_DATA_DESC << 4;
+	nvme_pci_sgl_set_data_addr(sge, iter->addr, iter->len);
 }
 
 static void nvme_pci_sgl_set_seg(struct nvme_sgl_desc *sge,
@@ -1303,6 +1309,158 @@ static void nvme_pci_sgl_set_seg(struct nvme_sgl_desc *sge,
 	sge->type = NVME_SGL_FMT_LAST_SEG_DESC << 4;
 }
 
+static unsigned int nvme_pci_dmabuf_sgl_nents(struct request *req,
+					      dma_addr_t *first_dma,
+					      u32 *first_len)
+{
+	struct bio *bio = req->bio;
+	struct nvme_dmabuf_map *map = to_nvme_dmabuf_map(bio->bi_dmabuf_map);
+	struct scatterlist *sg;
+	unsigned long tmp;
+	size_t offset = bio->bi_iter.bi_offset;
+	size_t remaining = blk_rq_payload_bytes(req);
+	dma_addr_t last_end = 0;
+	unsigned int nents = 0;
+	dma_addr_t dma = 0;
+	u32 len = 0;
+	bool have = false;
+
+	for_each_sgtable_dma_sg(map->sgt, sg, tmp) {
+		size_t sg_len = sg_dma_len(sg);
+		dma_addr_t addr = sg_dma_address(sg);
+
+		if (!remaining)
+			break;
+		if (offset >= sg_len) {
+			offset -= sg_len;
+			continue;
+		}
+
+		addr += offset;
+		sg_len -= offset;
+		offset = 0;
+
+		while (sg_len && remaining) {
+			u32 chunk = min_t(size_t, remaining, sg_len);
+
+			if (!have || last_end != addr) {
+				nents++;
+				if (nents == 1) {
+					dma = addr;
+					len = chunk;
+				}
+			} else if (nents == 1) {
+				len += chunk;
+			}
+
+			have = true;
+			last_end = addr + chunk;
+			addr += chunk;
+			sg_len -= chunk;
+			remaining -= chunk;
+		}
+	}
+
+	if (unlikely(remaining))
+	       return 0;
+
+	*first_dma = dma;
+	*first_len = len;
+	return nents;
+}
+
+static blk_status_t nvme_rq_setup_dmabuf_sgl(struct request *req,
+					     struct nvme_queue *nvmeq,
+					     unsigned int entries,
+					     dma_addr_t first_dma, u32 first_len)
+{
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	struct bio *bio = req->bio;
+	struct nvme_dmabuf_map *map = to_nvme_dmabuf_map(bio->bi_dmabuf_map);
+	size_t length = blk_rq_payload_bytes(req);
+	struct nvme_sgl_desc *sg_list = NULL;
+	dma_addr_t sgl_dma = 0, last_end = 0;
+	unsigned int mapped = 0;
+	unsigned long tmp;
+	struct scatterlist *sg;
+	size_t offset, remaining;
+	bool have = false;
+
+	if (!entries)
+		return BLK_STS_IOERR;
+	if (entries > NVME_MAX_SEGS)
+		return BLK_STS_AGAIN;
+
+	iod->cmd.common.flags = NVME_CMD_SGL_METABUF;
+	iod->total_len = length;
+
+	nvme_dmabuf_map_sync_for_device(nvmeq->dev, req);
+
+	if (entries == 1) {
+		nvme_pci_sgl_set_data_addr(&iod->cmd.common.dptr.sgl, first_dma,
+					   first_len);
+		return BLK_STS_OK;
+	}
+
+	if (entries <= NVME_SMALL_POOL_SIZE / sizeof(*sg_list))
+		iod->flags |= IOD_SMALL_DESCRIPTOR;
+
+	sg_list = dma_pool_alloc(nvme_dma_pool(nvmeq, iod), GFP_ATOMIC,
+				 &sgl_dma);
+	if (!sg_list)
+		return BLK_STS_RESOURCE;
+	iod->descriptors[iod->nr_descriptors++] = sg_list;
+
+	offset = bio->bi_iter.bi_offset;
+	remaining = length;
+
+	for_each_sgtable_dma_sg(map->sgt, sg, tmp) {
+		size_t sg_len = sg_dma_len(sg);
+		dma_addr_t addr = sg_dma_address(sg);
+
+		if (!remaining)
+			break;
+		if (offset >= sg_len) {
+			offset -= sg_len;
+			continue;
+		}
+
+		addr += offset;
+		sg_len -= offset;
+		offset = 0;
+
+		while (sg_len && remaining) {
+			u32 chunk = min_t(size_t, remaining, sg_len);
+
+			if (have && last_end == addr) {
+				u32 old = le32_to_cpu(sg_list[mapped - 1].length);
+
+				sg_list[mapped - 1].length = cpu_to_le32(old + chunk);
+			} else {
+				if (WARN_ON_ONCE(mapped == entries))
+					goto err_free;
+				nvme_pci_sgl_set_data_addr(&sg_list[mapped++],
+							   addr, chunk);
+			}
+			have = true;
+			last_end = addr + chunk;
+			addr += chunk;
+			sg_len -= chunk;
+			remaining -= chunk;
+		}
+	}
+
+	if (unlikely(remaining))
+		goto err_free;
+
+	nvme_pci_sgl_set_seg(&iod->cmd.common.dptr.sgl, sgl_dma, mapped);
+	return BLK_STS_OK;
+err_free:
+	iod->nr_descriptors--;
+	dma_pool_free(nvme_dma_pool(nvmeq, iod), sg_list, sgl_dma);
+	return BLK_STS_IOERR;
+}
+
 static blk_status_t nvme_pci_setup_data_sgl(struct request *req,
 		struct blk_dma_iter *iter)
 {
@@ -1397,8 +1555,33 @@ static blk_status_t nvme_map_data(struct request *req)
 	struct blk_dma_iter iter;
 	blk_status_t ret;
 
-	if (blk_mq_rq_is_dmabuf(req))
+	if (blk_mq_rq_is_dmabuf(req)) {
+		if (use_sgl != SGL_UNSUPPORTED) {
+			dma_addr_t first_dma;
+			u32 first_len;
+			unsigned int entries;
+
+			entries = nvme_pci_dmabuf_sgl_nents(req, &first_dma,
+							    &first_len);
+
+			if (use_sgl == SGL_FORCED) {
+				ret = nvme_rq_setup_dmabuf_sgl(req, nvmeq,
+								entries, first_dma, first_len);
+				return ret == BLK_STS_AGAIN ? BLK_STS_IOERR : ret;
+			}
+
+			if (sgl_threshold && entries &&
+			    DIV_ROUND_UP(blk_rq_payload_bytes(req), entries) >=
+			    sgl_threshold) {
+				ret = nvme_rq_setup_dmabuf_sgl(req, nvmeq,
+								entries, first_dma, first_len);
+				if (ret != BLK_STS_AGAIN)
+					return ret;
+			}
+		}
+
 		return nvme_rq_setup_dmabuf_map(req, nvmeq);
+	}
 
 	/*
 	 * Try to skip the DMA iterator for single segment requests, as that
-- 
2.54.0


