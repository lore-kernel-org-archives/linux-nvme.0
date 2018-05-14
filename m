From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 14 May 2018 05:42:30 -0700
Subject: [PATCH] nvme: fix lockdep warning in nvme_mpath_clear_current_path
In-Reply-To: <20180514121312.13624-1-jthumshirn@suse.de>
References: <20180514121312.13624-1-jthumshirn@suse.de>
Message-ID: <20180514124230.GA654@infradead.org>

>  extern unsigned int nvme_io_timeout;
>  #define NVME_IO_TIMEOUT	(nvme_io_timeout * HZ)
> @@ -454,7 +455,9 @@ static inline void nvme_mpath_clear_current_path(struct nvme_ns *ns)
>  {
>  	struct nvme_ns_head *head = ns->head;
>  
> -	if (head && ns == srcu_dereference(head->current_path, &head->srcu))
> +	if (head &&
> +	    ns == rcu_dereference_protected(head->current_path,
> +				lockdep_is_held(&ns->ctrl->subsys->lock)))
>  		rcu_assign_pointer(head->current_path, NULL);
>  }
>  struct nvme_ns *nvme_find_path(struct nvme_ns_head *head);

We don't really dereference it at all in fact, but just check the
pointers for equality.  I wonder if there is a better way to do this,
as my ANA patches add a caller without the lock (and withou SRU
protection either now that I think of it) - for a pure pointer compare
we really should not need any sort of protection.
