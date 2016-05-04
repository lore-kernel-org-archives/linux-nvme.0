From: keith.busch@intel.com (Busch, Keith)
Date: Wed, 4 May 2016 14:44:59 +0000
Subject: [PATCH v2] NVMe: eliminate potential deadlock by
 nvme_get_ns_from_disk invoking nvme_free_ns
In-Reply-To: <20160504095004.GA15483@lst.de>
References: <1462324114-3716-1-git-send-email-shhuiw@foxmail.com>
 <20160504095004.GA15483@lst.de>
Message-ID: <B58D82457FDA0744A320A2FC5AC253B93D57C07D@fmsmsx104.amr.corp.intel.com>


I can't be bothered to fix up my dev machines this week, so I get to reply with outlook. :(


> -----Original Message-----
> From: Christoph Hellwig [mailto:hch at lst.de]
> Sent: Wednesday, May 04, 2016 3:50 AM
> To: Wang Sheng-Hui
> Cc: hch at lst.de; sagig at mellanox.com; Busch, Keith; axboe at fb.com; linux-nvme at lists.infradead.org
> Subject: Re: [PATCH v2] NVMe: eliminate potential deadlock by nvme_get_ns_from_disk invoking
> nvme_free_ns

<snip>

> What about this variant instead?
> 
> 	ns = disk->private_data;
> 	if (ns) {
> 		if (!kref_get_unless_zero(&ns->kref))
> 			ns = NULL;
> 		else if (!try_module_get(ns->ctrl->ops->module))
> 			goto out_put_ns;
> 	}
> 	spin_unlock(&dev_list_lock);
> 	return ns;
> 
> out_put_ns:
> 	spin_unlock(&dev_list_lock);
> 	kref_put(&ns->kref, nvme_free_ns);
> 	return NULL;

I was trying to suggest a smaller change by swapping the module and ns reference order, then unwinding failure is simpler without goto's:

---
	spin_lock(&dev_list_lock);
	ns = disk->private_data;
	if (ns) {
		if (!try_module_get(ns->ctrl->ops->module))
			ns = NULL;
		else if (!kref_get_unless_zero(&ns->kref)) {
			module_put(ns->ctrl->ops->module);
			ns = NULL;
		}
	}
	spin_unlock(&dev_list_lock);

	return ns;
--
