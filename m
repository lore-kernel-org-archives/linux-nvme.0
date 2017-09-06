From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 6 Sep 2017 17:50:50 +0300
Subject: [PATCH 2/3] nvmet-rdma: use SRQ per completion vector
In-Reply-To: <1504609157-3004-3-git-send-email-maxg@mellanox.com>
References: <1504609157-3004-1-git-send-email-maxg@mellanox.com>
 <1504609157-3004-3-git-send-email-maxg@mellanox.com>
Message-ID: <b02ac628-3960-7874-90bf-0a96e8938ea7@grimberg.me>


> In order to save resource allocation and utilize the completion
> locality in a better way, allocate Shared Receive Queues (SRQs) per
> completion vector (and not per device).

Something is backwards here, srq per vector is not saving resources
compared to srq per-device, maybe compared to normal receive queues
(if we have enough initiators).

And what do you mean by "utilize the completion locality in a better
way"? How is using srq affecting a completion queue locality?

> Assosiate each created QP/CQ

associate

> with an appropriate SRQ according to the queue index. This association
> will reduce the lock contention in the fast path

It reduces lock contention compared to srq-per-device, not normal
receive queues.


> and increase the locality in memory buffers.

How does it increase locality in memory buffers?
