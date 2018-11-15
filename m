From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 15 Nov 2018 15:12:48 -0700
Subject: [PATCH] nvme: utilize two queue maps, one for reads and one for
 writes
In-Reply-To: <20181115220610.GA7735@roeck-us.net>
References: <20181115191126.GA16973@roeck-us.net>
 <e7f72ebb-68e8-29f4-121b-4053ec8b537e@kernel.dk>
 <20181115193854.GA30639@roeck-us.net>
 <6fb23170-5029-f926-c063-77cefea37427@kernel.dk>
 <8bb5c405-55f8-f330-85a5-b22163c83119@kernel.dk>
 <20181115220610.GA7735@roeck-us.net>
Message-ID: <297ce9b7-3396-9dfa-0ef3-45d5f467c491@kernel.dk>

On 11/15/18 3:06 PM, Guenter Roeck wrote:
> On Thu, Nov 15, 2018@12:43:40PM -0700, Jens Axboe wrote:
>> On 11/15/18 12:40 PM, Jens Axboe wrote:
>>> On 11/15/18 12:38 PM, Guenter Roeck wrote:
>>>> On Thu, Nov 15, 2018@12:29:04PM -0700, Jens Axboe wrote:
>>>>> On 11/15/18 12:11 PM, Guenter Roeck wrote:
>>>>>> On Wed, Nov 14, 2018@10:12:44AM -0700, Jens Axboe wrote:
>>>>>>>
>>>>>>> I think the below patch should fix it.
>>>>>>>
>>>>>>
>>>>>> I spoke too early. sparc64, next-20181115:
>>>>>>
>>>>>> [   14.204370] nvme nvme0: pci function 0000:02:00.0
>>>>>> [   14.249956] nvme nvme0: Removing after probe failure status: -5
>>>>>> [   14.263496] ------------[ cut here ]------------
>>>>>> [   14.263913] WARNING: CPU: 0 PID: 15 at kernel/irq/manage.c:1597 __free_irq+0xa4/0x320
>>>>>> [   14.264265] Trying to free already-free IRQ 9
>>>>>> [   14.264519] Modules linked in:
>>>>>> [   14.264961] CPU: 0 PID: 15 Comm: kworker/u2:1 Not tainted 4.20.0-rc2-next-20181115 #1
>>>>>> [   14.265555] Workqueue: nvme-reset-wq nvme_reset_work
>>>>>> [   14.265899] Call Trace:
>>>>>> [   14.266118]  [000000000046944c] __warn+0xcc/0x100
>>>>>> [   14.266375]  [00000000004694b0] warn_slowpath_fmt+0x30/0x40
>>>>>> [   14.266635]  [00000000004d4ce4] __free_irq+0xa4/0x320
>>>>>> [   14.266867]  [00000000004d4ff8] free_irq+0x38/0x80
>>>>>> [   14.267092]  [00000000007b1874] pci_free_irq+0x14/0x40
>>>>>> [   14.267327]  [00000000008a5444] nvme_dev_disable+0xe4/0x520
>>>>>> [   14.267576]  [00000000008a69b8] nvme_reset_work+0x138/0x1c60
>>>>>> [   14.267827]  [0000000000488dd0] process_one_work+0x230/0x6e0
>>>>>> [   14.268079]  [00000000004894f4] worker_thread+0x274/0x520
>>>>>> [   14.268321]  [0000000000490624] kthread+0xe4/0x120
>>>>>> [   14.268544]  [00000000004060c4] ret_from_fork+0x1c/0x2c
>>>>>> [   14.268825]  [0000000000000000]           (null)
>>>>>> [   14.269089] irq event stamp: 32796
>>>>>> [   14.269350] hardirqs last  enabled at (32795): [<0000000000b624a4>] _raw_spin_unlock_irqrestore+0x24/0x80
>>>>>> [   14.269757] hardirqs last disabled at (32796): [<0000000000b622f4>] _raw_spin_lock_irqsave+0x14/0x60
>>>>>> [   14.270566] softirqs last  enabled at (32780): [<0000000000b64c18>] __do_softirq+0x238/0x520
>>>>>> [   14.271206] softirqs last disabled at (32729): [<000000000042ceec>] do_softirq_own_stack+0x2c/0x40
>>>>>> [   14.272288] ---[ end trace cb79ccd2a0a03f3c ]---
>>>>>>
>>>>>> Looks like an error during probe followed by an error cleanup problem.
>>>>>
>>>>> Did it previous probe fine? Or is the new thing just the fact that
>>>>> we spew a warning on trying to free a non-existing vector?
>>>>>
>>>> This works fine in mainline, if that is your question.
>>>
>>> Yeah, as soon as I sent the other email I realized that. Let me send
>>> you a quick patch.
>>
>> How's this?
>>
>>
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index ffbab5b01df4..fd73bfd2d1be 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -2088,15 +2088,11 @@ static int nvme_setup_irqs(struct nvme_dev *dev, int nr_io_queues)
>>  			affd.nr_sets = 1;
>>  
>>  		/*
>> -		 * Need IRQs for read+write queues, and one for the admin queue.
>> -		 * If we can't get more than one vector, we have to share the
>> -		 * admin queue and IO queue vector. For that case, don't add
>> -		 * an extra vector for the admin queue, or we'll continue
>> -		 * asking for 2 and get -ENOSPC in return.
>> +		 * If we got a failure and we're down to asking for just
>> +		 * 1 + 1 queues, just ask for a single vector. We'll share
>> +		 * that between the single IO queue and the admin queue.
>>  		 */
>> -		if (result == -ENOSPC && nr_io_queues == 1)
>> -			nr_io_queues = 1;
>> -		else
>> +		if (!(result < 0 && nr_io_queues == 1))
>>  			nr_io_queues = irq_sets[0] + irq_sets[1] + 1;
>>  
> 
> Unfortunately, the code doesn't even get here because the call of
> pci_alloc_irq_vectors_affinity in the first iteration fails with
> -EINVAL, which results in an immediate return with -EIO.

Oh yeah... How about this then?


diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ffbab5b01df4..4d161daa9c3a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2088,15 +2088,11 @@ static int nvme_setup_irqs(struct nvme_dev *dev, int nr_io_queues)
 			affd.nr_sets = 1;
 
 		/*
-		 * Need IRQs for read+write queues, and one for the admin queue.
-		 * If we can't get more than one vector, we have to share the
-		 * admin queue and IO queue vector. For that case, don't add
-		 * an extra vector for the admin queue, or we'll continue
-		 * asking for 2 and get -ENOSPC in return.
+		 * If we got a failure and we're down to asking for just
+		 * 1 + 1 queues, just ask for a single vector. We'll share
+		 * that between the single IO queue and the admin queue.
 		 */
-		if (result == -ENOSPC && nr_io_queues == 1)
-			nr_io_queues = 1;
-		else
+		if (!(result < 0 && nr_io_queues == 1))
 			nr_io_queues = irq_sets[0] + irq_sets[1] + 1;
 
 		result = pci_alloc_irq_vectors_affinity(pdev, nr_io_queues,
@@ -2111,6 +2107,9 @@ static int nvme_setup_irqs(struct nvme_dev *dev, int nr_io_queues)
 			if (!nr_io_queues)
 				return result;
 			continue;
+		} else if (result == -EINVAL) {
+			nr_io_queues = 1;
+			continue;
 		} else if (result <= 0)
 			return -EIO;
 		break;

-- 
Jens Axboe
