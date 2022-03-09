Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0687DC433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 13:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+PEhZ7N1GuRI5ecYJ2bWJsRvtLcd5XSxPgUZlH2GQrw=; b=PzcPMj9M8khSEg
	26dgRI7jFJcWJXB9MydHRg7Docpt/UeN+LTEmBQki57ojZNHYgwaMu4BtiyvUwhneS1uVdbwOCZ/s
	oy8/otfzvxsi5ZP0bhE5LOpxIjhujm0HXRrAofLLPZTAzvjd3Hqf0bLtc2t867594XdUBwAr2Lw2H
	9tNgIJkEybaTUfeDP+3M0Akr5FNRRp5Q5KjtIbOppl105OHNHpMqzGgn5Iv1k4lzV4tGqJJAS88Qo
	BKSUEmhRIS3vLpFBCLcelo9AP5SbmLQAD9oe/Uq233Ow+bxaRLw8hQo7aWlcHBRCAco/RtH8edmyv
	0VGTZSW0HqHC/FNVgn3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRwE7-008jR2-9E; Wed, 09 Mar 2022 13:19:39 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRwE3-008jQB-RT
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 13:19:37 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20220309131932euoutp018c21c40483ff8d4e8f76056fa3770de0~auPQ7G_eZ1429014290euoutp01Y
 for <linux-nvme@lists.infradead.org>; Wed,  9 Mar 2022 13:19:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20220309131932euoutp018c21c40483ff8d4e8f76056fa3770de0~auPQ7G_eZ1429014290euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1646831972;
 bh=+PEhZ7N1GuRI5ecYJ2bWJsRvtLcd5XSxPgUZlH2GQrw=;
 h=Date:Subject:To:CC:From:In-Reply-To:References:From;
 b=RqPJbv9aG1lOGIoaqKwSXVo3eofKHMvhJrr/DW88l+xDEN/h7sLXq5gd9jBpsiXP3
 to4htuBScUszW36UKpxUEnXpbYp8KtkWn9F7e5YOz46P6IgZ7GIwytzVDLoiAtpmzy
 d4Vy/bv5WLIWBr+OaIHBbwbjimz8h1UTS/e6szUo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20220309131932eucas1p1a1784dc90075801cf81620e472bd7b38~auPQfafSq2542525425eucas1p1H;
 Wed,  9 Mar 2022 13:19:32 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id B8.E0.10009.469A8226; Wed,  9
 Mar 2022 13:19:32 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20220309131931eucas1p20907f58668f38c6c357dcb5a2936d004~auPP9QIMz2493824938eucas1p2b;
 Wed,  9 Mar 2022 13:19:31 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20220309131931eusmtrp1accbde05ca98f6dbff792cc5ca8b9ec8~auPP8aAaS0548505485eusmtrp1w;
 Wed,  9 Mar 2022 13:19:31 +0000 (GMT)
X-AuditID: cbfec7f2-e7fff70000002719-cc-6228a9642bac
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id EF.B4.09522.369A8226; Wed,  9
 Mar 2022 13:19:31 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20220309131931eusmtip2306cff1703c2ff21a1a70f8a933a4f8e~auPP0T1GJ0951109511eusmtip2O;
 Wed,  9 Mar 2022 13:19:31 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.212) by CAMSVWEXC01.scsc.local
 (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 9 Mar 2022 13:19:27 +0000
Message-ID: <27926424-0a3f-fb8e-c47b-19270238f59c@samsung.com>
Date: Wed, 9 Mar 2022 14:19:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/6] nvme: zns: Allow ZNS drives that have
 non-power_of_2 zone size
Content-Language: en-US
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>, Luis Chamberlain
 <mcgrof@kernel.org>, Adam Manzanares <a.manzanares@samsung.com>,
 =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>, kanchan Joshi
 <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>, Keith Busch
 <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
 <sagi@grimberg.me>, =?UTF-8?Q?Matias_Bj=c3=b8rling?=
 <matias.bjorling@wdc.com>, <jiangbo.365@bytedance.com>
