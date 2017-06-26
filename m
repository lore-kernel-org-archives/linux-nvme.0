From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 26 Jun 2017 02:55:06 -0700
Subject: [PATCH 4/9] fs: add O_DIRECT support for sending down write life
 time hints
In-Reply-To: <1498004526-4543-5-git-send-email-axboe@kernel.dk>
References: <1498004526-4543-1-git-send-email-axboe@kernel.dk>
 <1498004526-4543-5-git-send-email-axboe@kernel.dk>
Message-ID: <20170626095506.GE14057@infradead.org>

> @@ -385,6 +385,8 @@ dio_bio_alloc(struct dio *dio, struct dio_submit *sdio,
>  	else
>  		bio->bi_end_io = dio_bio_end_io;
>  
> +	bio->bi_opf |= write_hint_to_opf(iocb_write_hint(dio->iocb));
> +
>  	sdio->bio = bio;
>  	sdio->logical_offset_in_bio = sdio->cur_page_fs_offset;
>  }
> diff --git a/fs/iomap.c b/fs/iomap.c
> index c71a64b97fba..9c9f8406018b 100644
> --- a/fs/iomap.c
> +++ b/fs/iomap.c
> @@ -804,6 +804,7 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
>  
>  		if (dio->flags & IOMAP_DIO_WRITE) {
>  			bio_set_op_attrs(bio, REQ_OP_WRITE, REQ_SYNC | REQ_IDLE);
> +			bio->bi_opf |= write_hint_to_opf(inode_write_hint(inode));

This should be iocb based as well, otherwise you'll miss out on
the per-file hints.

Also please don't add a > 80 char line.  (And yes, I should fix the one
just above, too)

>  			task_io_account_write(bio->bi_iter.bi_size);
>  		} else {
>  			bio_set_op_attrs(bio, REQ_OP_READ, 0);
> -- 
> 2.7.4
> 
---end quoted text---
