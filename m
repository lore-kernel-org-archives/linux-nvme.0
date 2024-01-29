Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F00C47DB3
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 23:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=So/8nH5GRmhiwdX5iD5VRBEC1iFxILOIoK7mcMdivhs=; b=Z/OcrpXMqmUXjfEEfFOzW0/ULQ
	R7oZaILGI6+SOEoiAi/S4KkXYlbjSnHhM0kC3z6LfmUo38XETjuegSnsGSxgTcWdOeWG18UcK50YS
	l8b2Gin3JOopf+9mjEi7FXNvYD8dC+IjiRHW6SYJmFmNYzL4d3pT3wjICKm3OHWq7WOF8W4LfLjTJ
	96Zi1RojJ45P0bKKu/AxJ0P5LzwplhhzdcKX9aFnXe9T/tpCJMU+//rYke4XiIXq8mpFPv4Ej9Qo3
	dBrtW8VFndIcarM5jCAPCJrYOa+1rlM4Za/6yN9HdueQHqj0rUCfdEwIzuKqNQLrKjFDjGn1q+OwG
	LbCpbOdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUb1F-0000000EZpe-0YWu;
	Mon, 29 Jan 2024 23:26:25 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUb1C-0000000EZnb-03J1
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 23:26:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 463C0625B9;
	Mon, 29 Jan 2024 23:26:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CEE9C433F1;
	Mon, 29 Jan 2024 23:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706570779;
	bh=d/aQihyhdrtQJBuM7w+mKzeJ7H7OziElkA0HqJ7h9Ns=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cYbOj+lj440jTo5PgwKnZXAFXNbloJYcUptUFrmP/kHDVvR5Z1i2RPWI4PU6Yxkym
	 Kg+OIUk9HDHgMKXZTE81B0sSLP2CSr5ZdS2J6eOdc+GiZqL350GMAvwUwofcabo2rn
	 pdAV3WTDvgkHzQH/AuUmbL1/MN6crGnAmcHZVMqy4YdEGfyg7DSfLdFL1Qk+BWwFw8
	 icjJpIuLa4aSSs+9DERd0+aaZ5zqBiYROxRuNxljVdlSRdlBfeNEElbCisc9dyRumd
	 WQQhGjtgaDkAecCk/hjPseTUUSpTW9yFJaXQDr6D2CdIkQeQUhI4T5hAM+EvQYomCT
	 df9fqY/vlV2qw==
Message-ID: <e2f8b1d7-78ab-4ef5-bb4f-088d60f7d7fc@kernel.org>
Date: Tue, 30 Jan 2024 08:26:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] dm: dm-zoned: guard blkdev_zone_mgmt with noio
 scope
Content-Language: en-US
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20240128-zonefs_nofs-v3-0-ae3b7c8def61@wdc.com>
 <20240128-zonefs_nofs-v3-2-ae3b7c8def61@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240128-zonefs_nofs-v3-2-ae3b7c8def61@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_152622_146817_BB5E9417 
X-CRM114-Status: GOOD (  16.37  )
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

On 1/29/24 16:52, Johannes Thumshirn wrote:
> Guard the calls to blkdev_zone_mgmt() with a memalloc_noio scope.
> This helps us getting rid of the GFP_NOIO argument to blkdev_zone_mgmt();
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> ---
>  drivers/md/dm-zoned-metadata.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/md/dm-zoned-metadata.c b/drivers/md/dm-zoned-metadata.c
> index fdfe30f7b697..165996cc966c 100644
> --- a/drivers/md/dm-zoned-metadata.c
> +++ b/drivers/md/dm-zoned-metadata.c
> @@ -1655,10 +1655,13 @@ static int dmz_reset_zone(struct dmz_metadata *zmd, struct dm_zone *zone)
>  
>  	if (!dmz_is_empty(zone) || dmz_seq_write_err(zone)) {
>  		struct dmz_dev *dev = zone->dev;
> +		unsigned int noio_flag;
>  
> +		noio_flag = memalloc_noio_save();
>  		ret = blkdev_zone_mgmt(dev->bdev, REQ_OP_ZONE_RESET,
>  				       dmz_start_sect(zmd, zone),
> -				       zmd->zone_nr_sectors, GFP_NOIO);
> +				       zmd->zone_nr_sectors, GFP_KERNEL);
> +		memalloc_noio_restore(noio_flag);
>  		if (ret) {
>  			dmz_dev_err(dev, "Reset zone %u failed %d",
>  				    zone->id, ret);
> 

-- 
Damien Le Moal
Western Digital Research


