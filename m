Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3EB4C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Feb 2022 14:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iHftRf/7i/XmxskSM/K/WPxANSIYGKixjpKz8MmDajM=; b=DhxD2mXTfMIJaIoqqWwFC+a/DR
	pPT49zFIilpna1NsVWIJ1Y0+t1S5u/dqnMd9MDgnGshJkb18d6NW59rbf+VNXsIfu+xvzSNU/tjH1
	9gajXnWyTtvCacep1IhnQpMgmDfux57L5/UmQKUp/WAoUGzD/Xvk//+bQUdKdZBCt7NsE52nDi0Mu
	V2BYvlYv1/CJw4q4T24NAOHPakzh5Vzl0CtDo1jGhhgjcsWzBDous6zpgAfMj3sXUIrDPkKZ/jZe2
	96h0fKCWgvP6hx59SHjrac7Q/LKzUHUj2PAuNwjJSbKcQjJWBuZX9l1MJyW2xfDNhYJIdqVUlPxqv
	41EYwppA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKhZo-00AwNo-14; Thu, 17 Feb 2022 14:16:08 +0000
Received: from mail-pl1-f173.google.com ([209.85.214.173])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKckm-009fCF-6l
 for linux-nvme@lists.infradead.org; Thu, 17 Feb 2022 09:07:09 +0000
Received: by mail-pl1-f173.google.com with SMTP id x4so4132628plb.4
 for <linux-nvme@lists.infradead.org>; Thu, 17 Feb 2022 01:07:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iHftRf/7i/XmxskSM/K/WPxANSIYGKixjpKz8MmDajM=;
 b=4wRIQU4nuleMGh8NbVyawhVnZ1GJVsAJTWe0DyB32wkDpJmy9FQn5prEp/p7Qhqaij
 /1s9huhbpcaPWyNB42bB/nzBlvKZUvBwDdPZz/+jV+3cPo8pVTfdGN7AwSPPQQ9CbT18
 fVENsesrkZyHgwneYEKglQVPwQ/S1Z1nuMFhZbEZ4NbkWcsjZALqbJDTk9B9ZdHBZvXz
 ZFGt5XWi4bLJUwsQ6Fn6q10KcFsibTgY4n5/+UVAVzu/qE35xtRx2+ZSkX1i6cdbxbww
 7lzzxvJpDvqjmHY1x/HE0WUVTtdvAtqLiLJCfLHMpL+Rt0VGFKscL/UUzD9u2pX9De9i
 H5HQ==
X-Gm-Message-State: AOAM533jbY3vJqcRVuwWQm+80heTBIJP+eHYJNj12/+TsrQCMT2lQzhq
 D7bxZXCmy/S2V8P4zWwmFu8=
X-Google-Smtp-Source: ABdhPJxA+Rn13F9gCou6v9WFyZVsRSarvAMjLejSWsOqgAvmd/WPGnRZiUrXO0c5nvf+XVq5Joo3eQ==
X-Received: by 2002:a17:903:1c4:b0:14e:def5:e6bb with SMTP id
 e4-20020a17090301c400b0014edef5e6bbmr2015834plh.154.1645088823823; 
 Thu, 17 Feb 2022 01:07:03 -0800 (PST)
Received: from garbanzo (136-24-173-63.cab.webpass.net. [136.24.173.63])
 by smtp.gmail.com with ESMTPSA id n37sm7970590pgl.48.2022.02.17.01.07.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Feb 2022 01:07:03 -0800 (PST)
Date: Thu, 17 Feb 2022 01:07:00 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Nitesh Shetty <nj.shetty@samsung.com>, hch@lst.de
Cc: javier@javigon.com, chaitanyak@nvidia.com, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, dm-devel@redhat.com,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 axboe@kernel.dk, msnitzer@redhat.com, bvanassche@acm.org,
 martin.petersen@oracle.com, hare@suse.de, kbusch@kernel.org,
 Frederick.Knight@netapp.com, osandov@fb.com,
 lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
 josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
 jack@suse.com, joshi.k@samsung.com, arnav.dawn@samsung.com,
 nitheshshetty@gmail.com, SelvaKumar S <selvakuma.s1@samsung.com>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/10] block: Introduce queue limits for copy-offload
 support
Message-ID: <20220217090700.b7n33vbkx5s4qbfq@garbanzo>
References: <20220214080002.18381-1-nj.shetty@samsung.com>
 <CGME20220214080605epcas5p16868dae515a6355cf9fecf22df4f3c3d@epcas5p1.samsung.com>
 <20220214080002.18381-3-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214080002.18381-3-nj.shetty@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220217_010708_281840_93C121DA 
X-CRM114-Status: GOOD (  23.33  )
X-Mailman-Approved-At: Thu, 17 Feb 2022 06:00:23 -0800
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

The subject says limits for copy-offload...

On Mon, Feb 14, 2022 at 01:29:52PM +0530, Nitesh Shetty wrote:
> Add device limits as sysfs entries,
>         - copy_offload (RW)
>         - copy_max_bytes (RW)
>         - copy_max_hw_bytes (RO)
>         - copy_max_range_bytes (RW)
>         - copy_max_range_hw_bytes (RO)
>         - copy_max_nr_ranges (RW)
>         - copy_max_nr_ranges_hw (RO)

Some of these seem like generic... and also I see a few more max_hw ones
not listed above...

> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> +/**
> + * blk_queue_max_copy_sectors - set max sectors for a single copy payload
> + * @q:  the request queue for the device
> + * @max_copy_sectors: maximum number of sectors to copy
> + **/
> +void blk_queue_max_copy_sectors(struct request_queue *q,
> +		unsigned int max_copy_sectors)
> +{
> +	q->limits.max_hw_copy_sectors = max_copy_sectors;
> +	q->limits.max_copy_sectors = max_copy_sectors;
> +}
> +EXPORT_SYMBOL(blk_queue_max_copy_sectors);

