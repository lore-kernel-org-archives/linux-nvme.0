Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90956D5B874
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 04:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T6j6jm70Mz/zmXUura75TLRWqxS45T3i+a6hnD42wjU=; b=vblwsTaEaD+n/hxHzhCkAU9f5h
	3beS6Kz1nQmXVDzUT3H2scHGOM6GUBxR/Ik5OSnRL5JkpE6wTMQfVWginCntHLHb+2nNcQrPSfpSA
	Qyb6eZIRBKbk4pZc2W745qaObuUL/DbeyKIpVoTcBB2xVhx26j5RNLPmYtzcQ7vlUnikZ5i5zf7S6
	OJK02XBkSfyQJpFD3CqQq6KyHpYWLPFFHyal5BkyM6FDBBgR0OFzaF4uoZQgIUbRIUHG9KNTRouzQ
	45oaYpZN/Ci6MlcYLyx8XYroNeoutsZCEk/VaGjHjJ7YyVsTy6+bJTp/s3AsppVaqvkp4MOKiGsvx
	eAFyvIyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5dnp-0000000DAqf-1dKb;
	Tue, 29 Oct 2024 04:25:57 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5dnk-0000000DAph-3cMF
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 04:25:55 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241029042547epoutp036f6729d2264b7713b5d377144662bd9f~C0dtqWtru0375003750epoutp03a
	for <linux-nvme@lists.infradead.org>; Tue, 29 Oct 2024 04:25:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241029042547epoutp036f6729d2264b7713b5d377144662bd9f~C0dtqWtru0375003750epoutp03a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1730175947;
	bh=T6j6jm70Mz/zmXUura75TLRWqxS45T3i+a6hnD42wjU=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Wwiq8v9NfMwejUHjOzRe0Xixn6dbYeryGl09qERt8OGB7cPSPJDkB4Tjhp2rumXL6
	 1Pt4I5zriKogpQqueHwWOeUQ9VbNtQbfkRNTNpCkoP5o09i6SJwEHJjEx70EmsV4eg
	 lgtgwzFz7DYMx4ksLj2ys7IQGTbGHSj5lqJC0jAw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20241029042546epcas5p3da74ec9e1c2902fb8db6219565b161b4~C0ds3Fk7y0536605366epcas5p3r;
	Tue, 29 Oct 2024 04:25:46 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4XcxyK065Hz4x9Pp; Tue, 29 Oct
	2024 04:25:45 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	CA.AE.09800.8C360276; Tue, 29 Oct 2024 13:25:44 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20241029042544epcas5p1cbf95f364afb23b3029e6166814eee5d~C0dq9ftPU0566605666epcas5p1J;
	Tue, 29 Oct 2024 04:25:44 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241029042544epsmtrp140cd23addc9f0be5555eb6a912b0cd49~C0dq8zBRK3119131191epsmtrp1B;
	Tue, 29 Oct 2024 04:25:44 +0000 (GMT)
X-AuditID: b6c32a4b-4a7fa70000002648-18-672063c8d77d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	03.C3.08229.8C360276; Tue, 29 Oct 2024 13:25:44 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241029042543epsmtip2b7afc059a49cc5a95aff40711423015b~C0dp561EF1962219622epsmtip2V;
	Tue, 29 Oct 2024 04:25:43 +0000 (GMT)
