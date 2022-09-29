Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89EDDC433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Sep 2022 12:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DG6Zpqd4/2UP5P9wNBGWZp+XVTct8fbhkANYJQeAaWw=; b=f+5ddRHgvnDdzdTc4509XBFiyV
	nOZ8sBkuPBwE3YLGnbVHRkFcFFLllqSHe0RtmfjWofOwrVK5ec9+yI9aPhsgALlj5X48b9ks4d25+
	D0WCj53cBg41ZiWkuQz+pIAagOJeanWMTa7EIDmtaNYIRyE3sm9l5/wVapYf3um1JxmhSK91Zjbpa
	KgnGkSwn1W8SbvEz4rR3dGT0E8FDywiO004L0ytRJQUX8IlitzaV9c8YXTR3YdPi10dGouK/DJG6P
	Xn3EjFy1TidQQ264AZd35JzDGXLx6aLbBtBsyOaCcllkWkbAW7xuJSFZ4/B2PeZ7tKtYLGy6rN1/B
	Aqex9mdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odsbt-002wmX-0E; Thu, 29 Sep 2022 12:25:49 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odsaT-002w2d-7n
	for linux-nvme@lists.infradead.org; Thu, 29 Sep 2022 12:24:23 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220929122419epoutp049b3dc59aea303352eff811273c1b63a3~ZVFSNeR911159911599epoutp04L
	for <linux-nvme@lists.infradead.org>; Thu, 29 Sep 2022 12:24:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220929122419epoutp049b3dc59aea303352eff811273c1b63a3~ZVFSNeR911159911599epoutp04L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1664454259;
	bh=DG6Zpqd4/2UP5P9wNBGWZp+XVTct8fbhkANYJQeAaWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qkPxDG9X5ggsvQlXwhF84sAkM9npi+AjUglAjre3Rlti6aPu5JH6AYyjI+oauXkp4
	 ddOFQRYf7e2a+Agkf6PNI8kY9NITeR3UUKvT5GQ+ea1FbdfcNqNCIyLv/l60HzvWNh
	 4ho18VSqotQGwYpJ0mcf0BYrvN79z0jv4YEdO92g=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20220929122419epcas5p3ab50085349aa2d4f199397ae8060aac2~ZVFR8zI0j1893118931epcas5p3n;
	Thu, 29 Sep 2022 12:24:19 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4MdXbh5h5Tz4x9Pt; Thu, 29 Sep
	2022 12:24:16 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F5.33.26992.E6E85336; Thu, 29 Sep 2022 21:24:14 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20220929121709epcas5p325553d10a7ada7717c2f51ddb566a3e5~ZU-BsZpoH1999119991epcas5p3-;
	Thu, 29 Sep 2022 12:17:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220929121709epsmtrp270ba0d78c1d27006505094c47795e360~ZU-BriPFm1811218112epsmtrp2i;
	Thu, 29 Sep 2022 12:17:09 +0000 (GMT)
X-AuditID: b6c32a49-319fb70000016970-48-63358e6eda74
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4C.43.14392.5CC85336; Thu, 29 Sep 2022 21:17:09 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20220929121707epsmtip127b90fef27a1a68fece6a7d250645b96~ZU-ATJ1Xi3029530295epsmtip1D;
	Thu, 29 Sep 2022 12:17:07 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH for-next v11 11/13] block: add blk_rq_map_user_io
