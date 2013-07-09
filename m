From: willy@linux.intel.com (Matthew Wilcox)
Date: Tue, 9 Jul 2013 09:41:29 -0400
Subject: [PATCHv2] NVMe: IO Queue NUMA locality
In-Reply-To: <1373312159-2255-1-git-send-email-keith.busch@intel.com>
References: <1373312159-2255-1-git-send-email-keith.busch@intel.com>
Message-ID: <20130709134129.GI30142@linux.intel.com>

On Mon, Jul 08, 2013@01:35:59PM -0600, Keith Busch wrote:
> There is measurable difference when running IO on a cpu on another
> domain; however, my particular device hits its peak performance on
> either domain at higher queue depths and block sizes, so I'm only able
> to see a difference at lower io depths. The best gains topped out at 2%
> improvement with this patch vs the existing code.

That's not too shabby.  This is only a two-socket system you're testing
on, so I'd expect larger gains on systems with more sockets.

> I understand this method of allocating and mapping memory may not work
> for CPUs without cache-coherency, but I'm not sure if there is another
> way to allocate coherent memory for a specific NUMA node.

I found a way in the networking drivers:

int ixgbe_setup_tx_resources(struct ixgbe_ring *tx_ring)
{
        int orig_node = dev_to_node(dev);
        int numa_node = -1;
...
        if (tx_ring->q_vector)
                numa_node = tx_ring->q_vector->numa_node;
...
        set_dev_node(dev, numa_node);
        tx_ring->desc = dma_alloc_coherent(dev,
                                           tx_ring->size,
                                           &tx_ring->dma,
                                           GFP_KERNEL);
        set_dev_node(dev, orig_node);
        if (!tx_ring->desc)
                tx_ring->desc = dma_alloc_coherent(dev, tx_ring->size,
                                                   &tx_ring->dma, GFP_KERNEL);
        if (!tx_ring->desc)
                goto err;


> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> index 711b51c..9cedfa0 100644
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
> @@ -1200,7 +1206,7 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
>  	if (result < 0)
>  		return result;
>  
> -	nvmeq = nvme_alloc_queue(dev, 0, 64, 0);
> +	nvmeq = nvme_alloc_queue(dev, 0, 64, 0, -1);
>  	if (!nvmeq)
>  		return -ENOMEM;
>  

I suppose we should really have the admin queue allocated on the node
closest to the device, so pass in dev_to_node(dev) instead of -1 here?
