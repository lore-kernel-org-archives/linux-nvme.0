Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C657C47DD9
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Feb 2024 12:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Subject:Cc:To:
	From:Message-Id:Date:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=25Wnxo4auMxWX81USo8zF0+feYqyPwphwSYBjyk9TfY=; b=xdzU1s7fEskqkd
	AM9VvJhnEnH9Ey+wkG3fNN1sCJugPjXkwaYcnYQqKqp5nyh4uk6FvDB063bVJYzt6go86YkrXUw67
	IdINMroEjS0yorDKnrSkTeCkDdakPqdrQCgcgMPheBl5CmYRHhBlkQx8YuqEw0Ppdf20z1nnSNDIE
	fuXBlmwWqw1mW3mslnPsmxI9pGCHdUUX8Qnp7tdmPzwnU7bTC5L+ncLZCroFz5A5C1r7mfu3Hw8hb
	IkMSPMfhe1M5gucWGiudxO0rPDXny4ol2vjizeJs7qIU/CevWs0+d6xTbvD+UEYvfqb4AXTSqazID
	hDNCTqrRbjJYmtAHJqhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reDKG-0000000EtV6-0Ce1;
	Sun, 25 Feb 2024 12:09:48 +0000
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reDKB-0000000EtUN-0CXd
	for linux-nvme@lists.infradead.org;
	Sun, 25 Feb 2024 12:09:45 +0000
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-58e256505f7so2329268eaf.3
        for <linux-nvme@lists.infradead.org>; Sun, 25 Feb 2024 04:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708862980; x=1709467780; darn=lists.infradead.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=25Wnxo4auMxWX81USo8zF0+feYqyPwphwSYBjyk9TfY=;
        b=Goms8oFKkZJf8YuWH+VTNUr53YbpidUWPt5l2WddabojRMjeofxkJVCYc80OHlKJ3W
         u2IoSlL8DeFkM9M4644EObGhl0ScqnjmlFJfmv653VTptawtfrCAWdK7UvC94bhJHTgX
         Vl+sbgjei6YdzK6SEQg9EYhi3h7ZZPZ1iIAUiLhL7jnlVPh6n+FOoLyMY/ehkSZN5529
         ba2CDnJ0z9o9c+igY+fxPdF2N1MqCtzznPLUq9ZilvqPUA3VtkiNuy5PisJ8gybWX2ti
         nPWLW/22kWrpYRp6E5B2pSNs+7pdV5Gd60EX1Uk00KLgugtuhQ8dkcfUtYEp8IkMyYk0
         e4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708862980; x=1709467780;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=25Wnxo4auMxWX81USo8zF0+feYqyPwphwSYBjyk9TfY=;
        b=mq3KBGCAhIsD9zQAlQe56bpr9NRotI2yYNIL1b5NPqiJxzdi0ZMxRctVm2HELcQT1+
         Uulp8VCoS9wpWSFE5J2HEV9K1eafaNtM8ewCaixaz5gt4ooo3DkvwwzsUQQs7NRpJhpY
         JXrupdsyKbtIccTyB02T3GO1bwNZQRJ48vO2H5YDKosVHmwpvNmu8XHB0giTK7oCLEoP
         E/TT1QjpX1sI34inH/C11tXGbVrHHo2/02wpvOFVe0ib0PAsxBpnL3QXyEyw0L6ZAd9d
         BFsHCd88NvyCAW+DKcW2OjfddgqR+nDAVM76ogdXp9uqDEy2qgKCZ9sdMJiikQRJ7cG1
         hT2A==
X-Forwarded-Encrypted: i=1; AJvYcCUomjiUj2KT7jZ0mUowpPbmOqrtm+4CrVK9T8Gtf967+L3lpZOuotLgVTNrT5YQdEMNrm970OLXLHaTP7GqPZ40s5mtovPMxHXy38p7hBs=
X-Gm-Message-State: AOJu0YweDxgHFz3CRVlWTIiOf58Ze5Nl9QZfNfXu79UZuiVEaEdI+15x
	9uZBpr4tuJLyhfbKqMRrypLoG5hz6JgomYgwxuy8Rxsv8vafmmYl
