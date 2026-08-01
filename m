Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B5EC55175
	for <linux-nvme@archiver.kernel.org>; Sun,  2 Aug 2026 06:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3jtuIHi3+Rs23Pr4RqXoeVIdwK8MwXNBLfA4ntKbnrQ=; b=Gv9USLWTOQvfnjS/Xc8MtW+v/2
	Sxr8wAqbVzCVodHCjtZnsqtC/ua7g1aUmvmCXAesu0hElQeoxMDVT7QtyKTCdDzX0OBevxZsqot6T
	sqE2WYa/dDYWKIhsDEDJPcDNNn9Lb3tDmJATZkZP3qZsmBE2VI2KLvmlhwIvNEiK5ZuTBysgrHSzD
	d3sN3nK6cbI3tIaS+cLUYRQ2EhELhnIoXbztu+Hl36HBHDJTus1CccXhWkccQvgm/S3MmCO02A6qX
	LCIl1QmeWIRFeZ51e+hxo86C2Ln9c26hKBFL9lP9MDKZgvYGCRyKLRw5MfDaHtWkWdNhaznxIyfE5
	AGKTHBwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqPX7-0000000FOMz-1wNn;
	Sun, 02 Aug 2026 06:18:49 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqByN-0000000Ep9i-2Ogp
	for linux-nvme@lists.infradead.org;
	Sat, 01 Aug 2026 15:50:04 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2d049069377so14210855ad.0
        for <linux-nvme@lists.infradead.org>; Sat, 01 Aug 2026 08:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785599403; x=1786204203; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3jtuIHi3+Rs23Pr4RqXoeVIdwK8MwXNBLfA4ntKbnrQ=;
        b=nkYcx/6BDjPjDW514G7+3Bsuu65zRr79Pks0zGNmVxqupRnUvVDwOggYKRcl7GpYfh
         gMIoOmcCYgLT7lZg5dGlZlvS26jwHl31FtkRjq7hTRl1s4KzJ7IOBKrPRA7f3G73TdOC
         0IwRjPIC6Ie9c0UJbLFp5S9ax/AfmiNLfRG43PiZt8DFu650seM18n9DLgrcvQGiF6cI
         swH7iHAPvbH/28fVxYtgVf0wbFVu1dVU0vqVpYUK+ni00Ver12PNhhpaFJIlwmhGQsZf
         Fs1d9kSrgHVP/HRnTyXHwVCa1yYQN6utd/lkBW1f2RydkBL7Y8HSbxdemhRi+mz8LeU+
         iFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785599403; x=1786204203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3jtuIHi3+Rs23Pr4RqXoeVIdwK8MwXNBLfA4ntKbnrQ=;
        b=JFWlUVXVMrPDa4bGkaIOMlZv8RhUammL/biFwi9V6KiFz96oEPYboZ1AGQWKWvSlWa
         UOs4zvy8TfS67QsuNXZGrXY3pCIRqZ76haqUJiRjkQbrHNcmeq6j3uTTauMnUErrKTx0
         H6zJlRGqGNTkJBp3V8MYL9i9ZfFDIRHnmNUPgErfk+B56CLqVpEhJfTF7HU9+AkainXZ
         64FIUGdy4dWwxUWFtCSH+u7xU4LX4mGQj3fqYLj+8bvrkBTw4St7BXV+A7YtdvR60FsM
         1gIOzV0s9J00dhh8eoGTa9iMEXXSwk7RgTm8EhgMSqSUqL0zRMTxbUvxb1qPwsy1CFG7
         mwmg==
X-Forwarded-Encrypted: i=1; AHgh+RperTHKGYarmhB6G6ykh2wYybhfpOSFjX0bbQgJEJKW50oTaA7ydbwe+KRci5nOF7t86qUI7wISpRkq@lists.infradead.org
X-Gm-Message-State: AOJu0YwRudh7F8XhO+WMPQYYYY1pJVW7c9NIDY/Xlf7CoB3/OVDytBBf
	dQ0KL4V7JTUOr5/LrU+Rsr0TCTmdLtr317cMm8/iQminHtOhOtc0508X
