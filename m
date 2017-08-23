From: keith.busch@intel.com (Keith Busch)
Date: Wed, 23 Aug 2017 18:53:00 -0400
Subject: [PATCH 10/10] nvme: implement multipath access to nvme subsystems
In-Reply-To: <20170823175815.3646-11-hch@lst.de>
References: <20170823175815.3646-1-hch@lst.de>
 <20170823175815.3646-11-hch@lst.de>
Message-ID: <20170823225259.GD16596@localhost.localdomain>

On Wed, Aug 23, 2017@07:58:15PM +0200, Christoph Hellwig wrote:
> 
> TODO: implement sysfs interfaces for the new subsystem and
> subsystem-namespace object.  Unless we can come up with something
> better than sysfs here..

Can we get symlinks from the multipath'ed nvme block device to the
individual paths? I think it should be something like the following:
 
> @@ -2616,6 +2821,10 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  	if (ns->ndev && nvme_nvm_register_sysfs(ns))
>  		pr_warn("%s: failed to register lightnvm sysfs group for identification\n",
>  			ns->disk->disk_name);
> +
> +	if (new)
> +		add_disk(ns->head->disk);
+
+	sysfs_create_link(&disk_to_dev(ns->head->disk)->kobj,
+			  &disk_to_dev(ns->disk)->kobj,
+			  ns->disk->name);
