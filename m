Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636BBC19F4E
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Apr 2024 18:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GpaNMWMqzUtQKOveThTCzAl0+LvJX9/CNL8Eg2zqipA=; b=ERiR+zw+ldkoX4nDUOgIY62iXV
	3MZtUaTO9oqIL5b+94I/mn9DcsZ2KAZCF4sq5xt5tmb42CyXwJClnWHEotGiycsgEZbWMvHCjzkjs
	fEWhxW6CPiP7QsC9LzT24bnLZ/PH80LtavbspoOyWw6pciFa7HmsRF4B4avDKS+0BDZm8lH8xmiZs
	iKlvIe2HVLkzBYzCNqNSHFC0F30A9UhDYc82v8CNMrPvxevhx4qXb1bu9WE/5YCIgOBXehduomxzK
	q20b4qnBBXCXo9+9ENMJb48pArGbtyFOerRKBPcqUjqJwhTz/VBn4wA6Of+Y6F+XmRzcRg9/OKE9d
	aNrmRIBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s047z-00000009m1m-34Cc;
	Thu, 25 Apr 2024 18:47:27 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s047m-00000009lrE-1qx0
	for linux-nvme@lists.infradead.org;
	Thu, 25 Apr 2024 18:47:17 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240425184712epoutp0442bcfa6271cd5b6b603c5465ac3fafdc~Jmlc31CBp0442104421epoutp04d
	for <linux-nvme@lists.infradead.org>; Thu, 25 Apr 2024 18:47:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240425184712epoutp0442bcfa6271cd5b6b603c5465ac3fafdc~Jmlc31CBp0442104421epoutp04d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1714070832;
	bh=GpaNMWMqzUtQKOveThTCzAl0+LvJX9/CNL8Eg2zqipA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VtYVIxFgkXgDu7QRDS2Uc6QnTjsq3ywg+ckiPPZN5/cJtsXLA7yE3sJHBoECbQoXn
	 xr/9CQyd84Ru2wgpLRm3A4ozyAkLQBeGGusV+oZTmFwdroR4l6ST2rJ3cB0ud0fdC0
	 ewGpLf9Xqj5Ut1Jho1Iq9JOa1QcO3jp9NsQiKNHw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240425184711epcas5p2ff167da86ca6a3e26396a9b47387ce8b~JmlcTLqnC1621116211epcas5p2Y;
	Thu, 25 Apr 2024 18:47:11 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4VQPwZ5lFvz4x9Pv; Thu, 25 Apr
	2024 18:47:10 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	7D.E6.19431.E25AA266; Fri, 26 Apr 2024 03:47:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240425184710epcas5p2968bbc40ed10d1f0184bb511af054fcb~Jmla3wUSC1896318963epcas5p2H;
	Thu, 25 Apr 2024 18:47:10 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240425184710epsmtrp2407dc1e395edbb139ed2fd6ca97458fa~Jmla3B_-P0377403774epsmtrp2G;
	Thu, 25 Apr 2024 18:47:10 +0000 (GMT)
X-AuditID: b6c32a50-ccbff70000004be7-d8-662aa52ef286
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	0D.F0.07541.E25AA266; Fri, 26 Apr 2024 03:47:10 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240425184708epsmtip15a805bc42cf84a83e5c58dc63dbc8ef4~JmlZIg4mQ3266832668epsmtip17;
	Thu, 25 Apr 2024 18:47:08 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, martin.petersen@oracle.com, kbusch@kernel.org,
	hch@lst.de, brauner@kernel.org
