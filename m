Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 902D5CCD199
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Oct 2025 18:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=KQHW89gCVYrfAVmbQKx6LGYOFKWyxsUSMVjmSon0310=; b=TEdHpheGInLPDtcTi9HVwhvEMF
	7xptEQK+4mBIUVnZ59bKdkMWjs94WP+bFAxyBBM30YVLH7eWGBgzepqnEMEM92YsQh5JykLDVshVx
	YouxfltycjR2udIRt3F/264zfaIRB344u4gSwgxiQ70B3pqqfOnHQCd/IvWC1vM3HaXU71kTrX5NB
	9H9uzHELbiij7tEx0WCJwdgHcOnEx2YxOkcKB/W4VNUhHh+iYaIdvjKDUTOqI0ZYKBJ/WjpAH1wrr
	9q7/WoTh9WXL/1ubghX1lNT+z3PFrIHsGecM16PKIYLHVqJMI8/SyD7T5iFqMdQqLQObtxEans3Q7
	AGWA/iaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAuZ3-0000000EcLm-2cZU;
	Mon, 20 Oct 2025 18:25:01 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAuZ0-0000000EcKE-32HO
	for linux-nvme@lists.infradead.org;
	Mon, 20 Oct 2025 18:25:00 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59KH5LhN1740293
	for <linux-nvme@lists.infradead.org>; Mon, 20 Oct 2025 11:24:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=KQHW89gCVYrfAVmbQK
	x6LGYOFKWyxsUSMVjmSon0310=; b=fq3KidjbG3iVYrgbOCF8TtXDD/lLi0vU6J
	r5vATnSBiG3N3yB+lVXkOSy+k60U5Wzrcqd8/BFWFp4Th/TpnUCw3A6N77Hw2Ntx
	m9FaXUeOrSbaqdP6AMNdfRUTLePIr877RNsmRfgHgmd5IN1i5MQj01pOrynqASaj
	V7sPKkz1swLfgRRYOAowJvEU9UOTNyjY8tBqv2oq1tnaz1iOVqxcZ9IzVoSpt1y/
	0r5tk5oi+eGR/+9Jki81Ptt/QqomWBpZgM/zefrBHViJ4m65mf6/rpQ9PlD3/NGI
	D4pm0y5Pm3Rj1+WDbZwzHYr80qfCD70tEJWgyUsWFRpkj4diKYQA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 49ws63gtmb-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 20 Oct 2025 11:24:55 -0700 (PDT)
Received: from twshared51336.15.frc2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Mon, 20 Oct 2025 18:24:54 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id BB4BF2E7E8D2; Mon, 20 Oct 2025 11:24:44 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, Leon Romanovsky <leon@kernel.org>
Subject: [PATCH] nvme-pci: always use blk_map_iter for metadata
Date: Mon, 20 Oct 2025 11:24:44 -0700
Message-ID: <20251020182444.2587155-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIwMDE1MiBTYWx0ZWRfX/ZgxqrMdq5P2
 nqyl7kwJKaBoacvgwON4HN6cC11QEp6s7OJs9qtfhPS988n3BFNB8dvTsTs5hnQzrMtX5W7odig
 T+sz1BIk4JuXW26UdINdJ8RyAnawJGCqUvDXM8xTTIZHd8gAtnVNOCrnJ1OQ8v3a16Ep2HkQthK
 FX8ozuCPQWEDvL4Kv2nld8znaPBubZupMt+iUT4I2T0i/pgavlFsb20O+CJfLqPDYLbS3eER94A
 pfSSSjdHRn2dPsuTkEe7UWy+RJShL3BuniZJQcbIoyCZlgAVCUPev2yh3y8lVjTaxa7WHyPPhmY
 qNiA85weqdh3Z9zv5YAL3MbNb9bVqGi+jxHYqGz0jCFx+EOZjw0fX5QjvM3WGjiCvvDLYorh5My
 GmuiA07Ad+g1ocFynR/7fjueJjcd5Q==
