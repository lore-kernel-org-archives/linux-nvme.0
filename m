From: axboe@kernel.dk (Jens Axboe)
Date: Sun, 9 Dec 2018 11:18:16 -0700
Subject: [PATCH] nvme: default to 0 poll queues
In-Reply-To: <C7D155CA-8DA8-4DF2-BBC2-14E6AF436F24@kernel.dk>
References: <20181209004953.GA11638@roeck-us.net>
 <fa7aabad-774b-4e5b-686f-3696762291c1@kernel.dk>
 <4ad5653b-1cd4-a770-2290-ca032eeb7072@roeck-us.net>
 <C7D155CA-8DA8-4DF2-BBC2-14E6AF436F24@kernel.dk>
Message-ID: <f971d196-1f73-3a70-f493-b292df00df9b@kernel.dk>

On 12/8/18 11:31 PM, Jens Axboe wrote:
> On Dec 8, 2018,@11:22 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>>> On 12/8/18 9:38 PM, Jens Axboe wrote:
>>>> On 12/8/18 5:49 PM, Guenter Roeck wrote:
>>>> Hi,
>>>>
>>>>> On Mon, Nov 19, 2018@08:18:24AM -0700, Jens Axboe wrote:
>>>>> We need a better way of configuring this, and given that polling is
>>>>> (still) a bit niche, let's default to using 0 poll queues. That way
>>>>> we'll have the same read/write/poll behavior as 4.20, and users that
>>>>> want to test/use polling are required to do manual configuration of the
>>>>> number of poll queues.
>>>>>
>>>>> Reviewed-by: Christoph Hellwig <hch at lst.de>
>>>>> Signed-off-by: Jens Axboe <axboe at kernel.dk>
>>>>> ---
>>>>
>>>> This patch results in a boot stall when booting parisc (hppa) images
>>>> from nvme in qemu.
>>>>
>>>> ...
>>>> Fusion MPT SAS Host driver 3.04.20
>>>> rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
>>>> rcu:    (detected by 0, t=5252 jiffies, g=141, q=22)
>>>> rcu: All QSes seen, last rcu_sched kthread activity 5252 (-66742--71994), jiffies_till_next_fqs=1, root ->qsmask 0x0
>>>> kworker/u8:3    R  running task        0    85      2 0x00000004
>>>> Workqueue: nvme-reset-wq nvme_reset_work
>>>> Backtrace:
>>>>  [<10190d20>] show_stack+0x28/0x38
>>>>  [<101dd1e0>] sched_show_task.part.3+0xc4/0x144
>>>>  [<101dd290>] sched_show_task+0x30/0x38
>>>>  [<10221e18>] rcu_check_callbacks+0x760/0x7a4
>>>>
>>>> rcu: rcu_sched kthread starved for 5252 jiffies! g141 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
>>>> rcu: RCU grace-period kthread stack dump:
>>>> rcu_sched       R  running task        0    10      2 0x00000000
>>>> Backtrace:
>>>>  [<10995b1c>] __schedule+0x214/0x648
>>>>  [<10995f94>] schedule+0x44/0xa8
>>>>  [<1099a7c4>] schedule_timeout+0x114/0x1a0
>>>>  [<10220e70>] rcu_gp_kthread+0x744/0x968
>>>>  [<101d5438>] kthread+0x154/0x15c
>>>>  [<1019501c>] ret_from_kernel_thread+0x1c/0x24
>>>>
>>>> [ continued ]
>>>>
>>>> This is only seen in SMP configurations; non-SMP configurations are ok.
>>>> Reverting the patch fixes the problem. v4.20-rcX and earlier kernels
>>>> also boot without problems.
>>>>
>>>> For reference, here is the qemu command line. This is with qemu 3.0.
>>>>
>>>> qemu-system-hppa -kernel vmlinux -no-reboot \
>>>>    -snapshot \
>>>>    -device nvme,serial=foo,drive=d0 \
>>>>    -drive file=rootfs.ext2,if=none,format=raw,id=d0 \
>>>>    -append 'root=/dev/nvme0n1 rw rootwait panic=-1 console=ttyS0,115200 ' \
>>>>    -nographic -monitor null
>>>>
>>>> Please let me know if you need additional information.
>>> Hmm, I think the queue reduction case has a logic error. Actually there
>>> are two bugs:
>>> 1) Ensure we don't keep overwriting the queue count we ask for
>>> 2) Don't include poll_queues in the vectors we need
>>> Untested... And not super pretty. But does this work for you?
>>
>> It solves the boot problem on parisc/hppa. I didn't test with any other architectures.
>> Should I run a complete test sequence ?
> 
> That?d be great, thanks. 

This one is a bit prettier, I think it makes more sense to do it this way.
Just did some random testing with various limitations and it seems to hold
up fine for me in terms of adjusting the queues to the right counts. I'm
going to send this one out for review.


diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7732c4979a4e..0fe48b128aff 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2030,60 +2030,40 @@ static int nvme_setup_host_mem(struct nvme_dev *dev)
 	return ret;
 }
 
