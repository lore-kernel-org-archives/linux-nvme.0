Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1466CD4F21
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2024 18:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1WbH4+z1nhI4pw/764e1D4a4xyNbP9gWZPr0rvsCOIQ=; b=kOONRUSK4DCAe8dVFBi44T8Qa9
	RLHliwnVGDaKkmELpC/x1nIn4A81O6Pl8rKMcIQaWsjeo2AvvG/xvsLGJ+zNpv6uAjkm1k477Ezbj
	3ByM3rAFP2GfMY3vEsCYLmoPJsauXO0vzpsjhTPsprs1qmU+9AfuUEElDnh8AwFyOrQsyaTiU58+t
	sQa42zUvQw0yYdo6IshN0RmJdZlT+Uoht8VQzqCkiiP36v3Yokzhr38uOorhEAmLydhtDY6OTL9CG
	2mJUshCg0JiBoCQs7dNnrOIKkLhOThtHdYXXmuOOtiFxpYOTl0b3v4NHjj304f973OOpuqJDXjyBQ
	TP9TGSWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sluts-00000005dWQ-1mfN;
	Wed, 04 Sep 2024 18:38:40 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slutm-00000005dQs-0nvD
	for linux-nvme@lists.infradead.org;
	Wed, 04 Sep 2024 18:38:35 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 484D6iUh021402
	for <linux-nvme@lists.infradead.org>; Wed, 4 Sep 2024 11:38:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=1WbH4+z1nhI4pw/764e1D4a4xyNbP9gWZPr0rvsCOIQ=; b=
	K+bJOQZaitMwyYDBQqgDuWEIILBmxspkkj7dbT3Mxcjcs505F8vPHvQNbjL67Csy
	Jln0K+zyVo/pMg2OjLdRJpjiHHcTfVQVY5DVxpjJsFBKr//n3TzYJ05vAZgEcfxf
	+jIU/PiQqmwHkBKTJu3hSD3hOmBxdKU4VdIup7DQFz4h+pp0FOF5/UcAsOU6REqK
	ft1OeyrADbIxG/QazVnsiMvZih2LCObs00tX4/zzqHdnGWzzeoCVIlJbq2SL8/A9
	UFfmMJSuEJW/7Fb7vO6yTJ2Rv/jdpYY6w/ZZiBISWVQ3i338poaKuNDiDcT4q0FW
	iSyhDQVDd6/9WHedRk3XbQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 41e4wvs0af-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 04 Sep 2024 11:38:33 -0700 (PDT)
Received: from twshared17102.15.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 4 Sep 2024 18:38:29 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 9EA6D12A1F099; Wed,  4 Sep 2024 11:38:19 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <hch@lst.de>, <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH-part-2 3/9] nvme-pci: split out the simple dma mapping
Date: Wed, 4 Sep 2024 11:38:11 -0700
Message-ID: <20240904183818.713941-4-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240904183818.713941-1-kbusch@meta.com>
References: <20240904183818.713941-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: q7iDK9gKylqyJGx-ucuX0-i0ufjdxFA6
X-Proofpoint-ORIG-GUID: q7iDK9gKylqyJGx-ucuX0-i0ufjdxFA6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_16,2024-09-04_01,2024-09-02_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_113834_439553_0E0C916B 
X-CRM114-Status: GOOD (  12.81  )
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

To help imporve code readablilty.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 1763ee1886a7f..77d42eaada742 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -779,27 +779,13 @@ static blk_status_t nvme_setup_sgl_simple(struct nv=
me_dev *dev,
 	return BLK_STS_OK;
 }
=20
-static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *=
req,
+static blk_status_t __nvme_map_data(struct nvme_dev *dev, struct request=
 *req,
 		struct nvme_command *cmnd)
 {
 	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
 	blk_status_t ret =3D BLK_STS_RESOURCE;
 	int rc;
=20
-	if (blk_rq_nr_phys_segments(req) =3D=3D 1) {
-		struct bio_vec bv =3D req_bvec(req);
-
-		if (!is_pci_p2pdma_page(bv.bv_page)) {
-			if (nvme_pci_use_prps(&bv))
-				return nvme_setup_prp_simple(dev, req,
-							     &cmnd->rw, &bv);
-
-			if (nvme_pci_sgl_capable(dev, req))
-				return nvme_setup_sgl_simple(dev, req,
-							     &cmnd->rw, &bv);
-		}
-	}
-
 	iod->dma_len =3D 0;
 	iod->sgt.sgl =3D mempool_alloc(dev->iod_mempool, GFP_ATOMIC);
 	if (!iod->sgt.sgl)
@@ -832,6 +818,25 @@ static blk_status_t nvme_map_data(struct nvme_dev *d=
ev, struct request *req,
 	return ret;
 }
=20
+static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *=
req,
+		struct nvme_command *cmnd)
+{
+	if (blk_rq_nr_phys_segments(req) =3D=3D 1) {
+		struct bio_vec bv =3D req_bvec(req);
+
+		if (!is_pci_p2pdma_page(bv.bv_page)) {
+			if (nvme_pci_use_prps(&bv))
+				return nvme_setup_prp_simple(dev, req,
+							     &cmnd->rw, &bv);
+			if (nvme_pci_sgl_capable(dev, req))
+				return nvme_setup_sgl_simple(dev, req,
+							     &cmnd->rw, &bv);
+		}
+	}
+
+	return __nvme_map_data(dev, req, cmnd);
+}
+
 static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct reque=
st *req,
 		struct nvme_command *cmnd)
 {
--=20
2.43.5


