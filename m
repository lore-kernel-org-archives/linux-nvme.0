From: ming.lei@redhat.com (Ming Lei)
Date: Mon, 11 Dec 2017 21:47:44 +0800
Subject: BUG: NULL pointer at IP: blk_mq_map_swqueue+0xbc/0x200 on
 4.15.0-rc2
In-Reply-To: <07dd2fb3-60e0-445c-211c-6201982ebab4@redhat.com>
References: <799322399.34367785.1512659684033.JavaMail.zimbra@redhat.com>
 <1443577037.35143768.1512717869183.JavaMail.zimbra@redhat.com>
 <20171211035844.GB22819@ming.t460p>
 <07dd2fb3-60e0-445c-211c-6201982ebab4@redhat.com>
Message-ID: <20171211134737.GA22595@ming.t460p>

On Mon, Dec 11, 2017@09:29:40PM +0800, Yi Zhang wrote:
> 
> 
> On 12/11/2017 11:58 AM, Ming Lei wrote:
> > Hi Zhang Yi,
> > 
> > On Fri, Dec 08, 2017@02:24:29AM -0500, Yi Zhang wrote:
> > > Hi
> > > I found this issue during nvme blk-mq io scheduler test on 4.15.0-rc2, let me know if you need more info, thanks.
> > > 
> > > Reproduce steps
> > > MQ_IOSCHEDS=`sed 's/[][]//g' /sys/block/nvme0n1/queue/scheduler
> > > dd if=/dev/nvme0n1p1 of=/dev/null bs=4096 &
> > > while kill -0 $! 2>/dev/null; do
> > > 	for SCHEDULER in $MQ_IOSCHEDS; do
> > > 		echo "INFO: BLK-MQ IO SCHEDULER:$SCHEDULER testing during IO"
> > > 		echo $SCHEDULER > /sys/block/nvme0n1/queue/scheduler
> > > 		echo 1 >/sys/bus/pci/devices/0000\:84\:00.0/reset
> > > 		sleep 0.5
> > > 	done
> > > done
> > > 
> > > Kernel log:
> > > [  101.202734] BUG: unable to handle kernel NULL pointer dereference at 0000000094d3013f
> > > [  101.211487] IP: blk_mq_map_swqueue+0xbc/0x200
> > As we talked offline, this IP points to cpumask_set_cpu(), seems this
> > case may happen when one CPU isn't mapped to any hw queue, could you test
> > the following patch to see if it helps your issue?
> 
> Hi Ming
> With this patch, I reproduced another BUG, here is part for the log
> 
> [?? 93.263237] ------------[ cut here ]------------
> [?? 93.268391] kernel BUG at drivers/nvme/host/pci.c:408!

Hi Zhang Yi,

Thanks for your test!

That is the race between updating hw queue and switching io scheduler,
especially on q->nr_hw_queues. Could you run the following patch to see
if it fixes both?

--
diff --git a/block/blk-mq-pci.c b/block/blk-mq-pci.c
index 76944e3271bf..c60d06bfa76e 100644
--- a/block/blk-mq-pci.c
+++ b/block/blk-mq-pci.c
@@ -33,6 +33,9 @@ int blk_mq_pci_map_queues(struct blk_mq_tag_set *set, struct pci_dev *pdev)
 	const struct cpumask *mask;
 	unsigned int queue, cpu;
 
+	for_each_possible_cpu(cpu)
+		set->mq_map[cpu] = 0;
+
 	for (queue = 0; queue < set->nr_hw_queues; queue++) {
 		mask = pci_irq_get_affinity(pdev, queue);
 		if (!mask)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 11097477eeab..3e91819fc8e8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2415,6 +2415,7 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 		}
 		blk_mq_hctx_kobj_init(hctxs[i]);
 	}
+	mutex_lock(&q->sysfs_lock);
 	for (j = i; j < q->nr_hw_queues; j++) {
 		struct blk_mq_hw_ctx *hctx = hctxs[j];
 
@@ -2428,6 +2429,7 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 		}
 	}
 	q->nr_hw_queues = i;
+	mutex_unlock(&q->sysfs_lock);
 	blk_mq_sysfs_register(q);
 }
 

Thanks,
Ming
