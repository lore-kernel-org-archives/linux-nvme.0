From: kbusch@kernel.org (Keith Busch)
Date: Wed, 27 Mar 2019 08:20:45 -0600
Subject: [PATCH 2/3] nvme: shorten race window in nvme_ns_remove()
In-Reply-To: <20190327080929.27918-3-hare@suse.de>
References: <20190327080929.27918-1-hare@suse.de>
 <20190327080929.27918-3-hare@suse.de>
Message-ID: <20190327142044.GB8448@localhost.localdomain>

On Wed, Mar 27, 2019@01:09:28AM -0700, Hannes Reinecke wrote:
> @@ -3316,6 +3316,10 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>  	if (test_and_set_bit(NVME_NS_REMOVING, &ns->flags))
>  		return;
>  
> +	down_write(&ns->ctrl->namespaces_rwsem);
> +	list_del_init(&ns->list);
> +	up_write(&ns->ctrl->namespaces_rwsem);
> +
>  	nvme_fault_inject_fini(ns);
>  	if (ns->disk && ns->disk->flags & GENHD_FL_UP) {
>  		del_gendisk(ns->disk);

I think I understand the problem you've described, but I'm a little
concerned with the early removal. This will call blk_cleanup_queue
after the namespace is removed from our lists, and that does a blocking
queue_freeze. If commands happen to be dispatched to that namespace,
and the controller for some reason stops responding, we may not be able
to recover during reset when the namespace queue is removed from the
controller list. That's at least problematic if we have to go with the
per-queue tag iterators that Jianchao proposed.

I may be wrong, or there might be another way to address this. It's a bit
late where I'm at the moment, I'll revisit again with fresh eyes tomorrow.
