Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640E2E7717F
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2024 07:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h/3fWvhBo5ziPTr8sALnHcTet2dmKiQ09pXjyBQeOjg=; b=OpCk+2uUfPLLZjCBMVz9GD6ZRe
	aud6CvXeacy34hAPT+VZIWlHJIPnY3xNYFH3EeuGSyBxhQWHhRFHzl0xpL9FvOFgf/+arvNCi0h3I
	JrcxtUzmD4dziaJ7kE+fJYD7iCObmd4cVqHwM9UrRqtF3AnoT/BxxARrOL0urWtfqgfNVh6f+rlpk
	o5nvTKk+KefnkXwzx1KEIa5j9B+qAZUhYFYLJXJRgSKCBwjvypr80K0e29neR3sI5WS723vJ6rTef
	QwOFcv2ccngrVp7ziX6o5AljaV2jbkySE1cMuJIZri/XdSOdXlZNwI/wtPCHrfcGmb4P5RM5D5fay
	2zuE+Ldg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKv9W-0000000AdRS-2i0y;
	Tue, 10 Dec 2024 07:59:30 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKv9T-0000000AdP5-0gSN
	for linux-nvme@lists.infradead.org;
	Tue, 10 Dec 2024 07:59:28 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241210075923epoutp03e42a622563f64d706a4aa3afb9683d5b~PweNYHxO22893228932epoutp03s
	for <linux-nvme@lists.infradead.org>; Tue, 10 Dec 2024 07:59:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241210075923epoutp03e42a622563f64d706a4aa3afb9683d5b~PweNYHxO22893228932epoutp03s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733817563;
	bh=h/3fWvhBo5ziPTr8sALnHcTet2dmKiQ09pXjyBQeOjg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M76F21MlhD35AJeo0w2AiCWBJczhtwN5jVMVqtOrlUhs9QmM/MMohLtOzvEuHyPzt
	 9ldvQnO1kDPY5F5lsi2eCuckReglW1UDXUx+PtItPWBiqApDML/SfeHVyh2HigE2jF
	 ZLAhIgolVAM2H2kO+VyG/81Czn83h+ZHZhRNVfqU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20241210075923epcas5p277add695cbad2d519247d666fd9c6721~PweNERR3Z2363723637epcas5p2x;
	Tue, 10 Dec 2024 07:59:23 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Y6rjP3JtYz4x9QG; Tue, 10 Dec
	2024 07:59:21 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E7.53.29212.9D4F7576; Tue, 10 Dec 2024 16:59:21 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20241210075259epcas5p23bbb79cdb18ddbfad337d764d4fe75da~PwYn7_1Xi3210632106epcas5p24;
	Tue, 10 Dec 2024 07:52:59 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241210075259epsmtrp2f11746f760861303bbe9740b41ca0d4e~PwYn7JUK-0373703737epsmtrp27;
	Tue, 10 Dec 2024 07:52:59 +0000 (GMT)
X-AuditID: b6c32a50-7ebff7000000721c-fc-6757f4d9ed58
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	0C.39.18729.B53F7576; Tue, 10 Dec 2024 16:52:59 +0900 (KST)
Received: from ubuntu (unknown [107.99.41.245]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20241210075257epsmtip2931b210b4f3f67f716b34a50372e4d50~PwYmHFXoC0235202352epsmtip2A;
	Tue, 10 Dec 2024 07:52:57 +0000 (GMT)
Date: Tue, 10 Dec 2024 13:15:05 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, sagi@grimberg.me, asml.silence@gmail.com,
	anuj20.g@samsung.com, joshi.k@samsung.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv12 05/12] block: introduce a write_stream_granularity
 queue limit
