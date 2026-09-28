Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084B6CA5FAE
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2026 08:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j1oj1dAJP0I40+o8SeAXsOmkZXs4Z4JZibo2wpFxfPw=; b=NRCjNHGBmOcx6gnJ+y6x0+5Wy/
	tjMTmk08qHPlHiv/WCDa3Tgnqd2smfwzvZfiGNnUjoYRExT66tKK37btd03JA52S202AbKZP+QKqM
	wl4RyAFxBtM1Xhswy3DB48ki+ifR/LJhfIBo7MxzYJi82QGDza0JxTLS+Cy24KzzAGVY4y9qGu+oL
	2NmSwhfqbWOW1K+gj9Vzat7l/D2npsaWfEFfylNsb3clF8OgkEfM6n0UvlsiHgPYoME+SVFgJY0Bk
	XLl1GNbO7KJHUIMtCzNAnJgvwW3NVEYtMvTlT+Ufl5+O4yi1M+AFEezYAWQbCrVbtj2TOxz89E5WH
	EOtdb8kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBT7c-00000002jMm-24XM;
	Tue, 29 Sep 2026 08:23:32 +0000
Received: from mail-wr2-x16.google.com ([2a00:1450:4864:30::16])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBBTW-00000000fHF-2dXX
	for linux-nvme@lists.infradead.org;
	Mon, 28 Sep 2026 13:32:59 +0000
Received: by mail-wr2-x16.google.com with SMTP id ffacd0b85a97d-4834977ae75so1793981f8f.3
        for <linux-nvme@lists.infradead.org>; Mon, 28 Sep 2026 06:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790602377; x=1791207177; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j1oj1dAJP0I40+o8SeAXsOmkZXs4Z4JZibo2wpFxfPw=;
        b=Rc4IPyIj4ddfTEX9QWTP0FWdURtq7q89Aau1R0wiHrbXMv7qDjStXKR2pgcpxV0u8R
         cfQ0CkatEVRDrVKpAKTBJw2mQO1tav1iuQOuYrqlSDSyOr8LqpdeT7GHlQkiu8qytzlZ
         +9rSWMEuM/ZKwM2JIoeQbpYSOgjN2FhuZQoeV4RdjUJ2y1ihRrE1Y283WTP40C2YiOd1
         YHWx81wNy7DLNqyslC7agbzvjaAcipbn/4/dIQw8g9ttrdCdU360Dk1O3N9ywypRJKc1
         +IkKZEX97NZCFS8U5VYVIkkhozapdI9ZCL8EDR/J09Ip0k7opQLvZkr6LzOCz5hp+m4w
         UcTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790602377; x=1791207177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j1oj1dAJP0I40+o8SeAXsOmkZXs4Z4JZibo2wpFxfPw=;
        b=uToiJzBq17x1V00t9vvW0YHB3VGVGISOJMR+2lkM/zrUiNKE4KCa3pNDeUpYXTMxPr
         LRothpfTpz3DdBgiCdZ97WMWK4XS87ytVtQdtM8pKZv11n31eZ2jCzcU1S0ygVUP6Z9K
         VyBVoN15SHPVVppT2GtmIjriaxiPvOkfCRj5Mo71aJAU+QomIzYZ5esKH7yGCrdmy/dD
         Yu6rbklOwq/EJDx/o9ie3+y7FbypbfYWDvGPuMPlzYpSm5rQoxrXx23HHREnhM1QGNFN
         24WTs+Q9hViIa9obNyEJ8D+FmJrYD/bpUIC9LnmLFAEuXmMi3J/oeaUGJGcQJVICGRhZ
         GvMg==
X-Forwarded-Encrypted: i=1; AKwUvBx0vhN/eAK+n0zPIFegXyl6ZrMb54KtLP3TGbir42U3cnkybPqenrX3bG3xCEvdXegRbhJd1c+XWQg6@lists.infradead.org
X-Gm-Message-State: AFq9FYLufNl+FTWngwX0Exk+Fkk9ajtMvV/gSrrNUi5zsyZvWhxD+Mse
	VFafSH+kkWBi/2FvCQ9GWM/UpgjRRlAWQDZ1E85FlpifNkdDrTFLaTlU
