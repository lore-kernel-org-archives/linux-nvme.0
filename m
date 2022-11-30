Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65F8C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Nov 2022 14:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Kscipv6BkawDOSIhKHFS9BVJt02cpjkFGfZxLKXFxx8=; b=abhyVWf6Z5yCvO
	SO91ydPaViSeLicyV/XkulzNCzbSbDs/1m5gxmRR/6/GgAI0asRBmYyTIf2xg7BbfFKiHFCcI5RZJ
	gy4Ta8TWmcuQN95gU+qU6buu/mcMuDKHoRZfebOyUE4Ex6WrNiKFNyiAkyr4EZt4jV6Qm10QJjOrG
	QRfDI5pJRhSiHlbJYkILjIJiISiNRPn+BixC/l3UoBvWgHa7HF4N6hZXLXc9O6AkxPhXBB0HrR+FN
	gwLAYhUBa6Um+ym/h79ph+bwbNNqDRLqXj90d8MxRnMzwS6nCJTijvbcINIGVw857+0Hac+h7j7Gi
	OskwGbLS0bzaANrG0SLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0O3x-00Gsan-Et; Wed, 30 Nov 2022 14:27:49 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0O3r-00GsU6-MJ
	for linux-nvme@lists.infradead.org; Wed, 30 Nov 2022 14:27:48 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20221130142733euoutp012730b5f4290f4b71c23f5c62fcd28150~sYwlBt5N22320323203euoutp01L
	for <linux-nvme@lists.infradead.org>; Wed, 30 Nov 2022 14:27:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20221130142733euoutp012730b5f4290f4b71c23f5c62fcd28150~sYwlBt5N22320323203euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1669818453;
	bh=Kscipv6BkawDOSIhKHFS9BVJt02cpjkFGfZxLKXFxx8=;
	h=Date:Subject:To:CC:From:In-Reply-To:References:From;
	b=mItj3jm3k5CzsWXU09dwqCLpiQZcWdIGideeaWQuTPZ8RXEIgmK7slUKCQqVH1QIV
	 J80f/LtD1iji9LpAtdzhOM9T0c6Vvicz5iSiZqef9RMOnpSoyxYTNnF4B6CKsSmo5A
	 vsaJ0vHByn2E270bZ6i2PwPKnY9+qwkx9dXrkTpY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20221130142732eucas1p1f8053d94336162fc79acb2c34006ba94~sYwkh9GxN0107901079eucas1p1E;
	Wed, 30 Nov 2022 14:27:32 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 26.9F.09549.45867836; Wed, 30
	Nov 2022 14:27:32 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20221130142732eucas1p1c6bf1882f8554331225f718c51056f08~sYwkK_-j-0107101071eucas1p1H;
	Wed, 30 Nov 2022 14:27:32 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20221130142732eusmtrp10aefa271fb8236675af0ab8a279831fe~sYwkKO3LR3074230742eusmtrp1O;
	Wed, 30 Nov 2022 14:27:32 +0000 (GMT)
X-AuditID: cbfec7f5-f5dff7000000254d-e2-63876854535d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id A9.4B.09026.45867836; Wed, 30
	Nov 2022 14:27:32 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20221130142732eusmtip195eb22052abcc644c2ee2e9564ea36ea~sYwj-OE5z1762917629eusmtip1C;
	Wed, 30 Nov 2022 14:27:32 +0000 (GMT)
Received: from [192.168.8.141] (106.210.248.101) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 30 Nov 2022 14:27:30 +0000
Message-ID: <fc5d0a74-e4e9-38c7-3a93-ff1eb71e0054@samsung.com>
Date: Wed, 30 Nov 2022 15:27:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
	Thunderbird/102.4.2
Subject: Re: [PATCH 2/9] nvme: use nvme_wait_ready in nvme_shutdown_ctrl
To: Christoph Hellwig <hch@lst.de>, Pankaj Raghav <pankydev8@gmail.com>
CC: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, James
	Smart <james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	<asahi@lists.linux.dev>, <linux-nvme@lists.infradead.org>
