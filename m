Return-Path: <SRS0=ZvdC=KH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FFAC433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 22:03:59 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 186B0613C9
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 22:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 186B0613C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=77RjfDDdp12e/gD2u8eSf6bosMoNsy2xKrj812yZPTw=; b=WGr+mgF6US8lDVZYVxJ5GKGhr
	n/7auJ+0OiUIM9iy75NnEuE6XPB1j6ecojzNoAHh8vtACx4hR9fCQT427gFax4tV5ZqCd7iYa0jce
	OetsZPYxPLM/7doltZPO89YobhYqGbzM2bArEXB0/l3qECoEgO3/FG+dk2WZ4iS/107SBIOP55nxC
	cFkyHy5slc3FhCZWZLRyYVT6GwsJBeIPXHWtcPFMwegkhZPT90HgX/vL01geCi/8yhuNFNjBL+G7n
	olZPr2ZKg7cTMQejJpLIDqYUXcD6N0JQJfNV8o2h5uV169by2yBficqqc3rojZJ2ALhXyjwY+LkMX
	vsARAqrog==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgwxM-0047c4-UY; Wed, 12 May 2021 22:03:53 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgwxJ-0047bo-2x
 for linux-nvme@desiato.infradead.org; Wed, 12 May 2021 22:03:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=BQiroiLIHgZFOWm5Zo2PHMPKmz+9UyKwhGqacEm+ENY=; b=Z8g35mOPqY9otm7r8+uAzRvWl0
 eABzVhyB8TbZQmOXccbOcWV+oqhb9M64REfP11m+xpWDv3vpOKUX5yAw0FQbrxEOsCUuTNOynmIyZ
 1Ed3xz+pdemkrHkaJShNtR3KxLlYxoItJerk0wGt1AfVM1+Ng8db87kg+QKCfiL9+V1DR3CxbkTLM
 PrSGZGtk3F2mM69VkHfG9kLYLEfJdmAS7NEkFClUQM/s+IzJzP3VrtEHViCTTRzQsD2cA92sdFEsY
 yC4TC3jMPgwpgBC04XAHDvqZuBhUh1wafneG5oK33EpsBQfSkIjKsUDmis0yiyz+0hh19+lPi2ALK
 mlzi15Pw==;
Received: from mail-qk1-f175.google.com ([209.85.222.175])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgwxF-00ArJn-Gk
 for linux-nvme@lists.infradead.org; Wed, 12 May 2021 22:03:47 +0000
Received: by mail-qk1-f175.google.com with SMTP id o27so23810642qkj.9
 for <linux-nvme@lists.infradead.org>; Wed, 12 May 2021 15:03:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BQiroiLIHgZFOWm5Zo2PHMPKmz+9UyKwhGqacEm+ENY=;
 b=f/r8IgG5H92Q3zQNVA+gzS49OEkzopmdgnUYICtqoMAm9uS/EgaG+aPm4aHJjPnBQE
 nADj6cJdddruib7jJRlRr+iXyWyCTbo+MwS10EYLTHJgEFUfjOvTJoXzo4vxzsOu/R5f
 d3rh9JR891r3YwqKjq9Q1yBD+FjmJY/aS438CywUnP7jqQeRe4tXrgp7hZVbs3yJMo9L
 BTzMros0PBFZYigTHS8ZZrETZRG10m5a9Pse7TukJQT72WDlYOEvkK3kCdhJuMplGTRw
 6ebDoFvynQ+/F+QmaI1IOT2OGFiBeTZPLjFHnwerCDqqgrqhxvxP3dK2bBIdtcquW+cz
 sHXg==
X-Gm-Message-State: AOAM5313ztIKOQJM3eryvYNd/ifY11naypsPwLlfppIYqkl0NQIE9my2
 QI8Lgk7s7GZk7guT+OEr5SbLmDyJi4Y=
X-Google-Smtp-Source: ABdhPJybFyUbWUSsgNF51ig/HH+IlS97Arpsqsszcgg74v2hmFeBy+BB6V5Nn94qI0FXyw/k0uWzWg==
X-Received: by 2002:a37:ac17:: with SMTP id e23mr36147397qkm.184.1620857023232; 
 Wed, 12 May 2021 15:03:43 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:c65a:d038:3389:f848?
 ([2600:1700:65a0:78e0:c65a:d038:3389:f848])
 by smtp.gmail.com with ESMTPSA id j25sm997283qka.116.2021.05.12.15.03.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 May 2021 15:03:42 -0700 (PDT)
