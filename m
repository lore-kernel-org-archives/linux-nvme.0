From: Bart.VanAssche@sandisk.com (Bart Van Assche)
Date: Wed, 3 May 2017 15:45:25 +0000
Subject: [PATCH v4, under testing] nvme-rdma: support devices with queue
 size < 32
In-Reply-To: <780938034.8003164.1493824767084.JavaMail.zimbra@kalray.eu>
References: <79901165.5342369.1493805915415.JavaMail.zimbra@kalray.eu>
 <823aa3f0-685f-4569-11d6-238cc4f0b126@grimberg.me>
 <780938034.8003164.1493824767084.JavaMail.zimbra@kalray.eu>
Message-ID: <1493826324.3901.2.camel@sandisk.com>

On Wed, 2017-05-03@17:19 +0200, Marta Rybczynska wrote:
> > > +static inline bool nvme_rdma_queue_sig_limit(struct nvme_rdma_queue *queue)
> > > +{
> > > +       int v, old;
> > > +
> > > +       v = atomic_read(&queue->sig_count);
> > > +       while (1) {
> > > +               if (v > 1) {
> > > +                       old = atomic_cmpxchg(&queue->sig_count, v, v - 1);
> > > +                       if (old == v)
> > > +                               return false;
> > > +               } else {
> > > +                       int new_count;
> > > +
> > > +                       new_count = nvme_rdma_init_sig_count(queue->queue_size);
> > > +                       old = atomic_cmpxchg(&queue->sig_count, v, new_count);
> > > +                       if (old == v)
> > > +                               return true;
> > > +               }
> > > +               v = old;
> > > +       }
> > > +}
> > > +
> > 
> > Ugh, no...
> > 
> > How about just do:
> > 
> > 	if (atomic_inc_return(queue->sig_count) % queue->sig_limit)
> > 		return true;
> > 	return false;
> > 
> > where
> > 	queue->sig_limit = max(queue->queue_size / 2, 1);
> 
> I tried to avoid that because this adds a division in the fast path Bart
> was unhappy about in v2.
> 
> Unfortunately we do not have an atomic with on overflow operation like
> the one needed here.

Hello Marta,

The approach I proposed works well if sig_count is modified by a single thread
at a time. Seeing your code made me realize that it is nontrivial to implement
that approach if multiple threads can change sig_count concurrently. Since
atomic_cmpxchg() is relatively expensive, what Sagi proposed may be a better
alternative. Sorry that I sent you in the wrong direction.

Bart.