Content-Language: en-US
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20221130135749.GA4786@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.101]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsWy7djP87ohGe3JBs92qVv8vMpnsXL1USaL
	3Qs/MllMOnSN0eLp1VlMFvOXPWW3OH1tAbvFmptPWSzWvX7PYvHn9n8mBy6PWffPsnnsnHWX
	3eP8vY0sHptWdbJ5bF5S7/Fi80xGj903G9g8Fi/byebR2/yOzaN/Xj9TAFcUl01Kak5mWWqR
	vl0CV8aFGUfYC74JVfyYdYGtgXEGfxcjJ4eEgInEtxmbGLsYuTiEBFYwSszff5EdwvnCKLGy
	eRILhPOZUeL9/8VAZRxgLbOemEHElzNKfDx6jxmu6OjaWVDObkaJGQtvg3XwCthJPH6VBbKP
	RUBVYuP1/cwgNq+AoMTJmU9YQGxRgSiJpgs/wWxhAQ+JdV+uMILYIgLuEn2nf7GBzGQWmMYk
	0bP1DBtIgllAXOLWk/lMIPPZBLQkGjvZQUxOAW2JFxdVICo0JVq3/2aHsOUltr+dwwzxsrLE
	rFPnoOxaiVNbbjGBjJcQ2M8psfXORxaIhIvEx4t3oIqEJV4d38IOYctInJ7cA1VTLfH0xm9m
	iOYWRon+nevZICFkLdF3JgeixlHiw/wdrBBhPokbbwUh7uGTmLRtOvMERtVZSCExC8ljs5C8
	MAvJCwsYWVYxiqeWFuempxYb56WW6xUn5haX5qXrJefnbmIEprTT/45/3cG44tVHvUOMTByM
	hxglOJiVRHg7PrclC/GmJFZWpRblxxeV5qQWH2KU5mBREudlm6GVLCSQnliSmp2aWpBaBJNl
	4uCUamASW3Vgwn3+Vf7WWUFcPkGLLx5rlZnD/+3yr+oTpgecLnVUKKx8+/WE67RL+wpPiegs
	djdTupf5IDE4+Nq0WvutC5ZXPVCLfOh7O+7mvr/btSPCfOfkrt9znSfLS4cjYX73v77azgeM
	Jl8np1/6n2ltm9V9JeF57FmbfHv5Nflf8j/cmf37wOQ3ZXPK/pxW73JYwND+5Okh/X07xO3W
	3d11aHUZ8+2XUxwX/tnzocjhUUJSwmMOzQ2KOQa810xKZ31dOGG+RpWZ3/X1x8MKbbV2XC7c
	vbAjjD9J4saUEx8SXe7oipxcq35k96UmhbwG9qaltccKi2Se/G48suencaHIFAvJSS0ejWXf
	xWZYV4enKrEUZyQaajEXFScCAL+rkXfYAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsVy+t/xu7ohGe3JBudnCFr8vMpnsXL1USaL
	3Qs/MllMOnSN0eLp1VlMFvOXPWW3OH1tAbvFmptPWSzWvX7PYvHn9n8mBy6PWffPsnnsnHWX
	3eP8vY0sHptWdbJ5bF5S7/Fi80xGj903G9g8Fi/byebR2/yOzaN/Xj9TAFeUnk1RfmlJqkJG
	fnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsaFGUfYC74JVfyYdYGt
	gXEGfxcjB4eEgInErCdmXYxcHEICSxklPr+fwNrFyAkUl5H4dOUjO4QtLPHnWhcbRNFHRomt
	zR+hnN2MEndbVzKCTOIVsJN4/CoLpIFFQFVi4/X9zCA2r4CgxMmZT1hAbFGBKImb5x8ygdjC
	Ah4S675cYQSxRQTcJfpO/wKbySwwjUni04G9bCAJIYFPjBJvO2JBbGYBcYlbT+YzgexiE9CS
	aOxkBzE5BbQlXlxUgajQlGjd/psdwpaX2P52DjPE/coSs06dg7JrJT7/fcY4gVF0FpLrZiFZ
	MAvJqFlIRi1gZFnFKJJaWpybnltspFecmFtcmpeul5yfu4kRmAa2Hfu5ZQfjylcf9Q4xMnEw
	HmKU4GBWEuHt+NyWLMSbklhZlVqUH19UmpNafIjRFBhEE5mlRJPzgYkoryTe0MzA1NDEzNLA
	1NLMWEmc17OgI1FIID2xJDU7NbUgtQimj4mDU6qByfPUuZmviyMuncm38o861zXXNiPZd3mw
	xu0QwQkRZtrvkn9XPeAPNlSPsijv2qovdbFCoey7RuK3iZs/8gjcufr6xBnr++GX71uGME0u
	dLlbMXdqi/qHvDl2Tn+fyzbtex/auzO8zOmNXMltfYkD78QebPrcvq16/rNVJlXR889x6s2Z
	cTX8AYvEZKXcRJ24/pJ768we1DLlXpkz/0Gx7c8tb/4YSgcozrHTjKm7OPmZ2BGuB2tuaekv
	koxfMCc1WuTu7Y+erptXL/u6dErAygDx83xs5T0To87JB3kLvbrx6rqXpP/Hpu8eNXILU9uf
	b193VOSl7Lca3y3Gfz0l4gNKAtw6LTQL4q8eOiomosRSnJFoqMVcVJwIAPsPQliMAwAA
