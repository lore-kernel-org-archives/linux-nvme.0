Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B468C3DA78
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Jan 2023 17:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ppgbS9otra+l3yNgfUZn3vLxr94OaomCYTi/AzlB998=; b=FQ2XZRU/PzLYqq
	k2rP8j4mbw5P4altVChwgmo/sx+N0IUD2SSHeBpKrJ5OdPRI/zW8Gy5jEhSttD3ffYerVY3VOd9Kc
	5tDl9QPSrBnOOC8N/lpKTXEbHDcreBC9X5Tc+XmgOkWugOivHTE8Xo6gCrW12hAqiDBKNDI8rFN68
	yJeL8gfweEDaIgX8qmMQQ3mq/Nhrv6iBxxuK/72j4ki98MuAX4QKaBBQ2D8OfJin/d/3I8A2uPdlR
	iGoEzlEJg6ctZ2xmW1Hiy0MOCnLbspZ01SINdw6DanvdC+d6YmW1SvVIqA4/G4UgkmmzyLs7KCyL5
	42li26vO9qGKibsy1vtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHpl9-00FGQb-G1; Tue, 17 Jan 2023 17:28:31 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHpl3-00FGML-TR
	for linux-nvme@lists.infradead.org; Tue, 17 Jan 2023 17:28:29 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230117172815euoutp0149139bdcdfa82b86989fe52bacf738fc~7KMDebd9S2480324803euoutp01u
	for <linux-nvme@lists.infradead.org>; Tue, 17 Jan 2023 17:28:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230117172815euoutp0149139bdcdfa82b86989fe52bacf738fc~7KMDebd9S2480324803euoutp01u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1673976495;
	bh=ppgbS9otra+l3yNgfUZn3vLxr94OaomCYTi/AzlB998=;
	h=Date:Subject:To:CC:From:In-Reply-To:References:From;
	b=LeQcHs3Q65bVO+Phv/o2O8SvWrz3UPM0KDzAPTud+xJHaLH1QuGBiLdrWdN7yVH6n
	 TGHHXdzPnYBLlfqb9Qw95WC9o/MB7So7aH/UBsbrO8clqckNg52C3EsHrwOT4o3aXd
	 f5KKmIbBpnSBP4gjGXSa8jNB0Mt76ktGAPDIRxFY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20230117172815eucas1p2f208a8baf5de0337668c3c8217c690cf~7KMDOnh6x0536905369eucas1p2V;
	Tue, 17 Jan 2023 17:28:15 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 38.31.61936.EAAD6C36; Tue, 17
	Jan 2023 17:28:14 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20230117172814eucas1p2b1f69afa48bb56b8e8a3edb0a3bc75e0~7KMC7glhB0536905369eucas1p2U;
	Tue, 17 Jan 2023 17:28:14 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230117172814eusmtrp2e04e3912e6676c0532a5bfadc4b18786~7KMC6_DSm0072400724eusmtrp2D;
	Tue, 17 Jan 2023 17:28:14 +0000 (GMT)
X-AuditID: cbfec7f4-a43ff7000002f1f0-60-63c6daaeeafc
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 07.EE.23420.EAAD6C36; Tue, 17
	Jan 2023 17:28:14 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20230117172814eusmtip22e8c59fdbfd7cc75bceec47210399095~7KMCv38ns0222802228eusmtip2J;
	Tue, 17 Jan 2023 17:28:14 +0000 (GMT)
Received: from [192.168.8.107] (106.210.248.178) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 17 Jan 2023 17:28:13 +0000
Message-ID: <eac2263f-43b0-f6f5-2a75-33e571075dc8@samsung.com>
Date: Tue, 17 Jan 2023 18:28:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
	Thunderbird/102.4.2
