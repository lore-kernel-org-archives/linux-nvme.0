From: hch@lst.de (Christoph Hellwig)
Date: Tue, 24 Apr 2018 19:22:15 +0200
Subject: [PATCH 04/20] nvmet: initialize file handle and req fields
In-Reply-To: <20180418190011.3973-5-chaitanya.kulkarni@wdc.com>
References: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
 <20180418190011.3973-5-chaitanya.kulkarni@wdc.com>
Message-ID: <20180424172215.GB30391@lst.de>

> +static int nvmet_ns_enable_file(struct nvmet_ns *ns)
> +{
> +	int ret;
> +	int flags = O_RDWR | O_LARGEFILE | O_DIRECT;
> +	struct kstat stat;
> +
> +	ns->filp = filp_open(ns->device_path, flags, 0);
> +	if (!ns->filp || IS_ERR(ns->filp)) {
> +		pr_err("failed to open file %s: (%ld)\n",
> +				ns->device_path, PTR_ERR(ns->bdev));
> +		ns->filp = NULL;
> +		return -1;
> +	}
> +
> +	ret = nvmet_vfs_stat(ns->device_path, &stat);
> +	if (ret)
> +		goto err;

Just call vfs_getattr on file->f_path instead of this nvmet_vfs_stat
helper that isn't really needed.

> +	ns->blksize_shift = ns->filp->f_inode->i_blkbits;

Pleae use file_inode() to get an inode from the file instead of the
direct reference to accomodate overlayfs and other stackable file
systems.

> +
> +	return ret;
> +err:
> +	filp_close(ns->filp, NULL);

This should be a fput instead.

>  static int nvmet_ns_dev_enable(struct nvmet_ns *ns)
>  {
> -	return nvmet_ns_enable_blk(ns);
> +	int ret = 0;
> +	int ret1 = 0;
> +
> +	ret = nvmet_ns_enable_blk(ns);
> +	if (ret)
> +		ret1 = nvmet_ns_enable_file(ns);
> +
> +	if (ret && ret1)
> +		return -1;

I don't think there is any good reason to keep the blk open return
value, e.g. this could simpl be:

	ret = nvmet_ns_enable_blk(ns);
	if (ret)
		ret = nvmet_ns_enable_file(ns);

The file open return value is probably more useful in general.

>  }
>  
>  static void nvmet_ns_dev_disable(struct nvmet_ns *ns)
> @@ -299,7 +351,11 @@ static void nvmet_ns_dev_disable(struct nvmet_ns *ns)
>  	if (ns->bdev) {
>  		blkdev_put(ns->bdev, FMODE_WRITE | FMODE_READ);
>  		ns->bdev = NULL;
> -	}
> +	} else if (ns->filp) {
> +		filp_close(ns->filp, NULL);

fput again.
