Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3F2C04A68
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jul 2022 23:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9RCSjgTld4jFxyRMFpo8i47HSyAGNN8HsW/U7jGMYJo=; b=tkZTddl1rl6Vg41qOFiZ+CIm+I
	+5aLt3DkpHr4bG2ekr1GG5Vo8ebDqVdqayfPlQ694IiaN4pZWDRkqEERHFoo4IuVdljxiEI9qU+e1
	locV+SMK57QhAA1CBggC5/nhNIRNg5pgTaaBDVzYgjuZJ3V08gF+RIXp2LVGBhotaTVKJhKiM6FfF
	tSuePNhz4cqFlcmi6W2WXQbYvWiHzUA2u+AD4A2OmZ/oI+IvKqdsEUIDaAteKiFECgUNxL+hppghI
	Tfsl8C50/WMYxM09tcuCEn1UrvyDFZUrnTIrolQSDJJilQJ2lg0qX2ZiLriZn9dSyGXq5aB8lFiFC
	kLaFwT6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGqGg-001NE5-QB; Wed, 27 Jul 2022 23:16:42 +0000
Received: from mail-pg1-f180.google.com ([209.85.215.180])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGqGd-001NAB-Sg
	for linux-nvme@lists.infradead.org; Wed, 27 Jul 2022 23:16:41 +0000
Received: by mail-pg1-f180.google.com with SMTP id bh13so132724pgb.4
        for <linux-nvme@lists.infradead.org>; Wed, 27 Jul 2022 16:16:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9RCSjgTld4jFxyRMFpo8i47HSyAGNN8HsW/U7jGMYJo=;
        b=FcZqWG5k+ZcQLHtEMNyTEdNDUOmu4QMKzc4qZg7cFOXnlIcPfX2pd8pWA80aLMcEj8
         gdOrkhJ5GIXpUIbCvM10wr316pz4X5fRRpgO+O93TbJe2jUlyKF5mHmPaDaekFPSJGN1
         wfafF3AnKeOQlv08cSqYUicUW9ca6Y8eOx+RZidbCgg0P6DmI7I40aJGDDFcxto5TEeJ
         QmlMb3Wfq0FIKd8tYWWIl2Xlxf7aLMqHgFEcrbON2/4ayQMQdaNMYmJKVZ2xzozgCT2i
         T4EeXQz32M5nJadqf53j7gTnfDTUPs+mZ6XcsdrqQ+L+GNM3+3e7lQdiqmuyIi4zRnEG
         Qgww==
X-Gm-Message-State: AJIora+dkaxcALRxysFQjBXyHGRImJvLfs2h+4pOraHWszr5hk4A/mW2
	BacqI5+8A1APQce20w87uSY=
X-Google-Smtp-Source: AGRyM1vSsVlL/urmNVN47qPHjbOavQDlMzKZVyvZFSg6UpuKUdlr1Wsfk2LxjLM4G7rsl977tP28Ug==
X-Received: by 2002:a05:6a00:114f:b0:528:2c7a:634c with SMTP id b15-20020a056a00114f00b005282c7a634cmr23853833pfm.41.1658963794531;
        Wed, 27 Jul 2022 16:16:34 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:a84e:2ec1:1b57:b033? ([2620:15c:211:201:a84e:2ec1:1b57:b033])
        by smtp.gmail.com with ESMTPSA id f25-20020a635559000000b0041983a8d8c2sm12585044pgm.39.2022.07.27.16.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 16:16:33 -0700 (PDT)
Message-ID: <7984b969-9025-6b31-2645-da08daeefafb@acm.org>
Date: Wed, 27 Jul 2022 16:16:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 02/11] block: allow blk-zoned devices to have
 non-power-of-2 zone size
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, damien.lemoal@opensource.wdc.com,
 hch@lst.de, axboe@kernel.dk, snitzer@kernel.org, Johannes.Thumshirn@wdc.com
Cc: matias.bjorling@wdc.com, gost.dev@samsung.com,
 linux-kernel@vger.kernel.org, hare@suse.de, linux-block@vger.kernel.org,
 pankydev8@gmail.com, jaegeuk@kernel.org, dm-devel@redhat.com,
 linux-nvme@lists.infradead.org, Luis Chamberlain <mcgrof@kernel.org>
References: <20220727162245.209794-1-p.raghav@samsung.com>
 <CGME20220727162248eucas1p2ff8c3c2b021bedcae3960024b4e269e9@eucas1p2.samsung.com>
 <20220727162245.209794-3-p.raghav@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220727162245.209794-3-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220727_161639_952137_1EBFE4FF 
X-CRM114-Status: GOOD (  21.16  )
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

On 7/27/22 09:22, Pankaj Raghav wrote:
> Checking if a given sector is aligned to a zone is a common
> operation that is performed for zoned devices. Add
> bdev_is_zone_start helper to check for this instead of opencoding it
> everywhere.

I can't find the bdev_is_zone_start() function in this patch?

> To make this work bdev_get_queue(), bdev_zone_sectors() and
> bdev_is_zoned() are moved earlier without modifications.

Can that change perhaps be isolated into a separate patch?

> diff --git a/block/blk-core.c b/block/blk-core.c
> index 3d286a256d3d..1f7e9a90e198 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -570,7 +570,7 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
>   		return BLK_STS_NOTSUPP;
>   
>   	/* The bio sector must point to the start of a sequential zone */
> -	if (bio->bi_iter.bi_sector & (bdev_zone_sectors(bio->bi_bdev) - 1) ||
> +	if (!bdev_is_zone_aligned(bio->bi_bdev, bio->bi_iter.bi_sector) ||
>   	    !bio_zone_is_seq(bio))
>   		return BLK_STS_IOERR;

The bdev_is_zone_start() name seems more clear to me than 
bdev_is_zone_aligned(). Has there already been a discussion about which 
name to use for this function?

> +		/*
> +		 * Non power-of-2 zone size support was added to remove the
> +		 * gap between zone capacity and zone size. Though it is technically
> +		 * possible to have gaps in a non power-of-2 device, Linux requires
> +		 * the zone size to be equal to zone capacity for non power-of-2
> +		 * zoned devices.
> +		 */
> +		if (!is_power_of_2(zone->len) && zone->capacity < zone->len) {
> +			pr_warn("%s: Invalid zone capacity for non power of 2 zone size",
> +				disk->disk_name);

Given the severity of this error, shouldn't the zone capacity and length 
be reported in the error message?

Thanks,

Bart.

