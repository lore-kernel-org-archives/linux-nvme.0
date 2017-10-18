From: israelr@mellanox.com (Israel Rukshin)
Date: Wed, 18 Oct 2017 16:58:08 +0300
Subject: [PATCH 0/3] Add BLK_MQ_F_NO_SCHED flag to admin tag set
In-Reply-To: <ac3c9220-a7be-cbd4-324a-ceeb4c31c139@grimberg.me>
References: <1508330306-26844-1-git-send-email-israelr@mellanox.com>
 <ac3c9220-a7be-cbd4-324a-ceeb4c31c139@grimberg.me>
Message-ID: <4f73e090-513c-aa07-a4aa-fcea4bc944a0@mellanox.com>

On 10/18/2017 3:50 PM, Sagi Grimberg wrote:
>
>> Since commit b86dd81
>> "block: get rid of blk-mq default scheduler choice Kconfig entries",
>> when setting nr_hw_queues to 1 the admin tag set uses mq-deadline 
>> scheduler.
>> This flag is useful for admin queues that aren't used for normal IO.
>> We already use this flag at nvme-pci.
>
> How is the fact that we set a single hw queue has anything to do with
> the admin tagset?

Setting nr_hw_queues attribute of admin tag set to 1 influence the value
of nr_hw_queues attribute of the admin queue.
At /block/elevator.c
elevator_init() selects the scheduler according to the value of 
nr_hw_queues
attribute of the admin queue.

if (q->mq_ops) {
     if (q->nr_hw_queues == 1)
         e = elevator_get("mq-deadline", false);
     if (!e)
         return 0;
...

Israel
