From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 3 May 2017 18:08:31 +0300
Subject: [PATCH v4, under testing] nvme-rdma: support devices with queue
 size < 32
In-Reply-To: <79901165.5342369.1493805915415.JavaMail.zimbra@kalray.eu>
References: <79901165.5342369.1493805915415.JavaMail.zimbra@kalray.eu>
Message-ID: <823aa3f0-685f-4569-11d6-238cc4f0b126@grimberg.me>


> +static inline bool nvme_rdma_queue_sig_limit(struct nvme_rdma_queue *queue)
> +{
> +       int v, old;
> +
> +       v = atomic_read(&queue->sig_count);
> +       while (1) {
> +               if (v > 1) {
> +                       old = atomic_cmpxchg(&queue->sig_count, v, v - 1);
> +                       if (old == v)
> +                               return false;
> +               } else {
> +                       int new_count;
> +
> +                       new_count = nvme_rdma_init_sig_count(queue->queue_size);
> +                       old = atomic_cmpxchg(&queue->sig_count, v, new_count);
> +                       if (old == v)
> +                               return true;
> +               }
> +               v = old;
> +       }
> +}
> +

Ugh, no...

How about just do:

	if (atomic_inc_return(queue->sig_count) % queue->sig_limit)
		return true;
	return false;

where
	queue->sig_limit = max(queue->queue_size / 2, 1);
