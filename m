From: willy@linux.intel.com (Matthew Wilcox)
Date: Fri, 9 May 2014 10:01:16 -0400
Subject: NVMe: Add pci suspend/resume driver callbacks
In-Reply-To: <alpine.LRH.2.03.1405080845480.5666@AMR>
References: <20140508125504.GA4973@mwanda>
 <alpine.LRH.2.03.1405080845480.5666@AMR>
Message-ID: <20140509140116.GA13438@linux.intel.com>

On Thu, May 08, 2014@09:08:22AM -0600, Keith Busch wrote:
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

Wait, no, your explanation is wrong.  It's a macro, so it gets expanded by the preprocessor before it gets to the compiler.  Like this:

static void put_nvmeq(struct nvme_queue *nvmeq) __releases(RCU)
{
	rcu_read_unlock();
	do {
		(void)&(nvmeq->dev->io_queue);
		preempt_enable();
	} while (0);
}

but it's never evaluated, so the fact that it *would* be a NULL pointer
dereference is irrelevant.

> That's a no-op, right? It is on my config, so it appears to be safe (for
> now). I'd agree it's not a good idea relying on that macro to never use
> this parameter, though.
> 
> Maybe do this instead:

Taking a step back, the API is kind of bogus.  You shouldn't have to
'put' something that was NULL.  So something like this, perhaps?

I wouldn't mind seeing lock_nvmeq() having the same semantics, but that's
a larger patch.

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index cd8a8bc7..0691e86 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -275,29 +275,34 @@ static struct nvme_queue *raw_nvmeq(struct nvme_dev *dev, int qid)
 	return rcu_dereference_raw(dev->queues[qid]);
 }
 
-static struct nvme_queue *get_nvmeq(struct nvme_dev *dev) __acquires(RCU)
+static struct nvme_queue *lock_nvmeq(struct nvme_dev *dev, int q_idx)
+							__acquires(RCU)
 {
-	unsigned queue_id = get_cpu_var(*dev->io_queue);
 	rcu_read_lock();
-	return rcu_dereference(dev->queues[queue_id]);
+	return rcu_dereference(dev->queues[q_idx]);
 }
 
-static void put_nvmeq(struct nvme_queue *nvmeq) __releases(RCU)
+static void unlock_nvmeq(struct nvme_queue *nvmeq) __releases(RCU)
 {
 	rcu_read_unlock();
-	put_cpu_var(nvmeq->dev->io_queue);
 }
 
-static struct nvme_queue *lock_nvmeq(struct nvme_dev *dev, int q_idx)
-							__acquires(RCU)
+static struct nvme_queue *get_nvmeq(struct nvme_dev *dev) __acquires(RCU)
 {
-	rcu_read_lock();
-	return rcu_dereference(dev->queues[q_idx]);
+	struct nvme_queue *nvmeq;
+	unsigned queue_id = get_cpu_var(*dev->io_queue);
+	nvmeq = lock_nvmeq(dev, queue_id);
+	if (nvmeq)
+		return nvmeq;
+	unlock_nvmeq(nvmeq);
+	put_cpu_var(*dev->io_queue);
+	return NULL;
 }
 
-static void unlock_nvmeq(struct nvme_queue *nvmeq) __releases(RCU)
+static void put_nvmeq(struct nvme_queue *nvmeq) __releases(RCU)
 {
-	rcu_read_unlock();
+	unlock_nvmeq(nvmeq);
+	put_cpu_var(nvmeq->dev->io_queue);
 }
 
 /**
@@ -801,7 +806,6 @@ static void nvme_make_request(struct request_queue *q, struct bio *bio)
 	int result = -EBUSY;
 
 	if (!nvmeq) {
-		put_nvmeq(NULL);
 		bio_endio(bio, -EIO);
 		return;
 	}
