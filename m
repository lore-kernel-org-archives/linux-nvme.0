From: hch@lst.de (Christoph Hellwig)
Date: Mon, 11 Mar 2019 19:25:01 +0100
Subject: [PATCH 1/8] nvme/pci: Use a flag for polled queues
In-Reply-To: <20190308174313.5134-1-keith.busch@intel.com>
References: <20190308174313.5134-1-keith.busch@intel.com>
Message-ID: <20190311182501.GA11448@lst.de>

On Fri, Mar 08, 2019@10:43:06AM -0700, Keith Busch wrote:
> A negative value for the cq_vector used to mean the queue is either
> disabled or a polled queue. However, we have a queue enabled flag,
> so the cq_vector had been serving double duty.
> 
> Don't overload the meaning of cq_vector. Use a flag specific to the
> polled queues instead.

Looks good,

a few nitpicks below:

> -	nvmeq->cq_vector = -1;
> +	if (!test_and_clear_bit(NVMEQ_POLLED, &nvmeq->flags))
> +		pci_free_irq(to_pci_dev(nvmeq->dev->dev), nvmeq->cq_vector, nvmeq);
>  	return 0;

This creates an > 80 char line.

But given that the nvme_suspend_queue return value is always ignored
you could throw in a prep patch to remove the return value and just
do an early return for the poll case here.

> @@ -1552,7 +1547,7 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
>  	if (!polled)
>  		vector = dev->num_vecs == 1 ? 0 : qid;
>  	else
> -		vector = -1;
> +		set_bit(NVMEQ_POLLED, &nvmeq->flags);

Between the inversion and the ? : this looks pretty obsfucated.
Can we untangle this to:

	if (polled)
		set_bit(NVMEQ_POLLED, &nvmeq->flags);
	else if (dev->num_vecs == 1)
		vector = 0;
	else
		vector = qid;

Or we might just kill the polled argument and the local vector variable
entirely, set the NVMEQ_POLLED flag in nvme_create_io_queues and
calculate the vector inside adapter_alloc_cq, which would also lose the
vector argument.
