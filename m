Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A28C00144
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jul 2022 16:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uhAc8GoN9mU4AP2PADNqztiznELYp2a2o7NOA9WyO4Q=; b=KpjpLTPEE+BjU6mOIolvrNBXOV
	9Q6RhBK8ONUv/YNUXV02HFoAmv1WMOxurAWj9hxC3J7+ccz3s/Q+Ztb5j5EBCQcKKPi0uwbsADNdU
	CqPRKcCV8T3LhCNxJrNjEhfNDpOd7wOXrzJi4utsuviyGNmHkJGzLM3sl8QGWct7Isk5197dZZeup
	LDJfQq5v3sSFpMfekVuaxkti3vwhnHYvdqNezskAm+FkWWKgUfW8V3o7yKtSaHYGwKMEK//QhGXZz
	z9OtlMZXtKRAPc9FU7qhBFNdQWLV1KC3xLRG5SK30+/+T3DnFTArJoL6HpD7KyDaXDsutRvwHnT9B
	VnsKZT6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHSrc-006Nmc-SQ; Fri, 29 Jul 2022 16:29:24 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHSrO-006NaM-N6
	for linux-nvme@lists.infradead.org; Fri, 29 Jul 2022 16:29:12 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 26T8XaPS008053
	for <linux-nvme@lists.infradead.org>; Fri, 29 Jul 2022 09:29:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=uhAc8GoN9mU4AP2PADNqztiznELYp2a2o7NOA9WyO4Q=;
 b=Ua6ctV0VrfCQm+MqTLQfYi+ApLUMscIJa0n01opdQroE5ilQmDR1r/gX89soB/EijcUo
 PKFReLET7nZjNFfHNbB6Y7iFgnT31QKc8nmGx0HqzOHp5eYb2b/pfyoVyft6DMbARrA4
 TgRobmpQyyUM/ORQ6AZdLRVdQAxqE/B0uH8= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0089730.ppops.net (PPS) with ESMTPS id 3hkjkn3s26-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 29 Jul 2022 09:29:07 -0700
Received: from twshared8442.02.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 29 Jul 2022 09:29:05 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 4984D6BA33E2; Fri, 29 Jul 2022 09:28:53 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCHv2 3/5] nvme-pci: iod npages fits in s8
Date: Fri, 29 Jul 2022 09:28:49 -0700
Message-ID: <20220729162851.1574210-4-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220729162851.1574210-1-kbusch@fb.com>
References: <20220729162851.1574210-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 9Ju1FhPh1owzPZRrzQKSXfEWOmT6mNAo
X-Proofpoint-ORIG-GUID: 9Ju1FhPh1owzPZRrzQKSXfEWOmT6mNAo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-29_17,2022-07-28_02,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220729_092910_898601_26AC397D 
X-CRM114-Status: GOOD (  22.06  )
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

The largest allowed transfer is 4MB, which can use at most 1025 PRPs.
Each PRP is 8 bytes, so the maximum number of 4k nvme pages needed for
the iod_list is 3, which fits in an 's8' type.

While modifying this field, change the name to "nr_allocations" to
better represent that this is referring to the number of units allocated
from a dma_pool.

