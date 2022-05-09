Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C631C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  9 May 2022 18:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w16vchMYkyFzvUDJDkFpExZGWWDGv88fe0vQkjsLWNM=; b=cNVmRoJ4Wj4HuWIFKjx/Pc6Gcf
	lrDjDIjad4xUKT9HGv6fdV83OWF2tekcvY2s3UIbW3qQZul2ZDytM8cqRUhGCQPkl92LnAorgDDy4
	U5QpaFy37DQdtpZJZeVzKauJ+HcrbFv20ffQ+NTO8PLnZYjkPutlNvseII+llxlqFa19ZtVFCKIEn
	I14KPZriavysdGFEkaNZb0w6rA6PeUfvdrKfB50rXJmlyAJ40bd5T8qQYlfwcKgnACzsc/TvkvlJf
	O4EAcfNqeUxopGqyJcb02z0b5XPFpDnNDziD7BWr8lkEIYphq2nhejSOmwnLYJfY9nBgmwFoqk2Kd
	aC0MMO7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1no8av-00FwLW-Lx; Mon, 09 May 2022 18:58:57 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1no8as-00FwIC-9c
 for linux-nvme@lists.infradead.org; Mon, 09 May 2022 18:58:55 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7AF061F96C;
 Mon,  9 May 2022 18:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652122727;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w16vchMYkyFzvUDJDkFpExZGWWDGv88fe0vQkjsLWNM=;
 b=mlwTaZePSYYE+AM6xPPGqmoaln0IagFvo9KKgNNA4Uz66qywNk6uF9/skqurvX0+4SQsTk
 UJoUGdTg3x8JIPYFK35e6+W609tsTHvyuFkLN8zUuM5Y6yjYFjh4XdOfahdlwnluavSp7v
 s3SJEovsDRoQEco1xf6AO+Dr6kV3n2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652122727;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w16vchMYkyFzvUDJDkFpExZGWWDGv88fe0vQkjsLWNM=;
 b=XoAgV38ZQFsVXsLl2q0Y/LuyEaHZ7SnRRkLm8/ZoXITtGX7+VWngPcr6IpaTqKZE5vbtWk
 ZaBqkBsEIZSIRUCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DE59313AA5;
 Mon,  9 May 2022 18:58:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id C0pQNWZkeWIhcgAAMHmgww
 (envelope-from <dsterba@suse.cz>); Mon, 09 May 2022 18:58:46 +0000
Date: Mon, 9 May 2022 20:54:32 +0200
From: David Sterba <dsterba@suse.cz>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: jaegeuk@kernel.org, hare@suse.de, dsterba@suse.com, axboe@kernel.dk,
 hch@lst.de, damien.lemoal@opensource.wdc.com, snitzer@kernel.org,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 bvanassche@acm.org, linux-fsdevel@vger.kernel.org,
 matias.bjorling@wdc.com, Jens Axboe <axboe@fb.com>,
 gost.dev@samsung.com, jonathan.derrick@linux.dev,
 jiangbo.365@bytedance.com, linux-nvme@lists.infradead.org,
 dm-devel@redhat.com, Naohiro Aota <naohiro.aota@wdc.com>,
 linux-kernel@vger.kernel.org, Johannes Thumshirn <jth@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Alasdair Kergon <agk@redhat.com>,
 linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
 Keith Busch <kbusch@kernel.org>, linux-btrfs@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v3 11/11] dm-zoned: ensure only power of 2 zone sizes are
 allowed
Message-ID: <20220509185432.GB18596@twin.jikos.cz>
Mail-Followup-To: dsterba@suse.cz, Pankaj Raghav <p.raghav@samsung.com>,
 jaegeuk@kernel.org, hare@suse.de, dsterba@suse.com, axboe@kernel.dk,
 hch@lst.de, damien.lemoal@opensource.wdc.com, snitzer@kernel.org,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 bvanassche@acm.org, linux-fsdevel@vger.kernel.org,
 matias.bjorling@wdc.com, Jens Axboe <axboe@fb.com>,
 gost.dev@samsung.com, jonathan.derrick@linux.dev,
 jiangbo.365@bytedance.com, linux-nvme@lists.infradead.org,
 dm-devel@redhat.com, Naohiro Aota <naohiro.aota@wdc.com>,
 linux-kernel@vger.kernel.org, Johannes Thumshirn <jth@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Alasdair Kergon <agk@redhat.com>,
 linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
 Keith Busch <kbusch@kernel.org>, linux-btrfs@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>
References: <20220506081105.29134-1-p.raghav@samsung.com>
 <CGME20220506081118eucas1p17f3c29cc36d748c3b5a3246f069f434a@eucas1p1.samsung.com>
 <20220506081105.29134-12-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506081105.29134-12-p.raghav@samsung.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220509_115854_526440_4E4EF8D6 
X-CRM114-Status: GOOD (  20.16  )
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
Reply-To: dsterba@suse.cz
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, May 06, 2022 at 10:11:05AM +0200, Pankaj Raghav wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> Today dm-zoned relies on the assumption that you have a zone size
> with a power of 2. Even though the block layer today enforces this
> requirement, these devices do exist and so provide a stop-gap measure
> to ensure these devices cannot be used by mistake
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  drivers/md/dm-zone.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
> index 3e7b1fe15..27dc4ddf2 100644
> --- a/drivers/md/dm-zone.c
> +++ b/drivers/md/dm-zone.c
> @@ -231,6 +231,18 @@ static int dm_revalidate_zones(struct mapped_device *md, struct dm_table *t)
>  	struct request_queue *q = md->queue;
>  	unsigned int noio_flag;
>  	int ret;
> +	struct block_device *bdev = md->disk->part0;
> +	sector_t zone_sectors;
> +	char bname[BDEVNAME_SIZE];
> +
> +	zone_sectors = bdev_zone_sectors(bdev);
> +
> +	if (!is_power_of_2(zone_sectors)) {

is_power_of_2 takes 'unsigned long' and sector_t is u64, so this is not
32bit clean and we had an actual bug where value 1<<48 was not
recognized as power of 2.

> +		DMWARN("%s: %s only power of two zone size supported\n",
> +		       dm_device_name(md),
> +		       bdevname(bdev, bname));
> +		return 1;
> +	}
>  
>  	/*
>  	 * Check if something changed. If yes, cleanup the current resources
> -- 
> 2.25.1

