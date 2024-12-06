Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F24CE77179
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Dec 2024 12:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lmjPq207zxiZXvb3s8mxzYr5pL9OZCvX4A75sj+1CW0=; b=uhCE01IvoDtlFHY8GqtxfiMHNT
	bEx1+wX33ssFeeukAnfY6R+681TkxqPjqvEeiAxbu5wfZCEibCNjsvityZogjw0UtK5/VhQL54zlH
	NX//5UOlMIcXRne72VHim2fBeC3+20cOJNuw/yqB+8GspGDMp+AlqnsuWvOQtYqjxFdD3pwyI9OEG
	mosYlKBFIZfsEfS5Ac+YTQYoju/wsWu+1F9nPh6wfC9ALvGZnXui7v1zxZxSUxRVIuVcAmj5QkAv7
	mjw26MiNc3ECzEGAZwBJAMuI4pN6Y/Aiu86hTug6VPdFdM8IC3IXP6sGllnJ0URxl9cedJCVope4D
	A85Ach4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJXpf-00000001dHH-2UnI;
	Fri, 06 Dec 2024 12:53:19 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJXpd-00000001dFg-0Gs6
	for linux-nvme@lists.infradead.org;
	Fri, 06 Dec 2024 12:53:18 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20241206125310epoutp012fb1910c2b5080e43c4feff87ff7a768~Ol5kscR6R1686016860epoutp01E
	for <linux-nvme@lists.infradead.org>; Fri,  6 Dec 2024 12:53:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20241206125310epoutp012fb1910c2b5080e43c4feff87ff7a768~Ol5kscR6R1686016860epoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733489590;
	bh=lmjPq207zxiZXvb3s8mxzYr5pL9OZCvX4A75sj+1CW0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rn+ED/6+Uhs5r7x3U0g5oM6DV9wnVJUmDTSxaKPdaDoP1T5S3FaSU3Vfaq7rXq2r6
	 yKZEc3HUIBTA9ZC83TIQWlj2k2QdygKq9URqla7S7R2S6X3eJyqJSqn/WzB3PgyFG0
	 mVrSswBCqkkBRUpHMUgdQGUvIGFTNqQWCgwkqaXA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20241206125309epcas5p14a47153232da08249365959fa2c5f6b5~Ol5kBQwi-1382213822epcas5p1q;
	Fri,  6 Dec 2024 12:53:09 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Y4WQD5rm8z4x9Ps; Fri,  6 Dec
	2024 12:53:08 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	21.38.19933.4B3F2576; Fri,  6 Dec 2024 21:53:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20241206095739epcas5p1ee968cb92c9d4ceb25a79ad80521601f~OjgVH94jN2378523785epcas5p1O;
	Fri,  6 Dec 2024 09:57:39 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241206095739epsmtrp15f13725bf84ffaa5ec486bb3f456a7f3~OjgVHLqGr2843928439epsmtrp1o;
	Fri,  6 Dec 2024 09:57:39 +0000 (GMT)
X-AuditID: b6c32a4a-b87c770000004ddd-ba-6752f3b4067c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	84.E0.33707.39AC2576; Fri,  6 Dec 2024 18:57:39 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20241206095738epsmtip1237e22ac714aded712e44ea5142c8ccd~OjgTmFoCM0321303213epsmtip1q;
	Fri,  6 Dec 2024 09:57:38 +0000 (GMT)
Date: Fri, 6 Dec 2024 15:19:36 +0530
From: Anuj Gupta <anuj20.g@samsung.com>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, sagi@grimberg.me, asml.silence@gmail.com, Keith
	Busch <kbusch@kernel.org>
