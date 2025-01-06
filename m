Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7AE7E77198
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2025 10:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9tFCjF2qSoUQ2okYhm3Eqj9U/WxFsSrc4ePNxZuJEgU=; b=Zm87R7ha15atOG6slgv6KFam36
	Tjb0BGbczLT7Tc8r0Wh7nTjjqyiiMND4JA317pC7v9aoxf9npB3mwQSWy9YSTKGx0NqFbtluCB4sj
	OlDh19qO2jg6u/817xtAcZ8bw9i3Yq3euSNEtUgcXBmAkpl4n/VbWa22w0GEfSf3QLDCLKgDCZJNo
	4MZ3LzSsjyDoSg//pVHbeNOTqPwMQMDeRotkYNMcDxbjDP/3YVYgS2J9HfE/hRZLovoUS8dtVT6+t
	3TvFwK0IA5WU/JXk2LgzZ9WgZcOuBvU0u63CQ9uy/rOQi5N+EgKkg+Mo6xtQBv7mm0woQizHixQzq
	SXO9jjzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUkWX-00000000tMh-3Fto;
	Mon, 06 Jan 2025 10:39:53 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUkWU-00000000tM7-25rx
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jan 2025 10:39:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id C2BFDA413F1;
	Mon,  6 Jan 2025 10:38:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 386FBC4CED2;
	Mon,  6 Jan 2025 10:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736159989;
	bh=yxjR/msICYPQyNZp7VDsz8GJNakeVo6N3uxmzscuuTY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UVVmQ8ZK+ThglmGt6ZKcBZ8e3Syi47x1JsCOXZmKrmzeT8NL8LNSml09e4pLj8f0q
	 pHDd+4P6vumMFzMhsTDORIlbRMMJ4rjGHC76Vml3Sk/7tYcG2Vn/vWhAiJXJl5EGmT
	 iyD26odNze8G9REiz4+4dDmA0loqA7KflPCNGYVjESgmfSAO28o9ClZPouZNzagXE5
	 /g46KRsdgZckZ3u0NMMDyFJVMHNIWnwLC73TJUunDcfVDBw0ZMMOYc8KNjO85mCbr1
	 lNDjWjuppATfLW58GzGKlE3+/LYQDLzYckJvXDH1dKkCcJuDAIw1BPoAibDflN/A+1
	 urF5oZuX6khnQ==
Message-ID: <89e35fd6-830c-46b7-a0c3-284bc120d424@kernel.org>
Date: Mon, 6 Jan 2025 19:39:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] block: fix docs for freezing of queue limits
 updates
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, Nilay Shroff <nilay@linux.ibm.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 nbd@other.debian.org, virtualization@lists.linux.dev,
 linux-scsi@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
References: <20250106100645.850445-1-hch@lst.de>
 <20250106100645.850445-2-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250106100645.850445-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_023950_613650_8E8F67B5 
X-CRM114-Status: GOOD (  20.38  )
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

On 1/6/25 7:06 PM, Christoph Hellwig wrote:
> queue_limits_commit_update is the function that needs to operate on a
> frozen queue, not queue_limits_start_update.  Update the kerneldoc
> comments to reflect that.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-settings.c   | 3 ++-
>  include/linux/blkdev.h | 3 +--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 8f09e33f41f6..4187c3e8a07f 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -413,7 +413,8 @@ int blk_set_default_limits(struct queue_limits *lim)
>   * @lim:	limits to apply
>   *
>   * Apply the limits in @lim that were obtained from queue_limits_start_update()
> - * and updated by the caller to @q.
> + * and updated by the caller to @q.  The caller must have frozen the queue or
> + * ensured that there is outstanding I/O by other means.

...ensure that there are no outstanding I/Os by other means.

>   *
>   * Returns 0 if successful, else a negative error code.
>   */
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 5d40af2ef971..e781d4e6f92d 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -944,8 +944,7 @@ static inline unsigned int blk_boundary_sectors_left(sector_t offset,
>   * the caller can modify.  The caller must call queue_limits_commit_update()
>   * to finish the update.
>   *
> - * Context: process context.  The caller must have frozen the queue or ensured
> - * that there is outstanding I/O by other means.
> + * Context: process context.
>   */
>  static inline struct queue_limits
>  queue_limits_start_update(struct request_queue *q)


-- 
Damien Le Moal
Western Digital Research

