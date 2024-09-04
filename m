Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A85CD4847
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2024 18:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8PxjRWEcFo2XG9dC8tJ/4vww6LbM0idZ3cIhDJSWzf4=; b=YjeLMitE04gixY90kj09u/Mhy4
	rRip7b+HOFIbaMhxe7EY5YoGr4EuDzO6LAd3ialnGjKR8molNzELPHcYePT2f3BTprjmAuIlBdNJR
	HGHXSHbeqxgJdunIewCc4Yi7x2mPx17W4EPfl2pY6ysQfbAQTJUJW0Sts2kxeJYPXQ2xKTHFKdtaW
	W55llcDAGn7+T5nbfH9Rau88n9Izxy4LDojpI7Rlyg/qcp3obM7L6YFbV6+Vx4uoLekN0tfvfm0DT
	SAFpvBwpNm2TYKGfXf6DXoXedJ0YTJKaPOGMxuRXdHzs4IkjRCnI5XYAhbBvl64D69dQyzSp5jTOQ
	JnRjrhgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slutp-00000005dTm-3s3B;
	Wed, 04 Sep 2024 18:38:37 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slutk-00000005dPN-1GeV
	for linux-nvme@lists.infradead.org;
	Wed, 04 Sep 2024 18:38:33 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 484D6iUe021402
	for <linux-nvme@lists.infradead.org>; Wed, 4 Sep 2024 11:38:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=8PxjRWEcFo2XG9dC8tJ/4vww6LbM0idZ3cIhDJSWzf4=; b=
	eDNA2Ikqqlk6Zqi8N+7ipI7AsQGQR8QRZvf/eVzJMq2iWYYe8ZTyGrQuB+gk81rU
	rsLxOA3fsLOU1YOkkVtFubfPlkMWfvgpZjhSIsmIFVy78gNKYFAPgHy2IRsaeSWA
	ZcsnozjHTZkSNv5N2bZ7o7gdvZZoSBfozpVSahtr+p0HcwcaN5LIbY5OueKJLMHG
	Mkk16eW6BMW3Aq4/iwiJieItTKHpK4mEeGK0KKWIrddOAJ/qioCmhSa7M4vNaEx/
	aoQ0m7cSGtEmOU9HkbS9HBk/PHe2LdX9ZbxMtF3kTjqvsfbOIhfO6MRtuQlxPizH
	xeaAHYXfsS3G9DXZtSLepw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 41e4wvs0af-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 04 Sep 2024 11:38:31 -0700 (PDT)
Received: from twshared10900.35.frc1.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 4 Sep 2024 18:38:26 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 947C312A1F097; Wed,  4 Sep 2024 11:38:19 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <hch@lst.de>, <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH-part-2 2/9] nvme-pci: provide prp selection helper
Date: Wed, 4 Sep 2024 11:38:10 -0700
Message-ID: <20240904183818.713941-3-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240904183818.713941-1-kbusch@meta.com>
References: <20240904183818.713941-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: -2dkUbJJF3-yi4U4USo4UztrhU2VWNqw
X-Proofpoint-ORIG-GUID: -2dkUbJJF3-yi4U4USo4UztrhU2VWNqw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_16,2024-09-04_01,2024-09-02_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_113832_498462_8305EBFC 
X-CRM114-Status: GOOD (  13.42  )
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

The prp selection criteria is going to get a little more complicated so
introduce a helper to make the code more readable.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 21f6aeb236a6f..1763ee1886a7f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -528,6 +528,12 @@ static inline bool nvme_pci_use_sgls(struct nvme_dev=
 *dev, struct request *req,
 	return avg_seg_size >=3D sgl_threshold;
 }
=20
+static inline bool nvme_pci_use_prps(struct bio_vec *bv)
+{
+	unsigned int off =3D bv->bv_offset & (NVME_CTRL_PAGE_SIZE - 1);
+	return  off + bv->bv_len <=3D NVME_CTRL_PAGE_SIZE * 2;
+}
+
 static void nvme_free_prps(struct nvme_dev *dev, struct request *req)
 {
 	const int last_prp =3D NVME_CTRL_PAGE_SIZE / sizeof(__le64) - 1;
@@ -784,8 +790,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *de=
v, struct request *req,
 		struct bio_vec bv =3D req_bvec(req);
=20
 		if (!is_pci_p2pdma_page(bv.bv_page)) {
-			if ((bv.bv_offset & (NVME_CTRL_PAGE_SIZE - 1)) +
-			     bv.bv_len <=3D NVME_CTRL_PAGE_SIZE * 2)
+			if (nvme_pci_use_prps(&bv))
 				return nvme_setup_prp_simple(dev, req,
 							     &cmnd->rw, &bv);
=20
--=20
2.43.5


