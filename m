From: willy@linux.intel.com (Matthew Wilcox)
Date: Thu, 2 Jan 2014 11:58:53 -0500
Subject: [PATCH] NVMe: use-after-free on surprise removal fixes
In-Reply-To: <1388528118-4866-1-git-send-email-keith.busch@intel.com>
References: <1388528118-4866-1-git-send-email-keith.busch@intel.com>
Message-ID: <20140102165853.GN4945@linux.intel.com>

On Tue, Dec 31, 2013@03:15:18PM -0700, Keith Busch wrote:
> A surprise removal of a device while a program has an open reference to
> the block handle may cause it to use the nvme dev, namespace, or queue
> after we've freed them. Reference count the opens on the block device,
> do not free the namespaces until the device ref count is 0, and protect
> queue access with RCU.

Brave.  I love it.

> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> index b59a93a..d71fc27 100644
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
> @@ -263,12 +263,12 @@ static void *cancel_cmdid(struct nvme_queue *nvmeq, int cmdid,
>  
>  struct nvme_queue *get_nvmeq(struct nvme_dev *dev)
>  {
> -	return dev->queues[get_cpu() + 1];
> +	return rcu_dereference(dev->queues[part_stat_lock() + 1]);
>  }
>  
>  void put_nvmeq(struct nvme_queue *nvmeq)
>  {
> -	put_cpu();
> +	part_stat_unlock();
>  }
>  
>  /**

I'm not so keen on using part_stat_lock,unlock here.  If the part stats
switch to a different protection scheme, this will be broken.  Also,
I'm not entirely sure that we're safe in the !SMP case (can't we end up
without having called preempt_disable()?).  I think it's probably better
to do:

-	return dev->queues[get_cpu() + 1];
+	int queue;
+	rcu_read_lock();
+	queue = get_cpu() + 1;
+	return rcu_dereference(dev->queues[queue]);

> @@ -1155,10 +1155,20 @@ static void nvme_free_queues(struct nvme_dev *dev, int lowest)
>  {
>  	int i;
>  
> +	for (i = num_possible_cpus(); i > dev->queue_count - 1; i--)
> +		rcu_assign_pointer(dev->queues[i], NULL);
>  	for (i = dev->queue_count - 1; i >= lowest; i--) {
> -		nvme_free_queue(dev->queues[i]);
> +		struct nvme_queue *nvmeq = dev->queues[i];
> +
> +		spin_lock_irq(&nvmeq->q_lock);
> +		nvme_cancel_ios(nvmeq, false);
> +		spin_unlock_irq(&nvmeq->q_lock);
> +
> +		rcu_assign_pointer(dev->queues[i], NULL);
> +		synchronize_rcu();
> +
> +		nvme_free_queue(nvmeq);
>  		dev->queue_count--;
> -		dev->queues[i] = NULL;
>  	}
>  }
>  

I don't think you want to do this.  You're calling synchronize_rcu() for
each queue individually, which is extremely heavy-weight.  This routine
could take minutes to execute on a machine with a lot of RCU activity.

Two ways to fix this; accumulate the queues into a function-local array,
call synchronize_rcu() once, then free them all.  Alternatively, use
call_rcu() to have nvme_free_queue() executed after a grace period
has elapsed.

If we go that route, then as described in
Documentation/RCU/rcubarrier.txt, we will need to add a call to
rcu_barrier() in the module exit path to be sure that all the call_rcu()
functions have finished executing.  So there's probabaly no real
difference between the execution time of the two options in the case of
module unload, though it'd be visible in device hotplug.

By the way, this is an extremely common mistake people make when
introducing RCU.  If one can figure out a way to avoid calling
synchronize_rcu(), then one probably should.

Also, why is
		rcu_assign_pointer(dev->queues[i], NULL);
after cancelling the I/Os?  It seems to me that another thread could submit
an I/O between the cancellations and setting the queue to NULL.  I think
the pointer assignment needs to at least be within the spin_lock section,
but it could also be done before taking the spinlock ... right?
