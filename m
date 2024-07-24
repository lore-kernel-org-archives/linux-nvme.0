Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFA9C3DA49
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jul 2024 04:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hm6FD2Ug5c3pOe9Qm89s7IFoHzb9JCpzfyhKV9uY+fU=; b=Mu3TvR/qETSkaZ64KhpJIdUNl9
	Wmzb4HKhTf2CGOqrMGqg5yyDaVTgsF9zmi+6rxL46MBXu55ZwSNACc7Reh+vHlarNtnGcPWVLW+7a
	+NeJvRXWCQvGA7YSF3bS6rvUGXC9tIYSj+GRfcnAZ1ntZLJLvngpqRiH0gG+Q+xuSs3JhbuXFK2yS
	+OlehOV8Z3BztQfcqMxmFqqZ8BgW19L3clzvg8lnSGHE46k5oR+6BT1e6uEXyNlELac3WuMi7GjtJ
	Jr1ieaZf1S3tlWHUGXN7qxhr5IvQhcIjNKG+aSL1qDb5AiPWsVNVGtrkaSYwOfdNfGw10zpaAPoCx
	76FWYZzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWqYt-0000000HP5Q-3oCm;
	Thu, 25 Jul 2024 04:58:43 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWqYe-0000000HOzv-2gBV
	for linux-nvme@lists.infradead.org;
	Thu, 25 Jul 2024 04:58:34 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240725045819epoutp0186519d10dcc594f4ce1787a0d4a38fae~lW_t9jNMh0389803898epoutp013
	for <linux-nvme@lists.infradead.org>; Thu, 25 Jul 2024 04:58:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240725045819epoutp0186519d10dcc594f4ce1787a0d4a38fae~lW_t9jNMh0389803898epoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721883499;
	bh=hm6FD2Ug5c3pOe9Qm89s7IFoHzb9JCpzfyhKV9uY+fU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M3VBoPMpYPCK48D2wsTvNc0NAeN7XL8xZCu0wsyHVsB3pWFrZePs3E2FWsdsyIvjp
	 s5ZqlKjcbuK951eWPP4+nX6NvWdUtd5p04wpCBybSNEwI+rBmzdTjsVx4cMsdBOMWV
	 QVn8o8IcPHd634nnVeCUQqI5tL+ebAW8Rw/n1Ur0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240725045819epcas5p165872ae10ae773175616c5d486fa04d8~lW_tusTvW2882328823epcas5p1G;
	Thu, 25 Jul 2024 04:58:19 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4WTzDB0kw8z4x9Pr; Thu, 25 Jul
	2024 04:58:18 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	52.70.09640.96BD1A66; Thu, 25 Jul 2024 13:58:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240724180451epcas5p3cffc89fcc59156ca49078a60851f1e29~lOEKj4BT52025820258epcas5p3E;
	Wed, 24 Jul 2024 18:04:51 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240724180451epsmtrp12840ad44c1adeaa3848969e7cc400b23~lOEKjMiLZ2369423694epsmtrp1X;
	Wed, 24 Jul 2024 18:04:51 +0000 (GMT)
