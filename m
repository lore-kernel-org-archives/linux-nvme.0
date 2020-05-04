Return-Path: <SRS0=qmg+=6S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EDDC3A5A9
	for <linux-nvme@archiver.kernel.org>; Mon,  4 May 2020 15:59:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DADDB20721
	for <linux-nvme@archiver.kernel.org>; Mon,  4 May 2020 15:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Efz6aLFa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DADDB20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ggRGUgfVu4eBJ/2/NQBk1tRsrK5QljE8Kz6nWidK1D8=; b=Efz6aLFaf8huCd
	4jOFV8tKLUFx03jFfJYnz/EaGwiLnK5DWwkbBh+Gg7EoKPXM660RnMzTDxwMgZeGFLspx6OmUynZQ
	21cpbxi4APeKVPJKEICiySqA5zXdEptij4EIQe6Fc9jKAVyAXhG1AXC6CUvNRKG0ScZM00uWExHwg
	c06NHa5rFKQYroXfrZeqL47fLuf9J4DuZG1JgUkLQdtUREhMxE6X5bpcdTyi/FFywWevzzeSE+1+g
	fTz3B9KxZMeUTXMZGxAG3eiZnMJmvjnVAKqENc5gEI1b9uF+Dt/1b8cYtVO2mjcMGLG0G9GP4NCNt
	gMQ4aiqDOMRcT999lSJw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jVdUn-0001uA-68; Mon, 04 May 2020 15:59:05 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jVdTr-00011D-9o
 for linux-nvme@lists.infradead.org; Mon, 04 May 2020 15:58:10 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 4 May 2020 18:57:56 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 044FvtCK017882;
 Mon, 4 May 2020 18:57:56 +0300
From: Max Gurtovoy <maxg@mellanox.com>
To: maxg@mellanox.com, linux-nvme@lists.infradead.org, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, martin.petersen@oracle.com,
 jsmart2021@gmail.com, axboe@kernel.dk
Subject: [PATCH 08/16] nvme-rdma: introduce nvme_rdma_sgl structure
Date: Mon,  4 May 2020 18:57:47 +0300
Message-Id: <20200504155755.221125-9-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200504155755.221125-1-maxg@mellanox.com>
References: <20200504155755.221125-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200504_085807_733128_B87EF251 
X-CRM114-Status: GOOD (  11.14  )
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
Cc: vladimirk@mellanox.com, shlomin@mellanox.com, israelr@mellanox.com,
 idanb@mellanox.com, oren@mellanox.com, nitzanc@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Israel Rukshin <israelr@mellanox.com>

Remove first_sgl pointer from struct nvme_rdma_request and use pointer
arithmetic instead. The inline scatterlist, if exists, will be located
right after the nvme_rdma_request. This patch is needed as a preparation
for adding PI support.

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/rdma.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index cac8a93..4086874 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -48,6 +48,11 @@ struct nvme_rdma_qe {
 	u64			dma;
 };
 
