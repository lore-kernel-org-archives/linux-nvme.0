Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF49C48BF8
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Feb 2024 22:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G2SusDOlkkZCINXkEP6RVbB2J47VRPBecZ6j24NRkMs=; b=mfBa1LxCKwSrN70k0499FKP18t
	JwbXfgMBagsX786UUzsKrecPiyL98uR8ZXEYbR3nKgGW29ibmyIup/CI+2OTkKxIQ0Fo1p45svyDa
	Xfie+u83eUhx3r2ILhUKLqDnxdaatqiObVUpj4PpIoaKn+XK7HRzQ1MrpyNSUo5koyr4sqyIQ7TuQ
	CGjarZJvewaIYsGbv1AEi+MDf24WSO2YoCI+fisW8C5/jnE5/1AFDjlMaxC8o3YPg1wW9h92cCoRK
	eNJA/23hLbfZQOpuIr7+aKq4C6ZH54LSlmmIQRd92aYrz+IL3DGUrQmGW6nTnFnLT1TclHcQ0GRl1
	8rWhSwHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcCb0-0000000CVVy-1Tay;
	Mon, 19 Feb 2024 22:58:46 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcCax-0000000CVVT-2uLL
	for linux-nvme@lists.infradead.org;
	Mon, 19 Feb 2024 22:58:44 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6e08dd0fa0bso4118974b3a.1
        for <linux-nvme@lists.infradead.org>; Mon, 19 Feb 2024 14:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1708383522; x=1708988322; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G2SusDOlkkZCINXkEP6RVbB2J47VRPBecZ6j24NRkMs=;
        b=CTOEei2QLj85KpGlhSnVR3X/FezDeacs82om9sGT/72b0PpwtsgcD/udlC1w0vK7lv
         GUy1EBZutg2jrjiS9hOAtoxBxBv+3umREcc3Nf7LZKVVnoQ37R7Ubsmckq/u8FV0cPXR
         3WcSLQMZI0G6/rPdwFz3x3vMt8+LWoyJRczPXd+8orHtZX/cMctEbzAszNF2/Umn+dv0
         nTs8IhyzxtVCS6+8USf4WxwBUtpYaRJRA/twLHBxBs1jsd3sfWET+u8wCS2j0tjbomoe
         rGIAiKMbOBWhe+owK7ob/3c+PGHRtOu7JgTxSW32p2zPo7qf8npDa0GxPdaumplKuidR
         qbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708383522; x=1708988322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2SusDOlkkZCINXkEP6RVbB2J47VRPBecZ6j24NRkMs=;
        b=Lzylb8BxEsS/Fz5LpntU8Lo32bQFBaaj5XG8h7PVxuUQ/7qjxKfT/UDXD8vE2uFgOl
         FLNj2m80mLYXs7vwZ1v07uA/6WMndhDg3T/KqVRS1HwYr5Xle2AePFpdTOzCNLH0cTze
         RH7tPPbC/LjGOXlrX6MB2EIBCoSChBiymdm+tEtYNPQy+x9tpeHfR2ErAWdrQbUYN+nN
         eJnIUEvqQF8hthXTa7d57rzs+2yVlzT1r/5QCWkxu0tYgXTLfGeHrmVIE8heofiR3Bdm
         Z8rIVN5TiDumjtRZO9jGErK28op0wxETmnI31YxHX2hNX+1Gc/BV2U9zBLDUIPgdoX56
         IqXg==
X-Forwarded-Encrypted: i=1; AJvYcCXCsMYf6t0TX4uIAbyp8O6SnpbLxmRqWDe+73I3cnRJfRoyZ9Do05fBmTMSao1it9uQQfK+KamZ6x/GISLbAGLA5VYgS45Ij01g8/B8VYk=
X-Gm-Message-State: AOJu0YwsEqnQ11nV7R5/3d74ZciKpemGYk5h2I+1k9ZKVhDTHU28xJP6
	wJlATY8/kU9HNuY+PiQ6G8DX75hUN7ciWLGWYwB4yyfoqnvgVa0Q94ULbjTBCHA=