Subject: Re: [PATCH 12/15] block: switch polling to be bio based
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20210512131545.495160-1-hch@lst.de>
 <20210512131545.495160-13-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <45d66945-165c-ae48-69f4-75dc553b0386@grimberg.me>
Date: Wed, 12 May 2021 15:03:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210512131545.495160-13-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210512_150345_598697_52FD6CE3 
X-CRM114-Status: GOOD (  43.55  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 5/12/21 6:15 AM, Christoph Hellwig wrote:
> Replace the blk_poll interface that requires the caller to keep a queue
> and cookie from the submissions with polling based on the bio.
> 
> Polling for the bio itself leads to a few advantages:
> 
>   - the cookie construction can made entirely private in blk-mq.c
>   - the caller does not need to remember the request_queue and cookie
>     separately and thus sidesteps their lifetime issues
>   - keeping the device and the cookie inside the bio allows to trivially
>     support polling BIOs remapping by stacking drivers
>   - a lot of code to propagate the cookie back up the submission path can
>     be removed entirely.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/m68k/emu/nfblock.c             |   3 +-
>   arch/xtensa/platforms/iss/simdisk.c |   3 +-
>   block/bio.c                         |   1 +
>   block/blk-core.c                    | 120 +++++++++++++++++++++-------
>   block/blk-mq.c                      |  73 ++++++-----------
>   block/blk-mq.h                      |   2 +
>   drivers/block/brd.c                 |  12 ++-
>   drivers/block/drbd/drbd_int.h       |   2 +-
>   drivers/block/drbd/drbd_req.c       |   3 +-
>   drivers/block/n64cart.c             |  12 ++-
>   drivers/block/null_blk/main.c       |   3 +-
>   drivers/block/pktcdvd.c             |   7 +-
>   drivers/block/ps3vram.c             |   6 +-
>   drivers/block/rsxx/dev.c            |   7 +-
>   drivers/block/zram/zram_drv.c       |  10 +--
>   drivers/lightnvm/pblk-init.c        |   6 +-
>   drivers/md/bcache/request.c         |  13 ++-
>   drivers/md/bcache/request.h         |   4 +-
>   drivers/md/dm.c                     |  28 +++----
>   drivers/md/md.c                     |  10 +--
>   drivers/nvdimm/blk.c                |   5 +-
>   drivers/nvdimm/btt.c                |   5 +-
>   drivers/nvdimm/pmem.c               |   3 +-
>   drivers/nvme/host/core.c            |   2 +-
>   drivers/nvme/host/multipath.c       |   6 +-
>   drivers/s390/block/dcssblk.c        |   7 +-
>   drivers/s390/block/xpram.c          |   5 +-
>   fs/block_dev.c                      |  25 ++----
>   fs/btrfs/inode.c                    |   8 +-
>   fs/ext4/file.c                      |   2 +-
>   fs/gfs2/file.c                      |   4 +-
>   fs/iomap/direct-io.c                |  39 +++------
>   fs/xfs/xfs_file.c                   |   2 +-
>   fs/zonefs/super.c                   |   2 +-
>   include/linux/bio.h                 |   2 +-
>   include/linux/blk-mq.h              |  15 +---
>   include/linux/blk_types.h           |  12 ++-
>   include/linux/blkdev.h              |   8 +-
>   include/linux/fs.h                  |   6 +-
>   include/linux/iomap.h               |   3 +-
>   mm/page_io.c                        |   8 +-
>   41 files changed, 223 insertions(+), 271 deletions(-)
> 
> diff --git a/arch/m68k/emu/nfblock.c b/arch/m68k/emu/nfblock.c
> index ba808543161a..dd36808f0d5e 100644
> --- a/arch/m68k/emu/nfblock.c
> +++ b/arch/m68k/emu/nfblock.c
> @@ -59,7 +59,7 @@ struct nfhd_device {
>   	struct gendisk *disk;
>   };
>   
> -static blk_qc_t nfhd_submit_bio(struct bio *bio)
> +static void nfhd_submit_bio(struct bio *bio)
>   {
>   	struct nfhd_device *dev = bio->bi_bdev->bd_disk->private_data;
>   	struct bio_vec bvec;
> @@ -77,7 +77,6 @@ static blk_qc_t nfhd_submit_bio(struct bio *bio)
>   		sec += len;
>   	}
>   	bio_endio(bio);
> -	return BLK_QC_T_NONE;
>   }
>   
>   static int nfhd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
> diff --git a/arch/xtensa/platforms/iss/simdisk.c b/arch/xtensa/platforms/iss/simdisk.c
> index fc09be7b1347..182825d639e2 100644
> --- a/arch/xtensa/platforms/iss/simdisk.c
> +++ b/arch/xtensa/platforms/iss/simdisk.c
> @@ -101,7 +101,7 @@ static void simdisk_transfer(struct simdisk *dev, unsigned long sector,
>   	spin_unlock(&dev->lock);
>   }
>   
> -static blk_qc_t simdisk_submit_bio(struct bio *bio)
> +static void simdisk_submit_bio(struct bio *bio)
>   {
>   	struct simdisk *dev = bio->bi_bdev->bd_disk->private_data;
>   	struct bio_vec bvec;
> @@ -119,7 +119,6 @@ static blk_qc_t simdisk_submit_bio(struct bio *bio)
>   	}
>   
>   	bio_endio(bio);
> -	return BLK_QC_T_NONE;
>   }
>   
>   static int simdisk_open(struct block_device *bdev, fmode_t mode)
> diff --git a/block/bio.c b/block/bio.c
> index de5505d7018e..986908cc99d4 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -250,6 +250,7 @@ void bio_init(struct bio *bio, struct bio_vec *table,
>   	memset(bio, 0, sizeof(*bio));
>   	atomic_set(&bio->__bi_remaining, 1);
>   	atomic_set(&bio->__bi_cnt, 1);
> +	bio->bi_cookie = BLK_QC_T_NONE;
>   
>   	bio->bi_io_vec = table;
>   	bio->bi_max_vecs = max_vecs;
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 94a817532472..c024cba98195 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -910,18 +910,18 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
>   	return false;
>   }
>   
> -static blk_qc_t __submit_bio(struct bio *bio)
> +static void __submit_bio(struct bio *bio)
>   {
>   	struct gendisk *disk = bio->bi_bdev->bd_disk;
> -	blk_qc_t ret = BLK_QC_T_NONE;
>   
>   	if (blk_crypto_bio_prep(&bio)) {
> -		if (!disk->fops->submit_bio)
> -			return blk_mq_submit_bio(bio);
> -		ret = disk->fops->submit_bio(bio);
> +		if (!disk->fops->submit_bio) {
> +			blk_mq_submit_bio(bio);
> +			return;
> +		}
> +		disk->fops->submit_bio(bio);
>   	}
>   	blk_queue_exit(disk->queue);
> -	return ret;
>   }
>   
>   /*
> @@ -943,10 +943,9 @@ static blk_qc_t __submit_bio(struct bio *bio)
>    * bio_list_on_stack[1] contains bios that were submitted before the current
>    *	->submit_bio_bio, but that haven't been processed yet.
>    */
> -static blk_qc_t __submit_bio_noacct(struct bio *bio)
> +static void __submit_bio_noacct(struct bio *bio)
>   {
>   	struct bio_list bio_list_on_stack[2];
> -	blk_qc_t ret = BLK_QC_T_NONE;
>   
>   	BUG_ON(bio->bi_next);
>   
> @@ -966,7 +965,7 @@ static blk_qc_t __submit_bio_noacct(struct bio *bio)
>   		bio_list_on_stack[1] = bio_list_on_stack[0];
>   		bio_list_init(&bio_list_on_stack[0]);
>   
> -		ret = __submit_bio(bio);
> +		__submit_bio(bio);
>   
>   		/*
>   		 * Sort new bios into those for a lower level and those for the
> @@ -989,13 +988,11 @@ static blk_qc_t __submit_bio_noacct(struct bio *bio)
>   	} while ((bio = bio_list_pop(&bio_list_on_stack[0])));
>   
>   	current->bio_list = NULL;
> -	return ret;
>   }
>   
> -static blk_qc_t __submit_bio_noacct_mq(struct bio *bio)
> +static void __submit_bio_noacct_mq(struct bio *bio)
>   {
>   	struct bio_list bio_list[2] = { };
> -	blk_qc_t ret = BLK_QC_T_NONE;
>   
>   	current->bio_list = bio_list;
>   
> @@ -1007,15 +1004,13 @@ static blk_qc_t __submit_bio_noacct_mq(struct bio *bio)
>   
>   		if (!blk_crypto_bio_prep(&bio)) {
>   			blk_queue_exit(disk->queue);
> -			ret = BLK_QC_T_NONE;
>   			continue;
>   		}
>   
> -		ret = blk_mq_submit_bio(bio);
> +		blk_mq_submit_bio(bio);
>   	} while ((bio = bio_list_pop(&bio_list[0])));
>   
>   	current->bio_list = NULL;
> -	return ret;
>   }
>   
>   /**
> @@ -1027,10 +1022,10 @@ static blk_qc_t __submit_bio_noacct_mq(struct bio *bio)
>    * systems and other upper level users of the block layer should use
>    * submit_bio() instead.
>    */
> -blk_qc_t submit_bio_noacct(struct bio *bio)
> +void submit_bio_noacct(struct bio *bio)
>   {
>   	if (!submit_bio_checks(bio))
> -		return BLK_QC_T_NONE;
> +		return;
>   
>   	/*
>   	 * We only want one ->submit_bio to be active at a time, else stack
> @@ -1038,14 +1033,12 @@ blk_qc_t submit_bio_noacct(struct bio *bio)
>   	 * to collect a list of requests submited by a ->submit_bio method while
>   	 * it is active, and then process them after it returned.
>   	 */
> -	if (current->bio_list) {
> +	if (current->bio_list)
>   		bio_list_add(&current->bio_list[0], bio);
> -		return BLK_QC_T_NONE;
> -	}
> -
> -	if (!bio->bi_bdev->bd_disk->fops->submit_bio)
> -		return __submit_bio_noacct_mq(bio);
> -	return __submit_bio_noacct(bio);
> +	else if (!bio->bi_bdev->bd_disk->fops->submit_bio)
> +		__submit_bio_noacct_mq(bio);
> +	else
> +		__submit_bio_noacct(bio);
>   }
>   EXPORT_SYMBOL(submit_bio_noacct);
>   
> @@ -1062,10 +1055,10 @@ EXPORT_SYMBOL(submit_bio_noacct);
>    * in @bio.  The bio must NOT be touched by thecaller until ->bi_end_io() has
>    * been called.
>    */
> -blk_qc_t submit_bio(struct bio *bio)
> +void submit_bio(struct bio *bio)
>   {
>   	if (blkcg_punt_bio_submit(bio))
> -		return BLK_QC_T_NONE;
> +		return;
>   
>   	/*
>   	 * If it's a regular read/write or a barrier with data attached,
> @@ -1097,19 +1090,84 @@ blk_qc_t submit_bio(struct bio *bio)
>   	if (unlikely(bio_op(bio) == REQ_OP_READ &&
>   	    bio_flagged(bio, BIO_WORKINGSET))) {
>   		unsigned long pflags;
> -		blk_qc_t ret;
>   
>   		psi_memstall_enter(&pflags);
> -		ret = submit_bio_noacct(bio);
> +		submit_bio_noacct(bio);
>   		psi_memstall_leave(&pflags);
> -
> -		return ret;
> +		return;
>   	}
>   
> -	return submit_bio_noacct(bio);
> +	submit_bio_noacct(bio);
>   }
>   EXPORT_SYMBOL(submit_bio);
>   
> +/**
> + * bio_poll - poll for BIO completions
> + * @bio: bio to poll for
> + * @flags: BLK_POLL_* flags that control the behavior
> + *
> + * Poll for completions on queue associated with the bio. Returns number of
> + * completed entries found.
> + *
> + * Note: the caller must either be the context that submitted @bio, or
> + * be in a RCU critical section to prevent freeing of @bio.
> + */
> +int bio_poll(struct bio *bio, unsigned int flags)
> +{
> +	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
> +	blk_qc_t cookie = READ_ONCE(bio->bi_cookie);
> +
> +	if (cookie == BLK_QC_T_NONE ||
> +	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
> +		return 0;
> +
> +	if (current->plug)
> +		blk_flush_plug_list(current->plug, false);
> +
> +	/* not yet implemented, so this should not happen */
> +	if (WARN_ON_ONCE(!queue_is_mq(q)))

What happens if the I/O wasn't (yet) queued to the bottom device
(i.e. no available path in nvme-mpath)?

In this case the disk would be the mpath device node (which is
not mq...)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
