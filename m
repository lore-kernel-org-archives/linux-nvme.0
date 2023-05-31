Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C52FC77B73
	for <linux-nvme@archiver.kernel.org>; Wed, 31 May 2023 09:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dgHU00N/+R/KHKgNRjIXIRKTVuQTmbw0OyEaTHfs+n8=; b=TlfTKrhVodueB+UlX9uVMJ62DH
	yCRSwk1WtbqFdEN+fy2PCzU2fQew/FbmUzOFqU+GpknRdhPMadtm2DM/XksefZeZ/ffnVLS2sReSv
	E8Gi+sxui+71FiuhAPqA6RFYxCJgiW+pK+u+Pldv/6+EFeaHQ49EvPYwqEN2lL4BJzjK2Zu0OXUV9
	QwBaF1CH9VhGT/omb/heAjGVafGCHC7bqbJUtC1qJyeO6z4w3/0ioBNbiZ1HW+VWU6LPxO++gXyXB
	t2sM+5z151qYXQdxFehb33PxJFdZn9PrxTZblf7tpPh+rTyaHwyir0vyeEIAjLlCmqgpSz3LgNHMI
	WgO5cYQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4IS9-00Guqq-2S;
	Wed, 31 May 2023 09:49:13 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4IS2-00Gupg-1b
	for linux-nvme@lists.infradead.org;
	Wed, 31 May 2023 09:49:09 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230531094900epoutp042f21d07f78e00a0c2a15159616479293~kMXVV1ISD2574925749epoutp04X
	for <linux-nvme@lists.infradead.org>; Wed, 31 May 2023 09:49:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230531094900epoutp042f21d07f78e00a0c2a15159616479293~kMXVV1ISD2574925749epoutp04X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1685526540;
	bh=dgHU00N/+R/KHKgNRjIXIRKTVuQTmbw0OyEaTHfs+n8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K9usgEE66aGgoY0S9IC6VMVAGnQ4BMfsYup4a8EFXZA0HfHauBEjilejg/AQb1dPq
	 AQyLlvIhgkX0tTMOqDQwaUjJRwZsXi3+MlabZ8aGcGfej51ulyYl4MLnYcIFbuDJjr
	 hhTcto0r+rwNcIMLs7dVikfJXecSEW+ncFL7XjiM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20230531094900epcas5p4239c356021a98922de5f54fe9895f6ea~kMXVIZ5pE2669026690epcas5p4R;
	Wed, 31 May 2023 09:49:00 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4QWPbt4n5Dz4x9Q7; Wed, 31 May
	2023 09:48:58 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E1.58.16380.90817746; Wed, 31 May 2023 18:48:57 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20230531094857epcas5p4b3046c55ef96b6aaefee2fd1f853dc9c~kMXSItqNb2669026690epcas5p4M;
	Wed, 31 May 2023 09:48:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230531094857epsmtrp1a00a077ce10f9d2928e228cc6e1c107e~kMXSH0FTE1498114981epsmtrp1H;
	Wed, 31 May 2023 09:48:57 +0000 (GMT)
X-AuditID: b6c32a4b-56fff70000013ffc-18-647718091df7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5A.76.27706.80817746; Wed, 31 May 2023 18:48:56 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20230531094855epsmtip27651a058430e2468748d5b744eee1f2e~kMXQ5pODk2593025930epsmtip2u;
	Wed, 31 May 2023 09:48:55 +0000 (GMT)
Date: Wed, 31 May 2023 15:15:52 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, hch@lst.de, axboe@kernel.dk,
	sagi@grimberg.me, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/2] block: add request polling helper