Also introduce a BUILD_BUG_ON to ensure we never accidently increase the
largest transfer limit beyond 127 chained prp lists.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2:
  Renamed field from npages to nr_allocations (Christoph)

  Added BUILD_BUG_ON

 drivers/nvme/host/pci.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a8ae043e33de..e5b8e1c277b2 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -228,7 +228,7 @@ struct nvme_iod {
 	struct nvme_command cmd;
 	bool use_sgl;
 	bool aborted;
-	int npages;		/* In the PRP list. 0 means small pool in use */
+	s8 nr_allocations;	/* PRP list pool allocations. 0 means small pool in =
use */
 	int nents;		/* Used in scatterlist */
 	dma_addr_t first_dma;
 	unsigned int dma_len;	/* length of single DMA segment mapping */
@@ -545,7 +545,7 @@ static void nvme_free_prps(struct nvme_dev *dev, stru=
ct request *req)
 	dma_addr_t dma_addr =3D iod->first_dma;
 	int i;
=20
-	for (i =3D 0; i < iod->npages; i++) {
+	for (i =3D 0; i < iod->nr_allocations; i++) {
 		__le64 *prp_list =3D nvme_pci_iod_list(req)[i];
 		dma_addr_t next_dma_addr =3D le64_to_cpu(prp_list[last_prp]);
=20
@@ -561,7 +561,7 @@ static void nvme_free_sgls(struct nvme_dev *dev, stru=
ct request *req)
 	dma_addr_t dma_addr =3D iod->first_dma;
 	int i;
=20
-	for (i =3D 0; i < iod->npages; i++) {
+	for (i =3D 0; i < iod->nr_allocations; i++) {
 		struct nvme_sgl_desc *sg_list =3D nvme_pci_iod_list(req)[i];
 		dma_addr_t next_dma_addr =3D le64_to_cpu((sg_list[last_sg]).addr);
=20
@@ -594,7 +594,7 @@ static void nvme_unmap_data(struct nvme_dev *dev, str=
uct request *req)
 	WARN_ON_ONCE(!iod->nents);
=20
 	nvme_unmap_sg(dev, req);
-	if (iod->npages =3D=3D 0)
+	if (iod->nr_allocations =3D=3D 0)
 		dma_pool_free(dev->prp_small_pool, nvme_pci_iod_list(req)[0],
 			      iod->first_dma);
 	else if (iod->use_sgl)
@@ -656,15 +656,15 @@ static blk_status_t nvme_pci_setup_prps(struct nvme=
_dev *dev,
 	nprps =3D DIV_ROUND_UP(length, NVME_CTRL_PAGE_SIZE);
 	if (nprps <=3D (256 / 8)) {
 		pool =3D dev->prp_small_pool;
-		iod->npages =3D 0;
+		iod->nr_allocations =3D 0;
 	} else {
 		pool =3D dev->prp_page_pool;
-		iod->npages =3D 1;
+		iod->nr_allocations =3D 1;
 	}
=20
 	prp_list =3D dma_pool_alloc(pool, GFP_ATOMIC, &prp_dma);
 	if (!prp_list) {
-		iod->npages =3D -1;
+		iod->nr_allocations =3D -1;
 		return BLK_STS_RESOURCE;
 	}
 	list[0] =3D prp_list;
@@ -676,7 +676,7 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_d=
ev *dev,
 			prp_list =3D dma_pool_alloc(pool, GFP_ATOMIC, &prp_dma);
 			if (!prp_list)
 				goto free_prps;
-			list[iod->npages++] =3D prp_list;
+			list[iod->nr_allocations++] =3D prp_list;
 			prp_list[0] =3D old_prp_list[i - 1];
 			old_prp_list[i - 1] =3D cpu_to_le64(prp_dma);
 			i =3D 1;
@@ -750,15 +750,15 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme=
_dev *dev,
=20
 	if (entries <=3D (256 / sizeof(struct nvme_sgl_desc))) {
 		pool =3D dev->prp_small_pool;
-		iod->npages =3D 0;
+		iod->nr_allocations =3D 0;
 	} else {
 		pool =3D dev->prp_page_pool;
-		iod->npages =3D 1;
+		iod->nr_allocations =3D 1;
 	}
=20
 	sg_list =3D dma_pool_alloc(pool, GFP_ATOMIC, &sgl_dma);
 	if (!sg_list) {
-		iod->npages =3D -1;
+		iod->nr_allocations =3D -1;
 		return BLK_STS_RESOURCE;
 	}
=20
@@ -777,7 +777,7 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_d=
ev *dev,
 				goto free_sgls;
=20
 			i =3D 0;
-			nvme_pci_iod_list(req)[iod->npages++] =3D sg_list;
+			nvme_pci_iod_list(req)[iod->nr_allocations++] =3D sg_list;
 			sg_list[i++] =3D *link;
 			nvme_pci_sgl_set_seg(link, sgl_dma, entries);
 		}
@@ -905,7 +905,7 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev=
, struct request *req)
 	blk_status_t ret;
=20
 	iod->aborted =3D false;
-	iod->npages =3D -1;
+	iod->nr_allocations =3D -1;
 	iod->nents =3D 0;
=20
 	ret =3D nvme_setup_cmd(req->q->queuedata, req);
@@ -3562,6 +3562,8 @@ static int __init nvme_init(void)
 	BUILD_BUG_ON(sizeof(struct nvme_create_sq) !=3D 64);
 	BUILD_BUG_ON(sizeof(struct nvme_delete_queue) !=3D 64);
 	BUILD_BUG_ON(IRQ_AFFINITY_MAX_SETS < 2);
+	BUILD_BUG_ON(DIV_ROUND_UP(nvme_pci_npages_prp(), NVME_CTRL_PAGE_SIZE) >
+		     S8_MAX);
=20
 	return pci_register_driver(&nvme_driver);
 }
--=20
2.30.2


