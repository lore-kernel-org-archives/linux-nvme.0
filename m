Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7096FC433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 03:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2jkbQLcDnVJxV0Z62XhPYhy/xvpgWpeOalEWvDr7n/0=; b=Z9tWy8g/W9DmmWZETwYd2ot+Br
	/DgLkuFb5q9jkJIPUUjN3Kw5AmqfmQ5jAVnBzMGHrMsiJyB9lBJO8Re94Yf40utVrf0nGL4xFpAU7
	o8SU94p+8ipk3/p3Hyn0DqmkYENu6Rt9itGJ7Hb9Xj/xp2j370YgytGKD9/FdQwb22V+LhAk9v0ZF
	SjhbngC78jzxkpbb07dBZrXUrQoCIS4GCqOqcpldVxXlvywqH80c8xeSGNbpflvkkJdo2/aphwcbO
	BeR8YkCby5DskAXKjnmVyy7S2F1V+vwirL4Qih4fB5n3XRtWZINcZ5sErx4uj8LasMy1JdORrFdX5
	35KWEyrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRnFj-007A69-6s; Wed, 09 Mar 2022 03:44:43 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRnFf-007A4n-E2
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 03:44:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1646797478; x=1678333478;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Cix+ZQn+HfYI1JZBoqYQ0IX5sNeZqeJolFM7SyZjKtA=;
 b=rzmSYnbWDtryY5ZJek0PZ/KwftZR/M8EJWzjGSrxtQBSIl9cboXxYimf
 n1eV6BjLOCJkBfd5Uq3D+pR4mpK4VHoP35/1Dx+6FKsrm8MoqrHhQF6K0
 P57UUTg/MGELMv4JtnkR6dtcmiSlliJpYaRi+CqHaeyvWSVHNi7nQOEB1
 gHiVjdfimx1b5C5WgaFXJbc9PvDI1OjBtQU6uhrN18cgpzGTyP4k3rwHx
 BvX1aWhjmjcYNGcOEv68bawehFHZVIkfUTEN18Xeh9xfvGOPEcCpKeFyp
 pL3l+FAvxxFNdZC6i1mE2yv6rzq1R7jj6wIKqND3uuSi9Advb4Q/1zWEu A==;
X-IronPort-AV: E=Sophos;i="5.90,166,1643644800"; d="scan'208";a="199667340"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2022 11:44:38 +0800
IronPort-SDR: +0OajQxHvBwW3VDkapd2F0+u0mhmrcLkFnVYRxm6KTaVT9P4OitcWon8FpxuarCbJsn0575j7f
 tK8OwXlEE1a+N++G57z4B+ee8c7nLFcEFOjRxuVkUexlCGlKyg4b6zR4HHWypu6pfnTYFddYPM
 PN7URqYzLKmuro88jJdDR9JFxDJgs0hDtDY3PglshlkDdyIJQDRpibPG06PxD595cbIdZHosuF
 b5SsZk9uccekTm9UUq03U1UMqH6IYNYwX8M3ZmCFt82/pn3D6+yfaUO6/DyrXMEXbYiiNwlFBF
 0Qbn4H6PRjuYH/IcB27+YFAd
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2022 19:15:54 -0800
IronPort-SDR: CxsOirfQbKXKylVC0kuSmzaznjzf4tqGPNLzQUxRoZxOOEzFM/MxR0Mj3LFHeRAigZCT7uY5TK
 Ri5tkkoLuWS2SRHUdXyYMYans/fkcugo3vI5kRqPCZ5VRzPdyDs4Ixvi21mmWk5ttoGEsDpCqU
 Z+7flvFPMM8L5ewhOldXTF8UgnqeP7MyQunH/+PqMEwGmwx56GkRxGYPkW7FOvsFcK2AkHdkPb
 JJmqTDeAwHQl8JezQAbp0UXrU+3jpphs5CBnVpVmM14kMk5h/LbFNebdlaV+cYM9jTozxEGLuA
 yZY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2022 19:44:39 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KCykG310Qz1SVp3
 for <linux-nvme@lists.infradead.org>; Tue,  8 Mar 2022 19:44:38 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1646797477; x=1649389478; bh=Cix+ZQn+HfYI1JZBoqYQ0IX5sNeZqeJolFM
 7SyZjKtA=; b=mObchIuXkiqWIlWO8v0uyQ/V7SPyVQX5BpMrQ8ymJs9emec9wT4
 ByGtV2BS08JRE7gVALFPDJr4LZnt9teCndJIJFrbaWvagx4wWIuKQ/KOcqp6rxfb
 TMrn30NNq5buWo6hu61q9F8U8HXiqN28DspqIB6C9VThtQNX2oc2nvT0t9Hxcy4b
 XmE5h0+Bl3XTUISLEZ/rrGPBxysknJQYur3kFbQINuu00c/L88vXl0SVSee/Vbpk
 NlwHMPXiW7d8GO3QnF3bhx8A71rTAadHDrl0628So0lpq5f6DWd1Ry/3V7pDlr0g
 dOY/oKPTZSvI7MpR2h4mfwiEruceMIBvX+g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id Ymp4KUDhKRbv for <linux-nvme@lists.infradead.org>;
 Tue,  8 Mar 2022 19:44:37 -0800 (PST)
