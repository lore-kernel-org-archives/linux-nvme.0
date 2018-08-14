From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Tue, 14 Aug 2018 15:20:33 +0000
Subject: [PATCH 2/5] nvme: register ns_id attributes as default sysfs
 groups
In-Reply-To: <20180814073305.87255-3-hare@suse.de>
References: <20180814073305.87255-1-hare@suse.de>
 <20180814073305.87255-3-hare@suse.de>
Message-ID: <5a4aab8b5f509d8090ad10107b01d11285fe1528.camel@wdc.com>

On Tue, 2018-08-14@09:33 +0200, Hannes Reinecke wrote:
> +const struct attribute_group *nvme_ns_id_attr_groups[] = {
> +	&nvme_ns_id_attr_group,
> +	NULL, /* Will be filled in by lightnvm if present */
> +	NULL,
> +};
[ ... ]
> -void nvme_nvm_unregister_sysfs(struct nvme_ns *ns)
> -{
> -	struct nvm_dev *ndev = ns->ndev;
> -	struct nvm_geo *geo = &ndev->geo;
> +		return;
>  
>  	switch (geo->major_ver_id) {
>  	case 1:
> -		sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
> -					&nvm_dev_attr_group_12);
> +		nvme_ns_id_attr_groups[1] = &nvm_dev_attr_group_12;
>  		break;
>  	case 2:
> -		sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
> -					&nvm_dev_attr_group_20);
> +		nvme_ns_id_attr_groups[1] = &nvm_dev_attr_group_20;

This patch introduces a really ugly dependency between the NVMe core code and
the lightnvm code, namely that the lightnvm code has to know at which position
in the nvme_ns_id_attr_groups it can fill in its attribute group pointer. Have
you considered to make nvme_nvm_register_sysfs() return an attribute group
pointer such that the nvme_ns_id_attr_groups can be changed from a global into
a static array?

Thanks,

Bart.
