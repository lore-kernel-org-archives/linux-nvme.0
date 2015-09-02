From: ks0204.kim@samsung.com (=?ks_c_5601-1987?B?seiw5rvq?=)
Date: Wed, 02 Sep 2015 19:26:44 +0900
Subject: setting nvme irq per cpu affinity in device driver
Message-ID: <003c01d0e569$dd9a7b40$98cf71c0$@samsung.com>

Hello.
Recently, we've experienced two bad conditions in the use of nvme ssd.

First one was, soft-lockup kernel warning has continually displayed when we
run fio test with high jobs(>32) on a SMP system(usually more than 32 CPUs).
Second one was, scalability has significantly decreased under multi SSD
device environment. 
The more we use nvme SSDs in our test, the lower scalability has shown. 
Those two were critical issue for us as it hinders to archive high IOPS.


We've investigated to find out the cause of the problem and we've found it.
The root cause was that the majority of interrupt handling has been
processed by a CPU, mostly by CPU0,
unlikely our expectation that an interrupt would be also handled by the
same CPU that handled SQ submission.
When we balanced IRQ processing over multi CPUs, both of the phenomenon has
disappeared and significantly improved.

Actually, in current status, device driver already tries to set
affinity_hint for IRQs during Q initialization.
But in our tests, it does not guarantee the CPU distribution on system-wide
even with irqbalance daemon working, failing to resolve above issues.
Later I've thought that setting affinity by shell script, but come to know
that it has limitation to make it always work well. 

So, we become thought that a clear way to solve the problems is setting the
nvme irq affinity from device driver by itself.
With this modification, we could archive high scalability under large IO
requests with multi SSD devices.
We think this can help those who want to expect high IOPS as we did.


As a result, we  suggest the patch providing a new module option,
use_set_irq_affinity(default=0).
When it is enabled(=1),  insmod nvme.ko use_set_irq_affinity=1, 
nvme IRQ per CPU matching is proceeded in the process of Q initialization.
It finally effects on /proc/irq/$IRQNO/smp_affinity.
Of course, system administrator can change it later on purpose for some
reason.

We hope the snippet merge on mainstream. Please review the modification.
It is created from 4.2-rc6 nvme-core.c


--- nvme-core.c.426.org 2015-09-02 23:54:16.479746463 +0900
+++ nvme-core.c 2015-09-03 01:10:48.944251952 +0900
@@ -63,6 +63,14 @@
 module_param(shutdown_timeout, byte, 0644);
 MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for controller
shutdown");

+static int use_set_irq_affinity;
+module_param(use_set_irq_affinity, int, 0);
+MODULE_PARM_DESC(use_set_irq_affinity, "set irq affinity to assign CPU per
IRQ evenly");
+
+static int interrupt_coalescing_param;
+module_param(interrupt_coalescing_param, int, 0);
+MODULE_PARM_DESC(interrupt_coalescing_param, "interrupt coalescing
param(time/threshold : 0x00~0xFF");
+
 static int nvme_major;
 module_param(nvme_major, int, 0);

@@ -249,6 +257,29 @@
        blk_mq_start_request(blk_mq_rq_from_pdu(cmd));
 }

+static int nvme_set_irq_affinity(unsigned int irq, const struct cpumask
*mask, bool force)
+{
+       int ret;
+       unsigned long flags;
+       struct irq_desc *desc;
+       struct irq_data *data;
+       struct irq_chip *chip;
+
+       desc = irq_to_desc(irq);
+       if (!desc)
+               return -EINVAL;
+       data = irq_desc_get_irq_data(desc);
+       if(!data)
+               return -EINVAL;
+       chip = irq_data_get_irq_chip(data);
+       if(!chip)
+               return -EINVAL;
+       raw_spin_lock_irqsave(&desc->lock, flags);
+       ret = chip->irq_set_affinity(data, mask, force);
+       raw_spin_unlock_irqrestore(&desc->lock, flags);
+       return ret;
+}
+

static void *iod_get_private(struct nvme_iod *iod)
 {
        return (void *) (iod->private & ~0x1UL);
@@ -2839,13 +2866,19 @@
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
