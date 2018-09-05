From: hch@lst.de (Christoph Hellwig)
Date: Wed, 5 Sep 2018 15:18:21 +0200
Subject: [PATCH 2/5] nvme: register ns_id attributes as default sysfs
 groups
In-Reply-To: <20180905070053.26239-3-hare@suse.de>
References: <20180905070053.26239-1-hare@suse.de>
 <20180905070053.26239-3-hare@suse.de>
Message-ID: <20180905131821.GA26956@lst.de>

On Wed, Sep 05, 2018@09:00:50AM +0200, Hannes Reinecke wrote:
> We should be registering the ns_id attribute as default sysfs
> attribute groups, otherwise we have a race condition between
> the uevent and the attributes appearing in sysfs.

Please give Bart credit for his work, as the lightnvm bits are almost
bigger than the rest.

> +static umode_t nvm_dev_attrs_visible(struct kobject *kobj,
> +				     struct attribute *attr, int index)
>  {
> +	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct gendisk *disk = dev_to_disk(dev);
> +	struct nvme_ns *ns = disk->private_data;
>  	struct nvm_dev *ndev = ns->ndev;
> +	struct device_attribute *dev_attr =
> +		container_of(attr, typeof(*dev_attr), attr);
>  
> +	if (dev_attr->show == nvm_dev_attr_show)
> +		return attr->mode;
>  
> +	switch (ndev ? ndev->geo.major_ver_id : 0) {

How could ndev be zero here?
