Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C934FD2AB3C
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 12:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+N9xNxcRiyZbnIppftSwJNIxmvNHQi1WtyZiPy4I7wY=; b=SmxUV6OQOuknm8wWHP5fXcRCfw
	i5/F9OS7lM2ltE+TCavR8+lsiVbxoDyIeJp70I6eEep/SdjTMvZE9OHwe/QYZztW1sC19ocEzGxTo
	DmOuVp8V4S750KIXMUktotva5EL8HtsPKQHZCgUDi7JitX3/QY7qgxGJIy3sX90milJiZjc9d73Vn
	1keUdg8eXiLyRIsg7PloCQZwYwKjPIxs78ArZUAg3d0Za7QYiI71MYRvOl4jqDgkCqy7YnmKzfy7v
	qj3+Ow5gCqdQryR3XffdaTgZW2DEFoEOFWo8mQhtv0Bcg0EUwswDft1lMs2oWhkWo4UyGXKP4Rq16
	6rE8l4Zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5lkE-0000000ETcy-0iTs;
	Tue, 29 Oct 2024 12:54:46 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5kzy-0000000ELLD-3Tbd
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 12:07:01 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20241029120651epoutp0101048c5deceb921199c8cd8458b40a9d~C6wSU3-BA2872628726epoutp01U
	for <linux-nvme@lists.infradead.org>; Tue, 29 Oct 2024 12:06:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20241029120651epoutp0101048c5deceb921199c8cd8458b40a9d~C6wSU3-BA2872628726epoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1730203611;
	bh=+N9xNxcRiyZbnIppftSwJNIxmvNHQi1WtyZiPy4I7wY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HKW8Qy5ir7b0hJreaIFRhpZrRrzRPwxSxtnrrsx6Qi4il4qOB+bRF5goueb9hCEjx
	 dG+uMPy4qxV+bb3i27aDReX+3ZLq1rcZk9VFnfFiono54wRd8yUEYhI6HnqUS2RyRG
	 XE2NasqYYz1Mck3cWbvkOm8R3zba4brjFaR2Pj4Q=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20241029120651epcas5p421e7f1f7a1e9140df1e86ed233c417fb~C6wR_pJh_0675006750epcas5p4V;
	Tue, 29 Oct 2024 12:06:51 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Xd8BL07VSz4x9Pv; Tue, 29 Oct
	2024 12:06:50 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	31.5B.09800.9DFC0276; Tue, 29 Oct 2024 21:06:49 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20241029120623epcas5p1a6a1a190b252cd2be568a08e9ffd9457~C6v4TDX4R1417314173epcas5p1B;
	Tue, 29 Oct 2024 12:06:23 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241029120623epsmtrp22e73a1d129cc45e5af406200e27bb3b9~C6v4JroUw2161321613epsmtrp22;
	Tue, 29 Oct 2024 12:06:23 +0000 (GMT)
X-AuditID: b6c32a4b-23fff70000002648-e8-6720cfd9bf80
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	DC.60.07371.FBFC0276; Tue, 29 Oct 2024 21:06:23 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20241029120622epsmtip1c38cdcf61c2e13292cf9d27070aa1044~C6v3Fqf_U2272722727epsmtip1T;
	Tue, 29 Oct 2024 12:06:22 +0000 (GMT)
Date: Tue, 29 Oct 2024 17:27:25 +0530
From: Anuj Gupta <anuj20.g@samsung.com>
To: Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, martin.petersen@oracle.com, Keith Busch
	<kbusch@kernel.org>
