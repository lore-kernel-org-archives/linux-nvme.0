From: parav.pandit@avagotech.com (Parav Pandit)
Date: Fri, 22 May 2015 09:45:16 +0530
Subject: [PATCH] NVMe: Avoid interrupt disable during queue init.
In-Reply-To: <alpine.LNX.2.00.1505211931470.15930@localhost.lm.intel.com>
References: <1432253553-17045-1-git-send-email-parav.pandit@avagotech.com>
 <alpine.LNX.2.00.1505211931470.15930@localhost.lm.intel.com>
Message-ID: <CAGgvQNQHaZBRzedkLmYxCBtDyxq7j2wr=e0vAYfw5r+KKeVbxg@mail.gmail.com>

On Fri, May 22, 2015@1:04 AM, Keith Busch <keith.busch@intel.com> wrote:
> On Thu, 21 May 2015, Parav Pandit wrote:
>>
>> Avoid diabling interrupt and holding q_lock for the queue
>> which is just getting initialized.
>>
>> With this change, online_queues is also incremented without
>> lock during queue setup stage.
>> if Power management nvme_suspend() kicks in during queue setup time,
>> per nvmeq based q_lock spinlock cannot protect device wide
>> online_queues variable anyway.
>
>
> The q_lock is held to protect polling from reading inconsistent data.

ah, yes. I can see the nvme_kthread can poll the CQ while its getting
created through the nvme_resume().
I think this opens up other issue.

nvme_kthread() should,

Instead of,
struct nvme_queue *nvmeq = dev->queues[i];

it should do,
struct nvme_queue *nvmeq = rcu_dereference(dev->queues[i]);

And,
nvme_alloc_queue()
dev->queues[qid] = nvmeq;

should be,
rcu_assign_pointer(dev->queues[qid], nvmeq);

Otherwise nvme_kthread could get stale value for elements of nvmeq.
I will send patch for fix.