+struct nvme_rdma_sgl {
+	int			nents;
+	struct sg_table		sg_table;
+};
+
 struct nvme_rdma_queue;
 struct nvme_rdma_request {
 	struct nvme_request	req;
@@ -58,12 +63,10 @@ struct nvme_rdma_request {
 	refcount_t		ref;
 	struct ib_sge		sge[1 + NVME_RDMA_MAX_INLINE_SEGMENTS];
 	u32			num_sge;
-	int			nents;
 	struct ib_reg_wr	reg_wr;
 	struct ib_cqe		reg_cqe;
 	struct nvme_rdma_queue  *queue;
-	struct sg_table		sg_table;
-	struct scatterlist	first_sgl[];
+	struct nvme_rdma_sgl	data_sgl;
 };
 
 enum nvme_rdma_queue_flags {
@@ -1158,8 +1161,9 @@ static void nvme_rdma_unmap_data(struct nvme_rdma_queue *queue,
 		req->mr = NULL;
 	}
 
-	ib_dma_unmap_sg(ibdev, req->sg_table.sgl, req->nents, rq_dma_dir(rq));
-	sg_free_table_chained(&req->sg_table, NVME_INLINE_SG_CNT);
+	ib_dma_unmap_sg(ibdev, req->data_sgl.sg_table.sgl, req->data_sgl.nents,
+			rq_dma_dir(rq));
+	sg_free_table_chained(&req->data_sgl.sg_table, NVME_INLINE_SG_CNT);
 }
 
 static int nvme_rdma_set_sg_null(struct nvme_command *c)
@@ -1178,7 +1182,7 @@ static int nvme_rdma_map_sg_inline(struct nvme_rdma_queue *queue,
 		int count)
 {
 	struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
-	struct scatterlist *sgl = req->sg_table.sgl;
+	struct scatterlist *sgl = req->data_sgl.sg_table.sgl;
 	struct ib_sge *sge = &req->sge[1];
 	u32 len = 0;
 	int i;
@@ -1203,8 +1207,8 @@ static int nvme_rdma_map_sg_single(struct nvme_rdma_queue *queue,
 {
 	struct nvme_keyed_sgl_desc *sg = &c->common.dptr.ksgl;
 
-	sg->addr = cpu_to_le64(sg_dma_address(req->sg_table.sgl));
-	put_unaligned_le24(sg_dma_len(req->sg_table.sgl), sg->length);
+	sg->addr = cpu_to_le64(sg_dma_address(req->data_sgl.sg_table.sgl));
+	put_unaligned_le24(sg_dma_len(req->data_sgl.sg_table.sgl), sg->length);
 	put_unaligned_le32(queue->device->pd->unsafe_global_rkey, sg->key);
 	sg->type = NVME_KEY_SGL_FMT_DATA_DESC << 4;
 	return 0;
@@ -1225,7 +1229,8 @@ static int nvme_rdma_map_sg_fr(struct nvme_rdma_queue *queue,
 	 * Align the MR to a 4K page size to match the ctrl page size and
 	 * the block virtual boundary.
 	 */
-	nr = ib_map_mr_sg(req->mr, req->sg_table.sgl, count, NULL, SZ_4K);
+	nr = ib_map_mr_sg(req->mr, req->data_sgl.sg_table.sgl, count, NULL,
+			  SZ_4K);
 	if (unlikely(nr < count)) {
 		ib_mr_pool_put(queue->qp, &queue->qp->rdma_mrs, req->mr);
 		req->mr = NULL;
@@ -1272,17 +1277,18 @@ static int nvme_rdma_map_data(struct nvme_rdma_queue *queue,
 	if (!blk_rq_nr_phys_segments(rq))
 		return nvme_rdma_set_sg_null(c);
 
-	req->sg_table.sgl = req->first_sgl;
-	ret = sg_alloc_table_chained(&req->sg_table,
-			blk_rq_nr_phys_segments(rq), req->sg_table.sgl,
+	req->data_sgl.sg_table.sgl = (struct scatterlist *)(req + 1);
+	ret = sg_alloc_table_chained(&req->data_sgl.sg_table,
+			blk_rq_nr_phys_segments(rq), req->data_sgl.sg_table.sgl,
 			NVME_INLINE_SG_CNT);
 	if (ret)
 		return -ENOMEM;
 
-	req->nents = blk_rq_map_sg(rq->q, rq, req->sg_table.sgl);
+	req->data_sgl.nents = blk_rq_map_sg(rq->q, rq,
+					    req->data_sgl.sg_table.sgl);
 
-	count = ib_dma_map_sg(ibdev, req->sg_table.sgl, req->nents,
-			      rq_dma_dir(rq));
+	count = ib_dma_map_sg(ibdev, req->data_sgl.sg_table.sgl,
+			      req->data_sgl.nents, rq_dma_dir(rq));
 	if (unlikely(count <= 0)) {
 		ret = -EIO;
 		goto out_free_table;
@@ -1311,9 +1317,10 @@ static int nvme_rdma_map_data(struct nvme_rdma_queue *queue,
 	return 0;
 
 out_unmap_sg:
-	ib_dma_unmap_sg(ibdev, req->sg_table.sgl, req->nents, rq_dma_dir(rq));
+	ib_dma_unmap_sg(ibdev, req->data_sgl.sg_table.sgl, req->data_sgl.nents,
+			rq_dma_dir(rq));
 out_free_table:
-	sg_free_table_chained(&req->sg_table, NVME_INLINE_SG_CNT);
+	sg_free_table_chained(&req->data_sgl.sg_table, NVME_INLINE_SG_CNT);
 	return ret;
 }
 
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
