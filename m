From: hch@lst.de (Christoph Hellwig)
Date: Tue, 24 Apr 2018 19:18:20 +0200
Subject: [PATCH 03/20] nvmet: add structure members for file I/O
In-Reply-To: <20180418190011.3973-4-chaitanya.kulkarni@wdc.com>
References: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
 <20180418190011.3973-4-chaitanya.kulkarni@wdc.com>
Message-ID: <20180424171820.GA30391@lst.de>

On Wed, Apr 18, 2018@02:59:54PM -0400, Chaitanya Kulkarni wrote:
> This patch adds new members to perform I/O operations on the
> file backed namespaces.

In general this should go along with actually adding the code.

> +	struct file		*filp;

Please call this file instead of filp.

>  	u32			nsid;
>  	u32			blksize_shift;
>  	loff_t			size;
> @@ -222,6 +224,8 @@ struct nvmet_req {
>  	struct scatterlist	*sg;
>  	struct bio		inline_bio;
>  	struct bio_vec		inline_bvec[NVMET_MAX_INLINE_BIOVEC];
> +	struct kiocb            iocb;
> +	struct bio_vec          *bvec;

Can this be unioned with any block devices fields?
