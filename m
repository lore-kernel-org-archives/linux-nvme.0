Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58326CA0EDF
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Aug 2025 17:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kcoo5840AGoxNXqmlM7GRSvPqwN2LEc1uL+j011rAsk=; b=4DQbxCEUk+Jp0G4tuZOVJs3zEo
	a3sKA7Op/TJwNGk8D2IKZKiFcbIDmYY2cD0R9TTbUglgKYVyU+pE5FDZdDaleS1ubR7zWsglHzIia
	Vvi9LVUPnMedF1X1kP0k0vINPR6CWOm4wpJoRzuCkku8FbZ7+mnu97zdZCtMekZs3NqJeZuEy0U3l
	EsefzVHsXblvbFBZXDov/ZD0xTj3ixZvLutroH2ylxhnRP0wojEHqrEnIdHOhO95hkJTXCjzK8t6G
	XkME0Q0+xe1m6rg8o38GHhuzdx6dTYYS5qStR2fqNxKOauUk+admXR5cZBzdm1mLmHfyGkBEXAgXa
	RYgLcE3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulst3-0000000Bbe5-2xJ4;
	Tue, 12 Aug 2025 17:34:13 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulpSI-0000000Az2T-35eC
	for linux-nvme@lists.infradead.org;
	Tue, 12 Aug 2025 13:54:23 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDpjkl006845
	for <linux-nvme@lists.infradead.org>; Tue, 12 Aug 2025 06:54:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=Kcoo5840AGoxNXqmlM7GRSvPqwN2LEc1uL+j011rAsk=; b=YxDRUNBs+8Kt
	9n2DSxN8s1S7D3CaC1nN3fFvvS0HQZS6iJ/SQtCnhKKPC5m+7KVXXnEJhNeIrTbc
	JqSLOasBNizCWWMkC2flpTprzRLuapJXxZYFzS6IqcK8pEKQSTMxOTwqsTDdlp3+
	7DlEpKUlrNzIjbeLMV9u7tyKN1schfrrhNiDr3yx21R1dSEY8nbXbDHLtob6VonN
	0+MwQweR3JwNLljDc7yxN4IUUHVko4K6Iggpz7kWQ1d6ZyJokQ82xkhTC1nIbxpB
	0FXStiZwfzEjj33hqqPOTUVO2YW/oJdMbiHT1Y7KpeM5sGkmzHCBQlmgDUrL6EDC
	xY/SvxT2tQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48g120b14n-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 12 Aug 2025 06:54:21 -0700 (PDT)
Received: from twshared71707.17.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 12 Aug 2025 13:52:23 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 9D2388D407A; Tue, 12 Aug 2025 06:52:11 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv6 3/8] blk-mq-dma: require unmap caller provide p2p map type
Date: Tue, 12 Aug 2025 06:52:05 -0700
Message-ID: <20250812135210.4172178-4-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250812135210.4172178-1-kbusch@meta.com>
References: <20250812135210.4172178-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=KJdaDEFo c=1 sm=1 tr=0 ts=689b478d cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=lg-0pX42I_tHtCv8E8UA:9
X-Proofpoint-ORIG-GUID: 7_QWVZ5c0StUo9l-QLMiHUBWS4yXxQUN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDEzNCBTYWx0ZWRfXwuwd+hDRhpUl 8wvuWqilxSJufwFpodqBbcPfsYbNoUrUGyf/ExwEnR3GKGIuDE1FRbyJubZSi8MpJzckX0I36v8 5TvCLnLCj0/yucOCjKLhszJ4EYb6hojN5paid51Zyz/NXyREexAGzcAphCVVJMTkOsz3zxzJU7W
 mqGOmVzDQp3B90aeHa/cxsiV01vE6vIQ4+zyx1Fxj9VoapjJicdau3oVn6eWzb1p3FDOXZXGOc0 ZFz+sGn0TS2DS70/YNlCptSFExgM80EYJfHjjDc5k43TxWNYgpSJIvXrdOPhE61pCAe1ze2EBVO 9j5RkoLqM1diitEQ+0QbpWFQk2KaQhhtkHPAEDXEiRWRLhHYYEnXAUg4jBsGKvQynMyX1MOMJwe
 eux605H5XnHyIRCYL1r5upuIDVgq1K17BJTwFV2LFtUO+isVG+9ZXRhiyqkxSAjskHbePaHN
X-Proofpoint-GUID: 7_QWVZ5c0StUo9l-QLMiHUBWS4yXxQUN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_065422_895758_1F7E8052 
X-CRM114-Status: GOOD (  15.45  )
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
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