X-Gm-Gg: AR+sD11ZEdjtfwghCPHri3Pay5E9EmfLVN/rvJKXTYzFoTs2dq6jh/4Sfz2VCAD8RBn
	u0ffhUfrLh7F2If+Z33zlX56CudMZ53Oid4y7jC6UZ36Y4ogILVJ30W4xDtNWu692cIOYSmdZp1
	zHZ6xPR9q8Da52ZVLgYJzEERi8svTsyGphvMxiy14qqQO9lh1kMjMIpmsF1XF48Qxb5BCkdAOAm
	BIf3JFxbhqoEc0jxb/88POMj1N/RwKg1siLahiiLWTnSSm2CyNJaW109G7qsudR06ykDBg3OG+C
	ZID3e9SDuUAnWecsXE3oBoBJkS9RprgZhfND70TOWkErJY2cZrIeoaeGrlSAhdj8DIf7pBXicEM
	3ceWeYF3M8U+FjZ6UsllbjOXzIG+BWAngZ6dVI3gLUNsXf3uwXzUwJHq5DaUcKiHs2Zo7qhUw4W
	inKFhFnScFx3A2mcLZAIRoKZbzGNWgu+GJorThI60azSXD8M8KcLKV5LDCA/P6lmJ88YDWXUBEd
	0XLSJfeD9MVioUrmhJlw1h59YrbnFBdCWrhrcSaFi0DEjY=
X-Received: by 2002:a17:903:32c5:b0:2c6:a981:b591 with SMTP id d9443c01a7336-2d0523bd6b9mr37885665ad.30.1785599402798;
        Sat, 01 Aug 2026 08:50:02 -0700 (PDT)
