Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD8BC433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Feb 2022 07:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6Zr24xya9nhM+CWnh0YYVrMZWFT5JeqROVHOulS15yA=; b=LC+DYxwbYaxAoU/MM7QegYp5Zx
	LJAnQKME7d3uOoa8Pf2iCfBV13fgTMq8sn/iUeIIwQwUemB+EJta858H1XoZjA21Kwa5/JYxcOREi
	vY/6bzo25mikOMxyhzl0L9L3HPZMoAjdcQXHkvp1e/+v/8B1NKfav+b1H4xIHtLNkbc/KrkFQt8Ql
	Fz8Q43MMkQEKEAG7v7DK+6dzxXgn8qJCeWT4Kur1eTnQwP4FqW39FmR6NUPYMsaECpkG9cXltAvH1
	ODnbYnEAaTQak5FP99gMnBXL9oCxwSfFvDg7njoZFfPzxRwh1R3l2Ik48nFidnuw3+7vQMF1gl8OV
	wWgaj4dA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nHKoh-00Cl7h-E9; Tue, 08 Feb 2022 07:21:35 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nHKod-00Cl70-RK
 for linux-nvme@lists.infradead.org; Tue, 08 Feb 2022 07:21:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1644304890; x=1675840890;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=g64yFGZnZtBlZZe3pHAgbpNwncCobKe+4KHoTihhnoo=;
 b=nqLqB76eF/aCJPYsoeEyUajQ2HyMFolbr2Uk3piuHh9erCOCuO63QoMg
 7O4Xdl5kbWRCo1KqP8pVuymmW0ADpaIAhst9+nVeloxqkIgb6L6Nu0IbG
 XxnGoVYhRqOUVjDvdwUmcKC5aJI/GT575C2JRl1U3jMf4sIvZeKfNn6mJ
 qXT1FvU/hE+/7Utm+DymYgKer8D3K5vY+GYM9e3AGoO13vqr1yroCByT5
 gOLMiLowTNnrBL9X9LwIBCCj3Ji9myQ/RTCrzOTkhjReWBKWXFwkFMY/c
 CDkCgh/MctH26/UmXwDzrL/B8XsD2tqeJ2xXOvmY3w7an5j6s9oNKsl/K Q==;
X-IronPort-AV: E=Sophos;i="5.88,352,1635177600"; d="scan'208";a="197212513"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2022 15:21:28 +0800
IronPort-SDR: bXEvq2wKsvWn2UtbUi/B7Y4YSig411WEppWSn3idbIQ1oCdZ4ZDFq4zDpy6n67xm6JUXN4YQyV
 hATYcg6alk4WPmOA3g/bunzkWt9MSwPjaXdfqJwfIbuB1SaJSIa/l7cnNXSZNj4xLuke5yr2lP
 541SPabgF10ozyAjJGy61bBKZerwsC5qxEWEJVh6LLwS7cA7BA+mb5dLtpobqYDzRszDMpjkWQ
 9k9VeCIY+EVvQ18Q4DwFcYG/b2/yJUG7nv0Ly5jG1BMmHv9dAg10ev845Ofdj7ZmPkwYcFn7n3
 H0ev0CNyAON/Rg6BwiyfnGy9
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2022 22:54:30 -0800
IronPort-SDR: d24aLXmgK/OWfPbPAQzFEKaRyVsSDmANj45y02Zq/B5CLLJbuB8DXglr9L1NBfAut+Qwcsif+E
 8NiMe+8VhjJyTVBKpwDUoDL9TxsxMf6mymNz8jCCKfaiCeCxyqpxuJEIHlZejKtjkPCxIaH38Y
 x0qE5/dqdHf8xsUnqZMHda3C5FvygrNCBJY3wNYc1w5WcN15yGsETOJWdtfQLumG0vcNaDG6+U
 8X3vuoBrt+f6nBVVGsiV3Cc6j1QRs2nXWPBMe7xO49rETnnRr0lJcEIl2FCFCULqfVHMWgy/WK
 GjE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2022 23:21:30 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JtDvt0sMYz1SHwl
 for <linux-nvme@lists.infradead.org>; Mon,  7 Feb 2022 23:21:30 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1644304888; x=1646896889; bh=g64yFGZnZtBlZZe3pHAgbpNwncCobKe+4KH
 oTihhnoo=; b=Jmk3FSvN9MTej2lXj5KsM13/ush1bdJf0JQ/3Tzh6JRInwS7Qhg
 P6hGMUmE43eqaqnxT3y5Ed49uqFtzzeIJORGxcEqNhp8BtYSIH6Fq+pw+6kAj1vI
 GedIEIJDVEuFcR1i/gDOXKw7F8GPdWAUQCiTf9VfufZ7EAgOjoBJXsaHkJLnc6DY
 wSJppU8DZPqJ7XRhmoz/yjwMlbJ9eI4h80mmlfWzckWnTtuZYvT+j7y+ni0XWakY
 yK39K0Yg2RQB5/qrroElsr8caihQS0WUxZbYjWZYpMV7EuQRpjtoi654w/vZ6v7s
 X7v/C/LlEc4AeyO3ULtWfoV6h2uEoRCvn0w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id PrrTo_M8v66M for <linux-nvme@lists.infradead.org>;
 Mon,  7 Feb 2022 23:21:28 -0800 (PST)
