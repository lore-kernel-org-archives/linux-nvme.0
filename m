Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D695CD4F24
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2024 18:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lN//Cco4VgfrpN41P89jbstESARN82SPrfQJYnShlKE=; b=lEKWyDtndP9kPqwDCEbvVVtJkw
	lOGie85tRBOzqnE0iHFtWMdV07ipA2+S5rluT/PUDgEraOzZI/mhre2QuTWX20JeddAIL8kSMbgKh
	6jA9EQFiddTHf79xKIHrjEH+MBqp7qCWnYbcTEME1PCY5Khanc99nEKPWOYYmlaWBxCC3+6gDeWUI
	DcCUxe/6m7jRBsA8p1o1YDHSEwa0Wh/qDf/PkDVlrD6F+vx0khRsKahMcoxK4kWCVjhOk0oVlehad
	8KFwzDyQpBbmOvx14950AHoQfAVZDurydblcKKCzCPEXm3djDU+ChwRVY2/F5vkkR+j7KDD9qeWkV
	e2bEa0Fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sluto-00000005dT1-2xWf;
	Wed, 04 Sep 2024 18:38:36 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slutj-00000005dOj-22iX
	for linux-nvme@lists.infradead.org;
	Wed, 04 Sep 2024 18:38:33 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484GYPoT025595
	for <linux-nvme@lists.infradead.org>; Wed, 4 Sep 2024 11:38:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=lN//Cco4VgfrpN41P89jbstESARN82SPrfQJYnShlKE=; b=
	ayOMXTAa505Er0d3MMaq/HbGHnFc9XQh7vCGZKDV4iduVXX0y4lz/OUK6pqB9+RD
	9CeIOvIjbWfbeX4qQZZWu+OK83L7kpJVouwrf7FidJAu5GXkQRHduinlTBkTaWw2
	hodK8x8bJg66JX/woqHFpx6JZDLQkdb6H+v35zmScSwT0wbdJuaBMBM/BQrDcECv
	TE9fguTvVpef8BY7eYcUa0brLT9+sKf35Z5bF41xJmsjhjmtbJ69KqUmd3mHNDj8
	ZI8r/hVgp64ObLKOj3y06mWvy1O9q1DS4f2uGRgZX5JOu/oLbQoV9QA+461FbBQP
	Dg6Ou+NREp3nEyOnsoAwEw==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41eu6d0x8a-20
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 04 Sep 2024 11:38:30 -0700 (PDT)
Received: from twshared39016.07.ash9.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 4 Sep 2024 18:38:26 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id BF39712A1F09F; Wed,  4 Sep 2024 11:38:19 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <hch@lst.de>, <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH-part-2 6/9] nvme-pci: common dma pool alloc helper
Date: Wed, 4 Sep 2024 11:38:14 -0700
Message-ID: <20240904183818.713941-7-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240904183818.713941-1-kbusch@meta.com>
References: <20240904183818.713941-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: ILboUgi7YiL53DYEmE3vgHkCd9EBdMTj
X-Proofpoint-ORIG-GUID: ILboUgi7YiL53DYEmE3vgHkCd9EBdMTj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_16,2024-09-04_01,2024-09-02_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_113831_761798_DBF67956 
X-CRM114-Status: GOOD (  16.53  )
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

The more complicated sgl and prp setup does the same thing to select a
pool, allocate and initialize the iod dma fields. Provide a common
helper for this.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 69 ++++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 35 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index cdba1f8e0bba6..4980dde804a0e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -217,6 +217,7 @@ struct nvme_queue {
 };
=20
 union nvme_descriptor {
+	void			*list;
 	struct nvme_sgl_desc	*sg_list;
 	__le64			*prp_list;
 };
@@ -586,6 +587,29 @@ static void nvme_print_sgl(struct scatterlist *sgl, =
int nents)
 	}
 }
