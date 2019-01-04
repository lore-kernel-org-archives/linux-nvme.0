From: ming.lei@redhat.com (Ming Lei)
Date: Fri, 4 Jan 2019 10:41:18 +0800
Subject: [PATCHv2 4/4] nvme-pci: Use PCI to handle IRQ reduce and retry
In-Reply-To: <20190103225033.11249-5-keith.busch@intel.com>
References: <20190103225033.11249-1-keith.busch@intel.com>
 <20190103225033.11249-5-keith.busch@intel.com>
Message-ID: <20190104024117.GC31330@ming.t460p>

On Thu, Jan 03, 2019@03:50:33PM -0700, Keith Busch wrote:
> Restore error handling for vector allocation back to the PCI core.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>  drivers/nvme/host/pci.c | 77 ++++++++++++++-----------------------------------
>  1 file changed, 21 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 1481bb6d9c42..f3ef09a8e8f9 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2059,37 +2059,43 @@ static int nvme_setup_host_mem(struct nvme_dev *dev)
>  	return ret;
>  }
>  
> -static void nvme_calc_io_queues(struct nvme_dev *dev, unsigned int irq_queues)
> +static void nvme_calc_io_queues(struct irq_affinity *affd, unsigned int nvecs)
>  {
> +	struct nvme_dev *dev = affd->priv;
>  	unsigned int this_w_queues = write_queues;
>  
>  	/*
>  	 * Setup read/write queue split
>  	 */
> -	if (irq_queues == 1) {
> +	if (nvecs == 1) {

The above line can be 'nvecs <= 2', cause when nvecs is 2, one is for
admin queue, another can be for DEFAULT.

>  		dev->io_queues[HCTX_TYPE_DEFAULT] = 1;
>  		dev->io_queues[HCTX_TYPE_READ] = 0;
> -		return;
> +		goto set_sets;
>  	}
>  
>  	/*
>  	 * If 'write_queues' is set, ensure it leaves room for at least
>  	 * one read queue
>  	 */
> -	if (this_w_queues >= irq_queues)
> -		this_w_queues = irq_queues - 1;
> +	if (this_w_queues >= nvecs - 1)
> +		this_w_queues = nvecs - 1;

If we want to leave room for one read queue, 'this_w_queues' should be
set as 'nvecs - 2' given nvecs covers admin queue.

>  
>  	/*
>  	 * If 'write_queues' is set to zero, reads and writes will share
>  	 * a queue set.
>  	 */
>  	if (!this_w_queues) {
> -		dev->io_queues[HCTX_TYPE_DEFAULT] = irq_queues;
> +		dev->io_queues[HCTX_TYPE_DEFAULT] = nvecs - 1;
>  		dev->io_queues[HCTX_TYPE_READ] = 0;
>  	} else {
>  		dev->io_queues[HCTX_TYPE_DEFAULT] = this_w_queues;
> -		dev->io_queues[HCTX_TYPE_READ] = irq_queues - this_w_queues;
> +		dev->io_queues[HCTX_TYPE_READ] = nvecs - this_w_queues - 1;
>  	}

In above change, looks you starts to consider admin queue vector, which
is obvious one issue in current code.

So I'd suggest to fix nvme_calc_io_queues() in one standalone patch,
just what I posted, given this patch doesn't do "Restore error
handling for vector allocation back to the PCI core" only.

http://lists.infradead.org/pipermail/linux-nvme/2018-December/021879.html

Thanks,
Ming
