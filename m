Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4001C43334
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jul 2022 09:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:CC:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VWcfwXZHavwwmJ8uG26l6fifwNmuXWW+Va2RJcR3d9k=; b=Jinizwe4Xf8bN+FhIvQKOQxO+C
	q4CUxHX3kksRFUzEpeK8s4wMO1Bwq2QY8lzfq41lIgX9P7D04CuUBbIjTmGG7GETokOvQH2Wn5/oA
	Ew5X1SRvgU40pFbn42S6GVBQWXBqamPn3zVp+8UWxDrn0YTPPHIEBS+pUYy/4qzV8d9APowpqIFBX
	UcVSxEnJYvJd6aLCS2f9NUFRnpYg5H128SnoYudAMGZSPLElCh/ZoixW1UYWNPNUcIN51pBXFBb4t
	uAaPV33nxt30+t8Z8dyyx6v91gah9+lDazHzFKwyvy0GZWoZYc4syeYwi3Iwj7sk+M0OPanUGwAVC
	eubO+Wkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBYf1-002GNc-Br; Wed, 13 Jul 2022 09:27:59 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBYey-002GLd-Du
	for linux-nvme@lists.infradead.org; Wed, 13 Jul 2022 09:27:58 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220713092753euoutp025c1ef177d5243b439f382d3c42255055~BWW_Hk9kB2426924269euoutp02y
	for <linux-nvme@lists.infradead.org>; Wed, 13 Jul 2022 09:27:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220713092753euoutp025c1ef177d5243b439f382d3c42255055~BWW_Hk9kB2426924269euoutp02y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1657704473;
	bh=VWcfwXZHavwwmJ8uG26l6fifwNmuXWW+Va2RJcR3d9k=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Mkx5DaynMNZ1k44xdG9vWcYtv437X9u20niSddEuuPSb0qwDnaI3udXYEAeQ6C3Wq
	 XbVu/sGce14zrBHVZFqIY4ieb8nMmrm3u/pBmcXn7NTWaoAwEOjM//cL810CikS9Hs
	 nFW7W1DX1x2949xT2QSj2P9f8fboCSOx2WbN/e5M=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20220713092753eucas1p2c7c77d0e2504feaac6f277da006dc121~BWW970RwE0112201122eucas1p2Q;
	Wed, 13 Jul 2022 09:27:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id A0.55.09664.9109EC26; Wed, 13
	Jul 2022 10:27:53 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20220713092752eucas1p23ce455fdf4b2cea97647b1617f4b379f~BWW9mAWwj1053010530eucas1p2t;
	Wed, 13 Jul 2022 09:27:52 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220713092752eusmtrp16cc61000c15767712781d3783bc43bf4~BWW9lZHQj3162631626eusmtrp1w;
	Wed, 13 Jul 2022 09:27:52 +0000 (GMT)
X-AuditID: cbfec7f2-d97ff700000025c0-16-62ce9019bf64
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 92.EE.09095.8109EC26; Wed, 13
	Jul 2022 10:27:52 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20220713092752eusmtip1d65ce3be695dc6a43b4de6d5b912f064~BWW9epztK1942319423eusmtip1f;
	Wed, 13 Jul 2022 09:27:52 +0000 (GMT)
Received: from localhost (106.110.32.122) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 13 Jul 2022 10:27:51 +0100
Date: Wed, 13 Jul 2022 11:27:47 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
To: Christoph Hellwig <hch@lst.de>
CC: Joel Granados <j.granados@samsung.com>, <kbusch@kernel.org>,
	<sagi@grimberg.me>, <joshi.k@samsung.com>, <linux-nvme@lists.infradead.org>,
	<gost.dev@samsung.com>, <k.jensen@samsung.com>
