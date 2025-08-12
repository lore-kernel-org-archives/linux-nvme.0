Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF51EC87FCB
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Aug 2025 17:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oZjy9qmDyJ9N8Kjq9alhx8rDCTwySWdnaJuLkKVMHfU=; b=osBjcC1LyZBbTUcSv3oUwSxih2
	Jwpbhdv5CcgD+fQ7I3QNV7ReYgOsiarHGUuelwP+zkoB8E8jEHnHkyt6MqI6tzbDv35l0GvVGmmAO
	ti6nuICwF+7MItXqAdWlhaY5vLrVRFOMKmi0zJzQN+NwKAgf+dnULpWix3QYu8cVO/K0GqkAAPGvj
	SOHnRC7ShDwRRf5twb9BQOmQtzO8T0LJrmUK7to6W9sEsbo4TSBUE0XvUVu737n3eeGkfs0YDUZc3
	uw2ZFS7oOnVzGTJhvKdWeSSFTrrtVSU0SYeshQ8FS5p5Zyy+hcl8z9U17We8e3MoVGt+nFvrEHSx1
	GLoA6X/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulssu-0000000BbSn-18x0;
	Tue, 12 Aug 2025 17:34:04 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulpRf-0000000Aywh-1WNZ
	for linux-nvme@lists.infradead.org;
	Tue, 12 Aug 2025 13:53:44 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDpi5k006825
	for <linux-nvme@lists.infradead.org>; Tue, 12 Aug 2025 06:53:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=oZjy9qmDyJ9N8Kjq9alhx8rDCTwySWdnaJuLkKVMHfU=; b=RZfdn/+xXo1u
	oEQmi/YBa3Jv3XfPzRXm5bdY9cpt7PdoEDbyd+AcahUI1dILEN1+6ZED0xqPAy1u
	onZioK0t0KC6YlO0Oj4xiMwh1AEN3d15Gmg0W12WtLocezGTSm+TNE6qCxSziGmy
	vUNXGtoarH7lLzpcyvHZ7dA6vK4tJNzEECltreVIMx1okdBHX0ZyVNoUaI96lPAK
	t746u7Y126uVwn7A822ac6N4w1J/ym2qHwKHYdwqEhFZ80RfSOWqp7pOJHGf5UsS
	XKXktY3pt0I9YkDL7DyA3Rc37WqmYVk0z0B/8igji9bIhyYdjrOKqG9xWiyIjKyS
	7TM/5Ih1PA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48g120b0cg-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 12 Aug 2025 06:53:42 -0700 (PDT)
Received: from twshared71707.17.frc2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 12 Aug 2025 13:52:23 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id DE3A08D4081; Tue, 12 Aug 2025 06:52:11 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv6 7/8] nvme-pci: create common sgl unmapping helper
Date: Tue, 12 Aug 2025 06:52:09 -0700
Message-ID: <20250812135210.4172178-8-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250812135210.4172178-1-kbusch@meta.com>
References: <20250812135210.4172178-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=KJdaDEFo c=1 sm=1 tr=0 ts=689b4766 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=r3bDFXGCrlSiSwDhwTUA:9
X-Proofpoint-ORIG-GUID: rCyZ2Ll6Ks9-tjvhdQh50infYFjIkOSR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDEzNCBTYWx0ZWRfX/syOp/KM45Uq 4DHQKmDCadXeDvUm2LlXUU7T0zQ9h352AZJqDghmcCgGaCdpe38CDv3kTAsB5vLCa1YnibNc6kU 9YFi8QaMoshm0KTsoptP8ZS/v4pMxdhm87RIgoPfqB063GgyMP3GMX6Ug4VYxlU1aCwvedo11YC
 sieKu3hIG45Lnn8rxPKiDKYpU/n/mzQxBFOkeIkM51BLxf38PUD9mgiSmlqeNTzjzs/tMMnOSZt vNqdlADYeVIcrChekCyU9RFxrrvuKeCzQe1qng4AhsgcBixOukls5kf/lo16cpGpnPqWg1JBlj0 mZXXrqs6SXuGa5KRz0lcHcbJM9aHbhWyxniZ+9F3MoPGXITFTAtbtmyO4VFnU55UFMFdCVt99zu
 AwXZD399+Pr2qHVXOmfDoE3TKvNAsx7nOwiESz7KMx5OfBoahQ6i0qQZABuMueE4VMDMkyKw
X-Proofpoint-GUID: rCyZ2Ll6Ks9-tjvhdQh50infYFjIkOSR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_065343_533286_96E994F5 
X-CRM114-Status: GOOD (  13.24  )
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
 drivers/nvme/host/pci.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 111b6bc6c93eb..2b89e74d1fa73 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -693,25 +693,33 @@ static void nvme_free_prps(struct request *req)
 	mempool_free(iod->dma_vecs, nvmeq->dev->dmavec_mempool);
 }
=20
-static void nvme_free_sgls(struct request *req)
+
+static void __nvme_free_sgls(struct request *req, struct nvme_sgl_desc *=
sge,
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
+}
+
+static void nvme_free_sgls(struct request *req)
+{
+	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
+	struct nvme_sgl_desc *sg_list =3D iod->descriptors[0];
+	struct nvme_sgl_desc *sge =3D &iod->cmd.common.dptr.sgl;
+
+	__nvme_free_sgls(req, sge, sg_list);
 }
=20
 static void nvme_unmap_data(struct request *req)
--=20
2.47.3


