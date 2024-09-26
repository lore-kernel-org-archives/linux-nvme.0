Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D755CDE024
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Sep 2024 16:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I9PrBq4VRyNqM7vB2acMB7QhPsc7ZilPrm5o5cDnQWc=; b=WkSrNq5JV3NdNbB+NAdR5MfML0
	DeV6VhnRXLZkJ6ZrzhcoWneFnU9Y9TPGBB+hxLozfWows1tHYKk4PffUcI7CLG1+yXk9IVhYPOPre
	LFL166Z+gWqEZYci1zTNq8eMET+dhMqFvCfYnzEdAqsNQ2V/DU1xeQw18AmerqxxceCqvp3G9dtGm
	Z01JOV6z2HdHmXPvwTg7yk7j9w5DV5bFhpO4OtR3knBpgn3ShTAtdq3MaknH2ybZQped6ooYM/YL9
	FBIt1ykSoz8w4FuAgVEpfNZFfjBEWN4eCOEmNt5IqwI4jh/rgt1LpC9KRvtGkNtsRxgEhQADEgdxI
	Had9xMfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1strVe-00000008uW5-1DlL;
	Thu, 26 Sep 2024 16:38:30 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1strVa-00000008uTT-3cQm
	for linux-nvme@lists.infradead.org;
	Thu, 26 Sep 2024 16:38:29 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240926163819epoutp0298649755039354254520cca5d0fcc34b~42K4VVB132351223512epoutp02X
	for <linux-nvme@lists.infradead.org>; Thu, 26 Sep 2024 16:38:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240926163819epoutp0298649755039354254520cca5d0fcc34b~42K4VVB132351223512epoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1727368699;
	bh=I9PrBq4VRyNqM7vB2acMB7QhPsc7ZilPrm5o5cDnQWc=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=eSkF4E1lN3lKwrkajJWAWP+wZcu9B95okcBoZKX745CpNs6iy+CU+6VJR44/a1O2d
	 3CLKUgSzX+MYl8Q/w1yeky25j6MBwCig9U/uSQlxip9wBGJRpkZIUzaTK3r6v5owdj
	 X/tfO5vMbwNR1YAGhagCsaO+NjWPVyM7KIkDW0jQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240926163818epcas5p426491427b731dcfe8b15fac4a82390e9~42K338Pyd2198221982epcas5p4c;
	Thu, 26 Sep 2024 16:38:18 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4XDzmm70Thz4x9Pq; Thu, 26 Sep
	2024 16:38:16 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	16.59.09640.8FD85F66; Fri, 27 Sep 2024 01:38:16 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240926163816epcas5p3c74179bddf80da97477a0c947f5556ac~42K1uJmql3076030760epcas5p3G;
	Thu, 26 Sep 2024 16:38:16 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240926163816epsmtrp253a903162ce547e66beee8aed8f2f7b4~42K1s755Z1104611046epsmtrp2M;
	Thu, 26 Sep 2024 16:38:16 +0000 (GMT)
X-AuditID: b6c32a49-a57ff700000025a8-95-66f58df85f0f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	3C.6F.07567.8FD85F66; Fri, 27 Sep 2024 01:38:16 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240926163814epsmtip2315fe41bd61248b05873c22703a47e32~42K0Q_bwj2954329543epsmtip2B;
	Thu, 26 Sep 2024 16:38:14 +0000 (GMT)
