From: keith.busch@intel.com (Keith Busch)
Date: Wed, 7 Dec 2016 17:27:46 -0500
Subject: [PATCH] nvme: create the correct number of queues
In-Reply-To: <20161207220326.8461-1-ddstreet@ieee.org>
References: <20161207220326.8461-1-ddstreet@ieee.org>
Message-ID: <20161207222746.GD22478@localhost.localdomain>

On Wed, Dec 07, 2016@05:03:26PM -0500, Dan Streetman wrote:
> Change nr_io_queues variable name to nr_queues, as it includes not
> only the io queues but also the admin queue in its count; and change
> the variable name in functions that it is passed into, for clarity.
> 
> Also correct misuses of the nr_queue count:
> 
> In the db_bar_size() function, the calculation added 1 to the
> nr_io_queues value to account for the admin queue, but since that's
> actually already in the nr_queue count, don't add it.
> 
> In the nvme_setup_io_queues() function when allocating irq vectors,
> it considers the minimum number of queues to be 1, but actually 2
> queues are needed; 1 admin queue + at least 1 io queue.
> 
> When setting the device's max_qid (maximum queue index id), it's
> currently set to nr_io_queues, but since nr_queues counts all
> queues, and because max_qid is 0-based and nr_queues is 1-based,
> max_qid must be set to nr_queues - 1.
> 
> Signed-off-by: Dan Streetman <dan.streetman at canonical.com>
>
> ---

[snip]  

>  static int nvme_setup_io_queues(struct nvme_dev *dev)
>  {
>  	struct nvme_queue *adminq = dev->queues[0];
>  	struct pci_dev *pdev = to_pci_dev(dev->dev);
> -	int result, nr_io_queues, size;
> +	int result, nr_queues, size;
>  
> -	nr_io_queues = num_online_cpus();
> -	result = nvme_set_queue_count(&dev->ctrl, &nr_io_queues);
> +	nr_queues = num_online_cpus();

I'm not sure I follow. If you want to say nr_queues includes the admin
queue, the above is incorrect. We want the number of io queues to equal
the number of online cpus, so if nr_queues includes the admin, we're
off by one.

I don't think there's anything wrong with the code as it is, though.
