From: linux@roeck-us.net (Guenter Roeck)
Date: Sat, 8 Dec 2018 22:22:31 -0800
Subject: [PATCH] nvme: default to 0 poll queues
In-Reply-To: <fa7aabad-774b-4e5b-686f-3696762291c1@kernel.dk>
References: <20181209004953.GA11638@roeck-us.net>
 <fa7aabad-774b-4e5b-686f-3696762291c1@kernel.dk>
Message-ID: <4ad5653b-1cd4-a770-2290-ca032eeb7072@roeck-us.net>

On 12/8/18 9:38 PM, Jens Axboe wrote:
> On 12/8/18 5:49 PM, Guenter Roeck wrote:
>> Hi,
>>
>> On Mon, Nov 19, 2018@08:18:24AM -0700, Jens Axboe wrote:
>>> We need a better way of configuring this, and given that polling is
>>> (still) a bit niche, let's default to using 0 poll queues. That way
>>> we'll have the same read/write/poll behavior as 4.20, and users that
>>> want to test/use polling are required to do manual configuration of the
>>> number of poll queues.
>>>
>>> Reviewed-by: Christoph Hellwig <hch at lst.de>
>>> Signed-off-by: Jens Axboe <axboe at kernel.dk>
>>> ---
>>
>> This patch results in a boot stall when booting parisc (hppa) images
>> from nvme in qemu.
>>
>> ...
>> Fusion MPT SAS Host driver 3.04.20
>> rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
>> rcu: 	(detected by 0, t=5252 jiffies, g=141, q=22)
>> rcu: All QSes seen, last rcu_sched kthread activity 5252 (-66742--71994), jiffies_till_next_fqs=1, root ->qsmask 0x0
>> kworker/u8:3    R  running task        0    85      2 0x00000004
>> Workqueue: nvme-reset-wq nvme_reset_work
>> Backtrace:
>>   [<10190d20>] show_stack+0x28/0x38
>>   [<101dd1e0>] sched_show_task.part.3+0xc4/0x144
>>   [<101dd290>] sched_show_task+0x30/0x38
>>   [<10221e18>] rcu_check_callbacks+0x760/0x7a4
>>
>> rcu: rcu_sched kthread starved for 5252 jiffies! g141 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
>> rcu: RCU grace-period kthread stack dump:
>> rcu_sched       R  running task        0    10      2 0x00000000
>> Backtrace:
>>   [<10995b1c>] __schedule+0x214/0x648
>>   [<10995f94>] schedule+0x44/0xa8
>>   [<1099a7c4>] schedule_timeout+0x114/0x1a0
>>   [<10220e70>] rcu_gp_kthread+0x744/0x968
>>   [<101d5438>] kthread+0x154/0x15c
>>   [<1019501c>] ret_from_kernel_thread+0x1c/0x24
>>
>> [ continued ]
>>
>> This is only seen in SMP configurations; non-SMP configurations are ok.
>> Reverting the patch fixes the problem. v4.20-rcX and earlier kernels
>> also boot without problems.
>>
>> For reference, here is the qemu command line. This is with qemu 3.0.
>>
>> qemu-system-hppa -kernel vmlinux -no-reboot \
>> 	-snapshot \
>> 	-device nvme,serial=foo,drive=d0 \
>> 	-drive file=rootfs.ext2,if=none,format=raw,id=d0 \
>> 	-append 'root=/dev/nvme0n1 rw rootwait panic=-1 console=ttyS0,115200 ' \
>> 	-nographic -monitor null
>>
>> Please let me know if you need additional information.
> 
> Hmm, I think the queue reduction case has a logic error. Actually there
> are two bugs:
> 
> 1) Ensure we don't keep overwriting the queue count we ask for
> 2) Don't include poll_queues in the vectors we need
> 
> Untested... And not super pretty. But does this work for you?
> 

