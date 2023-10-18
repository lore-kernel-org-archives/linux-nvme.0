Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 293D2CDB47E
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Oct 2023 18:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qf7Zl7qsLHIoMCFqm9qSB6HgRK8245PlROzZtjcq5w8=; b=GvwuTxKJgi9usZ6GI4mgaM7Ig/
	DRmIONnRZi/i4G4xL6HOEN+OUlNF7/XI6f40mQZW/zER4ImE400rDrIBoCt7Sk/+GKs1bAl59iY2W
	UeR9R46KvgCvqhWdXuAeg/utG2Dc+xRkPvXg1oHTDzEuwpLsk4+VN3ytAFmKgeAHctGDFGqOMchYY
	jc79KnMew9BUgKbkIk3e54wF8z3hyk82oIhYgXbSSU5s2VaPEm48G53lamhsU2Rc0bidASU+/qqgG
	IpY2f8kYfDxz4qYsi4N64TXkFSG3C0rJWsESFnYoqmwEysiOLe/LtSCM6iCx78bjZsgFxygPOlHv5
	6DVaI0Sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtBPL-00FTCK-33;
	Wed, 18 Oct 2023 18:36:39 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtBPH-00FT9N-1Z
	for linux-nvme@lists.infradead.org;
	Wed, 18 Oct 2023 18:36:38 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231018183628epoutp04e7aeaff2438bf1df351603992eddca69~PR310vxLo0976709767epoutp04C
	for <linux-nvme@lists.infradead.org>; Wed, 18 Oct 2023 18:36:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231018183628epoutp04e7aeaff2438bf1df351603992eddca69~PR310vxLo0976709767epoutp04C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1697654188;
	bh=qf7Zl7qsLHIoMCFqm9qSB6HgRK8245PlROzZtjcq5w8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pAORbHFWx/9PHxR0TMlH5s/oEeOkf/216lEDod5/0wodB3mzJ3EvV8vdIqE1bb7NM
	 XcWvCIGpn0hhkzeeJHjuLixbTrg7514FBlPGuLBjPiY78RP10nCcCN3hyZlNAvTmnY
	 V7kpZcifNfUsNKKJhFR7LgeNs5CERk3G28CmQYGA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20231018183628epcas5p28d0177442067b66a18734136e19109c2~PR31RHfdb1864818648epcas5p2D;
	Wed, 18 Oct 2023 18:36:28 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4S9fgt3b8Qz4x9Pv; Wed, 18 Oct
	2023 18:36:26 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	94.A9.09672.AA520356; Thu, 19 Oct 2023 03:36:26 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20231018183625epcas5p4d79f229a097cc083c2a2d2c77f6a5bb9~PR3zIxzP20493504935epcas5p4x;
	Wed, 18 Oct 2023 18:36:25 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231018183625epsmtrp2522b6b5131a9eaf8d046a6f9ab880e90~PR3zIJRpd0438704387epsmtrp2r;
	Wed, 18 Oct 2023 18:36:25 +0000 (GMT)
X-AuditID: b6c32a4b-60bfd700000025c8-2c-653025aa1c5a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B0.DA.08817.9A520356; Thu, 19 Oct 2023 03:36:25 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231018183624epsmtip123149749b6e134014a26e4efb1fdb7fb~PR3x16QbK1269912699epsmtip1H;
	Wed, 18 Oct 2023 18:36:24 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, gost.dev@samsung.com,
	joshiiitr@gmail.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH 1/2] nvme-pci: meta-transfer via sgl
