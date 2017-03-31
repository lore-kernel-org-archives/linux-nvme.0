From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 31 Mar 2017 14:49:01 -0400
Subject: [RFC 1/8] Introduce Peer-to-Peer memory (p2pmem) device
In-Reply-To: <1490911959-5146-2-git-send-email-logang@deltatee.com>
References: <1490911959-5146-1-git-send-email-logang@deltatee.com>
 <1490911959-5146-2-git-send-email-logang@deltatee.com>
Message-ID: <cb102386-0314-a3a3-ed44-b42debdf1512@codeaurora.org>

Hi Logan,

> +/**
> + * p2pmem_unregister() - unregister a p2pmem device
> + * @p: the device to unregister
> + *
> + * The device will remain until all users are done with it
> + */
> +void p2pmem_unregister(struct p2pmem_dev *p)
> +{
> +	if (!p)
> +		return;
> +
> +	dev_info(&p->dev, "unregistered");
> +	device_del(&p->dev);
> +	ida_simple_remove(&p2pmem_ida, p->id);

Don't you need to clean up the p->pool here.

> +	put_device(&p->dev);
> +}
> +EXPORT_SYMBOL(p2pmem_unregister);
> +

I don't like the ugliness around the switch port to be honest. 

Going to whitelist/blacklist looks simpler in my opinion.

Sinan


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
