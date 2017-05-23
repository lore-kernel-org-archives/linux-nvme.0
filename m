From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 23 May 2017 17:08:07 +0300
Subject: [PATCH 7/7] nvme: allocate queues for all possible CPUs
In-Reply-To: <20170519085756.29742-8-hch@lst.de>
References: <20170519085756.29742-1-hch@lst.de>
 <20170519085756.29742-8-hch@lst.de>
Message-ID: <b546ab47-4ccd-6fd9-0d3d-2448702f33b1@mellanox.com>

Hi Christoph,

On 5/19/2017 11:57 AM, Christoph Hellwig wrote:
> Unlike most dr?vers that simply pass the maximum possible vectors to
> pci_alloc_irq_vectors NVMe needs to configure the device before allocting
> the vectors, so it needs a manual update for the new scheme of using
> all present CPUs.
>
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  drivers/nvme/host/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index fed803232edc..6580a21d1425 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1520,7 +1520,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
>  	struct pci_dev *pdev = to_pci_dev(dev->dev);
>  	int result, nr_io_queues, size;
>
> -	nr_io_queues = num_online_cpus();
> +	nr_io_queues = num_present_cpus();

we allocate the queues using num_possible_cpus():
dev->queues = kzalloc_node((num_possible_cpus() + 1) * sizeof(void *), 
GFP_KERNEL, node);

I'm not sure regarding the differance between 
num_present_cpus()/num_possible_cpus(), is this ok to use 
num_present_cpus() in the allocation ?

>  	result = nvme_set_queue_count(&dev->ctrl, &nr_io_queues);
>  	if (result < 0)
>  		return result;
>