X-Authority-Analysis: v=2.4 cv=S8LUAYsP c=1 sm=1 tr=0 ts=68f67e77 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=y-eM56mxYRIo3OaEqAcA:9
X-Proofpoint-GUID: mtMa4zzkCwg33E4MFwffNvzAu3of-Go3
X-Proofpoint-ORIG-GUID: mtMa4zzkCwg33E4MFwffNvzAu3of-Go3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_05,2025-10-13_01,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251020_112458_800644_0FFFC80D 
X-CRM114-Status: GOOD (  14.92  )
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

From: Keith Busch <kbusch@kernel.org>

The dma_map_bvec helper doesn't work for p2p data. Rather than special
case it, just use the same mapping logic so that the driver doesn't need
to consider memory types.

Reported-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 89 ++++++++++++++---------------------------
 1 file changed, 31 insertions(+), 58 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c916176bd9f05..3acb5843de450 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -259,9 +259,6 @@ enum nvme_iod_flags {
=20
 	/* single segment dma mapping */
 	IOD_SINGLE_SEGMENT	=3D 1U << 2,
-
-	/* Metadata using non-coalesced MPTR */
-	IOD_SINGLE_META_SEGMENT	=3D 1U << 5,
 };
=20
 struct nvme_dma_vec {
@@ -596,17 +593,6 @@ enum nvme_use_sgl {
 	SGL_FORCED,
 };
=20
-static inline bool nvme_pci_metadata_use_sgls(struct request *req)
-{
-	struct nvme_queue *nvmeq =3D req->mq_hctx->driver_data;
-	struct nvme_dev *dev =3D nvmeq->dev;
-
-	if (!nvme_ctrl_meta_sgl_supported(&dev->ctrl))
-		return false;
-	return req->nr_integrity_segments > 1 ||
-		nvme_req(req)->flags & NVME_REQ_USERCMD;
-}
-
 static inline enum nvme_use_sgl nvme_pci_use_sgls(struct nvme_dev *dev,
 		struct request *req)
 {
@@ -724,13 +710,6 @@ static void nvme_unmap_metadata(struct request *req)
 	struct device *dma_dev =3D nvmeq->dev->dev;
 	struct nvme_sgl_desc *sge =3D iod->meta_descriptor;
=20
-	if (iod->flags & IOD_SINGLE_META_SEGMENT) {
-		dma_unmap_page(dma_dev, iod->meta_dma,
-			       rq_integrity_vec(req).bv_len,
-			       rq_dma_dir(req));
-		return;
-	}
-
 	if (!blk_rq_integrity_dma_unmap(req, dma_dev, &iod->meta_dma_state,
 					iod->meta_total_len)) {
 		if (nvme_pci_cmd_use_meta_sgl(&iod->cmd))
@@ -1042,21 +1021,27 @@ static blk_status_t nvme_map_data(struct request =
*req)
 	return nvme_pci_setup_data_prp(req, &iter);
 }
=20
-static blk_status_t nvme_pci_setup_meta_sgls(struct request *req)
+static blk_status_t nvme_pci_setup_meta_mptr(struct nvme_iod *iod,
+					     struct blk_dma_iter *iter)
+{
+	iod->cmd.common.metadata =3D cpu_to_le64(iter->addr);
+	iod->meta_total_len =3D iter->len;
+	iod->meta_dma =3D iter->addr;
+	iod->meta_descriptor =3D NULL;
+	return BLK_STS_OK;
+}
+
+static blk_status_t nvme_pci_setup_meta_sgls(struct request *req,
+					     struct blk_dma_iter *iter)
 {
 	struct nvme_queue *nvmeq =3D req->mq_hctx->driver_data;
 	unsigned int entries =3D req->nr_integrity_segments;
 	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
 	struct nvme_dev *dev =3D nvmeq->dev;
 	struct nvme_sgl_desc *sg_list;
-	struct blk_dma_iter iter;
 	dma_addr_t sgl_dma;
 	int i =3D 0;
=20
-	if (!blk_rq_integrity_dma_map_iter_start(req, dev->dev,
-						&iod->meta_dma_state, &iter))
-		return iter.status;
-
 	if (blk_rq_dma_map_coalesce(&iod->meta_dma_state))
 		entries =3D 1;
=20
@@ -1073,13 +1058,8 @@ static blk_status_t nvme_pci_setup_meta_sgls(struc=
t request *req)
 	 * mechanism to catch any misunderstandings between the application and
 	 * device.
 	 */
-	if (entries =3D=3D 1 && !(nvme_req(req)->flags & NVME_REQ_USERCMD)) {
-		iod->cmd.common.metadata =3D cpu_to_le64(iter.addr);
-		iod->meta_total_len =3D iter.len;
-		iod->meta_dma =3D iter.addr;
-		iod->meta_descriptor =3D NULL;
-		return BLK_STS_OK;
-	}
+	if (entries =3D=3D 1 && !(nvme_req(req)->flags & NVME_REQ_USERCMD))
+		return nvme_pci_setup_meta_mptr(iod, iter);
=20
 	sg_list =3D dma_pool_alloc(nvmeq->descriptor_pools.small, GFP_ATOMIC,
 			&sgl_dma);
@@ -1091,45 +1071,38 @@ static blk_status_t nvme_pci_setup_meta_sgls(stru=
ct request *req)
 	iod->cmd.common.flags =3D NVME_CMD_SGL_METASEG;
 	iod->cmd.common.metadata =3D cpu_to_le64(sgl_dma);
 	if (entries =3D=3D 1) {
-		iod->meta_total_len =3D iter.len;
-		nvme_pci_sgl_set_data(sg_list, &iter);
+		iod->meta_total_len =3D iter->len;
+		nvme_pci_sgl_set_data(sg_list, iter);
 		return BLK_STS_OK;
 	}
=20
 	sgl_dma +=3D sizeof(*sg_list);
 	do {
-		nvme_pci_sgl_set_data(&sg_list[++i], &iter);
-		iod->meta_total_len +=3D iter.len;
-	} while (blk_rq_integrity_dma_map_iter_next(req, dev->dev, &iter));
+		nvme_pci_sgl_set_data(&sg_list[++i], iter);
+		iod->meta_total_len +=3D iter->len;
+	} while (blk_rq_integrity_dma_map_iter_next(req, dev->dev, iter));
=20
 	nvme_pci_sgl_set_seg(sg_list, sgl_dma, i);
-	if (unlikely(iter.status))
+	if (unlikely(iter->status))
 		nvme_unmap_metadata(req);
-	return iter.status;
+	return iter->status;
 }
=20
-static blk_status_t nvme_pci_setup_meta_mptr(struct request *req)
+static blk_status_t nvme_map_metadata(struct request *req)
 {
-	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
 	struct nvme_queue *nvmeq =3D req->mq_hctx->driver_data;
-	struct bio_vec bv =3D rq_integrity_vec(req);
+	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
+	struct nvme_dev *dev =3D nvmeq->dev;
+	struct blk_dma_iter iter;
=20
-	iod->meta_dma =3D dma_map_bvec(nvmeq->dev->dev, &bv, rq_dma_dir(req), 0=
);
-	if (dma_mapping_error(nvmeq->dev->dev, iod->meta_dma))
-		return BLK_STS_IOERR;
-	iod->cmd.common.metadata =3D cpu_to_le64(iod->meta_dma);
-	iod->flags |=3D IOD_SINGLE_META_SEGMENT;
-	return BLK_STS_OK;
-}
+	if (blk_rq_integrity_dma_map_iter_start(req, dev->dev,
+						&iod->meta_dma_state, &iter))
+		return iter.status;
=20
-static blk_status_t nvme_map_metadata(struct request *req)
-{
-	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
+	if (!nvme_ctrl_meta_sgl_supported(&dev->ctrl))
+		return nvme_pci_setup_meta_mptr(iod, &iter);
=20
-	if ((iod->cmd.common.flags & NVME_CMD_SGL_METABUF) &&
-	    nvme_pci_metadata_use_sgls(req))
-		return nvme_pci_setup_meta_sgls(req);
-	return nvme_pci_setup_meta_mptr(req);
+	return nvme_pci_setup_meta_sgls(req, &iter);
 }
=20
 static blk_status_t nvme_prep_rq(struct request *req)
--=20
2.47.3


