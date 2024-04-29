Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A336CC4345F
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Apr 2024 10:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Az+hRiv5av28fx/NMox4ku8zhbC9n/++KSpp75bjFT8=; b=JLmxktWlbDbKRjwCNxPIpZ+xz9
	TJ4dp6Mn3/YiKg7cZ6Fj0vu5Udikp6u5/Di3fFJF5W0KpauX5H7SMTzpjtOz4tZjoFFSll8mhTWkp
	J/G2d5Np4JsSEXrivdPpg0680OuQiZdTzQdHYJ4T8Ukj+/oYGkgBMIJ8/QRJI2eKzbDgJLDqVbpv8
	0ACtVyNaTaJStO9hLpK8h55aB/FTMq3oL2z4Dv0M3Bp/7G1VpvnSdA8OFYqLkT5pAjuU8aTq0IDBF
	cojYUiQhuR6G+uMsww+GxazMpw+rHZjjmn0Ki55EXJfvx8Mjqa+XXa+roFCGT+C1js7odIDj8Xx/t
	RTGlq2Iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1Ojc-00000002NCG-3Nfn;
	Mon, 29 Apr 2024 10:59:48 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1OjY-00000002NBR-3jRf
	for linux-nvme@lists.infradead.org;
	Mon, 29 Apr 2024 10:59:47 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240429105936epoutp042fa2f52da1b390c884d176b802876714~KuyUX26pl3040030400epoutp04G
	for <linux-nvme@lists.infradead.org>; Mon, 29 Apr 2024 10:59:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240429105936epoutp042fa2f52da1b390c884d176b802876714~KuyUX26pl3040030400epoutp04G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1714388376;
	bh=Az+hRiv5av28fx/NMox4ku8zhbC9n/++KSpp75bjFT8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=ng3MPmLxV/sEyqlNUj42GGAua8XRgEzOmi6yY4bUogxWit5aLQInBEvSUIjE5pWi5
	 Gexpj1MzBuL+4ViOMbyomXNiBbcKw9XbDMb8gTXS207mqn6e0g2pTc8Cp0tnVK7gXv
	 kYIomg+cATYt5W26qHRoJ2ncjunE14rX+v3Ue3lY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240429105935epcas5p3c89a15e085f6801054e7b7694902dbe7~KuyTzmNpC1482714827epcas5p3w;
	Mon, 29 Apr 2024 10:59:35 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4VSgM96YZ2z4x9Pv; Mon, 29 Apr
	2024 10:59:33 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4A.5E.09665.59D7F266; Mon, 29 Apr 2024 19:59:33 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240429105933epcas5p271bec7690d5e6e2e9264754fab4a7b3d~KuyR2RPLB0104201042epcas5p2p;
	Mon, 29 Apr 2024 10:59:33 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240429105933epsmtrp145532c8f3c6f5865a68786f88cd3c04b~KuyRxgbZJ0970609706epsmtrp1V;
	Mon, 29 Apr 2024 10:59:33 +0000 (GMT)
X-AuditID: b6c32a4b-829fa700000025c1-9c-662f7d954ace
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F4.28.08390.59D7F266; Mon, 29 Apr 2024 19:59:33 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240429105931epsmtip1cc615a2ad8041ab968fb6c42a7a1c350~KuyQCkEtc2520925209epsmtip1Y;
	Mon, 29 Apr 2024 10:59:31 +0000 (GMT)
