Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16BFBCDB474
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Oct 2023 06:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b7bEAC4YH67CB9UuwMtYsskx9PkC7Zuq/+DrQQlLpwU=; b=xSUvvq/D04MCUU7UVHglh8bDBN
	86OJguywaqvPo2id3TeIw9ipU7SpX5eir7NqQXL5YJx3i7SjM0qjow1krT2CRcW6ihU+iCN2ceaUn
	XDpKG5uvu+r6gX4qTHKTEUepreaOChv4ZtNkfwhk+fsRFMWld68Zm2d1FqLjn/neOZF1mHe7Vz0NE
	lwZxRGMGXqpyLG4Ql8MmKM2J7WwFnze9v+gzo4dJIgwdUZy1hlYc8oz4Y6s88rk9JX4cGbwsgu8x4
	9SZiojyS2uWdQpRkFC2wsTGCbbIKjVJVqCInC69vzMidTXPAk3fYm3CAO+7IUwsEvfhdAje4htwVP
	HFsTvMOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qsdDm-00BLwF-1X;
	Tue, 17 Oct 2023 06:06:26 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qsdDh-00BLtk-2O
	for linux-nvme@lists.infradead.org;
	Tue, 17 Oct 2023 06:06:25 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231017060612epoutp034805b571b7a27a53b2a4eb023dedf4a8~Oz-enW8wx1215012150epoutp03U
	for <linux-nvme@lists.infradead.org>; Tue, 17 Oct 2023 06:06:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231017060612epoutp034805b571b7a27a53b2a4eb023dedf4a8~Oz-enW8wx1215012150epoutp03U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1697522772;
	bh=b7bEAC4YH67CB9UuwMtYsskx9PkC7Zuq/+DrQQlLpwU=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=ljuWvBwTMrxbgAxknsmbLXxiTSe6crdvS1/kF4TpphxGztMKbDepn7dW9nlXSnqLV
	 OCM8/6x9AJKpO5cdTON03V7H0w+f37Q+HiBXxWNUjXJBVMdYAqcvuvlwJ69dtg7Vet
	 /2C2iH6Gwv1TlgfeGrfiW5qIubosOZQSycoOOQHc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20231017060611epcas5p2666f5ed30e7357373bc708b7f7dcc59d~Oz-ebtChz2747727477epcas5p2m;
	Tue, 17 Oct 2023 06:06:11 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4S8k4f210Lz4x9Py; Tue, 17 Oct
	2023 06:06:10 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	07.02.08567.D442E256; Tue, 17 Oct 2023 15:06:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20231017060605epcas5p41a7f1c7297ff6b377fce5f88edb0375f~Oz-YsgMhu2837028370epcas5p41;
	Tue, 17 Oct 2023 06:06:05 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231017060605epsmtrp202f2d4c66211a4815e5f8324cddc81d3~Oz-Yr0rsR0718907189epsmtrp2S;
	Tue, 17 Oct 2023 06:06:05 +0000 (GMT)
X-AuditID: b6c32a44-3abff70000002177-72-652e244d29db
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	EE.E8.08817.D442E256; Tue, 17 Oct 2023 15:06:05 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231017060604epsmtip29607f54dabc8287380fca98bba4dcfac~Oz-Xpy4531090510905epsmtip2p;
	Tue, 17 Oct 2023 06:06:04 +0000 (GMT)
Message-ID: <054938ef-a31e-709d-f1ea-47caedf1fdb3@samsung.com>
Date: Tue, 17 Oct 2023 11:36:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCHv2] nvme: sanitize metadata bounce buffer for reads
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, hch@lst.de,
	linux-nvme@lists.infradead.org
