Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC6DC87FDA
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Aug 2025 16:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ut48uWJtSD/GPhmg0N8X2KhVkgcEnwTLCf0dr8KqeYs=; b=DtFt4rJsHVJKeB1Dd7rsRzFlJ2
	EVW0RtiUdHPiRVvNwcAL6TyyuxCP1Ies+nNC6hwooq5QnUBkJX8xKuIuG7A+NIB/DJsWPpsRHExsn
	YmwnL5UWC21COrune0AO4UFLcStW0OKRvOQQHrDqPOmwxWyp5L6n5d+r8ZsnS+YDzzpkZfcvhBdYf
	Qxc//ttcHgNTR1A3Xl4F2ig2faMNgpbqUlwbdsWblq6QDFcQDR4ujd4730NPJKsWZegkljqAda93C
	LTCAHwEzdjRft6SW76mFKh8luFn9q2YLdMs2f8pB935C7qBAxJDRNTDgB83MmJQVgltu2c27YsWE5
	+8AJGjrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukPWf-00000003GA6-3J8N;
	Fri, 08 Aug 2025 16:01:01 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukPUU-00000003FgN-0sCq
	for linux-nvme@lists.infradead.org;
	Fri, 08 Aug 2025 15:58:47 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578FJ2Vp027029
	for <linux-nvme@lists.infradead.org>; Fri, 8 Aug 2025 08:58:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=ut48uWJtSD/GPhmg0N8X2KhVkgcEnwTLCf0dr8KqeYs=; b=PF4dCi34NY3M
	3tBLEaduklOMj6PpW70+ioKg4hR/Da/syL7aE6Vzts9WCzPHiEJ5+Y1paBj4nDJc
	JLanF1uzXhAqbkadt2D2Xq6C5/5agokXAMue7zHkYlt8I2s+vQsPkb7+u9pf7gcB
	6x2chywrxU69TjbGX7o0tpSJDZPXQoZZ4lReYEcdOAszdVLzcNxrDtz1pcTMGK7o
	ytxlHswOzSX0975M8linJkgVnAMjODkT3tZi8HIVketofseTMVbIxGhh0mG4BC4e
	ZvrA/FX99IBBO/woiRoSY6uqitkgrSlNsw9EQ2WlCf83modLIDeoNsMIJm9OkCrk
	afW2RHfZ3Q==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48d8mybvnm-19
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 08 Aug 2025 08:58:45 -0700 (PDT)
Received: from twshared60001.02.ash8.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Fri, 8 Aug 2025 15:58:36 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 422316C76CC; Fri,  8 Aug 2025 08:58:27 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv5 7/8] nvme-pci: create common sgl unmapping helper
Date: Fri, 8 Aug 2025 08:58:25 -0700
Message-ID: <20250808155826.1864803-8-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250808155826.1864803-1-kbusch@meta.com>
References: <20250808155826.1864803-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=I5BlRMgg c=1 sm=1 tr=0 ts=68961eb5 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=Duz19Zw78js5DzQJfkIA:9
X-Proofpoint-ORIG-GUID: QiSE75vr1rI1fzh46IluxVew0_mpz_Bn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDEyOSBTYWx0ZWRfXxxB8wpFLYlu/ sIp85RcO58lGNwhMssUsoZ6TK348u8V/bkjXE/GeTeXcd/JvoXJRsWdN38JyupR71urXRRWEoIV 0DExZ7UKxMc6jRlcJz7HZHBbPoypYPgB+1stWIOBX45vPcpxH0tZSHn+K+mQw+uI9S9LEXna3Oz
 M1OnAPQ2Qi52qhqIls+AH2oxNPHDsczgndgBK1Ub7ln/sCSpokZtrcmXh+5agaP3pMQCX3WVN2F t33kC3IReoM2FWeE5AwiQFQZEhse6OGsdOPd3FOMsjiufEE3glW9osgvOojWX00gAEkK+/vrSA2 c4ao7pxynnw57KyKd2GDeCvuP0zzAH4AmrvxOviikgDq8veFIMOtCjFKFdqnoKi+Q/uSj1/4WEe
 CkePOHr5xeAv8owVakFfq5YXYQ6sofbtJVI8i4jYD4BvtPYGvzkeuGJvPaChu1jMJ3F1QW34
X-Proofpoint-GUID: QiSE75vr1rI1fzh46IluxVew0_mpz_Bn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_05,2025-08-06_01,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250808_085846_249989_884B91B0 
X-CRM114-Status: GOOD (  13.61  )
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


