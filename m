Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27FA1CA1013
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Sep 2025 23:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=40j+UgwEuN3AtV/CDpkJ+OWLMkFVQ8v0JC761N1WWjQ=; b=ot94JIXj8yT7t4MHY0KwDkoS/q
	hUWQvI5WWKMEW6cZxlKncggbnLJQmay8oPCyim6i5ISBdS3a6jsdNsI2cBXaRPpiB3SzKOwVObDbu
	UDu64tyfFkjSjGJvu9CnG0SHuQabnEE5pmrrkDBwp6HG6LB5FYE6LwzYGInK65rOOzoOMxjE8BzqS
	SjDwOMwiTwhisHk+cAgGYNLdyG0uvt2hEFYN7vyl8xHCsRqS3ciVlrmUGhD9WChTCjpukPntCrTwC
	uK6uM/yU2EiWXB/aSUvJLjOmXI4eA46banWCtYY34pZ9dsVmnyG1D3yXGc6Ro5yhHW2zRITHsxe9r
	WNC9bh8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utwhp-00000007tDb-0hLn;
	Wed, 03 Sep 2025 23:15:57 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uttEV-00000007SsJ-1tAo
	for linux-nvme@lists.infradead.org;
	Wed, 03 Sep 2025 19:33:28 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 583J8AKu3661896
	for <linux-nvme@lists.infradead.org>; Wed, 3 Sep 2025 12:33:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=40j+UgwEuN3AtV/CDpkJ+OWLMkFVQ8v0JC761N1WWjQ=; b=DEGPCxNxxAm7
	4KLk3/udVaEzXEZoA5mwBFJAQpiWpt9krXcvk0sIDw3KVQJ8Jll/pdoJscEhQueT
	QRPoHt0bwJyeTAZBuS4EWMkPiJqdFrqYUnLCV+EMx71MWbQF/x00OyeGCs6LTeP/
	g7Ayluk1EQY06tMEvRCnJLQl9/Awn3++xiPv1gO9TOf84s1jDu4AXR7ajq9Yl4lp
	e9GPWp/jqb+rUQ10BPeCSlXTWXKxsUodZoqga/flMHPfssLCP0JybhnSm3FI9ox4
	xDz/zEKppDNxedWiFNHw5QKiidF0BUBiXriIkee1uwaabyZuZlGkIMm1utj0j8Vb
	77AH/Ja1Tg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48xqt7jdpc-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 03 Sep 2025 12:33:26 -0700 (PDT)
Received: from twshared21625.15.frc2.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Wed, 3 Sep 2025 19:33:21 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id CC84C14CE624; Wed,  3 Sep 2025 12:33:17 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <martin.petersen@oracle.com>,
        <jgg@nvidia.com>, <leon@kernel.org>, Keith Busch <kbusch@kernel.org>,
        Leon
 Romanovsky <leonro@nvidia.com>
Subject: [PATCHv3 2/2] blk-mq-dma: bring back p2p request flags
Date: Wed, 3 Sep 2025 12:33:17 -0700
Message-ID: <20250903193317.3185435-3-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250903193317.3185435-1-kbusch@meta.com>
References: <20250903193317.3185435-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDE5NiBTYWx0ZWRfX7PaFTAYkqC6T
 GX8I+g1/iHj7uNqAcEibM6mX7g2nnTGLEj/rQYXU3WyfCQrCF98A8giING8/C+A0P7XhKSbXeWy
 xAIgy8i3EFfW39IZCOBoxm9CCJ6pEIpfx4UOcGIeGrmo/xFbRDYG0rGWLst3ULw7SXrb9u6Ft9u
 4s8eH3/W46HIjAAaWaHSccaeu9Re42iRuag6gPFhoSTdpnOZrHsG03WYxTXZSS2CTX7bHwlkrVo
 lNx3DTEe6NAcJjN4NnW6Q4O9AntwFO28v7UnfvxTO+y29vKVVMSM7zPpNxo59PqKM1XTm3YH2n1
 vHtqGiKMWb+TSaf8EsxhfeLHvpCErEr50pUHOSuWJEUT1rzm55gbDCG0MtSYd4=
X-Authority-Analysis: v=2.4 cv=LZ886ifi c=1 sm=1 tr=0 ts=68b89806 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=Ikd4Dj_1AAAA:8
 a=KeZPkw9lY6AM_2-iRd4A:9
X-Proofpoint-GUID: ixh2bcDbQN4OVK_4Erz2qrGBy5PdOzs1
X-Proofpoint-ORIG-GUID: ixh2bcDbQN4OVK_4Erz2qrGBy5PdOzs1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_09,2025-08-28_01,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250903_123327_608163_19A7F2A0 
X-CRM114-Status: GOOD (  22.16  )
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

