Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE232CA0EC1
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Aug 2025 16:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dsr5x8qJZFXEH7GdyeAHRaxjQOPGX3vWdY3mJjxt6+4=; b=3bZJg0vTXjju21PxygdROcXUCR
	0JILpVqvXdhYRQWHQb+mF08NFBluBJQ/c+yUOq2EXcjrJUrU98sgkN5TJul5vXn/yKgl0gXgKT/HR
	IEmPlvU+rwNCnibpAxU9U4uQgeYNHZdmR1hROdS4d0G1m+tKsV+yXkG9/HeH5W0ef9/5kvD28vyEQ
	/KGj7yg+RtHZUwK8TkC5ks7t2r8CLGNNdyv5h75jfD7v/wdehn7ll4sw+HFmegRrvKOzo+F+oTLvI
	hRkxNmCJCYuUsZ9cAjd8Edr7GY4nOenU0jnZqfjHcjY2TZxS6gy4H3kThj2EqKqtP6wj+npxb3H8e
	mcn4kNtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukPWg-00000003GAz-1jE8;
	Fri, 08 Aug 2025 16:01:02 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukPUU-00000003FhB-3RYN
	for linux-nvme@lists.infradead.org;
	Fri, 08 Aug 2025 15:58:48 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 578FIqjs012510
	for <linux-nvme@lists.infradead.org>; Fri, 8 Aug 2025 08:58:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=dsr5x8qJZFXEH7GdyeAHRaxjQOPGX3vWdY3mJjxt6+4=; b=rBY/Upjs+n/g
	xkZkXI6svOsqLBAlBcXypDTuVuVK6l5HEByer53KWxq5+RTrqkXlq4QnMK9FPkft
	RgWHW+HFPSRhrurgUBYeKKMOgWvcQyufAdi207pLW+K9upeaOQBCjp1dR1nRasDx
	6h1ZYnVQvf5Il92D8cmhAatVHj8gN7m4mLz+eHoR/VEO1dKHmyTNS0t7hfHnXRUj
	7ox0BqCfhYfvufDu6s5BtmB7j70WHWmnmZVjq91knCNkaks85ka6NbCnWGd5rW8j
	PxXAygdMgpWM8EqjbikacRZA3ZV/9zxF8pH+N790JtNQhbCQDkJNP1sK1NlPv/xH
	bCbc03krLw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 48d1x5xjtu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 08 Aug 2025 08:58:45 -0700 (PDT)
Received: from twshared60001.02.ash8.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Fri, 8 Aug 2025 15:58:36 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 4FC346C76C1; Fri,  8 Aug 2025 08:58:27 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv5 3/8] blk-mq-dma: require unmap caller provide p2p map type
Date: Fri, 8 Aug 2025 08:58:21 -0700
Message-ID: <20250808155826.1864803-4-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250808155826.1864803-1-kbusch@meta.com>
References: <20250808155826.1864803-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDEyOSBTYWx0ZWRfXw9d8Jja+KGRE L6lS1xqINzVlB8wdIBloBoKbOuGc+A+sT08Kdl/3naFrc8wr+/sPUtumXpXZn+naJSbSGsQP8kN 1M4NFGdzWkZRavlObgt+cKNGwr/3iWtb3ffSF34lJhUHgbCiO527mQbUB3xSYXSQZ70Ih94drw5
 jgZMGdSYODavD1gKeeiOmHTggEudxBN9qSmw0s5L3eWdbqhatNTA7xj7uKVBS5iF3VtpXb28UHI lZUnwco10ZOen0ELCftGo7Ul/yTIPxXTqReoI9uQn/dI976RkabrhJJVga0+tFxj4ZsblnD1ESX grG3uNJ2JWz32/38OPV1rMz9MYuNTjD7djQ8Mv2+wpBbhhnuoJDpfcQrgpooRuG2BR7DhWx2u3J
 85KAhlBySCkj90HvEqU/XbGTMt/YMGgWe3etw7lCBYLKdzrRf3b8JjYGQqvdJPC257ytvUnl
X-Proofpoint-GUID: hfEq9C2L61gDG9PNG0rwKm42v-aWHpYk
X-Proofpoint-ORIG-GUID: hfEq9C2L61gDG9PNG0rwKm42v-aWHpYk
X-Authority-Analysis: v=2.4 cv=R4sDGcRX c=1 sm=1 tr=0 ts=68961eb5 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=lg-0pX42I_tHtCv8E8UA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_05,2025-08-06_01,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250808_085846_972656_53FDFF16 
X-CRM114-Status: GOOD (  14.38  )
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