Received: from 127.net ([2620:10d:c092:600::1:61d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b12202bsm18287605ad.66.2026.08.01.08.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 08:50:02 -0700 (PDT)
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
Subject: [PATCH v5 09/16] nvme-pci: implement dma-buf backed requests
Date: Sat,  1 Aug 2026 16:46:21 +0100
Message-ID: <9e3dd1b2d71dc0f9bd556b6a6d6e48fb6a8d727b.1785596451.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785596451.git.asml.silence@gmail.com>
References: <cover.1785596451.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260801_085003_652340_08D30D54 
X-CRM114-Status: GOOD (  23.42  )
X-Mailman-Approved-At: Sat, 01 Aug 2026 23:18:43 -0700
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

Enable BIO_DMABUF_MAP backed requests. On registration we map the
dma-buf and store it as a prp list, which is then used to initialise
requests.

Suggested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/nvme/host/core.c |  12 ++
 drivers/nvme/host/nvme.h |   2 +
 drivers/nvme/host/pci.c  | 265 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 279 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 453c1f0b2dd0..8bd407603d92 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2676,6 +2676,17 @@ static int nvme_report_zones(struct gendisk *disk, sector_t sector,
 #define nvme_report_zones	NULL
 #endif /* CONFIG_BLK_DEV_ZONED */
 
+static int nvme_init_dma_buf_io_ctx(struct block_device *bdev,
+		struct dma_buf_io_ctx *ctx)
+{
+	struct nvme_ns *ns = bdev->bd_disk->private_data;
+	struct nvme_ctrl *ctrl = ns->ctrl;
+
+	if (!ctrl->ops->init_dma_buf_io_ctx)
+		return -EINVAL;
+	return ctrl->ops->init_dma_buf_io_ctx(ctrl, ctx);
+}
+
 const struct block_device_operations nvme_bdev_ops = {
 	.owner		= THIS_MODULE,
 	.ioctl		= nvme_ioctl,
@@ -2686,6 +2697,7 @@ const struct block_device_operations nvme_bdev_ops = {
 	.get_unique_id	= nvme_get_unique_id,
 	.report_zones	= nvme_report_zones,
 	.pr_ops		= &nvme_pr_ops,
+	.init_dma_buf_io_ctx = nvme_init_dma_buf_io_ctx,
 };
 
 static int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 mask, u32 val,
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 824651cc898d..034c31af8fec 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -652,6 +652,8 @@ struct nvme_ctrl_ops {
 	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
 	void (*print_device_info)(struct nvme_ctrl *ctrl);
 	bool (*supports_pci_p2pdma)(struct nvme_ctrl *ctrl);
+	int (*init_dma_buf_io_ctx)(struct nvme_ctrl *ctrl,
+				   struct dma_buf_io_ctx *ctx);
 	unsigned long (*get_virt_boundary)(struct nvme_ctrl *ctrl, bool is_admin);
 };
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 69932d640b53..5608ede6c479 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -27,6 +27,8 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/io-64-nonatomic-hi-lo.h>
 #include <linux/sed-opal.h>
+#include <linux/dma-buf-io.h>
+#include <linux/dma-resv.h>
 
 #include "trace.h"
 #include "nvme.h"
@@ -393,6 +395,13 @@ struct nvme_queue {
 	struct completion delete_done;
 };
 
+struct nvme_dmabuf_map {
+	struct dma_buf_io_map base;
+	struct sg_table *sgt;
+	unsigned nr_entries;
+	dma_addr_t dma_list[];
+};
+
 /* bits for iod->flags */
 enum nvme_iod_flags {
 	/* this command has been aborted by the timeout handler */
@@ -859,6 +868,138 @@ static void nvme_free_descriptors(struct request *req)
 	}
 }
 
+static inline struct nvme_dmabuf_map *
+to_nvme_dmabuf_map(struct dma_buf_io_map *map)
+{
+	return container_of(map, struct nvme_dmabuf_map, base);
+}
+
+static void nvme_dmabuf_map_sync_for_cpu(struct nvme_dev *nvme_dev,
+					 struct request *req)
+{
+	struct device *dev = nvme_dev->dev;
+	enum dma_data_direction dma_dir;
+	struct bio *bio = req->bio;
+	struct nvme_dmabuf_map *map = to_nvme_dmabuf_map(bio->bi_dmabuf_map);
+	dma_addr_t *dma_list = map->dma_list;
+	unsigned offset = bio->bi_iter.bi_offset;
+	unsigned map_idx = offset / NVME_CTRL_PAGE_SIZE;
+	int length = blk_rq_payload_bytes(req) +
+		     (offset & (NVME_CTRL_PAGE_SIZE - 1));
+
+	dma_dir = rq_data_dir(req) == READ ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
+
+	while (length > 0) {
+		dma_sync_single_for_cpu(dev, dma_list[map_idx++],
+					NVME_CTRL_PAGE_SIZE, dma_dir);
+		length -= NVME_CTRL_PAGE_SIZE;
+	}
+}
+
+static void nvme_dmabuf_map_sync_for_device(struct nvme_dev *nvme_dev,
+					    struct request *req)
+{
+	struct device *dev = nvme_dev->dev;
+	enum dma_data_direction dma_dir;
+	struct bio *bio = req->bio;
+	struct nvme_dmabuf_map *map = to_nvme_dmabuf_map(bio->bi_dmabuf_map);
+	dma_addr_t *dma_list = map->dma_list;
+	unsigned offset = bio->bi_iter.bi_offset;
+	unsigned map_idx = offset / NVME_CTRL_PAGE_SIZE;
+	int length = blk_rq_payload_bytes(req) +
+		     (offset & (NVME_CTRL_PAGE_SIZE - 1));
+
+	dma_dir = rq_data_dir(req) == READ ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
+
+	while (length > 0) {
+		dma_sync_single_for_device(dev, dma_list[map_idx++],
+					   NVME_CTRL_PAGE_SIZE, dma_dir);
+		length -= NVME_CTRL_PAGE_SIZE;
+	}
+}
+
+static void nvme_rq_clean_dmabuf_map(struct nvme_dev *dev,
+				      struct request *req)
+{
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+
+	nvme_dmabuf_map_sync_for_cpu(dev, req);
+
+	if (!(iod->flags & IOD_SINGLE_SEGMENT))
+		nvme_free_descriptors(req);
+}
+
+static blk_status_t nvme_rq_setup_dmabuf_map(struct request *req,
+					     struct nvme_queue *nvmeq)
+{
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	struct bio *bio = req->bio;
+	struct nvme_dmabuf_map *map = to_nvme_dmabuf_map(bio->bi_dmabuf_map);
+	unsigned bvec_done = bio->bi_iter.bi_offset;
+	unsigned map_idx = bvec_done / NVME_CTRL_PAGE_SIZE;
+	unsigned offset = bvec_done & (NVME_CTRL_PAGE_SIZE - 1);
+	int length = blk_rq_payload_bytes(req) - (NVME_CTRL_PAGE_SIZE - offset);
+	dma_addr_t *dma_list = map->dma_list;
+	u64 prp1_dma = dma_list[map_idx++] + offset;
+	u64 dma_addr, prp2_dma;
+	dma_addr_t prp_dma;
+	__le64 *prp_list;
+	unsigned i;
+
+	nvme_dmabuf_map_sync_for_device(nvmeq->dev, req);
+
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
@@ -937,6 +1078,11 @@ static void nvme_unmap_data(struct request *req)
 	struct device *dma_dev = nvmeq->dev->dev;
 	unsigned int attrs = 0;
 
+	if (blk_mq_rq_is_dmabuf(req)) {
+		nvme_rq_clean_dmabuf_map(nvmeq->dev, req);
+		return;
+	}
+
 	if (iod->flags & IOD_SINGLE_SEGMENT) {
 		static_assert(offsetof(union nvme_data_ptr, prp1) ==
 				offsetof(union nvme_data_ptr, sgl.addr));
@@ -1251,6 +1397,9 @@ static blk_status_t nvme_map_data(struct request *req)
 	struct blk_dma_iter iter;
 	blk_status_t ret;
 
+	if (blk_mq_rq_is_dmabuf(req))
+		return nvme_rq_setup_dmabuf_map(req, nvmeq);
+
 	/*
 	 * Try to skip the DMA iterator for single segment requests, as that
 	 * significantly improves performances for small I/O sizes.
@@ -2269,6 +2418,118 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
 	return result;
 }
 
+#ifdef CONFIG_DMA_SHARED_BUFFER
+static void nvme_dmabuf_invalidate_mappings(struct dma_buf_attachment *attach)
+{
+	struct dma_buf_io_ctx *ctx = attach->importer_priv;
+
+	dma_buf_io_invalidate_mappings(ctx);
+}
+
+const struct dma_buf_attach_ops nvme_dmabuf_importer_ops = {
+	.invalidate_mappings	= nvme_dmabuf_invalidate_mappings,
+	.allow_peer2peer	= true,
+};
+
+static struct dma_buf_io_map *nvme_dma_buf_io_map(struct dma_buf_io_ctx *ctx)
+{
+	unsigned nr_entries = ctx->dmabuf->size / NVME_CTRL_PAGE_SIZE;
+	struct dma_buf_attachment *attach = ctx->dev_priv;
+	unsigned long tmp, i = 0;
+	unsigned seg_shift = ~0U;
+	struct nvme_dmabuf_map *map;
+	struct scatterlist *sg;
+	struct sg_table *sgt;
+	int ret;
+
+	dma_resv_assert_held(ctx->dmabuf->resv);
+
+	map = kmalloc_flex(*map, dma_list, nr_entries);
+	if (!map)
+		return ERR_PTR(-ENOMEM);
+
+	sgt = dma_buf_map_attachment(attach, ctx->dir);
+	if (IS_ERR(sgt)) {
+		ret = PTR_ERR(sgt);
+		sgt = NULL;
+		goto err;
+	}
+
+	for_each_sgtable_dma_sg(sgt, sg, tmp) {
+		dma_addr_t dma_addr = sg_dma_address(sg);
+		unsigned long sg_len = sg_dma_len(sg);
+
+		if (sg_len % NVME_CTRL_PAGE_SIZE) {
+			ret = -EINVAL;
+			goto err;
+		}
+		seg_shift = min(seg_shift, __ffs(sg_len));
+
+		while (sg_len) {
+			map->dma_list[i++] = dma_addr;
+			dma_addr += NVME_CTRL_PAGE_SIZE;
+			sg_len -= NVME_CTRL_PAGE_SIZE;
+		}
+	}
+
+	if (WARN_ON_ONCE(seg_shift < NVME_CTRL_PAGE_SHIFT))
+		return ERR_PTR(-EFAULT);
+
+	ret = dma_buf_io_init_map(ctx, &map->base);
+	if (ret)
+		goto err;
+	map->base.seg_shift = seg_shift;
+	map->nr_entries = nr_entries;
+	map->sgt = sgt;
+	return &map->base;
+err:
+	if (sgt)
+		dma_buf_unmap_attachment(attach, sgt, ctx->dir);
+	kfree(map);
+	return ERR_PTR(ret);
+}
+
+static void nvme_dma_buf_io_unmap(struct dma_buf_io_ctx *ctx,
+				  struct dma_buf_io_map *map_base)
+{
+	struct dma_buf_attachment *attach = ctx->dev_priv;
+	struct nvme_dmabuf_map *map = to_nvme_dmabuf_map(map_base);
+
+	dma_resv_assert_held(ctx->dmabuf->resv);
+
+	dma_buf_unmap_attachment(attach, map->sgt, ctx->dir);
+}
+
+static void nvme_dma_buf_io_release(struct dma_buf_io_ctx *ctx)
+{
+	struct dma_buf_attachment *attach = ctx->dev_priv;
+
+	dma_buf_detach(ctx->dmabuf, attach);
+}
+
+const struct dma_buf_io_ops nvme_dma_buf_io_ops = {
+	.map		= nvme_dma_buf_io_map,
+	.unmap		= nvme_dma_buf_io_unmap,
+	.release	= nvme_dma_buf_io_release,
+};
+
+static int nvme_pci_init_dma_buf_io_ctx(struct nvme_ctrl *ctrl,
+					struct dma_buf_io_ctx *ctx)
+{
+	struct dma_buf_attachment *attach;
+	struct nvme_dev *dev = to_nvme_dev(ctrl);
+
+	attach = dma_buf_dynamic_attach(ctx->dmabuf, dev->dev,
+					&nvme_dmabuf_importer_ops, ctx);
+	if (IS_ERR(attach))
+		return PTR_ERR(attach);
+
+	ctx->dev_priv = attach;
+	ctx->dev_ops = &nvme_dma_buf_io_ops;
+	return 0;
+}
+#endif
+
 static const struct blk_mq_ops nvme_mq_admin_ops = {
 	.queue_rq	= nvme_queue_rq,
 	.complete	= nvme_pci_complete_rq,
@@ -3563,6 +3824,9 @@ static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
 	.print_device_info	= nvme_pci_print_device_info,
 	.supports_pci_p2pdma	= nvme_pci_supports_pci_p2pdma,
 	.get_virt_boundary	= nvme_pci_get_virt_boundary,
+#ifdef CONFIG_DMA_SHARED_BUFFER
+	.init_dma_buf_io_ctx	= nvme_pci_init_dma_buf_io_ctx,
+#endif
 };
 
 static int nvme_dev_map(struct nvme_dev *dev)
@@ -4327,5 +4591,6 @@ MODULE_AUTHOR("Matthew Wilcox <willy@linux.intel.com>");
 MODULE_LICENSE("GPL");
 MODULE_VERSION("1.0");
 MODULE_DESCRIPTION("NVMe host PCIe transport driver");
+MODULE_IMPORT_NS("DMA_BUF");
 module_init(nvme_init);
 module_exit(nvme_exit);
-- 
2.54.0


