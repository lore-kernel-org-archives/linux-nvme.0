From: keith.busch@intel.com (Keith Busch)
Date: Fri, 28 Mar 2014 10:29:13 -0600 (MDT)
Subject: [PATCH RFC 3/5] NVMe: Asynchronous device scan support
In-Reply-To: <CALMYJDtMTZKf6pAYsc3LeG4LT9xfe0NFRMUEqxxarp=0yfdHUQ@mail.gmail.com>
References: <1388399240-13828-1-git-send-email-santoshsy@gmail.com>
 <1388399240-13828-4-git-send-email-santoshsy@gmail.com>
 <20131230135025.GI4945@linux.intel.com>
 <CALMYJDtMTZKf6pAYsc3LeG4LT9xfe0NFRMUEqxxarp=0yfdHUQ@mail.gmail.com>
Message-ID: <alpine.LRH.2.03.1403281028520.4731@AMR>

On Fri, 28 Mar 2014, Santosh Y wrote:
> On Mon, Dec 30, 2013@7:20 PM, Matthew Wilcox <willy@linux.intel.com> wrote:
>> On Mon, Dec 30, 2013@03:57:18PM +0530, Santosh Y wrote:
>>> This patch provides asynchronous device enumeration
>>> capability. The 'probe' need not wait until the namespace scanning is
>>> complete.
>>
>> I'm very interested in having something like this, except I don't think
>> it's complete.  You don't seem to handle the cases where the device
>> is shut down in the middle of an async scan.  Also, the only piece you
>> seem to make async is the calls to add_disk(), which are surely not the
>> timeconsuming parts of the scan.  I would think the time consuming parts
>> are sending the IDENTIFY commands, which you don't make async.
>>
>
> Would you prefer changes in the following patch. Please let me know
> your comments.

This still doesn't look safe in the case a remove occurs during an async
scan. I think you need to do something like save the async_cookie_t when
you start it and call async_synchronize_cookie() in the removal path.

> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> index b59a93a..2f65f89 100644
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
> @@ -17,6 +17,7 @@
>  */
>
> #include <linux/nvme.h>
> +#include <linux/async.h>
> #include <linux/bio.h>
> #include <linux/bitops.h>
> #include <linux/blkdev.h>
> @@ -1993,6 +1994,49 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
>     return result;
> }
>
> +static void nvme_async_add(void *data, async_cookie_t cookie)
> +{
> +    struct nvme_dev *dev = (struct nvme_dev *) data;
> +    struct pci_dev *pdev = dev->pci_dev;
> +    struct nvme_ns *ns;
> +    struct nvme_id_ns *id_ns;
> +    void *mem;
> +    dma_addr_t dma_addr;
> +    unsigned i;
> +    int res;
> +
> +    mem = dma_alloc_coherent(&pdev->dev, 8192, &dma_addr, GFP_KERNEL);
> +    if (!mem)
> +        return;
> +
> +    id_ns = mem;
> +    for (i = 1; i <= dev->nn; i++) {
> +        res = nvme_identify(dev, i, 0, dma_addr);
> +
> +        if (res)
> +            continue;
> +
> +        if (id_ns->ncap == 0)
> +            continue;
> +
> +        res = nvme_get_features(dev, NVME_FEAT_LBA_RANGE, i,
> +                    dma_addr + 4096, NULL);
> +        if (res)
> +            memset(mem + 4096, 0, 4096);
> +        ns = nvme_alloc_ns(dev, i, mem, mem + 4096);
> +        if (ns)
> +            list_add_tail(&ns->list, &dev->namespaces);
> +    }
> +
> +    mutex_lock(&dev->async_mutex);
> +    list_for_each_entry(ns, &dev->namespaces, list)
> +    add_disk(ns->disk);
> +    mutex_unlock(&dev->async_mutex);
> +
> +    dev->initialized = 1;
> +    dma_free_coherent(&pdev->dev, 8192, mem, dma_addr);
> +}
> +
> /*
>  * Return: error value if an error occurred setting up the queues or calling
>  * Identify Device.  0 if these succeeded, even if adding some of the
> @@ -2003,15 +2047,12 @@ static int nvme_dev_add(struct nvme_dev *dev)
> {
>     struct pci_dev *pdev = dev->pci_dev;
>     int res;
> -    unsigned nn, i;
> -    struct nvme_ns *ns;
>     struct nvme_id_ctrl *ctrl;
> -    struct nvme_id_ns *id_ns;
>     void *mem;
>     dma_addr_t dma_addr;
>     int shift = NVME_CAP_MPSMIN(readq(&dev->bar->cap)) + 12;
>
> -    mem = dma_alloc_coherent(&pdev->dev, 8192, &dma_addr, GFP_KERNEL);
> +    mem = dma_alloc_coherent(&pdev->dev, 4096, &dma_addr, GFP_KERNEL);
>     if (!mem)
>         return -ENOMEM;
>
> @@ -2022,7 +2063,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
>     }
>
>     ctrl = mem;
> -    nn = le32_to_cpup(&ctrl->nn);
> +    dev->nn = le32_to_cpup(&ctrl->nn);
>     dev->oncs = le16_to_cpup(&ctrl->oncs);
>     dev->abort_limit = ctrl->acl + 1;
>     memcpy(dev->serial, ctrl->sn, sizeof(ctrl->sn));
> @@ -2034,30 +2075,11 @@ static int nvme_dev_add(struct nvme_dev *dev)
>             (pdev->device == 0x0953) && ctrl->vs[3])
>         dev->stripe_size = 1 << (ctrl->vs[3] + shift);
>
> -    id_ns = mem;
> -    for (i = 1; i <= nn; i++) {
> -        res = nvme_identify(dev, i, 0, dma_addr);
> -        if (res)
> -            continue;
> -
> -        if (id_ns->ncap == 0)
> -            continue;
> -
> -        res = nvme_get_features(dev, NVME_FEAT_LBA_RANGE, i,
> -                            dma_addr + 4096, NULL);
> -        if (res)
> -            memset(mem + 4096, 0, 4096);
> -
> -        ns = nvme_alloc_ns(dev, i, mem, mem + 4096);
> -        if (ns)
> -            list_add_tail(&ns->list, &dev->namespaces);
> -    }
> -    list_for_each_entry(ns, &dev->namespaces, list)
> -        add_disk(ns->disk);
> +    async_schedule(nvme_async_add, dev);
>     res = 0;
>
>  out:
> -    dma_free_coherent(&dev->pci_dev->dev, 8192, mem, dma_addr);
> +    dma_free_coherent(&pdev->dev, 4096, mem, dma_addr);
>     return res;
> }
>
> @@ -2501,6 +2523,7 @@ static int nvme_probe(struct pci_dev *pdev,
> const struct pci_device_id *id)
>         goto free;
>
>     INIT_LIST_HEAD(&dev->namespaces);
> +    mutex_init(&dev->async_mutex);
>     dev->pci_dev = pdev;
>     pci_set_drvdata(pdev, dev);
>     result = nvme_set_instance(dev);
> @@ -2532,7 +2555,6 @@ static int nvme_probe(struct pci_dev *pdev,
> const struct pci_device_id *id)
>     if (result)
>         goto remove;
>
> -    dev->initialized = 1;
>     kref_init(&dev->kref);
>     return 0;
>
> @@ -2560,6 +2582,7 @@ static void nvme_remove(struct pci_dev *pdev)
>     list_del_init(&dev->node);
>     spin_unlock(&dev_list_lock);
>
> +    mutex_lock(&dev->async_mutex);
>     pci_set_drvdata(pdev, NULL);
>     flush_work(&dev->reset_work);
>     misc_deregister(&dev->miscdev);
> @@ -2569,6 +2592,7 @@ static void nvme_remove(struct pci_dev *pdev)
>     nvme_release_instance(dev);
>     nvme_release_prp_pools(dev);
>     kref_put(&dev->kref, nvme_free_dev);
> +    mutex_unlock(&dev->async_mutex);
> }
>
> /* These functions are yet to be implemented */
> @@ -2583,7 +2607,9 @@ static int nvme_suspend(struct device *dev)
>     struct pci_dev *pdev = to_pci_dev(dev);
>     struct nvme_dev *ndev = pci_get_drvdata(pdev);
>
> +    mutex_lock(&ndev->async_mutex);
>     nvme_dev_shutdown(ndev);
> +    mutex_unlock(&ndev->async_mutex);
>     return 0;
> }
>
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 69ae03f..4ada390 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -97,6 +97,8 @@ struct nvme_dev {
>     u16 oncs;
>     u16 abort_limit;
>     u8 initialized;
> +    unsigned nn;
> +    struct mutex async_mutex;
> };
