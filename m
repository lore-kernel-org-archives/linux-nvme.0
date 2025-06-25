Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5EEC7EE31
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Jun 2025 21:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Nrl/mM1f4nUDM+SPsl9lsAxt3jHm+mBbaf0FUbbncJ8=; b=efubjuYAWY2frK5WU63il/dBfQ
	iFposNCCWSdK9N2/l1cO0VCRCTd92UXf9htgJYtDJ3MVUwcgiE36oB4FyxicZAIAI62sSVjUT9y7k
	yt25yLxtnQjW3OsDycg28hcuIgrOTNEdqcZLWNJpnNzTVqD9tVuD7nQbl7tXAIwRJg+84vb6FuEEf
	VL4N/Cs4+y2n84Hf5qzidHBGX+4giZhOg4oNE+2O1R+//YnIIauFYpK7uWqMiX5LPKdFmCcnbQzs6
	V24+g20xg3XUCDMukpI6LGEbfLZwzXl5qOFwWua69a4p9zlVnJjfz9uujI36EZbfiYGiYMg0v/G2f
	8hVLEJrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUY4c-0000000A0qV-1OEb;
	Wed, 25 Jun 2025 21:54:30 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUWzY-00000009uPJ-0gTb
	for linux-nvme@bombadil.infradead.org;
	Wed, 25 Jun 2025 20:45:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Content-Transfer-Encoding
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Nrl/mM1f4nUDM+SPsl9lsAxt3jHm+mBbaf0FUbbncJ8=; b=Ea4PHSqOm9rV/R4F2Xf2cjt0c7
	HxPaZIb6XZJKlPMmJR1xmZq03JxY7N4dGbyKhS697i77g9k+DSOYfm0JuRhoSIm+ql9attuT2KHog
	rf7pcYGxEPKomnlF/P9pOBo2JfAm7GjeZBSt4d4Iv9v09mSS/gDPbdzo6Zw96sVxyep6iYUJ02WFI
	wXAhoTWcS2z07wAEvTVLUEPchSAOGIkSQcodhNpIQks7HLprPC+jeZWAws7SrSmrpwGRK0LWwN0WY
	Z6+liruRVw3Xbr1Jh53T9LtR+L9rfuB1QuB0DuYenx9cZy9hQnIBj0+CvgNoBh3kicZ3+T0AfS2de
	KlLaGHsA==;
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUWzR-00000005ylk-1aiw
	for linux-nvme@lists.infradead.org;
	Wed, 25 Jun 2025 20:45:10 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PJMF5t011152
	for <linux-nvme@lists.infradead.org>; Wed, 25 Jun 2025 13:44:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=Nrl/mM1f4nUDM+SPsl9lsAxt3jHm+mBbaf0FUbbncJ8=; b=MvKML5cfnWYN
	FCnL9Ra6bZ+zk79B/N6jfhWaGzqs6PhjwpRWnBb9F+VANysu6Kwcw22JlVN/FUgg
	Xv+bRgKN1/jSyD7tqsPYIwiA8BqztrWvQHfOdDospaDTkNz5AB8hEubIxaGp6/13
	nuKjOILb3eKu1GlqwHS5WbEhx/hwur2Qx4whTOsF+ig4AvmSqlKxIYh0RGVl3fC2
	bbGt2hlPSdj8KrgdmfSoLEnXXm8kx6GEQ5/+RGPBIZeaVIn65r5gUMfre/O/rphT
	0CDJwvQs22fP+eKKLaQvR/r6+cM9z5GHpRLoCEq1yNrBVeQwINr8J3TJu71DJ4Rx
	jMc0hCtCEg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47gext4dms-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 25 Jun 2025 13:44:59 -0700 (PDT)
Received: from twshared4564.15.prn3.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Wed, 25 Jun 2025 20:44:57 +0000
Received: by devbig1708.prn1.facebook.com (Postfix, from userid 544533)
	id CB8438C48C9; Wed, 25 Jun 2025 13:44:46 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <hch@lst.de>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>
CC: <axboe@kernel.dk>, <leon@kernel.org>, <joshi.k@samsung.com>,
        <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 2/2] nvme: convert metadata mapping to dma iter