X-Gm-Gg: AYBFou0qzrw456YqWAraMtEHUsqUmCMBejFbosuuftxxavaFm8K/eL2PzWnH7Aoqyfz
	uOyiiN3/IsDB+YawYDRjJY8oFO5H8ClJEvgoJ9HvGV2PajSU9WKgOlY2m/yXS04IZ5z2CJNPxAK
	rGOS2f8nz1wS1sWlQQeJLW+Rb8GZmuy/V86P6Bw79IuwavATrw6a16qLJ3gPdqdUUr2WhUnMYyL
	lEXFaNqi75Aw9HyEWDZC5FBT2pdA9iG0iUk/wWwsrPQQhR9bJ0V56Sg8iWQJ7yMQKRMZKTiirps
	UgTEZghXiV6DMuWd08m9XTM6zx4aVbGM+iAHtQakGbB7eP9371E7qo7gWl8Bk+29r6+XguKfbSH
	PMMMGsejw0s26LVZJ2bB6xOp4hUcgC3ax+eSdGFvzm2kprhxpjfDyWx+4JXE8FpoLWLZwVf+KI1
	e/vR1Yp9ywYKM/AKZU+WkpjNl8L5UOVI9YDNYmVYh/3OkxBZ1gVuZskcsl7yolLdrKfMLQuQpy0
	khb+Gmyf19L3rUYHJrY0NYrabDEEvgIXjT8OwbTLboGBZv0NilFBMwb3ECNOh3LIKN57I2tuhv+
X-Received: by 2002:a5d:5f53:0:b0:488:8b07:f3fc with SMTP id ffacd0b85a97d-48aeddea01dmr1376199f8f.17.1790602376733;
        Mon, 28 Sep 2026 06:32:56 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a349731sm28090164f8f.12.2026.09.28.06.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 06:32:55 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org
Cc: asml.silence@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	dm-devel@lists.linux.dev
Subject: [PATCH v7 08/13] nvme-pci: add SGL support for the dmabuf path
Date: Mon, 28 Sep 2026 14:32:24 +0100
Message-ID: <9d09ba51f1335a17576f3b92f0e93230c39751d2.1790602223.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1790602223.git.asml.silence@gmail.com>
References: <cover.1790602223.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_063258_731093_93171275 
X-CRM114-Status: GOOD (  20.03  )
X-Mailman-Approved-At: Tue, 29 Sep 2026 01:23:30 -0700
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
building the descriptor list from the mapping's sg_table.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/nvme/host/pci.c | 153 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 149 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index bb8051c62926..36d8987bb28d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1277,12 +1277,18 @@ static blk_status_t nvme_pci_setup_data_prp(struct request *req,
 	return BLK_STS_IOERR;
 }
 
