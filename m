From: keith.busch@intel.com (Keith Busch)
Date: Thu, 8 May 2014 09:08:22 -0600 (MDT)
Subject: NVMe: Add pci suspend/resume driver callbacks
In-Reply-To: <20140508125504.GA4973@mwanda>
References: <20140508125504.GA4973@mwanda>
Message-ID: <alpine.LRH.2.03.1405080845480.5666@AMR>

Hi Dan,

On Thu, 8 May 2014, Dan Carpenter wrote:
>   797          if (!nvmeq) {
>   798                  put_nvmeq(NULL);
>                                  ^^^^
> You can't pass a NULL to put_nvmeq(), it will just Oops.

Does it? Let's follow this through:

static void put_nvmeq(struct nvme_queue *nvmeq) __releases(RCU)
{
 	rcu_read_unlock();
 	put_cpu_var(nvmeq->dev->io_queue);
}

This will use 'NULL' in put_cpu_var, and here's that macro:

#define put_cpu_var(var) do {                           \
 	(void)&(var);                                   \
 	preempt_enable();                               \
} while (0)

That's a no-op, right? It is on my config, so it appears to be safe (for
now). I'd agree it's not a good idea relying on that macro to never use
this parameter, though.

Maybe do this instead:

@@ -282,6 +282,12 @@ static struct nvme_queue *get_nvmeq(struct nvme_dev *dev) __acquires(RCU)
  	return rcu_dereference(dev->queues[queue_id]);
  }

+static void put_nvmeq(struct nvme_dev *dev) __releases(RCU)
+{
+	rcu_read_unlock();
+	put_cpu_var(dev->io_queue);
+}
+
  static void put_nvmeq(struct nvme_queue *nvmeq) __releases(RCU)
  {
  	rcu_read_unlock();
@@ -801,7 +807,7 @@ static void nvme_make_request(struct request_queue *q, struct bio *bio)
  	int result = -EBUSY;

  	if (!nvmeq) {
-		put_nvmeq(NULL);
+		put_ioqueue(ns->dev);
  		bio_endio(bio, -EIO);
  		return;
  	}
