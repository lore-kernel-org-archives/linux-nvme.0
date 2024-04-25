Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7686C4345F
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Apr 2024 18:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F00u05YI6eiHNm55/ntjfplIagvFXf11AolOIQtFnGQ=; b=h0exsMx6yd0A8YUxi51ghM4710
	t9NomyZgwKPfMJ2NrwdclMSSkKKFLQqoJ33a1fndSTkVLnGQSxxLjDYUpEgqeJfFI/i5tmJvfj2UH
	RwzXc/8t4rPWHF5Yh1auj4e5im4tb2qAYdn6iYkhjtTxzycVp/ZN/XFPPIYe11kl2VQ2hXp/eTwVc
	Ro4SQVHW5cjXbxWuTcQBpvZZ4TH9Rg12697Zef8v0tVHHwQUbSQANxc108G94CtfSVU0uaPDBd24+
	TX8tkGD+DkfnZOHKXev6ZsWCodRhtJCwL550LlzrQLslKmxllpvzLCY7YKRMfFBDl+IIduPZvU4mU
	eCXmqLDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s047r-00000009lv8-2bCx;
	Thu, 25 Apr 2024 18:47:19 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s047h-00000009lnE-2tgo
	for linux-nvme@lists.infradead.org;
	Thu, 25 Apr 2024 18:47:13 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240425184703epoutp0147ed7dcf7656a9ef4a6a6317fd80f862~JmlUI0-Qi0066600666epoutp01z
	for <linux-nvme@lists.infradead.org>; Thu, 25 Apr 2024 18:47:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240425184703epoutp0147ed7dcf7656a9ef4a6a6317fd80f862~JmlUI0-Qi0066600666epoutp01z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1714070823;
	bh=F00u05YI6eiHNm55/ntjfplIagvFXf11AolOIQtFnGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UIFbaquYzDBut4jLHtkt+SGi9Lb4+8I5RCLF6atf2TSnanltN0ZiO+1YHJRfCHoqh
	 zmB5NKf8ekf7HqSNlm2K7THGN2eT2YS2V4InT8FyksvSSMKIZq0RnZBcUu0WWkIFdu
	 CQimUtSx2qb0pM8C+IjoJdwZYbZQ2zvshgf4HhFE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240425184702epcas5p2b41c1145228a485e2883078343720f64~JmlTWAB0j1620416204epcas5p2J;
	Thu, 25 Apr 2024 18:47:02 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4VQPwN4g50z4x9Pt; Thu, 25 Apr
	2024 18:47:00 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	64.C1.09666.425AA266; Fri, 26 Apr 2024 03:47:00 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240425184700epcas5p1687590f7e4a3f3c3620ac27af514f0ca~JmlRRXjxl1328213282epcas5p1M;
	Thu, 25 Apr 2024 18:47:00 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240425184700epsmtrp260d58501356653291e5003ddd22fb1f8~JmlRQnl8X0238902389epsmtrp2d;
	Thu, 25 Apr 2024 18:47:00 +0000 (GMT)
X-AuditID: b6c32a49-f53fa700000025c2-1f-662aa52491d9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	6F.C2.19234.325AA266; Fri, 26 Apr 2024 03:47:00 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240425184658epsmtip1ffeb5676217af8158896c1660e49b425~JmlPcCPj-0041100411epsmtip1l;
	Thu, 25 Apr 2024 18:46:58 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, martin.petersen@oracle.com, kbusch@kernel.org,
	hch@lst.de, brauner@kernel.org
Cc: asml.silence@gmail.com, dw@davidwei.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta
	<anuj20.g@samsung.com>
