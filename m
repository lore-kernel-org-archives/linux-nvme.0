Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF955C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 16 May 2022 14:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XG9pthlD0eAdpXe1K8jm8dpusf7MYkENzjnTCFt1nT8=; b=QIdOJiuxanTtTr+Iul0lfE6L0L
	zke/OduJSSFfuFdYvWHCyIf6JvUyuKF4sGHdBuqw8j0M3d63xx0fHrVHnFc7bMfAJHmFsQeLRtCpp
	CFeDar9zQNbljCP1Wv04XeToaGnuj6a/I4m8Rf4uGAUfAdP8s0eDhfOJijJgpuWlLh/WPNPgLQVQ0
	AOdeH9hIORhWzi19GQ9SffIanRnpwVMY0glBemyAN5iEq3+B/psu7+XllfMkNQFx+03tvpFYAo++J
	8cOb8DJIa2d+/if3gLlnqdpMzv9aaGukvbvKC3uBDrxhgJhAf1dsFI3WYCLSCBOu6+B1HT11qUtGz
	8+mo/RcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqbIy-008AIp-QX; Mon, 16 May 2022 14:02:36 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqbIt-008ADv-8I
 for linux-nvme@lists.infradead.org; Mon, 16 May 2022 14:02:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1652709751; x=1684245751;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=xGZDTf4qfj90dVVU9I5TmSQhq50AE4kFyxK7baB8oU4=;
 b=loZ+yu/duBglJU57E6XMUjPf1XHqG07karGg/YujMNBXCBfrdAgQGmFx
 6o4mLw4M2x/1KcQs6vL+/mk/BSmZZuABrGnVAgR9PCH5XAoQE0hIncUSC
 vtHM7eeKmvK1ovc9v80k7GQGIRsJtG5mFIk9ASCZdY1DFYyUTw1OeMWFf
 b5ZzZ8ps3ba/SS6U7OZIl2e7i4thNlJBZvP40dYHPCsP0J1eBn1BEKqKj
 a52EUqLZHMnxE+kdh/Op6pbEZVWe3CsCP9LocuRT35T6VOkuzvYKKrxeU
 aJ2mVmS8mnNceWOGvBsqgAN5WkhZSWqTP940G1rzhbnlZwsouCgnFwaNW Q==;
X-IronPort-AV: E=Sophos;i="5.91,230,1647273600"; d="scan'208";a="201300057"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 16 May 2022 22:02:28 +0800
IronPort-SDR: OxZnDcqHwMccOJK/Oj8mrdZCpTsvnpOiAfHlatKHOdO2juobykXmGsdj6n1vvVx57wLw0whBAu
 R1eNm1BIXuCd9W5mBjgMidg0tEXV8T45DTON1RJvtNdMuzRnssxSPuL5bYyvkjBSE0hegjlkOU
 Pbz/6Ox3HkLQGoipJaVt28qNOdSszWyX8cYcktpa+5W01GoF6BHs71lw5V13Ff+ZNKRD4l92S0
 3qNEkGMUN+wE0tHeYPbBX2j9DkKKYUX2qiFI9MDhtZk/JCEvmgyICBXIUJNmY8vRucCAAAcMh1
 cEiJf8v86mwMHAqrpfEBtsLf
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 16 May 2022 06:28:10 -0700
IronPort-SDR: fcnkGCzMJh2J+7DNcArqRBIQ9zCO/FKY4RWpgaSh4U9C1gg8ifMYKAA+9DcGQgbS3BRynMb/zI
 gED0KVHdV5nYUDvkEc/jewDXvz7GUU4YL91EeWTPnxRASP2ELSh/BpaNDNCY8D3tyM/6MVf/dd
 nzqrfPNxLZNqCFsL7rgzqi/xaJAj7qSjSjE30p/sUxor1QFT2bEJ5WJRJgjz21sWnWDMkXybXR
 QQE2+p+sITKegG4QR09Hyx7Kj+mYqmmq4jVxeiLwrD53kfo+w1KT/fEquoM/5pMHxpAuzBVNMc
 4G0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 16 May 2022 07:02:28 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L21Cl6xljz1SVny
 for <linux-nvme@lists.infradead.org>; Mon, 16 May 2022 07:02:27 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1652709747; x=1655301748; bh=xGZDTf4qfj90dVVU9I5TmSQhq50AE4kFyxK
 7baB8oU4=; b=BfBYgNsZ+siIAOaFFV8ORNyI1hHayTk2+IZ97SuE/RQw3f85/g+
 iOHRQ6DIbLehX2BUg43EH2PfJ84Mhi1w7NepehdOw0H3+rdx6hosakiN8UFeC/ZZ
 qrqwo60Sqgsl3aoxlvs3BcQ/dsdIOjV4/UH253I9MDD1EKQccyOkMEXjWDM+laUP
 48HjBexyerRk07a4NhdGMFwEniePnYNtolwQkfP2dQ297lFyVth1X4bTN8zMPPD/
 z42+sRJ9viAKZSWKafIgxT5YvljUKLuprFO0yFNAhCR4Rqa1SG6W/5JiFmqJNdeb
 iHbO8fFnXQN9uxrsANwRUroe3kkzWhokSWQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id UG-4jjHRthlg for <linux-nvme@lists.infradead.org>;
 Mon, 16 May 2022 07:02:27 -0700 (PDT)
