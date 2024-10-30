Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E8EBD5CCB1
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 14:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vgFe+mIp8kTKyb34kU2wZeoq2vGKRybw9PQjsSI2sFY=; b=zyRht6M01/+oEXm1xIVwHYx58X
	IqCK1kpFCfnAwxmHzebVHf7ylPEqfiiun34LS0V+BpuWmLDqBFfbNNBT9Bk6Y4WhjDPeo0ItZseU4
	iv+5pYrCgsBdaz5DNbcAqAWC6xU0G0FEuenYMzD7UGhEar9G20Us4GlZTJJAh+uwRjb7kA6NciO2H
	OxhrnQp8g3CeZeMpN3hn1wJqfOdsHA2fUmpF8HTd4oBSDRN8NOO+HmngkdDcA57dmzA52cuguYkax
	XoVAm6AwL2M1jc1xsQBIixy/sCzctR3/AvBQRiHX67Oom7P4MutXpJScnyQIIi6i3VhDazUWhzaAn
	rGHrqjIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t69G0-00000000aA6-2SEH;
	Wed, 30 Oct 2024 14:01:08 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t69Ee-00000000ZxU-34pz
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 13:59:46 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20241030135938epoutp01defe835941fd013400623ea293b42038~DP8CMYgl31969119691epoutp01U
	for <linux-nvme@lists.infradead.org>; Wed, 30 Oct 2024 13:59:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20241030135938epoutp01defe835941fd013400623ea293b42038~DP8CMYgl31969119691epoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1730296778;
	bh=vgFe+mIp8kTKyb34kU2wZeoq2vGKRybw9PQjsSI2sFY=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Y16qfiXMOsl5J5ZWRvfNqZmpw2ftOxbsaoc56vUKTy8pJ4SJpnUEz2WxQNx4Kq/Fs
	 L423bH/yrAVG2iutFXrbIHlEX1wRyEfEeB4JvNoI350X7KquMI/Q9+HW843YTRbqEZ
	 CWjCiTq7RpPtsvJY7Z6aBhDNqcCUGLiwcUNGvsuI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20241030135936epcas5p47a0a5aab8a01be2ca5785c81f577a700~DP8BHBadz0566905669epcas5p4e;
	Wed, 30 Oct 2024 13:59:36 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Xdpf01grhz4x9Pr; Wed, 30 Oct
	2024 13:59:36 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8B.29.09770.8CB32276; Wed, 30 Oct 2024 22:59:36 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20241030135935epcas5p4b42e5355e469e99a9ebcb8f66a56bccb~DP7-7Pedv0566905669epcas5p4d;
	Wed, 30 Oct 2024 13:59:35 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241030135935epsmtrp2f92877ceabf3508ef8f735c0fcdab905~DP7-6oTgL2403824038epsmtrp2e;
	Wed, 30 Oct 2024 13:59:35 +0000 (GMT)
X-AuditID: b6c32a4a-e25fa7000000262a-2a-67223bc84a66
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	90.4E.08227.7CB32276; Wed, 30 Oct 2024 22:59:35 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241030135934epsmtip1d05ef58cdd199ae5647049a2ae95b51e~DP7_qDHr52369823698epsmtip1Q;
	Wed, 30 Oct 2024 13:59:34 +0000 (GMT)