Subject: [PATCH 05/10] block, nvme: modify rq_integrity_vec function
Date: Fri, 26 Apr 2024 00:09:38 +0530
Message-Id: <20240425183943.6319-6-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240425183943.6319-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIJsWRmVeSWpSXmKPExsWy7bCmhq7KUq00gz0v5C2aJvxltpizahuj
	xeq7/WwWrw9/YrR4NWMtm8XNAzuZLFauPspk8a71HIvF0f9v2SwmHbrGaLH3lrbF/GVP2S2W
	H//H5MDrcW3GRBaPnbPusntcPlvqsWlVJ5vH5iX1HrtvNrB5fHx6i8Wjb8sqRo/Pm+QCOKOy
	bTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOArlZSKEvM
	KQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgU6BUn5haX5qXr5aWWWBkaGBiZAhUmZGfM
	XdvHVvBcvGLJKYkGxr/CXYycHBICJhJvjhxj7WLk4hAS2M0o8aZrEguE84lRYsvxQ2xwzuut
	N1hhWiZfeMEIYgsJ7GSU2H8uDqLoM6PEiXNvgIo4ONgENCUuTC4FqRERSJF4te41I0gNs8BT
	Rok9X28ygSSEBVwknrzoBhvKIqAqcetNG1icV8Bc4uTijSwQy+QlZl76zg5icwpYSEy+eJod
	okZQ4uTMJ2A1zEA1zVtnM4MskBBYySFx7dwaJohmF4lvc9dBXS0s8er4FnYIW0ri87u9bBB2
	ssSlmeeg6kskHu85CGXbS7Se6mcGeYYZ6Jn1u/QhdvFJ9P5+wgQSlhDglehoE4KoVpS4N+kp
	1CZxiYczlkDZHhKv205AQ7SbUeLR1JvsExjlZyF5YRaSF2YhbFvAyLyKUTK1oDg3PbXYtMAw
	L7UcHq/J+bmbGMFpV8tzB+PdBx/0DjEycTAeYpTgYFYS4b35USNNiDclsbIqtSg/vqg0J7X4
	EKMpMIwnMkuJJucDE39eSbyhiaWBiZmZmYmlsZmhkjjv69a5KUIC6YklqdmpqQWpRTB9TByc
	Ug1MVduK72SdSn5tyrEz413esTsLj6dMk5gTpRSb9PZ47XExw4n3lBLeT9qxu3LHdzvD/dfM
	ZZNWr1DfOXGrxfIw76bsKaUzPi56fvZryfWzYnM02uXZbnDv5rgaXNK40r0rY/+qbZLH6h93
	8M9M///kZYfwQ+tNghF3kg6kJmuzRkyc5Si16vkZtQX3XtuvT155bRqH/S3R1s7L69Jntb7i
	taze71h6J2Xf9Ion605xnApuPSn1onHnjvencjXXV+fLCqydI5tW/ksy62LItgtnj8y+Y5h3
	kO9pTY7b/rTEx1pdqx5nFga5+fPt9W/8rjg7+O4KtZnZ3MxtoYVeiesdtQs2zAgI+D5hZdS7
	LI7iKiWW4oxEQy3mouJEALqwLQdEBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsWy7bCSnK7KUq00g9mtjBZNE/4yW8xZtY3R
	YvXdfjaL14c/MVq8mrGWzeLmgZ1MFitXH2WyeNd6jsXi6P+3bBaTDl1jtNh7S9ti/rKn7BbL
	j/9jcuD1uDZjIovHzll32T0uny312LSqk81j85J6j903G9g8Pj69xeLRt2UVo8fnTXIBnFFc
	NimpOZllqUX6dglcGXPX9rEVPBevWHJKooHxr3AXIyeHhICJxOQLLxi7GLk4hAS2M0rsn3Ce
	ESIhLtF87Qc7hC0ssfLfczBbSOAjo8Tt1S5djBwcbAKaEhcml4KERQSyJPb2X2EHmcMs8JZR
	YtvSlWwgCWEBF4knL7pZQWwWAVWJW2/amEBsXgFziZOLN7JAzJeXmHnpO9h8TgELickXT0Pt
	MpeYumYRI0S9oMTJmU/A6pmB6pu3zmaewCgwC0lqFpLUAkamVYyiqQXFuem5yQWGesWJucWl
	eel6yfm5mxjBkaIVtINx2fq/eocYmTgYDzFKcDArifDe/KiRJsSbklhZlVqUH19UmpNafIhR
	moNFSZxXOaczRUggPbEkNTs1tSC1CCbLxMEp1cC0njty4ovvLUxfxB1dir6yPzjz6MbC7bvu
	nBJcenNq8Yl4g9yJjYkW1Srv8mX5rk3ZMdHSx9mgpmKy2pxDVudMVrm6WDvvUJ/WHT9h/eeZ
	ByZm2WRu6N7++fvc1M0djaoK+8Kv5rHUiW7LWf6es/bS1ttymQf71qpMd98b+pEp6ozyPzZH
	r4CyzaHCip8jXS7f2PdlxfQPjz77sa9Yk3T/2Mun/27q6rVVcnZsPSbaGykqW9nc8nb5zvjz
	e5Pd3r//vGeKm39ngsMt7jPpE5Xtnpnkznrm9URn28m929VnxnwxzWf58XDW9Ct5m49zWr9N
	T1zw59jZo/LcHLtaAmRvyLskRr7MlpJvfL+GpSufSYmlOCPRUIu5qDgRAFle4/MDAwAA
