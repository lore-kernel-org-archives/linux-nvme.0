Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F95CD4F5B
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2026 22:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=K53buEqLo7g+OySjKvdvrsWF1DTb+1AVHZyTCMsfiCY=; b=rN94moRPQ+p+SX+FnQJ34d9TVb
	QbDvb4elM6+W/IuASZce4OpiKGWXGaZIKUjFZn90dfGWpW8Q1XyFscekVGGimKkZNQeNq461parWC
	f3nQ2TrnDVkJpioihV/+Ks/YZcsZtLyVHwIJEYO3qRgW6sj5piRjoCv5d51GEcMAlEZw61hLEQ2JI
	PtnwC3K0mrUqKftKb68suHnA9sxBQCx5OHDq40n4l9wP8c55bB0kBbYq+VGTkK4KCNCfJTxetUKm0
	uPP3MK3LCzsSpTTQL3PRdibT8T9qvBdIYX5+/88kLAuVdAArOBaB4We65Cm+r1ETVOxS/jT0dKdJt
	OdAmSfCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPT0l-00000002ycO-2R5A;
	Tue, 19 May 2026 22:34:03 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPT0i-00000002yam-2T1R
	for linux-nvme@lists.infradead.org;
	Tue, 19 May 2026 22:34:02 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JE3IRV1647048
	for <linux-nvme@lists.infradead.org>; Tue, 19 May 2026 15:34:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=K53buEqLo7g+OySjKv
	dvrsWF1DTb+1AVHZyTCMsfiCY=; b=hk3P+WjGLueE88G85RkaEOIICuvoZP8jb7
	ZIve4ahdbi1PSIJumJnESN1GpVasiht2IyF7W6Q65x56A4dn1r7xdoViJcdglUAU
	j+0PVvbMjrl7RT1tci5Jl6Qs/n+wTSluSDrqNPqM4H21QY2BxU9+p+bjVc5Pv+lD
	c2ZJV45lj1SThoAUKRsglfWMpIRXUvEPGDHAS7XJJ42GULQF6/OUpgwqeCENl2Ip
	R9nY+5M7/RlcaDVN+9906uKuFYEYnVPh68LbeA6EesA+JLNYhGc+vd4Y1czdFjQY
	TpXq7cuxF+iy2XIriRN4f0/c0GCtzQLl+ALc/EvhOUL2W6BsuyAg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e8s9ebc2n-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 19 May 2026 15:33:59 -0700 (PDT)
Received: from twshared13583.32.frc3.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Tue, 19 May 2026 22:33:43 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 0F55D1A817A0F; Tue, 19 May 2026 15:33:31 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2] nvme-pci: fix dma mapping leak on data setup error
Date: Tue, 19 May 2026 15:33:29 -0700
Message-ID: <20260519223329.1886456-1-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDIyNSBTYWx0ZWRfX61UiikYEJMkZ
 eFFh4QRCtTUKeJrN+Bwv77kCQvWU8ZEnJ49xEB/m5jkMMyP1YC2U7mG7/YQ7rXTAEuE3fjjLduf
 4XPHRDHho5w0SKN7acEmvtt1pImIz1XrGaogMfuL4jA8lXkV4E6KqiRLJrVxB7VVQabkOJ4QAxy
 pMDrmq2TVULAVqD3PA14LufsLGepVD0wZspX8i9rWUJXb+mS8qDViCPanADnhDI3MF93pmuocmC
 FKFGwxwHWIw+M0XEgizqhVkLirZ8cdFuSkBVawd9qjiBHPikchDT+BEiQcVx1ydRDmvJj6Vdb8l
 CYnBdVRWMKckDbaq1bexqkZ7748FYPvr/PF4t4y5FxTwfVVRR+qc2mWfOirWR8KBjWv3fnaYwu2
 RNJQrfnP4kGcEYd5pissXzZT0M6+f6UhLYSUl1DWSThhVVDF/hcmy0zJY4rW/05mgrjQL2BRW7h
 8AnjnTCE7jPI5/iMMJA==
