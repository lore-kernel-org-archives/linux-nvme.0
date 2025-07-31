Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 140FCC87FD2
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Jul 2025 15:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ut48uWJtSD/GPhmg0N8X2KhVkgcEnwTLCf0dr8KqeYs=; b=2oyoADiPf/VdRmPlM2bJchlNmo
	/7Ux5z4UjRsK0Q3CY+S6kkOaa8UkYyXXuccZJzz6nQwFVFZESQhK+2RaAMtRiWfrs1TVpGhSBH3re
	1zxLgWrwPsJ5kz5TFFFLJfGXzg5YT7d42We4DjFeBlE3x8gahPNMScvNnC6XcUyHbueDaduLb/R0h
	2VK84j3i+89C1YYAC7cuLvdGxaFkXfgurgslfx5C3SnxbrZgFIgS4ejlZVVMndKSkColX6M4w59g5
	LRdzH72dxIZFJzT63TQjE5M8SGTk2dyTWOaGKmkLOGq78/0IpB5TWZvDtHxXK8aEX2mf9AT8FV4Mk
	gCKkcOEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhV5u-00000003wfD-41jG;
	Thu, 31 Jul 2025 15:21:22 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhUqO-00000003vAg-3bOt
	for linux-nvme@lists.infradead.org;
	Thu, 31 Jul 2025 15:05:22 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 56VE72Wi018109
	for <linux-nvme@lists.infradead.org>; Thu, 31 Jul 2025 08:05:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=ut48uWJtSD/GPhmg0N8X2KhVkgcEnwTLCf0dr8KqeYs=; b=F5aCkAL9D/5o
	jwa0c1BJg3mcCiFfIJ4rYualp1lVHBnu/LVZpyJpKHIW2rVMiekhrtC96l9zr8Fc
	oKPQZDI1E76iH+M4vZd3tB68vKwH//GX0xJGHjoCdwH/szIAJCh3w0eYpN+OXD9k
	OcKNoyqen/neh5ntzXKgZWcn0UUTzo9KuB10RIVkyqshoWw1fe+dDgYg31Z5sk/G
	6+GdF4Ie7lWiQ/7bJWOZXT/VetARje1mOD36yh6p3u57wqOZXTRYCXktMViYzsMJ
	oB/mFyNvgnxbw3I2ovBfoJebyaN+cpZD7cG5DY15a3y35J8CrwaIKMWgiQxP5PfS
	lksKAOWxog==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4883m32mxa-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 31 Jul 2025 08:05:18 -0700 (PDT)
Received: from twshared21625.15.frc2.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Thu, 31 Jul 2025 15:05:18 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 2C638231DB3; Thu, 31 Jul 2025 08:05:14 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv4 7/8] nvme-pci: create common sgl unmapping helper
Date: Thu, 31 Jul 2025 08:05:12 -0700
Message-ID: <20250731150513.220395-8-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250731150513.220395-1-kbusch@meta.com>
References: <20250731150513.220395-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: HRZ1nrj6Na7de8j2zEe8wQFgJPs9Fmzc
X-Authority-Analysis: v=2.4 cv=WqwrMcfv c=1 sm=1 tr=0 ts=688b862e cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=Duz19Zw78js5DzQJfkIA:9
X-Proofpoint-GUID: HRZ1nrj6Na7de8j2zEe8wQFgJPs9Fmzc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDEwMiBTYWx0ZWRfX+rVblXXH3Sou xIxjgoDPXE/FFhqm91OnZNIgre5yeVfHlUyR3dS1WKlitHQnd6C0UoeNIT8v4X2c5V4UYPj5J2u jf5vZsSKk3nDXOI9uGCD6E2HgoVrqS9Tuj+6OO2vUyezOZGB9DbZQuYT/FcUHE2zJxdXl6RT4u5
 gP98b9oc9MKvHgoqyWm3kFnnsGsfgYNaPYlfrpHIJ4O76JusHNH/5v6VLhUnDVK+5kDthT9EmHs O0RAVAf69S7LxpqttMHErbG2Zg4fVYCHtBFFEOsmmaCulepAvsyWrG+3mgewRVWWUtsGLTygFQc 8FfN9sNBcBvWMcQ3+3ELuvOg/YlH0A5zsZWfYfCHADonsYJXDPqAUONV6NiUwFfh6o8zbYhlCCR
 i3eKv+AYv2Dco/QmI0JGg5ZPnC018pYt9JVRqNnOz4Ur2wSbTWa8AKe7ijYeKx6pAkXRm/tn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_02,2025-07-31_02,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250731_080521_020001_4144D14A 
X-CRM114-Status: GOOD (  13.84  )
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
---
 drivers/nvme/host/pci.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 111b6bc6c93eb..decb3ad1508a7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -693,25 +693,34 @@ static void nvme_free_prps(struct request *req)
 	mempool_free(iod->dma_vecs, nvmeq->dev->dmavec_mempool);
 }
=20
+
+static void __nvme_free_sgls(struct device *dma_dev, struct nvme_sgl_des=
c *sge,
+		struct nvme_sgl_desc *sg_list, enum dma_data_direction dir)
+{
+	unsigned int len =3D le32_to_cpu(sge->length);
+	unsigned int i, nr_entries;
+
+	if (sge->type =3D=3D (NVME_SGL_FMT_DATA_DESC << 4)) {
+		dma_unmap_page(dma_dev, le64_to_cpu(sge->addr), len, dir);
+		return;
+	}
+
+	nr_entries =3D len / sizeof(*sg_list);
+	for (i =3D 0; i < nr_entries; i++)
+		dma_unmap_page(dma_dev, le64_to_cpu(sg_list[i].addr),
+			le32_to_cpu(sg_list[i].length), dir);
+}
+
 static void nvme_free_sgls(struct request *req)
 {
 	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
 	struct nvme_queue *nvmeq =3D req->mq_hctx->driver_data;
 	struct device *dma_dev =3D nvmeq->dev->dev;
-	dma_addr_t sqe_dma_addr =3D le64_to_cpu(iod->cmd.common.dptr.sgl.addr);
-	unsigned int sqe_dma_len =3D le32_to_cpu(iod->cmd.common.dptr.sgl.lengt=
h);
 	struct nvme_sgl_desc *sg_list =3D iod->descriptors[0];
+	struct nvme_sgl_desc *sge =3D &iod->cmd.common.dptr.sgl;
 	enum dma_data_direction dir =3D rq_dma_dir(req);
=20
-	if (iod->nr_descriptors) {
-		unsigned int nr_entries =3D sqe_dma_len / sizeof(*sg_list), i;
-
-		for (i =3D 0; i < nr_entries; i++)
-			dma_unmap_page(dma_dev, le64_to_cpu(sg_list[i].addr),
-				le32_to_cpu(sg_list[i].length), dir);
-	} else {
-		dma_unmap_page(dma_dev, sqe_dma_addr, sqe_dma_len, dir);
-	}
+	__nvme_free_sgls(dma_dev, sge, sg_list, dir);
 }
=20
 static void nvme_unmap_data(struct request *req)
--=20
2.47.3