Date: Thu, 19 Oct 2023 00:00:02 +0530
Message-Id: <20231018183003.41174-2-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231018183003.41174-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdlhTXXeVqkGqweFFkhar7/azWdw8sJPJ
	YuXqo0wWR/+/ZbM4//Ywk8WkQ9cYLeYve8puse71exYHDo+ds+6ye5y/t5HF4/LZUo9NqzrZ
	PDYvqffYfbOBzaNvyyrGAPaobJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8
	xNxUWyUXnwBdt8wcoKOUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQUmBXrFibnF
	pXnpenmpJVaGBgZGpkCFCdkZK39rFhzWqzhxcDtbA+MMtS5GTg4JAROJm0/nMILYQgK7GSX+
	rvfoYuQCsj8xSuzbcpkNwvnGKPGjbT4jTMeVExuZIBJ7GSU2vrgL5XxmlJh95ilLFyMHB5uA
	psSFyaUgDSICLhIN/96ANTMLlEgcmDWRFcQWBhrUNbmHCcRmEVCVmNb3FszmFbCQWHfqHzPE
	MnmJmZe+s4PYnAKWEjP7dzFC1AhKnJz5hAViprxE89bZzCA3SAh8ZZf4NukOK0Szi8SJ89/Y
	IWxhiVfHt0DZUhKf3+1lg7CTJS7NPMcEYZdIPN5zEMq2l2g91c8M8gsz0C/rd+lD7OKT6P39
	hAkkLCHAK9HRJgRRrShxb9JTqK3iEg9nLIGyPSSuXbjKCAmeHkaJg303GScwys9C8sIsJC/M
	Qti2gJF5FaNkakFxbnpqsWmBcV5qOTxak/NzNzGCU6aW9w7GRw8+6B1iZOJgPMQowcGsJMKb
	HqyTKsSbklhZlVqUH19UmpNafIjRFBjGE5mlRJPzgUk7ryTe0MTSwMTMzMzE0tjMUEmc93Xr
	3BQhgfTEktTs1NSC1CKYPiYOTqkGJm7trtjlWnn70mw3uwX+//2Yw+OUQ4Xjn7KSDzvvtQna
	CfLX/Ezkv3Q5zLM4iHdn8xunlAwLr7oW1cmXZFKNurrWWBYtWXQ7h3F22HpDloWSKTaqpgdt
	Qg8UqiSx3OOxyudY8vyJz8u8IOn30m/c/8x8UPL/uuucS1NipS44rVbZqHVpS1RqhOrllG3x
	qd93GMbKlYq0rc7mUOGbWPk9IEbKZasSzwI91t7y85Ps36scEs44f3T50qk8oS8yV27+zBF7
	yOat3+oLy+p8tdaeVeiYmtTRc/J145n+uD/837nlImcnhxlNkXaKfDana9br9Zw/NA6UOJ0Q
	1tCo3rrAIz5Lk5PDgZGh53XG5XtKLMUZiYZazEXFiQCHsyEgIgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsWy7bCSnO5KVYNUg9WLNS1W3+1ns7h5YCeT
	xcrVR5ksjv5/y2Zx/u1hJotJh64xWsxf9pTdYt3r9ywOHB47Z91l9zh/byOLx+WzpR6bVnWy
	eWxeUu+x+2YDm0ffllWMAexRXDYpqTmZZalF+nYJXBkrf2sWHNarOHFwO1sD4wy1LkZODgkB
	E4krJzYygdhCArsZJXo2aEDExSWar/1gh7CFJVb+e84OUfORUeJom08XIwcHm4CmxIXJpSBh
	EQEviXmzF7CA2MwCFRL/X79kBLGFgcZ3Te4BG88ioCoxre8tmM0rYCGx7tQ/Zojx8hIzL30H
	G88pYCkxs38XI8QqC4mP77ZC1QtKnJz5BGq+vETz1tnMExgFZiFJzUKSWsDItIpRMrWgODc9
	t9iwwCgvtVyvODG3uDQvXS85P3cTIzjUtbR2MO5Z9UHvECMTB+MhRgkOZiUR3vRgnVQh3pTE
	yqrUovz4otKc1OJDjNIcLErivN9e96YICaQnlqRmp6YWpBbBZJk4OKUamAK73kiceaFZvuPX
	n7ctMQcFdSx8nPzqNPULjk22eRmw1Kxt26VKPZZjR9yO2JQ9W/vZbNHx6DkfV55P31qiI6V8
	6l7w2hjFHS17pU9Lvuli+Z4qdTrIJSuI1UVo+bW7bO/PH9o9l/X7pBM/fDVmFn5J3fJX7bAI
	Q9K5oHvZD874PpylY3h54p3KluD22MVVzMluKw//6tLofi2+4cCE3THsp5V+qr2QeHf9XrVz
	5+Y0N2+l/G9G24/w1+pz9ccoNEZqHfjMEPKlODn51TJZ6U8BFTvFemuu3lr8LC5UfdsftWXM
	uisj9y+cvqyrdeqtqBDnrUz3Zzmuv7Oy5oqazgXlzb1WR7c5PIx/Y/9RRlGJpTgj0VCLuag4
	EQAuyUxh5AIAAA==
