From: willy@linux.intel.com (Matthew Wilcox)
Date: Tue, 8 Dec 2015 13:53:25 -0500
Subject: [PATCH] NVMe: Expose namespace unique identifier to sysfs
In-Reply-To: <1449595605-20735-1-git-send-email-keith.busch@intel.com>
References: <1449595605-20735-1-git-send-email-keith.busch@intel.com>
Message-ID: <20151208185325.GC2457@linux.intel.com>

On Tue, Dec 08, 2015@10:26:45AM -0700, Keith Busch wrote:
> A controller namespace supporting 1.1 or 1.2 capabilities uniquely
> identifies itself with either the 64-bit EUI or 128-bit NGUID.
> 
> This patch determines which the device supports and reports the unique
> identifier in new sysfs binary attribute "uuid". The attribute group is
> added to the gendisk's kobject directory.

I don't understand why we want to produce a binary attribute here instead
of a text attribute?  We already have nicely-formatted UUIDs in sysfs
(see the %pU specifier to printk)

I don't think we should have one attribute that might be an eui64 or might
be a uuid.  Maybe we should produce either an eui64 or a uuid attribute,
depending on which one the device reports?

> +	if (ns->ctrl->vs >= NVME_VS(1, 1)) {
> +		u8 *identifier = id->eui64;
> +		int len = sizeof(id->eui64);
> +
> +		if (bitmap_empty((void *)identifier, len * 8) &&
> +					ns->ctrl->vs >= NVME_VS(1, 2)) {
> +			identifier = id->nguid;
> +			len = sizeof(id->nguid);
> +		}

I'm a bit reluctant to use bitmap_empty here, because it's not actually
a bitmap.  We almost want the inverse of memchr ("find me the first
byte that is non-zero").  Maybe somebody else knows a better functoin
to call here?

> +	add_disk(ns->disk);
> +	if (sysfs_create_group(&disk_to_dev(ns->disk)->kobj,
> +			&nvme_ns_attrs_group)) {
> +		del_gendisk(ns->disk);
> +		nvme_put_ctrl(ctrl);
> +		goto out_free_queue;
> +	}
>  	return;
>   out_free_disk:
>  	kfree(disk);

An interesting philosophical point ... if creating the group fails,
should we really refuse to use the namespace?  It seems to me that we
can use it just fine.
