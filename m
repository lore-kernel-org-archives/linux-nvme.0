Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8D8C00140
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Aug 2022 17:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=//afs5k/C3CJvPW7j8UN/5+wS7sDb4fQ5ckHEP9nxrs=; b=W+HM4zHYSq4P+Nc85hl/FJV05M
	wo6CDpt07vyJENrI1l2FK+8z0nc/dn46ETckod4HY8GF6X7q8IlO7jHSOOvm3N550jBh/QK9M1l6J
	tLhAymu/SKCXjD61DtiAcOOs1R7lcRO1SVEALSEVSKfZDlkzvFWNMSmoQqQjp0IkYDy7pncY0QYDm
	JCV4+RwDn7Yy/5oOrUBTWVZc6obQYLw8fndeyVaaC3k4tsB69DurRPKU0KetEzp0DYubcQZr9+kL7
	eDDT5RpPkb3A6q8Nq9N5wxAI/p2e0/7smNKNhpXpIXHvxXyIguKFUm+IOUAQoXonj16PjcBOBygcb
	ub4KY8LQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oK12O-00H1ij-Jd; Fri, 05 Aug 2022 17:23:04 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oK12K-00H1f8-KE
	for linux-nvme@lists.infradead.org; Fri, 05 Aug 2022 17:23:02 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220805172256epoutp0467d6a9ea00ee3cf521a911e2d3414341~IgrUYN-s20203202032epoutp04W
	for <linux-nvme@lists.infradead.org>; Fri,  5 Aug 2022 17:22:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220805172256epoutp0467d6a9ea00ee3cf521a911e2d3414341~IgrUYN-s20203202032epoutp04W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1659720177;
	bh=//afs5k/C3CJvPW7j8UN/5+wS7sDb4fQ5ckHEP9nxrs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DldysqgOrNhSc5oNOwFfsw6pvhCZ90bzUbkkNF+cab15GF6xtAZx/ztLN/y3oXGtE
	 lzU+wMDZ4hQmRuGcpWWDUINDU82uwfHuyZDIVaXnrxnSpa2SnTAE4HnJNpM5wYM1f5
	 q/siGz6D0UUHWuNZqob32L/8ANNiWw+pOCVfTiBY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20220805172256epcas5p30273d36728b04727d046345aedcc5500~IgrTeALOl3156531565epcas5p3_;
	Fri,  5 Aug 2022 17:22:56 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Lzsqf1Rb0z4x9Pq; Fri,  5 Aug
	2022 17:22:54 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	67.0B.09639.EE15DE26; Sat,  6 Aug 2022 02:22:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20220805172253epcas5p36832520a5fbdbb87a1a2441cca840c3e~IgrRgP9Pd3175631756epcas5p3A;
	Fri,  5 Aug 2022 17:22:53 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220805172253epsmtrp14b12a25cd24dd473399e1f6ea3ec4108~IgrRfX5Nc3083130831epsmtrp1Y;
	Fri,  5 Aug 2022 17:22:53 +0000 (GMT)
X-AuditID: b6c32a4b-e6dff700000025a7-7d-62ed51ee2735
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	89.4B.08905.DE15DE26; Sat,  6 Aug 2022 02:22:53 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20220805172252epsmtip24fe1671fe120fabf53c39f8642c49253~IgrQTmKlQ0484204842epsmtip2Q;
	Fri,  5 Aug 2022 17:22:52 +0000 (GMT)
Date: Fri, 5 Aug 2022 22:43:31 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: hch@lst.de, io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, ming.lei@redhat.com, joshiiitr@gmail.com,
	gost.dev@samsung.com
