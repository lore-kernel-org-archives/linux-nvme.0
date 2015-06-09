From: willy@linux.intel.com (Matthew Wilcox)
Date: Tue, 9 Jun 2015 15:06:58 -0400
Subject: [PATCH] NVMe: IRQ vector sharing depends on resources
In-Reply-To: <1432088416-10409-1-git-send-email-jonathan.derrick@intel.com>
References: <1432088416-10409-1-git-send-email-jonathan.derrick@intel.com>
Message-ID: <20150609190658.GJ2729@linux.intel.com>

On Tue, May 19, 2015@08:20:16PM -0600, Jon Derrick wrote:
> If the number of io queues + admin queue is less than or equal
> to the number of vectors, no IRQs will be shared. If there are more
> io queues + admin queue than there are vectors, qid 0 (admin queue)
> and qid 1 will share a vector

I like the idea.  The implementation, while it looks correct, reads a bit
funny.

> @@ -1457,7 +1457,8 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
>  	struct nvme_dev *dev = nvmeq->dev;
>  	int result;
>  
> -	nvmeq->cq_vector = qid - 1;
> +	nvmeq->cq_vector = qid - dev->shared_vec;
> +
>  	result = adapter_alloc_cq(dev, qid, nvmeq);
>  	if (result < 0)
>  		return result;

This usage says to me "shared_vec is a count of the number of shared vectors".

> @@ -2278,6 +2280,9 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
>  		}
>  	}
>  
> +	if (vecs < nr_io_queues + 1)
> +		dev->shared_vec = 1;
> +
>  	/*
>  	 * Should investigate if there's a performance win from allocating
>  	 * more queues than interrupt vectors; it might allow the submission

Here it looks like it's being used as a truth value.  Maybe you're one
of these newfangled C programmers who use 'bool' and 'true', but a lot
of Linux programmers are dinosaurs who invented their own values of truth.

> @@ -2285,6 +2290,8 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
>  	 * number of interrupts.
>  	 */
>  	nr_io_queues = vecs;
> +	if (!dev->shared_vec)
> +		--nr_io_queues;
>  	dev->max_qid = nr_io_queues;
>  
>  	result = queue_request_irq(dev, adminq, adminq->irqname);

Here it looks like a truth value again.

> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 0adad4a..e5386e1 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -85,6 +85,7 @@ struct nvme_dev {
>  	u32 db_stride;
>  	u32 ctrl_config;
>  	struct msix_entry *entry;
> +	int shared_vec;
>  	struct nvme_bar __iomem *bar;
>  	struct list_head namespaces;
>  	struct kref kref;

This is a bad place to put an 'int' -- between two pointers.  It'd fit better
after ctrl_config, but ...

What I think you probably ought to do is have a 'vec_count' variable,
right after 'queue_count'.  That gets us a little closer to answering
this question:

        /*
         * Should investigate if there's a performance win from allocating
         * more queues than interrupt vectors; it might allow the submission
         * path to scale better, even if the receive path is limited by the
         * number of interrupts.
         */

I don't know exactly how 'vec_count' will work out; feel free to come
back and tell me that we really do need to store the difference between
the number of vectors and the number of queues.
