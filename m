Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8023C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Apr 2022 12:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rJ68u8jd1pGMMpvwjEOkdhZXSNG8xLLCdO1Cn+Xq+gA=; b=MGX2BcjPVG4p9ap9wJOsc3W45/
	SYB5Kp/lFNL6PghULPBhtWq4TOIm7N+vrR+5OOD0E3YM69uqgZGuWeoVqWMGMY++PBAwQkM71ku27
	/IDpBMHN8n0F0mypTxmFa2ntUSKYjFYL3P4O12ar1ydOtrNCS06RCev+gG0NP2EAHjOZzLzabEdk3
	NQpfAxsmCouBWgv9gehT32AYJq3us8yAW54afEkPaZxXNk8aDboqkTQjaX72Gp6hwAJnaVkb+NYZu
	sI6nuE0xD3PQ4Yit1VSefToYCHNw0i269gnKQ6Z6gLfoh3M+u74gPkM9n3aI1NDY/Mb2iBNJmihao
	9fFYm1og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njh7f-001NaY-8v; Wed, 27 Apr 2022 12:50:23 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njevC-000wLs-Vn
 for linux-nvme@lists.infradead.org; Wed, 27 Apr 2022 10:29:24 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 63E961F388;
 Wed, 27 Apr 2022 10:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1651055356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rJ68u8jd1pGMMpvwjEOkdhZXSNG8xLLCdO1Cn+Xq+gA=;
 b=gDV+xrS2GbcllQPvhcHYRsIZ5JmMF2CTqkJH2hZzzFtDP0TXmtJZrpUuuojh3t96ebXcco
 MAc0BQ67VewzXUn+zMa2QyCdDcBvaXF2/Fq9ddaIFETQCt9fte7B7E4o+krYi72nEXZLYM
 2ZEuZ2TIjVXu6V9ocZWj7LvaM3Bftfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1651055356;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rJ68u8jd1pGMMpvwjEOkdhZXSNG8xLLCdO1Cn+Xq+gA=;
 b=EkM4US2Ur6JYETOSv0kVXMTGm4wfX9NWB6vWzYaHSmzhLafSzMfv1PShz4hn4/DwHAF+XD
 EYzGw+r4D0s0dBCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 193711323E;
 Wed, 27 Apr 2022 10:29:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 24OHBfwaaWJ/AQAAMHmgww
 (envelope-from <hare@suse.de>); Wed, 27 Apr 2022 10:29:16 +0000
Message-ID: <2082148f-890f-e5f4-c304-b99212aa377e@suse.de>
Date: Wed, 27 Apr 2022 12:29:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: chaitanyak@nvidia.com, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, dm-devel@redhat.com,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 axboe@kernel.dk, msnitzer@redhat.com, bvanassche@acm.org,
 martin.petersen@oracle.com, kbusch@kernel.org, hch@lst.de,
 Frederick.Knight@netapp.com, osandov@fb.com,
 lsf-pc@lists.linux-foundation.org, djwong@kernel.org, josef@toxicpanda.com,
 clm@fb.com, dsterba@suse.com, tytso@mit.edu, jack@suse.com,
 nitheshshetty@gmail.com, gost.dev@samsung.com,
 Arnav Dawn <arnav.dawn@samsung.com>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 James Smart <james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
References: <20220426101241.30100-1-nj.shetty@samsung.com>
 <CGME20220426101921epcas5p341707619b5e836490284a42c92762083@epcas5p3.samsung.com>
 <20220426101241.30100-3-nj.shetty@samsung.com>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v4 02/10] block: Add copy offload support infrastructure
In-Reply-To: <20220426101241.30100-3-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220427_032923_215714_152C4BF1 
X-CRM114-Status: GOOD (  29.06  )
X-Mailman-Approved-At: Wed, 27 Apr 2022 05:48:55 -0700
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

