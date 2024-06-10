Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 740DAC27C55
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jun 2024 10:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dn/7dkDIQc+y8X2QUqLDtZxRK17G94X+ut2amDoWMNY=; b=QiuL3pssgB64fm0Y74uqdm3cPC
	AjRKnDEzI8IdBXL4zUmmPPQrOyzg8oce7VsG93Jht/5JImJRjqSM1v+qaSezyV2LtpstWLhKQQoPV
	E6DAkPjjeJ6YjzbphL1sTT0vwcFCGI0fkqTXEtz5B88uJbsGco49XK2JO9TbpmhMj9ars9LLXlTl6
	rAWhS+qTYEjspyPRmFswy7/R9O/EDoQRPpWPyhUVN79LrQPTZK2zfumjkgeahw97TCELzh/CjWOfZ
	N7X0jkvmj0lDvtmZlyk14Gm8ixZ5EZnuDHZywXWQAw+j1/KWm1SdBzrcMvX+fFCtwHj86ep0d6pFk
	UCSKM9Eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGcQF-00000004gMZ-1ROq;
	Mon, 10 Jun 2024 10:38:43 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGcQ8-00000004gLW-2Jvx
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jun 2024 10:38:41 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240610103825epoutp039ff04b6b2a0932e8868832fb572686c9~Xnlz-7pnk2871028710epoutp03w
	for <linux-nvme@lists.infradead.org>; Mon, 10 Jun 2024 10:38:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240610103825epoutp039ff04b6b2a0932e8868832fb572686c9~Xnlz-7pnk2871028710epoutp03w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718015905;
	bh=dn/7dkDIQc+y8X2QUqLDtZxRK17G94X+ut2amDoWMNY=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=WWjkHKoV/eeSrvQryV0WlYNG6yqdWMO74NQUJV7DFb8hxJ5Du+4r8jFOIjpXdo1zO
	 QCDt3GfyIC9/edLnJy60RKDi+znmgwyOpbj4gnEm6/uCBK3Hfv9nNHVEG0H1gwwRyr
	 9ntB0qX08XVCVJ8KX1a/mwViN8aJ0IsEVWnP2RVg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240610103824epcas5p3a3198ec5bba8d06408b6f1699934c4ee~XnlzQAI_60313003130epcas5p31;
	Mon, 10 Jun 2024 10:38:24 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4VySvL4yBCz4x9Q0; Mon, 10 Jun
	2024 10:38:22 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	11.C0.09989.E97D6666; Mon, 10 Jun 2024 19:38:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240610103821epcas5p366944629c759532cc95987a38358e006~XnlxEsEJ50264302643epcas5p3z;
	Mon, 10 Jun 2024 10:38:21 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240610103821epsmtrp25d75ac5bfddcff129f0d4db4168d4f37~XnlxD_5TH2316323163epsmtrp2U;
	Mon, 10 Jun 2024 10:38:21 +0000 (GMT)
X-AuditID: b6c32a4a-e57f970000002705-16-6666d79e3ed2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	03.43.18846.D97D6666; Mon, 10 Jun 2024 19:38:21 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240610103820epsmtip2bc3f438571b4ed617bb2ed5a6a68d82e~XnlvkLJlq1595415954epsmtip2T;
	Mon, 10 Jun 2024 10:38:20 +0000 (GMT)