X-Google-Smtp-Source: AGHT+IHlfzy+s9i3qKJWzkHasWDQ5Dp8s/ZMPkMUlAlAKBlL38U+vY5Udn0W8KhJ2rlPYO9vcrxajg==
X-Received: by 2002:a05:6a00:198f:b0:6e4:74d7:a732 with SMTP id d15-20020a056a00198f00b006e474d7a732mr2108349pfl.11.1708383522593;
        Mon, 19 Feb 2024 14:58:42 -0800 (PST)
Received: from dread.disaster.area (pa49-181-247-196.pa.nsw.optusnet.com.au. [49.181.247.196])
        by smtp.gmail.com with ESMTPSA id e8-20020a62ee08000000b006e02da39dbcsm3319334pfi.10.2024.02.19.14.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 14:58:42 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rcCat-008oe1-1J;
	Tue, 20 Feb 2024 09:58:39 +1100
Date: Tue, 20 Feb 2024 09:58:39 +1100
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com,
	linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
	io-uring@vger.kernel.org, nilay@linux.ibm.com,
	ritesh.list@gmail.com
Subject: Re: [PATCH v4 05/11] block: Add core atomic write support
Message-ID: <ZdPdHzNAVb5hqlkY@dread.disaster.area>
References: <20240219130109.341523-1-john.g.garry@oracle.com>
 <20240219130109.341523-6-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219130109.341523-6-john.g.garry@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240219_145843_766508_FD9FEFAA 
X-CRM114-Status: GOOD (  29.02  )
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

On Mon, Feb 19, 2024 at 01:01:03PM +0000, John Garry wrote:
> Add atomic write support as follows:
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 74e9e775f13d..12a75a252ca2 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -18,6 +18,42 @@
>  #include "blk-rq-qos.h"
>  #include "blk-throttle.h"
>  
> +static bool rq_straddles_atomic_write_boundary(struct request *rq,
> +					unsigned int front,
> +					unsigned int back)
> +{
> +	unsigned int boundary = queue_atomic_write_boundary_bytes(rq->q);
> +	unsigned int mask, imask;
> +	loff_t start, end;
> +
> +	if (!boundary)
> +		return false;
> +
> +	start = rq->__sector << SECTOR_SHIFT;
> +	end = start + rq->__data_len;
> +
> +	start -= front;
> +	end += back;
> +
> +	/* We're longer than the boundary, so must be crossing it */
> +	if (end - start > boundary)
> +		return true;
> +
> +	mask = boundary - 1;
> +
> +	/* start/end are boundary-aligned, so cannot be crossing */
> +	if (!(start & mask) || !(end & mask))
> +		return false;
> +
> +	imask = ~mask;
> +
> +	/* Top bits are different, so crossed a boundary */
> +	if ((start & imask) != (end & imask))
> +		return true;
> +
> +	return false;
> +}

I have no way of verifying this function is doing what it is
supposed to because it's function is undocumented. I have no idea
what the front/back variables are supposed to represent, and so no
clue if they are being applied properly.

That said, it's also applying unsigned 32 bit mask variables to
signed 64 bit quantities and trying to do things like "high bit changed"
checks on the 64 bit variable. This just smells like a future
source of "large offsets don't work like we expected!" bugs.

> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 06ea91e51b8b..176f26374abc 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -59,6 +59,13 @@ void blk_set_default_limits(struct queue_limits *lim)
>  	lim->zoned = false;
>  	lim->zone_write_granularity = 0;
>  	lim->dma_alignment = 511;
> +	lim->atomic_write_hw_max_sectors = 0;
> +	lim->atomic_write_max_sectors = 0;
> +	lim->atomic_write_hw_boundary_sectors = 0;
> +	lim->atomic_write_hw_unit_min_sectors = 0;
> +	lim->atomic_write_unit_min_sectors = 0;
> +	lim->atomic_write_hw_unit_max_sectors = 0;
> +	lim->atomic_write_unit_max_sectors = 0;
>  }

