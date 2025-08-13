Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF4BCA0EE5
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Aug 2025 16:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ATd9aLqfAuUonWisv9tjrA1ckMNkUrs5UgNGR4dDPHE=; b=y07xWBZQjy72vOEaz08QxtDz3L
	TmZ6CTfpaRNAyPxT7qW0wB7JzKNp7JNyNUMCH0A6/lsA+cKpfMAz7Tf2hOx5hyL5Y2QLgqj+IF9pM
	/3FGvsmWYvWpbrXAtNtoTq5cjUOW9YwCqdkcQp1Oyq2bhmdKfqMD7r9zuvS8ly4ctllf4ZC8UMWqR
	/bNCa437bogXf9/VX/JQA10Om1hOV1JZ3pGyCO9Zctv8qIDE7mIjkuKWbYqBkmWwFTL5ZW96z/keW
	gzLr+Qvj2QOMCbvx8SHwgVocj/Tql7tFsJUvTkezNaPAZEnR4C2TPsK1lRwoVyTKzx6QJ+4r97nMs
	uLIIoQew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umEO6-0000000EOr8-39EL;
	Wed, 13 Aug 2025 16:31:42 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umDSU-0000000ECL3-2D5B
	for linux-nvme@lists.infradead.org;
	Wed, 13 Aug 2025 15:32:11 +0000
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DFBkiB020949
	for <linux-nvme@lists.infradead.org>; Wed, 13 Aug 2025 08:32:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=ATd9aLqfAuUonWisv9tjrA1ckMNkUrs5UgNGR4dDPHE=; b=PvdfjM1tU54p
	daETPXtCet+Ui3AXYMYKOhzFdBLeM5nCxf0Nx4iPtnJ25gPCW7Y5SarzGQi6u74c
	xLhUObT/V69alk0YLVk0MvXmGE0Yanm16+AYVK4yeMZdGyL5LJQJeDfSlsuRnDkY
	GHBXunjc92zNcA4rR+YjH7GFl2/2heqKEDn4gxzlLhtzhWjNifY74Z8O2xlYzchb
	HeaZesBZ7eEsHl4d9EN81iyuf3Zm2QG6fRklAQcynwE6hTTzgsLhxAlCRvrIiV/R
	hT5Anqy/t1eeGlw2U21Wm+6QniUc8tG6Pz6bu19pqY29wjPga654fqIzAuiPGvL/
	1DK96tdt+w==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48gt29hp7j-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 13 Aug 2025 08:32:10 -0700 (PDT)
Received: from twshared24438.15.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Wed, 13 Aug 2025 15:32:04 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 7283897CD81; Wed, 13 Aug 2025 08:32:00 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv7 3/9] blk-mq-dma: require unmap caller provide p2p map type
Date: Wed, 13 Aug 2025 08:31:47 -0700
Message-ID: <20250813153153.3260897-4-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250813153153.3260897-1-kbusch@meta.com>
References: <20250813153153.3260897-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: NHHHtUI3kiyPwsI2Wy4unOAwZUsLhyEy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDE0NiBTYWx0ZWRfX7IdhLD3bA4Db iS/dhN9tzF9dmP/fbGC7ExsQBS6P6cthM/P0/34lqK9nlf5/uTewUmi2OS3EDSXHR7DffHenC5q RqNtYTOLhcjhrnfUkrvMvejJ0mnKbCgh3t3ILV+6lWDGcZo+VN4T0wM5UlOre1WGST8fCNkB8eN
 ia2afSQLz91Nxga0Ww84tKJeEH2CxmqbIdVoypL02fOol0Z7dFYeQ3znVnzozXL6e8G7J/0ah7J SBH/1lgd1u03i4ACe5f0bsWsN5BHp1IG8xAMH1qdhHKZHIjT+cHbnjpfw6lcNXaD4ZZlOfQ5chD 0pgpIRIy+mY6bifK/tMFN8WzaaiwlnLPqAEIt0aKrn9xRzvQRrf/tzcLzTdnjuzbpJnGfVPF65h
 wLOc8/H45qD5BuJwHEO9IAcFj0cOmQ4PrC+KbLV2IVE7joLbtF9fAfFZBM5i7LtYlUG7K0qm
X-Proofpoint-ORIG-GUID: NHHHtUI3kiyPwsI2Wy4unOAwZUsLhyEy
X-Authority-Analysis: v=2.4 cv=Oe+YDgTY c=1 sm=1 tr=0 ts=689caffa cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=lg-0pX42I_tHtCv8E8UA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250813_083210_574694_80562E0E 
X-CRM114-Status: GOOD (  14.97  )
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
index e5cb5e46fc928..881880095e0da 100644
--- a/include/linux/blk-mq-dma.h
+++ b/include/linux/blk-mq-dma.h
@@ -47,14 +47,15 @@ static inline bool blk_rq_dma_map_coalesce(struct dma=
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


