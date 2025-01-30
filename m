Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6753C0218A
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jan 2025 09:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wx7aZCGHZqI05fpqUcDZen/kuLIz9kgd4IntaYov6A8=; b=o8xCqeRhIfJ+I2gjNaTfvMwmeB
	6ux8GXz5LNKqSGmy4t0n4WoIJRi6hukQHjAHq5mf/Y37p8mURrK0zZk7/2iTIoH3Wc4t8xcFi1ao9
	JQ6/Mwi3VLZa2JhSuHReRC5A/migMKh1IPhI5CV4ajJ4Do2Mja/0LuK5SDAgoNgGFhFpoHsImcGhw
	kmw/aPJtcHwLu6Kxn9T1dctTYOiRyX+0ZoeptLd7HdMthJIO/kNW0/lvQq5zni9LTFLSpG/rVogiF
	9FBXAYqNkLDaMLh0vhcg1ov2UJ/28flTWOn5IWkBY+IehnNN5QOAd4YTdQXx6966gk362EojwC0Br
	xVamynCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdQku-00000008UcQ-0j2Z;
	Thu, 30 Jan 2025 09:22:36 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdQkr-00000008Ubx-1OzU
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jan 2025 09:22:34 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250130092228epoutp01e29427c044e4a58504bc93428a4beae7~fbgTsy65f3119931199epoutp01c
	for <linux-nvme@lists.infradead.org>; Thu, 30 Jan 2025 09:22:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250130092228epoutp01e29427c044e4a58504bc93428a4beae7~fbgTsy65f3119931199epoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738228948;
	bh=Wx7aZCGHZqI05fpqUcDZen/kuLIz9kgd4IntaYov6A8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=UR/iiUHQio+Ruwh19yWhLObeDCjsm65POfDFiWszE0VI0d0+wDPLB/CZ2sbPAd+uP
	 9xnh+MWIcZMxNluHZ5nzu5+r6Ys8uQcmfVq5vd0WAygW+eTPboLlebGkLTPJZ7QhOn
	 gsWedmxM9fbFO0K+1tV3JW8XxsgklOu1AatUucXo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20250130092228epcas5p237fe7db3196715a946b65bda1c7b9a5f~fbgTMX06D2560325603epcas5p2I;
	Thu, 30 Jan 2025 09:22:28 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4YkD7k5915z4x9Px; Thu, 30 Jan
	2025 09:22:26 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D2.EB.29212.2D44B976; Thu, 30 Jan 2025 18:22:26 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250130092226epcas5p4c8830a18efedb85436a2167c5146058c~fbgRcCQ5P3189131891epcas5p4U;
	Thu, 30 Jan 2025 09:22:26 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250130092226epsmtrp1fc9bfa099aecd7f940cedb88d2feb898~fbgRbMQ-q2846128461epsmtrp1r;
	Thu, 30 Jan 2025 09:22:26 +0000 (GMT)
X-AuditID: b6c32a50-7ebff7000000721c-6c-679b44d2dd6f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9E.DC.18949.2D44B976; Thu, 30 Jan 2025 18:22:26 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250130092224epsmtip1d983c41a07ed41df2dd58005c2805c44~fbgP7FMmy1288612886epsmtip15;
	Thu, 30 Jan 2025 09:22:24 +0000 (GMT)
