From: hch@lst.de (Christoph Hellwig)
Date: Wed, 24 Apr 2019 18:27:46 +0200
Subject: [PATCH V7 9/9] nvme: hold request queue's refcount in ns's
 whole lifetime
In-Reply-To: <20190424110221.17435-10-ming.lei@redhat.com>
References: <20190424110221.17435-1-ming.lei@redhat.com>
 <20190424110221.17435-10-ming.lei@redhat.com>
Message-ID: <20190424162746.GE23854@lst.de>

On Wed, Apr 24, 2019@07:02:21PM +0800, Ming Lei wrote:
> Hennes reported the following kernel oops:

Hannes?

> +	if (!blk_get_queue(ns->queue)) {
> +		ret = -ENXIO;
> +		goto out_free_queue;
> +	}

If we always need to hold a reference, shouldn't blk_mq_init_queue
return with that reference held (and yes, that means changes to
every driver, but it seems like we need to audit all of them anyway..)

It seems like the queue lifetimes are a bit of a mess, and I'm not sure
if this just papers over the problem.
