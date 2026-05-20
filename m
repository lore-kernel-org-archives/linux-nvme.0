Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D255DCD5BA4
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2026 17:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lV9FdxcfRtVopWEsXnp9fBI2OT04lIqu7thHkNpzrbQ=; b=4tUob9b8J6CnDiphMmuLw7PTRY
	h/wkF+raMKJz5quwa+j8fKaMjHPuGJGyy/PjZAMF2BPBd6a1MmIHALyPGmv7dA0ViO25Sh5jmWgdz
	9veObH2kXoMuqtuDt7ImKNMt9MqrBuEIQ1yIqHl5tPDKszfONFXzEnsmvGRHEnqVRt79z/yps2zKZ
	R5lDSj4yF9JzgecMYTkx5XjLgg1um4Je3RlpUK65SjVa4cd8u+woL7QWOJYdpV9Vx7pUkit8ryyx+
	5/Y15GaBGgA0xGx1TyftOK7ewcEtUMKlyagMOIVetVJFw8B8OzypcuQrc0rVEdqgkdu82LO23tCG8
	avVKWhhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPl3n-00000005LyS-18wI;
	Wed, 20 May 2026 17:50:23 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPl3k-00000005LxP-3A0W
	for linux-nvme@lists.infradead.org;
	Wed, 20 May 2026 17:50:22 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KCibgW2117374
	for <linux-nvme@lists.infradead.org>; Wed, 20 May 2026 10:50:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=lV9FdxcfRtVopWEsXnp9fBI2OT04lIqu7thHkNpzrbQ=; b=GgdhJOMicClQ
	4feKk+06uvhKPhV01H9TuhQDb7eGpQ6Or0nlOH7HzgBseJq9EnHzxRnKwljq41jA
	Mk/hpRGP8x4HqPbz+rzVHWu8mQPkl4jZFrfAdHarKJXxq9Q2EWOrkndr551vEzYE
	EhnPhg73g4NfWl7epC/YiT9rQdxMni7v70beSZyvjRcftVvQ1yLbnXRBPK5GnkLS
	VkIJiHS+Dp5bMiZ80I6VCk/pyMDJ/kdxstxxdCNHM3yxrnqby74xKw2UIkN2sEhP
	ht3nyFoyU84hC/G9NuEIXwEyt6HMf500dmsKQwwzPn3WYwFCmAF8DhFHIzKGkbA0
	/afp3n15DA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e8vj5qmgq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 20 May 2026 10:50:17 -0700 (PDT)
Received: from twshared17152.01.snb2.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Wed, 20 May 2026 17:50:16 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 1B4A21AC8087E; Wed, 20 May 2026 10:50:06 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 2/2] nvme-pci: fix dma mapping leak on data setup error
Date: Wed, 20 May 2026 10:49:53 -0700
Message-ID: <20260520174953.2989852-2-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260520174953.2989852-1-kbusch@meta.com>
References: <20260520174953.2989852-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: rUCOD_bYPjIx7PZs3iJlPQJmGdsJGPco
X-Proofpoint-ORIG-GUID: rUCOD_bYPjIx7PZs3iJlPQJmGdsJGPco
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE3NCBTYWx0ZWRfXy7ueYFoJSMf4
 tFXfUR0U/YSENaZ8lFo9OGIBs5+XwvOKutwjuX7RjXBOhAhs9j+HcC6n1KZIhFdh0+kH0aCUg8C
 nVtTz/4QE+ndRAddsIw1ZNM8sxaCuaqffHKr+SgiBJD9d0MOX+39PgJGHqeFvBTRk1sMHXa4SVP
 XOz7FWugtWQTvYuQZfC3KCGJIJx7Ed1QLUhl94KSh+Bd1IURDDmPx6M+VAJ53CQGUUnwsTcl4Ln
 E9eC9SWt+Y7KUeMDfzySBuK22UsFd50qXgntYHc/IINOFn71+r0y4Z46syu6e3NQwUnWH+xlcEk
 yN0B431EdCX78QsdFpxAaJRc1qP8sCnr2CMIB84orTbBQRy2c6JuOj4ygnGvqfFrS97hG1oSAOr
 yY3ci6EffwG+KWNAG5ELbOxOlUXkBVPqbH1JL9pGefbsJVahoHQu7hpLrLrohr7m9CPY0ckGN8f
 pUMvAVS+bxwpc7kTIFg==