Received: from [10.225.163.67] (unknown [10.225.163.67])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JtDvj1HkYz1Rwrw;
 Mon,  7 Feb 2022 23:21:20 -0800 (PST)
Message-ID: <2e976611-6ba1-f986-91ce-d7f59fe4dd47@opensource.wdc.com>
Date: Tue, 8 Feb 2022 16:21:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 03/10] block: Add copy offload support infrastructure
Content-Language: en-US
To: Nitesh Shetty <nj.shetty@samsung.com>, mpatocka@redhat.com
Cc: javier@javigon.com, chaitanyak@nvidia.com, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, dm-devel@redhat.com,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 axboe@kernel.dk, msnitzer@redhat.com, bvanassche@acm.org,
 martin.petersen@oracle.com, roland@purestorage.com, hare@suse.de,
 kbusch@kernel.org, hch@lst.de, Frederick.Knight@netapp.com, osandov@fb.com,
 djwong@kernel.org, josef@toxicpanda.com, clm@fb.com, dsterba@suse.com,
 tytso@mit.edu, jack@suse.com, joshi.k@samsung.com, arnav.dawn@samsung.com,
 SelvaKumar S <selvakuma.s1@samsung.com>
References: <CAOSviJ0HmT9iwdHdNtuZ8vHETCosRMpR33NcYGVWOV0ki3EYgw@mail.gmail.com>
 <20220207141348.4235-1-nj.shetty@samsung.com>
 <CGME20220207141918epcas5p4f9badc0c3f3f0913f091c850d2d3bd81@epcas5p4.samsung.com>
 <20220207141348.4235-4-nj.shetty@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220207141348.4235-4-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220207_232131_953922_09EE6F6E 
X-CRM114-Status: GOOD (  40.90  )
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

On 2/7/22 23:13, Nitesh Shetty wrote:
> Introduce blkdev_issue_copy which supports source and destination bdevs,
> and a array of (source, destination and copy length) tuples.

s/a/an

> Introduce REQ_COP copy offload operation flag. Create a read-write

REQ_COPY ?

> bio pair with a token as payload and submitted to the device in order.
> the read request populates token with source specific information which
> is then passed with write request.
> Ths design is courtsey Mikulas Patocka<mpatocka@>'s token based copy

s/Ths design is courtsey/This design is courtesy of

> 
> Larger copy operation may be divided if necessary by looking at device
> limits.

may or will ?
by looking at -> depending on the ?