X-CMS-MailID: 20221130142732eucas1p1c6bf1882f8554331225f718c51056f08
X-Msg-Generator: CA
X-RootMTR: 20221130135758eucas1p2aaf96c2c7bee29c0f44e5714b0b159bc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221130135758eucas1p2aaf96c2c7bee29c0f44e5714b0b159bc
References: <20221129132208.4337-1-hch@lst.de>
	<20221129132208.4337-3-hch@lst.de> <20221129155718.poqztp4zudt47zmq@quentin>
	<CGME20221130135758eucas1p2aaf96c2c7bee29c0f44e5714b0b159bc@eucas1p2.samsung.com>
	<20221130135749.GA4786@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221130_062745_433415_084805BC 
X-CRM114-Status: GOOD (  29.36  )
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

On 2022-11-30 14:57, Christoph Hellwig wrote:
> On Tue, Nov 29, 2022 at 04:57:18PM +0100, Pankaj Raghav wrote:
>> The timeout_jiffies calculation in nvme_shutdown_ctrl is:
>> unsigned long timeout = jiffies + (ctrl->shutdown_timeout * HZ);
>>
>> Aren't we changing the timeout with this change to something
>> different compared to what it was before for shutdown?
> 
> Indeed.  the timeout fields in the spec are in a different granularity
> than the shutdown_timeout field.  This version should fix that:
> 
> ---
> From 2f862232c4428d57dcfdc3b332866a9b2743711d Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Wed, 16 Nov 2022 08:54:26 +0100
> Subject: nvme: use nvme_wait_ready in nvme_shutdown_ctrl
> 
> Refactor the code to wait for CSTS state changes so that it can be reused
> by nvme_shutdown_ctrl.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

One minor nit: I also notice that nvme_wait_ready busy loop sleeps for
1~2ms, while the existing shutdown code busy loop sleeps for 100ms. Though,
I don't think it is an issue.

Apart from that, the new version looks good to me. Feel free to add to it:

Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  drivers/nvme/host/core.c | 38 ++++++++++++--------------------------
>  1 file changed, 12 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 7961e146bbb163..03b2e34dcf7249 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2252,16 +2252,17 @@ static const struct block_device_operations nvme_bdev_ops = {
>  	.pr_ops		= &nvme_pr_ops,
>  };
>  
> -static int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 timeout, bool enabled)
> +static int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 mask, u32 val,
> +		u32 timeout, const char *op)
>  {
> -	unsigned long timeout_jiffies = ((timeout + 1) * HZ / 2) + jiffies;
> -	u32 csts, bit = enabled ? NVME_CSTS_RDY : 0;
> +	unsigned long timeout_jiffies = jiffies + timeout * HZ;
> +	u32 csts;
>  	int ret;
>  
>  	while ((ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts)) == 0) {
>  		if (csts == ~0)
>  			return -ENODEV;
> -		if ((csts & NVME_CSTS_RDY) == bit)
> +		if ((csts & mask) == val)
>  			break;
>  
>  		usleep_range(1000, 2000);
<snip>

> -		msleep(100);
> -		if (fatal_signal_pending(current))
> -			return -EINTR;

