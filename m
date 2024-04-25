Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96BAC10F15
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Apr 2024 18:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8UjWzASLbE281aLekYBWGcVUrDYfR/50j9EjsKMziS0=; b=evhWPU85WPlk82zAqkDUX1EB0h
	nQiHSAtpYZVIvVSzrMzwnysUWtE5XLn59T0d63bNp+DNOOxQQrtnGyHyS+eIdtqF+jzNe2pmYcc4B
	pUYsJaFhFe9qilA9/9We46m3GTvLWy1a2FIl03gjqeN93XXCGnG1SsAYcSvCrQlfixmSvItqfzd94
	sI3Uiou5BJ+h0BwCLYHiGxdmKxtxuP6pAMLIJ1L3YOe1rDrBZ6kLyGeeMXbqlsSwcB04afABzdDFQ
	NDNyDAWXG0q9slCNK6J/18PRLBvs/WBVGn/5wQEP+6W3jMt4slK+N7qcnDeD/dFgK3pWHCtrlIBS9
	U82MEO9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s047v-00000009lxt-1x4S;
	Thu, 25 Apr 2024 18:47:23 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s047j-00000009lmm-2jxl
	for linux-nvme@lists.infradead.org;
	Thu, 25 Apr 2024 18:47:16 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240425184657epoutp026a0e32cd2d1e9baad1a861ba1a698aae~JmlOa8jy02856228562epoutp02b
	for <linux-nvme@lists.infradead.org>; Thu, 25 Apr 2024 18:46:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240425184657epoutp026a0e32cd2d1e9baad1a861ba1a698aae~JmlOa8jy02856228562epoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1714070817;
	bh=8UjWzASLbE281aLekYBWGcVUrDYfR/50j9EjsKMziS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EkWk0nZFFZR+UZPyMT3GvkvBnqBu8Ir0x2eKAXzvLVPGuZ/zaYZ+XLZ7vPDMFrndK
	 6CdiDg98Eole7XqWegqjEo7GV6nC2/+lY+bGx1B+3vcv1aJyLaabEr11jwQbyHz0gl
	 p5rjRcNhC0GFBvJAB2wyJTeFCvDRtSEHAH+HkE3g=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240425184656epcas5p35ee096051f0bbb21f8542a38aabb4ea6~JmlNhW5YC0824808248epcas5p3h;
	Thu, 25 Apr 2024 18:46:56 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4VQPwG354Fz4x9Pp; Thu, 25 Apr
	2024 18:46:54 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A7.20.09665.E15AA266; Fri, 26 Apr 2024 03:46:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240425184653epcas5p28de1473090e0141ae74f8b0a6eb921a7~JmlLj1-nc2219922199epcas5p2p;
	Thu, 25 Apr 2024 18:46:53 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240425184653epsmtrp15999b231b11a167202adf9a316909721~JmlLjFbN_0085200852epsmtrp1N;
	Thu, 25 Apr 2024 18:46:53 +0000 (GMT)
X-AuditID: b6c32a4b-829fa700000025c1-13-662aa51ea6f3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F8.F0.07541.D15AA266; Fri, 26 Apr 2024 03:46:53 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240425184652epsmtip15304991c802986bd2c08f53595bdaacf~JmlJv392M3082730827epsmtip1Y;
	Thu, 25 Apr 2024 18:46:51 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, martin.petersen@oracle.com, kbusch@kernel.org,
	hch@lst.de, brauner@kernel.org
Cc: asml.silence@gmail.com, dw@davidwei.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>, Kanchan Joshi
	<joshi.k@samsung.com>
Subject: [PATCH 02/10] block: copy bip_max_vcnt vecs instead of bip_vcnt
 during clone
