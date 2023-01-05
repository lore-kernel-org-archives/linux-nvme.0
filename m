Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E18BC4708E
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Jan 2023 23:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EapPQiMsu/aZ5pCwkxOFWvWIDvZb+G3xZaUG5gGAu9c=; b=Mhkr9QItGzcOZZvyU2V6ryQWD5
	HyReD8lff0su4drDdALR6KAOrCTHHHjJqxZNClT/wiTTmfmLSUrRhHiQyTx+WIFgU1lucBR/N3gpk
	PkXMTDoawtsK6UrcrTbzyRYOof70h4EUpJaCPRBBMRV2WrvwOWgMKQL2fIXMZCNrJF0VerYlJUjzB
	aFFb69u1cIB/wAsXbsQFD72nS4iTvMs7EqK7uqP7LWNiu59kWgao6Do4IJo0xHjtVA5fACADOVWTf
	hJDF760VoCjVyqnQLtPGwUmlKhJnddlgOb6UscohMxjpcIQaB7D5dSZAbIa8lOttTcOEmfJA8NXaW
	9Pr6AlOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pDZZo-00G67D-ND; Thu, 05 Jan 2023 23:23:12 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pDWr5-00EYQ4-H3
	for linux-nvme@lists.infradead.org; Thu, 05 Jan 2023 20:28:53 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305KMBDQ010292
	for <linux-nvme@lists.infradead.org>; Thu, 5 Jan 2023 12:28:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=EapPQiMsu/aZ5pCwkxOFWvWIDvZb+G3xZaUG5gGAu9c=;
 b=iHEYkj/dGAMptBpo8ekSgjHavVp8DwTDnCGOOyrvw2YdGzH1anHDFYPbXtfk7/w/XkV2
 SNC2kDi+IBpBGNrgGQ8rZu1/EcGG3FBxR4WMzTEpXzAGw6rmvu0k0N0jndeQyoJbiVX7
 sXTSQ8p6nGkZZ2Gs3Mj9IiDsPPPpuMd2oMVLq0LKm4QUWy+ijMYFa89L6g76qIKmqVvX
 I7bXfyFa6VE32WAVUbYrnLe5j5ECYypHrAUoLEagZ+Q90ekAd0r8+zBOQDocoAlawjKr
 7Bm6OSCaXvkJLLDBBflfUrqoxSdavkz8y68VCRAofS0e6jQPNn3Yc8GH63hEcZgR7rvA sg== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mx5h2r122-19
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 05 Jan 2023 12:28:51 -0800
Received: from twshared41876.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 5 Jan 2023 12:28:49 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 3383FE457D7B; Thu,  5 Jan 2023 12:28:35 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH 1/4] nvme-pci: remove SGL segment descriptors
Date: Thu, 5 Jan 2023 12:28:30 -0800
Message-ID: <20230105202833.3225645-2-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230105202833.3225645-1-kbusch@meta.com>
References: <20230105202833.3225645-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: AVE71yczwERTlw_T5s72B_LKwCWDMwZc
X-Proofpoint-ORIG-GUID: AVE71yczwERTlw_T5s72B_LKwCWDMwZc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_11,2023-01-05_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230105_122851_636414_33940B22 
X-CRM114-Status: GOOD (  17.23  )
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

The max segments this driver can see is 127, well below the 256
threshold needed to add an nvme sgl segment descriptor. Remove all the
useless checks and dead code.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 47 +++++------------------------------------
 1 file changed, 5 insertions(+), 42 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b13baccedb4a9..693c6e5495846 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -548,22 +548,6 @@ static void nvme_free_prps(struct nvme_dev *dev, str=
uct request *req)
 	}
 }
