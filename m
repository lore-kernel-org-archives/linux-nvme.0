From: bvanassche@acm.org (Bart Van Assche)
Date: Wed, 24 Apr 2019 12:49:11 -0700
Subject: [PATCH] block: use static bio_set for bio_split() calls
In-Reply-To: <20190418140632.60606-1-hare@suse.de>
References: <20190418140632.60606-1-hare@suse.de>
Message-ID: <1556135351.161891.138.camel@acm.org>

On Thu, 2019-04-18@16:06 +0200, Hannes Reinecke wrote:
> +static int __init blk_bio_split_init(void)
> +{
> +       return bioset_init(&bio_split_bio_set, BIO_POOL_SIZE, 0,
> +                          BIOSET_NEED_BVECS);
> +}

The slab allocator uses __init for some of its initialization. Can it happen
that blk_bio_split_init() is called before slab initialization has finished?

Otherwise this patch looks fine to me.

Bart.