Message-ID: <554281ce-9f83-48db-9e24-7a7cfd4ed240@samsung.com>
Date: Wed, 30 Oct 2024 19:29:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-integrity: remove seed for user mapped buffers
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@meta.com>, hch@lst.de,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: anuj20.g@samsung.com, martin.petersen@oracle.com, Keith Busch
	<kbusch@kernel.org>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <75331d62-fb0b-41ef-9a47-2bbe78e09f9f@kernel.dk>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOJsWRmVeSWpSXmKPExsWy7bCmuu4Ja6V0g6OtnBZNE/4yW6y+289m
	sXL1USaLSYeuMVqcubqQxWLvLW2L+cueslssP/6PyYHD4/LZUo9NqzrZPDYvqffYfbOBzePc
	xQqPj09vsXj0bVnF6PF5k1wAR1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmS
	Ql5ibqqtkotPgK5bZg7QWUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScApMCveLE
	3OLSvHS9vNQSK0MDAyNToMKE7IwXn26xFcRXdF67x9rA6NnFyMkhIWAi8eXxOvYuRi4OIYHd
	jBI/JqxlBUkICXxilGicJQthf2OUuL8iG6bh4p4TLBDxvYwSU8+xQDS/ZZRo6djECJLgFbCT
	2Pu0jQnEZhFQlZj78wQrRFxQ4uTMJ2DNogLyEvdvzWAHsYUF3CWeru1gAxkkItDFKPF4ygtm
	kASzQLjEwZ5tTBC2uMStJ/OBbA4ONgFNiQuTS0HCnAK2EtPXPIcql5fY/nYOM8gcCYGFHBJt
	616zQFztIrG38zsjhC0s8er4FnYIW0ri87u9bBB2tsSDRw+g6mskdmzuY4Ww7SUa/txgBdnL
	DLR3/S59iF18Er2/n4CdIyHAK9HRJgRRrShxb9JTqE5xiYczlkDZHhItD/9Aw2opk8ScJ9tY
	JjAqzEIKlllIvpyF5J1ZCJsXMLKsYpRMLSjOTU8tNi0wyksth0d2cn7uJkZwitXy2sH48MEH
	vUOMTByMhxglOJiVRHgtgxTThXhTEiurUovy44tKc1KLDzGaAuNnIrOUaHI+MMnnlcQbmlga
	mJiZmZlYGpsZKonzvm6dmyIkkJ5YkpqdmlqQWgTTx8TBKdXApP9f3ko4YVqGksbsDSs9HVjF
	JTXKd1+Q7q5ct/7QEvkvJ/QZWf+8vlgheztMN8lwSsPl9rctRgpFlxMup6rNnGDm2qR8JnP3
	oj0nX7TfXBC5YDnDhGfMD3wnHXiT3qLtph96+KqCvs4GtTm3pyZNErwxvzTvl/UrR6eT09Rq
	FN2jRHI1v+wvstr4Vu3ix5CAhFittFXuLVaFScuMDx7Q3nTDaKF83bHSm9+09/X7LffTFupJ
	Fc3ytWvvkH3muHhx9YWmmi65xBy7O//t793vWc6UGM+cIxjawLVhGcODXLmwNTNWPjs6q+Pm
	m6XWSdr3mjgKdx5cyNb5O0Ryp17S1vWy6ZVT72Zah82WMd+vxFKckWioxVxUnAgAHBGboToE
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42LZdlhJTve4tVK6wYIlihZNE/4yW6y+289m
	sXL1USaLSYeuMVqcubqQxWLvLW2L+cueslssP/6PyYHD4/LZUo9NqzrZPDYvqffYfbOBzePc
	xQqPj09vsXj0bVnF6PF5k1wARxSXTUpqTmZZapG+XQJXxotPt9gK4is6r91jbWD07GLk5JAQ
	MJG4uOcESxcjF4eQwG5GiVNfVzFBJMQlmq/9YIewhSVW/nvODlH0mlGidelXsASvgJ3E3qdt
	YA0sAqoSc3+eYIWIC0qcnPmEBcQWFZCXuH9rBli9sIC7xNO1HWwgg0QEuhglVm+aCdbALBAu
	8eF3CxuILSSwlEniwB4LiLi4xK0n84EWcHCwCWhKXJhcChLmFLCVmL7mOTNEiZlE19YuRghb
	XmL72znMExiFZiE5YxaSSbOQtMxC0rKAkWUVo2RqQXFuem6xYYFRXmq5XnFibnFpXrpecn7u
	JkZwTGlp7WDcs+qD3iFGJg7GQ4wSHMxKIryWQYrpQrwpiZVVqUX58UWlOanFhxilOViUxHm/
	ve5NERJITyxJzU5NLUgtgskycXBKNTClHNda1lx8oCDfLSr32885W489OtW70dOz/8Zmobjc
	Rx8kv5gnCh+4Y7FW34PnQlmqm9Oe1Q8++XF9yV/GUHPg+u7t1p1blNTmbj/H4vZi+dE2pnUp
	75VlGtRsHodpiT160j3redRT7f4bk70OqPJsPNPx98xuvoXG/x8+4mtW5ZUWMj+87sfkWpkn
	ywyeXJgZrbzjXLXiAs4LiQL8tRE7VNIirPl/NsyTbREXD9K+aWdZLy3hc///smPaMs9utfoe
	1Hnw7ecUdfd8887cG1Obn30Ur1T6dF9wQZDT8o/ar8I6epkYGSUkZ7DY9vyvnOtvHb4xLpVv
	WePKE2sm6sz3irQ2zF1VmXH1SWvR5n4lluKMREMt5qLiRADAFqbzGAMAAA==
X-CMS-MailID: 20241030135935epcas5p4b42e5355e469e99a9ebcb8f66a56bccb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241016201337epcas5p33625af2c67f92092078b0b43874d67bd
References: <CGME20241016201337epcas5p33625af2c67f92092078b0b43874d67bd@epcas5p3.samsung.com>
	<20241016201309.1090320-1-kbusch@meta.com>
	<5220b70f-13e9-4f73-b611-97235db87ed5@samsung.com>
	<c156bc1f-da5c-4522-8e5d-b138a94cb7d2@kernel.dk>
	<75331d62-fb0b-41ef-9a47-2bbe78e09f9f@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_065945_136268_9DF9390E 
X-CRM114-Status: GOOD (  12.09  )
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

On 10/30/2024 7:20 PM, Jens Axboe wrote:
> Doesn't look like it is, picked it up.

Thanks.

