From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 4 Dec 2018 14:27:51 -0800
Subject: [PATCH] nvme-core: small cleanups
In-Reply-To: <20181129171804.5241-1-chaitanya.kulkarni@wdc.com>
References: <20181129171804.5241-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20181204222751.GA18078@infradead.org>

>  	c.identify.nsid = cpu_to_le32(nsid);
> @@ -1565,10 +1569,7 @@ static int nvme_revalidate_disk(struct gendisk *disk)
>  	}
>  
>  	id = nvme_identify_ns(ctrl, ns->head->ns_id);
> -	if (!id)
> -		return -ENODEV;
> -
> -	if (id->ncap == 0) {
> +	if (!id || id->ncap == 0) {

This now moves to kfree id which wasn't even allocated.

I think we can just drop the rest of the patch as well, it isn't
really worth the churn.
