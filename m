From: ks0204.kim@samsung.com (=?ks_c_5601-1987?B?seiw5rvq?=)
Date: Thu, 03 Sep 2015 14:01:07 +0900
Subject: setting nvme irq per cpu affinity in device driver
In-Reply-To: <20150902140517.GA9787@infradead.org>
References: <003c01d0e569$dd9a7b40$98cf71c0$@samsung.com>
 <20150902140517.GA9787@infradead.org>
Message-ID: <007c01d0e605$8b054df0$a10fe9d0$@samsung.com>

Hi Christoph Hellwig,
Thank you for your comment.
I've fixed to call kernel API, irq_set_affinity(), assuming it will be
provided again.

Let me ask one thing.
My current approach is that assigning a CPU to an IRQ for a CQ interrupt by
retrieving cpu id with get_cpu_mask().
Do you think blk_mq_tags_cpumask() might work better?



module_param(shutdown_timeout, byte, 0644);
 MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for controller
shutdown");

+static int use_set_irq_affinity;
+module_param(use_set_irq_affinity, int, 0);
+MODULE_PARM_DESC(use_set_irq_affinity, "set irq affinity to assign CPU per
IRQ evenly");
+
 static int nvme_major;
 module_param(nvme_major, int, 0);

@@ -249,6 +253,14 @@
        blk_mq_start_request(blk_mq_rq_from_pdu(cmd));
 }

+static nvme_set_irq_affinity(unsigned int irq, const struct cpumask *mask)
+{
+       int ret = 0;
+       /* call kernel API  when provided */
+       /* ret = irq_set_affinity() */
+       return ret;
+}
+
 static void *iod_get_private(struct nvme_iod *iod)
 {
        return (void *) (iod->private & ~0x1UL);
@@ -2839,13 +2851,19 @@
        int i;

        for (i = 0; i < dev->online_queues; i++) {
+               int cpu_id;
                nvmeq = dev->queues[i];

-               if (!nvmeq->tags || !(*nvmeq->tags))
+               if (!nvmeq)
                        continue;

-               irq_set_affinity_hint(dev->entry[nvmeq->cq_vector].vector,
-                                       blk_mq_tags_cpumask(*nvmeq->tags));
+               cpu_id = (i <= 1) ? 0 : i-1;
+               irq_set_affinity_hint(dev->entry[nvmeq-
>cq_vector].vector,get_cpu_mask(cpu_id));
+               if(use_set_irq_affinity){
+                       dev_info(dev->dev,"set affinity(IRQ%d-
>CPU%d)\n",dev->entry[nvmeq->cq_vector].vector,cpu_id);
+                       nvme_set_irq_affinity(dev->entry[nvmeq-
>cq_vector].vector,get_cpu_mask(cpu_id),false);
+               }
+
        }
 }


-----Original Message-----
From: Christoph Hellwig [mailto:hch@infradead.org] 
Sent: Wednesday, September 02, 2015 11:05 PM
To: ??????
Cc: Linux-nvme at lists.infradead.org
Subject: Re: setting nvme irq per cpu affinity in device driver

We'll need a proper API in the interrupt subsystem to set the affinity
instead of poking directly into the internals.  The irq subsystem
maintainer already indicated he's fine with adding suh an API in principle.
Please go ahead and propose something similar to your implementation, just
as an exported API in kernel/irq instead of inside the NVMe driver.
