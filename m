Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0ACCE9D3EC
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Feb 2026 14:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hjbgxDuqsTBAfo5zGr5m/fQfTnrPNdOxncntTnkTMOo=; b=PJRJjE8RygjswkpjRrevL1yPGx
	dLX7PI4SPdT2qkSutzKYmlh2SsLcP9KXI9bdol0FmFlpqIFL+X4zKpGbITV/ORzQ//KySaHlVLbhK
	ViE4SUgv5FGi/x8ZA6ZNndujq9trk88pgW1O3ChDZ2UchWuShaoVOjBfWiQews2pFokSdEKxp2Dge
	7Elobl3c+b65LiZJJNupN0jr+K3hacbYOrTonXg/nPktCcHoQW5w6xMhcR1gp7dPgk7YgnX8fxxoF
	hp8HOBtqShu6JbALAjtyNgDlmC8KlwsuoWTkNKU3rga7o2S2snwv6nBY/jJM1T8DZrLUSmwW4XSF7
	hL04+w4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vneAj-00000008bpS-1k0j;
	Wed, 04 Feb 2026 14:48:01 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vneAg-00000008bp5-1L9Z
	for linux-nvme@lists.infradead.org;
	Wed, 04 Feb 2026 14:47:59 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614AcpI81412138
	for <linux-nvme@lists.infradead.org>; Wed, 4 Feb 2026 06:47:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=hjbgxDuqsTBAfo5zGr
	5m/fQfTnrPNdOxncntTnkTMOo=; b=XJqsy+gmohD1YxEIf8fpQ3AgdnWlcyjIJd
	lwlGIJa5PyjO1czgSZP1xqDF5gknH7qoZc1Jc0oSxr1kAvsm0cmN3j26tvC1NK81
	Zsso4NySQCafWM06QL21jVS3ySFkF0hFQqWh1YunulbUmyXn4p+jP0GhW4Gry4MA
	YqoHidOJDY72I4uYKBCQe3MVDT5kuO5WA3uiEK189C5Uy2Al7RE/xW9h8k25Ph4C
	ip3wE47NCsLM3B7PGUBoYyytGh1yIkRmjLUhTc41Gdg2wTKcyOKK+JF/llxqfJ07
	0GuwA9AyN7KBJoaIl4e1g+sSH5Y8zlAuMkTmH4dGnxKtRgCdJQbg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c3u2rnwk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 04 Feb 2026 06:47:56 -0800 (PST)
Received: from twshared13080.31.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Wed, 4 Feb 2026 14:47:55 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id AD7A371F3A7E; Wed,  4 Feb 2026 06:47:41 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: <nitin.rawat@oss.qualcomm.com>, Keith Busch <kbusch@kernel.org>,
        Pradeep P
 V K <pradeep.pragallapati@oss.qualcomm.com>
Subject: [PATCH] nvme-pci: handle changing device dma map requirements
Date: Wed, 4 Feb 2026 06:47:41 -0800
Message-ID: <20260204144741.732805-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: hPuQR3m2jWZeHzo6E2qKxcuaeYlOkdoi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDExMiBTYWx0ZWRfXysI120VK0Eww
 W7+FfNMWRWL7I+XsejYj0X3gn/j5EUTSwa7UbKkLk0Oy1DIw6OUZkzFF6a9AUr3Hf8Ne44x3rF+
 TgrhEeGFJ/WjUJMFVTwrIyMkuKVOZT9NSvQNeOfIkaCRnzL2KzQUWgmJVJ6IC/ZT0agjXwi7+ld
 pV5Xgkt9/YdhoW2mma0G0e1GZL/qpmmpL5aWnXRKyVbA6l229O4IeaKZmi9BVXxXn2uUiiNpPoa
 ludyJGc7K3K6NqIUZjC369blQzqSWDsaq4Btfbd6zWQd+6vAjkCnSXofM5hUM82kiy8OJ+Mp0An
 S7HlYmHgGXjq8Ht5i4NvMeSn8YQDrn0/570l4YPvP+wyHgIiE4Zg1bI826rj24HVr65a6KnRxsm
 XBKxN7D0xcHMQrOeLLCs/CqnISLglgSqdH8thWVaSEPUKeD/dVKi4+ePztYQcyMwpXs8+si4ijE
 5K91d+HcR8rsQWcGc6w==