On 4/26/22 12:12, Nitesh Shetty wrote:
> Introduce blkdev_issue_copy which supports source and destination bdevs,
> and an array of (source, destination and copy length) tuples.
> Introduce REQ_COPY copy offload operation flag. Create a read-write
> bio pair with a token as payload and submitted to the device in order.
> Read request populates token with source specific information which
> is then passed with write request.
> This design is courtesy Mikulas Patocka's token based copy
> 
> Larger copy will be divided, based on max_copy_sectors,
> max_copy_range_sector limits.
> 
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: Arnav Dawn <arnav.dawn@samsung.com>
> ---
>   block/blk-lib.c           | 232 ++++++++++++++++++++++++++++++++++++++
>   block/blk.h               |   2 +
>   include/linux/blk_types.h |  21 ++++
>   include/linux/blkdev.h    |   2 +
>   include/uapi/linux/fs.h   |  14 +++
>   5 files changed, 271 insertions(+)
> 
> diff --git a/block/blk-lib.c b/block/blk-lib.c
> index 09b7e1200c0f..ba9da2d2f429 100644
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
> @@ -117,6 +117,238 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
>   }
>   EXPORT_SYMBOL(blkdev_issue_discard);
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
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&cio->lock, flags);
> +	if (cio->refcount) {
> +		cio->waiter = current;
> +		__set_current_state(TASK_UNINTERRUPTIBLE);
> +		spin_unlock_irqrestore(&cio->lock, flags);
> +		blk_io_schedule();
> +		/* wake up sets us TASK_RUNNING */
> +		spin_lock_irqsave(&cio->lock, flags);
> +		cio->waiter = NULL;
> +		ret = cio->io_err;
> +	}
> +	spin_unlock_irqrestore(&cio->lock, flags);
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
> +	unsigned long flags;
> +	bool wake = false;
> +
> +	if (bio->bi_status) {
> +		cio->io_err = bio->bi_status;
> +		clen = (bio->bi_iter.bi_sector << SECTOR_SHIFT) - ctx->start_sec;
> +		cio->rlist[ri].comp_len = min_t(sector_t, clen, cio->rlist[ri].comp_len);
> +	}
> +	__free_page(bio->bi_io_vec[0].bv_page);
> +	kfree(ctx);
> +	bio_put(bio);
> +
> +	spin_lock_irqsave(&cio->lock, flags);
> +	if (((--cio->refcount) <= 0) && cio->waiter)
> +		wake = true;
> +	spin_unlock_irqrestore(&cio->lock, flags);
> +	if (wake)
> +		wake_up_process(cio->waiter);
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
> +	unsigned long flags;
> +	int ri = 0, ret = 0;
> +
> +	cio = kzalloc(sizeof(struct cio), GFP_KERNEL);
> +	if (!cio)
> +		return -ENOMEM;
> +	cio->rlist = rlist;
> +	spin_lock_init(&cio->lock);
> +
> +	max_copy_len = min_t(sector_t, sq->limits.max_copy_sectors, dq->limits.max_copy_sectors);
> +	max_copy_len = min3(max_copy_len, (sector_t)sq->limits.max_copy_range_sectors,
> +			(sector_t)dq->limits.max_copy_range_sectors) << SECTOR_SHIFT;
> +
> +	for (ri = 0; ri < nr_srcs; ri++) {
> +		cio->rlist[ri].comp_len = rlist[ri].len;
> +		src_blk = rlist[ri].src;
> +		dst_blk = rlist[ri].dst;
> +		for (remaining = rlist[ri].len; remaining > 0; remaining -= copy_len) {
> +			copy_len = min(remaining, max_copy_len);
> +
> +			token = alloc_page(gfp_mask);
> +			if (unlikely(!token)) {
> +				ret = -ENOMEM;
> +				goto err_token;
> +			}
> +
> +			ctx = kzalloc(sizeof(struct copy_ctx), gfp_mask);
> +			if (!ctx) {
> +				ret = -ENOMEM;
> +				goto err_ctx;
> +			}
> +			ctx->cio = cio;
> +			ctx->range_idx = ri;
> +			ctx->start_sec = dst_blk;
> +
> +			read_bio = bio_alloc(src_bdev, 1, REQ_OP_READ | REQ_COPY | REQ_NOMERGE,
> +					gfp_mask);
> +			if (!read_bio) {
> +				ret = -ENOMEM;
> +				goto err_read_bio;
> +			}
> +			read_bio->bi_iter.bi_sector = src_blk >> SECTOR_SHIFT;
> +			__bio_add_page(read_bio, token, PAGE_SIZE, 0);
> +			/*__bio_add_page increases bi_size by len, so overwrite it with copy len*/
> +			read_bio->bi_iter.bi_size = copy_len;
> +			ret = submit_bio_wait(read_bio);
> +			bio_put(read_bio);
> +			if (ret)
> +				goto err_read_bio;
> +
> +			write_bio = bio_alloc(dst_bdev, 1, REQ_OP_WRITE | REQ_COPY | REQ_NOMERGE,
> +					gfp_mask);
> +			if (!write_bio) {
> +				ret = -ENOMEM;
> +				goto err_read_bio;
> +			}
> +			write_bio->bi_iter.bi_sector = dst_blk >> SECTOR_SHIFT;
> +			__bio_add_page(write_bio, token, PAGE_SIZE, 0);
> +			/*__bio_add_page increases bi_size by len, so overwrite it with copy len*/
> +			write_bio->bi_iter.bi_size = copy_len;
> +			write_bio->bi_end_io = bio_copy_end_io;
> +			write_bio->bi_private = ctx;
> +
> +			spin_lock_irqsave(&cio->lock, flags);
> +			++cio->refcount;
> +			spin_unlock_irqrestore(&cio->lock, flags);
> +
> +			submit_bio(write_bio);
> +			src_blk += copy_len;
> +			dst_blk += copy_len;
> +		}
> +	}
> +

Hmm. I'm not sure if I like the copy loop.
What I definitely would do is to allocate the write bio before reading 
data; after all, if we can't allocate the write bio reading is pretty 
much pointless.

But the real issue I have with this is that it's doing synchronous 
reads, thereby limiting the performance.

Can't you submit the write bio from the end_io function of the read bio?
That would disentangle things, and we should be getting a better 
performance.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

