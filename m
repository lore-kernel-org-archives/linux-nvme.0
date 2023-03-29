Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD3BC74A5B
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Mar 2023 12:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T9kM4LUmcniYXGaxhhwKhusS2XuzAA7gUfA+apMM1ww=; b=14zyTvEnFlp3RN1ShFRFu8+m/J
	V45Nh+ukvhM/hjR45lz8GQAF/GNcZv74gSM2qoSaChXkhCwkatuRCwN+KOSEawUPpuQzyoVO0RdiQ
	K1lBjFcbHYeI0ylbLP03RS8dVphI755pwQj9Sq2Aec2egizkELTW2rgK4HD2axMc+1/5MllrQPKuH
	MypSwUiC4OvQbqJEWJYlHa4MjDGUDkIPq7cqbhz9MJJU3OWVA2+n7NZ9mESz1C4CjUjknc4bW4Z84
	FuWaLvPWtq6rwiO+r//qpgcOW7fn8PIdy72fvRcZr6vq35fw6VYRZQrKx2x29ofEKghn0U6B8vzfZ
	rqkiI+yA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phUhf-000A1H-2d;
	Wed, 29 Mar 2023 12:14:59 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phUha-0009zn-1o
	for linux-nvme@lists.infradead.org;
	Wed, 29 Mar 2023 12:14:58 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 5783DB822F0;
	Wed, 29 Mar 2023 12:14:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1B7C433D2;
	Wed, 29 Mar 2023 12:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680092089;
	bh=Cq96Ecr1uXjVoaJWJyUxPHu037nrWz83m8M9Gjo4M0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KGfQ19JB/t5T8xfel5ekL7rIPIqjuGdUbpHu2TvFVfDJqzFnbriKg5iK3wfxALI59
	 5LyiLESlpTzJHFW/8lt+018tzaD7vZPajHSzbIU/DEnaaeuEg4k4RCEEfRugFAgOYR
	 m4DqhUtYK/1puiYULG8SOL55Wo0xxlZ0S513YrqIOLShG+zrSOD7j4MR7Fy5CLAsOW
	 nn4Qqp5Qeh+Rgu7KnCNo6kX6DX82G9OqAuv4aGfxbXXRpuHiefLuICveefVRrgufMz
	 KWcn2gniTr4BpCa5KHKzopGOqsKdRWruD0kdqIg9k6ZIVu2LqL7myHVVmrQ8JoGoPD
	 zDQW2N2v6MA6A==
Date: Wed, 29 Mar 2023 14:14:40 +0200
From: Christian Brauner <brauner@kernel.org>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, bvanassche@acm.org,
	hare@suse.de, ming.lei@redhat.com, damien.lemoal@opensource.wdc.com,
	joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
	Nitesh Shetty <nj.shetty@samsung.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v8 4/9] fs, block: copy_file_range for def_blk_ops for
 direct block device.
Message-ID: <20230329-glitter-drainpipe-bdf9d3876ac4@brauner>
References: <20230327084103.21601-1-anuj20.g@samsung.com>
 <CGME20230327084244epcas5p1b0ede867e558ff6faf258de3656a8aa4@epcas5p1.samsung.com>
 <20230327084103.21601-5-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230327084103.21601-5-anuj20.g@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230329_051454_937211_2C859338 
X-CRM114-Status: GOOD (  22.69  )
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

On Mon, Mar 27, 2023 at 02:10:52PM +0530, Anuj Gupta wrote:
> From: Nitesh Shetty <nj.shetty@samsung.com>
> 
> For direct block device opened with O_DIRECT, use copy_file_range to
> issue device copy offload, and fallback to generic_copy_file_range incase
> device copy offload capability is absent.
> Modify checks to allow bdevs to use copy_file_range.
> 
> Suggested-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> ---
>  block/blk-lib.c        | 22 ++++++++++++++++++++++
>  block/fops.c           | 20 ++++++++++++++++++++
>  fs/read_write.c        | 11 +++++++++--
>  include/linux/blkdev.h |  3 +++
>  4 files changed, 54 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-lib.c b/block/blk-lib.c
> index a21819e59b29..c288573c7e77 100644
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
> @@ -475,6 +475,28 @@ static inline bool blk_check_copy_offload(struct request_queue *q_in,
>  	return blk_queue_copy(q_in) && blk_queue_copy(q_out);
>  }
>  
> +int blkdev_copy_offload(struct block_device *bdev_in, loff_t pos_in,
> +		      struct block_device *bdev_out, loff_t pos_out, size_t len,
> +		      cio_iodone_t end_io, void *private, gfp_t gfp_mask)
> +{
> +	struct request_queue *in_q = bdev_get_queue(bdev_in);
> +	struct request_queue *out_q = bdev_get_queue(bdev_out);
> +	int ret = -EINVAL;

Why initialize to -EINVAL if blk_copy_sanity_check() initializes it
right away anyway?

> +	bool offload = false;

Same thing with initializing offload.

> +
> +	ret = blk_copy_sanity_check(bdev_in, pos_in, bdev_out, pos_out, len);
> +	if (ret)
> +		return ret;
> +
> +	offload = blk_check_copy_offload(in_q, out_q);
> +	if (offload)
> +		ret = __blk_copy_offload(bdev_in, pos_in, bdev_out, pos_out,
> +				len, end_io, private, gfp_mask);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(blkdev_copy_offload);
> +
>  /*
>   * @bdev_in:	source block device
>   * @pos_in:	source offset
> diff --git a/block/fops.c b/block/fops.c
> index d2e6be4e3d1c..3b7c05831d5c 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -611,6 +611,25 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  	return ret;
>  }
>  
> +static ssize_t blkdev_copy_file_range(struct file *file_in, loff_t pos_in,
> +				struct file *file_out, loff_t pos_out,
> +				size_t len, unsigned int flags)
> +{
> +	struct block_device *in_bdev = I_BDEV(bdev_file_inode(file_in));
> +	struct block_device *out_bdev = I_BDEV(bdev_file_inode(file_out));
> +	int comp_len = 0;
> +
> +	if ((file_in->f_iocb_flags & IOCB_DIRECT) &&
> +		(file_out->f_iocb_flags & IOCB_DIRECT))
> +		comp_len = blkdev_copy_offload(in_bdev, pos_in, out_bdev,
> +				 pos_out, len, NULL, NULL, GFP_KERNEL);
> +	if (comp_len != len)
> +		comp_len = generic_copy_file_range(file_in, pos_in + comp_len,
> +			file_out, pos_out + comp_len, len - comp_len, flags);

I'm not deeply familiar with this code but this looks odd. It at least
seems possible that comp_len could be -EINVAL and len 20 at which point
you'd be doing len - comp_len aka 20 - 22 = -2 in generic_copy_file_range().

