From: hch@lst.de (Christoph Hellwig)
Date: Sat, 1 Sep 2018 09:44:14 +0200
Subject: [PATCH] nvmet-rdma: fix possible bogus dereference under heavy
 load
In-Reply-To: <20180901011447.32287-1-sagi@grimberg.me>
References: <20180901011447.32287-1-sagi@grimberg.me>
Message-ID: <20180901074414.GA32538@lst.de>

On Fri, Aug 31, 2018@06:14:47PM -0700, Sagi Grimberg wrote:
> Currently we always repost the recv buffer before we send a response
> capsule back to the host. Since ordering is not guaranteed for send
> and recv completions, it is posible that we will receive a new request
> from the host before we got a send completion for the response capsule.
> 
> Today, we pre-allocate 2x rsps the length of the queue, but in reality, under
> heavy load there is nothing that is really preventing the gap to expand
> until we exhaust all our rsps.

This is a little scary and means we have the same issue in all other
protocol drivers.  It also means that there probably is no point in
allocating twice the queue length as it will be wasted most of the
time, but still not enough.

>  	spin_lock_irqsave(&queue->rsps_lock, flags);
> -	rsp = list_first_entry(&queue->free_rsps,
> +	rsp = list_first_entry_or_null(&queue->free_rsps,
>  				struct nvmet_rdma_rsp, free_list);
> -	list_del(&rsp->free_list);
>  	spin_unlock_irqrestore(&queue->rsps_lock, flags);
> +	if (rsp) {
> +		list_del(&rsp->free_list);

The list del needs to be under the lock.

> +		rsp->allocated = false;
> +	} else {
> +		rsp = kmalloc(sizeof(*rsp), GFP_KERNEL);
> +		rsp->allocated = true;

This needs to handle a NULL return from kmalloc.
