From: parav.pandit@avagotech.com (Parav Pandit)
Date: Fri, 22 May 2015 20:21:27 +0530
Subject: [PATCH] NVMe: Avoid interrupt disable during queue init.
In-Reply-To: <alpine.LNX.2.00.1505221446410.15930@localhost.lm.intel.com>
References: <1432253553-17045-1-git-send-email-parav.pandit@avagotech.com>
 <alpine.LNX.2.00.1505211931470.15930@localhost.lm.intel.com>
 <CAGgvQNQHaZBRzedkLmYxCBtDyxq7j2wr=e0vAYfw5r+KKeVbxg@mail.gmail.com>
 <alpine.LNX.2.00.1505221446410.15930@localhost.lm.intel.com>
Message-ID: <CAGgvQNRi+60uNYqaeKHMRci_9zuDngi07mkUsNSdiOyZz9QG-w@mail.gmail.com>

On Fri, May 22, 2015@8:18 PM, Keith Busch <keith.busch@intel.com> wrote:
> On Thu, 21 May 2015, Parav Pandit wrote:
>>
>> On Fri, May 22, 2015 at 1:04 AM, Keith Busch <keith.busch at intel.com>
>> wrote:
>>>
>>> The q_lock is held to protect polling from reading inconsistent data.
>>
>>
>> ah, yes. I can see the nvme_kthread can poll the CQ while its getting
>> created through the nvme_resume().
>> I think this opens up other issue.
>>
>> nvme_kthread() should,
>>
>> Instead of,
>> struct nvme_queue *nvmeq = dev->queues[i];
>>
>> it should do,
>> struct nvme_queue *nvmeq = rcu_dereference(dev->queues[i]);
>
>
> The rcu protection on nvme queues was removed with the blk-mq conversion
> as we rely on that layer for h/w access.

o.k. But above is at level where data I/Os are not even active. Its
between nvme_kthread and nvme_resume() from power management
subsystem.
I must be missing something.
