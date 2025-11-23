Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 816ECCFD316
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Nov 2025 22:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aczXTymWXQPIGDaXnf/nBr9xYQNzFFU48NeAsCHNOPA=; b=3YtCGzbLdIwTmLcQ1HsU1BXxaZ
	kjbj+sZm8QYk2KZQeIw3u5OIXKK0DDUWI8rQ5gfGNB70CTF03wOy4IjD6mDFJexU9c2qK/SFuR53V
	k4Kt+fYyOjLhxndiMTws9htWWwx6LzazIspMjDcpIw8m8szREfTWEliPybEW0n3K0Taw73ktKKFO3
	0WchlWWlHwxQT779YPJLTGbILLlzQBeEIJxY0oef1JQhvmOOrNIwWvid1MCS+RZwfNn1Y480uPGUw
	yy75CEyZdXLRLqx57uhCPO50U8qCH/kOtdABtSag84+yBZoY8BVLIlQozFhQgn2uGcyAAowaITAXe
	J4aY1N2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNIw4-0000000AkpW-3Yas;
	Sun, 23 Nov 2025 22:52:00 +0000
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNIw2-0000000Akmd-0bUb
	for linux-nvme@lists.infradead.org;
	Sun, 23 Nov 2025 22:51:59 +0000
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-42b38de7940so1790783f8f.3
        for <linux-nvme@lists.infradead.org>; Sun, 23 Nov 2025 14:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763938316; x=1764543116; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aczXTymWXQPIGDaXnf/nBr9xYQNzFFU48NeAsCHNOPA=;
        b=YvqobVvSjTKnes2ZP5jAqUWmhBY+evNYkWzTOxF1/TH1CRpQlC8q6J91nmDceS3Fjf
         4cGbDHdPxlrx+F0w9AmJlgymLGLp7LjQTXvjmqRW12tde0iMrqw5ZBNK1nMB9UkDWiX8
         Q/w+BeD9sy9ZU3MKty4LyktGzYGLvBs1JRJta3M40KJhUH8bL4cYru4az0RBMLOcAn7K
         m0a0NfkDVPthuXzuvObYIgVmX6xXg4dMJd/p1tMPi71Sj7kRo0u4TJxryzQYi1DIXykW
         sWcBpqxmuaNgreGfIN0E+SLdMujB5QfoHx3fxxNdvm+ELbYsQGlcYbeMvwhjWQcsa9D8
         HfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763938316; x=1764543116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aczXTymWXQPIGDaXnf/nBr9xYQNzFFU48NeAsCHNOPA=;
        b=IN5k2U7xlJlASZOj3NZo5UZAb5yQyh6oNNzd37OkiHFBWpCczt5bIjfJ/6mcEChzuh
         MYsxDLztunO1sZYraqw53pzzwVvQ7xMuiKlurS2Izo+kCyfVSh+wLUCvD9aJuWL1hm/z
         DkgHQ8z/Gn6/50+VJmzRY8dBh0mmQ5H4WWLQiqxY4pelUQXTyK0k7Hp47RjpMp4j7ODu
         2Z+HxKkRBRcoiAOOPfonIEmtFfgZ27ORMeVfnXmIQKBj5MRV1FRmiht0GGadpNIltFBQ
         Z05EL8HykFqnVaz/l/JAAurgWGhS3D7oZHyHEERqXcBymBn5A9bSnynXQlgbjWyaz1uf
         VicA==
X-Forwarded-Encrypted: i=1; AJvYcCV8FnliYXUUVe7DldQoZGrX4NIaG5B2vEl6ozmrobR0bebesq73MyaDIGCXMGguT469SzICELPczft3@lists.infradead.org
X-Gm-Message-State: AOJu0Yx+AbrpGKXDs2lKS9+dKXtZqBC5Hfd/a7tK/+EmqsGGgSZl0oIv
	BHDZCq+hoPmXYfiyBQXqRLImDO175BsgIGQSqatkfaoPm14l3XNaij/8
