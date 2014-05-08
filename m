From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Thu, 8 May 2014 21:19:52 +0300
Subject: NVMe: Add pci suspend/resume driver callbacks
In-Reply-To: <alpine.LRH.2.03.1405080845480.5666@AMR>
References: <20140508125504.GA4973@mwanda>
 <alpine.LRH.2.03.1405080845480.5666@AMR>
Message-ID: <20140508181952.GA4963@mwanda>

On Thu, May 08, 2014@09:08:22AM -0600, Keith Busch wrote:
> Hi Dan,
> 
> On Thu, 8 May 2014, Dan Carpenter wrote:
> >  797          if (!nvmeq) {
> >  798                  put_nvmeq(NULL);
> >                                 ^^^^
> >You can't pass a NULL to put_nvmeq(), it will just Oops.
> 
> Does it? Let's follow this through:
> 
> static void put_nvmeq(struct nvme_queue *nvmeq) __releases(RCU)
> {
> 	rcu_read_unlock();
> 	put_cpu_var(nvmeq->dev->io_queue);
> }
> 
> This will use 'NULL' in put_cpu_var, and here's that macro:
> 
> #define put_cpu_var(var) do {                           \
> 	(void)&(var);                                   \
> 	preempt_enable();                               \
> } while (0)
> 
> That's a no-op, right?

Interesting.  You're right it's not a problem to pass the NULL pointer
here.

regards,
dan carpenter
