Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B954DC433FE
	for <linux-nvme@archiver.kernel.org>; Fri,  6 May 2022 15:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:To:From:References:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r48NN8K17+Vaycp2fcoUaY8PZRHqW5yBueK7iYcVfJY=; b=pELuSlg7+zfLhaAEx+MZ0Yrcxj
	TboNcjOiHsqB9I8v1vK6+rkQRDgH5Dditok2k44hJwKGrAA9RrFAYEnfaaC/Qm1L1K+ElxRXMsGDe
	K1hlFWBmoO4XBSmjL4y1CfrhEyHuCLNdlou9Tt1zpsKuCbyD9AAFwegWKQXnHMi6Joh9I3DZ23bu1
	2FJt3r1t0bA0BqAJ/5DIQ/Z/C0U1a60I1v/sqeGIc1pfZ3CcmEcL3aGZ6JtJbCYTXfseyplVtnxpF
	915w+1aq/7CEMMY5/v3QCvj86JONnade780GpJW4oFTHAPb854RpsNPpztADeWL5jB5Pfv6sGvExD
	uWLX6faA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmzU8-003wWi-3J; Fri, 06 May 2022 15:03:12 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmIPq-00Bp0i-RD
 for linux-nvme@lists.infradead.org; Wed, 04 May 2022 17:03:56 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 54385210E6;
 Wed,  4 May 2022 17:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1651683831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r48NN8K17+Vaycp2fcoUaY8PZRHqW5yBueK7iYcVfJY=;
 b=u0Oe4gfc1OhFZsT1UUyMuMt08draDSwEqD3AdD9jt9/qwYg9acWkqsrrpzW0WvJ4UDM6lE
 fFO3SASX2LtgEe4r0IVMUg78LBBRhVHEBvaFggznA1XDSGAr3gl99IR6AeUBYaOZFdVTnh
 MsqkFs2WaX9f9VkewxprCasGCDulyqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1651683831;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r48NN8K17+Vaycp2fcoUaY8PZRHqW5yBueK7iYcVfJY=;
 b=WL7Mwjzvc7qZd7CxcdYyzSZtHL135g1bMXjbrTJTi51amF5aezAaa5HJ0UGqmtv/m5zq6L
 MC+BAh7W/YAJU5Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A3897131BD;
 Wed,  4 May 2022 17:03:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Ob9+GvGxcmJMWAAAMHmgww
 (envelope-from <hare@suse.de>); Wed, 04 May 2022 17:03:45 +0000
Message-ID: <6a1c06e8-bedd-47b0-2a3f-9c51468fc029@suse.de>
Date: Wed, 4 May 2022 10:03:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 05/16] nvme: zns: Allow ZNS drives that have
 non-power_of_2 zone size
Content-Language: en-US
References: <20220427160255.300418-1-p.raghav@samsung.com>
 <CGME20220427160301eucas1p147d0dced70946e20dd2dd046b94b8224@eucas1p1.samsung.com>
 <20220427160255.300418-6-p.raghav@samsung.com>
From: Hannes Reinecke <hare@suse.de>
To: undisclosed-recipients: ;
In-Reply-To: <20220427160255.300418-6-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220504_100355_060982_763E4E54 
X-CRM114-Status: GOOD (  20.08  )
X-Mailman-Approved-At: Fri, 06 May 2022 08:02:49 -0700
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

On 4/27/22 09:02, Pankaj Raghav wrote:
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
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   drivers/nvme/host/zns.c | 11 ++---------
>   1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> index 9f81beb4df4e..2087de0768ee 100644
> --- a/drivers/nvme/host/zns.c
> +++ b/drivers/nvme/host/zns.c
> @@ -101,13 +101,6 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
>   	}
>   
>   	ns->zsze = nvme_lba_to_sect(ns, le64_to_cpu(id->lbafe[lbaf].zsze));
> -	if (!is_power_of_2(ns->zsze)) {
> -		dev_warn(ns->ctrl->device,
> -			"invalid zone size:%llu for namespace:%u\n",
> -			ns->zsze, ns->head->ns_id);
> -		status = -ENODEV;
> -		goto free_data;
> -	}
>   
>   	blk_queue_set_zoned(ns->disk, BLK_ZONED_HM);
>   	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
> @@ -129,7 +122,7 @@ static void *nvme_zns_alloc_report_buffer(struct nvme_ns *ns,
>   				   sizeof(struct nvme_zone_descriptor);
>   
>   	nr_zones = min_t(unsigned int, nr_zones,
> -			 get_capacity(ns->disk) >> ilog2(ns->zsze));
> +			 div64_u64(get_capacity(ns->disk), ns->zsze));
>   
Same here; please add a helper calculating the number of zones for a 
given disk.

>   	bufsize = sizeof(struct nvme_zone_report) +
>   		nr_zones * sizeof(struct nvme_zone_descriptor);
> @@ -197,7 +190,7 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
>   	c.zmr.zrasf = NVME_ZRASF_ZONE_REPORT_ALL;
>   	c.zmr.pr = NVME_REPORT_ZONE_PARTIAL;
>   
> -	sector &= ~(ns->zsze - 1);
> +	sector = rounddown(sector, ns->zsze);
>   	while (zone_idx < nr_zones && sector < get_capacity(ns->disk)) {
>   		memset(report, 0, buflen);
>   
Please be a bit more consistent. In the previous patches you always had 
a condition to check if it's a power_of_2 zone size, but here you are 
using the same calculation for each disk.
So please use the check in all locations, or add a comment why the 
generic calculation is okay to use here.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