We only need to consider data and metadata dma mapping types separately.
The request and bio integrity payload have enough flag bits to
internally track the mapping type for each. Use these so the caller
doesn't need to track them, and provide separete request and integrity
helpers to the common code. This will make it easier to scale new
mappings, like the proposed MMIO attribute, without burdening the caller
to track such things.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq-dma.c            |  4 ++++
 drivers/nvme/host/pci.c       | 21 ++++-----------------
 include/linux/bio-integrity.h |  1 +
 include/linux/blk-integrity.h | 15 +++++++++++++++
 include/linux/blk-mq-dma.h    | 11 +++++++++--
 include/linux/blk_types.h     |  2 ++
 6 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 660b5e200ccf6..449950029872a 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -174,6 +174,10 @@ static bool blk_dma_map_iter_start(struct request *r=
eq, struct device *dma_dev,
 	switch (pci_p2pdma_state(&iter->p2pdma, dma_dev,
 				 phys_to_page(vec.paddr))) {
 	case PCI_P2PDMA_MAP_BUS_ADDR:
+		if (iter->iter.is_integrity)
+			bio_integrity(req->bio)->bip_flags |=3D BIP_P2P_DMA;
+		else
+			req->cmd_flags |=3D REQ_P2PDMA;
 		return blk_dma_map_bus(iter, &vec);
 	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
 		/*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d8a9dee55de33..28e203b894eb1 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -260,12 +260,6 @@ enum nvme_iod_flags {
 	/* single segment dma mapping */
 	IOD_SINGLE_SEGMENT	=3D 1U << 2,
=20
-	/* DMA mapped with PCI_P2PDMA_MAP_BUS_ADDR */
-	IOD_P2P_BUS_ADDR	=3D 1U << 3,
-
-	/* Metadata DMA mapped with PCI_P2PDMA_MAP_BUS_ADDR */
-	IOD_META_P2P_BUS_ADDR	=3D 1U << 4,
-
 	/* Metadata using non-coalesced MPTR */
 	IOD_SINGLE_META_SEGMENT	=3D 1U << 5,
 };
@@ -737,9 +731,8 @@ static void nvme_unmap_metadata(struct request *req)
 		return;
 	}
=20
-	if (!blk_rq_dma_unmap(req, dma_dev, &iod->meta_dma_state,
-				iod->meta_total_len,
-				iod->flags & IOD_META_P2P_BUS_ADDR)) {
+	if (!blk_rq_integrity_dma_unmap(req, dma_dev, &iod->meta_dma_state,
+					iod->meta_total_len)) {
 		if (nvme_pci_cmd_use_meta_sgl(&iod->cmd))
 			nvme_free_sgls(req, sge, &sge[1]);
 		else
@@ -766,8 +759,7 @@ static void nvme_unmap_data(struct request *req)
 		return;
 	}
=20
-	if (!blk_rq_dma_unmap(req, dma_dev, &iod->dma_state, iod->total_len,
-				iod->flags & IOD_P2P_BUS_ADDR)) {
+	if (!blk_rq_dma_unmap(req, dma_dev, &iod->dma_state, iod->total_len)) {
 		if (nvme_pci_cmd_use_sgl(&iod->cmd))
 			nvme_free_sgls(req, iod->descriptors[0],
 				       &iod->cmd.common.dptr.sgl);
@@ -1043,9 +1035,6 @@ static blk_status_t nvme_map_data(struct request *r=
eq)
 	if (!blk_rq_dma_map_iter_start(req, dev->dev, &iod->dma_state, &iter))
 		return iter.status;
=20
-	if (iter.p2pdma.map =3D=3D PCI_P2PDMA_MAP_BUS_ADDR)
-		iod->flags |=3D IOD_P2P_BUS_ADDR;
-
 	if (use_sgl =3D=3D SGL_FORCED ||
 	    (use_sgl =3D=3D SGL_SUPPORTED &&
 	     (sgl_threshold && nvme_pci_avg_seg_size(req) >=3D sgl_threshold)))
@@ -1068,9 +1057,7 @@ static blk_status_t nvme_pci_setup_meta_sgls(struct=
 request *req)
 						&iod->meta_dma_state, &iter))
 		return iter.status;
=20
-	if (iter.p2pdma.map =3D=3D PCI_P2PDMA_MAP_BUS_ADDR)
-		iod->flags |=3D IOD_META_P2P_BUS_ADDR;
-	else if (blk_rq_dma_map_coalesce(&iod->meta_dma_state))
+	if (blk_rq_dma_map_coalesce(&iod->meta_dma_state))
 		entries =3D 1;
=20
 	/*
diff --git a/include/linux/bio-integrity.h b/include/linux/bio-integrity.=
h
index 0a25716820fe0..851254f36eb36 100644
--- a/include/linux/bio-integrity.h
+++ b/include/linux/bio-integrity.h
@@ -13,6 +13,7 @@ enum bip_flags {
 	BIP_CHECK_GUARD		=3D 1 << 5, /* guard check */
 	BIP_CHECK_REFTAG	=3D 1 << 6, /* reftag check */
 	BIP_CHECK_APPTAG	=3D 1 << 7, /* apptag check */
+	BIP_P2P_DMA		=3D 1 << 8, /* using P2P address */
 };
