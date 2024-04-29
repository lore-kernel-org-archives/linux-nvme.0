Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA7FAC4345F
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Apr 2024 11:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+0XhRoGE1qPFbsa9fpNYLOfvFVjRjsIUSKulInZuNas=; b=fd5Gw2zCWN3ih4Fnd1M7vo4SxU
	AnLdA+jKBQeqsGfDNlLagHS7V9a1Zn2HC+HKgVZXvzXeTxY+FGkgnL+xsOJ8FNGBNqWCycxdEobqe
	08h/WjKM5XyKCoiJ9BK1OxGLBHlIUaJrurcA9h2iNTR1BVYgmgn2o8XYCFmFcylZBi9mKUmC6PG5N
	10PHk5Tujm+AEn1W4DcZ0+yeSECji3OzLymJG2wSWt0OlSR+Ohg6WeX8XCl48hhtQOhXc4kEUAeXR
	OQ2wwxh8R2HBcn3II9V10azydUHFBQ3b6/i7o4Ekk0xEncrK/V8jtcG8qG56PHpBccr33lgbOYv99
	cOCZC25A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1PTb-00000002Vm5-2usl;
	Mon, 29 Apr 2024 11:47:19 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1PTX-00000002Vjf-3LvT
	for linux-nvme@lists.infradead.org;
	Mon, 29 Apr 2024 11:47:18 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240429114711epoutp04121b66d313ab9def1996887cf7a851b2~Kvb4FAEJk0626906269epoutp04L
	for <linux-nvme@lists.infradead.org>; Mon, 29 Apr 2024 11:47:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240429114711epoutp04121b66d313ab9def1996887cf7a851b2~Kvb4FAEJk0626906269epoutp04L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1714391232;
	bh=+0XhRoGE1qPFbsa9fpNYLOfvFVjRjsIUSKulInZuNas=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=SHVchpRVv+87uPt+4nWISGyA97mff9dyU8vgHnQ4kI+vuDpLAhdTVNNA+zCUHbyoO
	 B6HUA8rEmKvURyVIxRc9Z31OmrOzdkRwkzwvoEYLA7Ub7b1db++TQ/WR86pqm9x2EE
	 WBzvLznt7f94HN9Fid8RScLvGMd7Yl3r2WymDqNU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240429114711epcas5p1b423bbbd09b8f8244344da8954c4392d~Kvb3fqGqr2009320093epcas5p17;
	Mon, 29 Apr 2024 11:47:11 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4VShQ61R6xz4x9Px; Mon, 29 Apr
	2024 11:47:10 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	AD.D4.09666.EB88F266; Mon, 29 Apr 2024 20:47:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240429114709epcas5p26c338ab76152b8a5d129144a9e58caef~Kvb16Fndh2821028210epcas5p2m;
	Mon, 29 Apr 2024 11:47:09 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240429114709epsmtrp21fc1f57df3e9cc3c276093230e110bdb~Kvb15abvK0750207502epsmtrp2L;
	Mon, 29 Apr 2024 11:47:09 +0000 (GMT)
X-AuditID: b6c32a49-cefff700000025c2-6b-662f88be12f2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	BF.69.19234.DB88F266; Mon, 29 Apr 2024 20:47:09 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240429114707epsmtip1a4bade1605d78db6ddc0eb14c0b8e031~Kvb0PT69p2805728057epsmtip18;
	Mon, 29 Apr 2024 11:47:07 +0000 (GMT)