Please use EXPORT_SYMBOL_GPL() for all new things.

Why is this setting both? The documentation does't seem to say.
What's the point?

> +
> +/**
> + * blk_queue_max_copy_range_sectors - set max sectors for a single range, in a copy payload
> + * @q:  the request queue for the device
> + * @max_copy_range_sectors: maximum number of sectors to copy in a single range
> + **/
> +void blk_queue_max_copy_range_sectors(struct request_queue *q,
> +		unsigned int max_copy_range_sectors)
> +{
> +	q->limits.max_hw_copy_range_sectors = max_copy_range_sectors;
> +	q->limits.max_copy_range_sectors = max_copy_range_sectors;
> +}
> +EXPORT_SYMBOL(blk_queue_max_copy_range_sectors);

Same here.

> +/**
> + * blk_queue_max_copy_nr_ranges - set max number of ranges, in a copy payload
> + * @q:  the request queue for the device
> + * @max_copy_nr_ranges: maximum number of ranges
> + **/
> +void blk_queue_max_copy_nr_ranges(struct request_queue *q,
> +		unsigned int max_copy_nr_ranges)
> +{
> +	q->limits.max_hw_copy_nr_ranges = max_copy_nr_ranges;
> +	q->limits.max_copy_nr_ranges = max_copy_nr_ranges;
> +}
> +EXPORT_SYMBOL(blk_queue_max_copy_nr_ranges);

Same.

> +
>  /**
>   * blk_queue_max_write_same_sectors - set max sectors for a single write same
>   * @q:  the request queue for the device
> @@ -541,6 +592,14 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
>  	t->max_segment_size = min_not_zero(t->max_segment_size,
>  					   b->max_segment_size);
>  
> +	t->max_copy_sectors = min(t->max_copy_sectors, b->max_copy_sectors);
> +	t->max_hw_copy_sectors = min(t->max_hw_copy_sectors, b->max_hw_copy_sectors);
> +	t->max_copy_range_sectors = min(t->max_copy_range_sectors, b->max_copy_range_sectors);
> +	t->max_hw_copy_range_sectors = min(t->max_hw_copy_range_sectors,
> +						b->max_hw_copy_range_sectors);
> +	t->max_copy_nr_ranges = min(t->max_copy_nr_ranges, b->max_copy_nr_ranges);
> +	t->max_hw_copy_nr_ranges = min(t->max_hw_copy_nr_ranges, b->max_hw_copy_nr_ranges);
> +
>  	t->misaligned |= b->misaligned;
>  
>  	alignment = queue_limit_alignment_offset(b, start);
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 9f32882ceb2f..9ddd07f142d9 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -212,6 +212,129 @@ static ssize_t queue_discard_zeroes_data_show(struct request_queue *q, char *pag
>  	return queue_var_show(0, page);
>  }
>  
> +static ssize_t queue_copy_offload_show(struct request_queue *q, char *page)
> +{
> +	return queue_var_show(blk_queue_copy(q), page);
> +}
> +
> +static ssize_t queue_copy_offload_store(struct request_queue *q,
> +				       const char *page, size_t count)
> +{
> +	unsigned long copy_offload;
> +	ssize_t ret = queue_var_store(&copy_offload, page, count);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	if (copy_offload && !q->limits.max_hw_copy_sectors)
> +		return -EINVAL;


If the kernel schedules, copy_offload may still be true and
max_hw_copy_sectors may be set to 0. Is that an issue?

> +
> +	if (copy_offload)
> +		blk_queue_flag_set(QUEUE_FLAG_COPY, q);
> +	else
> +		blk_queue_flag_clear(QUEUE_FLAG_COPY, q);

The flag may be set but the queue flag could be set. Is that an issue?

> @@ -597,6 +720,14 @@ QUEUE_RO_ENTRY(queue_nr_zones, "nr_zones");
>  QUEUE_RO_ENTRY(queue_max_open_zones, "max_open_zones");
>  QUEUE_RO_ENTRY(queue_max_active_zones, "max_active_zones");
>  
> +QUEUE_RW_ENTRY(queue_copy_offload, "copy_offload");
> +QUEUE_RO_ENTRY(queue_copy_max_hw, "copy_max_hw_bytes");
> +QUEUE_RW_ENTRY(queue_copy_max, "copy_max_bytes");
> +QUEUE_RO_ENTRY(queue_copy_range_max_hw, "copy_max_range_hw_bytes");
> +QUEUE_RW_ENTRY(queue_copy_range_max, "copy_max_range_bytes");
> +QUEUE_RO_ENTRY(queue_copy_nr_ranges_max_hw, "copy_max_nr_ranges_hw");
> +QUEUE_RW_ENTRY(queue_copy_nr_ranges_max, "copy_max_nr_ranges");

Seems like you need to update Documentation/ABI/stable/sysfs-block.

> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index efed3820cbf7..792e6d556589 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -254,6 +254,13 @@ struct queue_limits {
>  	unsigned int		discard_alignment;
>  	unsigned int		zone_write_granularity;
>  
> +	unsigned long		max_hw_copy_sectors;
> +	unsigned long		max_copy_sectors;
> +	unsigned int		max_hw_copy_range_sectors;
> +	unsigned int		max_copy_range_sectors;
> +	unsigned short		max_hw_copy_nr_ranges;
> +	unsigned short		max_copy_nr_ranges;

Before limits start growing more.. I wonder if we should just
stuff hw offload stuff to its own struct within queue_limits.

Christoph?

  Luis