X-Authority-Analysis: v=2.4 cv=ZJvnX37b c=1 sm=1 tr=0 ts=6a0df459 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=JnKecZnUtZousrUlYMGU:22 a=VwQbUJbxAAAA:8 a=Q7TYvuNXhNawsMCuZk4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260520_105020_917673_6AB33582 
X-CRM114-Status: GOOD (  15.40  )
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

We're leaking the initial DMA mapping during iteration if we fail to
allocate the tracking descriptor for both PRP and SGL. Unmap the
iterator directly; we can't use the existing unmap helper because it
depends on the tracking descriptor being successfully allocated, so a
new one for an in-use iterator is provided.

The mappings were also leaking when the driver detects an invalid
bio_vec when mapping PRPs, so fix that too.

Fixes: b8b7570a7ec87 ("nvme-pci: fix dma unmapping when using PRPs and no=
t using the IOVA mapping")
Fixes: 7ce3c1dd78fca ("nvme-pci: convert the data mapping to blk_rq_dma_m=
ap")
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v2->v3:

  Made the same fix for metadata sgl handling, and factored out a common
  helper that data and metadata can both use.

 drivers/nvme/host/pci.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 744b388eea956..d108dbe0d4ebd 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -997,6 +997,23 @@ static bool nvme_pci_prp_iter_next(struct request *r=
eq, struct device *dma_dev,
 	return nvme_pci_prp_save_mapping(req, dma_dev, iter);
 }
=20
+static void nvme_unmap_iter(struct request *req, struct blk_dma_iter *it=
er,
+			    struct dma_iova_state *state)
+{
+	struct nvme_queue *nvmeq =3D req->mq_hctx->driver_data;
+	struct device *dev =3D nvmeq->dev->dev;
+
+	if (!blk_rq_dma_unmap(req, dev, state, iter->len, iter->p2pdma.map)) {
+		unsigned int attrs =3D 0;
+
+		if (iter->p2pdma.map =3D=3D PCI_P2PDMA_MAP_THRU_HOST_BRIDGE)
+			attrs |=3D DMA_ATTR_MMIO;
+
+		dma_unmap_phys(dev, iter->addr, iter->len, rq_dma_dir(req),
+			       attrs);
+	}
+}
+
 static blk_status_t nvme_pci_setup_data_prp(struct request *req,
 		struct blk_dma_iter *iter)
 {
@@ -1007,8 +1024,10 @@ static blk_status_t nvme_pci_setup_data_prp(struct=
 request *req,
 	unsigned int prp_len, i;
 	__le64 *prp_list;
=20
-	if (!nvme_pci_prp_save_mapping(req, nvmeq->dev->dev, iter))
+	if (!nvme_pci_prp_save_mapping(req, nvmeq->dev->dev, iter)) {
+		nvme_unmap_iter(req, iter, &iod->dma_state);
 		return iter->status;
+	}
=20
 	/*
 	 * PRP1 always points to the start of the DMA transfers.
@@ -1113,6 +1132,7 @@ static blk_status_t nvme_pci_setup_data_prp(struct =
request *req,
 	dev_err_once(nvmeq->dev->dev,
 		"Incorrectly formed request for payload:%d nents:%d\n",
 		blk_rq_payload_bytes(req), blk_rq_nr_phys_segments(req));
+	nvme_unmap_data(req);
 	return BLK_STS_IOERR;
 }
=20
@@ -1156,8 +1176,11 @@ static blk_status_t nvme_pci_setup_data_sgl(struct=
 request *req,
=20
 	sg_list =3D dma_pool_alloc(nvme_dma_pool(nvmeq, iod), GFP_ATOMIC,
 			&sgl_dma);
-	if (!sg_list)
+	if (!sg_list) {
+		nvme_unmap_iter(req, iter, &iod->dma_state);
 		return BLK_STS_RESOURCE;
+	}
+
 	iod->descriptors[iod->nr_descriptors++] =3D sg_list;
=20
 	do {
@@ -1314,8 +1337,10 @@ static blk_status_t nvme_pci_setup_meta_iter(struc=
t request *req)
=20
 	sg_list =3D dma_pool_alloc(nvmeq->descriptor_pools.small, GFP_ATOMIC,
 			&sgl_dma);
-	if (!sg_list)
+	if (!sg_list) {
+		nvme_unmap_iter(req, &iter, &iod->meta_dma_state);
 		return BLK_STS_RESOURCE;
+	}
=20
 	iod->meta_descriptor =3D sg_list;
 	iod->meta_dma =3D sgl_dma;
--=20
2.53.0-Meta