Date: Thu, 29 Sep 2022 17:36:30 +0530
Message-Id: <20220929120632.64749-12-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220929120632.64749-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmum5+n2mywUkBi6YJf5ktVt/tZ7O4
	eWAnk8XK1UeZLN61nmOxmHToGqPF3lvaFvOXPWW36L6+g82B0+Py2VKPTas62Tw2L6n32H2z
	gc2jb8sqRo/Pm+QC2KKybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1Nt
	lVx8AnTdMnOALlJSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgU6BUn5haX5qXr
	5aWWWBkaGBiZAhUmZGdsbf/HWHBZqOLIo4PsDYzt/F2MnBwSAiYSkzZsYe9i5OIQEtjNKPH6
	8RFmCOcTo8TMji2MEM43IGdqLxNMy7y9d6Cq9jJKPJm1GqrqM6PEkW3PWECq2ATUJY48b2UE
	sUUEjCT2fzrJClLELLCJUeLX9WNgo4QFHCX23/wKZrMIqErsXDMLrJlXwEpi98qvrBDr5CVm
	XvrODmJzAsUXX5vDClEjKHFy5hOwemagmuats8FOkhD4yS5x8g/ISRxAjovE4su8EHOEJV4d
	38IOYUtJfH63lw3CTpf4cfkp1GsFEs3H9jFC2PYSraf6mUHGMAtoSqzfpQ8RlpWYemodE8Ra
	Pone30+gWnkldsyDsZUk2lfOgbIlJPaea4CyPSSm/73KBgmsXkaJw/fnsk9gVJiF5J1ZSN6Z
	hbB6ASPzKkbJ1ILi3PTUYtMCw7zUcng0J+fnbmIEJ1Mtzx2Mdx980DvEyMTBeIhRgoNZSYRX
	vMA0WYg3JbGyKrUoP76oNCe1+BCjKTC8JzJLiSbnA9N5Xkm8oYmlgYmZmZmJpbGZoZI47+IZ
	WslCAumJJanZqakFqUUwfUwcnFINTPMPf0n8v7NKUqCpKpj/TKMQ99GEdYLL2kQ6FPM5vLSe
	+3/ZouX/dLtA699YicXbenwvi4vq3uqbuq1B5X6C7mbrK3tVag4r3HW60pl6ZKPwL3fluTu7
	f+xcKnnvpAh/sGxQxmmJ/1ltrd5pjEL1c424Nqq05x+72/TqSnPgpHW1nTN3fPB2zv/v0/aP
	cWPiNkV+jdsJ96v9jA8HL2djYjYKtn8sJv3uT/7e00yFS5KmPA334no6Zz67DU9nt8W5KzPm
	7/UI/dh58ZiUNl/Jsi2pjecuJt3f6mGXFjTl9+K2rFV6wvOOHV+23Cf6yYad049F5bMWTP9s
	tcL/o5IIT9+yT8VPeESrAxq/RunKK7EUZyQaajEXFScCACCqGRovBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsWy7bCSnO7RHtNkg6ezeSyaJvxltlh9t5/N
	4uaBnUwWK1cfZbJ413qOxWLSoWuMFntvaVvMX/aU3aL7+g42B06Py2dLPTat6mTz2Lyk3mP3
	zQY2j74tqxg9Pm+SC2CL4rJJSc3JLEst0rdL4MrY2v6PseCyUMWRRwfZGxjb+bsYOTkkBEwk
	5u29w9zFyMUhJLCbUWLjyflsEAkJiVMvlzFC2MISK/89Z4co+sgoMWXSabAiNgF1iSPPW8GK
	RATMJJYeXsMCUsQssINRYt2zxWAJYQFHif03vzKB2CwCqhI718xiAbF5Bawkdq/8ygqxQV5i
	5qXv7CA2J1B88bU5QHEOoG2WEttvKkCUC0qcnPkErJUZqLx562zmCYwCs5CkZiFJLWBkWsUo
	mVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERzuWpo7GLev+qB3iJGJg/EQowQHs5IIr3iB
	abIQb0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFINTJbtF889
	Uj91Q1OaZyXbHZG/C+95Hti6J7PwSsvx5LS9rb4iDhuNneL4QiYbtx+r2tF3+rHJwpSQVLZv
	TP0m4d3La55qq2/e56qWGqrz9sfJnpKVnbaZx6/JHAq4+9TR0SPL/L3u9rLsb+Z3DmyZYr/C
	j2PXkt9r+t8Lr+zftdfWz1tJqdzTN+M+27+vf/IFNO8dTU6NUN6Y9OyG8erKled0K3bPEjQz
	ClQ7cudZkn5f1eN698tTqm9Jh733/6xT/3Dr+2fC7vyx7j2iL7Oe1emZtU/k4nnoeVj/kO3a
	UL/8N/w5jfM37Poq0D0//vnNn4L2v8/FTJTLcPhUwPJPjIE7d8Xjl5mHvWdcWrSpQImlOCPR
	UIu5qDgRACr5wZ/mAgAA
X-CMS-MailID: 20220929121709epcas5p325553d10a7ada7717c2f51ddb566a3e5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220929121709epcas5p325553d10a7ada7717c2f51ddb566a3e5
References: <20220929120632.64749-1-anuj20.g@samsung.com>
	<CGME20220929121709epcas5p325553d10a7ada7717c2f51ddb566a3e5@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220929_052421_660900_E09C92BB 
X-CRM114-Status: GOOD (  17.41  )
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

Create a helper blk_rq_map_user_io for mapping of vectored as well as
non-vectored requests. This will help in saving dupilcation of code at few
places in scsi and nvme.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Suggested-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-map.c        | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/blk-mq.h |  2 ++
 2 files changed, 38 insertions(+)

diff --git a/block/blk-map.c b/block/blk-map.c
index ffab5d2d8d6d..74ee496c2d3a 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -689,6 +689,42 @@ int blk_rq_map_user(struct request_queue *q, struct request *rq,
 }
 EXPORT_SYMBOL(blk_rq_map_user);
 
+int blk_rq_map_user_io(struct request *req, struct rq_map_data *map_data,
+		void __user *ubuf, unsigned long buf_len, gfp_t gfp_mask,
+		bool vec, int iov_count, bool check_iter_count, int rw)
+{
+	int ret;
+
+	if (vec) {
+		struct iovec fast_iov[UIO_FASTIOV];
+		struct iovec *iov = fast_iov;
+		struct iov_iter iter;
+
+		ret = import_iovec(rw, ubuf, iov_count ? iov_count : buf_len,
+				UIO_FASTIOV, &iov, &iter);
+		if (ret < 0)
+			return ret;
+
+		if (iov_count) {
+			/* SG_IO howto says that the shorter of the two wins */
+			iov_iter_truncate(&iter, buf_len);
+			if (check_iter_count && !iov_iter_count(&iter)) {
+				kfree(iov);
+				return -EINVAL;
+			}
+		}
+
+		ret = blk_rq_map_user_iov(req->q, req, map_data, &iter,
+				gfp_mask);
+		kfree(iov);
+	} else if (buf_len) {
+		ret = blk_rq_map_user(req->q, req, map_data, ubuf, buf_len,
+				gfp_mask);
+	}
+	return ret;
+}
+EXPORT_SYMBOL(blk_rq_map_user_io);
+
 /**
  * blk_rq_unmap_user - unmap a request with user data
  * @bio:	       start of bio list
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 50811d0fb143..ba18e9bdb799 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -985,6 +985,8 @@ struct rq_map_data {
 
 int blk_rq_map_user(struct request_queue *, struct request *,
 		struct rq_map_data *, void __user *, unsigned long, gfp_t);
+int blk_rq_map_user_io(struct request *, struct rq_map_data *,
+		void __user *, unsigned long, gfp_t, bool, int, bool, int);
 int blk_rq_map_user_iov(struct request_queue *, struct request *,
 		struct rq_map_data *, const struct iov_iter *, gfp_t);
 int blk_rq_unmap_user(struct bio *);
-- 
2.25.1