Date: Fri, 26 Apr 2024 00:09:35 +0530
Message-Id: <20240425183943.6319-3-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240425183943.6319-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHJsWRmVeSWpSXmKPExsWy7bCmhq7cUq00g1k3BC2aJvxltpizahuj
	xeq7/WwWrw9/YrR4NWMtm8XNAzuZLFauPspk8a71HIvF0f9v2SwmHbrGaLH3lrbF/GVP2S2W
	H//H5MDrcW3GRBaPnbPusntcPlvqsWlVJ5vH5iX1HrtvNrB5fHx6i8Wjb8sqRo/Pm+QCOKOy
	bTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOArlZSKEvM
	KQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgU6BUn5haX5qXr5aWWWBkaGBiZAhUmZGfs
	vPaCteA+R8WxZzdZGhgXs3cxcnJICJhIHH1+ma2LkYtDSGA3o8SyVX1QzidGiSk7b0E53xgl
	NrcdY4RpubV+IytEYi+jxKFDq8ASQgKfGSXO/+foYuTgYBPQlLgwuRQkLCKQIvFq3WuwEmaB
	p4wSPzqZQGxhgXCJU/ufMIKUswioSlz6bQQS5hUwl5i2spcVYpW8xMxL38Eu5RSwkJh88TQ7
	RI2gxMmZT1ggRspLNG+dzQxyjoTAWg6JX3Ofs0E0u0hs7ZsG9aawxKvjW6BsKYmX/W1QdrLE
	pZnnmCDsEonHew5C2fYSraf6mUFuYwZ6Zf0ufYhdfBK9v58wgYQlBHglOtqEIKoVJe5Negp1
	srjEwxlLWCFKPCQOb6iDhE03o8TBT9kTGOVnIXlgFpIHZiHsWsDIvIpRMrWgODc9tdi0wDgv
	tRweqcn5uZsYwQlXy3sH46MHH/QOMTJxMB5ilOBgVhLhvflRI02INyWxsiq1KD++qDQntfgQ
	oykwgCcyS4km5wNTfl5JvKGJpYGJmZmZiaWxmaGSOO/r1rkpQgLpiSWp2ampBalFMH1MHJxS
	DUwnok1m2C/6InaQza+hSHte4bZfnX7Pjwv9mhnIVxH0lUFha5LDDs3/87gZYhZMnWZ9/Wzi
	C83LOpO3TvPm973uVi5d3Whr96JSMVrX7FuNmGN9wOYP3G2T2z0nFhheWfdo54t+hVjLluXV
	SVeKr2/6eOX8v1cyu/8rbFO3mCRr9JMhPdu/vshuXlfX3psXnyqw692aM0HPWVrg0gXtaScO
	+2twS29oERNnCo17t/NR1CHJC0pfpxwW8zHQXMHc9JsnR6Ij74L51S3tJ+ez7QuRt7PP/tZz
	JeugQUL5o1nF5apvs3qMY2bGvT0stDn9ru6KWccP7+Fl6Gi0K3A+6lGYxlyoGVNyfJ77iZ27
	WZVYijMSDbWYi4oTAUZyiMNBBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsWy7bCSnK7sUq00g03NZhZNE/4yW8xZtY3R
	YvXdfjaL14c/MVq8mrGWzeLmgZ1MFitXH2WyeNd6jsXi6P+3bBaTDl1jtNh7S9ti/rKn7BbL
	j/9jcuD1uDZjIovHzll32T0uny312LSqk81j85J6j903G9g8Pj69xeLRt2UVo8fnTXIBnFFc
	NimpOZllqUX6dglcGTuvvWAtuM9RcezZTZYGxsXsXYycHBICJhK31m9k7WLk4hAS2M0oMXPS
	BGaIhLhE87UfUEXCEiv/PWeHKPrIKHF43mSWLkYODjYBTYkLk0tBakQEsiT29l8Bq2EWeMso
	Mf/vHrBBwgKhEn+mv2AGqWcRUJW49NsIJMwrYC4xbWUvK8R8eYmZl76D7eIUsJCYfPE0mC0E
	VDN1zSJGiHpBiZMzn7CA2MxA9c1bZzNPYBSYhSQ1C0lqASPTKkbJ1ILi3PTcZMMCw7zUcr3i
	xNzi0rx0veT83E2M4JjR0tjBeG/+P71DjEwcjIcYJTiYlUR4b37USBPiTUmsrEotyo8vKs1J
	LT7EKM3BoiTOazhjdoqQQHpiSWp2ampBahFMlomDU6qB6cipWw3Fkw+dXl0YKXFwZ+fyhIDT
	m7Y/O//9g5+4uNbFxddDJ8clLyh+Vt4x36vRVfmo/WXzBUVSbeeZ7/K67/Ce81HnopRDaMxt
	lozC+isvl8vPyXhawL10YsH85b6HSjw+vHjVNFM12DPHR+Nc66atGdsUmAKTxX8+j5p66Okf
	0Ul/RaIr2D+bsB79wb6sqpzf1T+F713Lz3s2KxsFrgTysvoe8/fr7b1WfSzNfHFf9bvnnNKX
	b1icuch3J/lK1eHr6cL976J9583TvDD357omcb7FTRKiu/7snXTd5JRTJtf81Uldmbs1/m/K
	9TG0X6PmWWW4fErwtszZgXtvCYX46O9TXeA7+1/apefdfkosxRmJhlrMRcWJAG8TR5QIAwAA
X-CMS-MailID: 20240425184653epcas5p28de1473090e0141ae74f8b0a6eb921a7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240425184653epcas5p28de1473090e0141ae74f8b0a6eb921a7
References: <20240425183943.6319-1-joshi.k@samsung.com>
	<CGME20240425184653epcas5p28de1473090e0141ae74f8b0a6eb921a7@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240425_114712_163080_8210CD4A 
X-CRM114-Status: GOOD (  14.40  )
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

From: Anuj Gupta <anuj20.g@samsung.com>

If bio_integrity_copy_user is used to process the meta buffer, bip_max_vcnt
is one greater than bip_vcnt. In this case bip_max_vcnt vecs needs to be
copied to cloned bip.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 block/bio-integrity.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index e3390424e6b5..c1955f01412e 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -622,12 +622,12 @@ int bio_integrity_clone(struct bio *bio, struct bio *bio_src,
 
 	BUG_ON(bip_src == NULL);
 
-	bip = bio_integrity_alloc(bio, gfp_mask, bip_src->bip_vcnt);
+	bip = bio_integrity_alloc(bio, gfp_mask, bip_src->bip_max_vcnt);
 	if (IS_ERR(bip))
 		return PTR_ERR(bip);
 
 	memcpy(bip->bip_vec, bip_src->bip_vec,
-	       bip_src->bip_vcnt * sizeof(struct bio_vec));
+	       bip_src->bip_max_vcnt * sizeof(struct bio_vec));
 
 	bip->bip_vcnt = bip_src->bip_vcnt;
 	bip->bip_iter = bip_src->bip_iter;
-- 
2.25.1


