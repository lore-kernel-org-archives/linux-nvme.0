From: parav.pandit@avagotech.com (Parav Pandit)
Date: Fri, 22 May 2015 23:03:58 +0530
Subject: [PATCH] NVMe: Avoid interrupt disable during queue init.
In-Reply-To: <alpine.LNX.2.00.1505221700120.15930@localhost.lm.intel.com>
References: <1432253553-17045-1-git-send-email-parav.pandit@avagotech.com>
 <alpine.LNX.2.00.1505211931470.15930@localhost.lm.intel.com>
 <CAGgvQNQHaZBRzedkLmYxCBtDyxq7j2wr=e0vAYfw5r+KKeVbxg@mail.gmail.com>
 <alpine.LNX.2.00.1505221446410.15930@localhost.lm.intel.com>
 <CAGgvQNRi+60uNYqaeKHMRci_9zuDngi07mkUsNSdiOyZz9QG-w@mail.gmail.com>
 <alpine.LNX.2.00.1505221453230.15930@localhost.lm.intel.com>
 <CAGgvQNRhUVujKiniazC6ha3nQm789EeM6XdwFDe42HdOESS0+g@mail.gmail.com>
 <alpine.LNX.2.00.1505221608560.15930@localhost.lm.intel.com>
 <CAGgvQNTHyLZzOdi9m5FPfwwsRtxhrvf48Uz590RNsPVkw+HMNw@mail.gmail.com>
 <alpine.LNX.2.00.1505221700120.15930@localhost.lm.intel.com>
Message-ID: <CAGgvQNReNQgiXydEqX-c+PNgsjZDSbOdYkTTBz8SV-sPwCVL7Q@mail.gmail.com>

On Fri, May 22, 2015@10:37 PM, Keith Busch <keith.busch@intel.com> wrote:
> On Fri, 22 May 2015, Parav Pandit wrote:
>>
>> On Fri, May 22, 2015 at 9:53 PM, Keith Busch <keith.busch at intel.com>
>> wrote:
>>>
>>> A memory barrier before incrementing the dev->queue_count (and assigning
>>> the pointer in the array before that) should address this concern.
>>
>>
>> Sure. mb() will solve the publisher side problem. RCU is wrapper around
>> mb().
>> However mb() doesn't solve the issue of q_lock variable getting
>> fetched before if (!nvmeq) condition being executed, by value
>> compilation optimizations in nvme_kthread().
>
>
> Eh? The value of dev->queue_count prevents the thread's for-loop from
> iterating that nvmeq before the q_lock is initialized.

I agree to it that nvmeq won't be null after mb(); That alone is not sufficient.

What I have proposed in previous email is,

Converting,

struct nvme_queue *nvmeq = dev->queues[i];
if (!nvmeq)
    continue;
spin_lock_irq(nvmeq->q_lock);

to replace with,

struct nvme_queue *nvmeq = rcu_dereference(dev->queues[i]);
if (!nvmeq)
    continue;
spin_lock_irq(nvmeq->q_lock);

This will prevent fetching content of q_lock before checking for NULL
condition. Classic usage or RCU.
