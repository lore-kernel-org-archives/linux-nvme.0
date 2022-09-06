Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F68C6FA86
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Sep 2022 16:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kaqOMRNwA1b3UDcIu6FDRlTBXiD1K1fYfHfPWb/uUs0=; b=VCthpELcptJvfNvl+NmEStSIvh
	bs9QvzRY5zDRRFR1HWUOgKYdbU0eVXppWaRG6BOEcQ6Slplb5IGr4Ct31Y27xIohZrC9Cgs/gWbqE
	ajZiI4eaeAz5Nry1pd9XHyYP4xZcyV0Jw1s4+FexqhjMRoH/B4MOLRThKIhrzw9C4R68jZa7NcLbd
	V+wt+0Gquia1rY2kV9G1V3+D8pvlXjy7lHnnjsMiMFvNJMPUSx/I/0SX83HWzB/b9QWhPmp/WT03s
	13Nc6CTlHrCQa4tpYIL+DS8Pc8jkE64e/Yp/nHI1j76lH6gend5Lp13piOFBvaVgqtxEFi6Cxvj/S
	NihV/GJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVbO7-00FO5t-EE; Tue, 06 Sep 2022 16:25:23 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVb7C-00FCim-1V
	for linux-nvme@lists.infradead.org; Tue, 06 Sep 2022 16:07:59 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286F3QZL008649
	for <linux-nvme@lists.infradead.org>; Tue, 6 Sep 2022 09:07:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=kaqOMRNwA1b3UDcIu6FDRlTBXiD1K1fYfHfPWb/uUs0=;
 b=hVUj75DCD5p+1+CZwZpc4pEy+iAOdidwWBphj/20jHGRzoojTFNLhTE09FbGzOyMAho4
 cUQwe4DAvFTpWGfqN36VKcbzZnsgNLTAr7WE7s09caOaxwC7GOVepZ7qSpWaCOew1JSo
 Wues0RNLwQFjScmvvwPQ95mA2Hsszh2MJdw= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jc4ruybev-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 06 Sep 2022 09:07:49 -0700
Received: from twshared14074.07.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 09:07:46 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 75851847D5BD; Tue,  6 Sep 2022 09:07:43 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni
	<kch@nvidia.com>
Subject: [PATCHv3 3/4] nvme-pci: iod npages fits in s8
Date: Tue, 6 Sep 2022 09:07:37 -0700
Message-ID: <20220906160738.2289621-4-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220906160738.2289621-1-kbusch@fb.com>
References: <20220906160738.2289621-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: JMv68UOmSSgz18iwFt_VHtg-KENP9N-k
X-Proofpoint-ORIG-GUID: JMv68UOmSSgz18iwFt_VHtg-KENP9N-k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220906_090755_442702_ACEA6DD3 
X-CRM114-Status: GOOD (  22.66  )
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
 drivers/nvme/host/pci.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 045ebdd8e8f3..7339efc4cb86 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -228,7 +228,7 @@ struct nvme_iod {
 	struct nvme_command cmd;
 	bool use_sgl;
 	bool aborted;
-	int npages;		/* In the PRP list. 0 means small pool in use */
+	s8 nr_allocations;	/* PRP list pool allocations. 0 means small pool in =
use */
 	dma_addr_t first_dma;
 	unsigned int dma_len;	/* length of single DMA segment mapping */
 	dma_addr_t meta_dma;
@@ -542,7 +542,7 @@ static void nvme_free_prps(struct nvme_dev *dev, stru=
ct request *req)
 	dma_addr_t dma_addr =3D iod->first_dma;
 	int i;
=20
-	for (i =3D 0; i < iod->npages; i++) {
+	for (i =3D 0; i < iod->nr_allocations; i++) {
 		__le64 *prp_list =3D nvme_pci_iod_list(req)[i];
 		dma_addr_t next_dma_addr =3D le64_to_cpu(prp_list[last_prp]);
=20
@@ -558,7 +558,7 @@ static void nvme_free_sgls(struct nvme_dev *dev, stru=
ct request *req)
 	dma_addr_t dma_addr =3D iod->first_dma;
 	int i;
=20
-	for (i =3D 0; i < iod->npages; i++) {
+	for (i =3D 0; i < iod->nr_allocations; i++) {
 		struct nvme_sgl_desc *sg_list =3D nvme_pci_iod_list(req)[i];
 		dma_addr_t next_dma_addr =3D le64_to_cpu((sg_list[last_sg]).addr);
=20
@@ -581,7 +581,7 @@ static void nvme_unmap_data(struct nvme_dev *dev, str=
uct request *req)
=20
 	dma_unmap_sgtable(dev->dev, &iod->sgt, rq_dma_dir(req), 0);
=20
-	if (iod->npages =3D=3D 0)
+	if (iod->nr_allocations =3D=3D 0)
 		dma_pool_free(dev->prp_small_pool, nvme_pci_iod_list(req)[0],
 			      iod->first_dma);
 	else if (iod->use_sgl)
@@ -643,15 +643,15 @@ static blk_status_t nvme_pci_setup_prps(struct nvme=
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
@@ -663,7 +663,7 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_d=
ev *dev,
 			prp_list =3D dma_pool_alloc(pool, GFP_ATOMIC, &prp_dma);
 			if (!prp_list)
 				goto free_prps;
-			list[iod->npages++] =3D prp_list;
+			list[iod->nr_allocations++] =3D prp_list;
 			prp_list[0] =3D old_prp_list[i - 1];
 			old_prp_list[i - 1] =3D cpu_to_le64(prp_dma);
 			i =3D 1;
@@ -738,15 +738,15 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme=
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
@@ -765,7 +765,7 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_d=
ev *dev,
 				goto free_sgls;
=20
 			i =3D 0;
-			nvme_pci_iod_list(req)[iod->npages++] =3D sg_list;
+			nvme_pci_iod_list(req)[iod->nr_allocations++] =3D sg_list;
 			sg_list[i++] =3D *link;
 			nvme_pci_sgl_set_seg(link, sgl_dma, entries);
 		}
@@ -892,7 +892,7 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev=
, struct request *req)
 	blk_status_t ret;
=20
 	iod->aborted =3D false;
-	iod->npages =3D -1;
+	iod->nr_allocations =3D -1;
 	iod->sgt.nents =3D 0;
=20
 	ret =3D nvme_setup_cmd(req->q->queuedata, req);
@@ -3559,6 +3559,8 @@ static int __init nvme_init(void)
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


