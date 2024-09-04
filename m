Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3167CD4F21
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2024 18:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8ZGPUHbeeV7wyO4hJ3xI9Ig5uwe1gBU8R/ulPYiOazY=; b=M8ow4TLvr2+r0/pyp8Buk1zwDN
	m7XHXb7vvKSZmszJ45FY5OCbEjPDM62gJoGECoydPk59UlDSXxEzC7AqjKw6BWqohaxIf/SrxOuQz
	AUrFwydndc42FjrOvImdufYbnU8m1Xj1IEmt52uwoqt4Sh31fgpCv0u32OJ5IVzJCNBWfPEMWU+OP
	ATLuonF9yvxo6VOTQ33czQJNWX9keDhZvYlggVYl338iMRrW9qzzl6NJjcov90plwG4DAgs1baTKY
	uFrDga5QkYdbTybenb93u0D03Xoevm08ijt/hC5t/ebeqS/SS36MuGL/MVrI3pGJuQo4D5xT73CL4
	FW1nsQ9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slutg-00000005dMk-3sIY;
	Wed, 04 Sep 2024 18:38:28 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slutd-00000005dLN-0KOm
	for linux-nvme@lists.infradead.org;
	Wed, 04 Sep 2024 18:38:27 +0000
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484E1Zki010132
	for <linux-nvme@lists.infradead.org>; Wed, 4 Sep 2024 11:38:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=8ZGPUHbeeV7wyO4hJ3xI9Ig5uwe1gBU8R/ulPYiOazY=; b=
	knp3MQKyKXj9Yn2mkZHHcQyPdeuVJkJJKvViHH48yxNssdJBVbwuTzCw33ngmPNY
	5JbQah8P0SowRTliH+8UKzgGKC0cVs7dGb4Cer8F6su/Z1NU6Z6zLWzMcBsdsWin
	kIZcZWCpwpKbPPpWciiWgYkypCRAigw23C0P7XRfqllpQwXRISStanf9U4DR8H1s
	YhJmcN9dvMTK6FQI5VtimkWbFzcSRCudMlegdRKXLaMN5U+/mnq7Vlj4O2UUcIEW
	bGTIGFB3rG3LhC4EltRLvDslh4dlYBt6N5dXt2UMtR3I9rFo9q8rpfIHDnnbU75w
	Xblvjv20WFO3i7lF3lG0Zw==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41e8fvf122-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 04 Sep 2024 11:38:24 -0700 (PDT)
Received: from twshared34253.17.frc2.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 4 Sep 2024 18:38:21 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id B50B012A1F09D; Wed,  4 Sep 2024 11:38:19 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <hch@lst.de>, <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH-part-2 5/9] nvme-pci: simplify io setup function parameters
Date: Wed, 4 Sep 2024 11:38:13 -0700
Message-ID: <20240904183818.713941-6-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240904183818.713941-1-kbusch@meta.com>
References: <20240904183818.713941-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: _JkMhrV7bqZ5Vc2wuGOkiYNmDW7i1GUP
X-Proofpoint-GUID: _JkMhrV7bqZ5Vc2wuGOkiYNmDW7i1GUP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_16,2024-09-04_01,2024-09-02_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_113825_234486_ED909ED2 
X-CRM114-Status: GOOD (  14.99  )
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

We're threading a reference to the nvme_command through all functions
before it's needed. It's also redundant since it's a part of the request
that has to be provided anway. Remove the extra reference and only get
it in functions that actually need it.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3af4a226497c9..cdba1f8e0bba6 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -587,9 +587,10 @@ static void nvme_print_sgl(struct scatterlist *sgl, =
int nents)
 }
=20
 static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
-		struct request *req, struct nvme_rw_command *cmnd)
+		struct request *req)
 {
 	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
+	struct nvme_rw_command *cmnd =3D &iod->cmd.rw;
 	struct dma_pool *pool;
 	int length =3D blk_rq_payload_bytes(req);
 	struct scatterlist *sg =3D iod->sgt.sgl;
@@ -693,9 +694,10 @@ static void nvme_pci_sgl_set_seg(struct nvme_sgl_des=
c *sge,
 }
=20
 static blk_status_t nvme_pci_setup_sgls(struct nvme_dev *dev,
-		struct request *req, struct nvme_rw_command *cmd)
+		struct request *req)
 {
 	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
+	struct nvme_rw_command *cmd =3D &iod->cmd.rw;
 	struct dma_pool *pool;
 	struct nvme_sgl_desc *sg_list;
 	struct scatterlist *sg =3D iod->sgt.sgl;
@@ -738,12 +740,12 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme=
_dev *dev,
 }
