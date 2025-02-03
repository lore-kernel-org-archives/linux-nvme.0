Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02860C02192
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Feb 2025 13:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Sn+l8rsPtEhyWYMBjkIq4jtvzDpqY2GJAHjNtkksugQ=; b=S+e8G/bEccKJCBqTQ1/xHeZT64
	xp6BVWAVPSB86tvi4EQMlWxoujFeNISQRju+t47UtoV4807Eg/VNOy16CucORb3CiEGtEygd2J6Oa
	weKZYTqLdLJgh/eMpj3QgUT2P3sSmtv9YslyYm/snOzXNBksAoBRsiBDfahbINlWkqfYB1RbQep2o
	dwygVjoiovPnGPvYzitylTsZeIwRMauL4aBXA9ZcEcPn6ors2dVcKMl+XY7FffJky9EL7zCiaC4St
	sb1PjXXAbSb3qTs5cJHu4rQYHF5QJI+0YeOBY25GFiMn8e0wXvyLG/aJiDgf2CbVDFW472DGsaP1/
	a05f1L+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tewRC-0000000FVnx-2VH3;
	Mon, 03 Feb 2025 13:24:30 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tewR7-0000000FVmV-0IFS
	for linux-nvme@lists.infradead.org;
	Mon, 03 Feb 2025 13:24:29 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250203132418epoutp0183830238a6a48579d9e1d34bde03a74b~gtYl3Ogtq1316213162epoutp01q
	for <linux-nvme@lists.infradead.org>; Mon,  3 Feb 2025 13:24:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250203132418epoutp0183830238a6a48579d9e1d34bde03a74b~gtYl3Ogtq1316213162epoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738589058;
	bh=Sn+l8rsPtEhyWYMBjkIq4jtvzDpqY2GJAHjNtkksugQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=AHtunDDMi6rEsI3gTIFeSBgoKszxjVcgGim08o5J0D5v0iUnsARHkIQERo6TfhsPD
	 7xvJ7wZtb0BcqTUV2Q2fY0VlNKFZ9i0fDdZM2jmZ5qoJRrlcoAjzBX+8aDjRXSuhaR
	 ucERe/0nU6gmsAygUwqEcrJe1wTghvqj7TTzJIa0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250203132417epcas5p3c4586138db1e4f70dccd7f85835b0023~gtYlld50F2449724497epcas5p3G;
	Mon,  3 Feb 2025 13:24:17 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4YmnJw39bWz4x9Px; Mon,  3 Feb
	2025 13:24:16 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	15.9B.19933.083C0A76; Mon,  3 Feb 2025 22:24:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250203132416epcas5p29b636c04f0bef56c8f90bb30d21273a6~gtYj689-N2636126361epcas5p2f;
	Mon,  3 Feb 2025 13:24:16 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250203132416epsmtrp11bb8e49ea840d78ca84826ba12ec386e~gtYj6Q_GA2429824298epsmtrp1g;
	Mon,  3 Feb 2025 13:24:16 +0000 (GMT)
X-AuditID: b6c32a4a-c1fda70000004ddd-c8-67a0c3805888
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D4.66.18729.F73C0A76; Mon,  3 Feb 2025 22:24:15 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250203132414epsmtip1fa462c58e50f2fd28bf556d2e12d2b06~gtYiSTaaN2785527855epsmtip1I;
	Mon,  3 Feb 2025 13:24:14 +0000 (GMT)