> 
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
> Signed-off-by: Arnav Dawn <arnav.dawn@samsung.com>
> ---
>  block/blk-lib.c           | 216 ++++++++++++++++++++++++++++++++++++++
>  block/blk-settings.c      |   2 +
>  block/blk.h               |   2 +
>  include/linux/blk_types.h |  20 ++++
>  include/linux/blkdev.h    |   3 +
>  include/uapi/linux/fs.h   |  14 +++
>  6 files changed, 257 insertions(+)
> 
> diff --git a/block/blk-lib.c b/block/blk-lib.c
> index 1b8ced45e4e5..3ae2c27b566e 100644
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
> @@ -135,6 +135,222 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
>  }
>  EXPORT_SYMBOL(blkdev_issue_discard);
>  
> +/*
> + * Wait on and process all in-flight BIOs.  This must only be called once
> + * all bios have been issued so that the refcount can only decrease.
> + * This just waits for all bios to make it through bio_copy_end_io. IO
> + * errors are propagated through cio->io_error.
> + */
> +static int cio_await_completion(struct cio *cio)
> +{
> +	int ret = 0;
> +
> +	while (atomic_read(&cio->refcount)) {
> +		cio->waiter = current;
> +		__set_current_state(TASK_UNINTERRUPTIBLE);
> +		blk_io_schedule();
> +		/* wake up sets us TASK_RUNNING */
> +		cio->waiter = NULL;
> +		ret = cio->io_err;

Why is this in the loop ?

> +	}
> +	kvfree(cio);
> +
> +	return ret;
> +}
> +
> +static void bio_copy_end_io(struct bio *bio)
> +{
> +	struct copy_ctx *ctx = bio->bi_private;
> +	struct cio *cio = ctx->cio;
> +	sector_t clen;
> +	int ri = ctx->range_idx;
> +
> +	if (bio->bi_status) {
> +		cio->io_err = bio->bi_status;
> +		clen = (bio->bi_iter.bi_sector - ctx->start_sec) << SECTOR_SHIFT;
> +		cio->rlist[ri].comp_len = min_t(sector_t, clen, cio->rlist[ri].comp_len);
> +	}
> +	__free_page(bio->bi_io_vec[0].bv_page);
> +	kfree(ctx);
> +	bio_put(bio);
> +
> +	if (atomic_dec_and_test(&cio->refcount) && cio->waiter)
> +		wake_up_process(cio->waiter);

This looks racy: the cio->waiter test and wakeup are not atomic.

> +}
> +
> +/*
> + * blk_copy_offload	- Use device's native copy offload feature
> + * Go through user provide payload, prepare new payload based on device's copy offload limits.
> + */
> +int blk_copy_offload(struct block_device *src_bdev, int nr_srcs,
> +		struct range_entry *rlist, struct block_device *dst_bdev, gfp_t gfp_mask)
> +{
> +	struct request_queue *sq = bdev_get_queue(src_bdev);
> +	struct request_queue *dq = bdev_get_queue(dst_bdev);
> +	struct bio *read_bio, *write_bio;
> +	struct copy_ctx *ctx;
> +	struct cio *cio;
> +	struct page *token;
> +	sector_t src_blk, copy_len, dst_blk;
> +	sector_t remaining, max_copy_len = LONG_MAX;
> +	int ri = 0, ret = 0;
> +
> +	cio = kzalloc(sizeof(struct cio), GFP_KERNEL);
> +	if (!cio)
> +		return -ENOMEM;
> +	atomic_set(&cio->refcount, 0);
> +	cio->rlist = rlist;
> +
> +	max_copy_len = min3(max_copy_len, (sector_t)sq->limits.max_copy_sectors,
> +			(sector_t)dq->limits.max_copy_sectors);

sq->limits.max_copy_sectors is already by definition smaller than
LONG_MAX, so there is no need for the min3 here.

> +	max_copy_len = min3(max_copy_len, (sector_t)sq->limits.max_copy_range_sectors,
> +			(sector_t)dq->limits.max_copy_range_sectors) << SECTOR_SHIFT;> +
> +	for (ri = 0; ri < nr_srcs; ri++) {
> +		cio->rlist[ri].comp_len = rlist[ri].len;
> +		for (remaining = rlist[ri].len, src_blk = rlist[ri].src, dst_blk = rlist[ri].dst;
> +			remaining > 0;
> +			remaining -= copy_len, src_blk += copy_len, dst_blk += copy_len) {

This is unreadable.

> +			copy_len = min(remaining, max_copy_len);
> +
> +			token = alloc_page(gfp_mask);
> +			if (unlikely(!token)) {
> +				ret = -ENOMEM;
> +				goto err_token;
> +			}
> +
> +			read_bio = bio_alloc(src_bdev, 1, REQ_OP_READ | REQ_COPY | REQ_NOMERGE,
> +					gfp_mask);
> +			if (!read_bio) {
> +				ret = -ENOMEM;
> +				goto err_read_bio;
> +			}
> +			read_bio->bi_iter.bi_sector = src_blk >> SECTOR_SHIFT;
> +			read_bio->bi_iter.bi_size = copy_len;
> +			__bio_add_page(read_bio, token, PAGE_SIZE, 0);
> +			ret = submit_bio_wait(read_bio);
> +			if (ret) {
> +				bio_put(read_bio);
> +				goto err_read_bio;
> +			}
> +			bio_put(read_bio);
> +			ctx = kzalloc(sizeof(struct copy_ctx), gfp_mask);
> +			if (!ctx) {
> +				ret = -ENOMEM;
> +				goto err_read_bio;
> +			}

This should be done before the read.

> +			ctx->cio = cio;
> +			ctx->range_idx = ri;
> +			ctx->start_sec = rlist[ri].src;
> +
> +			write_bio = bio_alloc(dst_bdev, 1, REQ_OP_WRITE | REQ_COPY | REQ_NOMERGE,
> +					gfp_mask);
> +			if (!write_bio) {
> +				ret = -ENOMEM;
> +				goto err_read_bio;
> +			}
> +
> +			write_bio->bi_iter.bi_sector = dst_blk >> SECTOR_SHIFT;
> +			write_bio->bi_iter.bi_size = copy_len;
> +			__bio_add_page(write_bio, token, PAGE_SIZE, 0);
> +			write_bio->bi_end_io = bio_copy_end_io;
> +			write_bio->bi_private = ctx;
> +			atomic_inc(&cio->refcount);
> +			submit_bio(write_bio);
> +		}
> +	}
> +
> +	/* Wait for completion of all IO's*/
> +	return cio_await_completion(cio);
> +
> +err_read_bio:
> +	__free_page(token);
> +err_token:
> +	rlist[ri].comp_len = min_t(sector_t, rlist[ri].comp_len, (rlist[ri].len - remaining));
> +
> +	cio->io_err = ret;
> +	return cio_await_completion(cio);
> +}
> +
> +static inline int blk_copy_sanity_check(struct block_device *src_bdev,
> +		struct block_device *dst_bdev, struct range_entry *rlist, int nr)
> +{
> +	unsigned int align_mask = max(
> +			bdev_logical_block_size(dst_bdev), bdev_logical_block_size(src_bdev)) - 1;
> +	sector_t len = 0;
> +	int i;
> +
> +	for (i = 0; i < nr; i++) {
> +		if (rlist[i].len)
> +			len += rlist[i].len;
> +		else
> +			return -EINVAL;
> +		if ((rlist[i].dst & align_mask) || (rlist[i].src & align_mask) ||
> +				(rlist[i].len & align_mask))
> +			return -EINVAL;
> +		rlist[i].comp_len = 0;
> +	}
> +
> +	if (!len && len >= MAX_COPY_TOTAL_LENGTH)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static inline bool blk_check_copy_offload(struct request_queue *src_q,
> +		struct request_queue *dest_q)
> +{
> +	if (dest_q->limits.copy_offload == BLK_COPY_OFFLOAD &&
> +			src_q->limits.copy_offload == BLK_COPY_OFFLOAD)
> +		return true;
> +
> +	return false;
> +}
> +
> +/*
> + * blkdev_issue_copy - queue a copy
> + * @src_bdev:	source block device
> + * @nr_srcs:	number of source ranges to copy
> + * @src_rlist:	array of source ranges
> + * @dest_bdev:	destination block device
> + * @gfp_mask:   memory allocation flags (for bio_alloc)
> + * @flags:	BLKDEV_COPY_* flags to control behaviour
> + *
> + * Description:
> + *	Copy source ranges from source block device to destination block device.
> + *	length of a source range cannot be zero.
> + */
> +int blkdev_issue_copy(struct block_device *src_bdev, int nr,
> +		struct range_entry *rlist, struct block_device *dest_bdev,
> +		gfp_t gfp_mask, int flags)
> +{
> +	struct request_queue *src_q = bdev_get_queue(src_bdev);
> +	struct request_queue *dest_q = bdev_get_queue(dest_bdev);
> +	int ret = -EINVAL;
> +
> +	if (!src_q || !dest_q)
> +		return -ENXIO;
> +
> +	if (!nr)
> +		return -EINVAL;
> +
> +	if (nr >= MAX_COPY_NR_RANGE)
> +		return -EINVAL;
> +
> +	if (bdev_read_only(dest_bdev))
> +		return -EPERM;
> +
> +	ret = blk_copy_sanity_check(src_bdev, dest_bdev, rlist, nr);
> +	if (ret)
> +		return ret;
> +
> +	if (blk_check_copy_offload(src_q, dest_q))
> +		ret = blk_copy_offload(src_bdev, nr, rlist, dest_bdev, gfp_mask);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(blkdev_issue_copy);
> +
>  /**
>   * __blkdev_issue_write_same - generate number of bios with same page
>   * @bdev:	target blockdev
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 818454552cf8..4c8d48b8af25 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -545,6 +545,8 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
>  	t->max_segment_size = min_not_zero(t->max_segment_size,
>  					   b->max_segment_size);
>  
> +	t->max_copy_sectors = min_not_zero(t->max_copy_sectors, b->max_copy_sectors);

Why min_not_zero ? If one of the underlying drive does not support copy
offload, you cannot report that the top drive does.

> +
>  	t->misaligned |= b->misaligned;
>  
>  	alignment = queue_limit_alignment_offset(b, start);
> diff --git a/block/blk.h b/block/blk.h
> index abb663a2a147..94d2b055750b 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -292,6 +292,8 @@ static inline bool blk_may_split(struct request_queue *q, struct bio *bio)
>  		break;
>  	}
>  
> +	if (unlikely(op_is_copy(bio->bi_opf)))
> +		return false;
>  	/*
>  	 * All drivers must accept single-segments bios that are <= PAGE_SIZE.
>  	 * This is a quick and dirty check that relies on the fact that
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 5561e58d158a..0a3fee8ad61c 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -418,6 +418,7 @@ enum req_flag_bits {
>  	/* for driver use */
>  	__REQ_DRV,
>  	__REQ_SWAP,		/* swapping request. */
> +	__REQ_COPY,		/* copy request*/
>  	__REQ_NR_BITS,		/* stops here */
>  };
>  
> @@ -442,6 +443,7 @@ enum req_flag_bits {
>  
>  #define REQ_DRV			(1ULL << __REQ_DRV)
>  #define REQ_SWAP		(1ULL << __REQ_SWAP)
> +#define REQ_COPY		(1ULL << __REQ_COPY)
>  
>  #define REQ_FAILFAST_MASK \
>  	(REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT | REQ_FAILFAST_DRIVER)
> @@ -498,6 +500,11 @@ static inline bool op_is_discard(unsigned int op)
>  	return (op & REQ_OP_MASK) == REQ_OP_DISCARD;
>  }
>  
> +static inline bool op_is_copy(unsigned int op)
> +{
> +	return (op & REQ_COPY);
> +}
> +
>  /*
>   * Check if a bio or request operation is a zone management operation, with
>   * the exception of REQ_OP_ZONE_RESET_ALL which is treated as a special case
> @@ -532,4 +539,17 @@ struct blk_rq_stat {
>  	u64 batch;
>  };
>  
> +struct cio {
> +	atomic_t refcount;
> +	blk_status_t io_err;
> +	struct range_entry *rlist;
> +	struct task_struct *waiter;     /* waiting task (NULL if none) */
> +};
> +
> +struct copy_ctx {
> +	int range_idx;
> +	sector_t start_sec;
> +	struct cio *cio;
> +};
> +
>  #endif /* __LINUX_BLK_TYPES_H */
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index f63ae50f1de3..15597488040c 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1120,6 +1120,9 @@ extern int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
>  		struct bio **biop);
>  struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
>  		gfp_t gfp_mask);
> +int blkdev_issue_copy(struct block_device *src_bdev, int nr_srcs,
> +		struct range_entry *src_rlist, struct block_device *dest_bdev,
> +		gfp_t gfp_mask, int flags);
>  
>  #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
>  #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes */
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index bdf7b404b3e7..55bca8f6e8ed 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -64,6 +64,20 @@ struct fstrim_range {
>  	__u64 minlen;
>  };
>  
> +/* Maximum no of entries supported */
> +#define MAX_COPY_NR_RANGE	(1 << 12)
> +
> +/* maximum total copy length */
> +#define MAX_COPY_TOTAL_LENGTH	(1 << 21)
> +
> +/* Source range entry for copy */
> +struct range_entry {
> +	__u64 src;
> +	__u64 dst;
> +	__u64 len;
> +	__u64 comp_len;
> +};
> +
>  /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definitions */
>  #define FILE_DEDUPE_RANGE_SAME		0
>  #define FILE_DEDUPE_RANGE_DIFFERS	1


-- 
Damien Le Moal
Western Digital Research

