From: parav.pandit@avagotech.com (Parav Pandit)
Date: Thu, 18 Jun 2015 23:18:42 +0530
Subject: [PATCH] NVMe: Fixed race between nvme_thread & probe path.
In-Reply-To: <20150618155932.GA1276@localhost.localdomain>
References: <1434624230-25050-1-git-send-email-Parav.pandit@avagotech.com>
 <20150618155932.GA1276@localhost.localdomain>
Message-ID: <CAGgvQNRjgwRFdN54v7j5gnS1xEXpRADr=0WZO3iH4AcQaNsY8g@mail.gmail.com>

On Thu, Jun 18, 2015@9:29 PM, Jon Derrick <jonathan.derrick@intel.com> wrote:
> On Thu, Jun 18, 2015@04:13:50PM +0530, Parav Pandit wrote:
>> Kernel thread nvme_thread and driver load process can be executing
>> in parallel on different CPU. This leads to race condition whenever
>> nvme_alloc_queue() instructions are executed out of order that can
>> reflects incorrect value for nvme_thread.
>> Memory barrier in nvme_alloc_queue() ensures that it maintains the
>> order and and data dependency read barrier in reader thread ensures
>> that cpu cache is synced.
>>
>> Signed-off-by: Parav Pandit <Parav.pandit at avagotech.com>
>> ---
>>  drivers/block/nvme-core.c |   12 ++++++++++--
>>  1 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
>> index 5961ed7..90fb0ce 100644
>> --- a/drivers/block/nvme-core.c
>> +++ b/drivers/block/nvme-core.c
>> @@ -1403,8 +1403,10 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
>>       nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
>>       nvmeq->q_depth = depth;
>>       nvmeq->qid = qid;
>> -     dev->queue_count++;
>>       dev->queues[qid] = nvmeq;
>> +     /* update queues first before updating queue_count */
>> +     smp_wmb();
>> +     dev->queue_count++;
>>
>>       return nvmeq;
>>
>
> This has been applied already as an explicit mb()

Since these structure is only accessible by software, won't smp_wmb()
sufficient enough?

>
>> @@ -2073,7 +2075,13 @@ static int nvme_kthread(void *data)
>>                               continue;
>>                       }
>>                       for (i = 0; i < dev->queue_count; i++) {
>> -                             struct nvme_queue *nvmeq = dev->queues[i];
>> +                             struct nvme_queue *nvmeq;
>> +
>> +                             /* make sure to read queue_count before
>> +                              * traversing queues.
>> +                              */
>> +                             smp_read_barrier_depends();
>> +                             nvmeq = dev->queues[i];
>>                               if (!nvmeq)
>>                                       continue;
>>                               spin_lock_irq(&nvmeq->q_lock);
>
> I don't think this is necessary. If queue_count is incremented while in this loop, it will be picked up the next time the kthread runs

ok. Make sense.