X-CMS-MailID: 20240425184700epcas5p1687590f7e4a3f3c3620ac27af514f0ca
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240425184700epcas5p1687590f7e4a3f3c3620ac27af514f0ca
References: <20240425183943.6319-1-joshi.k@samsung.com>
	<CGME20240425184700epcas5p1687590f7e4a3f3c3620ac27af514f0ca@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240425_114710_114134_8C5DF3FB 
X-CRM114-Status: GOOD (  20.28  )
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

rq_integrity_vec always returns the first bio_vec, and does not take
bip_iter into consideration.
Modify it so that it does. This is similar to how req_bvec() works for
data buffers.

This is necessary for correct dma map/unmap of meta buffer when it was
split in the block layer.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/pci.c       |  9 +++++----
 include/linux/blk-integrity.h | 13 +++++++------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8e0bb9692685..bc5177ea6330 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -825,9 +825,9 @@ static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req,
 		struct nvme_command *cmnd)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	struct bio_vec bv = rq_integrity_vec(req);
 
-	iod->meta_dma = dma_map_bvec(dev->dev, rq_integrity_vec(req),
-			rq_dma_dir(req), 0);
+	iod->meta_dma = dma_map_bvec(dev->dev, &bv, rq_dma_dir(req), 0);
 	if (dma_mapping_error(dev->dev, iod->meta_dma))
 		return BLK_STS_IOERR;
 	cmnd->rw.metadata = cpu_to_le64(iod->meta_dma);
@@ -964,9 +964,10 @@ static __always_inline void nvme_pci_unmap_rq(struct request *req)
 
 	if (blk_integrity_rq(req)) {
 	        struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+		struct bio_vec bv = rq_integrity_vec(req);
 
-		dma_unmap_page(dev->dev, iod->meta_dma,
-			       rq_integrity_vec(req)->bv_len, rq_dma_dir(req));
+		dma_unmap_page(dev->dev, iod->meta_dma, bv.bv_len,
+			       rq_dma_dir(req));
 	}
 
 	if (blk_rq_nr_phys_segments(req))
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
index e253e7bd0d17..9223050c0f75 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -109,11 +109,12 @@ static inline bool blk_integrity_rq(struct request *rq)
  * Return the first bvec that contains integrity data.  Only drivers that are
  * limited to a single integrity segment should use this helper.
  */
-static inline struct bio_vec *rq_integrity_vec(struct request *rq)
+static inline struct bio_vec rq_integrity_vec(struct request *rq)
 {
-	if (WARN_ON_ONCE(queue_max_integrity_segments(rq->q) > 1))
-		return NULL;
-	return rq->bio->bi_integrity->bip_vec;
+	WARN_ON_ONCE(queue_max_integrity_segments(rq->q) > 1);
+
+	return mp_bvec_iter_bvec(rq->bio->bi_integrity->bip_vec,
+				 rq->bio->bi_integrity->bip_iter);
 }
 #else /* CONFIG_BLK_DEV_INTEGRITY */
 static inline int blk_rq_count_integrity_sg(struct request_queue *q,
@@ -177,9 +178,9 @@ static inline int blk_integrity_rq(struct request *rq)
 	return 0;
 }
 
-static inline struct bio_vec *rq_integrity_vec(struct request *rq)
+static inline struct bio_vec rq_integrity_vec(struct request *rq)
 {
-	return NULL;
+	return (struct bio_vec){0};
 }
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
 #endif /* _LINUX_BLK_INTEGRITY_H */
-- 
2.25.1