Received: from [10.225.163.91] (unknown [10.225.163.91])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KCykC1htcz1Rvlx;
 Tue,  8 Mar 2022 19:44:35 -0800 (PST)
Message-ID: <06580b24-426c-77ef-a338-e5e97f5ebee1@opensource.wdc.com>
Date: Wed, 9 Mar 2022 12:44:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/6] nvme: zns: Allow ZNS drives that have non-power_of_2
 zone size
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, Luis Chamberlain
 <mcgrof@kernel.org>, Adam Manzanares <a.manzanares@samsung.com>,
 =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
 kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, =?UTF-8?Q?Matias_Bj=c3=b8rling?=
 <matias.bjorling@wdc.com>, jiangbo.365@bytedance.com
Cc: Pankaj Raghav <pankydev8@gmail.com>, Kanchan Joshi <joshiiitr@gmail.com>, 
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20220308165349.231320-1-p.raghav@samsung.com>
 <CGME20220308165421eucas1p20575444f59702cd5478cb35fce8b72cd@eucas1p2.samsung.com>
 <20220308165349.231320-2-p.raghav@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220308165349.231320-2-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_194439_553809_0EFDA297 
X-CRM114-Status: GOOD (  20.30  )
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

On 3/9/22 01:53, Pankaj Raghav wrote:
> Remove the condition which disallows non-power_of_2 zone size ZNS drive
> to be updated and use generic method to calculate number of zones
> instead of relying on log and shift based calculation on zone size.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  drivers/nvme/host/zns.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> index 9f81beb4df4e..ad02c61c0b52 100644
> --- a/drivers/nvme/host/zns.c
> +++ b/drivers/nvme/host/zns.c
> @@ -101,13 +101,6 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
>  	}
>  
>  	ns->zsze = nvme_lba_to_sect(ns, le64_to_cpu(id->lbafe[lbaf].zsze));
> -	if (!is_power_of_2(ns->zsze)) {
> -		dev_warn(ns->ctrl->device,
> -			"invalid zone size:%llu for namespace:%u\n",
> -			ns->zsze, ns->head->ns_id);
> -		status = -ENODEV;
> -		goto free_data;
> -	}

Doing this will allow a non power of 2 zone sized device to be seen by
the block layer. This will break functions such as blkdev_nr_zones() but
this patch is not changing this functions, and other using bit shift
calculations.

>  
>  	blk_queue_set_zoned(ns->disk, BLK_ZONED_HM);
>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
> @@ -129,7 +122,7 @@ static void *nvme_zns_alloc_report_buffer(struct nvme_ns *ns,
>  				   sizeof(struct nvme_zone_descriptor);
>  
>  	nr_zones = min_t(unsigned int, nr_zones,
> -			 get_capacity(ns->disk) >> ilog2(ns->zsze));
> +			 get_capacity(ns->disk) / ns->zsze);
>  
>  	bufsize = sizeof(struct nvme_zone_report) +
>  		nr_zones * sizeof(struct nvme_zone_descriptor);


-- 
Damien Le Moal
Western Digital Research