Subject: Re: enable generic interface (/dev/ngX) for unknown command sets
Message-ID: <20220713092747.hyhpz5mlvgejnlhk@ArmHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220713054914.1888305-1-hch@lst.de>
X-Originating-IP: [106.110.32.122]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnleLIzCtJLcpLzFFi42LZduzneV3JCeeSDP7u5rRYufook8WkQ9cY
	LeYve8puse71exYHFo/z9zayeGxa1cnmsXlJvcfumw1sASxRXDYpqTmZZalF+nYJXBmvV21j
	L7jFVNF/7zhTA+N0pi5GTg4JAROJVX3/WbsYuTiEBFYwSryb3cQI4XxhlDg5ZzsThPOZUaJr
	6WU2mJZvRy+zQCSWM0psnjabBa7q6cMWsMFCAlsYJdobZUBsFgFVib+nrrOC2GwC9hKXlt1i
	BrFFBJQknr46ywhiMwscYJS48DMHxBYW8JT40fmPBcTmFbCV+DKnjRXCFpQ4OfMJC0S9lUTn
	hyagOAeQLS2x/B8HRFheonnrbLDxnAJGEjPu7GSBOFpJ4vGLt4wQdq3EqS23oP6/wSGx+mUI
	hO0icXzyCnYIW1ji1fEtULaMxOnJPVBzsiUunulmhrBLJBa/P8YMcoKEgLVE35kciLCjxPNj
	Z1ghwnwSN94KQlzGJzFp23Soal6JjjahCYwqs5C8NQvJW7MQ3pqF5K0FjCyrGMVTS4tz01OL
	DfNSy/WKE3OLS/PS9ZLzczcxAtPK6X/HP+1gnPvqo94hRiYOxkOMEhzMSiK8f86eShLiTUms
	rEotyo8vKs1JLT7EKM3BoiTOm5y5IVFIID2xJDU7NbUgtQgmy8TBKdXAVG1zPM2LTfWkBffp
	POtFv+7K7Z/Yt0j/b/qj36mbPy6ZJemQ9fhrXOAEplj/QO4epaKvExcnMS18czV214nT7nGM
	613L7i0ruVTA/Pn1qg3PN1lNcW5c6sva8OTKuVNzFBKjL7ZWJtsWc0jyJrdKn3kcsVyDo0Rg
	scDjBMOosOZjL4Rj7dOTtNWuKGz/fuBu28UVCctPrGmP/V/IGScj877K/GzRV94bMrufmX4P
	lRGcGGVocnLa7CSNLv7FJjuX20rzWs6p5K5fm7LmtfHqZX9+RkVXyPzV8SpOTrrf3lT3Lb7y
	QYLIfNZ2fun3okeDrpx5XPj3y6ndckG2L6y339yZ8OKiS/HWP65n09k+KbEUZyQaajEXFScC
	AIFkGnqaAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsVy+t/xu7oSE84lGZzeYGCxcvVRJotJh64x
	Wsxf9pTdYt3r9ywOLB7n721k8di0qpPNY/OSeo/dNxvYAlii9GyK8ktLUhUy8otLbJWiDS2M
	9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DJer9rGXnCLqaL/3nGmBsbpTF2MnBwS
	AiYS345eZuli5OIQEljKKLFz+QoWiISMxKcrH9khbGGJP9e62CCKPjJKfHh3kRnC2cIocf3G
	e0aQKhYBVYm/p66zgthsAvYSl5bdYgaxRQSUJJ6+OgtWwyxwgFHiws8cEFtYwFPiR+c/sG28
	ArYSX+a0sUIMbWWUWNt/ig0iIShxcuYTFohmC4mZ888DDeIAsqUllv/jgAjLSzRvnQ22i1PA
	SGLGnZ1QHyhJPH7xlhHCrpX4/PcZ4wRGkVlIps5CMnUWwtRZSKYuYGRZxSiSWlqcm55bbKhX
	nJhbXJqXrpecn7uJERh924793LyDcd6rj3qHGJk4GA8xSnAwK4nw/jl7KkmINyWxsiq1KD++
	qDQntfgQoykwiCYyS4km5wPjP68k3tDMwNTQxMzSwNTSzFhJnNezoCNRSCA9sSQ1OzW1ILUI
	po+Jg1Oqgcl/35+Zp15rqylUR257vTPxg4szZ7vS66UfPm5VXPfZJtojriHoWPnV3gt+05ef
	t3+VdDuxPbRd9JEt1zkVGTWVpVJvP5fvFlAxNi/apnNTceZf29+7+pY33Qg02/4hoOJSjuhM
	tU939s/m+hy0069qceSPrO1vv53Q0ZxwY8rzyTwv/hfcWsXkdTFv565KI8OMg3pza149eljK
	9ev3Qs27Ve/Kjh6Q2soQqCgQkyE/Y6Hju6/NDU0aS5Z/X5rZsae7054nxdpp3ZKP1ztC3l/3
	bZXee+LtR4aXB9Njt8+eNcWzrHTxQb6EQ4/vsvKubCwqNTZLOHozbqZ++7YnYkEb3yyPfJT/
	ZY5vygy2DUH3lViKMxINtZiLihMBW/2mGUcDAAA=
X-CMS-MailID: 20220713092752eucas1p23ce455fdf4b2cea97647b1617f4b379f
X-Msg-Generator: CA
X-RootMTR: 20220713054925eucas1p2f1015324abe9ccf6a665212f41d553c7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220713054925eucas1p2f1015324abe9ccf6a665212f41d553c7
References: <CGME20220713054925eucas1p2f1015324abe9ccf6a665212f41d553c7@eucas1p2.samsung.com>
	<20220713054914.1888305-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220713_022756_786053_226BE093 
X-CRM114-Status: UNSURE (   8.73  )
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

On 13.07.2022 07:49, Christoph Hellwig wrote:
>Hi all,
>
>this is a version of the patch from Joel rebased on a bunch of cleanups
>from me that I think make the layering a lot cleaner.  Let me know what
>everyone things.

Series look good. Thanks for doing the rebase Christoph.

Reviewed-by: Javier González <javier.gonz@samsung.com>