Subject: Re: [PATCHv11 02/10] io_uring: protection information enhancements
Message-ID: <20241206094936.icgalpwjytzirbhv@green245>
MIME-Version: 1.0
In-Reply-To: <20241206015308.3342386-3-kbusch@meta.com>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMJsWRmVeSWpSXmKPExsWy7bCmlu6Wz0HpBkuealvMWbWN0WL13X42
	i5WrjzJZvGs9x2Ix6dA1RoszVxeyWOy9pW2xZ+9JFov5y56yW6x7/Z7Fgctj56y77B7n721k
	8bh8ttRj06pONo/NS+o9dt9sYPM4d7HC4/MmuQCOqGybjNTElNQihdS85PyUzLx0WyXv4Hjn
	eFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKADlRTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2
	SqkFKTkFJgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGVdOH2IqOMhX0ff6HHsDYz9PFyMnh4SA
	icTPcyfYQWwhgd2MEg27OLsYuYDsT4wSu8+uZYFzuj6/Y4PpePlzNRNEYiejxIVbu1khnGeM
	Eg+X72XsYuTgYBFQkVixOQWkgU1AXeLI81ZGEFtEQFHiPDAQQGxmkPqFp2JAyoUFvCUurywC
	CfMKmEn8evGIEcIWlDg58wkLiM0pYC5xq/kOE4gtKiAjMWPpV2aQtRICczkktq6exg5xnIvE
	o2ndjBC2sMSr41ug4lISL/vboOx0iR+XnzJB2AUSzcf2QdXbS7Se6meGuC1DYtONr1BxWYmp
	p9YxQcT5JHp/P4Hq5ZXYMQ/GVpJoXzkHypaQ2HuuAcr2kDh58QsTJHi3A4P3SNIERvlZSH6b
	hWQdhG0l0fmhiXUWMFiYBaQllv/jgDA1Jdbv0l/AyLqKUTK1oDg3PbXYtMAoL7UcHt3J+bmb
	GMGpV8trB+PDBx/0DjEycTAeYpTgYFYS4a0MC0wX4k1JrKxKLcqPLyrNSS0+xGgKjKmJzFKi
	yfnA5J9XEm9oYmlgYmZmZmJpbGaoJM77unVuipBAemJJanZqakFqEUwfEwenVAOT+xL5LYmz
	LU50MTfMfdC5xDnzwTeHnl9rD/TbJr+Z/bKu0a/zwOeFO5XPia9nFwjZaa55ZcfdhM+hZ3jr
	v20PkHviP9Pd+Kbo4nef1D56dPOp++xsuvF2Rtm2ssZ7l3R3nHRt/vJm/rT2mc3lMpU6alUK
	s23Zjznnz7fwS5B5lv5e7MrEk/cvuwru3vi2+NLX6S0Kzbtkz9y/uK6jSfeXqIzstlqdJrW4
	21ksPi8WB3g+kc3YJ7XlynIefVH59odbexs19avvJU5StVp5ViP4UGGOr9v1szkvmv4uqakw
	+dDf0qYxtyju4VyXZs+sHaqiF5uUd/q9sxKac+rt+SVPX4VmdG26eZBttXD8B52fSizFGYmG
	WsxFxYkAjJN3P0YEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsWy7bCSnO7kU0HpBsvbjC3mrNrGaLH6bj+b
	xcrVR5ks3rWeY7GYdOgao8WZqwtZLPbe0rbYs/cki8X8ZU/ZLda9fs/iwOWxc9Zddo/z9zay
	eFw+W+qxaVUnm8fmJfUeu282sHmcu1jh8XmTXABHFJdNSmpOZllqkb5dAlfGxQ2bGQs+c1dc
	eN/G3sB4m7OLkZNDQsBE4uXP1UxdjFwcQgLbGSX+n//DBpGQkDj1chkjhC0ssfLfc3aIoieM
	ElPO/wZKcHCwCKhIrNicAlLDJqAuceR5K1i9iICixHmgS0DqmQWeMUrs2rOCGaReWMBb4vLK
	IpAaXgEziV8vHoGNERJIlph6SxUiLChxcuYTFhCbGahk3uaHYJ3MAtISy/9xgIQ5BcwlbjXf
	YQKxRQVkJGYs/co8gVFwFpLuWUi6ZyF0L2BkXsUomlpQnJuem1xgqFecmFtcmpeul5yfu4kR
	HCtaQTsYl63/q3eIkYmD8RCjBAezkghvZVhguhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe5ZzO
	FCGB9MSS1OzU1ILUIpgsEwenVAPTwm59dYm/KQnlJVWvlrgKlOWunfEjQTUqMiaiT0fLNjA4
	eK19gS1v4KWnP1Mf7ZPaqsMV6f5uxclGe+02ZsOq7WIf11y5HjYjYtsX7SWyl8MsOAxr7+aU
	pQbLL2bacnbrsQPrhLdlHVTy37qH82C665N/jJObfTYfyD1aZGqvvSrR5+RHZz+Ho5MXlyRa
	apouXCt3pvLlpFPTQhKF73+7YP4s8a3gGh2b6ev7YnSWS5wzyQoo/Z/e2at8bEbZ2er2tZuz
	c55kf9TjfJAVK7v5x4Ki6T7mq1QmN9npGX94dFGu8m9v4neDjxZvIqbeOi012Xe2zmZ5ZY/O
	MtNEzvLdUreWVIbsN1moEW5nuVuJpTgj0VCLuag4EQCy28/HBAMAAA==
