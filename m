From: willy@linux.intel.com (Matthew Wilcox)
Date: Thu, 19 Sep 2013 16:29:57 -0400
Subject: [PATCH 3/9] NVMe: Fail device if unresponsive during init
In-Reply-To: <1378413915-16667-4-git-send-email-keith.busch@intel.com>
References: <1378413915-16667-1-git-send-email-keith.busch@intel.com>
 <1378413915-16667-4-git-send-email-keith.busch@intel.com>
Message-ID: <20130919202957.GH4668@linux.intel.com>

On Thu, Sep 05, 2013@02:45:09PM -0600, Keith Busch wrote:
> This handles identifying namespace errors differently depending on
> the error. If the controller is unresponsive during this point of
> initialization, the namespaces are freed and the pci probe is failed.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>  		res = nvme_identify(dev, i, 0, dma_addr);
> -		if (res)
> +		if (res) {
> +			if (res < 0)
> +				goto out_free;
>  			continue;
> +		}

Feels a little klunky.  How about:

		res = nvme_identify(dev, i, 0, dma_addr);
-		if (res)
+		if (res < 0)
+			goto out_free;
+		else if (res)
			continue;

>  		res = nvme_get_features(dev, NVME_FEAT_LBA_RANGE, i,
>  							dma_addr + 4096, NULL);
> -		if (res)
> +		if (res) {
> +			if (res < 0)
> +				goto out_free;
>  			memset(mem + 4096, 0, 4096);
> +		}

I don't know if we need to do this.  Consider a hypothetical device that
has a broken get_features, but everything else works fine.  We can still
use that device just fine.  Contrariwise, if the device happens to break
between issuing the identify and get_features, we'll still error out
really soon afterwards.

> @@ -1930,7 +1936,13 @@ static int nvme_dev_add(struct nvme_dev *dev)
>  	list_for_each_entry(ns, &dev->namespaces, list)
>  		add_disk(ns->disk);
>  	res = 0;
> +	goto out;
>  
> + out_free:
> +	list_for_each_entry_safe(ns, next, &dev->namespaces, list) {
> +		list_del(&ns->list);
> +		nvme_ns_free(ns);
> +	}
>   out:
>  	dma_free_coherent(&dev->pci_dev->dev, 8192, mem, dma_addr);
>  	return res;

I tend to prefer the error path flow to look like this:

	res = 0;
 out:
	dma_free_coherent(&dev->pci_dev->dev, 8192, mem, dma_addr);
	return res;
 out_free:
	list_for_each_entry_safe(ns, next, &dev->namespaces, list) {
		list_del(&ns->list);
		nvme_ns_free(ns);
	}
	goto out;
}