Seems to me this function would do better to just

	memset(lim, 0, sizeof(*lim));

and then set all the non-zero fields.

>  
>  /**
> @@ -101,6 +108,44 @@ void blk_queue_bounce_limit(struct request_queue *q, enum blk_bounce bounce)
>  }
>  EXPORT_SYMBOL(blk_queue_bounce_limit);
>  
> +
> +/*
> + * Returns max guaranteed sectors which we can fit in a bio. For convenience of
> + * users, rounddown_pow_of_two() the return value.
> + *
> + * We always assume that we can fit in at least PAGE_SIZE in a segment, apart
> + * from first and last segments.
> + */
> +static unsigned int blk_queue_max_guaranteed_bio_sectors(
> +					struct queue_limits *limits,
> +					struct request_queue *q)
> +{
> +	unsigned int max_segments = min(BIO_MAX_VECS, limits->max_segments);
> +	unsigned int length;
> +
> +	length = min(max_segments, 2) * queue_logical_block_size(q);
> +	if (max_segments > 2)
> +		length += (max_segments - 2) * PAGE_SIZE;
> +
> +	return rounddown_pow_of_two(length >> SECTOR_SHIFT);
> +}
> +
> +static void blk_atomic_writes_update_limits(struct request_queue *q)
> +{
> +	struct queue_limits *limits = &q->limits;
> +	unsigned int max_hw_sectors =
> +		rounddown_pow_of_two(limits->max_hw_sectors);
> +	unsigned int unit_limit = min(max_hw_sectors,
> +		blk_queue_max_guaranteed_bio_sectors(limits, q));
> +
> +	limits->atomic_write_max_sectors =
> +		min(limits->atomic_write_hw_max_sectors, max_hw_sectors);
> +	limits->atomic_write_unit_min_sectors =
> +		min(limits->atomic_write_hw_unit_min_sectors, unit_limit);
> +	limits->atomic_write_unit_max_sectors =
> +		min(limits->atomic_write_hw_unit_max_sectors, unit_limit);
> +}
> +
>  /**
>   * blk_queue_max_hw_sectors - set max sectors for a request for this queue
>   * @q:  the request queue for the device
> @@ -145,6 +190,8 @@ void blk_queue_max_hw_sectors(struct request_queue *q, unsigned int max_hw_secto
>  				 limits->logical_block_size >> SECTOR_SHIFT);
>  	limits->max_sectors = max_sectors;
>  
> +	blk_atomic_writes_update_limits(q);
> +
>  	if (!q->disk)
>  		return;
>  	q->disk->bdi->io_pages = max_sectors >> (PAGE_SHIFT - 9);
> @@ -182,6 +229,62 @@ void blk_queue_max_discard_sectors(struct request_queue *q,
>  }
>  EXPORT_SYMBOL(blk_queue_max_discard_sectors);
>  
> +/**
> + * blk_queue_atomic_write_max_bytes - set max bytes supported by
> + * the device for atomic write operations.
> + * @q:  the request queue for the device
> + * @bytes: maximum bytes supported
> + */
> +void blk_queue_atomic_write_max_bytes(struct request_queue *q,
> +				      unsigned int bytes)
> +{
> +	q->limits.atomic_write_hw_max_sectors = bytes >> SECTOR_SHIFT;
> +	blk_atomic_writes_update_limits(q);
> +}
> +EXPORT_SYMBOL(blk_queue_atomic_write_max_bytes);

Ok, so this can silently set a limit that is different to what the
caller asked to have set?

How is the caller supposed to find this out if the smaller limit
that was set is not compatible with their configuration?

i.e. shouldn't this return an error if the requested size cannot
be set exactly as specified?

Same concern about the other limits that can be trimmed to be
smaller than requested.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