X-CMS-MailID: 20231018183625epcas5p4d79f229a097cc083c2a2d2c77f6a5bb9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231018183625epcas5p4d79f229a097cc083c2a2d2c77f6a5bb9
References: <20231018183003.41174-1-joshi.k@samsung.com>
	<CGME20231018183625epcas5p4d79f229a097cc083c2a2d2c77f6a5bb9@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_113635_848241_59949A63 
X-CRM114-Status: GOOD (  22.35  )
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

Introduce the ability to transfer the metadata buffer using sgl.
Also add a nvme request flag 'NVME_REQ_FORCE_SGL' that mandates both
data and meta transfer via sgl.

This is a prepatory patch to enable unprivileged passthrough via SGL.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/nvme.h |  6 ++++
 drivers/nvme/host/pci.c  | 63 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 64 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f35647c470af..58f8efe1ace9 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -184,6 +184,7 @@ enum {
 	NVME_REQ_CANCELLED		= (1 << 0),
 	NVME_REQ_USERCMD		= (1 << 1),
 	NVME_MPATH_IO_STATS		= (1 << 2),
+	NVME_REQ_FORCE_SGL		= (1 << 3),
 };
 
 static inline struct nvme_request *nvme_req(struct request *req)
@@ -1043,6 +1044,11 @@ static inline void nvme_start_request(struct request *rq)
 	blk_mq_start_request(rq);
 }
 
