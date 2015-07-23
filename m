From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 23 Jul 2015 02:53:29 -0700
Subject: [PATCH v5 1/5] lightnvm: Support for Open-Channel SSDs
In-Reply-To: <1437587464-7964-2-git-send-email-mb@lightnvm.io>
References: <1437587464-7964-1-git-send-email-mb@lightnvm.io>
 <1437587464-7964-2-git-send-email-mb@lightnvm.io>
Message-ID: <20150723095329.GA26420@infradead.org>

Hi Matias,

I like this new architecture.

Minor nitpicks below:

> @@ -0,0 +1,598 @@
> +/*
> + * core.c - Open-channel SSD integration core

No need to state the file name in the top of the file comments, it
doesn't add value and get stale easily.

> +static LIST_HEAD(_targets);
> +static LIST_HEAD(_bms);
> +static LIST_HEAD(_devices);
> +static DECLARE_RWSEM(_lock);

Please add a nvm_ prefix to these.

> +static int nvm_ioctl(struct block_device *bdev, fmode_t mode, unsigned int cmd,
> +							unsigned long arg)
> +{
> +	return 0;
> +}
> +
> +static int nvm_open(struct block_device *bdev, fmode_t mode)
> +{
> +	return 0;
> +}
> +
> +static void nvm_release(struct gendisk *disk, fmode_t mode)
> +{
> +}


No need to implement these empty methods.

> +/* _lock must be taken */

Turn this into an lockdep_assert_held in the code, please.

> +int nvm_register(struct request_queue *q, struct gendisk *disk,
> +							struct nvm_dev_ops *ops)
> +{

No need to pass a gendisk here, in fact LighNVM low level driver
shouldn't even need to allocate one.  The only thing you seem to be
using here is the name anyway.

> +void nvm_unregister(struct gendisk *disk)

Same here.