Message-ID: <20230531094552.GA19592@green245>
MIME-Version: 1.0
In-Reply-To: <20230530172343.3250958-1-kbusch@meta.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOJsWRmVeSWpSXmKPExsWy7bCmhi6nRHmKwfVlohar7/azWaxcfZTJ
	4l3rORaLSYeuMVqcubqQxWLvLW2L+cuesluse/2exYHD4/y9jSwel8+Wemxa1cnmsXlJvcfu
	mw1sHucuVnh83iQXwB6VbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtq
	q+TiE6DrlpkDdJGSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CkQK84Mbe4NC9d
	Ly+1xMrQwMDIFKgwITtj++TT7AVnWStadn9gbmD8xNLFyMEhIWAi0XdWrouRi0NIYDejxInX
	6xghnE+MEo9mrmCDcL4xSvzfuZWpi5ETrKO1swcqsZdRoql1D5TzjFFiw753LCBVLAKqEr+e
	f2QG2cEmoClxYXIpSFhEQFHiPDAQQGxmgbWMEru3pYPYwgJWEos+rWYEKecV0JXoPSwBEuYV
	EJQ4OfMJ2EROAXOJK78eMYPYogLKEge2HWcCWSsh0MshsWTmKmaI41wkzn+6zAJhC0u8Or6F
	HcKWknjZ3wZlJ0tcmnkO6pkSicd7DkLZ9hKtp/qZIW7LkNjwYxLUnXwSvb+fMEGCi1eio00I
	olxR4t6kp6wQtrjEwxlLoGwPicuHN4KtEhLoYpT4sEtmAqPcLCTvzEKyAcK2kuj80MQ6C2gD
	s4C0xPJ/HBCmpsT6XfoLGFlXMUqmFhTnpqcWmxYY56WWw2M4OT93EyM4hWp572B89OCD3iFG
	Jg7GQ4wSHMxKIry2icUpQrwpiZVVqUX58UWlOanFhxhNgZEzkVlKNDkfmMTzSuINTSwNTMzM
	zEwsjc0MlcR51W1PJgsJpCeWpGanphakFsH0MXFwSjUwdSoFPaj60zh9h8hZxntVgafPCfzX
	0dm39sdvo9SYXp21B5bqmb58HPhB/d/u6YsuX5R9OTFn8oMNE0UyggSTUjhfWyR8fJB72M7b
	4bdR/d7QV98dux8G7cy32hzJNGnG29bY6TO+pE249aB1vcDZF7OLvBI33bqd29n4rPr8AqHu
	9eym2gcOBF2bvGHS9/WdfJ86/t8/eut31pG+5Brz06tNeCx2Pdby85r46F2zGp/Lt4SejYFZ
	58Lfn5/3beO0lNm31IMu7330b4e2zJFOo6C9FdHv3xrMv1mpXrGTOdVEwHrW8bKEvsYln578
	1KvNdfM2Pb6vb0WB3JkJcuHLP230PtL0mrG+TopB1t7kR7kSS3FGoqEWc1FxIgAnpFOXKgQA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsWy7bCSvC6HRHmKwYbP1har7/azWaxcfZTJ
	4l3rORaLSYeuMVqcubqQxWLvLW2L+cuesluse/2exYHD4/y9jSwel8+Wemxa1cnmsXlJvcfu
	mw1sHucuVnh83iQXwB7FZZOSmpNZllqkb5fAlbFswk32gv9MFff/nWRsYNzH1MXIySEhYCLR
	2tnDBmILCexmlPh9zh8iLi7RfO0HO4QtLLHy33N2iJonjBLNh2JBbBYBVYlfzz8ydzFycLAJ
	aEpcmFwKEhYRUJQ4D3QHiM0ssJZRYve2dBBbWMBKYtGn1Ywg5bwCuhK9hyW6GLmAJnYxSmza
	9JcFpIZXQFDi5MwnLBC9ZhLzNj8EG88sIC2x/B8HSJhTwFziyq9HzCC2qICyxIFtx5kmMArO
	QtI9C0n3LITuBYzMqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcxgmNCS3MH4/ZVH/QO
	MTJxMB5ilOBgVhLhtU0sThHiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2ampB
	ahFMlomDU6qBSVk97OBNnxzVBTHfLgS7KejNmTIlJ3p/ooHl79l5ccuMJxjIN6xXLOFPFMry
	2VLCEaT7hW8p+5K7Dc377+yXuXzZYLsey7SLfyJ5bk8/MmfS9LXnrQ0n//r6XLXe7ur7FQtL
	Gg3MX3xX1gvsnvC8235RnJ5g61XrC+wdDOxn1dR+3HnzXGL3vlVthU87ml/t1Ha70Sd9PCuC
	u4jn719h98uRu7YKJ3LdmPnQf5HLZX9L25fGDn0x8+XlTrVoPUqfWrwxfIHU5dP5pv0ip97m
	JDLyPd9T13lk4u1NfyccVP8RwOXYNfdqrYhm/r5uc7kCZlYeCWmpdz9Due/I6C7YOj3Yfndd
	+wJFzrURf+6YKbEUZyQaajEXFScCAPkiq9v4AgAA
X-CMS-MailID: 20230531094857epcas5p4b3046c55ef96b6aaefee2fd1f853dc9c
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----JBF_njb0NWiSS48ThI00c_Y9Zxz.JAos93qymBy6wSZnW6dc=_369a9_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230530172405epcas5p317e15a619d6101c8875b920224f02e31
References: <CGME20230530172405epcas5p317e15a619d6101c8875b920224f02e31@epcas5p3.samsung.com>
	<20230530172343.3250958-1-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230531_024908_074234_0E295303 
X-CRM114-Status: GOOD (  11.53  )
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

------JBF_njb0NWiSS48ThI00c_Y9Zxz.JAos93qymBy6wSZnW6dc=_369a9_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Tue, May 30, 2023 at 10:23:42AM -0700, Keith Busch wrote:
>From: Keith Busch <kbusch@kernel.org>
>
>This will be used by drivers that allocate polling requests. It
>interface does not require a bio, and can skip the overhead associated
>with polling those.
>
>Signed-off-by: Keith Busch <kbusch@kernel.org>

Looks good.
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

------JBF_njb0NWiSS48ThI00c_Y9Zxz.JAos93qymBy6wSZnW6dc=_369a9_
Content-Type: text/plain; charset="utf-8"


------JBF_njb0NWiSS48ThI00c_Y9Zxz.JAos93qymBy6wSZnW6dc=_369a9_--

