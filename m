From: sergey.senozhatsky.work@gmail.com (Sergey Senozhatsky)
Date: Thu, 18 Aug 2016 11:06:37 +0900
Subject: [PATCH 11/15] zram: Pass attribute group to device_add_disk
In-Reply-To: <20160818015901.GA499@swordfish>
References: <1471418115-3654-1-git-send-email-famz@redhat.com>
 <1471418115-3654-12-git-send-email-famz@redhat.com>
 <20160818015901.GA499@swordfish>
Message-ID: <20160818020637.GA500@swordfish>

On (08/18/16 10:59), Sergey Senozhatsky wrote:
[..]
> I like the previous "Error creating sysfs group for device" string better,
> than "Error creating disk", because the latter one is much less informative.
> 
> do you want to do something like below?
> 
> int device_add_disk(struct device *parent, struct gendisk *disk,
> ...
>        if (attr_group) {
>                retval = sysfs_create_group(&disk_to_dev(disk)->kobj,
>                                            attr_group);
> 
> +		pr_err("Error creating sysfs group for device ...\n", ...);

d'oh... a typo. pr_err() is meant to be in `if (retval)' branch.

>                if (retval)
>                        goto fail;
>        }

	-ss
