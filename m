Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 908DFCD4F5B
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2026 20:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=stHP4pBXm+FgK6ERLY+JSh8vvL7qyfmqkIkL16lPmDc=; b=sSckrMLj9uP4SRrptwtXIGz7an
	P21JF1LbxKD9OtpeHeh9vRtM5n9ADWnMcfZiepc2qTSep5c1eBr/cGG4ZMpfjFKDoOwz1muh1ClNQ
	nL5GDWtocMs8q4mHOYoSiql2UJbP33aR+TGPpq1w47MNnvfRnvG9yHjCUKx5unHotI8eOtQxwoMTM
	Wu46rqpjI4k8VR4QP8UcG+zqFA+OkmElHhSjNnqnNWc0Z9VQyhgQF5PkAdohFUXvblkVjvF4MUkPr
	myBgmAO09EfKVz6iFdjXdd8Hg00PlMPpZZPaate0eQ8kDN7RTqfcjqhijP72wVYufpTLmhfE5UN98
	8jHI0ugg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPQhw-00000002gOd-0VgH;
	Tue, 19 May 2026 20:06:28 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPQht-00000002gO8-3F5C
	for linux-nvme@lists.infradead.org;
	Tue, 19 May 2026 20:06:27 +0000
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JHbJxT2000962
	for <linux-nvme@lists.infradead.org>; Tue, 19 May 2026 13:06:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=stHP4pBXm+FgK6ERLY
	+JSh8vvL7qyfmqkIkL16lPmDc=; b=GMvhEmv6GeXCkyMCNru4GUXr1eg3JQVmxA
	a4y0Rag8I81jsnro6Wkr32KaKZ4f9WoNAIOidGXjyzwDhIijvZp35LZ5IlhlN2td
	wqVKrSMcQnKm9RU9fx2Y/66U2CgDXoZp3kB+Aw7xoJs+KgryTsNs5+0H/2pF7w63
	MIkFlh5lyvACDujBhwGkSE/NERgCsLZHj0NyBB+ocVJBPLMdX3hpWPmN13BsHkTu
	bw3iBZhoMDwjIdtNenN9OzzRlTOogEgtETBhTso8/5pUcbA335Z09qEvCenNqwTi
	aTq4QaK+Pkv9Ahf1N1TWpOqdqR7gwkaRa8ioB7t/gxAkYe144Yyw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e7d6jpp0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 19 May 2026 13:06:25 -0700 (PDT)
Received: from twshared11179.02.snb2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Tue, 19 May 2026 20:06:23 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 4E8A51A7B93B4; Tue, 19 May 2026 13:06:15 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme-pci: fix dma mapping leak on data setup error
Date: Tue, 19 May 2026 13:06:14 -0700
Message-ID: <20260519200614.755159-1-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDIwMCBTYWx0ZWRfX2CjkuOzbSIBh
 8ME/5ituShm/LHyv8aUU2W3cuPkRi5D9OSLodSCItaDRs5piEmB3dqtDevjv03Tnv4Zy4sEPt3S
 aq35Qt1bP8dDCTZZEpYNMqFasUTR/jl7lzaE6vmundvQ7zp3tsBbdepZGk5SqlVh0JUfsSwki0x
 2oT0XdH5uL43n+t/ST4ek3j27M0viBwooN2gLolB73HH/zGk9tUovI6zowfA76jg0keVb2K6txc
 /qr/tSDvXs6Tw0BOOoraCd4DTAmWkQB5wABK7ZISdct0sqXQmiNwLQNgQdFCEyibilXuH3QPq1U
 5fRbvKulN9/SgZz3c2EmOpXeteLZbClPXCihUViNivgtS3GjAJfv6n1uUfXqvLn//C/f22wq4cS
 2oNB/MLrra0DE9fcY17oBFn7YjahcmRmkedymwgVUeWHl0vXZ2S5GuGkVNJWwI9ykQ2gT3ASY8L
 WIve0g/o1Cq5GoNbkDA==
X-Proofpoint-ORIG-GUID: s0WR6axtC8lAXn-nDW32uSwCR1pvDJat
X-Authority-Analysis: v=2.4 cv=B5yJFutM c=1 sm=1 tr=0 ts=6a0cc2c1 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_1IyUuN4QrATX339ibzo:22 a=VwQbUJbxAAAA:8 a=fbRKhktz8DzS-7rWtMYA:9
X-Proofpoint-GUID: s0WR6axtC8lAXn-nDW32uSwCR1pvDJat
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_05,2026-05-18_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260519_130625_878041_CEFBE21A 
X-CRM114-Status: GOOD (  13.04  )
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

Whether we're using PRP or SGL format, we're leaking the initial DMA
mapping during iteration if we fail to allocate the tracking descriptor.
Unmap it directly; we can't use the helper because it depends on the
tracking descriptor being successfully allocated.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
I apparently have a lot more systems pushing memory utilization to the
limits and finding interesting issues.

 drivers/nvme/host/pci.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 139a10cd687f9..0dbe9ad45b548 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1006,8 +1006,12 @@ static blk_status_t nvme_pci_setup_data_prp(struct=
 request *req,
 	unsigned int prp_len, i;
 	__le64 *prp_list;
=20
-	if (!nvme_pci_prp_save_mapping(req, nvmeq->dev->dev, iter))
+	if (!nvme_pci_prp_save_mapping(req, nvmeq->dev->dev, iter)) {
+		dma_unmap_phys(nvmeq->dev->dev, iter->addr, iter->len,
+			       rq_dma_dir(req),
+			       iod->flags & IOD_DATA_MMIO ? DMA_ATTR_MMIO : 0);
 		return iter->status;
+	}
=20
 	/*
 	 * PRP1 always points to the start of the DMA transfers.
@@ -1112,6 +1116,7 @@ static blk_status_t nvme_pci_setup_data_prp(struct =
request *req,
 	dev_err_once(nvmeq->dev->dev,
 		"Incorrectly formed request for payload:%d nents:%d\n",
 		blk_rq_payload_bytes(req), blk_rq_nr_phys_segments(req));
+	nvme_unmap_data(req);
 	return BLK_STS_IOERR;
 }
=20
@@ -1155,8 +1160,13 @@ static blk_status_t nvme_pci_setup_data_sgl(struct=
 request *req,
=20
 	sg_list =3D dma_pool_alloc(nvme_dma_pool(nvmeq, iod), GFP_ATOMIC,
 			&sgl_dma);
-	if (!sg_list)
+	if (!sg_list) {
+		dma_unmap_phys(nvmeq->dev->dev, iter->addr, iter->len,
+			       rq_dma_dir(req),
+			       iod->flags & IOD_DATA_MMIO ? DMA_ATTR_MMIO : 0);
 		return BLK_STS_RESOURCE;
+	}
+
 	iod->descriptors[iod->nr_descriptors++] =3D sg_list;
=20
 	do {
--=20
2.53.0-Meta