+static void nvme_pci_sgl_set_data(struct nvme_sgl_desc *sge,
+		dma_addr_t addr, u32 len)
+{
+	sge->addr = cpu_to_le64(addr);
+	sge->length = cpu_to_le32(len);
+	sge->type = NVME_SGL_FMT_DATA_DESC << 4;
+}
+
 static void nvme_pci_dma_iter_set_sgl(struct nvme_sgl_desc *sge,
 		struct blk_dma_iter *iter)
 {
-	sge->addr = cpu_to_le64(iter->addr);
-	sge->length = cpu_to_le32(iter->len);
-	sge->type = NVME_SGL_FMT_DATA_DESC << 4;
+	nvme_pci_sgl_set_data(sge, iter->addr, iter->len);
 }
 
 static void nvme_pci_sgl_set_seg(struct nvme_sgl_desc *sge,
@@ -1293,6 +1299,145 @@ static void nvme_pci_sgl_set_seg(struct nvme_sgl_desc *sge,
 	sge->type = NVME_SGL_FMT_LAST_SEG_DESC << 4;
 }
 
+static unsigned int nvme_pci_dmabuf_sgl_nents(struct request *req)
+{
+	struct bio *bio = req->bio;
+	struct nvme_dmabuf_map *map = to_nvme_dmabuf_map(bio->bi_dmabuf_map);
+	struct scatterlist *sg;
+	unsigned long tmp;
+	size_t offset = bio->bi_iter.bi_offset;
+	size_t remaining = blk_rq_payload_bytes(req);
+	unsigned int nents = 0;
+
+	for_each_sgtable_dma_sg(map->sgt, sg, tmp) {
+		size_t sg_len = sg_dma_len(sg);
+
+		if (!remaining)
+			break;
+		if (offset >= sg_len) {
+			offset -= sg_len;
+			continue;
+		}
+
+		sg_len -= offset;
+		offset = 0;
+
+		do {
+			size_t chunk = min(remaining, sg_len);
+
+			nents++;
+			sg_len -= chunk;
+			remaining -= chunk;
+		} while (sg_len && remaining);
+	}
+
+	if (unlikely(remaining))
+		return 0;
+
+	return nents;
+}
+
+static blk_status_t nvme_rq_setup_dmabuf_sgl(struct request *req,
+		struct nvme_queue *nvmeq, unsigned int entries)
+{
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	struct bio *bio = req->bio;
+	struct nvme_dmabuf_map *map = to_nvme_dmabuf_map(bio->bi_dmabuf_map);
+	size_t length = blk_rq_payload_bytes(req);
+	struct nvme_sgl_desc *sg_list = &iod->cmd.common.dptr.sgl;
+	bool pooled = entries > 1;
+	dma_addr_t sgl_dma = 0;
+	unsigned int mapped = 0;
+	unsigned long tmp;
+	struct scatterlist *sg;
+	size_t offset = bio->bi_iter.bi_offset;
+	size_t remaining = length;
+
+	if (!entries)
+		return BLK_STS_IOERR;
+
+	iod->cmd.common.flags = NVME_CMD_SGL_METABUF;
+	iod->total_len = length;
+
+	nvme_dmabuf_map_sync_for_device(nvmeq->dev, req);
+
+	/* entries == 1 fits in the inline descriptor; more needs a pool. */
+	if (pooled) {
+		if (entries <= NVME_SMALL_POOL_SIZE / sizeof(*sg_list))
+			iod->flags |= IOD_SMALL_DESCRIPTOR;
+
+		sg_list = dma_pool_alloc(nvme_dma_pool(nvmeq, iod), GFP_ATOMIC,
+					 &sgl_dma);
+		if (!sg_list)
+			return BLK_STS_RESOURCE;
+		iod->descriptors[iod->nr_descriptors++] = sg_list;
+	}
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
+		do {
+			u32 chunk = min_t(size_t, remaining, sg_len);
+
+			if (WARN_ON_ONCE(mapped == entries))
+				goto err_free;
+			nvme_pci_sgl_set_data(&sg_list[mapped++], addr, chunk);
+
+			addr += chunk;
+			sg_len -= chunk;
+			remaining -= chunk;
+		} while (sg_len && remaining);
+	}
+
+	if (unlikely(remaining))
+		goto err_free;
+
+	if (pooled)
+		nvme_pci_sgl_set_seg(&iod->cmd.common.dptr.sgl, sgl_dma,
+				     mapped);
+	return BLK_STS_OK;
+err_free:
+	if (pooled) {
+		iod->nr_descriptors--;
+		dma_pool_free(nvme_dma_pool(nvmeq, iod), sg_list, sgl_dma);
+	}
+	return BLK_STS_IOERR;
+}
+
+static blk_status_t nvme_rq_setup_dmabuf(struct request *req,
+		struct nvme_queue *nvmeq, enum nvme_use_sgl use_sgl)
+{
+	unsigned int entries;
+	size_t avg_seg;
+
+	if (use_sgl == SGL_UNSUPPORTED)
+		return nvme_rq_setup_dmabuf_map(req, nvmeq);
+
+	entries = nvme_pci_dmabuf_sgl_nents(req);
+
+	if (use_sgl == SGL_FORCED)
+		return nvme_rq_setup_dmabuf_sgl(req, nvmeq, entries);
+
+	avg_seg = entries ?
+		DIV_ROUND_UP(blk_rq_payload_bytes(req), entries) : 0;
+	if (sgl_threshold && avg_seg >= sgl_threshold)
+		return nvme_rq_setup_dmabuf_sgl(req, nvmeq, entries);
+
+	return nvme_rq_setup_dmabuf_map(req, nvmeq);
+}
+
 static blk_status_t nvme_pci_setup_data_sgl(struct request *req,
 		struct blk_dma_iter *iter)
 {
@@ -1388,7 +1533,7 @@ static blk_status_t nvme_map_data(struct request *req)
 	blk_status_t ret;
 
 	if (blk_mq_rq_is_dmabuf(req))
-		return nvme_rq_setup_dmabuf_map(req, nvmeq);
+		return nvme_rq_setup_dmabuf(req, nvmeq, use_sgl);
 
 	/*
 	 * Try to skip the DMA iterator for single segment requests, as that
-- 
2.54.0


