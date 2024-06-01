Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A3E6C25B7E
	for <linux-nvme@archiver.kernel.org>; Sat,  1 Jun 2024 06:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JXTOXUa+t1apywrCHWXGAC2n8OJjfySVPLPOcPE2Q0c=; b=qUqjzfuY7i7QzRbQC8P9hv1+sK
	/A149Q4gBGVsNzZLT+2NwPPcPHbCEufEopS1kAbEKAC2IcI8y7faXaIZ3sxre8GVJpx1byrfxRIaf
	6nonrR80/bG7HJlKT1Dq8eGMQvMkr8mFY5oHrdf0kAl3VqUpcWjy+4QW3kJUOHZ6kxUuPPgV1Hh3Z
	ebLcxlUDfjlLBZgc+GlIaayn+z8wfx4Z7KyV6XClVSzpL6Hz1DBUW3Y6/iDY1ww0aiYB9ogAdfxJd
	3CjMvS5X6EJIhifxf6LDwueVKdglZ7TVFOEDYqNbOZ40JfoG2rDGmVOQ1FZRVSY5I5e71ERUVKPcX
	JCAE3UZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDI33-0000000C4FH-0uIo;
	Sat, 01 Jun 2024 06:17:01 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDI30-0000000C4DF-3DAa
	for linux-nvme@lists.infradead.org;
	Sat, 01 Jun 2024 06:17:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 97C0668D17; Sat,  1 Jun 2024 08:16:53 +0200 (CEST)
Date: Sat, 1 Jun 2024 08:16:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	martin.petersen@oracle.com, bvanassche@acm.org, david@fromorbit.com,
	hare@suse.de, damien.lemoal@opensource.wdc.com,
	anuj20.g@samsung.com, joshi.k@samsung.com, nitheshshetty@gmail.com,
	gost.dev@samsung.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 03/12] block: add copy offload support
Message-ID: <20240601061653.GA5877@lst.de>
References: <20240520102033.9361-1-nj.shetty@samsung.com> <CGME20240520102853epcas5p42d635d6712b8876ea22a45d730cb1378@epcas5p4.samsung.com> <20240520102033.9361-4-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520102033.9361-4-nj.shetty@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240531_231659_115693_AD6A95B8 
X-CRM114-Status: GOOD (  28.26  )
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

> +/* Keeps track of all outstanding copy IO */
> +struct blkdev_copy_io {
> +	atomic_t refcount;
> +	ssize_t copied;
> +	int status;
> +	struct task_struct *waiter;
> +	void (*endio)(void *private, int status, ssize_t copied);
> +	void *private;
> +};
> +
> +/* Keeps track of single outstanding copy offload IO */
> +struct blkdev_copy_offload_io {
> +	struct blkdev_copy_io *cio;
> +	loff_t offset;
> +};

The structure names confuse me, and the comments make things even worse.

AFAICT:

blkdev_copy_io is a per-call structure, I'd name it blkdev_copy_ctx.
blkdev_copy_offload_io is per-bio pair, and something like blkdev_copy_chunk
might be a better idea.  Or we could just try to kill it entirely and add
a field to struct bio in the union currently holding the integrity
information.

I'm also quite confused what kind of offset this offset field is.  The
type and name suggest it is an offset in a file, which for a block device
based helper is pretty odd to start with.  blkdev_copy_offload
initializes it to len - rem, so it kind is an offset, but relative
to the operation and not to a file. blkdev_copy_offload_src_endio then
uses to set the ->copied field, but based on a min which means
->copied can only be decreased.  Something is really off there.

Taking about types and units: blkdev_copy_offload obviously can only
work in terms of LBAs.  Any reason to not make it work in terms of
512-byte block layer sectors instead of in bytes?

> +	if ((pos_in & align) || (pos_out & align) || (len & align) || !len ||
> +	    len >= BLK_COPY_MAX_BYTES)
> +		return -EINVAL;

This can be cleaned up an optimized a bit:

	if (!len || len >= BLK_COPY_MAX_BYTES)
		return -EINVAL;
	if ((pos_in | pos_out | len) & align)
		return -EINVAL;
	
> + *
> + * For synchronous operation returns the length of bytes copied or error
> + * For asynchronous operation returns -EIOCBQUEUED or error
> + *
> + * Description:
> + *	Copy source offset to destination offset within block device, using
> + *	device's native copy offload feature.
> + *	We perform copy operation using 2 bio's.
> + *	1. We take a plug and send a REQ_OP_COPY_DST bio along with destination
> + *	sector and length. Once this bio reaches request layer, we form a
> + *	request and wait for dst bio to arrive.
> + *	2. We issue REQ_OP_COPY_SRC bio along with source sector, length.
> + *	Once this bio reaches request layer and find a request with previously
> + *	sent destination info we merge the source bio and return.
> + *	3. Release the plug and request is sent to driver
> + *	This design works only for drivers with request queue.

The wording with all the We here is a bit odd.  Much of this also seem
superfluous or at least misplaced in the kernel doc comment as it doesn't
document the API, but just what is done in the code below.

> +	cio = kzalloc(sizeof(*cio), gfp);
> +	if (!cio)
> +		return -ENOMEM;
> +	atomic_set(&cio->refcount, 1);
> +	cio->waiter = current;
> +	cio->endio = endio;
> +	cio->private = private;

For the main use this could be allocated on-stack.  Is there any good
reason to not let callers that really want an async version to implement
the async behavior themselves using suitable helpers?

> +		src_bio = blk_next_bio(dst_bio, bdev, 0, REQ_OP_COPY_SRC, gfp);

Please switch to use bio_chain_and_submit, which is a easier to
understand API.  I'm trying to phase out blk_next_bio in favour of
bio_chain_and_submit over the next few merge windows.

> +		if (!src_bio)
> +			goto err_free_dst_bio;
> +		src_bio->bi_iter.bi_size = chunk;
> +		src_bio->bi_iter.bi_sector = pos_in >> SECTOR_SHIFT;
> +		src_bio->bi_end_io = blkdev_copy_offload_src_endio;
> +		src_bio->bi_private = offload_io;
> +
> +		atomic_inc(&cio->refcount);
> +		submit_bio(src_bio);
> +		blk_finish_plug(&plug);

plugs should be hold over all  I/Os, submitted from the same caller,
which is the point of them.