Subject: Re: [PATCH v2 0/3] block zoned cleanups
Content-Language: en-US
To: <axboe@kernel.dk>
CC: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <bvanassche@acm.org>,
	<linux-block@vger.kernel.org>, <damien.lemoal@opensource.wdc.com>,
	<gost.dev@samsung.com>, <snitzer@kernel.org>
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20230110143635.77300-1-p.raghav@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.178]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsWy7djPc7rrbh1LNrjcYG2x+m4/m8W0Dz+Z
	LX6fPc9ssXL1USaLvbe0LeYve8puceKWtAO7x+Ur3h6Xz5Z6bFrVyeaxeUm9x+6bDWweO1vv
	s3p83iQXwB7FZZOSmpNZllqkb5fAlXH+3ln2ghdcFYc/KzYwHuPoYuTkkBAwkdix4SULiC0k
	sIJRYuNsAwj7C6PEtgWyXYxcQPZnRokj5z+ywzRcuriADaJoOaPE8atKcEXtVzvZIZzdjBLN
	TdtZuxg5OHgF7CTWvZIBaWARUJVYOGk72DZeAUGJkzOfgNmiAlESTRd+gtnCAgYS93fcZQax
	mQXEJW49mc8EMkZEQFRizqJKkPHMAnsZJTY9esQIEmcT0JJo7AS7jVPASuLCxN+MEK2aEq3b
	f7ND2PIS29/OYYa4X1nix4bTbBB2rcTaY2fATpYQ6OeU6Gp+DJVwkdiwcCZUg7DEq+NboJ6X
	kfi/E+QeELta4umN38wQzS2MEv0717OBHCQhYC3RdyYHwnSU6L+rCGHySdx4KwhxDp/EpG3T
	mScwqs5CCohZSB6eheSDWUg+WMDIsopRPLW0ODc9tdgoL7Vcrzgxt7g0L10vOT93EyMwDZ3+
	d/zLDsblrz7qHWJk4mA8xCjBwawkwuu363CyEG9KYmVValF+fFFpTmrxIUZpDhYlcd4ZW+cn
	CwmkJ5akZqemFqQWwWSZODilGpgm9K/1if8yq4ahfLoXe3t+xY0c+1cpe2ViXK62dwkVWS4V
	ePBEY3LSMY5lzz64lt0rctnAvv9K/5IGl/hau032DZsO7dH6Nf2SXcTbtZPSr3pMzdm929Fw
	5kHNywcygoJZ3s19eY/3yDKZJaVbNe1tj0QfVrlwufSEiMG/zw+3uzk39e6plguQ/PdG4bhC
	z0wHldIT7os3Sd8XDC22OPI7wOrqw1NcDyadqPj6YPmcF8mG9s+rn7i2VrgH+f2TZuJ4JCsk
	+UbSZIFa9AHrw2tbN5boz8hYvNvF8tyvlqZ8lbI3T7XLVsZ9LhI6dkM2YvVkUc2Epu83oyPf
	RW2pLLJY2OA35ewztfU6P/cu2TJBiaU4I9FQi7moOBEAoTzzHrIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsVy+t/xe7rrbh1LNjj6T91i9d1+NotpH34y
	W/w+e57ZYuXqo0wWe29pW8xf9pTd4sQtaQd2j8tXvD0uny312LSqk81j85J6j903G9g8drbe
	Z/X4vEkugD1Kz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI
	3y5BL+P8vbPsBS+4Kg5/VmxgPMbRxcjJISFgInHp4gK2LkYuDiGBpYwS228vZIVIyEh8uvKR
	HcIWlvhzrQuq6COjRM/jQ4wQzm5Giamn7jB3MXJw8ArYSax7JQPSwCKgKrFw0nYWEJtXQFDi
	5MwnYLaoQJTEzfMPmUBsYQEDifs77jKD2MwC4hK3nsxnAhkjIiAqMWdRJch4ZoG9jBKbHj2C
	2tXLKPHzfx8jSBGbgJZEYyfYcZwCVhIXJv5mhJijKdG6/Tc7hC0vsf3tHGaIB5Qlfmw4zQZh
	10q8ur+bcQKj6Cwk581CcsYsJKNmIRm1gJFlFaNIamlxbnpusaFecWJucWleul5yfu4mRmAU
	bzv2c/MOxnmvPuodYmTiYDzEKMHBrCTC67frcLIQb0piZVVqUX58UWlOavEhRlNgGE1klhJN
	zgemkbySeEMzA1NDEzNLA1NLM2MlcV7Pgo5EIYH0xJLU7NTUgtQimD4mDk6pBqY4109N7BX3
	RB96Fc+e98Vis+br32mRy5+u9Oq6Xz/t6Vr+K9ufWt9oborKvlnWv27yPqfnkryWxzR4bmlZ
	LlnVeu3S/aAv1ydrOrSLqVwX8nn6Q2Dh0SkX9Z/MDHlYfj5bzqtw6uPSiqs2X04afcvfz55Z
	6uIV/u78o9Pnm1bbZ+zwnnXj6qyg/9L7tbTkYlctaerM+HeLMeBG0XR11nkfBdUmt3+aq/HF
	QOmtxrf/XvvmvnY2XrmQW+3l8hwh81snHsjk99St/3Dih5b//Ijo+VWX7dpmrzlfIfLneHDP
	zfJulx/zde6VmfpWHrnxJvaQyuqr5j/DBH9IBXtJP3+48fnVNdYhmb/X8lgG/6/VVWIpzkg0
	1GIuKk4EAD5sMiprAwAA
X-CMS-MailID: 20230117172814eucas1p2b1f69afa48bb56b8e8a3edb0a3bc75e0
X-Msg-Generator: CA
X-RootMTR: 20230110143637eucas1p1d82528b632ccda1de4fb2795ff691fe2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230110143637eucas1p1d82528b632ccda1de4fb2795ff691fe2
References: <CGME20230110143637eucas1p1d82528b632ccda1de4fb2795ff691fe2@eucas1p1.samsung.com>
	<20230110143635.77300-1-p.raghav@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230117_092826_244011_F7B6F3E6 
X-CRM114-Status: GOOD (  17.70  )
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

Hi Jens,
  There is a Reviewed-by tag by different reviewers in all the patches.
Could we queue this up for the next release?

Regards,
Pankaj

On 2023-01-10 15:36, Pankaj Raghav wrote:
> Hi Jens,
>   It is still unclear whether the support for non-po2 zone size devices
>   will be added anytime soon [1]. I have extracted out the cleanup
>   patches that doesn't do any functional change but improves the
>   readability by adding helpers. This also helps a bit to
>   maintain off-tree support as there is an interest to have this feature
>   in some companies.
> 
> [1] https://lore.kernel.org/lkml/20220923173618.6899-1-p.raghav@samsung.com/
> 
> Changes since v1:
> - Remove blk_is_zoned() check in bdev_{is_zone_start, offset_from_zone_start} (Damien)
> - Minor spelling and variable name changes (Bart and Johannes)
> - Remove zonefs patch for now (Damien)
> - Send dm patches separately(Christoph)
> 
> Pankaj Raghav (3):
>   block: remove superfluous check for request queue in bdev_is_zoned()
>   block: add a new helper bdev_{is_zone_start, offset_from_zone_start}
>   block: introduce bdev_zone_no helper
> 
>  block/blk-core.c          |  2 +-
>  block/blk-zoned.c         |  4 ++--
>  drivers/nvme/target/zns.c |  3 +--
>  include/linux/blkdev.h    | 22 +++++++++++++++++-----
>  4 files changed, 21 insertions(+), 10 deletions(-)
> 