=20
 struct bio_integrity_payload {
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.=
h
index 78fe2459e6612..b659373788f60 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -27,6 +27,15 @@ static inline bool queue_limits_stack_integrity_bdev(s=
truct queue_limits *t,
=20
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 int blk_rq_map_integrity_sg(struct request *, struct scatterlist *);
+
+static inline bool blk_rq_integrity_dma_unmap(struct request *req,
+		struct device *dma_dev, struct dma_iova_state *state,
+		size_t mapped_len)
+{
+	return blk_dma_unmap(req, dma_dev, state, mapped_len,
+			bio_integrity(req->bio)->bip_flags & BIP_P2P_DMA);
+}
+
 int blk_rq_count_integrity_sg(struct request_queue *, struct bio *);
 int blk_rq_integrity_map_user(struct request *rq, void __user *ubuf,
 			      ssize_t bytes);
@@ -115,6 +124,12 @@ static inline int blk_rq_map_integrity_sg(struct req=
uest *q,
 {
 	return 0;
 }
+static inline bool blk_rq_integrity_dma_unmap(struct request *req,
+		struct device *dma_dev, struct dma_iova_state *state,
+		size_t mapped_len)
+{
+	return false;
+}
 static inline int blk_rq_integrity_map_user(struct request *rq,
 					    void __user *ubuf,
 					    ssize_t bytes)
diff --git a/include/linux/blk-mq-dma.h b/include/linux/blk-mq-dma.h
index 0f45ea110ca12..51829958d8729 100644
--- a/include/linux/blk-mq-dma.h
+++ b/include/linux/blk-mq-dma.h
@@ -43,7 +43,7 @@ static inline bool blk_rq_dma_map_coalesce(struct dma_i=
ova_state *state)
 }
=20
 /**
- * blk_rq_dma_unmap - try to DMA unmap a request
+ * blk_dma_unmap - try to DMA unmap a request
  * @req:	request to unmap
  * @dma_dev:	device to unmap from
  * @state:	DMA IOVA state
@@ -53,7 +53,7 @@ static inline bool blk_rq_dma_map_coalesce(struct dma_i=
ova_state *state)
  * Returns %false if the callers need to manually unmap every DMA segmen=
t
  * mapped using @iter or %true if no work is left to be done.
  */
-static inline bool blk_rq_dma_unmap(struct request *req, struct device *=
dma_dev,
+static inline bool blk_dma_unmap(struct request *req, struct device *dma=
_dev,
 		struct dma_iova_state *state, size_t mapped_len, bool is_p2p)
 {
 	if (is_p2p)
@@ -68,4 +68,11 @@ static inline bool blk_rq_dma_unmap(struct request *re=
q, struct device *dma_dev,
 	return !dma_need_unmap(dma_dev);
 }
=20
+static inline bool blk_rq_dma_unmap(struct request *req, struct device *=
dma_dev,
+		struct dma_iova_state *state, size_t mapped_len)
+{
+	return blk_dma_unmap(req, dma_dev, state, mapped_len,
+				req->cmd_flags & REQ_P2PDMA);
+}
+
 #endif /* BLK_MQ_DMA_H */
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 930daff207df2..09b99d52fd365 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -386,6 +386,7 @@ enum req_flag_bits {
 	__REQ_DRV,		/* for driver use */
 	__REQ_FS_PRIVATE,	/* for file system (submitter) use */
 	__REQ_ATOMIC,		/* for atomic write operations */
+	__REQ_P2PDMA,		/* contains P2P DMA pages */
 	/*
 	 * Command specific flags, keep last:
 	 */
@@ -418,6 +419,7 @@ enum req_flag_bits {
 #define REQ_DRV		(__force blk_opf_t)(1ULL << __REQ_DRV)
 #define REQ_FS_PRIVATE	(__force blk_opf_t)(1ULL << __REQ_FS_PRIVATE)
 #define REQ_ATOMIC	(__force blk_opf_t)(1ULL << __REQ_ATOMIC)
+#define REQ_P2PDMA	(__force blk_opf_t)(1ULL << __REQ_P2PDMA)
=20
 #define REQ_NOUNMAP	(__force blk_opf_t)(1ULL << __REQ_NOUNMAP)
=20
--=20
2.47.3


