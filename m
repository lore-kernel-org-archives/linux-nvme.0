Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 208BDC98300
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 15:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mH7BvLrcnLu8WRQAlFxz4vQAXzatlrTdCQIygZg9AG4=; b=QqYo8yMye1qXUvzZqGPKWPj7sl
	kbnAUOngPHlKaEq3PFDNtwKdHWcrVkVlQ4nji9fKVyZZbLbdb1lC6a86Jfg6rAIJQhsi1mRvZQNRj
	r3nTiPm1iIsKXO4BU2q8v7Eb8z3QwsxCkmSj+Yf6wM/KAODw6WThUGuhr7ti/KDDXTFpEKaCQ0/6m
	fs0bO8BRp13N0qgvjzV5AwTrkCS9GFA9NJ+OYjaGsmZ6GucJI1pXtR0rLxKAaW1deMbenl4nI0Rho
	PCEkwO1Alp22Yb2GD9o7k5UfC7mdoYCd3S+mwupcccmTmfajPbpIta+Q5R5d1y189ASfjBnCpRQKJ
	aDChrhAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8fWG-00000002Viy-1uVo;
	Mon, 21 Sep 2026 15:01:24 +0000
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8eFI-00000002GYa-3CBA
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 13:39:49 +0000
Received: by mail-wm2-x10.google.com with SMTP id 5b1f17b1804b1-49b912e2406so15485275e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 21 Sep 2026 06:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789997987; x=1790602787; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mH7BvLrcnLu8WRQAlFxz4vQAXzatlrTdCQIygZg9AG4=;
        b=KQt/5h+zsuLvudBVMzNortnjepZuuLj8COL8LgPe0gdMZhLcUrLp1C2E5iWfH5WELy
         9eLtDKcAZDEQmZYBYwRqmUwnxv3h8Nw2/2EDaOskUmmpDT89ksviLlvcCQHOXNMIEcGy
         Y1dkHe5SeJxWPGouPeOZqWDaNogIx258voCvschqw/6kX08vH8Yhif55ApKvitu9789z
         3DhmwbuWwtITxQ+TdalVCFYqpAzbs2b1KnZRC6rpJ7LYaCIY8COMCZY/uFnz4mdqUP8v
         5e3+8wbt4kA9vjfLn4QmiZFE0UFNDe2akDXjKHIACaKrVXemosKqPQV0LEMjjeAjWXuZ
         cgjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789997987; x=1790602787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mH7BvLrcnLu8WRQAlFxz4vQAXzatlrTdCQIygZg9AG4=;
        b=0dKt2XhnuhZ46GUbOZgrWJSIszj1D6anQDF6MmXEV9V2IutyQNgObUP9czEpjMvnWh
         x7s1kusd+ORgX7Fz4lgPghbK3RaXhLUNoQo1CkD45M9plLL+dbYbjhcysPgaGydbuIcZ
         w7Uny7yASMBH0ZEHUljpwS/ghdF+DIN6ROW4RrmZ+L1l+B/hufom8XU4JFsZZ6oTU9pW
         oLCH/DMpmj7GQB8dHQRwoZ9Zu6gHLJSo6xhAk2X3EkIg/8ZED4TTbAil2uL9xLWpgDId
         JVFjaCCj6tkwjJOCGGN2GqWTjrfqY151tBN15tMyyZ5aJpbhnthZ74zPq3ai+cjC5zoy
         tW3w==
X-Forwarded-Encrypted: i=1; AKwUvByiMyl0t8TOkUiYBS54HjxmURjermVu1VymooXT4hEk8pgwsjOUiEOnTRb7eVvqFmfGL8aTuFJlrHqg@lists.infradead.org
X-Gm-Message-State: AFuF++nKt+sBbJHlUFQ0DCcDoJLMzStilVEXHTqlx+zcLwrodvpVIaOU
	iq7FFklnPdjscx5zQlk+lJCwfj8+En5eYdrJXD45jz/7TxPBwIRMdEso
X-Gm-Gg: AYBFou2bfy2btMMO/kaHu3rUmQWbSaf7fWZ2xO5VZLgzf9aZ1iN52sOp7Crj9Wbrw1Q
	NIVHrsCgifWbLdtkiUvpS2FjxjwHkce5EzrlMpAAFitNr/jJdEn3P1m7FNFDmOt8/dLLKPPgWwA
	T8kp+VqnCAerGOoPZW++BUK2hpdI0AF3JxsNaeURqiKzojkhvI7GCuA0BVI/zgO48e9LDPSAgEV
	GEUuYlEq+vjKBEQfkBUyOhcC84J3AB9ygryFOUT5/kLjoyQAEnu6Tm2ESDj+sxaSc7oGoGQpiEg
	V0SMQDk6h7qomfWDCrCjI45Q4K4f7EJxHrfEUcZlXu9Zryr0FSmoO/yvCcIKAkaJmtbjyF8ctvW
	dwxeCEfJO0p7EIUZlFnk4o0gnJVgw//JL3qAQEzv5K1I4UH2cPAnRdsn5QXvwEzkqel7ik2ul51
	Fm/mACqZEPQmPEQB7vuNUnxMHPcCBOL8IyUVuldiurPqd8HYFKuVHGTsgpovuBW3EbQD2HV1wOf
	ger4JMrBNTv5GycRpiwdFAgwrCINijxu5xUuYa3DV1vQ/E+jmC/rBpmVrrmtQwLfe3Ep4SUxALZ
	FspLFF/XPz7Ey5i7sGawZCjzw88K/g==
X-Received: by 2002:a05:600c:1d06:b0:49e:8222:3451 with SMTP id 5b1f17b1804b1-49fc5001358mr167903285e9.14.1789997987144;
        Mon, 21 Sep 2026 06:39:47 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-213-26.dab.02.net. [82.132.213.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc585920fsm617171605e9.4.2026.09.21.06.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 06:39:46 -0700 (PDT)
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
Subject: [PATCH v6 08/13] nvme-pci: add SGL support for the dmabuf path
Date: Mon, 21 Sep 2026 14:38:52 +0100
Message-ID: <1a50e7e88263f97403f8df8583dbb1953600f2a9.1789997898.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1789997898.git.asml.silence@gmail.com>
References: <cover.1789997898.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_063948_861842_C60F65EC 
X-CRM114-Status: GOOD (  19.97  )
X-Mailman-Approved-At: Mon, 21 Sep 2026 08:01:20 -0700
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
index 8dc4002fa696..4756f114154c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1297,12 +1297,18 @@ static blk_status_t nvme_pci_setup_data_prp(struct request *req,
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
@@ -1313,6 +1319,145 @@ static void nvme_pci_sgl_set_seg(struct nvme_sgl_desc *sge,
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
@@ -1408,7 +1553,7 @@ static blk_status_t nvme_map_data(struct request *req)
 	blk_status_t ret;
 
 	if (blk_mq_rq_is_dmabuf(req))
-		return nvme_rq_setup_dmabuf_map(req, nvmeq);
+		return nvme_rq_setup_dmabuf(req, nvmeq, use_sgl);
 
 	/*
 	 * Try to skip the DMA iterator for single segment requests, as that
-- 
2.54.0


