Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95EE8C87FD8
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Jul 2025 15:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dsr5x8qJZFXEH7GdyeAHRaxjQOPGX3vWdY3mJjxt6+4=; b=SExgT0w2pLjKVK/jtZ5cGY+pAc
	21SO/f1IDLjSnTB+1yOgfEPYZWwJDgZs5IbfzCtUeJXrq8NA/cSdh+HLpJTXMbqkULZwb94p6bBob
	mO2vh04AGeqcB4dm4BHnV9GF4OA112LU/3vkCxVYfIlme8uFlQzNsKYt2aI5n1Xrv2yoyb1eonQjT
	hBmz6Cha6fqjOq9O/vkGW6cBzD0B8Sz5/jN5GNstKPVhfqbYdNjWlJGquUAQHuDISmyW8RNtTjjWj
	lPe8O/dKHT+6fej5Bz+ScnVsfBBEpkL9c9A8jAN4MHjZYSFfjXjyhN4ONULqRUKQBnZSPUVqBJX1z
	KmeTlJQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhV5x-00000003whK-3tpA;
	Thu, 31 Jul 2025 15:21:25 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhUqT-00000003vCG-2fAY
	for linux-nvme@lists.infradead.org;
	Thu, 31 Jul 2025 15:05:26 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VE76qx030010
	for <linux-nvme@lists.infradead.org>; Thu, 31 Jul 2025 08:05:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=dsr5x8qJZFXEH7GdyeAHRaxjQOPGX3vWdY3mJjxt6+4=; b=wDdM6sZ2bbGC
	mO+nffW8Ckonlb5pxwcNnslCec6twGwwEjZ2B64tHnDJj4HiKHTduFiG9ifVegM6
	8npXw+JKssE3Zf2juSy9+PguYG6CLB2t37VMFLYWon8LrG4sZndHsS6fPcRLNlbE
	9PsLRWcpC4I0juOwS/4yjhSiscrabrhk9xoS/SkmOEc5K/u8P07CxRugdbeBwsuQ
	I7FpS6xkrY3Ckt0gvW8aJHFmAOJrkwHQuFoHDYcJe+ddLDAxxEVQ1tXPMDto8+TD
	qEWeG6zHZ6F4TTnVptViww1zBdf8LRZRlh3g+Pze4DG6yp4SQsN9LFQ/Oj5AXt7U
	w70CbNaSpA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4883m52me4-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 31 Jul 2025 08:05:24 -0700 (PDT)
Received: from twshared7571.34.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Thu, 31 Jul 2025 15:05:23 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id F2E62231DAB; Thu, 31 Jul 2025 08:05:13 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv4 3/8] blk-mq-dma: require unmap caller provide p2p map type
Date: Thu, 31 Jul 2025 08:05:08 -0700
Message-ID: <20250731150513.220395-4-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250731150513.220395-1-kbusch@meta.com>
References: <20250731150513.220395-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: GD0eo7mjB_Vev8oF55Pfxn7uEuAPE_A8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDEwMiBTYWx0ZWRfX/fnZSc3tV3N5 q16kKFmuB8VodoeSDAwpV8bT1mqVAJxQ0AHJSvHQpyagt9Da497Ey9LB+yxgOeSdxQ0sIh8Be5r SO+2KXW2h5IyiN84yniP4erNZg0vwYqrCka+zFEmh2G611WYqGj0fRRVZwYwLhKgg+0IY3ZOXfs
 FAT2MGi0EQ1MytPMXL0WBUVDeGL4zO8wsS7VP/luHSbb28ZPCaaRdTfzzNa0We1ip8i1MdJsfEH nEXDVd8FlzVjqiRlGLRlXLfJI8xJ1dZJzzQXSv+m3dbMJUpXwiBQV8lVWM4MphL8hgV05cKkL/5 j9UAe9C26Ik4BbLvzsKbuZ7UqRA5jtQZ6ih5x8c5jCKTU5GBj6jCefalyYzq+aamemD70NAieoa
 hWlwAtUCPuB2BF9PWBKUTEiZwzpT1P6bFdNye7W3nbrFUometLvA/g8zkBI/CCVy6olb3MrT
X-Authority-Analysis: v=2.4 cv=FNwbx/os c=1 sm=1 tr=0 ts=688b8634 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=lg-0pX42I_tHtCv8E8UA:9
X-Proofpoint-ORIG-GUID: GD0eo7mjB_Vev8oF55Pfxn7uEuAPE_A8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_02,2025-07-31_02,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250731_080525_794710_D567CE7D 
X-CRM114-Status: GOOD (  14.63  )
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

In preparing for integrity dma mappings, we can't rely on the request
flag because data and metadata may have different mapping types.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c    | 9 ++++++++-
 include/linux/blk-mq-dma.h | 5 +++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2c6d9506b1725..111b6bc6c93eb 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -261,6 +261,9 @@ enum nvme_iod_flags {
=20
 	/* single segment dma mapping */
 	IOD_SINGLE_SEGMENT	=3D 1U << 2,
+
+	/* DMA mapped with PCI_P2PDMA_MAP_BUS_ADDR */
+	IOD_P2P_BUS_ADDR	=3D 1U << 3,
 };
=20
 struct nvme_dma_vec {
@@ -725,7 +728,8 @@ static void nvme_unmap_data(struct request *req)
 		return;
 	}
=20
-	if (!blk_rq_dma_unmap(req, dma_dev, &iod->dma_state, iod->total_len)) {
+	if (!blk_rq_dma_unmap(req, dma_dev, &iod->dma_state, iod->total_len,
+				iod->flags & IOD_P2P_BUS_ADDR)) {
 		if (nvme_pci_cmd_use_sgl(&iod->cmd))
 			nvme_free_sgls(req);
 		else
@@ -1000,6 +1004,9 @@ static blk_status_t nvme_map_data(struct request *r=
eq)
 	if (!blk_rq_dma_map_iter_start(req, dev->dev, &iod->dma_state, &iter))
 		return iter.status;
=20
+	if (iter.p2pdma.map =3D=3D PCI_P2PDMA_MAP_BUS_ADDR)
+		iod->flags |=3D IOD_P2P_BUS_ADDR;
+
 	if (use_sgl =3D=3D SGL_FORCED ||
 	    (use_sgl =3D=3D SGL_SUPPORTED &&
 	     (sgl_threshold && nvme_pci_avg_seg_size(req) >=3D sgl_threshold)))
diff --git a/include/linux/blk-mq-dma.h b/include/linux/blk-mq-dma.h
index c82f880dee914..aef8d784952ff 100644
--- a/include/linux/blk-mq-dma.h
+++ b/include/linux/blk-mq-dma.h
@@ -49,14 +49,15 @@ static inline bool blk_rq_dma_map_coalesce(struct dma=
_iova_state *state)
  * @dma_dev:	device to unmap from
  * @state:	DMA IOVA state
  * @mapped_len: number of bytes to unmap
+ * @is_p2p:	true if mapped with PCI_P2PDMA_MAP_BUS_ADDR
  *
  * Returns %false if the callers need to manually unmap every DMA segmen=
t
  * mapped using @iter or %true if no work is left to be done.
  */
 static inline bool blk_rq_dma_unmap(struct request *req, struct device *=
dma_dev,
-		struct dma_iova_state *state, size_t mapped_len)
+		struct dma_iova_state *state, size_t mapped_len, bool is_p2p)
 {
-	if (req->cmd_flags & REQ_P2PDMA)
+	if (is_p2p)
 		return true;
=20
 	if (dma_use_iova(state)) {
--=20
2.47.3