X-Gm-Gg: ASbGnctM+dAPKahlht6tp9cxIwol8HVEf9sFFvLa4gUMmYLyX9457h0bHhBpeV/Jb8l
	lbYL5li4fIbeiHFAqNp0aoBUB2FOllqBMABj++B+8gXoPF5rpY6qdHt6KHBEsbZ2FVtkiFCQZ+h
	wiZlijEssqnIdJOo8mDEOxBSEqnXTjEzELSbOM4C6e9LTtlJerRbJ53wD8t1du/Dfe7xPrVMKLc
	pQK5PrNREHQ+gC5+H7UHnrW+uQPXeN/Lh5rfZw2kcLAUq/gmPleo0CctvOI43aKqX5+tLECvoOR
	X+GnCO8Pj4aXaScccT1mfGIe38Unycoi2vQsImxK3ij46HCa5bFr8yc8E05QpjraEujoO1Pqu0Q
	xi1PyK5fxZ+lO+sQtSF5ohKNQpiPC20CVKSXZsCDFjeiOCj6GBEQKfbJ3rawJFedso1c8rfiley
	ECRpLg1hPUnqWVYQ==
X-Google-Smtp-Source: AGHT+IEhsmDeavDDsXXTdPeMYswvjoeFYMEcGIVgrZUZIxbXidFIxZRmwhVPCPHioGiavOVUtI6phA==
X-Received: by 2002:a05:6000:2893:b0:42b:55f3:6196 with SMTP id ffacd0b85a97d-42cc1ab89b3mr10647235f8f.4.1763938316187;
        Sun, 23 Nov 2025 14:51:56 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb9190sm24849064f8f.33.2025.11.23.14.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 14:51:54 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org,
	io-uring@vger.kernel.org
Cc: Vishal Verma <vishal1.verma@intel.com>,
	tushar.gohad@intel.com,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Subject: [RFC v2 07/11] nvme-pci: implement dma_token backed requests
Date: Sun, 23 Nov 2025 22:51:27 +0000
Message-ID: <a86bbe2d8d105ed2c342749cd46ece2d1c537821.1763725388.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1763725387.git.asml.silence@gmail.com>
References: <cover.1763725387.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251123_145158_214630_56265A0F 
X-CRM114-Status: GOOD (  19.49  )
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

Enable BIO_DMA_TOKEN backed requests. It requires special handling to
set up the nvme request from the prepared in advance mapping, tear it
down and sync the buffers.

Suggested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/nvme/host/pci.c | 126 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 124 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 63e03c3dc044..ac377416b088 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -797,6 +797,123 @@ static void nvme_free_descriptors(struct request *req)
 	}
 }
 
