Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9208CD4847
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2024 18:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z29YRSxGdvS834cD0YmJk6S0KyyvkGP66DxNP83z26Y=; b=xmmwIgpk1XM4XqyHJPGnkg1qji
	juK02pgOZvgJb+Kt2behmAk6RM5rdFBcFqjTGLULayUSjDXG/I2hAnuw06EvgzelaC99LQ7vFBdb0
	BjabcMNgf4JOVAiIR8zOH4ezhbJM3udUEVeyd2SbrAq/Gby/g7lUEzLTueqwiUFFaiKw364RCBXLJ
	wbaDBOw05VwP8txmd4iNdqZ0VEgm9Y2/0fYVkz6Cff5LNcBM+J6ZrDd0QBeXB0Es8C0f00v4nwAtL
	1ENfqATwDbTDxlblz5yupkAofw+1/5unQG/xmz/11El3NPUIQ6mAVwLzBSxWN5Wn7/ovXk+tf7aDF
	A2k3O3tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slutk-00000005dPo-3CcY;
	Wed, 04 Sep 2024 18:38:32 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sluth-00000005dNU-41V0
	for linux-nvme@lists.infradead.org;
	Wed, 04 Sep 2024 18:38:31 +0000
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484E1Zkn010132
	for <linux-nvme@lists.infradead.org>; Wed, 4 Sep 2024 11:38:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=Z29YRSxGdvS834cD0YmJk6S0KyyvkGP66DxNP83z26Y=; b=
	TR1hiAbfajNOzZPPls1E4To+PXaUIGEC4jT1vcsRAquTdY6kWpwBS9S5eGgy4qXF
	t0i0tXB57xX6zCCPAlDwCJEAsiwIJ47e8z1ZJaYkgpPkdOQQajw7STSr/BN5IhqA
	wBCgJO6edgtaSp7TAfoOeBOHEX7L27Fwqhry6Cg5EG4Ggu8OZrbHqC1MAVFy+wGC
	z8kH/B/Xw+I4smVbkDNLynPQhpT/jymHE4Gl5XK7NvfhVOP19+VmQTjN5Y4qUfui
	ibOb1nWMFMmQE4rpQMSjO2w0peCfjpkl0przN0EvI7TZhmf46j2JYJuxlpVXqCsm
	5j+PVHkiwKBKfkic/HOYiA==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41e8fvf122-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 04 Sep 2024 11:38:29 -0700 (PDT)
Received: from twshared59809.03.ash8.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 4 Sep 2024 18:38:26 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id A8D0412A1F09B; Wed,  4 Sep 2024 11:38:19 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <hch@lst.de>, <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH-part-2 4/9] nvme-pci: remove "dma_len" from nvme_iod
Date: Wed, 4 Sep 2024 11:38:12 -0700
Message-ID: <20240904183818.713941-5-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240904183818.713941-1-kbusch@meta.com>
References: <20240904183818.713941-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: dYBVXhooi_WXKeRPhfE-9srWm3AyBdkC
X-Proofpoint-GUID: dYBVXhooi_WXKeRPhfE-9srWm3AyBdkC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_16,2024-09-04_01,2024-09-02_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_113830_071917_E18007F2 
X-CRM114-Status: GOOD (  14.94  )
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

This is redundant data that we can get from sgl nents and request data
length. Remove it to make the struct smaller.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 77d42eaada742..3af4a226497c9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -233,7 +233,6 @@ struct nvme_iod {
 	bool aborted;
 	s8 nr_allocations;	/* PRP list pool allocations. 0 means small
 				   pool in use */
-	unsigned int dma_len;	/* length of single DMA segment mapping */
 	dma_addr_t first_dma;
 	dma_addr_t meta_dma;
 	struct sg_table sgt;
@@ -554,14 +553,12 @@ static void nvme_unmap_data(struct nvme_dev *dev, s=
truct request *req)
 {
 	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
=20
-	if (iod->dma_len) {
-		dma_unmap_page(dev->dev, iod->first_dma, iod->dma_len,
+	if (!iod->sgt.nents) {
+		dma_unmap_page(dev->dev, iod->first_dma, blk_rq_bytes(req),
 			       rq_dma_dir(req));
 		return;
 	}
=20
-	WARN_ON_ONCE(!iod->sgt.nents);
-
 	dma_unmap_sgtable(dev->dev, &iod->sgt, rq_dma_dir(req), 0);
=20
 	if (iod->nr_allocations =3D=3D 0)
@@ -751,7 +748,6 @@ static blk_status_t nvme_setup_prp_simple(struct nvme=
_dev *dev,
 	iod->first_dma =3D dma_map_bvec(dev->dev, bv, rq_dma_dir(req), 0);
 	if (dma_mapping_error(dev->dev, iod->first_dma))
 		return BLK_STS_RESOURCE;
-	iod->dma_len =3D bv->bv_len;
=20
 	cmnd->dptr.prp1 =3D cpu_to_le64(iod->first_dma);
 	if (bv->bv_len > first_prp_len)
@@ -770,11 +766,10 @@ static blk_status_t nvme_setup_sgl_simple(struct nv=
me_dev *dev,
 	iod->first_dma =3D dma_map_bvec(dev->dev, bv, rq_dma_dir(req), 0);
 	if (dma_mapping_error(dev->dev, iod->first_dma))
 		return BLK_STS_RESOURCE;
-	iod->dma_len =3D bv->bv_len;
=20
 	cmnd->flags =3D NVME_CMD_SGL_METABUF;
 	cmnd->dptr.sgl.addr =3D cpu_to_le64(iod->first_dma);
-	cmnd->dptr.sgl.length =3D cpu_to_le32(iod->dma_len);
+	cmnd->dptr.sgl.length =3D cpu_to_le32(bv->bv_len);
 	cmnd->dptr.sgl.type =3D NVME_SGL_FMT_DATA_DESC << 4;
 	return BLK_STS_OK;
 }
@@ -786,7 +781,6 @@ static blk_status_t __nvme_map_data(struct nvme_dev *=
dev, struct request *req,
 	blk_status_t ret =3D BLK_STS_RESOURCE;
 	int rc;
=20
-	iod->dma_len =3D 0;
 	iod->sgt.sgl =3D mempool_alloc(dev->iod_mempool, GFP_ATOMIC);
 	if (!iod->sgt.sgl)
 		return BLK_STS_RESOURCE;
--=20
2.43.5


