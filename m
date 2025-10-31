Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD37CCCF9F8
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Oct 2025 21:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sQ+JoXonPizc19GDbFjJt0OInnLWi/x4ES7NDAgMyic=; b=kj7Fm0yGdlKlCRDg8rcuvYz7cH
	GZsjfwvaHJFKhT4ziQna3EgVTnoNAQ4I3FyRIOw46srEgD1kIKmvshBpkOx3K1k5tO43O59CJ73IO
	SJPJJbZWKhIeezFLnHpoJFnYXRaGmm7asGdcnU89yxw92bxzTyOL6ionNoZUniQ92IQg90tDRKySe
	c9LNFRbcwmvQx7vQMInS6OAH/j+dgpEKB7WEMW/QlWoJVggU4zuoPLra9QkuTERjiYxX6jllCkmMK
	CywzsNwkcmEHpY57hijMBh0SRGA8kcH/dmsIp3YYh2VDx/KBhGWyJo476HbCMqklfDiZLUTqU7DRk
	0uRd9/gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEwrS-00000006pYk-2uA6;
	Fri, 31 Oct 2025 21:40:42 +0000
Received: from 004.mia.mailroute.net ([199.89.3.7])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEwrQ-00000006pY0-2B5v
	for linux-nvme@lists.infradead.org;
	Fri, 31 Oct 2025 21:40:41 +0000
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4cyvY32462zm0pJx;
	Fri, 31 Oct 2025 21:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1761946836; x=1764538837; bh=sQ+JoXonPizc19GDbFjJt0OI
	nnLWi/x4ES7NDAgMyic=; b=Vefe9pMPLaf3cmzjAH8pQ4CEf7qWKKRJGSzxD4yb
	qkGJJyx+P5Vud2/vVVpBjamhCdhJg2cRUH5C7xenYLyF3sl/gG7qMBYPTS6MKtzW
	2SQJFTEMI8mO/rPXhYA6a4gvDHaAX1uRj+8nBQKXO8sU6nbegJS41qE5CYDiGSTL
	04oz0BePVLgb1TOHJ2h2asum0kugCc8M0llXcD4vRc09CL6wxiZ7OCA9MDFSokEI
	Ujuymz3aYlWIpkgZ/MRWSuj4UAMaRwl9dWQTbC/n2jndrV9zVyoE9N+oZEgdK4oO
	phoSid1sl1QWgz8lrZbKwtewKRpSWzrVNRFgVvIe7oh05Q==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id xEmyZrhwTdbZ; Fri, 31 Oct 2025 21:40:36 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4cyvXp0TXLzm0pL4;
	Fri, 31 Oct 2025 21:40:24 +0000 (UTC)
Message-ID: <42dc640b-28e9-4706-91dc-dd075e736065@acm.org>
Date: Fri, 31 Oct 2025 14:40:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] block: introduce blkdev_get_zone_info()
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org,
 David Sterba <dsterba@suse.com>
References: <20251031061307.185513-1-dlemoal@kernel.org>
 <20251031061307.185513-9-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251031061307.185513-9-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251031_144040_640946_D442B850 
X-CRM114-Status: GOOD (  18.28  )
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

On 10/30/25 11:13 PM, Damien Le Moal wrote:
> +static int blkdev_do_report_zones(struct block_device *bdev, sector_t sector,
> +				  unsigned int nr_zones,
> +				  struct blk_report_zones_args *args)
> +{
> +	struct gendisk *disk = bdev->bd_disk;
> +
> +	if (!bdev_is_zoned(bdev) || WARN_ON_ONCE(!disk->fops->report_zones))
> +		return -EOPNOTSUPP;
> +
> +	if (!nr_zones || sector >= get_capacity(disk))
> +		return 0;
> +
> +	return disk->fops->report_zones(disk, sector, nr_zones, args);
> +}
> +
>   /**
>    * blkdev_report_zones - Get zones information
>    * @bdev:	Target block device
> @@ -226,19 +242,12 @@ struct blk_report_zones_args {
>   int blkdev_report_zones(struct block_device *bdev, sector_t sector,
>   			unsigned int nr_zones, report_zones_cb cb, void *data)
>   {
> -	struct gendisk *disk = bdev->bd_disk;
>   	struct blk_report_zones_args args = {
>   		.cb = cb,
>   		.data = data,
>   	};
>   
> -	if (!bdev_is_zoned(bdev) || WARN_ON_ONCE(!disk->fops->report_zones))
> -		return -EOPNOTSUPP;
> -
> -	if (!nr_zones || sector >= get_capacity(disk))
> -		return 0;
> -
> -	return disk->fops->report_zones(disk, sector, nr_zones, &args);
> +	return blkdev_do_report_zones(bdev, sector, nr_zones, &args);
>   }
>   EXPORT_SYMBOL_GPL(blkdev_report_zones);

One change per patch please. Please split this patch into one patch that
introduces the blkdev_do_report_zones() function and another patch with
the remaining changes from this patch.
> +/**
> + * blkdev_get_zone_info - Get a zone information from cached data

"Get a zone information" -> "Get zone information"

> +	sector = sector & (~(zone_sectors - 1));

Please consider changing the above assignment into:

	sector -= bdev_offset_from_zone_start(bdev, sector);

> +	/*
> +	 * If the zone does not have a zone write plug, it is either full or
> +	 * empty, as we otherwise would have a zone write plug for it. In this
> +	 * case, set the write pointer accordingly and report the zone.
> +	 * Otherwise, if we have a zone write plug, use it.
> +	 */
> +	zwplug = disk_get_zone_wplug(disk, sector);
> +	if (!zwplug) {
> +		if (zone->cond == BLK_ZONE_COND_FULL)
> +			zone->wp = sector + zone_sectors;
> +		else
> +			zone->wp = sector;
> +		return 0;
> +	}

According to ZBC-2 the write pointer is invalid for full zones.

Thanks,

Bart.