Cc: sagi@grimberg.me, axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20231016230625.3792823-1-kbusch@meta.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKJsWRmVeSWpSXmKPExsWy7bCmpq6fil6qwcRdzBar7/azWaxcfZTJ
	YtKha4wWZ64uZLGYv+wpu8W61+9ZHNg8zt/byOJx+Wypx6ZVnWwem5fUe+y+2cDmce5iRQBb
	VLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtARSgpl
	iTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCkwK94sTc4tK8dL281BIrQwMDI1OgwoTs
	jHX3fzAVHGSqePNtBXsDYwdTFyMnh4SAicST928Zuxi5OIQEdjNKrDo1mxnC+cQo8WHZfjYI
	5xujxMaNp9lhWrZv+c0KYgsJ7GWUmHHUCaLoLaPEl1+nWboYOTh4Bewk9q1yAjFZBFQlFjeZ
	gJTzCghKnJz5hAXEFhVIkvh1dQ4jiC0s4CZx+Mg/MJtZQFzi1pP5YNeJCPhLrNqwB2wiM1DN
	rlYLEJNNQFPiwuRSkApOAXOJhXv6WCE65SW2v50Ddr6EQCuHxKcla6CedJHYvegelC0s8er4
	FqhPpCQ+v9vLBmEnS1yaeQ6qpkTi8Z6DULa9ROupfmaIEzQl1u/Sh9jFJ9H7+wkTSFhCgFei
	o00IolpR4t6kp6wQtrjEwxlLoGwPiZZpp6GB2cUo8ffGJ9YJjAqzkAJlFpLnZyF5ZxbC5gWM
	LKsYJVMLinPTU5NNCwzzUsvhkZ2cn7uJEZw+tVx2MN6Y/0/vECMTB+MhRgkOZiUR3vRgnVQh
	3pTEyqrUovz4otKc1OJDjKbAyJnILCWanA9M4Hkl8YYmlgYmZmZmJpbGZoZK4ryvW+emCAmk
	J5akZqemFqQWwfQxcXBKNTAxzIldeSn1uvPUJGPxGobLoUX1Nm8cZZWXq6oq6Elvf8YYKvG+
	Zs7irLg0izclEg9ffS8V3JH2dLNOreirq9VHP8xYvlzpgE2ngFmPLcPy3sUekmuKLuUJbkvr
	XHjPmulUiePXhIaldidDg/k+ystcqPnbeLX8hHWf4dPjU+driPke27a+7KFr3eLJ0W1RGy4+
	E2H9Vbf416tJx0SdFH1NX01cZduWUvDQdb/sar/Zt56VrfDcEDkzzf7o/u1NYhtj1tf9kj5/
	rLJ42ful9/g+fHryyXby6seHyplNJ734yLp9n9WJB49YBI/5/VMoe99xnvPOvBl9b4s/K3wx
	S13qGFqksOzmisgJr99d2vtaQomlOCPRUIu5qDgRAP/9RGgoBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsWy7bCSvK6vil6qwe3tGhar7/azWaxcfZTJ
	YtKha4wWZ64uZLGYv+wpu8W61+9ZHNg8zt/byOJx+Wypx6ZVnWwem5fUe+y+2cDmce5iRQBb
	FJdNSmpOZllqkb5dAlfGuvs/mAoOMlW8+baCvYGxg6mLkZNDQsBEYvuW36xdjFwcQgK7GSXu
	r9zIDpEQl2i+9gPKFpZY+e85O0TRa0aJx/MambsYOTh4Bewk9q1yAjFZBFQlFjeZgJTzCghK
	nJz5hAXEFhVIkthzvxFsl7CAm8ThI/8YQWxmoPG3nswHi4sI+Ers/POXDWQMM1DNrlYLiE1d
	jBJv97WxgsTZBDQlLkwuBSnnFDCXWLinjxVijJlE19YuqJHyEtvfzmGewCg0C8kVs5Bsm4Wk
	ZRaSlgWMLKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYKjRUtrB+OeVR/0DjEycTAe
	YpTgYFYS4U0P1kkV4k1JrKxKLcqPLyrNSS0+xCjNwaIkzvvtdW+KkEB6YklqdmpqQWoRTJaJ
	g1Oqgam9fnOGYHdE19qkYMEM6StSOv//GancqLfcoL9P5vpr4/5Al1tTnQvOFVpZNq895ThT
	mTNe4/Tv9Jqdc48cnxs6w1ngjMs87ssb3bX74/c7nC089GGG9ZemoHf/vsXfyF7//yVPtbUc
	p2LkGZmvyqu04zTkJ/50DFBik/we/+GobdtEVZlFFk0FlZlRu8XubuGITpsmfe5jS+KSIr/Y
	oODa3HZGs5obqbZzL3Xu/FITLru4dpZ8QqDZltaXd10NirqFmJb35P55GeoUyHyF4Yqk2IPG
	j1dsEkyCTq8TPh1Y6/X0fsLlu3Vbtsyeyflr8cN7cz4KnEvKu8FheeZQc9jMBnOeJwV33hoe
	XM++TomlOCPRUIu5qDgRAMI381oFAwAA
X-CMS-MailID: 20231017060605epcas5p41a7f1c7297ff6b377fce5f88edb0375f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231016230939epcas5p47d9b62301959586c168c9baca580c874
References: <CGME20231016230939epcas5p47d9b62301959586c168c9baca580c874@epcas5p4.samsung.com>
	<20231016230625.3792823-1-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231016_230623_267595_05F157F6 
X-CRM114-Status: UNSURE (   8.94  )
X-CRM114-Notice: Please train this message.
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

On 10/17/2023 4:36 AM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> User can request more metadata bytes than the device will write. Ensure
> kernel buffer is initialized so we are not leaking unsanitized memory on
> the completion's copy-out.

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