Subject: Re: [PATCH 0/4] iopoll support for io_uring/nvme passthrough
Message-ID: <20220805171331.GD17011@test-zns>
MIME-Version: 1.0
In-Reply-To: <78f0ac8e-cd45-d71d-4e10-e6d2f910ae45@kernel.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGJsWRmVeSWpSXmKPExsWy7bCmhu67wLdJBjPmsFusvtvPZnHzwE4m
	i5WrjzJZvGs9x2Jx/u1hJou9t7Qt5i97ym5xaHIzkwOHx85Zd9k9Lp8t9di8pN5j980GNo/3
	+66yefRtWcXo8XmTXAB7VLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJu
	qq2Si0+ArltmDtBJSgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCkwK94sTc4tK8
	dL281BIrQwMDI1OgwoTsjOfT2pgLjnJWHDx5gq2BsYu9i5GTQ0LARGL9lM/MXYxcHEICuxkl
	tm58wwySEBL4xCixfDoPROIbo8TZrxAJkI7FTw4zQiT2MkrMWXyMCcJ5xigx8/B+IIeDg0VA
	ReLH9QIQk01AU+LC5FKQXhEBBYme3yvZQMqZBVYySvzZ2cECkhAWcJWYcGkRI4jNK6ArseHG
	OWYIW1Di5MwnYDWcArYSTVf6mEBsUQFliQPbjoPtlRCYyiHx5fl3RpBlEgIuEqc+FkEcKizx
	6vgWqDelJF72t0HZyRKXZp5jgrBLJB7vOQhl20u0nupnBhnDLJAhceo/H0iYWYBPovf3EyaI
	6bwSHW1CENWKEvcmPWWFsMUlHs5YAmV7SNxb28QOCcMDjBK3jwVMYJSbheSZWQgLZoEtsJLo
	/NDEChGWllj+jwPC1JRYv0t/ASPrKkbJ1ILi3PTUYtMC47zUcnj8JufnbmIEJ1At7x2Mjx58
	0DvEyMTBeIhRgoNZSYT3547XSUK8KYmVValF+fFFpTmpxYcYTYFRM5FZSjQ5H5jC80riDU0s
	DUzMzMxMLI3NDJXEeb2ubkoSEkhPLEnNTk0tSC2C6WPi4JRqYHqV8miTzReO0EeVN/T+3c08
	9No4vNnytG9kykbOAC39e0FbJba577iT8sCK/9MmabYcI7UtW1ck/l70/uEk/jc7pnzKl9+/
	Zi/LF2ZlhS3T5rWKmdf/KjoUt1V83/R8bZHP1WtqXXTOs37dHxKu2rhDUnPn6j/aTBsEWeSC
	D19vPZbDwijx4cPqroh+HZbpqxOUl6uLrTkRyC9lsHET/9rQKLW1VXGSIh/n72uW7L/7+U+V
	ocGH1TdnTbp74I2TpPQKefF9vw3m3zBP0t6ioZxWeYKte//cMDch56xlgY5LXY57T7qzKa3a
	YX0es8rVVef7Fh4tX9k44b562sswP8bejr96dts26N1o4Zr+aKISS3FGoqEWc1FxIgDexTqY
	KQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsWy7bCSvO7bwLdJBk1/DCxW3+1ns7h5YCeT
	xcrVR5ks3rWeY7E4//Ywk8XeW9oW85c9Zbc4NLmZyYHDY+esu+wel8+WemxeUu+x+2YDm8f7
	fVfZPPq2rGL0+LxJLoA9issmJTUnsyy1SN8ugSuj8c9ztoLvbBUbnhxhb2C8xtLFyMkhIWAi
	sfjJYcYuRi4OIYHdjBLdJ04xQyTEJZqv/WCHsIUlVv57DmYLCTxhlNj3T6iLkYODRUBF4sf1
	AhCTTUBT4sLkUpAKEQEFiZ7fK9lARjILrGSU2HrpBNhIYQFXiQmXFjGC2LwCuhIbbpxjhth7
	gFGi4/49VoiEoMTJmU/AjmMWMJOYt/khM8gCZgFpieX/OEDCnAK2Ek1X+phAbFEBZYkD244z
	TWAUnIWkexaS7lkI3QsYmVcxSqYWFOem5xYbFhjmpZbrFSfmFpfmpesl5+duYgRHhpbmDsbt
	qz7oHWJk4mA8xCjBwawkwvtzx+skId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5ak
	ZqemFqQWwWSZODilGph2qdvHzchQTdtqxG/TElDldnn+67crCzheRIhIzJk6p9yyhjGl9sx9
	gZbDup9NHuUwaZ0M5mlNZZ74MDHy1OcVvVPnHmacNfWYxCvmwq8uS4796YoTPPd/0+5OHZf5
	70xeScr/5rn2qdH8z6X45R7Gfey3U2Ptu05c2m+V9WhdVvvJf2+rJ+50tV0cvu7extNJv6+p
	yd5cbxA01fLhE32XaxO+FvT5rDkxL7m9h0WaLeG5XxKnbNSCK80hx/vufV/1QuDVJuW9Shrs
	N9776MziijJeVRKycWWfz8f4VO7jqT3fo1808iSy7G3Ii9qtmqPbFr3rrt+N2ELGW6YCDuvi
	eaOfml7itlkprZpREqXEUpyRaKjFXFScCAB6iB7k+wIAAA==
X-CMS-MailID: 20220805172253epcas5p36832520a5fbdbb87a1a2441cca840c3e
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----_GKj2UxOoZMooFpgW.UaNJF5RnPKrhbpXXK.PgNceyCDa.V5=_4fc22_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220805155300epcas5p1b98722e20990d0095238964e2be9db34
References: <CGME20220805155300epcas5p1b98722e20990d0095238964e2be9db34@epcas5p1.samsung.com>
	<20220805154226.155008-1-joshi.k@samsung.com>
	<78f0ac8e-cd45-d71d-4e10-e6d2f910ae45@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220805_102301_156725_A07EBAAF 
X-CRM114-Status: GOOD (  12.30  )
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

------_GKj2UxOoZMooFpgW.UaNJF5RnPKrhbpXXK.PgNceyCDa.V5=_4fc22_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Fri, Aug 05, 2022 at 11:04:22AM -0600, Jens Axboe wrote:
>On 8/5/22 9:42 AM, Kanchan Joshi wrote:
>> Hi,
>>
>> Series enables async polling on io_uring command, and nvme passthrough
>> (for io-commands) is wired up to leverage that.
>>
>> 512b randread performance (KIOP) below:
>>
>> QD_batch    block    passthru    passthru-poll   block-poll
>> 1_1          80        81          158            157
>> 8_2         406       470          680            700
>> 16_4        620       656          931            920
>> 128_32      879       1056        1120            1132
>
>Curious on why passthru is slower than block-poll? Are we missing
>something here?
passthru-poll vs block-poll you mean?
passthru does not have bio-cache, while block path is running with that.
Maybe completion-batching is also playing some role, not too sure about that
at the moment.

------_GKj2UxOoZMooFpgW.UaNJF5RnPKrhbpXXK.PgNceyCDa.V5=_4fc22_
Content-Type: text/plain; charset="utf-8"


------_GKj2UxOoZMooFpgW.UaNJF5RnPKrhbpXXK.PgNceyCDa.V5=_4fc22_--