Cc: asml.silence@gmail.com, dw@davidwei.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH 10/10] nvme: add separate handling for user integrity buffer
Date: Fri, 26 Apr 2024 00:09:43 +0530
Message-Id: <20240425183943.6319-11-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240425183943.6319-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLJsWRmVeSWpSXmKPExsWy7bCmpq7eUq00g/2ztSzmrNrGaLH6bj+b
	xevDnxgtXs1Yy2Zx88BOJouVq48yWbxrPcdicfT/WzaLSYeuMVrsvaVtMX/ZU3aL5cf/MTnw
	eFybMZHFY+esu+wel8+Wemxa1cnmsXlJvcfumw1sHh+f3mLx6NuyitHj8ya5AM6obJuM1MSU
	1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoIOVFMoSc0qBQgGJ
	xcVK+nY2RfmlJakKGfnFJbZKqQUpOQUmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZfyZ2MRY8
	FK6Yc2sTWwPjZIEuRk4OCQETiXP7P7J1MXJxCAnsYZR4sb6DFSQhJPCJUWLj11iIxDdGib6T
	19i7GDnAOtZsjIeI72WUeHjnPyuE85lRonnXZUaQIjYBTYkLk0tBBokIpEi8WveaEaSGWeAA
	o8Si50/YQBLCAj4SLyfeBLNZBFQl9n1rYAGxeQUsJHYv7WOHOE9eYual72A2J1B88sXT7BA1
	ghInZz4Bq2cGqmneOpsZZIGEwEoOidbVu1ggml0kNn09xAxhC0u8Or4FaqiUxOd3e9kg7GSJ
	SzPPMUHYJRKP9xyEsu0lWk/1M4M8wwz0zPpd+hC7+CR6fz9hggQEr0RHmxBEtaLEvUlPWSFs
	cYmHM5ZA2R4Ss6ccYoaETzejxPn7a5gmMMrPQvLCLCQvzELYtoCReRWjVGpBcW56arJpgaFu
	Xmo5PGKT83M3MYLTrVbADsbVG/7qHWJk4mA8xCjBwawkwnvzo0aaEG9KYmVValF+fFFpTmrx
	IUZTYCBPZJYSTc4HJvy8knhDE0sDEzMzMxNLYzNDJXHe161zU4QE0hNLUrNTUwtSi2D6mDg4
	pRqY9DPeeDP3vPSua75ytS89+0kAt+AF/djsn172XYrtrz9d/221rVl8xSKnsn2bFPy09BfN
	ca8paYg7Ihs4SbHX8cW7VS45H5VFzdkltM/17rz56q8ej3zCf6ayncK1ZSf6Ai367MQtsuyO
	mR53Md0dnHr75N6X685mf7l49GV0bErkVINpaWqxLJEH37sxzReq4LAO5H6beIPHZ1kbp+CH
	2QseyUktN51oEdUfedHTJqSjWq+Lu3dtw+c9i9bYPHmwaVZSx42aV+Ly27Y89v+j/X6qj9eH
	OI3M1UcMDf8x3ReLlzhw6IhU3S41o50aTY/sJSs3c2a6XE9ra4uaJXq1/eIHdy8Vfq/p2ivK
	A5VYijMSDbWYi4oTAQKnYllABAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsWy7bCSnK7eUq00g9Y5QhZzVm1jtFh9t5/N
	4vXhT4wWr2asZbO4eWAnk8XK1UeZLN61nmOxOPr/LZvFpEPXGC323tK2mL/sKbvF8uP/mBx4
	PK7NmMjisXPWXXaPy2dLPTat6mTz2Lyk3mP3zQY2j49Pb7F49G1ZxejxeZNcAGcUl01Kak5m
	WWqRvl0CV8afiV2MBQ+FK+bc2sTWwDhZoIuRg0NCwERizcb4LkYuDiGB3YwSd24sY+pi5ASK
	i0s0X/vBDmELS6z895wdougjo8TG0++YQJrZBDQlLkwuBakREciS2Nt/BayGWeAEo8Sh+YfB
	moUFfCReTrzJBmKzCKhK7PvWwAJi8wpYSOxe2ge1QF5i5qXvYDYnUHzyxdNgtpCAucTUNYsY
	IeoFJU7OfALWywxU37x1NvMERoFZSFKzkKQWMDKtYpRMLSjOTc9NNiwwzEst1ytOzC0uzUvX
	S87P3cQIjhQtjR2M9+b/0zvEyMTBeIhRgoNZSYT35keNNCHelMTKqtSi/Pii0pzU4kOM0hws
	SuK8hjNmpwgJpCeWpGanphakFsFkmTg4pRqYOF5Yb3Geby+3VH7txwYHkW1a5Y8qmQs2H7P4
	vZVH9fxeoaX3d/D+Mpm8+Oj3LmmBrLW90zRccxMOL30x+89rqUufnzUscL/dsHOK6lPLUN+b
	gRra27te7J+995+srM+S5U+NPDqEJp7m+ii46tGf0Of1tZ4CB75o2627ajrz+8UfyXveSlz3
	XFB9zTc9yFBFtuGChPDqX2E2RSfYn2R7HGtlF3L43MLzXfBzI8fP/B2yKaVnbOe2TXt1ZNrV
	DZvZhDauXrm7mmPdtt0Wd+ar6q658y1eOtxfOfDuwUCr8E2q7YamW+7dmpCw7t+XJoP3dfsy
	/bfusNDdUe8/N8CV75r3dS0BW9s/OQtfrq1VclNiKc5INNRiLipOBADpcb0jAwMAAA==