Message-ID: <f336dbed-895c-4aa6-a621-84112e047989@samsung.com>
Date: Mon, 3 Feb 2025 18:54:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] Btrfs checksum offload
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: josef@toxicpanda.com, dsterba@suse.com, clm@fb.com, axboe@kernel.dk,
	kbusch@kernel.org, hch@lst.de, linux-btrfs@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <yq134h0p1m5.fsf@ca-mkp.ca.oracle.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEJsWRmVeSWpSXmKPExsWy7bCmhm7D4QXpBi8mi1qsvtvPZjGpfwa7
	xYUfjUwWNw/sZLJYufook8Wfh4YWkw5dY7TYe0vb4tLjFewW85c9ZbdYfvwfkwO3x8Tmd+we
	l8+Wemxa1cnmsXlJvcfumw1sHh+f3mLx6NuyitFj/ZarLB4TNm9k9fi8SS6AKyrbJiM1MSW1
	SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoXiWFssScUqBQQGJx
	sZK+nU1RfmlJqkJGfnGJrVJqQUpOgUmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsaUWU2sBdO5
	K04tmMjWwPiXo4uRk0NCwERi9/qZzF2MXBxCArsZJeb/vMoG4XxilNi0eD0LhPONUeL+gd3s
	MC2/Lr5mhEjsZZRYdeUtVMtbRonuzxNYQap4Bewkpj+YxAJiswioSJz9eY4dIi4ocXLmE7C4
	qIC8xP1bM4Di7BzCAroSO6JBoiICphKTP20FG8kscIdRYubRuYwgCWYBcYlbT+YzdTFycLAJ
	aEpcmFwKEuYUMJbY/ucRO0SJvMT2t3OYIe68wCHRtlsYwnaRuDqrmxXCFpZ4dXwL1C9SEi/7
	26DsbIkHjx6wQNg1Ejs290HV20s0/LnBCrKWGWjt+l36EKv4JHp/PwG7RkKAV6KjTQiiWlHi
	3qSnUJ3iEg9nLIGyPSReTDgGDaitjBI//u9ln8CoMAspTGYheXIWkm9mIWxewMiyilEytaA4
	Nz212LTAKC+1HB7dyfm5mxjBiVnLawfjwwcf9A4xMnEwHmKU4GBWEuE9vX1BuhBvSmJlVWpR
	fnxRaU5q8SFGU2DkTGSWEk3OB+aGvJJ4QxNLAxMzMzMTS2MzQyVx3uadLelCAumJJanZqakF
	qUUwfUwcnFINTAnmp2zUezrm84e+7yw+0DHXz6R13rcLU363+IqGnHUpijxy4IXv1PVPjjSu
	i7ERjhaL1fHxYdt6wNL2uNVln0VMnZ3V8We+N72zcAtNdVn1WcCAP/nGmrLLs2/vn8xZYr52
	bc72/2sEluWb7L3m83yBld3R/Z0hth2661WLcwJEg+eGGN0vnnzjuh+rrOL6cE3xxp35WivP
	xNQ/ncp6VjD7Z1mUYs+JuY4vnZcXlroEe0QoWn3LOHRTeE01U7SHNoP9MiF2xqzCiOl3zB72
	FF3eubYrV+nNn3dprxM87KOt7Y6yPzzhtdZRObPrd0xy6d3Q6y6GKS9iEsu3hCuqSm0+ssfm
	VOLsb8vtnsUosRRnJBpqMRcVJwIAuETp41UEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsWy7bCSnG794QXpBhtf2VisvtvPZjGpfwa7
	xYUfjUwWNw/sZLJYufook8Wfh4YWkw5dY7TYe0vb4tLjFewW85c9ZbdYfvwfkwO3x8Tmd+we
	l8+Wemxa1cnmsXlJvcfumw1sHh+f3mLx6NuyitFj/ZarLB4TNm9k9fi8SS6AK4rLJiU1J7Ms
	tUjfLoErY8qsJtaC6dwVpxZMZGtg/MvRxcjJISFgIvHr4mvGLkYuDiGB3YwSp/p+sEEkxCWa
	r/1gh7CFJVb+e84OUfSaUWLvgmZWkASvgJ3E9AeTWEBsFgEVibM/z7FDxAUlTs58AhYXFZCX
	uH9rBlCcnUNYQFdiRzRIVETAVGLyp61sICOZBe4wSvybe4MJYv5WRoltt88wglQxAx1x68l8
	oAQHB5uApsSFyaUgYU4BY4ntfx6xQ5SYSXRt7YIql5fY/nYO8wRGoVlIrpiFZNIsJC2zkLQs
	YGRZxSiZWlCcm55bbFhgmJdarlecmFtcmpeul5yfu4kRHIdamjsYt6/6oHeIkYmD8RCjBAez
	kgjv6e0L0oV4UxIrq1KL8uOLSnNSiw8xSnOwKInzir/oTRESSE8sSc1OTS1ILYLJMnFwSjUw
	Me1eff/IYd6loffrZmev9rNiX3bH/vh/hZrH95u0ViXM0hP0MXKarOPNZsf0l8sknWH14+vX
	oncUX32fqb1uwZwFF3ff3NfwOK10p5nt926717EL8ytt28LsGrec0nb/8veNfN0T74tH5lz3
	7JdRPnQ54IGv4vYJefdO/sk2+j930sEQyfjed5syjp59Fz/jEJu7FL/R+o6FOckJ2wQOrTmw
	q1fX/jzXytArfQofZRSfsNf0bhVw2f9b+d+iF5M/BTu+WbKp/e3DqAlzRe+YeD0SK/2setne
	x8jj8Zo5v7q3NIWp7QkyzHzP+fTjjO4v2XLuFSWKDAuqTqvlO7Q+2y9xduc7EyXlJZ/f7z+c
	cEuJpTgj0VCLuag4EQBWN79mMgMAAA==
X-CMS-MailID: 20250203132416epcas5p29b636c04f0bef56c8f90bb30d21273a6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250129141039epcas5p11feb1be4124c0db3c5223325924183a3
References: <CGME20250129141039epcas5p11feb1be4124c0db3c5223325924183a3@epcas5p1.samsung.com>
	<20250129140207.22718-1-joshi.k@samsung.com>
	<yq134h0p1m5.fsf@ca-mkp.ca.oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250203_052427_974871_C2512123 
X-CRM114-Status: GOOD (  21.28  )
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

On 1/31/2025 1:51 AM, Martin K. Petersen wrote:
>> There is value in avoiding Copy-on-write (COW) checksum tree on a
>> device that can anyway store checksums inline (as part of PI). This
>> would eliminate extra checksum writes/reads, making I/O more
>> CPU-efficient. Additionally, usable space would increase, and write
>> amplification, both in Btrfs and eventually at the device level, would
>> be reduced [*].
> I have a couple of observations.
> 
> First of all, there is no inherent benefit to PI if it is generated at
> the same time as the ECC. The ECC is usually far superior when it comes
> to protecting data at rest. And you'll still get an error if uncorrected
> corruption is detected. So BLK_INTEGRITY_OFFLOAD_NO_BUF does not offer
> any benefits in my book.

I fully agree, there is no benefit if we see it from E2E use case.
But for a different use case (i.e., checksum offload), 
BLK_INTEGRITY_OFFLOAD_NO_BUF is as good as it gets.

[Application -> FS -> Block-layer -> Device]

I understand that E2E gets stronger when integrity/checksum is placed at 
the origin of data (application), and then each component collaborates 
in checking it.

But I am not doing E2E here. Call it abuse or creative, but I am using 
the same E2E capable device to do checksum-offload. If the device had 
exposed checksum-offload in a different way, I would have taken that 
route rather than E2E one.

