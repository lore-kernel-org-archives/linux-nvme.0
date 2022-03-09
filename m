Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDAFEC433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 03:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dJ6OoVnjd34/gbahnpsOEbdjnOs8G3jKSEza3D8AMO4=; b=Z+dtxBe3eBQxVWlZ1vluoxMd3k
	uSs7ZPx0LDVTKN+4FgbmYg9B4rfae7PWAcFvKvBKczzM3kFdf4FY5Rkx9SpOMM9lkdNlRrQaXyoD5
	BG2xN0IKaptpDci3ySggw3MmkhfFsWT5JI27pndD8q6XjS+UuRfD2d+YniJh0cNPeXeNK1Hg4UuZ/
	ZwHHFBL+tYA3I8Ag5A408QbVKStINgJ0R6CGtP77Qcphgj9tSRyQsPjFI8/zNJd3Lg6EoiP2MJl2o
	wZVZMnaOwnk7ILVeZyf1vs0JCnDioDqrA7Im43D4RvahJ1jHC/VZJZxUoNNmTSPipp8T+VZwwWRJp
	ILI09sfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRnBT-0078h9-J7; Wed, 09 Mar 2022 03:40:19 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRnBQ-0078eh-AS
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 03:40:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1646797215; x=1678333215;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=xmF1sDRZPr3tQorEJq8JDYSDk9Aby1WDJLV6SHWhrzU=;
 b=PPY2xmritdbzo2f8Ym4TWSJi1hoULntQSpidZjTUXzTP77SNH3+JBj8V
 vQIj1YACNGzGC9/V52j2jwFEaopWPqAVZ3Rg3UvCEkERA0m9XUguktYw/
 LzURq8ZNZBGGbIF+6efDDl+INEyCrqKn9nIyunTmmh2fTIUU1vVgMxCII
 Ia3y5daRL6ER/Cyz7XvE/1sBf96ceql3YL0JI4QEgy/Z/Vf/4bLrRCj4G
 CZs5BYzzHqe2o94/Jxt8Z3+ir6BQyXlBd48D14MQGSXmbYEYcbzLfjdCe
 anYGupRNKSDSunuXzSvIWkX4Q1SW/8hCvuUB1Ux0gbyuonNI3ap2Ldvch A==;
X-IronPort-AV: E=Sophos;i="5.90,166,1643644800"; d="scan'208";a="199667072"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2022 11:40:13 +0800
IronPort-SDR: iiEsTnv+L5gOxNzz3CueB6tunNA06j6DfogLPQPwgTORZ1OBjJ3Wi0TWkb1mj10AnhxCCX6Kr6
 CPXmGl5DWd8cLIndaHNY6S10OWGfXwlo7Jxip6DLnsftC83AICiaqytN3kCRXJdbOOOsMvy8Tz
 rplEIm0d9HlrgjmXxmBPHYnQVgBkcaREjUObY2rKkj6rWG9HRsIMkiDvsEpOtDSoPbIuQb934X
 +NUNpvQcE39WADLnGKEOAdn4ijaOJ6NMcN81+oPIPjssIiIXBiQSBS1wp61Z70Ha8L5YSEjwaV
 j1demWkcvdPvybkSw4aQcmrb
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2022 19:12:30 -0800
IronPort-SDR: q8Cg5Sa+hCiZn4JtoXa1ifMnyeJaNc3xrQDvLSfEh5zJkMi+JRMktmiZh8Kqoftg7xpQ8qTJMC
 ym5UbMDEUsGFk7l3aLoOm42yOX5+2AIBGQZCNHAAdggGBGWQtVczelNdRUmcmenH+Jl+3ppDIn
 z96zq8Vf5WbJw8TTedmAMTIeR62bcfpgRNA8U0Uc3UYlyipppO1WTk0WEZhrLSgbbKBh9ox27W
 dtGqAXgKumjIvnRzpm60SUdd/Jf/sMjtixGEKHDDHCXa8xsiAkPDTV/6/PCx+vglAqXQRN9f2M
 aSI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2022 19:40:14 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KCyd93YXvz1SVp5
 for <linux-nvme@lists.infradead.org>; Tue,  8 Mar 2022 19:40:13 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1646797212; x=1649389213; bh=xmF1sDRZPr3tQorEJq8JDYSDk9Aby1WDJLV
 6SHWhrzU=; b=ClFvo+wN+z3SrEssyAGUs8cpcXKConw23LtPlvCLuOO9nA0UHl/
 fH6yLtb9sFVlla9nWli7KjZF6Kosh9xUuZLA5Odzl6ip/OM21X6HeO7Z+FD7Aj4+
 Va9uy/mOfsF9KbT8aBV3svg47xbeFrWYTNALVEBDIyUYawi/DrA+r8IwkWFuvSHO
 LMppjXrJFMmpps4LAklQBKqumJGaRlM2roeCP91/S6237iJxvDz5gbxS/LfqnLQQ
 9bhMQPSkELKFiLHVcRbOj/AhTDIHD1ydudYKSThOwAbRlRpk5JVtyfYU9dqpCwRT
 LVxcElNXwgkAB3JNpZ/PEtIjZaHYWzxWaPA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id KGWuyDvzN6OO for <linux-nvme@lists.infradead.org>;
 Tue,  8 Mar 2022 19:40:12 -0800 (PST)
Received: from [10.225.163.91] (unknown [10.225.163.91])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KCyd56ytNz1Rvlx;
 Tue,  8 Mar 2022 19:40:09 -0800 (PST)
Message-ID: <645d8224-df64-a057-cb9c-82c6cb8b2d5b@opensource.wdc.com>
Date: Wed, 9 Mar 2022 12:40:08 +0900
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
X-CRM114-CacheID: sfid-20220308_194016_446030_B48368AC 
X-CRM114-Status: GOOD (  19.81  )
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
>  
>  	blk_queue_set_zoned(ns->disk, BLK_ZONED_HM);
>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
> @@ -129,7 +122,7 @@ static void *nvme_zns_alloc_report_buffer(struct nvme_ns *ns,
>  				   sizeof(struct nvme_zone_descriptor);
>  
>  	nr_zones = min_t(unsigned int, nr_zones,
> -			 get_capacity(ns->disk) >> ilog2(ns->zsze));
> +			 get_capacity(ns->disk) / ns->zsze);

This will not compile on 32-bits arch. This needs to use div64_u64().

>  
>  	bufsize = sizeof(struct nvme_zone_report) +
>  		nr_zones * sizeof(struct nvme_zone_descriptor);


-- 
Damien Le Moal
Western Digital Research

