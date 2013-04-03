From: willy@linux.intel.com (Matthew Wilcox)
Date: Wed, 3 Apr 2013 08:38:09 -0400
Subject: [PATCH] NVMe: Do not save result for range type feature
In-Reply-To: <1364934695-24351-1-git-send-email-keith.busch@intel.com>
References: <1364934695-24351-1-git-send-email-keith.busch@intel.com>
Message-ID: <20130403123809.GO4671@linux.intel.com>

On Tue, Apr 02, 2013@02:31:35PM -0600, Keith Busch wrote:
> The LBA range type feature being optional, we do not want to save
> the result or propagate it up the call stack when a device does not
> support it.

Looking at the whole function, the description of what it returns
is rather odd.  "If nvme_setup_io_queues fails, returns that error.
If nvme_identify for the controller fails, returns -EIO.  Otherwise,
return an error if nvme_identify for the last namespace fails or if
nvme_get_features for the last namespace fails."

So we always discard errors for not-the-last namespace, but return an
error if identify or get_features for the last namespace gets an error.
Worse, on returning an error, the caller will free the queues and all the
controller structures, even though the namespaces have been registered as
devices!  I really didn't think through the error path here, did I?  :-)

So, I would propose that we _always_ discard any errors we hit going through
the namespace addition loop.  As long as we've been able to set up queues
and identify the controller, this function should return success.

And I think *that* patch is as simple as adding:

                        list_add_tail(&ns->list, &dev->namespaces);
        }
+	res = 0;
        list_for_each_entry(ns, &dev->namespaces, list)
                add_disk(ns->disk);

What do you think?

> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>  drivers/block/nvme-core.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> index a89f7db..00819d7 100644
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
> @@ -1544,9 +1544,8 @@ static int nvme_dev_add(struct nvme_dev *dev)
>  		if (id_ns->ncap == 0)
>  			continue;
>  
> -		res = nvme_get_features(dev, NVME_FEAT_LBA_RANGE, i,
> -							dma_addr + 4096, NULL);
> -		if (res)
> +		if (nvme_get_features(dev, NVME_FEAT_LBA_RANGE, i,
> +							dma_addr + 4096, NULL))
>  			memset(mem + 4096, 0, 4096);
>  
>  		ns = nvme_alloc_ns(dev, i, mem, mem + 4096);
> -- 
> 1.7.1
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://merlin.infradead.org/mailman/listinfo/linux-nvme