X-Google-Smtp-Source: AGHT+IG/SPBPaHYl9Zd0UdB/DMqbM9JvYxKfD6XaVkFYzPvtQchqP9U9WkoM+6DEtCHDWtRbQB2Oiw==
X-Received: by 2002:a05:6359:4127:b0:176:4f31:75de with SMTP id kh39-20020a056359412700b001764f3175demr5884981rwc.6.1708862980139;
        Sun, 25 Feb 2024 04:09:40 -0800 (PST)
Received: from dw-tp ([171.76.80.106])
        by smtp.gmail.com with ESMTPSA id s185-20020a625ec2000000b006e4e2dd013bsm2361399pfb.208.2024.02.25.04.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 04:09:39 -0800 (PST)
Date: Sun, 25 Feb 2024 17:39:30 +0530
Message-Id: <87le7821ad.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com, jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com, linux-aio@kvack.org, linux-btrfs@vger.kernel.org, io-uring@vger.kernel.org, nilay@linux.ibm.com, John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v4 05/11] block: Add core atomic write support
In-Reply-To: <20240219130109.341523-6-john.g.garry@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240225_040943_134269_F5FC713C 
X-CRM114-Status: GOOD (  53.34  )
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

John Garry <john.g.garry@oracle.com> writes:

> Add atomic write support as follows:
> - report request_queue atomic write support limits to sysfs and udpate Doc
> - add helper functions to get request_queue atomic write limits
> - support to safely merge atomic writes
> - add a per-request atomic write flag
> - deal with splitting atomic writes
> - misc helper functions
>
> New sysfs files are added to report the following atomic write limits:
> - atomic_write_boundary_bytes
> - atomic_write_max_bytes
> - atomic_write_unit_max_bytes
> - atomic_write_unit_min_bytes
>
> atomic_write_unit_{min,max}_bytes report the min and max atomic write
> support size, inclusive, and are primarily dictated by HW capability. Both
> values must be a power-of-2. atomic_write_boundary_bytes, if non-zero,
> indicates an LBA space boundary at which an atomic write straddles no
> longer is atomically executed by the disk. atomic_write_max_bytes is the
> maximum merged size for an atomic write. Often it will be the same value as
> atomic_write_unit_max_bytes.

Instead of explaining sysfs outputs which are deriviatives of HW
and request_queue limits (and also defined in Documentation), maybe we
could explain how those sysfs values are derived instead -

