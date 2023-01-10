Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D910C46467
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Jan 2023 08:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=flRUX4TXNKSuq6zxzZbc4RMO77h5oBaEM+JJT0NzPuQ=; b=TY3M6zwTDbZYM1
	Bjxyjybs/fIRV1mLhddquURrCg3dEHdWYsbXzFEZthWaHAVrdSRFr0ins6MrN2WUuEZV52T1O6Wfl
	LOTF7UobQpOknW1kem2wgcpeOthYnM1ZG1QN+1G6bhgkq0PzSJ5B3EdudvfGc5WPb1Ib4zI6rNMK2
	ODC4um9Fw7n4VmpGus1OI/e+uCM4zbBWgtWWNBnm5zY/dQtBjwkUeaeJHwG8fm6SXrJAOTEx1eLGO
	aoCDsiVlebZwYC2BPSx33ckL5+aVKoRaeyCskY5yOxb0uqRj7/b06MnUGbJ75dqDWIPiMqTOF+eDM
	9uLKtbVUW4fvp2PunI6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFAAJ-005qd4-K3; Tue, 10 Jan 2023 08:39:27 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFAAF-005qaP-RA
	for linux-nvme@lists.infradead.org; Tue, 10 Jan 2023 08:39:26 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230110083915euoutp02c86cd45fd6d326ad0f805d994b0796b4~45dL-Np9c2581825818euoutp02Q
	for <linux-nvme@lists.infradead.org>; Tue, 10 Jan 2023 08:39:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230110083915euoutp02c86cd45fd6d326ad0f805d994b0796b4~45dL-Np9c2581825818euoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1673339955;
	bh=flRUX4TXNKSuq6zxzZbc4RMO77h5oBaEM+JJT0NzPuQ=;
	h=Date:Subject:To:CC:From:In-Reply-To:References:From;
	b=gVbvMCHD+BcKucAjHmnYkbazLCu4DBOjxGrq89odls1qDGArDh8D5Mx04naQ4WAe6
	 eP0Q0qEEVhFwGPEHBAsT54ze9xmY2f4YGm6kfqB6nRC0YCUNWm+rFaL3ZEjEg5F/gg
	 ObP3PGXIJQWTD5Qcbq04its9yNi7NlbqNT0KOn50=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20230110083915eucas1p2e373a528e893339a83cb5c74002c3856~45dLp5blg2209722097eucas1p2M;
	Tue, 10 Jan 2023 08:39:15 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 49.35.43884.3342DB36; Tue, 10
	Jan 2023 08:39:15 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20230110083915eucas1p18a4b032bf44b21f8733d0280acbf8688~45dLNThQk0606106061eucas1p1C;
	Tue, 10 Jan 2023 08:39:15 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230110083915eusmtrp2096c2edc072337b430b2b22f8dc0805f~45dLMeU5A2380423804eusmtrp27;
	Tue, 10 Jan 2023 08:39:15 +0000 (GMT)
X-AuditID: cbfec7f5-25bff7000000ab6c-0b-63bd24331d39
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 31.EC.23420.2342DB36; Tue, 10
	Jan 2023 08:39:14 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20230110083914eusmtip26c71070d1d01301789f4728eca911ea0~45dK-lUgV3238632386eusmtip2A;
	Tue, 10 Jan 2023 08:39:14 +0000 (GMT)
Received: from [192.168.8.107] (106.210.248.241) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 10 Jan 2023 08:39:13 +0000
Message-ID: <01349d02-123d-3c49-bd92-8b8b3c645e1c@samsung.com>
Date: Tue, 10 Jan 2023 09:39:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
	Thunderbird/102.4.2
