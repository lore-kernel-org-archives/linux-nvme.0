Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B53C87FCA
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jul 2025 14:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ygphMWvAPZzH8NDnv0HqS/6M7HTBMhdXRZqUAEkSfW8=; b=OoRrndomP5W91uMSJe2DFcUuHU
	IaSffV1TPE6u6JelRp95Aq4u6lP4YRseHwZ5akRu6gVwXhh3ARmPTbZeHGDOS1rZLkv8MK4XnDTAE
	6JAQytLnrB9KXhjtG96I8O5q95QfgZAZG/aG/vzSG5t6zRO4DcFY7UQTF7kDEo5HYWFo1FeTgZhXG
	uE8Jr/yqDJLu5CIrLV1h4ErFkKuc4h3xmpWSXtXBvWZ0ojg2Rzf1qFyZqdN37iLvSiBe2EarorAN8
	J2KhxicNqTjVSe+PPYoakl8wF11rcErawOMdfulZeiMQvu1eNgtokMDdjrTnfr6of+U7IEr1qetyz
	mHMYw8cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uglQ0-0000000Guc1-3FZC;
	Tue, 29 Jul 2025 14:35:04 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uglPx-0000000GuZF-424a
	for linux-nvme@lists.infradead.org;
	Tue, 29 Jul 2025 14:35:03 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 56T7QjNa020371
	for <linux-nvme@lists.infradead.org>; Tue, 29 Jul 2025 07:35:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=ygphMWvAPZzH8NDnv0HqS/6M7HTBMhdXRZqUAEkSfW8=; b=C0gDCf+sB/a8
	gJsrHYWf8+bKJKbACHEjGljKQfRpyuCPjAnrNywF6jtf4OrwJ/CyZo+9+ARpNFAC
	TE4/x+mFyoGKivffW3yNL2o9/KM2k4/P9S+7UI/wk4SouWD9vAS8CBE7ROt/9w80
	v2Ch3CS+8Eik6MPFBwoJmZRZaFSBScRkrxE8dkvexv8OGjizlbOr2gPf58y5a/uq
	KrCE6E6YWxRu0R8fGUxL0D4NKla0MzO8Wp7NTsEQdQXwYF5NquR0tnle6GfVSPUZ
	c3CniFKg24GFoCXLKGHfaN6TEzZaT5UN1SnIIUn729RW9AA3Fq+KWq6Dsq0RoPgG
	njLUC8RcGg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 486sw62a11-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 29 Jul 2025 07:35:00 -0700 (PDT)
Received: from twshared57752.46.prn1.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 29 Jul 2025 14:34:56 +0000
Received: by devbig1708.prn1.facebook.com (Postfix, from userid 544533)
	id 2F3EE1CC4204; Tue, 29 Jul 2025 07:34:45 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <hch@lst.de>
CC: <axboe@kernel.dk>, <leonro@nvidia.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 3/7] blk-mq-dma: require unmap caller provide p2p map type
Date: Tue, 29 Jul 2025 07:34:38 -0700
Message-ID: <20250729143442.2586575-4-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250729143442.2586575-1-kbusch@meta.com>
References: <20250729143442.2586575-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: SSiOyiWaRcWc6WhTeYJr-vSVta6Y1yYw
X-Authority-Analysis: v=2.4 cv=fvbcZE4f c=1 sm=1 tr=0 ts=6888dc14 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=lg-0pX42I_tHtCv8E8UA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDExMiBTYWx0ZWRfX4r56oE5FQhQa yWbTIn+szyOfzrXjY1KYWezYWjFcsdTpY/c3H/EW2SszTj6LaacbDh3P5C82A2A3CIGUL9FgaUV 6CrlKbEf0oG+AYtBV9gXhwGt7fJ3W/+kiDUtfkUCMsppbnJW5OsOIA9y1y8sX4BmqsDOQFHqO/K
 3EfQUXKDu8ZEmnQbLJmVqnBrvraUL8FOjpehXPlemzVSg6rysrGMV/TOiLZp9dERtjbUN/kIWnH ef2uLq7CL/Bbal9bTFAiNL7SIPMwcUKNHcGdbecTH1i4RKnnkplJ7XaVnrNhBxjtcCeqoRtMJug 1TCB9L15xV7KQQhFsDw7/1IavnL4gK1+LirR/k8UMfOHxugHgRPSVNcXxo9muekCgqpK0BqPnr5
 qfRugZeKOHm5JNsAQpQWUZ/i1XUh6Ab1M4m5HrlPpsXFjNUsvqOcoSwH7oDC+cmsZaxVeHWk
X-Proofpoint-ORIG-GUID: SSiOyiWaRcWc6WhTeYJr-vSVta6Y1yYw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250729_073502_124951_E0F0DC8E 
X-CRM114-Status: GOOD (  14.51  )
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