Date: Wed, 25 Jun 2025 13:44:45 -0700
Message-ID: <20250625204445.1802483-2-kbusch@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250625204445.1802483-1-kbusch@meta.com>
References: <20250625204445.1802483-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDE1OSBTYWx0ZWRfX9Lo2MfHnILYH X2NGXSM61bSqE7q56EnrRqa2Erq/J5XmosQmTpegHBr/fd+yXbu4zC6EXgJI2y7qz+8WejMick2 n4Umn2qZdiHw74qtZkdSzENCIwEcBYOZfh6hfZx/Aee/i7rsRiXw73jip5LJhuodplSEXHACQww
 smq0nbuwXxbcOVKxz/3gVaSHClvBSkCHGXzuydqVCk6SmcgmrZoQcAPsJ7Jc7v60sUD9JVRrIAU z7zxm+8StOq8gxWoSYqxj5v8GZN/bSVCE7VeFQWZz+ffEbtMHeBYjcBLyHtGHNDw8D5zWccG2og IqMzH7VOIAt+TAbMdkIqHO+9gS8EoKPBosnYA3sp6kKmCqyoSpw8qKWU/SXHXaw1zbHfsu3KuHw
 mmDVQiFnpv8kN9tgooiZkC/t+MMMsOfkhr4n1XT0G5YznQQCoKRa/jnUSJuOh8dvqhUWR2xl
X-Proofpoint-ORIG-GUID: nCFBSmmf_aHoPEumCZ00WrzM5op7P36i
X-Authority-Analysis: v=2.4 cv=YuIPR5YX c=1 sm=1 tr=0 ts=685c5fcb cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=jSp59qru_JMrQpIs8J4A:9
X-Proofpoint-GUID: nCFBSmmf_aHoPEumCZ00WrzM5op7P36i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_07,2025-06-25_01,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250625_214505_868928_57DBF67C 
X-CRM114-Status: GOOD (  14.96  )
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

Aligns data and metadata to the similar dma mapping scheme and removes
one more user of the scatter-gather dma mapping.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 69 +++++++++++++----------------------------
 1 file changed, 21 insertions(+), 48 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 38be1505dbd96..f82ef19fa0a3a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -270,13 +270,13 @@ struct nvme_iod {
 	struct nvme_command cmd;
 	u8 flags;
 	u8 nr_descriptors;
+	u8 nr_meta_descriptors;
=20
 	unsigned int total_len;
 	struct dma_iova_state dma_state;
 	void *descriptors[NVME_MAX_NR_DESCRIPTORS];
=20
 	dma_addr_t meta_dma;
-	struct sg_table meta_sgt;
 	struct nvme_sgl_desc *meta_descriptor;
 };
=20
@@ -1010,70 +1010,39 @@ static blk_status_t nvme_map_data(struct request =
*req)
 	return nvme_pci_setup_data_prp(req, &iter);
 }