Received: from [10.225.1.43] (unknown [10.225.1.43])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L21Cb6yPlz1Rvlc;
 Mon, 16 May 2022 07:02:19 -0700 (PDT)
Message-ID: <501aba4d-f4a3-8a4d-ec2a-99c7319b6a4d@opensource.wdc.com>
Date: Mon, 16 May 2022 16:02:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [dm-devel] [PATCH v4 03/13] nvme: zns: Allow ZNS drives that have
 non-power_of_2 zone size
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk,
 naohiro.aota@wdc.com, Johannes.Thumshirn@wdc.com, snitzer@kernel.org,
 dsterba@suse.com, jaegeuk@kernel.org, hch@lst.de
Cc: jiangbo.365@bytedance.com, Jens Axboe <axboe@fb.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, bvanassche@acm.org,
 Chris Mason <clm@fb.com>, matias.bjorling@wdc.com, gost.dev@samsung.com,
 Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Josef Bacik <josef@toxicpanda.com>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 dm-devel@redhat.com, Alasdair Kergon <agk@redhat.com>,
 jonathan.derrick@linux.dev, Keith Busch <kbusch@kernel.org>,
 Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>
References: <20220516133921.126925-1-p.raghav@samsung.com>
 <CGME20220516133926eucas1p15c7ba425b67ce4ac824c6bd3263e2dd4@eucas1p1.samsung.com>
 <20220516133921.126925-4-p.raghav@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220516133921.126925-4-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220516_070231_452162_AB1772F8 
X-CRM114-Status: GOOD (  26.51  )
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

On 2022/05/16 15:39, Pankaj Raghav wrote:
> Remove the condition which disallows non-power_of_2 zone size ZNS drive
> to be updated and use generic method to calculate number of zones
> instead of relying on log and shift based calculation on zone size.
> 
> The power_of_2 calculation has been replaced directly with generic
> calculation without special handling. Both modified functions are not
> used in hot paths, they are only used during initialization &
> revalidation of the ZNS device.
> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  drivers/nvme/host/zns.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> index 9f81beb4d..65d2aa68a 100644
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
> @@ -128,8 +121,13 @@ static void *nvme_zns_alloc_report_buffer(struct nvme_ns *ns,
>  	const size_t min_bufsize = sizeof(struct nvme_zone_report) +
>  				   sizeof(struct nvme_zone_descriptor);
>  
> +	/*
> +	 * Division is used to calculate nr_zones with no special handling
> +	 * for power of 2 zone sizes as this function is not invoked in a
> +	 * hot path
> +	 */

Comment not very useful.

>  	nr_zones = min_t(unsigned int, nr_zones,
> -			 get_capacity(ns->disk) >> ilog2(ns->zsze));
> +			 div64_u64(get_capacity(ns->disk), ns->zsze));
>  
>  	bufsize = sizeof(struct nvme_zone_report) +
>  		nr_zones * sizeof(struct nvme_zone_descriptor);
> @@ -182,6 +180,7 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
>  	int ret, zone_idx = 0;
>  	unsigned int nz, i;
>  	size_t buflen;
> +	u64 remainder = 0;
>  
>  	if (ns->head->ids.csi != NVME_CSI_ZNS)
>  		return -EINVAL;
> @@ -197,7 +196,14 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
>  	c.zmr.zrasf = NVME_ZRASF_ZONE_REPORT_ALL;
>  	c.zmr.pr = NVME_REPORT_ZONE_PARTIAL;
>  
> -	sector &= ~(ns->zsze - 1);
> +	/*
> +	 * rounddown the sector value to the nearest zone size. roundown macro
> +	 * provided in math.h will not work for 32 bit architectures.
> +	 * Division is used here with no special handling for power of 2
> +	 * zone sizes as this function is not invoked in a hot path
> +	 */

Please simplify this to:

	/* Round down the sector value to the nearest zone start */

> +	div64_u64_rem(sector, ns->zsze, &remainder);
> +	sector -= remainder;
>  	while (zone_idx < nr_zones && sector < get_capacity(ns->disk)) {
>  		memset(report, 0, buflen);
>  


-- 
Damien Le Moal
Western Digital Research