Message-ID: <b5fe3e15-cd7f-41ce-9ac8-70dca0fee37a@samsung.com>
Date: Thu, 30 Jan 2025 14:52:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] Btrfs checksum offload
To: Christoph Hellwig <hch@lst.de>
Cc: josef@toxicpanda.com, dsterba@suse.com, clm@fb.com, axboe@kernel.dk,
	kbusch@kernel.org, linux-btrfs@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250129153524.GB5356@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJJsWRmVeSWpSXmKPExsWy7bCmhu4ll9npBg1fVSxW3+1ns5jUP4Pd
	4sKPRiaLmwd2MlmsXH2UyeLPQ0OLSYeuMVrsvaVtcenxCnaL+cuesjtweUxsfsfucflsqcem
	VZ1sHpuX1HvsvtnA5tG3ZRWjx/otV1k8JmzeyOrxeZNcAGdUtk1GamJKapFCal5yfkpmXrqt
	kndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0JVKCmWJOaVAoYDE4mIlfTubovzSklSF
	jPziElul1IKUnAKTAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMTf1bWQtuclb8nWLUwPiUvYuR
	k0NCwESi7ch7li5GLg4hgT2MEpNnrGGDcD4xSqyY28wI4XxjlDhz6QQrTMv+O4+YIRJ7GSW2
	v+iAct4ySmzqXswCUsUrYCfxePIiZhCbRUBV4u+vq0wQcUGJkzOfgNWICshL3L81A+gQdg5h
	AV2JHdEgUREBJYmnr86CLWYWuMAosXLPI7BWZgFxiVtP5gPZHBxsApoSFyaXgoQ5BbQlfs88
	wwZRIi+x/e0csHMkBPZwSOw/+50R4mgXid+bT0LZwhKvjm+B+l9K4mV/G5SdLfHg0QMWCLtG
	YsfmPqiH7SUa/txgBdnLDLR3/S59iF18Er2/n4CdIyHAK9HRJgRRrShxb9JTqE5xiYczlkDZ
	HhIvJhyDBu5qRom7N6+xTWBUmIUUKLOQfDkLyTuzEDYvYGRZxSiVWlCcm56abFpgqJuXWg6P
	7+T83E2M4DSsFbCDcfWGv3qHGJk4GA8xSnAwK4nwxp6bkS7Em5JYWZValB9fVJqTWnyI0RQY
	PROZpUST84GZIK8k3tDE0sDEzMzMxNLYzFBJnLd5Z0u6kEB6YklqdmpqQWoRTB8TB6dUAxNT
	6B7/Q7cnMGRxvNsr1BZwaUKhOAPP0vdnJ9Sb+M7LLAyX/GVuPP33t3PbS8yLLzervbpj+O7o
	hi0dn6ynL/8q5HYtcpfQ/z2fL+9Yd2dtwBxxa9buGcnSaZ58fw6LG7LNFl6ZUtGRcGqJARdj
	SrbPpbn7pnf/i+3KLn7y/oKCkdOv+62PBPTFfN85Orto3CzNsDvnu3qJ1OwpdlXrMpdOWLru
	90zd4FMZWyTjp/R9kkk+uzXi5uuf4p6LNHaLBE+86eK4oj8ogDUo5y5vK6/YYkZJ/kqhzK/B
	k1cFNouxrvzMd0C7oH+6gdVL65ZgAZfey09rV0srbmPumJewuvZ/hPGSJrvnmjHZc/5r3ldi
	Kc5INNRiLipOBAAhsS8CTAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsWy7bCSnO4ll9npBv+usFqsvtvPZjGpfwa7
	xYUfjUwWNw/sZLJYufook8Wfh4YWkw5dY7TYe0vb4tLjFewW85c9ZXfg8pjY/I7d4/LZUo9N
	qzrZPDYvqffYfbOBzaNvyypGj/VbrrJ4TNi8kdXj8ya5AM4oLpuU1JzMstQifbsEroxN/VtZ
	C25yVvydYtTA+JS9i5GTQ0LARGL/nUfMXYxcHEICuxkldvbNYoRIiEs0X/sBVSQssfLfc3aI
	oteMEq2d05lAErwCdhKPJy9iBrFZBFQl/v66ChUXlDg58wkLiC0qIC9x/9YMoGZ2DmEBXYkd
	0SBREQEliaevzjKCjGQWuMAoseTyEUaI+asZJXb9PwJ2BDPQEbeezAeaycHBJqApcWFyKUiY
	U0Bb4vfMM2wQJWYSXVu7oMrlJba/ncM8gVFoFpIrZiGZNAtJyywkLQsYWVYxSqYWFOem5xYb
	FhjlpZbrFSfmFpfmpesl5+duYgRHnJbWDsY9qz7oHWJk4mA8xCjBwawkwht7bka6EG9KYmVV
	alF+fFFpTmrxIUZpDhYlcd5vr3tThATSE0tSs1NTC1KLYLJMHJxSDUx8+xiyZj76+Gm2YdND
	WXX1KSHGbx+1MrWy7jyp+D+v0XDm77vP1OKjmNZ6Nrx54Ppraw1P/2bBNbYcHyx9mm++ufrV
	u5exRnKXcCFr6++VT4uUPmnkqwfw7bJj0LB3NhOUXfdk4fIrShPLLR7pyh2UTrQ6wnq/0ufa
	wVnJgWrxIqayOWc+Xli8pXl/m5TV25avT+e4bF+R1VWl5hJvUX7N+mxIYK3umrrp9r1S7nV+
	gXEnmeb/3P5z4hObnnUNr64Vsh9a7fRP5fY7tV0rz89SbN4XmBV2N6BhQdOdg1zf3kjetZrw
	x3SbMluV8qHvTUVaYT7r2jK2rVgZK3/ZO0rbfHKkVjtf9e7N84qvrVFiKc5INNRiLipOBACO
	1ZfqJwMAAA==
X-CMS-MailID: 20250130092226epcas5p4c8830a18efedb85436a2167c5146058c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250129141039epcas5p11feb1be4124c0db3c5223325924183a3
References: <CGME20250129141039epcas5p11feb1be4124c0db3c5223325924183a3@epcas5p1.samsung.com>
	<20250129140207.22718-1-joshi.k@samsung.com> <20250129153524.GB5356@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250130_012233_709860_B5DECF73 
X-CRM114-Status: GOOD (  16.97  )
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

On 1/29/2025 9:05 PM, Christoph Hellwig wrote:
>> This patch series: (a) adds checksum offload awareness to the
>> block layer (patch #1),
> I've skipped over the patches and don't understand what this offload
> awareness concept does compared the file system simply attaching PI
> metadata.

Difference is that FS does not have to attach any PI for offload.

Offload is about the Host doing as little as possible, and the closest 
we get there is by setting PRACT bit.

Attaching PI is not really needed, neither for FS nor for block-layer, 
for pure offload.
When device has "ms == pi_size" format, we only need to send I/O with 
PRACT set and device take care of attaching integrity buffer and 
checksum generation/verification.
This is abstracted as 'offload type 1' in this series.

For other format "ms > pi_size" also we set the PRACT but integrity 
buffer also needs to be passed. This is abstracted as 'offload type 2'.
Still offload as the checksum processing is done only by the device.

Block layer Auto-PI is a good place because all above details are common 
and remain abstracted, while filesystems only need to decide whether 
they want to send the flag (REQ_INTEGRITY_OFFLOAD) to use the facility.

