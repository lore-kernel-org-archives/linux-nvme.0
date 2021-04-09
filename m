Return-Path: <SRS0=kA4j=JG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29539C433ED
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 17:46:28 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 890836113A
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 17:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 890836113A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:Message-ID:
	Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JPRBcExmE/NGUaWELDJ+CWjZJyLf1C5OnvYDecIjCDQ=; b=JkpGYAuULCDXrO7dWZ4nc6v/4
	7q+s5AHY7eCkGsHy4vkGaTPpzHaC1lvDp8ETHfKdBFGR/L4AUWnIOoYdmmrxRAFAF2WvIcw6cQCuO
	nnjULKhoZGE/vniF92sD2+SU3YtojWTW/eH6NCUgFsokT2I5QQLzB+QjwfgTcGMBwYwUydQrjpUZn
	CfpNPoq2lTjJ6eTyk5lbI9QcaorCzx4P13IkUtdwvRtauoYKETj3Q5BpQDG/kH0yiN/T3lG+PaeOH
	tCqN2alFPLHcGYKa0vvGA2J9BlqgmYqhY1Th24fYzk+QX3mKUxwwVO1j9CuFgitUxCStvl/94N+xK
	U/XUfYmUw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUvCp-001DUx-UC; Fri, 09 Apr 2021 17:46:08 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUvCk-001DUQ-6Z
 for linux-nvme@desiato.infradead.org; Fri, 09 Apr 2021 17:46:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=References:In-Reply-To:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:CC:To:
 From:Date:Sender:Reply-To:Content-ID:Content-Description;
 bh=Jxu++ZxUni1dL8jfZhFdbzAKcs/2Xv0quewsG2HVNUw=; b=SSXlXarUbA2fwCs8hMD6XUYB72
 o5o0dF6WhPJYWgKTyeGA28CE/KmJA7yEaCJZ0nZaLrcC1mp2dzasvFsnbSsxVuLclMXBh/udeCE9t
 uQNmfqfDz3AriGaOEfMDFnErBkwAmKoAzC/FxM9zRApWSyX4jmEaOmJuZMwjBdfgQREelozNM6Y0N
 B6WMmGjigAOHOIq2CvVPWrCrUI19Efrffaf7vJ93ZzjZAYL/c9HQQCt13orUX9W/SmFM/cvgzAd5U
 aJZqADEiZtMDVlF+a3GnixeFD5ATCHiTV5T49g0cy5Ip/6IKRIPaxHRXAl1BZUtJcW0B+ZzFsJzEU
 22W9fSeg==;
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUvCW-004hQS-3E
 for linux-nvme@lists.infradead.org; Fri, 09 Apr 2021 17:45:53 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20210409174539euoutp02b1faeb733b0ff246220e6db0fc74f2bf~0QaQm1sDF2616226162euoutp02w
 for <linux-nvme@lists.infradead.org>; Fri,  9 Apr 2021 17:45:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20210409174539euoutp02b1faeb733b0ff246220e6db0fc74f2bf~0QaQm1sDF2616226162euoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1617990339;
 bh=Jxu++ZxUni1dL8jfZhFdbzAKcs/2Xv0quewsG2HVNUw=;
 h=Date:From:To:CC:Subject:In-Reply-To:References:From;
 b=AHQ3v0a1fynxGavI/Vy41nLuuorT7tv2U0HTeJ/uo3Njgu16ZImc9gYpHoPQeESqe
 9QwHvs+ifyi2HjfsecYhSIZwHhHQVfLgNUVsCr8MMqZRco727q627yZkt9xDKH0E9G
 nueiaxFALUoTsRLJshmRAmjibO3h3WS7qbYzTaAw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20210409174539eucas1p29a23de2cc261778bb66fa6e19ee75512~0QaQWQvge3109031090eucas1p2-;
 Fri,  9 Apr 2021 17:45:39 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id B5.BF.09452.3C290706; Fri,  9
 Apr 2021 18:45:39 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20210409174538eucas1p1e2acfed217f87c04f22f1f64cd8d9c23~0QaPVYMdt2353223532eucas1p1h;
 Fri,  9 Apr 2021 17:45:38 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20210409174538eusmtrp1ec377a482a9b9b6a35952fa32f855f7e~0QaPUw0sw0175101751eusmtrp1j;
 Fri,  9 Apr 2021 17:45:38 +0000 (GMT)