X-CMS-MailID: 20241206095739epcas5p1ee968cb92c9d4ceb25a79ad80521601f
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----YdMQOF_WoWeg2u_t4KSKhNTuhss8l_igc36-I4U5-7l0BmvH=_634a7_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241206095739epcas5p1ee968cb92c9d4ceb25a79ad80521601f
References: <20241206015308.3342386-1-kbusch@meta.com>
	<20241206015308.3342386-3-kbusch@meta.com>
	<CGME20241206095739epcas5p1ee968cb92c9d4ceb25a79ad80521601f@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241206_045317_439904_6201D084 
X-CRM114-Status: GOOD (  15.02  )
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

------YdMQOF_WoWeg2u_t4KSKhNTuhss8l_igc36-I4U5-7l0BmvH=_634a7_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 05/12/24 05:53PM, Keith Busch wrote:
>From: Keith Busch <kbusch@kernel.org>
>
>diff --git a/io_uring/rw.c b/io_uring/rw.c
>index 04e4467ab0ee8..a2987aefb2cec 100644
>--- a/io_uring/rw.c
>+++ b/io_uring/rw.c
>@@ -272,14 +272,14 @@ static inline void io_meta_restore(struct io_async_rw *io, struct kiocb *kiocb)
> }
>
> static int io_prep_rw_pi(struct io_kiocb *req, struct io_rw *rw, int ddir,
>-			 u64 attr_ptr, u64 attr_type_mask)
>+			 u64 *attr_ptr)
> {
> 	struct io_uring_attr_pi pi_attr;
> 	struct io_async_rw *io;
> 	int ret;
>
>-	if (copy_from_user(&pi_attr, u64_to_user_ptr(attr_ptr),
>-	    sizeof(pi_attr)))
>+	if (copy_from_user(&pi_attr, u64_to_user_ptr(*attr_ptr),
>+			   sizeof(pi_attr)))
> 		return -EFAULT;
>
> 	if (pi_attr.rsvd)
>@@ -295,6 +295,7 @@ static int io_prep_rw_pi(struct io_kiocb *req, struct io_rw *rw, int ddir,
> 		return ret;
> 	rw->kiocb.ki_flags |= IOCB_HAS_METADATA;
> 	io_meta_save_state(io);
>+	*attr_ptr += sizeof(pi_attr);
> 	return ret;
> }
>
>@@ -335,8 +336,7 @@ static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
> 	if (attr_type_mask) {
> 		u64 attr_ptr;
>
>-		/* only PI attribute is supported currently */
>-		if (attr_type_mask != IORING_RW_ATTR_FLAG_PI)
>+		if (attr_type_mask & ~IORING_RW_ATTR_FLAGS_SUPPORTED)
> 			return -EINVAL;
>
> 		attr_ptr = READ_ONCE(sqe->attr_ptr);
>-- 

Nit:
Although the next patch does it, but the call to io_prep_rw_pi should
pass a u64 pointer in this patch itself.

------YdMQOF_WoWeg2u_t4KSKhNTuhss8l_igc36-I4U5-7l0BmvH=_634a7_
Content-Type: text/plain; charset="utf-8"


------YdMQOF_WoWeg2u_t4KSKhNTuhss8l_igc36-I4U5-7l0BmvH=_634a7_--

