From: willy@linux.intel.com (Matthew Wilcox)
Date: Wed, 17 Jun 2015 12:24:12 -0400
Subject: [PATCH 1/1] NVMe : Corrected memory freeing.
In-Reply-To: <1434557459-4732-1-git-send-email-dheepthi.s@gracelabs.com>
References: <1434557459-4732-1-git-send-email-dheepthi.s@gracelabs.com>
Message-ID: <20150617162412.GA1971@linux.intel.com>

On Wed, Jun 17, 2015@09:40:59PM +0530, Dheepthi K wrote:
> Memory freeing order has been corrected incase of
> allocation failure.

This doesn't fix a bug.  kfree(NULL) is a no-op, and 'dev' is allocated
with kzalloc, so the current error path will call kfree(NULL).

> @@ -2947,11 +2947,11 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	dev->entry = kzalloc_node(num_possible_cpus() * sizeof(*dev->entry),
>  							GFP_KERNEL, node);
>  	if (!dev->entry)
> -		goto free;
> +		goto free_dev;
>  	dev->queues = kzalloc_node((num_possible_cpus() + 1) * sizeof(void *),
>  							GFP_KERNEL, node);
>  	if (!dev->queues)
> -		goto free;
> +		goto free_entry;
>  
>  	INIT_LIST_HEAD(&dev->namespaces);
>  	dev->reset_workfn = nvme_reset_failed_dev;
> @@ -2987,9 +2987,10 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	nvme_release_instance(dev);
>   put_pci:
>  	pci_dev_put(dev->pci_dev);
> - free:
>  	kfree(dev->queues);
> + free_entry:
>  	kfree(dev->entry);
> + free_dev:
>  	kfree(dev);
>  	return result;
>  }
> -- 
> 1.7.9.5
