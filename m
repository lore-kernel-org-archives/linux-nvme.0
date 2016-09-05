From: hch@lst.de (Christoph Hellwig)
Date: Mon, 5 Sep 2016 21:48:00 +0200
Subject: [PATCH 4/7] blk-mq: allow the driver to pass in an affinity mask
In-Reply-To: <20160901142410.GA10903@localhost.localdomain>
References: <1472468013-29936-1-git-send-email-hch@lst.de>
 <1472468013-29936-5-git-send-email-hch@lst.de>
 <20160831163852.GB5598@localhost.localdomain> <20160901084624.GC4115@lst.de>
 <20160901142410.GA10903@localhost.localdomain>
Message-ID: <20160905194759.GA26008@lst.de>

On Thu, Sep 01, 2016@10:24:10AM -0400, Keith Busch wrote:
> On Thu, Sep 01, 2016@10:46:24AM +0200, Christoph Hellwig wrote:
> > On Wed, Aug 31, 2016@12:38:53PM -0400, Keith Busch wrote:
> > > This can't be right. We have a single affinity mask for the entire
> > > set, but what I think we want is an one affinity mask for each
> > > nr_io_queues. The irq_create_affinity_mask should then create an array
> > > of cpumasks based on nr_vecs..
> > 
> > Nah, this is Thomas' creating abuse of the cpumask type.  Every bit set
> > in the affinity_mask means this is a cpu we allocate a vector / queue to.
> 
> Yeah, I gathered that's what it was providing, but that's just barely
> not enough information to do something useful. The CPUs that aren't set
> have to use a previously assigned vector/queue, but which one?

Always the previous one.  Below is a patch to get us back to the
previous behavior:

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 32f6cfc..09d4407 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -29,6 +29,8 @@ struct cpumask *irq_create_affinity_mask(unsigned int *nr_vecs)
 {
 	struct cpumask *affinity_mask;
 	unsigned int max_vecs = *nr_vecs;
+	unsigned int nr_cpus = 0, nr_uniq_cpus = 0, cpu;
+	unsigned int vec = 0, prev = -1, idx = 0;
 
 	if (max_vecs == 1)
 		return NULL;
@@ -40,24 +42,27 @@ struct cpumask *irq_create_affinity_mask(unsigned int *nr_vecs)
 	}
 
 	get_online_cpus();
-	if (max_vecs >= num_online_cpus()) {
-		cpumask_copy(affinity_mask, cpu_online_mask);
-		*nr_vecs = num_online_cpus();
-	} else {
-		unsigned int vecs = 0, cpu;
-
-		for_each_online_cpu(cpu) {
-			if (cpu == get_first_sibling(cpu)) {
-				cpumask_set_cpu(cpu, affinity_mask);
-				vecs++;
-			}
-
-			if (--max_vecs == 0)
-				break;
-		}
-		*nr_vecs = vecs;
+	for_each_online_cpu(cpu) {
+		nr_cpus++;
+		if (cpu == get_first_sibling(cpu))
+			nr_uniq_cpus++;
+	}
+
+	for_each_online_cpu(cpu) {
+		if (max_vecs >= nr_cpus || nr_cpus == nr_uniq_cpus)
+			vec = idx * max_vecs / nr_cpus;
+		else if (cpu == get_first_sibling(cpu))
+			vec = idx * max_vecs / nr_uniq_cpus;
+		else
+			continue;
+
+		if (vec != prev)
+			cpumask_set_cpu(cpu, affinity_mask);
+		prev = vec;
+		idx++;
 	}
 	put_online_cpus();
 
+	*nr_vecs = idx;
 	return affinity_mask;
 }