struct queue_limits {
<...>
	unsigned int		atomic_write_hw_max_sectors;
	unsigned int		atomic_write_max_sectors;
	unsigned int		atomic_write_hw_boundary_sectors;
	unsigned int		atomic_write_hw_unit_min_sectors;
	unsigned int		atomic_write_unit_min_sectors;
	unsigned int		atomic_write_hw_unit_max_sectors;
	unsigned int		atomic_write_unit_max_sectors;
<...>

1. atomic_write_unit_hw_max_sectors comes directly from hw and it need
not be a power of 2.

2. atomic_write_hw_unit_min_sectors and atomic_write_hw_unit_max_sectors
is again defined/derived from hw limits, but it is rounded down so that
it is always a power of 2.

3. atomic_write_hw_boundary_sectors again comes from HW boundary limit.
It could either be 0 (which means the device specify no boundary limit) or a
multiple of unit_max. It need not be power of 2, however the current
code assumes it to be a power of 2 (check callers of blk_queue_atomic_write_boundary_bytes())

4. atomic_write_max_sectors, atomic_write_unit_min_sectors
and atomic_write_unit_max_sectors are all derived out of above hw limits
inside function blk_atomic_writes_update_limits() based on request_queue
limits.
    a. atomic_write_max_sectors is derived from atomic_write_hw_unit_max_sectors and
       request_queue's max_hw_sectors limit. It also guarantees max
       sectors that can be fit in a single bio.
    b. atomic_write_unit_[min|max]_sectors are derived from atomic_write_hw_unit_[min|max]_sectors,
       request_queue's max_hw_sectors & blk_queue_max_guaranteed_bio_sectors(). Both of these limits
       are kept as a power of 2.

Now coming to sysfs outputs -
1. atomic_write_unit_max_bytes: Same as atomic_write_unix_max_sectors in bytes
2. atomic_write_unit_min_bytes: Same as atomic_write_unit_min_sectors in bytes
3. atomic_write_boundary_bytes: same as atomic_write_hw_boundary_sectors
in bytes
4. atomic_write_max_bytes: Same as atomic_write_max_sectors in bytes

>
> atomic_write_unit_max_bytes is capped at the maximum data size which we are
> guaranteed to be able to fit in a BIO, as an atomic write must always be
> submitted as a single BIO. This BIO max size is dictated by the number of

Here it says that the atomic write must always be submitted as a single
bio. From where to where? I think you meant from FS to block layer.
Because otherwise we still allow request/bio merging inside block layer
based on the request queue limits we defined above. i.e. bio can be
chained to form
      rq->biotail->bi_next = next_rq->bio
as long as the merged requests is within the queue_limits.

i.e. atomic write requests can be merged as long as -
    - both rqs have REQ_ATOMIC set
    - blk_rq_sectors(final_rq) <= q->limits.atomic_write_max_sectors
    - final rq formed should not straddle limits->atomic_write_hw_boundary_sectors

However, splitting of an atomic write requests is not allowed. And if it
happens, we fail the I/O req & return -EINVAL.

> segments allowed which the request queue can support and the number of
> bvecs a BIO can fit, BIO_MAX_VECS. Currently we rely on userspace issuing a
> write with iovcnt=1 for IOV_ITER - as such, we can rely on each segment
> containing PAGE_SIZE of data, apart from the first+last, which each can
> fit logical block size of data. Note that here we rely on the direct IO
> rule for alignment, that each iovec needs to be logical block size
> aligned/length multiple. Atomic writes may be supported for buffered IO in
> future, but it would still make sense to apply that direct IO rule there.
>
> atomic_write_max_sectors is capped at max_hw_sectors, but is not also
> capped at max_sectors. The value in max_sectors can be controlled from
> userspace, and it would only cause trouble if userspace could limit
> atomic_write_unit_max_bytes and the other atomic write limits.
>
> Atomic writes may be merged under the following conditions:
> - total request length <= atomic_write_max_bytes
> - the merged write does not straddle a boundary, if any
>
> It is only permissible to merge an atomic writes with another atomic
> write, i.e. it is not possible to merge an atomic and non-atomic write.
> There are many reasons for this, like:
> - SCSI has a dedicated atomic write command, so a merged atomic and
>   non-atomic needs to be issued as an atomic write, putting an unnecessary
>   burden on the disk to issue the merged write atomically
> - Dimensions of the merged non-atomic write need to be checked for size/
>   offset to conform to atomic write rules, which adds overhead
> - Typically only atomic writes or non-atomic writes are expected for a
>   file during normal processing, so not any expected use-case to cater for.
>
> Functions get_max_io_size() and blk_queue_get_max_sectors() are modified to
> handle atomic writes max length - those functions are used by the merge
> code.
>
> An atomic write cannot be split under any circumstances. In the case that
> an atomic write needs to be split, we reject the IO. If any atomic write
> needs to be split, it is most likely because of either:
> - atomic_write_unit_max_bytes reported is incorrect.
> - whoever submitted the atomic write BIO did not properly adhere to the
>   request_queue limits.
>
> All atomic writes limits are by default set 0 to indicate no atomic write
> support. Even though it is assumed by Linux that a logical block can always
> be atomically written, we ignore this as it is not of particular interest.
> Stacked devices are just not supported either for now.
>
> Flag REQ_ATOMIC is used for indicating an atomic write.
>
> Helper function bdev_can_atomic_write() is added to indicate whether
> atomic writes may be issued to a bdev. It ensures that if the bdev is a
> partition, that the partition is properly aligned with
> atomic_write_unit_min_sectors and atomic_write_hw_boundary_sectors.

IMHO, the commit message can definitely use a re-write. I agree that you
have put in a lot of information, but I think it can be more organized.

>
> Contains significant contributions from:
> Himanshu Madhani <himanshu.madhani@oracle.com>

Myabe it can use a better tag then.
"Documentation/process/submitting-patches.rst"

>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  Documentation/ABI/stable/sysfs-block |  52 ++++++++++++++
>  block/blk-merge.c                    |  91 ++++++++++++++++++++++-
>  block/blk-settings.c                 | 103 +++++++++++++++++++++++++++
>  block/blk-sysfs.c                    |  33 +++++++++
>  block/blk.h                          |   3 +
>  include/linux/blk_types.h            |   2 +
>  include/linux/blkdev.h               |  60 ++++++++++++++++
>  7 files changed, 343 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
> index 1fe9a553c37b..4c775f4bdefe 100644
> --- a/Documentation/ABI/stable/sysfs-block
> +++ b/Documentation/ABI/stable/sysfs-block
> @@ -21,6 +21,58 @@ Description:
>  		device is offset from the internal allocation unit's
>  		natural alignment.
>
> +What:		/sys/block/<disk>/atomic_write_max_bytes
> +Date:		February 2024
> +Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
> +Description:
> +		[RO] This parameter specifies the maximum atomic write
> +		size reported by the device. This parameter is relevant
> +		for merging of writes, where a merged atomic write
> +		operation must not exceed this number of bytes.
> +		This parameter may be greater to the value in
> +		atomic_write_unit_max_bytes as
> +		atomic_write_unit_max_bytes will be rounded down to a
> +		power-of-two and atomic_write_unit_max_bytes may also be
> +		limited by some other queue limits, such as max_segments.
> +		This parameter - along with atomic_write_unit_min_bytes
> +		and atomic_write_unit_max_bytes - will not be larger than
> +		max_hw_sectors_kb, but may be larger than max_sectors_kb.
> +
> +
> +What:		/sys/block/<disk>/atomic_write_unit_min_bytes
> +Date:		February 2024
> +Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
> +Description:
> +		[RO] This parameter specifies the smallest block which can
> +		be written atomically with an atomic write operation. All
> +		atomic write operations must begin at a
> +		atomic_write_unit_min boundary and must be multiples of
> +		atomic_write_unit_min. This value must be a power-of-two.
> +
> +
> +What:		/sys/block/<disk>/atomic_write_unit_max_bytes
> +Date:		February 2024
> +Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
> +Description:
> +		[RO] This parameter defines the largest block which can be
> +		written atomically with an atomic write operation. This
> +		value must be a multiple of atomic_write_unit_min and must
> +		be a power-of-two. This value will not be larger than
> +		atomic_write_max_bytes.
> +
> +
> +What:		/sys/block/<disk>/atomic_write_boundary_bytes
> +Date:		February 2024
> +Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
> +Description:
> +		[RO] A device may need to internally split I/Os which
> +		straddle a given logical block address boundary. In that
> +		case a single atomic write operation will be processed as
> +		one of more sub-operations which each complete atomically.
> +		This parameter specifies the size in bytes of the atomic
> +		boundary if one is reported by the device. This value must
> +		be a power-of-two.
> +
>
>  What:		/sys/block/<disk>/diskseq
>  Date:		February 2021
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 74e9e775f13d..12a75a252ca2 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -18,6 +18,42 @@
>  #include "blk-rq-qos.h"
>  #include "blk-throttle.h"
>  

/* A comment explaining this function and arguments could be helpful */

> +static bool rq_straddles_atomic_write_boundary(struct request *rq,
> +					unsigned int front,
> +					unsigned int back)

A better naming perhaps be start_adjust, end_adjust?

> +{
> +	unsigned int boundary = queue_atomic_write_boundary_bytes(rq->q);
> +	unsigned int mask, imask;
> +	loff_t start, end;

start_rq_pos, end_rq_pos maybe?

> +
> +	if (!boundary)
> +		return false;
> +
> +	start = rq->__sector << SECTOR_SHIFT;

blk_rq_pos(rq) perhaps?

> +	end = start + rq->__data_len;

blk_rq_bytes(rq) perhaps? It should be..
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

The last condition looks wrong. Shouldn't it be end - 1?

> +
> +	return false;
> +}

Can we do something like this?

static bool rq_straddles_atomic_write_boundary(struct request *rq,
					       unsigned int start_adjust,
					       unsigned int end_adjust)
{
	unsigned int boundary = queue_atomic_write_boundary_bytes(rq->q);
	unsigned long boundary_mask;
	unsigned long start_rq_pos, end_rq_pos;

	if (!boundary)
		return false;

	start_rq_pos = blk_rq_pos(rq) << SECTOR_SHIFT;
	end_rq_pos = start_rq_pos + blk_rq_bytes(rq);

	start_rq_pos -= start_adjust;
	end_rq_pos += end_adjust;

	boundary_mask = boundary - 1;

	if ((start_rq_pos | boundary_mask) != (end_rq_pos | boundary_mask))
		return true;

	return false;
}

I was thinking this check should cover all cases? Thoughts?


> +
>  static inline void bio_get_first_bvec(struct bio *bio, struct bio_vec *bv)
>  {
>  	*bv = mp_bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
> @@ -167,7 +203,16 @@ static inline unsigned get_max_io_size(struct bio *bio,
>  {
>  	unsigned pbs = lim->physical_block_size >> SECTOR_SHIFT;
>  	unsigned lbs = lim->logical_block_size >> SECTOR_SHIFT;
> -	unsigned max_sectors = lim->max_sectors, start, end;
> +	unsigned max_sectors, start, end;
> +
> +	/*
> +	 * We ignore lim->max_sectors for atomic writes simply because
> +	 * it may less than the bio size, which we cannot tolerate.
> +	 */
> +	if (bio->bi_opf & REQ_ATOMIC)
> +		max_sectors = lim->atomic_write_max_sectors;
> +	else
> +		max_sectors = lim->max_sectors;
>
>  	if (lim->chunk_sectors) {
>  		max_sectors = min(max_sectors,
> @@ -305,6 +350,11 @@ struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *lim,
>  	*segs = nsegs;
>  	return NULL;
>  split:
> +	if (bio->bi_opf & REQ_ATOMIC) {
> +		bio->bi_status = BLK_STS_IOERR;
> +		bio_endio(bio);
> +		return ERR_PTR(-EINVAL);
> +	}
>  	/*
>  	 * We can't sanely support splitting for a REQ_NOWAIT bio. End it
>  	 * with EAGAIN if splitting is required and return an error pointer.
> @@ -645,6 +695,13 @@ int ll_back_merge_fn(struct request *req, struct bio *bio, unsigned int nr_segs)
>  		return 0;
>  	}
>
> +	if (req->cmd_flags & REQ_ATOMIC) {
> +		if (rq_straddles_atomic_write_boundary(req,
> +				0, bio->bi_iter.bi_size)) {
> +			return 0;
> +		}
> +	}
> +
>  	return ll_new_hw_segment(req, bio, nr_segs);
>  }
>
> @@ -664,6 +721,13 @@ static int ll_front_merge_fn(struct request *req, struct bio *bio,
>  		return 0;
>  	}
>
> +	if (req->cmd_flags & REQ_ATOMIC) {
> +		if (rq_straddles_atomic_write_boundary(req,
> +				bio->bi_iter.bi_size, 0)) {
> +			return 0;
> +		}
> +	}
> +
>  	return ll_new_hw_segment(req, bio, nr_segs);
>  }
>
> @@ -700,6 +764,13 @@ static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
>  	    blk_rq_get_max_sectors(req, blk_rq_pos(req)))
>  		return 0;
>
> +	if (req->cmd_flags & REQ_ATOMIC) {
> +		if (rq_straddles_atomic_write_boundary(req,
> +				0, blk_rq_bytes(next))) {
> +			return 0;
> +		}
> +	}
> +
>  	total_phys_segments = req->nr_phys_segments + next->nr_phys_segments;
>  	if (total_phys_segments > blk_rq_get_max_segments(req))
>  		return 0;
> @@ -795,6 +866,18 @@ static enum elv_merge blk_try_req_merge(struct request *req,
>  	return ELEVATOR_NO_MERGE;
>  }
>
> +static bool blk_atomic_write_mergeable_rq_bio(struct request *rq,
> +					      struct bio *bio)
> +{
> +	return (rq->cmd_flags & REQ_ATOMIC) == (bio->bi_opf & REQ_ATOMIC);
> +}
> +
> +static bool blk_atomic_write_mergeable_rqs(struct request *rq,
> +					   struct request *next)
> +{
> +	return (rq->cmd_flags & REQ_ATOMIC) == (next->cmd_flags & REQ_ATOMIC);
> +}
> +
>  /*
>   * For non-mq, this has to be called with the request spinlock acquired.
>   * For mq with scheduling, the appropriate queue wide lock should be held.
> @@ -814,6 +897,9 @@ static struct request *attempt_merge(struct request_queue *q,
>  	if (req->ioprio != next->ioprio)
>  		return NULL;
>
> +	if (!blk_atomic_write_mergeable_rqs(req, next))
> +		return NULL;
> +
>  	/*
>  	 * If we are allowed to merge, then append bio list
>  	 * from next to rq and release next. merge_requests_fn
> @@ -941,6 +1027,9 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
>  	if (rq->ioprio != bio_prio(bio))
>  		return false;
>
> +	if (blk_atomic_write_mergeable_rq_bio(rq, bio) == false)
> +		return false;
> +
>  	return true;
>  }
>
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
> +
> +/**
> + * blk_queue_atomic_write_boundary_bytes - Device's logical block address space
> + * which an atomic write should not cross.
> + * @q:  the request queue for the device
> + * @bytes: must be a power-of-two.
> + */
> +void blk_queue_atomic_write_boundary_bytes(struct request_queue *q,
> +					   unsigned int bytes)
> +{
> +	q->limits.atomic_write_hw_boundary_sectors = bytes >> SECTOR_SHIFT;
> +}
> +EXPORT_SYMBOL(blk_queue_atomic_write_boundary_bytes);
> +
> +/**
> + * blk_queue_atomic_write_unit_min_sectors - smallest unit that can be written
> + * atomically to the device.
> + * @q:  the request queue for the device
> + * @sectors: must be a power-of-two.
> + */
> +void blk_queue_atomic_write_unit_min_sectors(struct request_queue *q,
> +					     unsigned int sectors)
> +{
> +
> +	q->limits.atomic_write_hw_unit_min_sectors = sectors;
> +	blk_atomic_writes_update_limits(q);
> +}
> +EXPORT_SYMBOL(blk_queue_atomic_write_unit_min_sectors);
> +
> +/*
> + * blk_queue_atomic_write_unit_max_sectors - largest unit that can be written
> + * atomically to the device.
> + * @q: the request queue for the device
> + * @sectors: must be a power-of-two.
> + */
> +void blk_queue_atomic_write_unit_max_sectors(struct request_queue *q,
> +					     unsigned int sectors)
> +{
> +	q->limits.atomic_write_hw_unit_max_sectors = sectors;
> +	blk_atomic_writes_update_limits(q);
> +}
> +EXPORT_SYMBOL(blk_queue_atomic_write_unit_max_sectors);
> +
>  /**
>   * blk_queue_max_secure_erase_sectors - set max sectors for a secure erase
>   * @q:  the request queue for the device
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 6b2429cad81a..3978f14f9769 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -118,6 +118,30 @@ static ssize_t queue_max_discard_segments_show(struct request_queue *q,
>  	return queue_var_show(queue_max_discard_segments(q), page);
>  }
>
> +static ssize_t queue_atomic_write_max_bytes_show(struct request_queue *q,
> +						char *page)
> +{
> +	return queue_var_show(queue_atomic_write_max_bytes(q), page);
> +}
> +
> +static ssize_t queue_atomic_write_boundary_show(struct request_queue *q,
> +						char *page)
> +{
> +	return queue_var_show(queue_atomic_write_boundary_bytes(q), page);
> +}
> +
> +static ssize_t queue_atomic_write_unit_min_show(struct request_queue *q,
> +						char *page)
> +{
> +	return queue_var_show(queue_atomic_write_unit_min_bytes(q), page);
> +}
> +
> +static ssize_t queue_atomic_write_unit_max_show(struct request_queue *q,
> +						char *page)
> +{
> +	return queue_var_show(queue_atomic_write_unit_max_bytes(q), page);
> +}
> +
>  static ssize_t queue_max_integrity_segments_show(struct request_queue *q, char *page)
>  {
>  	return queue_var_show(q->limits.max_integrity_segments, page);
> @@ -502,6 +526,11 @@ QUEUE_RO_ENTRY(queue_discard_max_hw, "discard_max_hw_bytes");
>  QUEUE_RW_ENTRY(queue_discard_max, "discard_max_bytes");
>  QUEUE_RO_ENTRY(queue_discard_zeroes_data, "discard_zeroes_data");
>
> +QUEUE_RO_ENTRY(queue_atomic_write_max_bytes, "atomic_write_max_bytes");
> +QUEUE_RO_ENTRY(queue_atomic_write_boundary, "atomic_write_boundary_bytes");
> +QUEUE_RO_ENTRY(queue_atomic_write_unit_max, "atomic_write_unit_max_bytes");
> +QUEUE_RO_ENTRY(queue_atomic_write_unit_min, "atomic_write_unit_min_bytes");
> +
>  QUEUE_RO_ENTRY(queue_write_same_max, "write_same_max_bytes");
>  QUEUE_RO_ENTRY(queue_write_zeroes_max, "write_zeroes_max_bytes");
>  QUEUE_RO_ENTRY(queue_zone_append_max, "zone_append_max_bytes");
> @@ -629,6 +658,10 @@ static struct attribute *queue_attrs[] = {
>  	&queue_discard_max_entry.attr,
>  	&queue_discard_max_hw_entry.attr,
>  	&queue_discard_zeroes_data_entry.attr,
> +	&queue_atomic_write_max_bytes_entry.attr,
> +	&queue_atomic_write_boundary_entry.attr,
> +	&queue_atomic_write_unit_min_entry.attr,
> +	&queue_atomic_write_unit_max_entry.attr,
>  	&queue_write_same_max_entry.attr,
>  	&queue_write_zeroes_max_entry.attr,
>  	&queue_zone_append_max_entry.attr,
> diff --git a/block/blk.h b/block/blk.h
> index 050696131329..6ba8333fcf26 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -178,6 +178,9 @@ static inline unsigned int blk_queue_get_max_sectors(struct request *rq)
>  	if (unlikely(op == REQ_OP_WRITE_ZEROES))
>  		return q->limits.max_write_zeroes_sectors;
>
> +	if (rq->cmd_flags & REQ_ATOMIC)
> +		return q->limits.atomic_write_max_sectors;
> +
>  	return q->limits.max_sectors;
>  }
>
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index f288c94374b3..cd7cceb8565d 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -422,6 +422,7 @@ enum req_flag_bits {
>  	__REQ_DRV,		/* for driver use */
>  	__REQ_FS_PRIVATE,	/* for file system (submitter) use */
>
> +	__REQ_ATOMIC,		/* for atomic write operations */
>  	/*
>  	 * Command specific flags, keep last:
>  	 */
> @@ -448,6 +449,7 @@ enum req_flag_bits {
>  #define REQ_RAHEAD	(__force blk_opf_t)(1ULL << __REQ_RAHEAD)
>  #define REQ_BACKGROUND	(__force blk_opf_t)(1ULL << __REQ_BACKGROUND)
>  #define REQ_NOWAIT	(__force blk_opf_t)(1ULL << __REQ_NOWAIT)
> +#define REQ_ATOMIC	(__force blk_opf_t)(1ULL << __REQ_ATOMIC)

Let's add this in the same order as of __REQ_ATOMIC i.e. after
REQ_FS_PRIVATE macro

>  #define REQ_POLLED	(__force blk_opf_t)(1ULL << __REQ_POLLED)
>  #define REQ_ALLOC_CACHE	(__force blk_opf_t)(1ULL << __REQ_ALLOC_CACHE)
>  #define REQ_SWAP	(__force blk_opf_t)(1ULL << __REQ_SWAP)
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 99e4f5e72213..40ed56ef4937 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -299,6 +299,14 @@ struct queue_limits {
>  	unsigned int		discard_alignment;
>  	unsigned int		zone_write_granularity;
>
> +	unsigned int		atomic_write_hw_max_sectors;
> +	unsigned int		atomic_write_max_sectors;
> +	unsigned int		atomic_write_hw_boundary_sectors;
> +	unsigned int		atomic_write_hw_unit_min_sectors;
> +	unsigned int		atomic_write_unit_min_sectors;
> +	unsigned int		atomic_write_hw_unit_max_sectors;
> +	unsigned int		atomic_write_unit_max_sectors;
> +

1 liner comment for above members please?

>  	unsigned short		max_segments;
>  	unsigned short		max_integrity_segments;
>  	unsigned short		max_discard_segments;
> @@ -885,6 +893,14 @@ void blk_queue_zone_write_granularity(struct request_queue *q,
>  				      unsigned int size);
>  extern void blk_queue_alignment_offset(struct request_queue *q,
>  				       unsigned int alignment);
> +void blk_queue_atomic_write_max_bytes(struct request_queue *q,
> +				unsigned int bytes);
> +void blk_queue_atomic_write_unit_max_sectors(struct request_queue *q,
> +				unsigned int sectors);
> +void blk_queue_atomic_write_unit_min_sectors(struct request_queue *q,
> +				unsigned int sectors);
> +void blk_queue_atomic_write_boundary_bytes(struct request_queue *q,
> +				unsigned int bytes);
>  void disk_update_readahead(struct gendisk *disk);
>  extern void blk_limits_io_min(struct queue_limits *limits, unsigned int min);
>  extern void blk_queue_io_min(struct request_queue *q, unsigned int min);
> @@ -1291,6 +1307,30 @@ static inline int queue_dma_alignment(const struct request_queue *q)
>  	return q ? q->limits.dma_alignment : 511;
>  }
>
> +static inline unsigned int
> +queue_atomic_write_unit_max_bytes(const struct request_queue *q)
> +{
> +	return q->limits.atomic_write_unit_max_sectors << SECTOR_SHIFT;
> +}
> +
> +static inline unsigned int
> +queue_atomic_write_unit_min_bytes(const struct request_queue *q)
> +{
> +	return q->limits.atomic_write_unit_min_sectors << SECTOR_SHIFT;
> +}
> +
> +static inline unsigned int
> +queue_atomic_write_boundary_bytes(const struct request_queue *q)
> +{
> +	return q->limits.atomic_write_hw_boundary_sectors << SECTOR_SHIFT;
> +}
> +
> +static inline unsigned int
> +queue_atomic_write_max_bytes(const struct request_queue *q)
> +{
> +	return q->limits.atomic_write_max_sectors << SECTOR_SHIFT;
> +}
> +
>  static inline unsigned int bdev_dma_alignment(struct block_device *bdev)
>  {
>  	return queue_dma_alignment(bdev_get_queue(bdev));
> @@ -1540,6 +1580,26 @@ struct io_comp_batch {
>  	void (*complete)(struct io_comp_batch *);
>  };
>
> +static inline bool bdev_can_atomic_write(struct block_device *bdev)
> +{
> +	struct request_queue *bd_queue = bdev->bd_queue;
> +	struct queue_limits *limits = &bd_queue->limits;
> +
> +	if (!limits->atomic_write_unit_min_sectors)
> +		return false;
> +
> +	if (bdev_is_partition(bdev)) {
> +		sector_t bd_start_sect = bdev->bd_start_sect;
> +		unsigned int granularity = max(

atomic_align perhaps?

> +				limits->atomic_write_unit_min_sectors,
> +				limits->atomic_write_hw_boundary_sectors);
> +		if (do_div(bd_start_sect, granularity))
> +			return false;
> +	}

since atomic_align is a power of 2. Why not use IS_ALIGNED()?
(bitwise operation instead of div)?

> +
> +	return true;
> +}
> +
>  #define DEFINE_IO_COMP_BATCH(name)	struct io_comp_batch name = { }
>
>  #endif /* _LINUX_BLKDEV_H */
> --
> 2.31.1

-ritesh

