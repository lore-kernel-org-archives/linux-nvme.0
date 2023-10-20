Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0EACC0032E
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Oct 2023 13:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i+OpaiZaPNNhXL6Gu3QRZygK1TfEv/M0ZGW2suDwE0M=; b=JHMvEF+jZ0uphLvkbbyWyT3IjM
	Lt+MI23pLMiATNpZKHZCQjGKqgDFha6ZZF6Cdq1AHXr8phL9pvM/YA6pVkMtTP5GR65ETG6DrRlaF
	s7Os6lssNMBvYdXRoAvdBoMRUrU8jLZ24IHjPuuO8iRHDF9wInKPj5vvJcKNqmcaPiRIBWzVorc8O
	NNqn4yHYx7SFqv1ul3KK8GxCrKdTO+tWEn4uoBP/3AbSwODsXKIh1o1N2E+4nIh/XsvWoC+UsgdAA
	T6rjDAvJ0vh5hYu5zzWait+qe+wL1wSS4ku6uGSIgJsxPYX9i2Dui6vsvlppcuU2/cBla1J69av7B
	YUuAqcMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtpen-002Nka-39;
	Fri, 20 Oct 2023 13:35:17 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtpei-002NiN-2p
	for linux-nvme@lists.infradead.org;
	Fri, 20 Oct 2023 13:35:16 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231020133507epoutp02c135607de38e0d8cb5a50ed208b777c4~P1DSj3mZU2347023470epoutp02S
	for <linux-nvme@lists.infradead.org>; Fri, 20 Oct 2023 13:35:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231020133507epoutp02c135607de38e0d8cb5a50ed208b777c4~P1DSj3mZU2347023470epoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1697808907;
	bh=i+OpaiZaPNNhXL6Gu3QRZygK1TfEv/M0ZGW2suDwE0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HykjZ2qApZ6R3AyOil6teCxdCP5j7WYDYI7IFoX8OtYpoxT/nKL2VZT9TyuEQy8iI
	 UdKpbS8y/Tmc3BISVgUOXtKIeRbUbnVzx3V4w2oT/x1/Rd5wYHA2RWxERjLMJrweC2
	 uAOD0oXR2mT2OFpDMyGSB2ajFLY1ikSyvRGtedDs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20231020133506epcas5p28ed1f2bac9ff4f87a5d845b92d508815~P1DR9CuCY0543305433epcas5p2j;
	Fri, 20 Oct 2023 13:35:06 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4SBlvD6TjFz4x9Ps; Fri, 20 Oct
	2023 13:35:04 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A2.97.09672.80282356; Fri, 20 Oct 2023 22:35:04 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20231020133504epcas5p2572d63d3563671825ea8dc07d4074937~P1DQJaHss2234922349epcas5p2u;
	Fri, 20 Oct 2023 13:35:04 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231020133504epsmtrp2e7d8fbd7a97e5c8180a3d4e9be616b26~P1DQIt_w00487504875epsmtrp28;
	Fri, 20 Oct 2023 13:35:04 +0000 (GMT)
X-AuditID: b6c32a4b-39fff700000025c8-e7-653282080bce
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D9.71.08817.80282356; Fri, 20 Oct 2023 22:35:04 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231020133503epsmtip10446b9d97f093fdf507daca7456f9acb~P1DOxXzDq1779917799epsmtip1U;
	Fri, 20 Oct 2023 13:35:02 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, gost.dev@samsung.com,
	joshiiitr@gmail.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH v2 2/3] nvme-pci: data/meta transfer via SGL
