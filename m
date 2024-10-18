Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D184ED3C550
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Oct 2024 05:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W7Rh+kY+sJ75UNyd7iBIkwHwbcWiDnBq2/a8rAFcYkQ=; b=wil9qJzYxauBZu+dFLsT2EgA1C
	TE+3WeR/LhmwRD9QP5zIsZC+Ph9xkahF5TcqJRVtklLxKC6fttwIAftGFSmMWhK8s6FQvbQQ+6MSD
	BK25gs8HVK7+tjaw2ZnDEcaBYWJVCIHOhcPwCsx1+cLBZSOfily54Z760kygyU7u1wJxlWttPKbA0
	7w3ByAtibjIso+6mklh8nuyap2cNPKjZ96hahHuYE7QIW64UANg2gnaP3NNl4gWzuOk0F6G+wjz0h
	o00wbrRtL8cQag1iU6lxylRfOdxFmcFbK6Pm5mnbFlOW+eNoAaNImISKYekbQwti6LUCVeW6W0mJc
	Be7M51Jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1fyL-0000000H2hs-009F;
	Fri, 18 Oct 2024 05:56:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1fsi-0000000H1II-210H
	for linux-nvme@lists.infradead.org;
	Fri, 18 Oct 2024 05:50:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 19F25227AAF; Fri, 18 Oct 2024 07:50:33 +0200 (CEST)
Date: Fri, 18 Oct 2024 07:50:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, hch@lst.de, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, joshi.k@samsung.com,
	javier.gonz@samsung.com, Nitesh Shetty <nj.shetty@samsung.com>,
	Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv8 1/6] block, fs: restore kiocb based write hint
 processing
Message-ID: <20241018055032.GB20262@lst.de>
References: <20241017160937.2283225-1-kbusch@meta.com> <20241017160937.2283225-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017160937.2283225-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_225036_682620_84FFB8C4 
X-CRM114-Status: GOOD (  23.06  )
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

On Thu, Oct 17, 2024 at 09:09:32AM -0700, Keith Busch wrote:
> From: Kanchan Joshi <joshi.k@samsung.com>
> 
> struct kiocb has a 2 bytes hole that developed post commit 41d36a9f3e53
> ("fs: remove kiocb.ki_hint"). But write hint returned with commit
> 449813515d3e ("block, fs: Restore the per-bio/request data lifetime
> fields").
> 
> This patch uses the leftover space in kiocb to carve 2 byte field
> ki_write_hint. Restore the code that operates on kiocb to use
> ki_write_hint instead of inode hint value.
> 
> This does not change any behavior, but needed to enable per-io hints.

In this version it doesn't really restore anything, but adds a new
write hinting capability.   Similarly to the bio patch we'll probably
need to make clear what is in there instead of having it completely
untyped (the exact same appraoch as for the bio should work).

> index bbd05f1a21453..73629e26becbe 100644
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -409,7 +409,7 @@ dio_bio_alloc(struct dio *dio, struct dio_submit *sdio,
>  		bio->bi_end_io = dio_bio_end_io;
>  	if (dio->is_pinned)
>  		bio_set_flag(bio, BIO_PAGE_PINNED);
> -	bio->bi_write_hint = file_inode(dio->iocb->ki_filp)->i_write_hint;
> +	bio->bi_write_hint = dio->iocb->ki_write_hint;
>  
>  	sdio->bio = bio;
>  	sdio->logical_offset_in_bio = sdio->cur_page_fs_offset;
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index f637aa0706a31..fff43f121ee65 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -397,7 +397,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  		fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
>  					  GFP_KERNEL);
>  		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
> -		bio->bi_write_hint = inode->i_write_hint;
> +		bio->bi_write_hint = dio->iocb->ki_write_hint;

File system (helper) code should not directly apply this limit,
but the file system needs to set it.

> +static inline enum rw_hint file_write_hint(struct file *filp)
> +{
> +	return file_inode(filp)->i_write_hint;
> +}
> +
>  static inline void init_sync_kiocb(struct kiocb *kiocb, struct file *filp)
>  {
>  	*kiocb = (struct kiocb) {
>  		.ki_filp = filp,
>  		.ki_flags = filp->f_iocb_flags,
>  		.ki_ioprio = get_current_ioprio(),
> +		.ki_write_hint = file_write_hint(filp),

And we'll need to distinguish between the per-inode and per file
hint.  I.e. don't blindly initialize ki_write_hint to the per-inode
one here, but make that conditional in the file operation.


