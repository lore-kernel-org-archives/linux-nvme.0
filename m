Return-Path: <SRS0=ZjMq=ND=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B849DC4338F
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Aug 2021 15:48:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7481560E93
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Aug 2021 15:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7481560E93
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=hqLpRFE47MzrOSoILWbQYOrTOOmgJvvFlSgUZQl4TPY=; b=oi+YS2aeVpGJ1iMasVG9uVduHb
	0r66pvocHw+7xVcwNuKF5CPtirtiwAM0RCETHio36viVAE0qhsnQHxSDLCkr0CSNNs9YXWRvHCF1G
	NBR1VsjkNZpBpFSwCAeij4gsU0EN1PljtEqgQAEbJWeAqJGHDlN9nsa5+CjnRFqDpDblA+r1L4YbO
	7pnpDQALGhW/6K88f8MCJwyGjeq1jLNch+uZtWFRv7A1IO1RRqdXvcPitHp65FmngzU4xoSx7SEwm
	LMRPayRSb+0v0wd48qV5grcgvCibwDSL91vUr8wq0x7IsQBYDNg+YtdCZNWVSrBUA39UDgUg2fT9Z
	ux1vasLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mECwM-00Aaie-RC; Thu, 12 Aug 2021 15:48:18 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mECwH-00AahE-6Z
 for linux-nvme@lists.infradead.org; Thu, 12 Aug 2021 15:48:17 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EA35F222A7;
 Thu, 12 Aug 2021 15:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1628783291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dggFCYfqvDGrc8ufyifdsUWa0iADyaxGU9QqwNJ3pNo=;
 b=NAfSTEBSkS/9UW2OGRu0KM86uMN88fpuuZtoZ0nyXuJbRTctqKyh0GvWMMiCntTvbWNXpe
 7sgCRk8h28MJodPKkmk7skNfmgLD4i6itTH+af4ASG70uoioR8IJj8hDd5o7JuWDpt7UIU
 BEzdCi8FzV/QQVpIGcEGYVUoYbIHqVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1628783291;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dggFCYfqvDGrc8ufyifdsUWa0iADyaxGU9QqwNJ3pNo=;
 b=jlMXXbviU9zQg6ZGEOseMnWtZOCtL2RjJqg6qLc4keAjYa1QgoS7S/8NawXNXzIrXsnDwt
 ZGO8Eq2x0gyEi9Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7E09C13C59;
 Thu, 12 Aug 2021 15:48:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id f/BwFLlCFWE6HwAAMHmgww
 (envelope-from <colyli@suse.de>); Thu, 12 Aug 2021 15:48:09 +0000
Subject: Re: [PATCH 6/8] bcache: add proper error unwinding in
 bcache_device_init
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Song Liu <song@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Luis Chamberlain <mcgrof@kernel.org>, linux-block@vger.kernel.org,
 linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20210809064028.1198327-1-hch@lst.de>
 <20210809064028.1198327-7-hch@lst.de>
From: Coly Li <colyli@suse.de>
Message-ID: <bdec1e0a-e789-19f1-e9b6-d7f99413670d@suse.de>
Date: Thu, 12 Aug 2021 23:48:07 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210809064028.1198327-7-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210812_084813_450760_A3FE7F86 
X-CRM114-Status: GOOD (  18.67  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/9/21 2:40 PM, Christoph Hellwig wrote:
> Except for the IDA none of the allocations in bcache_device_init is
> unwound on error, fix that.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Coly Li <colyli@suse.de>

Thanks.

Coly Li

> ---
>  drivers/md/bcache/super.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index 185246a0d855..d0f08e946453 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -931,20 +931,20 @@ static int bcache_device_init(struct bcache_device *d, unsigned int block_size,
>  	n = BITS_TO_LONGS(d->nr_stripes) * sizeof(unsigned long);
>  	d->full_dirty_stripes = kvzalloc(n, GFP_KERNEL);
>  	if (!d->full_dirty_stripes)
> -		return -ENOMEM;
> +		goto out_free_stripe_sectors_dirty;
>  
>  	idx = ida_simple_get(&bcache_device_idx, 0,
>  				BCACHE_DEVICE_IDX_MAX, GFP_KERNEL);
>  	if (idx < 0)
> -		return idx;
> +		goto out_free_full_dirty_stripes;
>  
>  	if (bioset_init(&d->bio_split, 4, offsetof(struct bbio, bio),
>  			BIOSET_NEED_BVECS|BIOSET_NEED_RESCUER))
> -		goto err;
> +		goto out_ida_remove;
>  
>  	d->disk = blk_alloc_disk(NUMA_NO_NODE);
>  	if (!d->disk)
> -		goto err;
> +		goto out_bioset_exit;
>  
>  	set_capacity(d->disk, sectors);
>  	snprintf(d->disk->disk_name, DISK_NAME_LEN, "bcache%i", idx);
> @@ -987,8 +987,14 @@ static int bcache_device_init(struct bcache_device *d, unsigned int block_size,
>  
>  	return 0;
>  
> -err:
> +out_bioset_exit:
> +	bioset_exit(&d->bio_split);
> +out_ida_remove:
>  	ida_simple_remove(&bcache_device_idx, idx);
> +out_free_full_dirty_stripes:
> +	kvfree(d->full_dirty_stripes);
> +out_free_stripe_sectors_dirty:
> +	kvfree(d->stripe_sectors_dirty);
>  	return -ENOMEM;
>  
>  }


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
