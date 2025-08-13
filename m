Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A52CA0EE6
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Aug 2025 16:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+gyerWlCZzrYWnrBZKmzALwcarJOeB+Qemyc5hQMAHs=; b=j7kdL4jEzdHYhJu/BkKOheBL5B
	ELdsIECWOJWIqg/pCq3x44LUoDbiTH7l6zRAZzXXVHCAHFqy9PqMnNUsxtvIzc2Ix7tKxQwACdLxH
	oj2ydCPogxTrOyVFFgKhHqSSeDU83XXNF/zgk6oe3BYWPxLUy/6OR0l5dF4/Is2GrW3IOAX0CqXF3
	Z/pnlbbdgwLddQMp/9hHGQpt9GX0zuRFuo0S/WMKzj3+2W7uSkT4AzQkrT3Cgdbcm3mbz98/xJ1Wi
	ESwUdAa8nww8TpnD9h/QYN6+N9zbVsIHio2fmSn65yGp5bED/qH7vqKlodTC2oeCcqD26f/tzQTet
	IRhfTCzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umEOA-0000000EOvo-3mM9;
	Wed, 13 Aug 2025 16:31:46 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umDVM-0000000ECo7-2TuI
	for linux-nvme@lists.infradead.org;
	Wed, 13 Aug 2025 15:35:09 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DFYH1D019140
	for <linux-nvme@lists.infradead.org>; Wed, 13 Aug 2025 08:35:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=+gyerWlCZzrYWnrBZKmzALwcarJOeB+Qemyc5hQMAHs=; b=MSW7nBaIGbx9
	+SGBr6FFP1xcdkKACqxX28X1a24n3fKuo9u8VHh6j4os9vBibSH9/kNZNHsjB1hk
	copdwdEpQejccWIK/UQGsgX4mWB5W32tPA1LNbuuQ3TBc4MtaPgTUBU0eqecmur6
	XqhEna/Gwmg6EXeMkPMlywE7Xvp4pqETfuDBC6rNxg7/vp4V2GbP9jrNAv9C7Mu1
	ZA3ooWxMltXo220THUK2tw8g9x6GB6YSqMlcmfavDpiwNw8Yt475fK16Wf2jmxG8
	ZsdF1FrUQz4y++wznqcoqSrUyigRSsyQ65QQvTo+zcE2NR/4qwN79ve+PUolwdw9
	PjardywWuQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48gpru2mn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 13 Aug 2025 08:35:08 -0700 (PDT)
Received: from twshared51809.40.frc1.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Wed, 13 Aug 2025 15:35:07 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 93E0F97CD8A; Wed, 13 Aug 2025 08:32:00 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv7 8/9] nvme-pci: create common sgl unmapping helper
Date: Wed, 13 Aug 2025 08:31:52 -0700
Message-ID: <20250813153153.3260897-9-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250813153153.3260897-1-kbusch@meta.com>
References: <20250813153153.3260897-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: kwLX29S9lCenG3Ku1ewvdvdokn3-g_Vz
X-Authority-Analysis: v=2.4 cv=JKM7s9Kb c=1 sm=1 tr=0 ts=689cb0ac cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=n24e_ilN-p_VDh2xB_kA:9
X-Proofpoint-GUID: kwLX29S9lCenG3Ku1ewvdvdokn3-g_Vz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDE0NiBTYWx0ZWRfXx0AA7U2w08nW Uil6wP8fmNT1udzWXVfQE4k7RGsJk4de6FsIM7bbtHj7OH2ROZJgcFg3ziykKDqb/j7u0iycdJW JDazWF7drjMquBIp+Ey90dYTg9+APKdXrr0vnJMcmm5136sfZyO5jfw9FUsLgo06YG3uW+qjNUF
 NTwO79vW45I4620ZRDn+LgX8noZI+0p+KDfKQ0IyrtsDRTS++AYCTemQLI6QRikLa83a99njCw2 3Wi9ZsQ1TTblKBCzcIWMqpKlR22yxkD3HXtEYbGNV+ioNowc6GsE0xmCJjfM45TTByKPeehIblX orTkoJmWhJPXMC+SttuM1PQKSR+YqzpUpIYaSgXRwHYlGMNXga/yxZ6rXDr3elxuVuuWcWlZjxB
 jvp6KQstIOjnvbvZkQBczOQcWhnsPUpjJIS2r+TGzmVKA6uKyCZYKNysLROxIWEv4vPw9OW3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250813_083508_635816_752D8B89 
X-CRM114-Status: GOOD (  14.10  )
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

This can be reused by metadata sgls once that starts using the blk-mq
dma api.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 111b6bc6c93eb..e12d47fecc584 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -693,25 +693,23 @@ static void nvme_free_prps(struct request *req)
 	mempool_free(iod->dma_vecs, nvmeq->dev->dmavec_mempool);
 }
=20
-static void nvme_free_sgls(struct request *req)
+static void nvme_free_sgls(struct request *req, struct nvme_sgl_desc *sg=
e,
+		struct nvme_sgl_desc *sg_list)
 {
-	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
 	struct nvme_queue *nvmeq =3D req->mq_hctx->driver_data;
-	struct device *dma_dev =3D nvmeq->dev->dev;
-	dma_addr_t sqe_dma_addr =3D le64_to_cpu(iod->cmd.common.dptr.sgl.addr);
-	unsigned int sqe_dma_len =3D le32_to_cpu(iod->cmd.common.dptr.sgl.lengt=
h);
-	struct nvme_sgl_desc *sg_list =3D iod->descriptors[0];
 	enum dma_data_direction dir =3D rq_dma_dir(req);
+	unsigned int len =3D le32_to_cpu(sge->length);
+	struct device *dma_dev =3D nvmeq->dev->dev;
+	unsigned int i;
=20
-	if (iod->nr_descriptors) {
-		unsigned int nr_entries =3D sqe_dma_len / sizeof(*sg_list), i;
-
-		for (i =3D 0; i < nr_entries; i++)
-			dma_unmap_page(dma_dev, le64_to_cpu(sg_list[i].addr),
-				le32_to_cpu(sg_list[i].length), dir);
-	} else {
-		dma_unmap_page(dma_dev, sqe_dma_addr, sqe_dma_len, dir);
+	if (sge->type =3D=3D (NVME_SGL_FMT_DATA_DESC << 4)) {
+		dma_unmap_page(dma_dev, le64_to_cpu(sge->addr), len, dir);
+		return;
 	}
+
+	for (i =3D 0; i < len / sizeof(*sg_list); i++)
+		dma_unmap_page(dma_dev, le64_to_cpu(sg_list[i].addr),
+			le32_to_cpu(sg_list[i].length), dir);
 }
=20
 static void nvme_unmap_data(struct request *req)
@@ -731,7 +729,8 @@ static void nvme_unmap_data(struct request *req)
 	if (!blk_rq_dma_unmap(req, dma_dev, &iod->dma_state, iod->total_len,
 				iod->flags & IOD_P2P_BUS_ADDR)) {
 		if (nvme_pci_cmd_use_sgl(&iod->cmd))
-			nvme_free_sgls(req);
+			nvme_free_sgls(req, iod->descriptors[0],
+				       &iod->cmd.common.dptr.sgl);
 		else
 			nvme_free_prps(req);
 	}
--=20
2.47.3


