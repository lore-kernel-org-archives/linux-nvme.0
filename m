From: willy@linux.intel.com (Matthew Wilcox)
Date: Wed, 1 May 2013 15:49:47 -0400
Subject: [PATCH] NVMe: Free allocated memory in probe failure
In-Reply-To: <1367435271-15784-4-git-send-email-keith.busch@intel.com>
References: <1367435271-15784-1-git-send-email-keith.busch@intel.com>
 <1367435271-15784-4-git-send-email-keith.busch@intel.com>
Message-ID: <20130501194947.GB6057@linux.intel.com>

On Wed, May 01, 2013@01:07:50PM -0600, Keith Busch wrote:
> When initializing in probe fails, free only the allocated memory.

'dev'is allocated using kzalloc, and kfree(NULL) is defined to be a no-op.
So having one 'free' label that frees all the memory is fine.

>  	dev->entry = kcalloc(num_possible_cpus(), sizeof(*dev->entry),
>  								GFP_KERNEL);
>  	if (!dev->entry)
> -		goto free;
> +		goto free_dev;
>  	dev->queues = kcalloc(num_possible_cpus() + 1, sizeof(void *),
>  								GFP_KERNEL);
>  	if (!dev->queues)
> -		goto free;
> +		goto free_entry;
>  
>  	if (pci_enable_device_mem(pdev))
>  		goto free;
> @@ -1781,7 +1781,9 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	pci_release_regions(pdev);
>   free:
>  	kfree(dev->queues);
> + free_entry:
>  	kfree(dev->entry);
> + free_dev:
>  	kfree(dev);