Message-ID: <20241210074450.otutruwtmy76y5jm@ubuntu>
MIME-Version: 1.0
In-Reply-To: <20241206221801.790690-6-kbusch@meta.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBJsWRmVeSWpSXmKPExsWy7bCmpu7NL+HpBtOXSFg0TfjLbDFn1TZG
	i9V3+9ksVq4+ymTxrvUci8XR/2/ZLCYdusZocebqQhaLvbe0LfbsPcliMX/ZU3aLda/fszjw
	eOycdZfd4/y9jSwel8+Wemxa1cnmsXlJvcfumw1sHucuVnj0bVnF6PF5k1wAZ1S2TUZqYkpq
	kUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QvUoKZYk5pUChgMTi
	YiV9O5ui/NKSVIWM/OISW6XUgpScApMCveLE3OLSvHS9vNQSK0MDAyNToMKE7IzdG+6wFexk
	rZjxZwNLA+Mzli5GTg4JAROJexP+M4PYQgJ7GCXe/QvuYuQCsj8xSuw+0sYEkfjGKNF9VA2m
	4dHdSywQRXsZJSbMW80K4TwBcg5sYeti5OBgEVCVuPGyGMRkE9CWOP2fA6RXREBR4jwwHEDK
	mQUmMkn8PtTEDpIQFgiX2LvpLlgrL9CC693aIGFeAUGJkzOfgB3KKWAmMX3KPmaQXgmBtRwS
	n2dfZYI4yEXi75GbbBC2sMSr41vYIWwpic/v9kLFyyVWTlnBBtHcwigx6/osRoiEvUTrqX6w
	95kFMiSe/J3JChGXlZh6ah0TRJxPovf3E6hlvBI75sHYyhJr1i+AWiApce17I5TtIdG0/A07
	JFC2Mkq0vNzBPIFRbhaSj2Yh2QdhW0l0fmgCsjmAbGmJ5f84IExNifW79Bcwsq5ilEotKM5N
	T002LTDUzUsth0dycn7uJkZwEtYK2MG4esNfvUOMTByMhxglOJiVRHg5vEPThXhTEiurUovy
	44tKc1KLDzGaAiNoIrOUaHI+MA/klcQbmlgamJiZmZlYGpsZKonzvm6dmyIkkJ5YkpqdmlqQ
	WgTTx8TBKdXAxH04Jm/L/McnTzSX3HL/ccg4XJtj06p8b36pwny71Z7fxWrDM3t1jxas8lh0
	5XXN9IXHDszgy2c452v9mtl04/zgiTfnWTtduz/lAtcyE11fu6fb+WNidki/On1XdOOv811r
	hf/KfrnnP/3941nfX/9mq1pzyKNxXUPjrMP5e11n+gkvyWr76PDUYV5bW2Tf/19LOWetvOu/
	fp70weWJvI76KQ47Jpw2mfGJ0cdlwkb34jLrkLCzTj+dO66fvOoxvfeKnt7sa6FPJ1c+uzPV
	U0Vqp1iRx49V0j/XPbA533mwr/e6/JmC/j1vK/b7N22ofWMp/vFuft4qRlmjavcvb2a+m/Hp
	zNkc7/DAW7bHX1QosRRnJBpqMRcVJwIAq+z/40sEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsWy7bCSvG705/B0g+VdRhZNE/4yW8xZtY3R
	YvXdfjaLlauPMlm8az3HYnH0/1s2i0mHrjFanLm6kMVi7y1tiz17T7JYzF/2lN1i3ev3LA48
	Hjtn3WX3OH9vI4vH5bOlHptWdbJ5bF5S77H7ZgObx7mLFR59W1YxenzeJBfAGcVlk5Kak1mW
	WqRvl8CV8WHRU5aC10wVy3tXsjYwbmLqYuTkkBAwkXh09xJLFyMXh5DAbkaJHxMmskEkJCWW
	/T3CDGELS6z895wdougRo8TW5V+BOjg4WARUJW68LAYx2QS0JU7/5wApFxFQlDgPdA1IObPA
	ZCaJ5zOPsYAkhAXCJfZuussGUs8LtPh6tzZIWEggUaJv5lZ2EJtXQFDi5MwnYOXMAmYS8zY/
	ZAYpZxaQllj+D2w8J1B4+pR9zBMYBWYh6ZiFpGMWQscCRuZVjJKpBcW56bnFhgWGeanlesWJ
	ucWleel6yfm5mxjBkaOluYNx+6oPeocYmTgYDzFKcDArifByeIemC/GmJFZWpRblxxeV5qQW
	H2KU5mBREucVf9GbIiSQnliSmp2aWpBaBJNl4uCUamDKV5EUVz7WsvDHOqE9Z+5ZxqhulYhd
	c0GI/dLL41xThTj/vzxzdUrqW2eVxU+mmC//cmeNKYfh6xvBV1679BRNVHp8pdHz7LYDd2Z9
	K2qXiLxt8tW63Kir5WtL+cf7nVkJwQ8y/ha17FL+vu7CzB08cw1VnCZyZ9Yv3/YtsO52yj8R
	id2XhC5UXLg5o95lXcj3wmv9zf9jU8TPq4iwaX5rdTnh37z3YfWRi33Gxzb1BD9tXboyN9Jy
	4f3Deh9Nz+4yW23l0yzDxZ7wtq9R/2Dw8kni2SsDow6z/3raXbb26MpD5zY5fXDJVqppKlpo
	uLW34Ibpvs96gcfSGVZE26fvNNS/L1Q45WqyslOuuL+/EktxRqKhFnNRcSIACwnopAsDAAA=
X-CMS-MailID: 20241210075259epcas5p23bbb79cdb18ddbfad337d764d4fe75da
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----x2Ox1x5iNi7PYvDn9sIpGVgpr3_-t8l_a8xeGFysXFeU9Shi=_7161d_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241210075259epcas5p23bbb79cdb18ddbfad337d764d4fe75da
References: <20241206221801.790690-1-kbusch@meta.com>
	<20241206221801.790690-6-kbusch@meta.com>
	<CGME20241210075259epcas5p23bbb79cdb18ddbfad337d764d4fe75da@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_235927_551090_9E3264D8 
X-CRM114-Status: UNSURE (   8.58  )
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

------x2Ox1x5iNi7PYvDn9sIpGVgpr3_-t8l_a8xeGFysXFeU9Shi=_7161d_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 06/12/24 02:17PM, Keith Busch wrote:
>From: Christoph Hellwig <hch@lst.de>
>
>Export the granularity that write streams should be discarded with,
>as it is essential for making good use of them.
>
>Signed-off-by: Christoph Hellwig <hch@lst.de>
>Signed-off-by: Keith Busch <kbusch@kernel.org>
>---

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------x2Ox1x5iNi7PYvDn9sIpGVgpr3_-t8l_a8xeGFysXFeU9Shi=_7161d_
Content-Type: text/plain; charset="utf-8"


------x2Ox1x5iNi7PYvDn9sIpGVgpr3_-t8l_a8xeGFysXFeU9Shi=_7161d_--