Subject: Re: [PATCH 5/7] dm-zoned: ensure only power of 2 zone sizes are
 allowed
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
CC: <axboe@kernel.dk>, <kernel@pankajraghav.com>,
	<linux-kernel@vger.kernel.org>, <hare@suse.de>, <bvanassche@acm.org>,
	<snitzer@kernel.org>, <dm-devel@redhat.com>,
	<damien.lemoal@opensource.wdc.com>, <linux-nvme@lists.infradead.org>,
	<linux-block@vger.kernel.org>, <gost.dev@samsung.com>, Luis Chamberlain
	<mcgrof@kernel.org>, Johannes Thumshirn <johannes.thumshirn@wdc.com>
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20230110065623.GD10289@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.241]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGKsWRmVeSWpSXmKPExsWy7djP87rGKnuTDda8k7NYfbefzWLah5/M
	Fr/Pnme22PtuNqvFnkWTmCxWrj7KZPG36x6TxZmXn1ks9t7Stri8aw6bxfxlT9ktbkx4ymhx
	4pa0A6/H5SveHpfPlnpsWtXJ5rF5Sb3H7psNbB47W++zepxd6ejxft9VoPDpao/Pm+Q82g90
	MwVwR3HZpKTmZJalFunbJXBl/N91nLmgk7li/7br7A2MG5m6GDk5JARMJOb/ns3excjFISSw
	glFi/+/1UM4XRomLH5azQjifGSVanoCUQbQ0H+thhkgsZ5S4uvgSO1zVs5lXoTK7GSVWfloL
	1sIrYCfx/tkeVhCbRUBVYtaJRawQcUGJkzOfsIDYogJREk0XfoLZwgJBEk9fv2IDsZkFxCVu
	PZkPdq2IgJLE01dnGUEWMAs0Mkt8+HEfyOHgYBPQkmjsBNvFKaAjce/2L1aIXk2J1u2/2SFs
	eYntb+cwQ7ygLLH4wjVGCLtWYu2xM2AfSAhc45Q4sPosG0TCReLOm5VQRcISr45vgfpfRuL/
	zvnQ4KuWeHrjNzNEcwujRP/O9WwgB0kIWEv0ncmBqHGUWLN4FQtEmE/ixltBiHv4JCZtm848
	gVF1FlJQzELy8iwkL8xC8sICRpZVjOKppcW56anFxnmp5XrFibnFpXnpesn5uZsYgUnv9L/j
	X3cwrnj1Ue8QIxMH4yFGCQ5mJRHelZx7koV4UxIrq1KL8uOLSnNSiw8xSnOwKInzztg6P1lI
	ID2xJDU7NbUgtQgmy8TBKdXAlL704LdApc9rp2S8U7VgFmRwfZnUv/O3q03/g7K4HraKoEu/
	OlgLPfOlAh8z1GlF/V2QUhZxyj/DWPdMyFFPCZtpYYa/9aX7r5R+sszcbLGt2PhhW/XsDaZ7
	jgfaVr5/MmMym5nJseCviYtlV+xgX+XaVVsdZZl4qvuZ++fElfliDBwPt60v0M7+YXdxzpKj
	Ut6CnB1vHy51C1RflcdQHvR7jkluyfdFJnITbzjdXRB2yze+neP3ytDp348G2XnWv2RY8H5a
	kpL8zYiMif/KoqMOz6uQaH9w1ND63n6BKZ4H+0Q3pWt+yL7LzJRn/HJTnNZZZ2bD0Kr/d5IX
	OEy2C2B0OiZtyfhBRNtzRbISS3FGoqEWc1FxIgAjtb2z6QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleLIzCtJLcpLzFFi42I5/e/4PV0jlb3JBhuf2VisvtvPZjHtw09m
	i99nzzNb7H03m9Viz6JJTBYrVx9lsvjbdY/J4szLzywWe29pW1zeNYfNYv6yp+wWNyY8ZbQ4
	cUvagdfj8hVvj8tnSz02repk89i8pN5j980GNo+drfdZPc6udPR4v+8qUPh0tcfnTXIe7Qe6
	mQK4o/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQy
	/u86zlzQyVyxf9t19gbGjUxdjJwcEgImEs3Hepi7GLk4hASWMkpMufUNKiEj8enKR3YIW1ji
	z7UuNhBbSOAjo8TShUIQDbsZJS7eucYIkuAVsJN4/2wPK4jNIqAqMevEIlaIuKDEyZlPWEBs
	UYEoiZvnH4ItEBYIknj6+hXYUGYBcYlbT+aDxUUElCSevjrLCLKAWaCRWeLDj/uMEJvvMkq8
	3azZxcjBwSagJdHYCXYcp4COxL3bv1gh5mhKtG7/zQ5hy0tsfzuHGeIBZYnFFyDulBColXh1
	fzfjBEbRWUjOm4XkjFlIRs1CMmoBI8sqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwDSx7djP
	zTsY5736qHeIkYmD8RCjBAezkgjvSs49yUK8KYmVValF+fFFpTmpxYcYTYFhNJFZSjQ5H5io
	8kriDc0MTA1NzCwNTC3NjJXEeT0LOhKFBNITS1KzU1MLUotg+pg4OKUamFY9nvJ2UUf15svC
	pv7K74QrP7xbbxrAInmnwyY76Kf9xhPVaaz8D9UtvJ1mMTzzNGCzCJi7raxlW/t9uePHd/3Y
	8rD32WG9RMMO/0PRvVvsj/HIrRcXceOZcfjh+RW9zoFTP29Z9DPlyprlizbM+Tev58P6mR3r
	EgrUToZ3TP3nybVyyUez7VsCT8Z6TVPks5G8EWIt7Gi8N/7uBZlq8b6N/dqHU2oj/4ea9mX5
	f19+aNYclnSlzL2PVyX4zH5zn7Hw5Mdd+yKezTTu33xz1VTj1ZoFqxeaJQic2ajMG3Vt4p1u
	I8FEdc6FZi7C/cnped5fDxw9Jd+19cKOJfzyc0+KajLcYfSY4GWg84b1fLASS3FGoqEWc1Fx
	IgD1OIivnAMAAA==
X-CMS-MailID: 20230110083915eucas1p18a4b032bf44b21f8733d0280acbf8688
X-Msg-Generator: CA
X-RootMTR: 20230106083322eucas1p2414f1f7f121fbbd7a0e5e1b1b622f5c0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230106083322eucas1p2414f1f7f121fbbd7a0e5e1b1b622f5c0
References: <20230106083317.93938-1-p.raghav@samsung.com>
	<CGME20230106083322eucas1p2414f1f7f121fbbd7a0e5e1b1b622f5c0@eucas1p2.samsung.com>
	<20230106083317.93938-6-p.raghav@samsung.com>
	<20230110065623.GD10289@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230110_003924_514127_FB5405CB 
X-CRM114-Status: GOOD (  11.68  )
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

On 2023-01-10 07:56, Christoph Hellwig wrote:
> Given that we don't even support the non pow of 2 zones in the block
> layer I don't see why this is needed.  But either way it doesn't really
> seem to fit into this series.

You are right. It is just an extra stop gap, but it is not needed as block
layer does not support pow of 2 anyway! I will remove this patch in the
next version.