X-Proofpoint-ORIG-GUID: zRF6YutHTF958QWf-d38ytzAqmx-QtTR
X-Proofpoint-GUID: zRF6YutHTF958QWf-d38ytzAqmx-QtTR
X-Authority-Analysis: v=2.4 cv=XpLK/1F9 c=1 sm=1 tr=0 ts=6a0ce557 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=crHB47gyY4rKiduisYu9:22 a=VwQbUJbxAAAA:8 a=V6YCeIl63oa-fZAVWsoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_06,2026-05-18_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260519_153400_671607_BD858387 
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
depends on the tracking descriptor being successfully allocated.

The mappings were also leaking when the driver detects an invalid
bio_vec when mapping PRPs, so fix that too.

Fixes: b8b7570a7ec87 ("nvme-pci: fix dma unmapping when using PRPs and no=
t using the IOVA mapping")
Fixes: 7ce3c1dd78fca ("nvme-pci: convert the data mapping to blk_rq_dma_m=
ap")
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2:

Check the conditions that indicate we have to unmap. We know we don't
have a coalesced iova in this path, so we can skip that, but need to
check P2P and device dma requirements. And introduce a helper function
for this so PRP and SGL don't duplicate the open coding for it.

Add fixes tags.

 drivers/nvme/host/pci.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 139a10cd687f9..c0de3b4afd072 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -996,6 +996,18 @@ static bool nvme_pci_prp_iter_next(struct request *r=
eq, struct device *dma_dev,
 	return nvme_pci_prp_save_mapping(req, dma_dev, iter);
 }
=20
+static void nvme_unmap_iter(struct request *req, struct blk_dma_iter *it=
er)
+{
+	struct nvme_queue *nvmeq =3D req->mq_hctx->driver_data;
+	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
+
+	if (iod->flags & IOD_DATA_P2P || !dma_need_unmap(dev))
+		return;
+
+	dma_unmap_phys(nvmeq->dev->dev, iter->addr, iter->len, rq_dma_dir(req),
+		       iod->flags & IOD_DATA_MMIO ? DMA_ATTR_MMIO : 0);
+}
+
 static blk_status_t nvme_pci_setup_data_prp(struct request *req,
 		struct blk_dma_iter *iter)
 {
@@ -1006,8 +1018,10 @@ static blk_status_t nvme_pci_setup_data_prp(struct=
 request *req,
 	unsigned int prp_len, i;
 	__le64 *prp_list;
=20
-	if (!nvme_pci_prp_save_mapping(req, nvmeq->dev->dev, iter))
+	if (!nvme_pci_prp_save_mapping(req, nvmeq->dev->dev, iter)) {
+		nvme_unmap_iter(req, iter);
 		return iter->status;
+	}
=20
 	/*
 	 * PRP1 always points to the start of the DMA transfers.
@@ -1112,6 +1126,7 @@ static blk_status_t nvme_pci_setup_data_prp(struct =
request *req,
 	dev_err_once(nvmeq->dev->dev,
 		"Incorrectly formed request for payload:%d nents:%d\n",
 		blk_rq_payload_bytes(req), blk_rq_nr_phys_segments(req));
+	nvme_unmap_data(req);
 	return BLK_STS_IOERR;
 }
=20
@@ -1155,8 +1170,11 @@ static blk_status_t nvme_pci_setup_data_sgl(struct=
 request *req,
=20
 	sg_list =3D dma_pool_alloc(nvme_dma_pool(nvmeq, iod), GFP_ATOMIC,
 			&sgl_dma);
-	if (!sg_list)
+	if (!sg_list) {
+		nvme_unmap_iter(req, iter);
 		return BLK_STS_RESOURCE;
+	}
+
 	iod->descriptors[iod->nr_descriptors++] =3D sg_list;
=20
 	do {
--=20
2.53.0-Meta