+static void nvme_sync_dma(struct nvme_dev *nvme_dev, struct request *req,
+			  enum dma_data_direction dir)
+{
+	struct blk_mq_dma_map *map = req->dma_map;
+	int length = blk_rq_payload_bytes(req);
+	bool for_cpu = dir == DMA_FROM_DEVICE;
+	struct device *dev = nvme_dev->dev;
+	dma_addr_t *dma_list = map->private;
+	struct bio *bio = req->bio;
+	int offset, map_idx;
+
+	offset = bio->bi_iter.bi_bvec_done;
+	map_idx = offset / NVME_CTRL_PAGE_SIZE;
+	length += offset & (NVME_CTRL_PAGE_SIZE - 1);
+
+	while (length > 0) {
+		u64 dma_addr = dma_list[map_idx++];
+
+		if (for_cpu)
+			__dma_sync_single_for_cpu(dev, dma_addr,
+						  NVME_CTRL_PAGE_SIZE, dir);
+		else
+			__dma_sync_single_for_device(dev, dma_addr,
+						     NVME_CTRL_PAGE_SIZE, dir);
+		length -= NVME_CTRL_PAGE_SIZE;
+	}
+}
+
+static void nvme_unmap_premapped_data(struct nvme_dev *dev,
+				      struct request *req)
+{
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+
+	if (rq_data_dir(req) == READ)
+		nvme_sync_dma(dev, req, DMA_FROM_DEVICE);
+	if (!(iod->flags & IOD_SINGLE_SEGMENT))
+		nvme_free_descriptors(req);
+}
+
+static blk_status_t nvme_dma_premapped(struct request *req,
+				       struct nvme_queue *nvmeq)
+{
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	int length = blk_rq_payload_bytes(req);
+	struct blk_mq_dma_map *map = req->dma_map;
+	u64 dma_addr, prp1_dma, prp2_dma;
+	struct bio *bio = req->bio;
+	dma_addr_t *dma_list;
+	dma_addr_t prp_dma;
+	__le64 *prp_list;
+	int i, map_idx;
+	int offset;
+
+	dma_list = map->private;
+
+	if (rq_data_dir(req) == WRITE)
+		nvme_sync_dma(nvmeq->dev, req, DMA_TO_DEVICE);
+
+	offset = bio->bi_iter.bi_bvec_done;
+	map_idx = offset / NVME_CTRL_PAGE_SIZE;
+	offset &= (NVME_CTRL_PAGE_SIZE - 1);
+
+	prp1_dma = dma_list[map_idx++] + offset;
+
+	length -= (NVME_CTRL_PAGE_SIZE - offset);
+	if (length <= 0) {
+		prp2_dma = 0;
+		goto done;
+	}
+
+	if (length <= NVME_CTRL_PAGE_SIZE) {
+		prp2_dma = dma_list[map_idx];
+		goto done;
+	}
+
+	if (DIV_ROUND_UP(length, NVME_CTRL_PAGE_SIZE) <=
+	    NVME_SMALL_POOL_SIZE / sizeof(__le64))
+		iod->flags |= IOD_SMALL_DESCRIPTOR;
+
+	prp_list = dma_pool_alloc(nvme_dma_pool(nvmeq, iod), GFP_ATOMIC,
+			&prp_dma);
+	if (!prp_list)
+		return BLK_STS_RESOURCE;
+
+	iod->descriptors[iod->nr_descriptors++] = prp_list;
+	prp2_dma = prp_dma;
+	i = 0;
+	for (;;) {
+		if (i == NVME_CTRL_PAGE_SIZE >> 3) {
+			__le64 *old_prp_list = prp_list;
+
+			prp_list = dma_pool_alloc(nvmeq->descriptor_pools.large,
+					GFP_ATOMIC, &prp_dma);
+			if (!prp_list)
+				goto free_prps;
+			iod->descriptors[iod->nr_descriptors++] = prp_list;
+			prp_list[0] = old_prp_list[i - 1];
+			old_prp_list[i - 1] = cpu_to_le64(prp_dma);
+			i = 1;
+		}
+
+		dma_addr = dma_list[map_idx++];
+		prp_list[i++] = cpu_to_le64(dma_addr);
+
+		length -= NVME_CTRL_PAGE_SIZE;
+		if (length <= 0)
+			break;
+	}
+done:
+	iod->cmd.common.dptr.prp1 = cpu_to_le64(prp1_dma);
+	iod->cmd.common.dptr.prp2 = cpu_to_le64(prp2_dma);
+	return BLK_STS_OK;
+free_prps:
+	nvme_free_descriptors(req);
+	return BLK_STS_RESOURCE;
+}
+
 static void nvme_free_prps(struct request *req, unsigned int attrs)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
@@ -875,6 +992,11 @@ static void nvme_unmap_data(struct request *req)
 	struct device *dma_dev = nvmeq->dev->dev;
 	unsigned int attrs = 0;
 
+	if (req->bio && bio_flagged(req->bio, BIO_DMA_TOKEN)) {
+		nvme_unmap_premapped_data(nvmeq->dev, req);
+		return;
+	}
+
 	if (iod->flags & IOD_SINGLE_SEGMENT) {
 		static_assert(offsetof(union nvme_data_ptr, prp1) ==
 				offsetof(union nvme_data_ptr, sgl.addr));
@@ -1154,8 +1276,8 @@ static blk_status_t nvme_map_data(struct request *req)
 	struct blk_dma_iter iter;
 	blk_status_t ret;
 
-	if (req->bio && bio_flagged(req->bio, BIO_DMA_TOKEN))
-		return BLK_STS_RESOURCE;
+	if (req->dma_map)
+		return nvme_dma_premapped(req, nvmeq);
 
 	/*
 	 * Try to skip the DMA iterator for single segment requests, as that
-- 
2.52.0