X-AuditID: cbfec7f2-ab7ff700000024ec-07-607092c3b059
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 51.6D.08696.1C290706; Fri,  9
 Apr 2021 18:45:37 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20210409174537eusmtip290f30b140a381d5fb91a35cd8378314c~0QaPLH-RN2722827228eusmtip2O;
 Fri,  9 Apr 2021 17:45:37 +0000 (GMT)
Received: from localhost (106.210.248.142) by CAMSVWEXC01.scsc.local
 (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Fri, 9 Apr 2021 18:45:37 +0100
Date: Fri, 9 Apr 2021 19:45:36 +0200
From: Javier Gonz??lez <javier.gonz@samsung.com>
To: Christoph Hellwig <hch@lst.de>
CC: Minwoo Im <minwoo.im.dev@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Kanchan Joshi <joshiiitr@gmail.com>,
 <linux-nvme@lists.infradead.org>
Subject: Re: nvme ioctl refactor and generic per-namespace char device
Message-ID: <20210409174536.ekvhei4nwi67nz5m@mpHalley.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210408120842.1450092-1-hch@lst.de>
X-Originating-IP: [106.210.248.142]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsWy7djPc7qHJxUkGOw8z2KxcvVRJovzbw8z
 WUw6dI3RYv6yp+wWvzq5Lda9fs/iwOaxc9Zddo/z9zayeGxa1cnmsXlJvcfumw1sAaxRXDYp
 qTmZZalF+nYJXBk3171lLmhkrpj5aCdjA+MOpi5GTg4JAROJDz1z2EBsIYEVjBL/12d3MXIB
 2V8YJe6f3MoM4XxmlPh2Zjpcx9GmHhaIxHJGiV0zf7LAVe1fvY8JwtnCKPF991VGkBYWARWJ
 6QsPs4LYbAIGEm9mzQIbJSKgJPH01VlGkAZmga2MEhcO/AG7RFjATeLrx3dgDbwCThKbj/Qw
 Q9iCEidnPmEBsZkFrCQ6PzQB1XAA2dISy/9xQITlJZq3zgYr5xQwkmi7so4FpERCQFli+XRf
 iA9qJdYeO8MOslZC4A2HxJ1n79kgEi4Sh573skLYwhKvjm9hh7BlJE5PhnhZQqCZUeLMmivM
 EE4Po8SfSSsYITZYS/SdyYFocJToePEbKswnceOtIMRtfBKTtk1nhgjzSnS0CU1gVJmF5LFZ
 SB6bhfDYLCSPLWBkWcUonlpanJueWmyYl1quV5yYW1yal66XnJ+7iRGYeE7/O/5pB+PcVx/1
 DjEycTAeYpTgYFYS4W1uzk8Q4k1JrKxKLcqPLyrNSS0+xCjNwaIkzrtq9pp4IYH0xJLU7NTU
 gtQimCwTB6dUAxPn+7hn+9sXfnKfZhpl3hP644Yxm//Phd5MyjsuTqwXlTnOFbb8obi9WPLS
 x7rrl+nf7d/Bndo45///2T4KLhMvRrfNWmp4e1pgif7Deffarz2qyHNiOHedaQvvnq8sW+Q1
 71RotJfGvLnuVFpjYpPoV/f1s9Kj1p1LHA66h7ZOE/yiPFHS8pTqxoPrbwWtcmWc4L7BceXD
 u1bnVjgy/OZ0kmYWarDKvddtc1BJOJRBwnpilYN228Ovk5+WXFHpfZo5Qac+VrJv/RXT3Txb
 +F9dXtxp8kRGZIKlRCm38vVPe57NenxVrDCgZ4/Sui/+Wxk+ujYsZNx6eZWbj+2/CbUtH/K3
 5bbGzb61XzjhjYYSS3FGoqEWc1FxIgAlMosYqwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsVy+t/xe7oHJxUkGDSds7JYufook8X5t4eZ
 LCYdusZoMX/ZU3aLX53cFutev2dxYPPYOesuu8f5extZPDat6mTz2Lyk3mP3zQa2ANYoPZui
 /NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYyb694yFzQy
 V8x8tJOxgXEHUxcjJ4eEgInE0aYeli5GLg4hgaWMEpsWrIJKyEh8uvKRHcIWlvhzrYsNougj
 o8T3BdugnC2MEmcav7KCVLEIqEhMX3gYzGYTMJB4M2sW2CQRASWJp6/OMoI0MAtsZZRof7SK
 DSQhLOAm8fXjO7AGXgEnic1HepghprYySsw6uo0ZIiEocXLmExYQm1nAQmLm/PNAkziAbGmJ
 5f84IMLyEs1bZ4OVcwoYSbRdWccCUiIhoCyxfLovxAe1Eq/u72acwCgyC8nQWUiGzkIYOgvJ
 0AWMLKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzECI3PbsZ9bdjCufPVR7xAjEwfjIUYJDmYl
 Ed7m5vwEId6UxMqq1KL8+KLSnNTiQ4ymwCCayCwlmpwPTA15JfGGZgamhiZmlgamlmbGSuK8
 JkfWxAsJpCeWpGanphakFsH0MXFwSjUwJe3N3PKnJvadwmHFY1yb1m2pTHI6HlFbrPqj4eae
 q5mm/G9Yz7M9W7Tp07xDf//UXKledr/Odp296M0tMj+Ko4uePbv5ifW54J2JQXN/FOWvWNT3
 h8Wm+qeZh9Dpid377YwLOy/2WcYeyplrqr9AXPa9GX+xunrv8kzHMOk4pxsXPM/cviZRIiw4
 oanK6/SexnaXP8+mr9jpHbuUv2VvmcfRAo6EozOSjnc+qUhyBKb1nS/Oeuxvf3Ms+7teyo0J
 Ze5Llneeu6kZf18wZbnoPcF3trfXlxrtUW/7JbIx5mrLqotzDP4mN/EV8It2HE1yV546+UJp
 2OLwhMz8OYe+nN3y72HBqTTtu4/13sUvUmIpzkg01GIuKk4EAITSxgZVAwAA
X-CMS-MailID: 20210409174538eucas1p1e2acfed217f87c04f22f1f64cd8d9c23
X-Msg-Generator: CA
X-RootMTR: 20210408121108eucas1p1fb60de8498a7461b453295497c206246
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210408121108eucas1p1fb60de8498a7461b453295497c206246
References: <CGME20210408121108eucas1p1fb60de8498a7461b453295497c206246@eucas1p1.samsung.com>
 <20210408120842.1450092-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210409_104550_268097_E7E7F347 
X-CRM114-Status: UNSURE (   8.15  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMDguMDQuMjAyMSAxNDowOCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj5IaSBhbGwsCj4K
PnRoaXMgc2VyaWVzIHBpY2tzIHVwIHRoZSBnZW5lcmljIHBlci1uYW1lc3BhY2UgY2hhcmFjdGVy
IGRldmljZQo+ZnJvbSBNaW53b28gYW5kIEphdmllciB3aXRoIGEgZmV3IHNtYWxsIGZpeGVkLCBi
dXQgcmViYXNlcyB0aGVtIG9uCj5hbiBpb2N0bCByZWZhY3RvcmluZyBJIGhhZCBwZW5kaW5nLCB3
aGljaCBjbGVhbnMgdXAgYSBsb3Qgb2YgdGhlCj5sb3dlciBsZXZlbCBjb2RlLgoKWW91IGNhbiBh
bHNvIGFkZCBteSByZXZpZXcgdGFnIGZvciAxLTEyLgoKUmV2aWV3ZWQtYnk6IEphdmllciBHb256
w6FsZXogPGphdmllci5nb256QHNhbXN1bmcuY29tPgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZt
ZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtbnZtZQo=