Message-ID: <2f70941e-2a46-8e58-bb5f-97e9b8fccdda@samsung.com>
Date: Mon, 29 Apr 2024 17:17:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH 09/10] block: add support to send meta buffer
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, hch@lst.de,
	brauner@kernel.org, asml.silence@gmail.com, dw@davidwei.uk,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com, Anuj Gupta
	<anuj20.g@samsung.com>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <ZivGhB0rGwBb8Eic@kbusch-mbp.dhcp.thefacebook.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMJsWRmVeSWpSXmKPExsWy7bCmpu6+Dv00g0WXOCyaJvxltpizahuj
	xeq7/WwWrw9/YrR4NWMtm8XNAzuZLFauPspk8a71HIvFpEPXGC323tK2mL/sKbvF8uP/mBx4
	PK7NmMjisXPWXXaPy2dLPTat6mTz2Lyk3mP3zQY2j49Pb7F49G1ZxejxeZNcAGdUtk1GamJK
	apFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0MFKCmWJOaVAoYDE
	4mIlfTubovzSklSFjPziElul1IKUnAKTAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMb3d3MBds
	Zqq4tG0rewPjd8YuRg4OCQETiX+bnLsYOTmEBHYzSjx/otTFyAVkf2KU+LL8Nzucc7xzAwtI
	FUjDrpON7BAdOxklvl4qhSh6yyjxeOJTNpAEr4CdxPzZe8FsFgFViX2/drJCxAUlTs58AjZI
	VCBZ4mfXAbAaYQFHiQ3rN4LZzALiEreezGcCsUUElCXuzp/JCrKAWaCfSeJo3zcmkLPZBDQl
	LkwuBanhFLCXaOnsZYXolZfY/nYOM0i9hMAJDomV+56xQVztIrFh70NmCFtY4tXxLewQtpTE
	53d7oWqSJS7NPMcEYZdIPN5zEMq2l2g91c8MspcZaO/6XfoQu/gken8/YYKEIq9ER5sQRLWi
	xL1JT1khbHGJhzOWQNkeElOPPoMG6HtGiXkLe5gnMCrMQgqWWUjen4XknVkImxcwsqxilEwt
	KM5NTy02LTDMSy2HR3dyfu4mRnBq1vLcwXj3wQe9Q4xMHIyHGCU4mJVEeDfN0U4T4k1JrKxK
	LcqPLyrNSS0+xGgKjJ+JzFKiyfnA7JBXEm9oYmlgYmZmZmJpbGaoJM77unVuipBAemJJanZq
	akFqEUwfEwenVAPT+quLfy8x837Qvzkg4svfudUx7Ge9pkzpKX+8uo1jyayF4X8j1wvscvXM
	tvRaIOJYzbr78dr7gmdvLpM6/Ujbwl76p5lEZ13DW4uVMwuP9aTHFt0yWu88PSlJsHhbarvK
	Rk795+b87wO9chtsZl6q/P/+lcSE5Ij//Pbcd6Lvhh5ssn4vOde9XyQpyOf4R+ttwidvHrB4
	WXRzorzK2RVKFXqfDofbxnzZvGtu2vmMavkzO6LnH1XcYbjldrBk7MKsuOaQxw2HrJeG1r7i
	3mB5Re7JKZtFG01FvmxZenKxpvEb57Te2e6nfunEVnZfcNh/bdmc+LmmkysZCrT+b5+oytC2
	8/8+sQn3q3z1nS7vVmIpzkg01GIuKk4EALHUnPtWBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsWy7bCSnO7eDv00g0snVCyaJvxltpizahuj
	xeq7/WwWrw9/YrR4NWMtm8XNAzuZLFauPspk8a71HIvFpEPXGC323tK2mL/sKbvF8uP/mBx4
	PK7NmMjisXPWXXaPy2dLPTat6mTz2Lyk3mP3zQY2j49Pb7F49G1ZxejxeZNcAGcUl01Kak5m
	WWqRvl0CV8a3uzuYCzYzVVzatpW9gfE7YxcjJ4eEgInErpON7F2MXBxCAtsZJTru7WeGSIhL
	NF/7wQ5hC0us/Pccqug1o8TuX7NZQBK8AnYS82fvZQOxWQRUJfb92skKEReUODnzCViNqECy
	xMs/E8EGCQs4SmxYvxGsnhlowa0n85lAbBEBZYm782eygixgFuhnktj4fgcTxLb3jBL79k0E
	ynBwsAloSlyYXArSwClgL9HS2csKMchMomtrFyOELS+x/e0c5gmMQrOQ3DELyb5ZSFpmIWlZ
	wMiyilE0taA4Nz03ucBQrzgxt7g0L10vOT93EyM4CrWCdjAuW/9X7xAjEwfjIUYJDmYlEd5N
	c7TThHhTEiurUovy44tKc1KLDzFKc7AoifMq53SmCAmkJ5akZqemFqQWwWSZODilGpi0vQUb
	5Cam20azzvrmfvMta+6kp0Y3V3Pw7HoRY5Evsq6Y5Uijz/rZJ1rfMNpM2cL+Jo1ZNejzncJv
	lyotjb5N7vz4+bAm/zWB8oy4neKSs8SmbZwp0WQloRx128vD9MLcO4fnTLR4KfThTNrbeJPK
	W49yo+dMyK64UK4w1XdHv33Z/H2pklZFi/+1Xvj8SeUz8+vVp3iEUliUbso/jry/K+bn0+h7
	d8LPd+Q+e9cbKPeQs9sydGlV+cJFj24fcLprdOPjkgN3X7NoCFsJbCs5L9I06+W5Q2+Xqzr8
	Dzk1a6FM5+IzBvKRU+MtmP2Wsk/XON+swWvB2OI151JPhJkWOw9n+vmpORYXHXoC2R2VWIoz
	Eg21mIuKEwENPLVuMQMAAA==
X-CMS-MailID: 20240429114709epcas5p26c338ab76152b8a5d129144a9e58caef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240425184708epcas5p4f1d95cd8d285614f712868d205a23115
References: <20240425183943.6319-1-joshi.k@samsung.com>
	<CGME20240425184708epcas5p4f1d95cd8d285614f712868d205a23115@epcas5p4.samsung.com>
	<20240425183943.6319-10-joshi.k@samsung.com>
	<ZivGhB0rGwBb8Eic@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240429_044716_585273_D4EDF064 
X-CRM114-Status: UNSURE (   9.08  )
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

On 4/26/2024 8:51 PM, Keith Busch wrote:
> Should this also be done for __blkdev_direct_IO and
> __blkdev_direct_IO_simple?


Right, this needs to be done for __blkdev_direct_IO.

But not for __blkdev_direct_IO_simple as that is for sync io. And we are 
wiring this interface up only for async io.

