Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9480BC04A68
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jul 2022 12:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RCAW+pbfUR2hVcHVMffOWUnXziugm9XBYRvhJy477A0=; b=t0D+if2t6w/bxj2QKDnXkU7piV
	Z82NPPpXCzncldwL5h6XU5Lv8R+e2nYkLQZ11Tgsip0ZRslKwM75N/ymHC1tMhZ6xlE2EQ3Y22iGy
	UPOPzTk/0sgCJLinwjFtBd+yhZBdoOyWHe0Z+6FgEusSA217Ju3GgA63EGKJWDQnATeyakt864Ckl
	8/iRJBLG1ChrlyWvZzpVahnGMP7h9vN6tvbi7G7n25snHnN/XHe6jMZ90wTQFCfbZWqIE266P/Zaa
	RekpoGKkbviSJZ1eshUAr03cjuOVgy1887Qh897OFVKFI/wM8oSeYh96/KefF/UXR75+LNPcbP105
	u/1vYQ8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oH2VZ-009Aei-H1; Thu, 28 Jul 2022 12:20:53 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oH2VW-009AcW-ED
	for linux-nvme@lists.infradead.org; Thu, 28 Jul 2022 12:20:51 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 34E8F372EC;
	Thu, 28 Jul 2022 12:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1659010847;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RCAW+pbfUR2hVcHVMffOWUnXziugm9XBYRvhJy477A0=;
	b=cMRYfjiF85Ju7aoXKWebUfzKaaxAh4M92EX4IXjucc3NE4stUbOAL3sAN10XyEuDhvTtgO
	mudPs9ipMIYBpXlV+jQdTqtruaGzgaxYxp1RcNuMgNgA73mumpqM1MNAHd1tMYeuLRWsAQ
	OS2DF90UakFMEaNlkwCwJSHIoWq8iLc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1659010847;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RCAW+pbfUR2hVcHVMffOWUnXziugm9XBYRvhJy477A0=;
	b=X4PURyY8PyuTCefkGj2BlbcoYaTtFZE8nrFKK4Di4OURQ/j61s4hh92pzXeOY3sXOVopOF
	yqWvufOot5YtS3Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CA18113A7E;
	Thu, 28 Jul 2022 12:20:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 4b3zLx5/4mKbJgAAMHmgww
	(envelope-from <dsterba@suse.cz>); Thu, 28 Jul 2022 12:20:46 +0000
Date: Thu, 28 Jul 2022 14:15:48 +0200
From: David Sterba <dsterba@suse.cz>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: damien.lemoal@opensource.wdc.com, hch@lst.de, axboe@kernel.dk,
	snitzer@kernel.org, Johannes.Thumshirn@wdc.com,
	matias.bjorling@wdc.com, gost.dev@samsung.com,
	linux-kernel@vger.kernel.org, hare@suse.de,
	linux-block@vger.kernel.org, pankydev8@gmail.com,
	bvanassche@acm.org, jaegeuk@kernel.org, dm-devel@redhat.com,
	linux-nvme@lists.infradead.org,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v8 07/11] dm-zoned: ensure only power of 2 zone sizes are
 allowed
Message-ID: <20220728121548.GE13489@twin.jikos.cz>
Mail-Followup-To: dsterba@suse.cz, Pankaj Raghav <p.raghav@samsung.com>,
	damien.lemoal@opensource.wdc.com, hch@lst.de, axboe@kernel.dk,
	snitzer@kernel.org, Johannes.Thumshirn@wdc.com,
	matias.bjorling@wdc.com, gost.dev@samsung.com,
	linux-kernel@vger.kernel.org, hare@suse.de,
	linux-block@vger.kernel.org, pankydev8@gmail.com,
	bvanassche@acm.org, jaegeuk@kernel.org, dm-devel@redhat.com,
	linux-nvme@lists.infradead.org,
	Luis Chamberlain <mcgrof@kernel.org>
References: <20220727162245.209794-1-p.raghav@samsung.com>
 <CGME20220727162253eucas1p1a5912e0494f6918504cc8ff15ad5d31f@eucas1p1.samsung.com>
 <20220727162245.209794-8-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727162245.209794-8-p.raghav@samsung.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220728_052050_646478_E72338BA 
X-CRM114-Status: GOOD (  10.33  )
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

On Wed, Jul 27, 2022 at 06:22:41PM +0200, Pankaj Raghav wrote:
> --- a/drivers/md/dm-zoned-target.c
> +++ b/drivers/md/dm-zoned-target.c
> @@ -792,6 +792,10 @@ static int dmz_fixup_devices(struct dm_target *ti)
>  				return -EINVAL;
>  			}
>  			zone_nr_sectors = bdev_zone_sectors(bdev);
> +			if (!is_power_of_2(zone_nr_sectors)) {
> +				ti->error = "Zone size is not power of 2";

This could print what's the value of zone_nr_sectors

> +				return -EINVAL;
> +			}
>  			zoned_dev->zone_nr_sectors = zone_nr_sectors;
>  			zoned_dev->nr_zones = bdev_nr_zones(bdev);
>  		}
> @@ -804,6 +808,10 @@ static int dmz_fixup_devices(struct dm_target *ti)
>  			return -EINVAL;
>  		}
>  		zoned_dev->zone_nr_sectors = bdev_zone_sectors(bdev);
> +		if (!is_power_of_2(zoned_dev->zone_nr_sectors)) {
> +			ti->error = "Zone size is not power of 2";

Same

> +			return -EINVAL;
> +		}
>  		zoned_dev->nr_zones = bdev_nr_zones(bdev);
>  	}
>  
> -- 
> 2.25.1