CC: Pankaj Raghav <pankydev8@gmail.com>, Kanchan Joshi
 <joshiiitr@gmail.com>, <linux-block@vger.kernel.org>,
 <linux-nvme@lists.infradead.org>
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <645d8224-df64-a057-cb9c-82c6cb8b2d5b@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.212]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDKsWRmVeSWpSXmKPExsWy7djP87opKzWSDCacF7FYfbefzeL32fPM
 FitXH2Wy6DnwgcXi/NvDTBaTDl1jtNh7S9ti/rKn7BYT2r4yW9yY8JTRYs3NpywW616/Z3Hg
 8fh3Yg2bx85Zd9k9zt/byOJx+Wypx6ZVnWwem5fUe+y+2QCUa73P6vF5k5xH+4FupgCuKC6b
 lNSczLLUIn27BK6Mp2vOMxecZK6Yt7mZuYHxEVMXIyeHhICJxJ/N05m7GLk4hARWMEpcPn2Z
 HcL5wigx/WkfVOYzo8SPibtYYVqm7f0I1i4ksJxR4tcpW7iia09msEA4uxgl1p1uZwOp4hWw
 k5j/rgHIZudgEVCR+GICERWUODnzCQuILSoQIfHyyF+wmcICkRLT1+5hBrGZBcQlbj2ZzwQy
 UkTgHLPExY7JrBCJiYwSnbvMuxg5ONgEtCQaO9lBwpwCbhKfmh6zQJRoSrRu/80OYctLbH87
 hxmkXEJAWeL1ehuIV2ol1h47A/awhMA5TomV/48wQyRcJI69OQ5lC0u8Or6FHcKWkTg9uYcF
 oqGfUWJqyx8mCGcGo0TP4c1MEBusJfrO5ECYjhI3D5pBmHwSN94KQpzDJzFp23TmCYyqs5BC
 YhaSj2ch+WAWkg8WMLKsYhRPLS3OTU8tNsxLLdcrTswtLs1L10vOz93ECExwp/8d/7SDce6r
 j3qHGJk4GA8xSnAwK4nwNoVqJAnxpiRWVqUW5ccXleakFh9ilOZgURLnTc7ckCgkkJ5Ykpqd
 mlqQWgSTZeLglGpgsn+6N4Cv4aziz+sBbDr7Zs5vOWOygOUXP7vc+te3y8Q+H7yitshry2q9
 H8/yj5oJLdg/e43oZ3cHLsELIf2yB/0iDS9csamskzwgs9vy/rQV3Ew/dWbqqhc++HRcUmJz
 +WlTy4yg7uBZQcv3X2K8xaI08YZWI0MF76Pb3MUBD3Pm9s+TU3d3P1eYdMI8rJVpQVeXF38F
 u+X1h1tLU/htHjjdfPrhwuVsV7a75XdqFVKXl+hte5xnNO3XD5OGV+t1O57qO3pv7oy4fy5i
 65y/nKJLlv8MFfmjrfaMe3+T8+v51dtXLb39sCGzsfZRxyuHRGftW0pvWx9O2hDOWStYH35j
 Vs1Khfv3klQe+t51VGIpzkg01GIuKk4EAGXta9rfAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42I5/e/4Pd3klRpJBufu6FmsvtvPZvH77Hlm
 i5WrjzJZ9Bz4wGJx/u1hJotJh64xWuy9pW0xf9lTdosJbV+ZLW5MeMposebmUxaLda/fszjw
 ePw7sYbNY+esu+we5+9tZPG4fLbUY9OqTjaPzUvqPXbfbADKtd5n9fi8Sc6j/UA3UwBXlJ5N
 UX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7G0zXnmQtO
 MlfM29zM3MD4iKmLkZNDQsBEYtrej0A2F4eQwFJGibMXnrFCJGQkPl35yA5hC0v8udbFBlH0
 kVHi1KQvjCAJIYFdjBKb37iC2LwCdhLz3zUAFbFzsAioSHwxgYgKSpyc+YQFxBYViJBoWzaF
 uYuRg0NYIFJi1k0vkDCzgLjErSfzwU4QETjHLHGxYzIriMMs0M8osWTKD1aIvb8ZJa5+3MMC
 0s0moCXR2Al2G6eAm8SnpscsEJM0JVq3/2aHsOUltr+dA7ZMQkBZ4vV6G4hXaiVe3d/NOIFR
 dBaS82YhuWMWkkmzkExawMiyilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzAtbDv2c/MOxnmv
 PuodYmTiYDzEKMHBrCTC2xSqkSTEm5JYWZValB9fVJqTWnyI0RQYQhOZpUST84GJKa8k3tDM
 wNTQxMzSwNTSzFhJnNezoCNRSCA9sSQ1OzW1ILUIpo+Jg1OqgWnC1g4t/eNXuyKvPfZ0TmL+
 fFqX4cbEIlvmlM6X2yoaYyc0H2tlOMH5PmtWhcalpslHvlvIz0yoWjzfoDaif/fBwyl33CNO
 zg6carRk1omP+6xXTsvQadV3Dbz7Z9qWnPmXfio9EP9k+5XvfdrdrmUTvrKqrVV2bnr4ZNPh
 C/nbQqqjp/J+N2E7a/G8+t/jbZuCPifunKTYuOyxnfB5DaczamdZHy5U8ZJ+bejNPkPA7Iv9
 trP/pypH/fr8qvPrWeGX/bmmZ7ulBI9FxLXFrAl8Fnai28y4cPPCDiEhrif2wbJX79xKvndU
 lzHxKtORF0qdkdkRcuyX9D6seaJYxj8hqspm9cnWhb8s+dYVXk9SYinOSDTUYi4qTgQAmwVX
 FZQDAAA=
X-CMS-MailID: 20220309131931eucas1p20907f58668f38c6c357dcb5a2936d004
X-Msg-Generator: CA
X-RootMTR: 20220308165421eucas1p20575444f59702cd5478cb35fce8b72cd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220308165421eucas1p20575444f59702cd5478cb35fce8b72cd
References: <20220308165349.231320-1-p.raghav@samsung.com>
 <CGME20220308165421eucas1p20575444f59702cd5478cb35fce8b72cd@eucas1p2.samsung.com>
 <20220308165349.231320-2-p.raghav@samsung.com>
 <645d8224-df64-a057-cb9c-82c6cb8b2d5b@opensource.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220309_051936_263329_7EDD12B1 
X-CRM114-Status: GOOD (  12.08  )
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



On 2022-03-09 04:40, Damien Le Moal wrote:
> On 3/9/22 01:53, Pankaj Raghav wrote:
>>  	nr_zones = min_t(unsigned int, nr_zones,
>> -			 get_capacity(ns->disk) >> ilog2(ns->zsze));
>> +			 get_capacity(ns->disk) / ns->zsze);
> 
> This will not compile on 32-bits arch. This needs to use div64_u64().
> 
Oops. I will fix that up in the next revision and also in other places
that does not use a div64_u64. Thanks. 
> 
> 

-- 
Regards,
Pankaj

