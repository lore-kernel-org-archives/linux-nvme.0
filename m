Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D477C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Dec 2022 21:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rfrZGpRS92N9abFJwHv25JTiFYkIqmovRByMKUMlQ6E=; b=2F0d8uun0vYV83rlFF2G+35ruQ
	vXooDospTHPlYfumzmVRY0soA3sLezKOqwfjnH8Ah8BvbIunD82Pd8+ayWxN07lCY+A3DVCIBrXx1
	DVrArXJdlLpHAO3hRAOMgohYnJxGliMq5O/4HDTwbqMPWqCBwvJneUWF2fTDjTnPpvXVbOM9g3ySE
	uRM2OHqfVpyhfOcA9+SbDzo415WW4ePYIEyKegIyJL+r/Chy6491vlO/bWMG7aS2MhlKzQYw79T5y
	j4tL3NqXy+o8zGKIAIONR6xW7Q4JVLrZ24WSkfzfaSzUu9To6ZI9vh2IWW+yaYhCzXVy/PabpaSD0
	3RMH9TTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7O6Q-0049hP-RR; Mon, 19 Dec 2022 21:55:18 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7O6K-0049cs-Ct
	for linux-nvme@lists.infradead.org; Mon, 19 Dec 2022 21:55:14 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJK36sE029550
	for <linux-nvme@lists.infradead.org>; Mon, 19 Dec 2022 13:55:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=rfrZGpRS92N9abFJwHv25JTiFYkIqmovRByMKUMlQ6E=;
 b=gJw2zN8b00ahk+oLWgaGRA9LY+DanVvzDuEh6k5qeEfGPP5v73nC+XTEJyVSFhbHt/TK
 /Pk1JrlflIAQuOEVEDYU6V0LL4eWgcKjcuND8XUWA/dWt3hBxLiEdK88Tsyr82mTo1/w
 F23gRwSvQHIY1zITXxWdcOvchTei6RFQiudyOmCqWyyP0UTfP84P4+ijkQnzZ259NeO0
 uTsQ27Ef8YRJqH8USR1hIHJ1IL8+w3HatGalaYlKQwqV4bIq2iZbW63VddT9Gr2Sut28
 eCo56JzkOUkSFLfIQMRDh4wwZmSzFyDf6ho8xVQJkAfz7rVKl2jNw2iUdoDAZx67RbJ8 FA== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mhcd41w05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 19 Dec 2022 13:55:11 -0800
Received: from twshared0551.06.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 19 Dec 2022 13:55:10 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 50FF8D333B7F; Mon, 19 Dec 2022 13:54:58 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 2/3] nvme-pci: Remove SGL chaining
Date: Mon, 19 Dec 2022 13:54:56 -0800
Message-ID: <20221219215457.711617-2-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221219215457.711617-1-kbusch@meta.com>
References: <20221219215457.711617-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Ds22Bc5ystiB3tLN3JjzAU7B9D0bbTYT
X-Proofpoint-ORIG-GUID: Ds22Bc5ystiB3tLN3JjzAU7B9D0bbTYT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221219_135512_634368_908C995F 
X-CRM114-Status: GOOD (  16.75  )
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
threshold needed to chain an nvme sgl segment. Remove all the useless
checks and dead code.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 47 +++++------------------------------------
 1 file changed, 5 insertions(+), 42 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f5e01861c881e..07c967f563788 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -547,22 +547,6 @@ static void nvme_free_prps(struct nvme_dev *dev, str=
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
@@ -581,7 +565,8 @@ static void nvme_unmap_data(struct nvme_dev *dev, str=
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
@@ -704,13 +689,8 @@ static void nvme_pci_sgl_set_seg(struct nvme_sgl_des=
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
@@ -750,30 +730,12 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme=
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
@@ -3523,6 +3485,7 @@ static int __init nvme_init(void)
 	BUILD_BUG_ON(IRQ_AFFINITY_MAX_SETS < 2);
 	BUILD_BUG_ON(DIV_ROUND_UP(nvme_pci_npages_prp(), NVME_CTRL_PAGE_SIZE) >
 		     S8_MAX);
+	BUILD_BUG_ON(NVME_MAX_SEGS > SGES_PER_PAGE);
=20
 	return pci_register_driver(&nvme_driver);
 }
--=20
2.30.2