Subject: Re: [PATCH] blk-integrity: remove seed for user mapped buffers
Message-ID: <20241029115725.GA20732@green245>
MIME-Version: 1.0
In-Reply-To: <20241016201309.1090320-1-kbusch@meta.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmlu7N8wrpBo+3mVqsvtvPZrFy9VEm
	i0mHrjFanLm6kMVi7y1ti/nLnrJbLD/+j8mB3ePy2VKPTas62Tw2L6n32H2zgc3j3MUKj49P
	b7F4fN4kF8AelW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg
	65aZA3SMkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafApECvODG3uDQvXS8vtcTK
	0MDAyBSoMCE7Y/KV7YwF69gqzvyfy9LAuI61i5GTQ0LARGLj1J3MXYxcHEICuxklrr0CSYA4
	nxglvq14ygRSJSTwjVHi/8sMmI5lS2ZDxfcySrSsqoFoeMYosevlTnaQBIuAqsSu5RMZQWw2
	AXWJI89bwWwRAUWJ88CQAGlgFpjLKPFzwWMWkISwgLvE07UdbCA2r4CuxPHFrcwQtqDEyZlP
	wGo4Bcwl5q/cDbZAVEBZ4sC240wQF7VySPQ/VISwXSTaP61ggbCFJV4d38IOYUtJfH63lw3C
	Tpf4cfkpVG+BRPOxfYwQtr1E66l+sL3MAhkSs1+uhpojKzH11DomiDifRO/vJ1C9vBI75sHY
	ShLtK+dA2RISe881QNkeEt/bTkCDtItR4vbCeWwTGOVnIfltFpJ9ELaOxILdn9hmMXIA2dIS
	y/9xQJiaEut36S9gZF3FKJlaUJybnlpsWmCcl1oOj/Dk/NxNjOC0quW9g/HRgw96hxiZOBgP
	MUpwMCuJ8K6OlU0X4k1JrKxKLcqPLyrNSS0+xGgKjKyJzFKiyfnAxJ5XEm9oYmlgYmZmZmJp
	bGaoJM77unVuipBAemJJanZqakFqEUwfEwenVAOT7tpdRY8434aGdBk9v5yQ/Jn55alfl/L7
	eaZdFpdwOH7wtvW7X2vv3eT68/PUz6l2R5ikA/ztOdR+61wKbOB7dCsv8w7fdD2/z7I1O/5k
	169z1+9I9biXHvzmk8Gh0zcUFIrmXZtz/O+Fb0lLZv5buDhyF3dWxLN4jw2LkvJmeHzjN5V/
	OkVmXb2DZvP2YPmtPVuzHqWqblvPq6f84cjFU4VWDMcFGpMvVOoKaQov3PrpcY7D2clZdfsj
	T28+1JXQfGTt+VXmZpfOTJut7P2ZISwr4/dsIY/o7sn6zo9Din/l711zkCslxiNzad62KGND
	M7bStCa+v3x7rYW/cB16sr1L6YRxicQ3xWyhQ8mXlViKMxINtZiLihMBr7typjQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSnO7+8wrpBlOeKlusvtvPZrFy9VEm
	i0mHrjFanLm6kMVi7y1ti/nLnrJbLD/+j8mB3ePy2VKPTas62Tw2L6n32H2zgc3j3MUKj49P
	b7F4fN4kF8AexWWTkpqTWZZapG+XwJUx82JRwTvmimfTDrE1MLYzdzFyckgImEgsWzKbqYuR
	i0NIYDejRHNnEyNEQkLi1MtlULawxMp/z9khip4wSiz4Mp0JJMEioCqxa/lEsCI2AXWJI89b
	wWwRAUWJ80DngDQwC8xllFhxZyFYg7CAu8TTtR1sIDavgK7E8cWtzBBTuxglphz8zAqREJQ4
	OfMJC4jNLKAlcePfS6BmDiBbWmL5Pw6QMKeAucT8lbvZQWxRAWWJA9uOM01gFJyFpHsWku5Z
	CN0LGJlXMUqmFhTnpucmGxYY5qWW6xUn5haX5qXrJefnbmIER4SWxg7Ge/P/6R1iZOJgPMQo
	wcGsJMK7OlY2XYg3JbGyKrUoP76oNCe1+BCjNAeLkjiv4YzZKUIC6YklqdmpqQWpRTBZJg5O
	qQamlxE3Cy9M7s5aUGnIe6hMcaFP8GQzHyaBiaL31QM3Klwyn7B6699aedWvypkHJ68ql0hJ
	8t0YnbE1oStNd17UcbkZZqqn+Vb+lu0XEjwZYL3c/VvRErWqqnibw4dO/fX85HejOlryUZDT
	vKCowI1G1eer/iSUHPa2nPuQ64KFsNrySKvWBie/Cge1zfqF7x7w3F296/hr/SM/q6/K5J4I
	emEbds9N1nXFylmvq82PMS2YnOnfrrq9OfnNwq0nFgYtLOjhSvzXcEw8z1JXUzw0eWmHQpTp
	m/k5rbI+4gtes9ZMO+bfusv26xfFGR2a1yInqb09oKnVcn1+y4ufsv9efS91vOrfV7Vi4YrX
	+54qsRRnJBpqMRcVJwIAlrrnxfcCAAA=
X-CMS-MailID: 20241029120623epcas5p1a6a1a190b252cd2be568a08e9ffd9457
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----Q5hryimWBrG20CTDo2Cycv07rC8cEZ5s1mVzGfufIajJO9l9=_86545_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241016201330epcas5p33226adcbff73f7df7cced504aea64a13
References: <CGME20241016201330epcas5p33226adcbff73f7df7cced504aea64a13@epcas5p3.samsung.com>
	<20241016201309.1090320-1-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_050659_553231_8727DC2E 
X-CRM114-Status: GOOD (  16.06  )
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

------Q5hryimWBrG20CTDo2Cycv07rC8cEZ5s1mVzGfufIajJO9l9=_86545_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Wed, Oct 16, 2024 at 01:13:09PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The seed is only used for kernel generation and verification. That
> doesn't happen for user buffers, so passing the seed around doesn't
> accomplish anything.

Looks fine. I can do the seed handling for io_uring metadata series
in the upper block layer functions, and hence won't rely on this
infra.

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>

> -- 
> 2.43.5
> 
> 

------Q5hryimWBrG20CTDo2Cycv07rC8cEZ5s1mVzGfufIajJO9l9=_86545_
Content-Type: text/plain; charset="utf-8"


------Q5hryimWBrG20CTDo2Cycv07rC8cEZ5s1mVzGfufIajJO9l9=_86545_--