=20
-static void nvme_pci_sgl_set_data_sg(struct nvme_sgl_desc *sge,
-		struct scatterlist *sg)
-{
-	sge->addr =3D cpu_to_le64(sg_dma_address(sg));
-	sge->length =3D cpu_to_le32(sg_dma_len(sg));
-	sge->type =3D NVME_SGL_FMT_DATA_DESC << 4;
-}
-
 static blk_status_t nvme_pci_setup_meta_sgls(struct request *req)
 {
 	struct nvme_queue *nvmeq =3D req->mq_hctx->driver_data;
-	struct nvme_dev *dev =3D nvmeq->dev;
 	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
+	struct nvme_dev *dev =3D nvmeq->dev;
 	struct nvme_sgl_desc *sg_list;
-	struct scatterlist *sgl, *sg;
-	unsigned int entries;
+	struct blk_dma_iter iter;
 	dma_addr_t sgl_dma;
-	int rc, i;
-
-	iod->meta_sgt.sgl =3D mempool_alloc(dev->iod_meta_mempool, GFP_ATOMIC);
-	if (!iod->meta_sgt.sgl)
-		return BLK_STS_RESOURCE;
-
-	sg_init_table(iod->meta_sgt.sgl, req->nr_integrity_segments);
-	iod->meta_sgt.orig_nents =3D blk_rq_map_integrity_sg(req,
-							   iod->meta_sgt.sgl);
-	if (!iod->meta_sgt.orig_nents)
-		goto out_free_sg;
+	int i =3D 0;
=20
-	rc =3D dma_map_sgtable(dev->dev, &iod->meta_sgt, rq_dma_dir(req),
-			     DMA_ATTR_NO_WARN);
-	if (rc)
-		goto out_free_sg;
+	if (!blk_rq_integrity_dma_map_iter_start(req, dev->dev, &iter))
+		return iter.status;
=20
 	sg_list =3D dma_pool_alloc(nvmeq->descriptor_pools.small, GFP_ATOMIC,
 			&sgl_dma);
 	if (!sg_list)
-		goto out_unmap_sg;
+		return BLK_STS_RESOURCE;
=20
-	entries =3D iod->meta_sgt.nents;
 	iod->meta_descriptor =3D sg_list;
 	iod->meta_dma =3D sgl_dma;
=20
 	iod->cmd.common.flags =3D NVME_CMD_SGL_METASEG;
 	iod->cmd.common.metadata =3D cpu_to_le64(sgl_dma);
=20
-	sgl =3D iod->meta_sgt.sgl;
-	if (entries =3D=3D 1) {
-		nvme_pci_sgl_set_data_sg(sg_list, sgl);
-		return BLK_STS_OK;
-	}
-
 	sgl_dma +=3D sizeof(*sg_list);
-	nvme_pci_sgl_set_seg(sg_list, sgl_dma, entries);
-	for_each_sg(sgl, sg, entries, i)
-		nvme_pci_sgl_set_data_sg(&sg_list[i + 1], sg);
=20
-	return BLK_STS_OK;
+	do {
+		nvme_pci_sgl_set_data(&sg_list[++i], &iter);
+	} while (blk_rq_integrity_dma_map_iter_next(req, dev->dev, &iter));
=20
-out_unmap_sg:
-	dma_unmap_sgtable(dev->dev, &iod->meta_sgt, rq_dma_dir(req), 0);
-out_free_sg:
-	mempool_free(iod->meta_sgt.sgl, dev->iod_meta_mempool);
-	return BLK_STS_RESOURCE;
+	nvme_pci_sgl_set_seg(sg_list, sgl_dma, i);
+	iod->nr_meta_descriptors =3D i;
+	return BLK_STS_OK;
 }
=20
 static blk_status_t nvme_pci_setup_meta_mptr(struct request *req)
@@ -1086,6 +1055,7 @@ static blk_status_t nvme_pci_setup_meta_mptr(struct=
 request *req)
 	if (dma_mapping_error(nvmeq->dev->dev, iod->meta_dma))
 		return BLK_STS_IOERR;
 	iod->cmd.common.metadata =3D cpu_to_le64(iod->meta_dma);
+	iod->nr_meta_descriptors =3D 0;
 	return BLK_STS_OK;
 }
=20
@@ -1107,7 +1077,6 @@ static blk_status_t nvme_prep_rq(struct request *re=
q)
 	iod->flags =3D 0;
 	iod->nr_descriptors =3D 0;
 	iod->total_len =3D 0;
-	iod->meta_sgt.nents =3D 0;
=20
 	ret =3D nvme_setup_cmd(req->q->queuedata, req);
 	if (ret)
@@ -1222,19 +1191,23 @@ static __always_inline void nvme_unmap_metadata(s=
truct request *req)
 {
 	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
 	struct nvme_queue *nvmeq =3D req->mq_hctx->driver_data;
+	struct nvme_sgl_desc *sg_list =3D iod->meta_descriptor;
+	enum dma_data_direction dir =3D rq_dma_dir(req);
 	struct nvme_dev *dev =3D nvmeq->dev;
+	int i;
=20
-	if (!iod->meta_sgt.nents) {
+	if (!iod->nr_meta_descriptors) {
 		dma_unmap_page(dev->dev, iod->meta_dma,
 			       rq_integrity_vec(req).bv_len,
 			       rq_dma_dir(req));
 		return;
 	}
=20
+	for (i =3D 1; i <=3D iod->nr_meta_descriptors; i++)
+		dma_unmap_page(dev->dev, le64_to_cpu(sg_list[i].addr),
+				le32_to_cpu(sg_list[i].length), dir);
 	dma_pool_free(nvmeq->descriptor_pools.small, iod->meta_descriptor,
 			iod->meta_dma);
-	dma_unmap_sgtable(dev->dev, &iod->meta_sgt, rq_dma_dir(req), 0);
-	mempool_free(iod->meta_sgt.sgl, dev->iod_meta_mempool);
 }
=20
 static __always_inline void nvme_pci_unmap_rq(struct request *req)
--=20
2.47.1