+static inline bool nvme_ctrl_meta_sgl_supported(struct nvme_ctrl *ctrl)
+{
+	return ctrl->sgls & (1 << 19);
+}
+
 static inline bool nvme_ctrl_sgl_supported(struct nvme_ctrl *ctrl)
 {
 	return ctrl->sgls & ((1 << 0) | (1 << 1));
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3f0c9ee09a12..1907b1c9919a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -123,6 +123,7 @@ struct nvme_dev {
 	struct device *dev;
 	struct dma_pool *prp_page_pool;
 	struct dma_pool *prp_small_pool;
+	struct dma_pool *meta_sgl_pool;
 	unsigned online_queues;
 	unsigned max_qid;
 	unsigned io_queues[HCTX_MAX_TYPES];
@@ -236,6 +237,8 @@ struct nvme_iod {
 	unsigned int dma_len;	/* length of single DMA segment mapping */
 	dma_addr_t first_dma;
 	dma_addr_t meta_dma;
+	dma_addr_t meta_dma_sg;
+	struct nvme_sgl_desc	*meta_sgl;
 	struct sg_table sgt;
 	union nvme_descriptor list[NVME_MAX_NR_ALLOCATIONS];
 };
@@ -772,18 +775,23 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	blk_status_t ret = BLK_STS_RESOURCE;
 	int rc;
+	bool force_sgl = nvme_req(req)->flags & NVME_REQ_FORCE_SGL;
+
+	if (force_sgl && !nvme_ctrl_sgl_supported(&dev->ctrl))
+		return BLK_STS_IOERR;
 
 	if (blk_rq_nr_phys_segments(req) == 1) {
 		struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 		struct bio_vec bv = req_bvec(req);
 
 		if (!is_pci_p2pdma_page(bv.bv_page)) {
-			if (bv.bv_offset + bv.bv_len <= NVME_CTRL_PAGE_SIZE * 2)
+			if (!force_sgl &&
+			    bv.bv_offset + bv.bv_len <= NVME_CTRL_PAGE_SIZE * 2)
 				return nvme_setup_prp_simple(dev, req,
 							     &cmnd->rw, &bv);
 
-			if (nvmeq->qid && sgl_threshold &&
-			    nvme_ctrl_sgl_supported(&dev->ctrl))
+			if (nvmeq->qid && nvme_ctrl_sgl_supported(&dev->ctrl)
+			    && (sgl_threshold || force_sgl))
 				return nvme_setup_sgl_simple(dev, req,
 							     &cmnd->rw, &bv);
 		}
@@ -806,7 +814,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		goto out_free_sg;
 	}
 
-	if (nvme_pci_use_sgls(dev, req, iod->sgt.nents))
+	if (force_sgl || nvme_pci_use_sgls(dev, req, iod->sgt.nents))
 		ret = nvme_pci_setup_sgls(dev, req, &cmnd->rw);
 	else
 		ret = nvme_pci_setup_prps(dev, req, &cmnd->rw);
@@ -825,13 +833,44 @@ static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req,
 		struct nvme_command *cmnd)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	bool force_sgl = nvme_req(req)->flags & NVME_REQ_FORCE_SGL;
+	blk_status_t ret;
 
 	iod->meta_dma = dma_map_bvec(dev->dev, rq_integrity_vec(req),
 			rq_dma_dir(req), 0);
 	if (dma_mapping_error(dev->dev, iod->meta_dma))
 		return BLK_STS_IOERR;
-	cmnd->rw.metadata = cpu_to_le64(iod->meta_dma);
+
+	if (!force_sgl) {
+		cmnd->rw.metadata = cpu_to_le64(iod->meta_dma);
+		return BLK_STS_OK;
+	}
+
+	if (!nvme_ctrl_meta_sgl_supported(&dev->ctrl)) {
+		WARN_ONCE(1, "controller does not support meta sgl.");
+		ret = BLK_STS_IOERR;
+		goto out_unmap;
+	}
+
+	iod->meta_sgl = dma_pool_alloc(dev->meta_sgl_pool, GFP_KERNEL,
+				       &iod->meta_dma_sg);
+	if (!iod->meta_sgl) {
+		ret = BLK_STS_IOERR;
+		goto out_unmap;
+	}
+
+	iod->meta_sgl->addr = cpu_to_le64(iod->meta_dma);
+	iod->meta_sgl->length = cpu_to_le32(rq_integrity_vec(req)->bv_len);
+	iod->meta_sgl->type = NVME_SGL_FMT_DATA_DESC << 4;
+	cmnd->rw.metadata = cpu_to_le64(iod->meta_dma_sg);
+	cmnd->rw.flags = NVME_CMD_SGL_METASEG;
+
 	return BLK_STS_OK;
+
+out_unmap:
+	dma_unmap_page(dev->dev, iod->meta_dma,
+			rq_integrity_vec(req)->bv_len, rq_dma_dir(req));
+	return ret;
 }
 
 static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
@@ -968,6 +1007,11 @@ static __always_inline void nvme_pci_unmap_rq(struct request *req)
 
 		dma_unmap_page(dev->dev, iod->meta_dma,
 			       rq_integrity_vec(req)->bv_len, rq_dma_dir(req));
+
+		if (nvme_req(req)->flags & NVME_REQ_FORCE_SGL)
+			dma_pool_free(dev->meta_sgl_pool,
+				      (void *)iod->meta_sgl,
+				      iod->meta_dma_sg);
 	}
 
 	if (blk_rq_nr_phys_segments(req))
@@ -2644,6 +2688,14 @@ static int nvme_setup_prp_pools(struct nvme_dev *dev)
 		dma_pool_destroy(dev->prp_page_pool);
 		return -ENOMEM;
 	}
+	/* for metadata sgl */
+	dev->meta_sgl_pool = dma_pool_create("meta sg 16", dev->dev, 16, 16, 0);
+	if (!dev->meta_sgl_pool) {
+		dma_pool_destroy(dev->prp_page_pool);
+		dma_pool_destroy(dev->prp_small_pool);
+		return -ENOMEM;
+	}
+
 	return 0;
 }
 
@@ -2651,6 +2703,7 @@ static void nvme_release_prp_pools(struct nvme_dev *dev)
 {
 	dma_pool_destroy(dev->prp_page_pool);
 	dma_pool_destroy(dev->prp_small_pool);
+	dma_pool_destroy(dev->meta_sgl_pool);
 }
 
 static int nvme_pci_alloc_iod_mempool(struct nvme_dev *dev)
-- 
2.25.1


