From: parav.pandit@avagotech.com (Parav Pandit)
Date: Fri, 22 May 2015 23:48:41 +0530
Subject: [PATCH] NVMe: Avoid interrupt disable during queue init.
In-Reply-To: <alpine.LNX.2.00.1505221738090.15930@localhost.lm.intel.com>
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
 <CAGgvQNReNQgiXydEqX-c+PNgsjZDSbOdYkTTBz8SV-sPwCVL7Q@mail.gmail.com>
 <alpine.LNX.2.00.1505221738090.15930@localhost.lm.intel.com>
Message-ID: <CAGgvQNQY-9YK5i=waOE8Cext_Lp6vSGw+iofcNmaU29-_kpomw@mail.gmail.com>

On Fri, May 22, 2015@11:17 PM, Keith Busch <keith.busch@intel.com> wrote:
> On Fri, 22 May 2015, Parav Pandit wrote:
>>
>> I agree to it that nvmeq won't be null after mb(); That alone is not
>> sufficient.
>>
>> What I have proposed in previous email is,
>>
>> Converting,
>>
>> struct nvme_queue *nvmeq = dev->queues[i];
>> if (!nvmeq)
>>    continue;
>> spin_lock_irq(nvmeq->q_lock);
>>
>> to replace with,
>>
>> struct nvme_queue *nvmeq = rcu_dereference(dev->queues[i]);
>> if (!nvmeq)
>>    continue;
>> spin_lock_irq(nvmeq->q_lock);
>>
>> This will prevent fetching content of q_lock before checking for NULL
>> condition. Classic usage or RCU.
>
>
> What the heck are you talking about? The value of dev->queue_count won't
> even let the thread iterate an nvmeq before q_lock is initialized.
>
Oh, right. My bad. I was getting confused with the possible reordering
in reset path within,
nvme_free_queues()
1320                 dev->queue_count--;
1321                 dev->queues[i] = NULL;

while nvme_kthread is working on it.
But thats unlikely case because device is removed from the list before.

Yes, so mb() is good enough.
I will send you the patch.
Thanks.


> We used to rcu protect queue access, but that was to make nvme's
> make_request_fn safe to surprise removal, not for the polling thread.