=20
-static void nvme_free_sgls(struct nvme_dev *dev, struct request *req)
-{
-	const int last_sg =3D SGES_PER_PAGE - 1;
-	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
-	dma_addr_t dma_addr =3D iod->first_dma;
-	int i;
-
-	for (i =3D 0; i < iod->nr_allocations; i++) {
-		struct nvme_sgl_desc *sg_list =3D nvme_pci_iod_list(req)[i];
-		dma_addr_t next_dma_addr =3D le64_to_cpu((sg_list[last_sg]).addr);
-
-		dma_pool_free(dev->prp_page_pool, sg_list, dma_addr);
-		dma_addr =3D next_dma_addr;
-	}
-}
-
 static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
 {
 	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
@@ -582,7 +566,8 @@ static void nvme_unmap_data(struct nvme_dev *dev, str=
uct request *req)
 		dma_pool_free(dev->prp_small_pool, nvme_pci_iod_list(req)[0],
 			      iod->first_dma);
 	else if (iod->use_sgl)
-		nvme_free_sgls(dev, req);
+		dma_pool_free(dev->prp_page_pool, nvme_pci_iod_list(req)[0],
+			      iod->first_dma);
 	else
 		nvme_free_prps(dev, req);
 	mempool_free(iod->sgt.sgl, dev->iod_mempool);
@@ -705,13 +690,8 @@ static void nvme_pci_sgl_set_seg(struct nvme_sgl_des=
c *sge,
 		dma_addr_t dma_addr, int entries)
 {
 	sge->addr =3D cpu_to_le64(dma_addr);
-	if (entries < SGES_PER_PAGE) {
-		sge->length =3D cpu_to_le32(entries * sizeof(*sge));
-		sge->type =3D NVME_SGL_FMT_LAST_SEG_DESC << 4;
-	} else {
-		sge->length =3D cpu_to_le32(NVME_CTRL_PAGE_SIZE);
-		sge->type =3D NVME_SGL_FMT_SEG_DESC << 4;
-	}
+	sge->length =3D cpu_to_le32(entries * sizeof(*sge));
+	sge->type =3D NVME_SGL_FMT_LAST_SEG_DESC << 4;
 }
=20
 static blk_status_t nvme_pci_setup_sgls(struct nvme_dev *dev,
@@ -751,30 +731,12 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme=
_dev *dev,
 	iod->first_dma =3D sgl_dma;
=20
 	nvme_pci_sgl_set_seg(&cmd->dptr.sgl, sgl_dma, entries);
-
 	do {
-		if (i =3D=3D SGES_PER_PAGE) {
-			struct nvme_sgl_desc *old_sg_desc =3D sg_list;
-			struct nvme_sgl_desc *link =3D &old_sg_desc[i - 1];
-
-			sg_list =3D dma_pool_alloc(pool, GFP_ATOMIC, &sgl_dma);
-			if (!sg_list)
-				goto free_sgls;
-
-			i =3D 0;
-			nvme_pci_iod_list(req)[iod->nr_allocations++] =3D sg_list;
-			sg_list[i++] =3D *link;
-			nvme_pci_sgl_set_seg(link, sgl_dma, entries);
-		}
-
 		nvme_pci_sgl_set_data(&sg_list[i++], sg);
 		sg =3D sg_next(sg);
 	} while (--entries > 0);
=20
 	return BLK_STS_OK;
-free_sgls:
-	nvme_free_sgls(dev, req);
-	return BLK_STS_RESOURCE;
 }
=20
 static blk_status_t nvme_setup_prp_simple(struct nvme_dev *dev,
@@ -3525,6 +3487,7 @@ static int __init nvme_init(void)
 	BUILD_BUG_ON(IRQ_AFFINITY_MAX_SETS < 2);
 	BUILD_BUG_ON(DIV_ROUND_UP(nvme_pci_npages_prp(), NVME_CTRL_PAGE_SIZE) >
 		     S8_MAX);
+	BUILD_BUG_ON(NVME_MAX_SEGS > SGES_PER_PAGE);
=20
 	return pci_register_driver(&nvme_driver);
 }
--=20
2.30.2