It solves the boot problem on parisc/hppa. I didn't test with any other architectures.
Should I run a complete test sequence ?

Guenter

> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 7732c4979a4e..fe00e19493ae 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2083,7 +2083,7 @@ static void nvme_calc_io_queues(struct nvme_dev *dev, unsigned int nr_io_queues)
>   	}
>   }
>   
> -static int nvme_setup_irqs(struct nvme_dev *dev, int nr_io_queues)
> +static int nvme_setup_irqs(struct nvme_dev *dev, int irq_queues, int pqueues)
>   {
>   	struct pci_dev *pdev = to_pci_dev(dev->dev);
>   	int irq_sets[2];
> @@ -2100,7 +2100,8 @@ static int nvme_setup_irqs(struct nvme_dev *dev, int nr_io_queues)
>   	 * IRQ vector needs.
>   	 */
>   	do {
> -		nvme_calc_io_queues(dev, nr_io_queues);
> +		nvme_calc_io_queues(dev, irq_queues + pqueues);
> +		pqueues = dev->io_queues[HCTX_TYPE_POLL];
>   		irq_sets[0] = dev->io_queues[HCTX_TYPE_DEFAULT];
>   		irq_sets[1] = dev->io_queues[HCTX_TYPE_READ];
>   		if (!irq_sets[1])
> @@ -2111,11 +2112,11 @@ static int nvme_setup_irqs(struct nvme_dev *dev, int nr_io_queues)
>   		 * 1 + 1 queues, just ask for a single vector. We'll share
>   		 * that between the single IO queue and the admin queue.
>   		 */
> -		if (!(result < 0 && nr_io_queues == 1))
> -			nr_io_queues = irq_sets[0] + irq_sets[1] + 1;
> +		if (!(result < 0 || irq_queues == 1))
> +			irq_queues = irq_sets[0] + irq_sets[1] + 1;
>   
> -		result = pci_alloc_irq_vectors_affinity(pdev, nr_io_queues,
> -				nr_io_queues,
> +		result = pci_alloc_irq_vectors_affinity(pdev, irq_queues,
> +				irq_queues,
>   				PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
>   
>   		/*
> @@ -2125,12 +2126,12 @@ static int nvme_setup_irqs(struct nvme_dev *dev, int nr_io_queues)
>   		 * likely does not. Back down to ask for just one vector.
>   		 */
>   		if (result == -ENOSPC) {
> -			nr_io_queues--;
> -			if (!nr_io_queues)
> +			irq_queues--;
> +			if (!irq_queues)
>   				return result;
>   			continue;
>   		} else if (result == -EINVAL) {
> -			nr_io_queues = 1;
> +			irq_queues = 1;
>   			continue;
>   		} else if (result <= 0)
>   			return -EIO;
> @@ -2144,7 +2145,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
>   {
>   	struct nvme_queue *adminq = &dev->queues[0];
>   	struct pci_dev *pdev = to_pci_dev(dev->dev);
> -	int result, nr_io_queues;
> +	int result, want_irqs, nr_io_queues, pqueues;
>   	unsigned long size;
>   
>   	nr_io_queues = max_io_queues();
> @@ -2185,7 +2186,20 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
>   	 */
>   	pci_free_irq_vectors(pdev);
>   
> -	result = nvme_setup_irqs(dev, nr_io_queues);
> +	/*
> +	 * If we don't get the number of IO queues we asked for, see if we
> +	 * need to adjust the number of poll queues down
> +	 */
> +	pqueues = poll_queues;
> +	if (!pqueues)
> +		want_irqs = nr_io_queues;
> +	else if (pqueues >= nr_io_queues) {
> +		want_irqs = 1;
> +		pqueues = nr_io_queues - 1;
> +	} else
> +		want_irqs = nr_io_queues - pqueues;
> +
> +	result = nvme_setup_irqs(dev, want_irqs, pqueues);
>   	if (result <= 0)
>   		return -EIO;
>   
> 