-static void nvme_calc_io_queues(struct nvme_dev *dev, unsigned int nr_io_queues)
+static void nvme_calc_io_queues(struct nvme_dev *dev, unsigned int irq_queues)
 {
 	unsigned int this_w_queues = write_queues;
-	unsigned int this_p_queues = poll_queues;
 
 	/*
 	 * Setup read/write queue split
 	 */
-	if (nr_io_queues == 1) {
+	if (irq_queues == 1) {
 		dev->io_queues[HCTX_TYPE_DEFAULT] = 1;
 		dev->io_queues[HCTX_TYPE_READ] = 0;
-		dev->io_queues[HCTX_TYPE_POLL] = 0;
 		return;
 	}
 
-	/*
-	 * Configure number of poll queues, if set
-	 */
-	if (this_p_queues) {
-		/*
-		 * We need at least one queue left. With just one queue, we'll
-		 * have a single shared read/write set.
-		 */
-		if (this_p_queues >= nr_io_queues) {
-			this_w_queues = 0;
-			this_p_queues = nr_io_queues - 1;
-		}
-
-		dev->io_queues[HCTX_TYPE_POLL] = this_p_queues;
-		nr_io_queues -= this_p_queues;
-	} else
-		dev->io_queues[HCTX_TYPE_POLL] = 0;
-
 	/*
 	 * If 'write_queues' is set, ensure it leaves room for at least
 	 * one read queue
 	 */
-	if (this_w_queues >= nr_io_queues)
-		this_w_queues = nr_io_queues - 1;
+	if (this_w_queues >= irq_queues)
+		this_w_queues = irq_queues - 1;
 
 	/*
 	 * If 'write_queues' is set to zero, reads and writes will share
 	 * a queue set.
 	 */
 	if (!this_w_queues) {
-		dev->io_queues[HCTX_TYPE_DEFAULT] = nr_io_queues;
+		dev->io_queues[HCTX_TYPE_DEFAULT] = irq_queues;
 		dev->io_queues[HCTX_TYPE_READ] = 0;
 	} else {
 		dev->io_queues[HCTX_TYPE_DEFAULT] = this_w_queues;
-		dev->io_queues[HCTX_TYPE_READ] = nr_io_queues - this_w_queues;
+		dev->io_queues[HCTX_TYPE_READ] = irq_queues - this_w_queues;
 	}
 }
 
-static int nvme_setup_irqs(struct nvme_dev *dev, int nr_io_queues)
+static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	int irq_sets[2];
@@ -2093,6 +2073,20 @@ static int nvme_setup_irqs(struct nvme_dev *dev, int nr_io_queues)
 		.sets = irq_sets,
 	};
 	int result = 0;
+	unsigned int irq_queues, this_p_queues;
+
+	/*
+	 * Poll queues don't need interrupts, but we need at least one IO
+	 * queue left over for non-polled IO.
+	 */
+	this_p_queues = poll_queues;
+	if (this_p_queues >= nr_io_queues) {
+		this_p_queues = nr_io_queues - 1;
+		irq_queues = 1;
+	} else {
+		irq_queues = nr_io_queues - this_p_queues;
+	}
+	dev->io_queues[HCTX_TYPE_POLL] = this_p_queues;
 
 	/*
 	 * For irq sets, we have to ask for minvec == maxvec. This passes
@@ -2100,7 +2094,7 @@ static int nvme_setup_irqs(struct nvme_dev *dev, int nr_io_queues)
 	 * IRQ vector needs.
 	 */
 	do {
-		nvme_calc_io_queues(dev, nr_io_queues);
+		nvme_calc_io_queues(dev, irq_queues);
 		irq_sets[0] = dev->io_queues[HCTX_TYPE_DEFAULT];
 		irq_sets[1] = dev->io_queues[HCTX_TYPE_READ];
 		if (!irq_sets[1])
@@ -2111,11 +2105,11 @@ static int nvme_setup_irqs(struct nvme_dev *dev, int nr_io_queues)
 		 * 1 + 1 queues, just ask for a single vector. We'll share
 		 * that between the single IO queue and the admin queue.
 		 */
-		if (!(result < 0 && nr_io_queues == 1))
-			nr_io_queues = irq_sets[0] + irq_sets[1] + 1;
+		if (!(result < 0 || irq_queues == 1))
+			irq_queues = irq_sets[0] + irq_sets[1] + 1;
 
-		result = pci_alloc_irq_vectors_affinity(pdev, nr_io_queues,
-				nr_io_queues,
+		result = pci_alloc_irq_vectors_affinity(pdev, irq_queues,
+				irq_queues,
 				PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
 
 		/*
@@ -2125,12 +2119,12 @@ static int nvme_setup_irqs(struct nvme_dev *dev, int nr_io_queues)
 		 * likely does not. Back down to ask for just one vector.
 		 */
 		if (result == -ENOSPC) {
-			nr_io_queues--;
-			if (!nr_io_queues)
+			irq_queues--;
+			if (!irq_queues)
 				return result;
 			continue;
 		} else if (result == -EINVAL) {
-			nr_io_queues = 1;
+			irq_queues = 1;
 			continue;
 		} else if (result <= 0)
 			return -EIO;

-- 
Jens Axboe