=20
+static struct dma_pool *nvme_pci_pool_alloc(struct nvme_dev *dev,
+					    unsigned nents, size_t desc_size,
+					    struct nvme_iod *iod)
+{
+	struct dma_pool *pool;
+
+	if (nents <=3D (256 / desc_size)) {
+		pool =3D dev->prp_small_pool;
+		iod->nr_allocations =3D 0;
+	} else {
+		pool =3D dev->prp_page_pool;
+		iod->nr_allocations =3D 1;
+	}
+
+	iod->list[0].list =3D dma_pool_alloc(pool, GFP_ATOMIC, &iod->first_dma)=
;
+	if (!iod->list[0].list) {
+		iod->nr_allocations =3D -1;
+		return NULL;
+	}
+
+	return pool;
+}
+
 static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
 		struct request *req)
 {
@@ -599,7 +623,7 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_d=
ev *dev,
 	int offset =3D dma_addr & (NVME_CTRL_PAGE_SIZE - 1);
 	__le64 *prp_list;
 	dma_addr_t prp_dma;
-	int nprps, i;
+	int nprps, i =3D 0;
=20
 	length -=3D (NVME_CTRL_PAGE_SIZE - offset);
 	if (length <=3D 0) {
@@ -622,22 +646,11 @@ static blk_status_t nvme_pci_setup_prps(struct nvme=
_dev *dev,
 	}
=20
 	nprps =3D DIV_ROUND_UP(length, NVME_CTRL_PAGE_SIZE);
-	if (nprps <=3D (256 / 8)) {
-		pool =3D dev->prp_small_pool;
-		iod->nr_allocations =3D 0;
-	} else {
-		pool =3D dev->prp_page_pool;
-		iod->nr_allocations =3D 1;
-	}
-
-	prp_list =3D dma_pool_alloc(pool, GFP_ATOMIC, &prp_dma);
-	if (!prp_list) {
-		iod->nr_allocations =3D -1;
+	pool =3D nvme_pci_pool_alloc(dev, nprps, 8, iod);
+	if (!pool)
 		return BLK_STS_RESOURCE;
-	}
-	iod->list[0].prp_list =3D prp_list;
-	iod->first_dma =3D prp_dma;
-	i =3D 0;
+
+	prp_list =3D iod->list[0].prp_list;
 	for (;;) {
 		if (i =3D=3D NVME_CTRL_PAGE_SIZE >> 3) {
 			__le64 *old_prp_list =3D prp_list;
@@ -697,12 +710,10 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme=
_dev *dev,
 		struct request *req)
 {
 	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
-	struct nvme_rw_command *cmd =3D &iod->cmd.rw;
-	struct dma_pool *pool;
 	struct nvme_sgl_desc *sg_list;
+	struct nvme_rw_command *cmd =3D &iod->cmd.rw;
 	struct scatterlist *sg =3D iod->sgt.sgl;
 	unsigned int entries =3D iod->sgt.nents;
-	dma_addr_t sgl_dma;
 	int i =3D 0;
=20
 	/* setting the transfer type as SGL */
@@ -713,24 +724,12 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme=
_dev *dev,
 		return BLK_STS_OK;
 	}
=20
-	if (entries <=3D (256 / sizeof(struct nvme_sgl_desc))) {
-		pool =3D dev->prp_small_pool;
-		iod->nr_allocations =3D 0;
-	} else {
-		pool =3D dev->prp_page_pool;
-		iod->nr_allocations =3D 1;
-	}
-
-	sg_list =3D dma_pool_alloc(pool, GFP_ATOMIC, &sgl_dma);
-	if (!sg_list) {
-		iod->nr_allocations =3D -1;
+	if (!nvme_pci_pool_alloc(dev, entries, sizeof(struct nvme_sgl_desc),
+				 iod))
 		return BLK_STS_RESOURCE;
-	}
-
-	iod->list[0].sg_list =3D sg_list;
-	iod->first_dma =3D sgl_dma;
=20
-	nvme_pci_sgl_set_seg(&cmd->dptr.sgl, sgl_dma, entries);
+	sg_list =3D iod->list[0].sg_list;
+	nvme_pci_sgl_set_seg(&cmd->dptr.sgl, iod->first_dma, entries);
 	do {
 		nvme_pci_sgl_set_data(&sg_list[i++], sg);
 		sg =3D sg_next(sg);
--=20
2.43.5