Date: Fri, 20 Oct 2023 18:58:36 +0530
Message-Id: <20231020132837.151037-3-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231020132837.151037-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdlhTU5ejySjVYNo5Q4vVd/vZLG4e2Mlk
	sXL1USaLo//fslmcf3uYyWLSoWuMFvOXPWW3WPf6PYsDh8fOWXfZPc7f28jicflsqcemVZ1s
	HpuX1HvsvtnA5tG3ZRVjAHtUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJe
	Ym6qrZKLT4CuW2YO0FFKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAKTAr3ixNzi
	0rx0vbzUEitDAwMjU6DChOyMCVdushS0aFW8+NfF2sB4TKmLkZNDQsBE4t68TkYQW0hgN6PE
	wcNREPYnRok3G1S7GLmA7G+MEo1Le1hgGr4+/McCkdjLKHFow1JmCOczo8SyKwfYuxg5ONgE
	NCUuTC4FaRARcJFo+PcGbAOzQInEgVkTWUFsYQEbiRlrroHZLAKqEm/2dYHZvAKWEre3nmOE
	WCYvMfPSd7CRnAJWEsvflUKUCEqcnPmEBWKkvETz1tlgJ0gI/GWXeHXjPDNEr4vEpB3vWSFs
	YYlXx7ewQ9hSEp/f7WWDsJMlLs08xwRhl0g83nMQyraXaD3VzwyylxnolfW79CF28Un0/n7C
	BBKWEOCV6GgTgqhWlLg36SnUJnGJhzOWQNkeEu92rGaFhE4vo8Tbe4/YJzDKz0LywiwkL8xC
	2LaAkXkVo2RqQXFuemqxaYFxXmo5PFaT83M3MYITppb3DsZHDz7oHWJk4mA8xCjBwawkwqvq
	YZAqxJuSWFmVWpQfX1Sak1p8iNEUGMQTmaVEk/OBKTuvJN7QxNLAxMzMzMTS2MxQSZz3devc
	FCGB9MSS1OzU1ILUIpg+Jg5OqQam81dKdu6Y3zi5cU1Jd3bRxsXbgmTVf/o9qtMr55mg+itv
	irvhptlJza/X8Hqqnd+8onTJzXf3fb8dkw8wjvxlq+zGOdthyrr0F7HL+R/EKfiv2xncu4C9
	MP7uY85G2+NX0zdWLHu5qkeuNfVTPb/y6/lm6jViRT+0QvK/XPTYtkC/ozrj24+IZSIsd5q+
	17Ns2/s8z8fz8s83/DY3PuzfPa+I/6Ta5TUn+m9NXNCbmPKnpyJCvezaeZWExcdNcs/sY1mw
	aI3rWpN4v6JT6hleW5T2pmU5dZ7bYm3BeGhL8JnrfzvFj81++mbu3OtMn7fP469n+8U9s3D/
	iX8cHOFGy5bZXFb+Mvs6x5XAty0L+JVYijMSDbWYi4oTAbBAjgwhBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsWy7bCSnC5Hk1GqwcM2MYvVd/vZLG4e2Mlk
	sXL1USaLo//fslmcf3uYyWLSoWuMFvOXPWW3WPf6PYsDh8fOWXfZPc7f28jicflsqcemVZ1s
	HpuX1HvsvtnA5tG3ZRVjAHsUl01Kak5mWWqRvl0CV8aEKzdZClq0Kl7862JtYDym1MXIySEh
	YCLx9eE/li5GLg4hgd2MErvuz2KFSIhLNF/7wQ5hC0us/PecHaLoI6PEiUcv2LoYOTjYBDQl
	LkwuBakREfCSmDd7AQuIzSxQIfH/9UtGEFtYwEZixpprYDNZBFQl3uzrArN5BSwlbm89xwgx
	X15i5qXv7CAjOQWsJJa/AxspBFTSeH8uG0S5oMTJmU+gxstLNG+dzTyBUWAWktQsJKkFjEyr
	GCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNzNzGCw11LawfjnlUf9A4xMnEwHmKU4GBWEuFV
	9TBIFeJNSaysSi3Kjy8qzUktPsQozcGiJM777XVvipBAemJJanZqakFqEUyWiYNTqoEpVOhh
	hFR333s/u6v1LTt8m22/NhWosq62Nrt77HDe+4ZDR0KuLDOZnWk4cXvJ+lJDEa/v5q9zb+9l
	Trp5YDOfuC/rh5VLDylO2XN5ifIPqeqC/AlV+1+zMnUXnnF6Lq/FZBRdKjtJief/mrmNZkWb
	N6xyPPHuXayvaEW7b9KdAo5PPqVCmTYp1Xw5XeE5VqpeefG/hJ9PEP36TzdiY/LTM+bRjsbf
	ppRMO6taMqF93Xax6xEzAqt4F250q9mwdc/CoqLX829fNp5zMsKncdW3iUEZN/sviamuzjZ/
	up/7QSTHFkHF2u9xHesvB3d0OdyTzRBtVArSt6w4fPhVL/+8+jeHnvpPsIpfyRK1wE2JpTgj
	0VCLuag4EQDKgJu/5gIAAA==
X-CMS-MailID: 20231020133504epcas5p2572d63d3563671825ea8dc07d4074937
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231020133504epcas5p2572d63d3563671825ea8dc07d4074937
References: <20231020132837.151037-1-joshi.k@samsung.com>
	<CGME20231020133504epcas5p2572d63d3563671825ea8dc07d4074937@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_063513_675827_BCB9E00B 
X-CRM114-Status: GOOD (  21.25  )
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

If NVME_REQ_FORCE_SGL flag is set, make the data and meta transfer
use SGL. A new dma pool is used to allocate per-io metadata sgl.

This is a prepatory patch to enable unprivileged passthrough via SGL.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/nvme.h |  5 ++++
 drivers/nvme/host/pci.c  | 54 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 141e1b1a897a..b0e234509049 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1045,6 +1045,11 @@ static inline void nvme_start_request(struct request *rq)
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
index 60a08dfe8d75..5122af327952 100644
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
@@ -772,18 +775,20 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	blk_status_t ret = BLK_STS_RESOURCE;
 	int rc;
+	bool force_sgl = nvme_req(req)->flags & NVME_REQ_FORCE_SGL;
 
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
@@ -806,7 +811,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		goto out_free_sg;
 	}
 
-	if (nvme_pci_use_sgls(dev, req, iod->sgt.nents))
+	if (force_sgl || nvme_pci_use_sgls(dev, req, iod->sgt.nents))
 		ret = nvme_pci_setup_sgls(dev, req, &cmnd->rw);
 	else
 		ret = nvme_pci_setup_prps(dev, req, &cmnd->rw);
@@ -825,13 +830,38 @@ static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req,
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
@@ -967,6 +997,11 @@ static __always_inline void nvme_pci_unmap_rq(struct request *req)
 
 		dma_unmap_page(dev->dev, iod->meta_dma,
 			       rq_integrity_vec(req)->bv_len, rq_dma_dir(req));
+
+		if (nvme_req(req)->flags & NVME_REQ_FORCE_SGL)
+			dma_pool_free(dev->meta_sgl_pool,
+				      (void *)iod->meta_sgl,
+				      iod->meta_dma_sg);
 	}
 
 	if (blk_rq_nr_phys_segments(req))
@@ -2643,6 +2678,14 @@ static int nvme_setup_prp_pools(struct nvme_dev *dev)
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
 
@@ -2650,6 +2693,7 @@ static void nvme_release_prp_pools(struct nvme_dev *dev)
 {
 	dma_pool_destroy(dev->prp_page_pool);
 	dma_pool_destroy(dev->prp_small_pool);
+	dma_pool_destroy(dev->meta_sgl_pool);
 }
 
 static int nvme_pci_alloc_iod_mempool(struct nvme_dev *dev)
-- 
2.25.1