X-CMS-MailID: 20240425184710epcas5p2968bbc40ed10d1f0184bb511af054fcb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240425184710epcas5p2968bbc40ed10d1f0184bb511af054fcb
References: <20240425183943.6319-1-joshi.k@samsung.com>
	<CGME20240425184710epcas5p2968bbc40ed10d1f0184bb511af054fcb@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240425_114714_964528_5228E8BA 
X-CRM114-Status: GOOD (  18.08  )
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

For user provided integrity buffer, convert bip flags
(guard/reftag/apptag checks) to protocol specific flags.
Also pass apptag and reftag down.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/core.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 27281a9a8951..3b719be4eedb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -886,6 +886,13 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 	return BLK_STS_OK;
 }
 
+static void nvme_set_app_tag(struct nvme_command *cmnd, u16 apptag)
+{
+	cmnd->rw.apptag = cpu_to_le16(apptag);
+	/* use 0xfff as mask so that apptag is used in entirety*/
+	cmnd->rw.appmask = cpu_to_le16(0xffff);
+}
+
 static void nvme_set_ref_tag(struct nvme_ns *ns, struct nvme_command *cmnd,
 			      struct request *req)
 {
@@ -943,6 +950,25 @@ static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns,
 	return BLK_STS_OK;
 }
 
+static inline void nvme_setup_user_integrity(struct nvme_ns *ns,
+		struct request *req, struct nvme_command *cmnd,
+		u16 *control)
+{
+	struct bio_integrity_payload *bip = bio_integrity(req->bio);
+	unsigned short bip_flags = bip->bip_flags;
+
+	if (bip_flags & BIP_USER_CHK_GUARD)
+		*control |= NVME_RW_PRINFO_PRCHK_GUARD;
+	if (bip_flags & BIP_USER_CHK_REFTAG) {
+		*control |= NVME_RW_PRINFO_PRCHK_REF;
+		nvme_set_ref_tag(ns, cmnd, req);
+	}
+	if (bip_flags & BIP_USER_CHK_APPTAG) {
+		*control |= NVME_RW_PRINFO_PRCHK_APP;
+		nvme_set_app_tag(cmnd, bip->apptag);
+	}
+}
+
 static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 		struct request *req, struct nvme_command *cmnd,
 		enum nvme_opcode op)
@@ -983,6 +1009,14 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 			if (WARN_ON_ONCE(!nvme_ns_has_pi(ns->head)))
 				return BLK_STS_NOTSUPP;
 			control |= NVME_RW_PRINFO_PRACT;
+		} else {
+			/* process user-created integrity */
+			if (bio_integrity(req->bio)->bip_flags &
+					BIP_INTEGRITY_USER) {
+				nvme_setup_user_integrity(ns, req, cmnd,
+							  &control);
+				goto out;
+			}
 		}
 
 		switch (ns->head->pi_type) {
@@ -999,7 +1033,7 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 			break;
 		}
 	}
-
+out:
 	cmnd->rw.control = cpu_to_le16(control);
 	cmnd->rw.dsmgmt = cpu_to_le32(dsmgmt);
 	return 0;
-- 
2.25.1


