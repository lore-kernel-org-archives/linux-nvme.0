Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3820AC83F1A
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Jul 2025 18:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7SFWLtbHkyelQ1an+E2J+fwswR7CMW0LEEdp/6uxTwQ=; b=NlBZBIz2ngVqmIwJXaRPPkMMo7
	lyjsU/Vhdzk8L+oWAvmo35GLMZBjKyjInFHQYhg4t95rxYHx4nPLsVAgYxU39KziDRsy2WxcIPrUf
	duVEQRSYSXWEhPUtwdOF0QtAi6uA8nSHnx5m420NE21bi073rBBUmDDvzU/VZrI8Z9bCcamO3M0S9
	bJATPIeMLKXjgupDSlMZBqi8uH4ryIe4Q1/K1mqdtLex7x0QHDE2sj6EMalzPy9LcgQAWyOhtPkUB
	r6cB4waBZ9nfYQWvMQDUGXW7HzX3JMP2+EJ6PayKpuRnrOH/fa1Q2sN/VqLyVDqvKHQw6QOuDC4X7
	kLBxkVNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udZ3R-0000000Fc4l-0jhu;
	Sun, 20 Jul 2025 18:46:33 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udZ10-0000000FbpC-3w0L
	for linux-nvme@lists.infradead.org;
	Sun, 20 Jul 2025 18:44:04 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 56K90DFs022250
	for <linux-nvme@lists.infradead.org>; Sun, 20 Jul 2025 11:44:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=7SFWLtbHkyelQ1an+E2J+fwswR7CMW0LEEdp/6uxTwQ=; b=qC5qJpbuz8xR
	FGS5IBRKpS3iy+ynznKauKzR0o/v/ZmD0LuQbd7PgBimdCfW04nv08GHBmPS2xWh
	kqvA8NfCjrCimW8W3xdxozTZG2/TLYQUtjruxsgDbUtljgZz2LGKU9l/WLE0fNU6
	uAuL/4JnGAorAxW/QcDF8h2psHfjAW+2GiI1ykCox+qz/LP+aUfxm1znYA1gDHuz
	FIN4zkBdUT8FqFoUQhWMxWbCpBWuIkPVQu71oLthRDiTFhOjJKlhk/gXPejfN1I9
	Riulhun5rFvywZyyTpqdWHU5lfoLnwYslmB7TSTo0/Cu3r/U1u2droptfUEEfD2h
	QKaTrsn2Dw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4806vk5u5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Sun, 20 Jul 2025 11:44:00 -0700 (PDT)
Received: from twshared4564.15.prn3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Sun, 20 Jul 2025 18:43:59 +0000
Received: by devbig1708.prn1.facebook.com (Postfix, from userid 544533)
	id 44588178C793; Sun, 20 Jul 2025 11:40:49 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <hch@lst.de>
CC: <axboe@kernel.dk>, <leonro@nvidia.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 3/7] blk-mq-dma: require unmap caller provide p2p map type
Date: Sun, 20 Jul 2025 11:40:36 -0700
Message-ID: <20250720184040.2402790-4-kbusch@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250720184040.2402790-1-kbusch@meta.com>
References: <20250720184040.2402790-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=demA3WXe c=1 sm=1 tr=0 ts=687d38f1 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=lg-0pX42I_tHtCv8E8UA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDE4MCBTYWx0ZWRfXx53qp/WreDhF dqaTKau9jUsd37+LJ8d2NEoh/BFIeDyg9IXz/xlC3OYGkXBiGLBgBbGUjtDL2/PS109VfCfZebi wqaV2ugDVt9q1w52mYTF4mNqV2GCdeu7Vv4YZ6V9wl7Vnvu1JNvRK861oNqZDca1umqmnth4uV6
 b3JtJzVZHfM+eKbWt9LxOC+hy27R5U566WaXvjE47HWoM4/njA0ShhW+yKOw9F3XmL+kZL3bVog 8vC4UKlpoNKVU7FZij3ufiLkM5GBabzrIayqp9J4bdy0sAEkIQut+N80WsQXwRf2jkxQTSwrw8F j1b2Vkhse5SZH5ey3KKnRMD6SJKXF3CDA0Ci63Bbv6eDoisV2PXEMSp/th6NeVchEgX6M1n9Yge
 k66wTLoP/CXJSn+PwmVAeD96Bw5wWn/UDgRh5sfSO3QPzNvn01kH+y4MeTiUSIJRP8ygaDjU
X-Proofpoint-ORIG-GUID: JkBdqykYJ3R-llCmDT9zmoyYY8QLcH3S
X-Proofpoint-GUID: JkBdqykYJ3R-llCmDT9zmoyYY8QLcH3S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_01,2025-07-17_02,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250720_114403_110740_895D7F34 
X-CRM114-Status: GOOD (  14.04  )
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
index 071efec25346f..6cefa8344f670 100644
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
index c2cf74be6a3d6..cdbaacc3db065 100644
--- a/include/linux/blk-mq-dma.h
+++ b/include/linux/blk-mq-dma.h
@@ -43,14 +43,15 @@ static inline bool blk_rq_dma_map_coalesce(struct dma=
_iova_state *state)
  * @dma_dev:	device to unmap from
  * @state:	DMA IOVA state
  * @mapped_len: number of bytes to unmap
+ * @p2p:	true if mapped with PCI_P2PDMA_MAP_BUS_ADDR
  *
  * Returns %false if the callers need to manually unmap every DMA segmen=
t
  * mapped using @iter or %true if no work is left to be done.
  */
 static inline bool blk_rq_dma_unmap(struct request *req, struct device *=
dma_dev,
-		struct dma_iova_state *state, size_t mapped_len)
+		struct dma_iova_state *state, size_t mapped_len, bool p2p)
 {
-	if (req->cmd_flags & REQ_P2PDMA)
+	if (p2p)
 		return true;
=20
 	if (dma_use_iova(state)) {
--=20
2.47.1