Message-ID: <8ed2637b-559e-3f27-3d1f-84a4718475fb@samsung.com>
Date: Thu, 26 Sep 2024 22:08:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v2 2/3] block: support PI at non-zero offset within
 metadata
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com, Chinmay Gameti
	<c.gameti@samsung.com>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <ZvV4uCUXp9_4x5ct@kbusch-mbp>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAJsWRmVeSWpSXmKPExsWy7bCmpu6P3q9pBsdOm1qsvtvPZvF9ex+L
	xc0DO5ksVq4+ymQx6dA1Rou9t7Qt5i97ym6x/Pg/Jot1r9+zOHB6nL+3kcXj8tlSj02rOtk8
	Ni+p99h9s4HN4+PTWywefVtWMXp83iQXwBGVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZg
	qGtoaWGupJCXmJtqq+TiE6DrlpkDdJySQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAl
	p8CkQK84Mbe4NC9dLy+1xMrQwMDIFKgwITvjwcMbjAVvuSpev25lbWA8zdHFyMkhIWAi0XJr
	OlsXIxeHkMBuRolt068xQTifGCUmTJ/IDuF8Y5TYefsvE0zLkoVfoVr2MkrMPdsF1fKWUeL9
	7jWsIFW8AnYSa2b8BrI5OFgEVCXObzaHCAtKnJz5hAXEFhVIkvh1dQ4jiC0sECSx5XEP2AJm
	AXGJW0/mg9kiAsoSd+fPZAWZzyxwllHi46xtjCAz2QQ0JS5MLgWp4RTQknh7+zkbRK+8xPa3
	c5hB6iUE1nJIXN/zE+wGCQEXiZc9ChAPCEu8Or6FHcKWkvj8bi8bhJ0t8eDRAxYIu0Zix+Y+
	VgjbXqLhzw2wMcxAa9fv0odYxSfR+/sJE8R0XomONiGIakWJe5OeQnWKSzycsQTK9pB4+LEd
	Gmy3GSVWfG1lnsCoMAspVGYh+X4Wkm9mIWxewMiyilEytaA4Nz212LTAMC+1HB7fyfm5mxjB
	SVfLcwfj3Qcf9A4xMnEwHmKU4GBWEuGddPNjmhBvSmJlVWpRfnxRaU5q8SFGU2DsTGSWEk3O
	B6b9vJJ4QxNLAxMzMzMTS2MzQyVx3tetc1OEBNITS1KzU1MLUotg+pg4OKUamNa2zxFYl9S0
	SvVPRphHybOeH7l7OKJ8FxlE1R13fFXPXna3typRta838GfLTNV1f3Z/M02sYXaYoDifJfPL
	9bKysoLfJ9YKPf2kMckg5sDvrdvt93kJKxy6Vfjm71WX7dzx+ew+j9jWKz+bMiFIf1Uoj1vn
	vx8bY7S2d26LmX+U73DNBRGrnbcMd/9wemgXXPhbNZtZ+cGnSt7l36IrdG5ovS0/mpAU/CVd
	KIXvzJ7au8K89tNWR7zO6/W/++Sze33P3NOJLhM/3JzhwPPfSfJKQwiX4FSvDWdl9ntGX4iu
	Wvr63t3Cl4YGP/vfC2fU53ifFOx5Op3P55lk4WfW2vczfO7M+VvNJP+05lbEPiWW4oxEQy3m
	ouJEAGzMBrVDBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJXvdH79c0g/vTRSxW3+1ns/i+vY/F
	4uaBnUwWK1cfZbKYdOgao8XeW9oW85c9ZbdYfvwfk8W61+9ZHDg9zt/byOJx+Wypx6ZVnWwe
	m5fUe+y+2cDm8fHpLRaPvi2rGD0+b5IL4IjisklJzcksSy3St0vgynjw8AZjwVuuitevW1kb
	GE9zdDFyckgImEgsWfiVDcQWEtjNKNEyJx4iLi7RfO0HO4QtLLHy33Mgmwuo5jWjxItlH8AS
	vAJ2Emtm/GbtYuTgYBFQlTi/2RwiLChxcuYTFhBbVCBJYs/9RiYQW1ggSGLL4x4wmxlo/q0n
	88FsEQFlibvzZ7KCzGcWOMsoMalzBhPEstuMEvO2TmUGWcAmoClxYXIpSAOngJbE29vP2SAG
	mUl0be1ihLDlJba/ncM8gVFoFpI7ZiHZNwtJyywkLQsYWVYxSqYWFOem5yYbFhjmpZbrFSfm
	Fpfmpesl5+duYgRHmJbGDsZ78//pHWJk4mA8xCjBwawkwjvp5sc0Id6UxMqq1KL8+KLSnNTi
	Q4zSHCxK4ryGM2anCAmkJ5akZqemFqQWwWSZODilGpieCs9erT7RqEJpeWDxR6lN28y4ZyxQ
	6nUxNJpx6duRYnnjL2/72dSlz7t49nPWvasUvrH82YqIVYtXuQrzm7Kq3j2T9GjC4wOHzKZ9
	fNl4ceW6rh9Rv+27N634k7C1aWPzt8TcpKU8zyynnHjLvfR2COv51uZLPEx9T9j5jbjsD5Xd
	/VMmpWA6PW3Jo9s2ToUHN3gyqj459tTm5c8WnfdBy+bs6fXx52M9XS11+obenz1v54Wcn/xo
	76R5+1bdfnFewvO7+9bVD8MLc/PktrXdcXis/6/H/U6Du3iHs3QJx5ve1rj8b4u3npWz2x97
	5/UBZpPPzHl8n060XtU/pPeAUeNAQHlL4yb1aOsdDcuylFiKMxINtZiLihMBWEPXch8DAAA=
X-CMS-MailID: 20240926163816epcas5p3c74179bddf80da97477a0c947f5556ac
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240201130843epcas5p1b1840bd14ced64a1effb6fd8c93c926d
References: <20240201130126.211402-1-joshi.k@samsung.com>
	<CGME20240201130843epcas5p1b1840bd14ced64a1effb6fd8c93c926d@epcas5p1.samsung.com>
	<20240201130126.211402-3-joshi.k@samsung.com> <ZvV4uCUXp9_4x5ct@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240926_093827_504694_DB8867AC 
X-CRM114-Status: GOOD (  21.03  )
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

On 9/26/2024 8:37 PM, Keith Busch wrote:
> On Thu, Feb 01, 2024 at 06:31:25PM +0530, Kanchan Joshi wrote:
>> Block layer integrity processing assumes that protection information
>> (PI) is placed in the first bytes of each metadata block.
>>
>> Remove this limitation and include the metadata before the PI in the
>> calculation of the guard tag.
> 
> Very late reply, but I am just now discovering the consequences of this
> patch.
> 
> We have drives with this format, 64b metadata with PI at the end. With
> previous kernels, we had written data to these drives. Those kernel
> versions disabled the GUARD generation, so the metadata was written
> without it, and everything was fine.
> 
> Now we upgrade to 6.9+, and this kernel enables the GUARD check. All the
> data previously written to this drive is unreadable because the GUARD is
> invalid.
> 
> Not sure exactly what to do about this, but it is a broken kernel
> upgrade path, so wanted to throw that information out there.
> 

Ah, writing to the disk without any guard, but after that reading with 
the guard!

I wish if there was a way to format the NVMe only to reset its pi type 
(from non-zero to 0).
But there are kernel knobs too. Hope you are able to get to the same 
state (as nop profile) by clearing write_generate and read_verify:
echo 0 > /sys/block/nvme0n1/integrity/read_verify