X-Authority-Analysis: v=2.4 cv=b8q/I9Gx c=1 sm=1 tr=0 ts=69835c1c cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=FRop3lbQfjv4RQsexjMA:9
X-Proofpoint-GUID: hPuQR3m2jWZeHzo6E2qKxcuaeYlOkdoi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_04,2026-02-04_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260204_064758_406841_C74E4B0D 
X-CRM114-Status: GOOD (  16.15  )
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

The initial state of dma_needs_unmap may be false, but change to true
while mapping the data iterator. Enabling swiotlb is one such case that
can change the result. The nvme driver needs to save the mapped dma
vectors to be unmapped later, so allocate as needed during iteration
rather than assume it was always allocated at the beginning. This fixes
a NULL dereference from accessing an uninitialized dma_vecs when the
device dma unmapping requirements change mid-iteration.

Reported-by: Pradeep P V K <pradeep.pragallapati@oss.qualcomm.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 49 ++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2a52cf46d9603..e44d2867bdd35 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -808,7 +808,7 @@ static void nvme_unmap_data(struct request *req)
 		if (nvme_pci_cmd_use_sgl(&iod->cmd))
 			nvme_free_sgls(req, &iod->cmd.common.dptr.sgl,
 			               iod->descriptors[0], attrs);
-		else
+		else if (iod->nr_dma_vecs)
 			nvme_free_prps(req, attrs);
 	}
=20
@@ -816,21 +816,40 @@ static void nvme_unmap_data(struct request *req)
 		nvme_free_descriptors(req);
 }
=20
-static bool nvme_pci_prp_iter_next(struct request *req, struct device *d=
ma_dev,
-		struct blk_dma_iter *iter)
+static bool nvme_pci_prp_save_mapping(struct request *req,
+				      struct device *dma_dev,
+				      struct blk_dma_iter *iter)
 {
 	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
=20
+	if (dma_use_iova(&iod->dma_state) || !dma_need_unmap(dma_dev))
+		return true;
+
+	if (!iod->nr_dma_vecs) {
+		struct nvme_queue *nvmeq =3D req->mq_hctx->driver_data;
+
+		iod->dma_vecs =3D mempool_alloc(nvmeq->dev->dmavec_mempool,
+				GFP_ATOMIC);
+		if (!iod->dma_vecs) {
+			iter->status =3D BLK_STS_RESOURCE;
+			return false;
+		}
+	}
+
+	iod->dma_vecs[iod->nr_dma_vecs].addr =3D iter->addr;
+	iod->dma_vecs[iod->nr_dma_vecs].len =3D iter->len;
+	iod->nr_dma_vecs++;
+	return true;
+}
+
+static bool nvme_pci_prp_iter_next(struct request *req, struct device *d=
ma_dev,
+		struct blk_dma_iter *iter)
+{
 	if (iter->len)
 		return true;
 	if (!blk_rq_dma_map_iter_next(req, dma_dev, iter))
 		return false;
-	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(dma_dev)) {
-		iod->dma_vecs[iod->nr_dma_vecs].addr =3D iter->addr;
-		iod->dma_vecs[iod->nr_dma_vecs].len =3D iter->len;
-		iod->nr_dma_vecs++;
-	}
-	return true;
+	return nvme_pci_prp_save_mapping(req, dma_dev, iter);
 }
=20
 static blk_status_t nvme_pci_setup_data_prp(struct request *req,
@@ -843,15 +862,8 @@ static blk_status_t nvme_pci_setup_data_prp(struct r=
equest *req,
 	unsigned int prp_len, i;
 	__le64 *prp_list;
=20
-	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(nvmeq->dev->dev)) =
{
-		iod->dma_vecs =3D mempool_alloc(nvmeq->dev->dmavec_mempool,
-				GFP_ATOMIC);
-		if (!iod->dma_vecs)
-			return BLK_STS_RESOURCE;
-		iod->dma_vecs[0].addr =3D iter->addr;
-		iod->dma_vecs[0].len =3D iter->len;
-		iod->nr_dma_vecs =3D 1;
-	}
+	if (!nvme_pci_prp_save_mapping(req, nvmeq->dev->dev, iter))
+		return iter->status;
=20
 	/*
 	 * PRP1 always points to the start of the DMA transfers.
@@ -1218,6 +1230,7 @@ static blk_status_t nvme_prep_rq(struct request *re=
q)
 	iod->nr_descriptors =3D 0;
 	iod->total_len =3D 0;
 	iod->meta_total_len =3D 0;
+	iod->nr_dma_vecs =3D 0;
=20
 	ret =3D nvme_setup_cmd(req->q->queuedata, req);
 	if (ret)
--=20
2.47.3