X-AuditID: b6c32a49-aabb8700000025a8-97-66a1db699e3e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	55.6A.07567.34241A66; Thu, 25 Jul 2024 03:04:51 +0900 (KST)
Received: from nj.shetty?samsung.com (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240724180449epsmtip1b78a4c96b9f589188d3e4e90108e90cf~lOEJO5Qad1370813708epsmtip16;
	Wed, 24 Jul 2024 18:04:49 +0000 (GMT)
Date: Wed, 24 Jul 2024 23:27:35 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
	Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Leon Romanovsky
	<leonro@nvidia.com>, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: add missing condition check for existence of
 mapped data
Message-ID: <20240724175735.lndoof76kovv5ge6@nj.shetty@samsung.com>
MIME-Version: 1.0
In-Reply-To: <23e8ca814177474160a516e09b562af339cec837.1721816805.git.leon@kernel.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCJsWRmVeSWpSXmKPExsWy7bCmum7m7YVpBhuXaFmsvtvPZjHr9msW
	i5WrjzJZTDp0jdFiyq+lzBabNjxhsbi8aw6bxfxlT9kt1r1+z+LA6XH+3kYWj8tnSz02repk
	89i8pN5j980GNo/e5ndsHp83yXm0H+hmCuCIyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUz
	MNQ1tLQwV1LIS8xNtVVy8QnQdcvMAbpOSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQ
	klNgUqBXnJhbXJqXrpeXWmJlaGBgZApUmJCd8fT5UsaCPraKWWeKGhi3s3YxcnJICJhIvO7a
	x9jFyMUhJLCbUeLX9wZmCOcTo8TC++uZIJxvjBL7WnYwwbRcWNUK1bKXUeLssgMsEM5nRomJ
	Vy6ygVSxCKhKPLh8D6iDg4NNQFvi9H8OkLAIUHjlgrusIPXMAnOZJJ5sbWAESQgLREqs3jab
	EaSeV8BZomuiJEiYV0BQ4uTMJywgNqdAmMT235fAdkkITOWQ+DNvBzvERS4Sp99vg3pIWOLV
	8S1QcSmJl/1tUHa5xMopK9ggmlsYJWZdn8UIkbCXaD3VzwyymFkgQ+L9FkGIsKzE1FPrwD5m
	FuCT6P39BOp7Xokd82BsZYk16xewQdiSEte+N7KBjJEQ8JCYed0BEiYrGSXauu4xTWCUm4Xk
	n1kI22aBbbCS6PzQxAoRlpZY/o8DwtSUWL9LfwEj6ypGydSC4tz01GLTAsO81HJ4FCfn525i
	BCdXLc8djHcffNA7xMjEwXiIUYKDWUmE98mruWlCvCmJlVWpRfnxRaU5qcWHGE2BsTORWUo0
	OR+Y3vNK4g1NLA1MzMzMTCyNzQyVxHlft85NERJITyxJzU5NLUgtgulj4uCUamDKbgr7z3qL
	uevCIpcJfeE2hS+CbmpO2Wx5dcXRuPUfCx4zudwwu/BiHdvD9dv5vj+bIaE4PyTp+RqHZiun
	BJ5uw/nc3gtOLvHZvzn901eHn/VN+rKlC06l8ih7b8j7smHLe82p7I7vo90k1Z/GxM6cdOOm
	d05+rHyuhvLOR+9U7tzZcov7dU+jzl4xM3WZt4WmAkEnYya+FFv1SMDMRrg1m/Wr36IFnp5a
	p0Vmdl15k1Hezrvw8NbnsuZF85dG++1bJRic/Ma4qvTghXcap/cvO1vlssFrtbzjthg7RjnG
	JJ3JFkoHN1i3av17sPTRvP6Lq55FXt8Vezbtzs/XhmXH/wa6TK+2Mhb8y8a1c42JEktxRqKh
	FnNRcSIAD4X0KjcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsWy7bCSnK6z08I0g2ObhC1W3+1ns5h1+zWL
	xcrVR5ksJh26xmgx5ddSZotNG56wWFzeNYfNYv6yp+wW616/Z3Hg9Dh/byOLx+WzpR6bVnWy
	eWxeUu+x+2YDm0dv8zs2j8+b5DzaD3QzBXBEcdmkpOZklqUW6dslcGXcatzAUnCAueLWnpmM
	DYzNzF2MnBwSAiYSF1a1MnYxcnEICexmlJj5/j4LREJSYtnfI1BFwhIr/z1nB7GFBD4ySnT+
	YwOxWQRUJR5cvsfUxcjBwSagLXH6PwdIWAQovHLBXVaQmcwC85kkZry6xQqSEBaIlFi9bTYj
	SD2vgLNE10RJEFNIIFTiwxFTkApeAUGJkzOfgF3ALGAmMW/zQ2aQEmYBaYnl/8CmcwqESWz/
	fYllAqPALCQds5B0zELoWMDIvIpRMrWgODc9N9mwwDAvtVyvODG3uDQvXS85P3cTIzgmtDR2
	MN6b/0/vECMTB+MhRgkOZiUR3iev5qYJ8aYkVlalFuXHF5XmpBYfYpTmYFES5zWcMTtFSCA9
	sSQ1OzW1ILUIJsvEwSnVwDRN75SQsZjfQfNDXAdePTGZo6+1SOqQQO0kleM3vupbteRNCrKR
	+vY7MOXAcQNlq9eG8yMfrtkvcLjh7ueTb/nm/TzZulB9xef9Tb5y3c3N61Ti1wRtkSv+69dd
	rM9/fkric/1zFw9mu2n21BRaV88zDzN8LeX078nWVSuEzkUrc0hsUQl/+qmopYfj78FjiiFu
	qasz3U6+/qqQ9mjyS2eZjhWXCvh9LFzSzrAtEqvaJ7pv8ptbNaf3O7l7WVws13N/YfboIK+H
	iV1b7Mb+yaxswfOzAzRcezcy3X+zdM+aasM41lD+COe7kU+aboUteTP1MEtN6d2AWUsrQwOY
	HHUTBH+0v5/pZv/4tyvfaSWW4oxEQy3mouJEAG1HVCb4AgAA
X-CMS-MailID: 20240724180451epcas5p3cffc89fcc59156ca49078a60851f1e29
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----tv00kGafDAKugJLLWPAFdl2KPkYaKdNcKQc3tmj5W0zcLjXE=_3e4fd_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240724180451epcas5p3cffc89fcc59156ca49078a60851f1e29
References: <23e8ca814177474160a516e09b562af339cec837.1721816805.git.leon@kernel.org>
	<CGME20240724180451epcas5p3cffc89fcc59156ca49078a60851f1e29@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240724_215830_970378_D71744B2 
X-CRM114-Status: GOOD (  14.13  )
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

------tv00kGafDAKugJLLWPAFdl2KPkYaKdNcKQc3tmj5W0zcLjXE=_3e4fd_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 24/07/24 01:31PM, Leon Romanovsky wrote:
>From: Leon Romanovsky <leonro@nvidia.com>
>
>nvme_map_data() is called when request has physical segments, hence
>the nvme_unmap_data() should have same condition to avoid dereference.
>
>Fixes: 4aedb705437f ("nvme-pci: split metadata handling from nvme_map_data / nvme_unmap_data")
>Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>---

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------tv00kGafDAKugJLLWPAFdl2KPkYaKdNcKQc3tmj5W0zcLjXE=_3e4fd_
Content-Type: text/plain; charset="utf-8"


------tv00kGafDAKugJLLWPAFdl2KPkYaKdNcKQc3tmj5W0zcLjXE=_3e4fd_--

