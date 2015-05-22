From: keith.busch@intel.com (Keith Busch)
Date: Fri, 22 May 2015 17:47:55 +0000 (UTC)
Subject: [PATCH] NVMe: Avoid interrupt disable during queue init.
In-Reply-To: <CAGgvQNReNQgiXydEqX-c+PNgsjZDSbOdYkTTBz8SV-sPwCVL7Q@mail.gmail.com>
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
Message-ID: <alpine.LNX.2.00.1505221738090.15930@localhost.lm.intel.com>

On Fri, 22 May 2015, Parav Pandit wrote:
> I agree to it that nvmeq won't be null after mb(); That alone is not sufficient.
>
> What I have proposed in previous email is,
>
> Converting,
>
> struct nvme_queue *nvmeq = dev->queues[i];
> if (!nvmeq)
>    continue;
> spin_lock_irq(nvmeq->q_lock);
>
> to replace with,
>
> struct nvme_queue *nvmeq = rcu_dereference(dev->queues[i]);
> if (!nvmeq)
>    continue;
> spin_lock_irq(nvmeq->q_lock);
>
> This will prevent fetching content of q_lock before checking for NULL
> condition. Classic usage or RCU.

What the heck are you talking about? The value of dev->queue_count won't
even let the thread iterate an nvmeq before q_lock is initialized.

We used to rcu protect queue access, but that was to make nvme's
make_request_fn safe to surprise removal, not for the polling thread.