Message-ID: <7e723041-9b78-4c08-9ff7-d1041797f1d3@samsung.com>
Date: Tue, 29 Oct 2024 09:55:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: re-fix error-handling for io_uring
 nvme-passthrough
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	hch@lst.de
Cc: anuj20.g@samsung.com, Keith Busch <kbusch@kernel.org>, Jens Axboe
	<axboe@kernel.dk>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20241028205253.2054407-1-kbusch@meta.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGJsWRmVeSWpSXmKPExsWy7bCmhu6JZIV0g73zrCyaJvxltlh9t5/N
	YuXqo0wWkw5dY7Q4c3Uhi8X8ZU/ZHdg8Lp8t9di0qpPNY/OSeo/dNxvYPM5drPDo27KKMYAt
	KtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+gIJYWy
	xJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BSYFecWJucWleul5eaomVoYGBkSlQYUJ2
	Rn/7SbaCScwV3UvWszQwXmTqYuTkkBAwkTjWOJG9i5GLQ0hgN6PE0bXXmCCcT4wSi2dfYQGp
	EhL4xijxqy0cpuP5q2OMEEV7GSXOnn/KAuG8ZZSYe/IzI0gVr4CdxP62w2wgNouAqsSfeV1s
	EHFBiZMzn4BNFRWQl7h/awY7iC0sECBx+NJK5i5GDg4RAX+JC49cQMLMApES66d8ZIawxSVu
	PZnPBFLCJqApcWFyKUiYU8BcovvZXzaIEnmJ7W/nMEPc2cohMX+mLITtIvHg1CNGCFtY4tXx
	LewQtpTEy/42KDtb4sGjBywQdo3Ejs19rBC2vUTDnxusIGuZgdau36UPsYpPovf3E7BrJAR4
	JTrahCCqFSXuTXoK1Sku8XDGEijbQ6Jj7l1WSEB1MUo0nPrCMoFRYRZSmMxC8uQsJN/MQti8
	gJFlFaNkakFxbnpqsWmBcV5qOTy2k/NzNzGCE6iW9w7GRw8+6B1iZOJgPMQowcGsJMK7OlY2
	XYg3JbGyKrUoP76oNCe1+BCjKTByJjJLiSbnA1N4Xkm8oYmlgYmZmZmJpbGZoZI47+vWuSlC
	AumJJanZqakFqUUwfUwcnFINTO3OXrvZ2998zVo8lTtv4TnLzNBn05fvmctrOvc+w7r7i1c1
	K2lI3J4/61ycm3KqxY1q1smnvOyUrL9En7pabv9A/UPHgYevlffN9Vs654LCbWM9gcXC6Tct
	oz7oT1xwccVSNplKiZTn5ekuh202LOfo2NshJtf/b8myacra2100WVP2K/15Mn/ifDuXhjph
	W1cFIfZveati2s9e1zZ4MeXFtXcehXy9b0JNpFl/3JSt4fI8tFe6xzbVd4vEcs7GWZ998nw8
	trtLHH338uKj42JyMn4/t397tVWeOVX4tfjhAF5Xp6/+cfOl9l0r2jXj0czf+sLMLbWzpf81
	/zyzcde2aby2c9XdSuzuVR2cOVeJpTgj0VCLuag4EQBaS2nXKQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsWy7bCSvO6JZIV0g3fv2SyaJvxltlh9t5/N
	YuXqo0wWkw5dY7Q4c3Uhi8X8ZU/ZHdg8Lp8t9di0qpPNY/OSeo/dNxvYPM5drPDo27KKMYAt
	issmJTUnsyy1SN8ugSujv/0kW8Ek5oruJetZGhgvMnUxcnJICJhIPH91jLGLkYtDSGA3o0Tj
	tf2sEAlxieZrP9ghbGGJlf+es0MUvWaUaDv3DSzBK2Ansb/tMBuIzSKgKvFnXhcbRFxQ4uTM
	JywgtqiAvMT9WzPA6oUF/CT23TgHZosI+Ep8nvYV6AoODmaBSIk/Cywh5ncxSky9+hbsCGag
	I249mQ9WwyagKXFhcilImFPAXKL72V82iBIzia6tXYwQtrzE9rdzmCcwCs1CcsUsJJNmIWmZ
	haRlASPLKkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M4IjR0tzBuH3VB71DjEwcjIcY
	JTiYlUR4V8fKpgvxpiRWVqUW5ccXleakFh9ilOZgURLnFX/RmyIkkJ5YkpqdmlqQWgSTZeLg
	lGpgkj2RpxN8Mm3fau3OE6+uCYUktJvInn3iEtKfv2pW5aa8X9vFdpll+6YqsMWxpFqeCwxU
	enyIOZSfa2rv5Gotu7wtUdxv2vd8kF3hv63PZvv1OI+nkgcOd2WtfrFWMmBOxZUQOfuOmRJ/
	xJZcm1q5/s/uE1xN584nXUq56JdZeyOUqSGV632j4rMYwXVnRepDaqPNL9ywk9Ccb3R+HQf3
	/u3aYdKl044GXU2K0bqrbOn3YNaNXzvfyKmu+BLs17wxR2Z19rXkvaJW94P+OF1dwrxf/0zX
	9boJU61d6+penur83G/VdXKmg2SoQclXNxeh7f1373eKZOdHKb9bM1dkb03RuQ9TRecHcOr1
	ibQosRRnJBpqMRcVJwIA0Zjk3wcDAAA=
X-CMS-MailID: 20241029042544epcas5p1cbf95f364afb23b3029e6166814eee5d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241028211654epcas5p19ea63d394a4faea81e54514ac6252271
References: <CGME20241028211654epcas5p19ea63d394a4faea81e54514ac6252271@epcas5p1.samsung.com>
	<20241028205253.2054407-1-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_212553_398454_2359D4FA 
X-CRM114-Status: GOOD (  10.47  )
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

On 10/29/2024 2:22 AM, Keith Busch wrote:
> From: Keith Busch<kbusch@kernel.org>
> 
> This was previously fixed with commit 1147dd0503564fa0e0348
> ("nvme: fix error-handling for io_uring nvme-passthrough"), but the
> change was mistakenly undone in a later commit.
> 
> Fixes: d6aacee9255e7f ("nvme: use bio_integrity_map_user"

Looks good.
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