=20
 static blk_status_t nvme_setup_prp_simple(struct nvme_dev *dev,
-		struct request *req, struct nvme_rw_command *cmnd,
-		struct bio_vec *bv)
+		struct request *req, struct bio_vec *bv)
 {
-	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
 	unsigned int offset =3D bv->bv_offset & (NVME_CTRL_PAGE_SIZE - 1);
 	unsigned int first_prp_len =3D NVME_CTRL_PAGE_SIZE - offset;
+	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
+	struct nvme_rw_command *cmnd =3D &iod->cmd.rw;
=20
 	iod->first_dma =3D dma_map_bvec(dev->dev, bv, rq_dma_dir(req), 0);
 	if (dma_mapping_error(dev->dev, iod->first_dma))
@@ -758,10 +760,10 @@ static blk_status_t nvme_setup_prp_simple(struct nv=
me_dev *dev,
 }
=20
 static blk_status_t nvme_setup_sgl_simple(struct nvme_dev *dev,
-		struct request *req, struct nvme_rw_command *cmnd,
-		struct bio_vec *bv)
+		struct request *req, struct bio_vec *bv)
 {
 	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
+	struct nvme_rw_command *cmnd =3D &iod->cmd.rw;
=20
 	iod->first_dma =3D dma_map_bvec(dev->dev, bv, rq_dma_dir(req), 0);
 	if (dma_mapping_error(dev->dev, iod->first_dma))
@@ -774,8 +776,7 @@ static blk_status_t nvme_setup_sgl_simple(struct nvme=
_dev *dev,
 	return BLK_STS_OK;
 }
=20
-static blk_status_t __nvme_map_data(struct nvme_dev *dev, struct request=
 *req,
-		struct nvme_command *cmnd)
+static blk_status_t __nvme_map_data(struct nvme_dev *dev, struct request=
 *req)
 {
 	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
 	blk_status_t ret =3D BLK_STS_RESOURCE;
@@ -798,9 +799,9 @@ static blk_status_t __nvme_map_data(struct nvme_dev *=
dev, struct request *req,
 	}
=20
 	if (nvme_pci_use_sgls(dev, req, iod->sgt.nents))
-		ret =3D nvme_pci_setup_sgls(dev, req, &cmnd->rw);
+		ret =3D nvme_pci_setup_sgls(dev, req);
 	else
-		ret =3D nvme_pci_setup_prps(dev, req, &cmnd->rw);
+		ret =3D nvme_pci_setup_prps(dev, req);
 	if (ret !=3D BLK_STS_OK)
 		goto out_unmap_sg;
 	return BLK_STS_OK;
@@ -812,23 +813,20 @@ static blk_status_t __nvme_map_data(struct nvme_dev=
 *dev, struct request *req,
 	return ret;
 }
=20
-static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *=
req,
-		struct nvme_command *cmnd)
+static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *=
req)
 {
 	if (blk_rq_nr_phys_segments(req) =3D=3D 1) {
 		struct bio_vec bv =3D req_bvec(req);
=20
 		if (!is_pci_p2pdma_page(bv.bv_page)) {
 			if (nvme_pci_use_prps(&bv))
-				return nvme_setup_prp_simple(dev, req,
-							     &cmnd->rw, &bv);
+				return nvme_setup_prp_simple(dev, req, &bv);
 			if (nvme_pci_sgl_capable(dev, req))
-				return nvme_setup_sgl_simple(dev, req,
-							     &cmnd->rw, &bv);
+				return nvme_setup_sgl_simple(dev, req, &bv);
 		}
 	}
=20
-	return __nvme_map_data(dev, req, cmnd);
+	return __nvme_map_data(dev, req);
 }
=20
 static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct reque=
st *req,
@@ -858,7 +856,7 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev=
, struct request *req)
 		return ret;
=20
 	if (blk_rq_nr_phys_segments(req)) {
-		ret =3D nvme_map_data(dev, req, &iod->cmd);
+		ret =3D nvme_map_data(dev, req);
 		if (ret)
 			goto out_free_cmd;
 	}
--=20
2.43.5