Message-ID: <53be2abc-5a46-fef6-1cb3-cd791e3f42be@samsung.com>
Date: Mon, 29 Apr 2024 16:29:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH 01/10] block: set bip_vcnt correctly
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, brauner@kernel.org,
	asml.silence@gmail.com, dw@davidwei.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <Zi0I1Aa7mIJ9tOht@kbusch-mbp.mynextlight.net>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKJsWRmVeSWpSXmKPExsWy7bCmlu7UWv00g7aJxhZNE/4yW8xZtY3R
	YvXdfjaL14c/MVq8mrGWzeLmgZ1MFitXH2WyeNd6jsVi0qFrjBZ7b2lbzF/2lN1i+fF/TA48
	HtdmTGTx2DnrLrvH5bOlHptWdbJ5bF5S77H7ZgObx8ent1g8+rasYvT4vEkugDMq2yYjNTEl
	tUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6GAlhbLEnFKgUEBi
	cbGSvp1NUX5pSapCRn5xia1SakFKToFJgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbGzhmvWAo2
	sVb8/rOWtYFxBUsXIyeHhICJxJUv+5lAbCGB3YwSK17zdjFyAdmfGCUu/uxihnC+MUpceHuR
	Dabj1OrNUIm9jBKLp29mgnDeMko83LGOHaSKV8BO4tSpncwgNouAqsTivvfMEHFBiZMzn4Dt
	FhVIlvjZdQBsqrCAhcSuf7/B4swC4hK3nswHu0lEwFnib+95sAXMAo1MEhtenAdq4OBgE9CU
	uDC5FKSGU8BKoqVzKitEr7zE9rdzwK6TEDjDITHvQjc7xNkuEifWToCyhSVeHd8CZUtJvOxv
	g7KTJS7NPMcEYZdIPN5zEMq2l2g91c8MspcZaO/6XfoQu/gken8/YQIJSwjwSnS0CUFUK0rc
	m/SUFcIWl3g4YwmU7SHx9/gORkhYdTBJzF62iG0Co8IspGCZheT9WUjemYWweQEjyypGydSC
	4tz01GLTAuO81HJ4hCfn525iBKdnLe8djI8efNA7xMjEwXiIUYKDWUmEd9Mc7TQh3pTEyqrU
	ovz4otKc1OJDjKbA+JnILCWanA/MEHkl8YYmlgYmZmZmJpbGZoZK4ryvW+emCAmkJ5akZqem
	FqQWwfQxcXBKNTA95voZ2jxjjVHYvPJP1rHs+ZHbHFasmrrtuP/jb9GFM/KecLXmvdZYx/NO
	m786kT1S+liQkMZ0y3lr7Yva83yOyF3LX77+l7tMmI/9v118Rn5qpc++hsev2/s2Z887d8m7
	JytTejTen4639L6pdVvzX3TAUr2stBNWH5POyGlISPtq8lrsK9La7jPp16b8vwrbvgpZZ1zf
	6m52+dGsjBKHWWZLfWscXCZX5JXeu+Vn/Gvv6ZDfv6KXrC/evoRL79Gnf3GpK9cuNJi19u3K
	8PsRdwR5tISyD14+NklL/muCxB/+CUrVd2zLZyx+9Oeb2OcfbvO/cj85wM256o3Ss2DO0Jrn
	3duKPd8lvlA+GPZMiaU4I9FQi7moOBEANCsywlgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsWy7bCSnO7UWv00g2+3+SyaJvxltpizahuj
	xeq7/WwWrw9/YrR4NWMtm8XNAzuZLFauPspk8a71HIvFpEPXGC323tK2mL/sKbvF8uP/mBx4
	PK7NmMjisXPWXXaPy2dLPTat6mTz2Lyk3mP3zQY2j49Pb7F49G1ZxejxeZNcAGcUl01Kak5m
	WWqRvl0CV8bOGa9YCjaxVvz+s5a1gXEFSxcjJ4eEgInEqdWbmUFsIYHdjBK/dxhAxMUlmq/9
	YIewhSVW/nsOZHMB1bxmlOhZM5UNJMErYCdx6tROsGYWAVWJxX3vmSHighInZz4BWyAqkCzx
	8s9EsEHCAhYSu/79BoszAy249WQ+E4gtIuAs8bf3PBPIAmaBRiaJpQvmsEBc1MEk8fmMcBcj
	BwebgKbEhcmlIGFOASuJls6prBBzzCS6tnYxQtjyEtvfzmGewCg0C8kZs5Csm4WkZRaSlgWM
	LKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYIjUUtrB+OeVR/0DjEycTAeYpTgYFYS
	4d00RztNiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+3170pQgLpiSWp2ampBalFMFkmDk6pBqYA
	643qJq/CrzDFcr8L3hq38+dJh7TmLxMsT21SuRsWLdllffjRxMlr3c91pgdttpzQv3uS6q6f
	ifcFmBdJ/Syye6GtFKTFvHHzPd6v3obPdKb8X6h59AvPPvVsa8NtmZtjKuL3rDjyLK6dM/hN
	JP9UEW/tCVrWxVm/1JS8Agz7FnHyp9XKGvgu2BZ976uZUflyqSN2K3/rJp1I/OrMOVOe8w6z
	ic17Y/7coOMb/J43qix+Lb/j+KZbU6YrPbg4R/3i8vssH/V/yltMNVP29+bZLPnqU0O+1QGt
	NZ2zBLWt2OL+p/B23qzf0FRnI/7+sfGZJ78XcbOy3uX8VC6foWnvkZu/Y7Z59pZ/zy+ZSSqx
	FGckGmoxFxUnAgAEw6XRMwMAAA==
X-CMS-MailID: 20240429105933epcas5p271bec7690d5e6e2e9264754fab4a7b3d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240425184651epcas5p3404f2390d6cf05148eb96e1af093e7bc
References: <20240425183943.6319-1-joshi.k@samsung.com>
	<CGME20240425184651epcas5p3404f2390d6cf05148eb96e1af093e7bc@epcas5p3.samsung.com>
	<20240425183943.6319-2-joshi.k@samsung.com> <20240427070214.GA3873@lst.de>
	<Zi0I1Aa7mIJ9tOht@kbusch-mbp.mynextlight.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240429_035945_662880_51187358 
X-CRM114-Status: GOOD (  12.53  )
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

On 4/27/2024 7:46 PM, Keith Busch wrote:
>> Looks good:
>>
>> Reviewed-by: Christoph Hellwig<hch@lst.de>
>>
>> Please add a Fixes tag and submit it separately from the features.
>>
>> I'm actually kinda surprised the direct user mapping of integrity data
>> survived so far without this.
> The only existing use case for user metadata is REQ_OP_DRV_IN/OUT, which
> never splits, so these initial fixes only really matter after this
> series adds new usage for generic READ/WRITE.
> 

Yes. It did not seem that there is any harm due to these missing pieces 
(first 6 patches).
Therefore, "Fixes" tag is not there, and patches were not sent 
separately from the features.