Message-ID: <5e686875-21de-869d-4b19-bdd9e272d690@samsung.com>
Date: Mon, 10 Jun 2024 16:08:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH v2] nvme: enable FDP support
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	javier.gonz@samsung.com, bvanassche@acm.org, gost.dev@samsung.com, Hui Qi
	<hui81.qi@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240608051740.GA24010@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIJsWRmVeSWpSXmKPExsWy7bCmhu6862lpBq/uKVqsvtvPZjHtw09m
	i5sHdjJZrFx9lMli57K17BaP73xmt5h06BqjxfxlT9kttv2ez2yx7vV7Fgcuj8tXvD3O39vI
	4nH5bKnHplWdbB6bl9R77L7ZwObRt2UVYwB7VLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZ
	gaGuoaWFuZJCXmJuqq2Si0+ArltmDtB1SgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSC
	lJwCkwK94sTc4tK8dL281BIrQwMDI1OgwoTsjM3LzrAW/OKpuLTmOXMD4wGuLkZODgkBE4md
	n9eygNhCArsZJdZs8+hi5AKyPzFKfDi0nQXO+TGhgR2mY9vK7UwQiZ2MEne2b2CHcN4ySizZ
	vZsRpIpXwE7i9N4zbCA2i4CqxI95Z1kg4oISJ2c+AbNFBZIlfnYdAKsRFjCQuNe/ghXEZhYQ
	l7j1ZD4TiC0i4Czx9fNVsG3MApcYJe6e2w20jYODTUBT4sLkUpAaTgEdiT2fLzJC9MpLbH87
	hxmkXkJgKYfEyvf/oc52kehZcZUFwhaWeHV8C1RcSuLzu71sEHayxKWZ55gg7BKJx3sOQtn2
	Eq2n+plB9jID7V2/Sx9iF59E7+8nTCBhCQFeiY42IYhqRYl7k56yQtjiEg9nLIGyPSR+7p7D
	BAnqx4wSV74FTmBUmIUUKrOQfD8LyTezEBYvYGRZxSiZWlCcm55abFpglJdaDo/v5PzcTYzg
	tKvltYPx4YMPeocYmTgYDzFKcDArifAKZSSnCfGmJFZWpRblxxeV5qQWH2I0BUbPRGYp0eR8
	YOLPK4k3NLE0MDEzMzOxNDYzVBLnfd06N0VIID2xJDU7NbUgtQimj4mDU6qBST9ATHvLBRVd
	/333fFPiJrh8X2cS8uPOITcP9VMO/8T2cD/f/yXS4ZvqgZlCia+3VX9tfx/U01tnfC9U3HhH
	Rdn6K7s3dcvwvBacaKpnecayNLCKccek11MzjDtloln5eLRmt1w2X51/fMkP75lBQuHf76q9
	FUr0mSl5t6xivbbK+ven/fwl/q4tODfxmO7PPUec7ST4lv/dfmfnkeza6WyxXy4Jd/Eammgx
	CyiuV7v8UXSRlIQUf/HCPG63qrYZvHb/TJev3V3w0+mjjq/jN+Pazzf7RR7VPD200lJ5VtXN
	UA3Goqfq9RNu3bUOvl0cVC8gadu/3PRMeP2l69uWh9gfOtVlGnsuYfYi8S5ZJZbijERDLeai
	4kQAMICoLEQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42LZdlhJXnfu9bQ0g78dphar7/azWUz78JPZ
	4uaBnUwWK1cfZbLYuWwtu8XjO5/ZLSYdusZoMX/ZU3aLbb/nM1use/2exYHL4/IVb4/z9zay
	eFw+W+qxaVUnm8fmJfUeu282sHn0bVnFGMAexWWTkpqTWZZapG+XwJWxedkZ1oJfPBWX1jxn
	bmA8wNXFyMkhIWAisW3ldqYuRi4OIYHtjBKL3h5igUiISzRf+8EOYQtLrPz3nB2i6DWjxM7J
	R8CKeAXsJE7vPcMGYrMIqEr8mHcWKi4ocXLmEzBbVCBZ4uWfiWCDhAUMJO71r2AFsZmBFtx6
	Mp8JxBYRcJb4+vkq2BXMApcYJe58XAR10mNGieO/NwBt4OBgE9CUuDC5FKSBU0BHYs/ni4wQ
	g8wkurZ2QdnyEtvfzmGewCg0C8kds5Dsm4WkZRaSlgWMLKsYRVMLinPTc5MLDPWKE3OLS/PS
	9ZLzczcxguNLK2gH47L1f/UOMTJxMB5ilOBgVhLhFcpIThPiTUmsrEotyo8vKs1JLT7EKM3B
	oiTOq5zTmSIkkJ5YkpqdmlqQWgSTZeLglGpg2ntUqoxlitG+BTm/WPqWMIdJMsU6B/g6XBT/
	7h6gzXnb6dGBq58SU/wyV5wV1Prg03DroMW1ySvXpk3iM7+fa/xD7qSpc4ttxcQLGgyb98kW
	K3Qsesz4U8Diwo4v19tfHz3+vp5jVXZSomRh1I3J0lkuF/e1f35rW+B7c8fG16kfZH9Yz258
	k26uIbjkaWWLt8uMg/tknj85Eayu9mixuKxAtslu9hkcs89/XeScfnVHZHmbuqWr/LyW2Hmn
	J3Bri60rzv9emqNYr6z0VmXp74BpLKodLj9usYgYf304t09Hd+fziEb/jY3nQxfObjq+8s7H
	mOyOfXIcszVmlS7epFjzh6fP7PK0orKbzJNmKbEUZyQaajEXFScCAFE+YSseAwAA
X-CMS-MailID: 20240610103821epcas5p366944629c759532cc95987a38358e006
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240528151007epcas5p32583675f647553923e5ba4987e9bc6ed
References: <CGME20240528151007epcas5p32583675f647553923e5ba4987e9bc6ed@epcas5p3.samsung.com>
	<20240528150233.55562-1-joshi.k@samsung.com>
	<ZmMj3d1Rvv-5E6Ey@kbusch-mbp.dhcp.thefacebook.com>
	<20240608051740.GA24010@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_033839_699307_A0F10FC9 
X-CRM114-Status: GOOD (  17.25  )
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

On 6/8/2024 10:47 AM, Christoph Hellwig wrote:
> Nacked-by: Christoph Hellwig<hch@lst.de>
> 
> This is a really overcomplicated way that does not in any way fit the
> FDP use case (which is also rather overcomplicated).
> 
> If you want to pass on life time information to a NVMe device please
> work with the NVMe technical working group to add the equivalent of
> the life time hints added to SCSI as part of the
> constrained streams in SBC.  It would be implementable in the Linux
> nvme driver in a few lines of code, similaly trivially in the device
> and actually makes things work.

I disagree. Bart's patch using "constrained streams in SBC" adds 104 
lines [*]. This patch adds 90 lines.
Both do the conceptually similar two steps equally trivially:

Step #1. Query protocol specific hints.
- sd_read_io_hints (scsi): sends one/two commands to the device
- nvme_fetch_fdp_plids (nvme): sends one command to the device

Step #2. map write-hints to protocol specific hints.
- sd_group_number (scsi)
- nvme_assign_placement_id (nvme)

So current plumbing is nearly identical and as simple as SCSI.

And TP 4146 author list shows 10 companies. Perhaps good enough for 
diverse opinions on how to go about things before settling down.

We have used passthrough interface for FDP wherever possible. But there 
are users asking file/block interface for what has been standardized. We 
end up sharing this patch as a off-tree solution (which is a pity).

And this was discussed at LSFMM too; There was no push back to move forward.

[*] 
https://lore.kernel.org/linux-scsi/20240222214508.1630719-4-bvanassche@acm.org/

