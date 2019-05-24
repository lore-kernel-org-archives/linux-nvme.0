From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 23 May 2019 23:24:29 -0700
Subject: [PATCH] nvme-rdma: Fix a NULL deref when lesser io queues are
 allocated.
In-Reply-To: <20190524044341.GA5129@chelsio.com>
References: <2936d0e0de627fce13f78fca2ef93960aab0d929.1558534119.git.nirranjan@chelsio.com>
 <bf05c7f8-7a97-5e67-3476-b92c698a23a9@mellanox.com>
 <20190523075524.GA15479@chelsio.com>
 <06d347cc-7df6-c2b3-2edf-88a53db3c12d@mellanox.com>
 <20190523114157.GA9479@chelsio.com>
 <033ac067-29b1-30ff-6ad0-5e13510649bd@mellanox.com>
 <20190524044341.GA5129@chelsio.com>
Message-ID: <955d9336-50d7-248c-eed8-3b038f6a5a11@grimberg.me>


>> I'll take deeper look on it next week but please try the new attached patch
> This new patch holds good for the minimal testing I did, with target allocating
> lesser queues.

Hi,

Just got to this one (after ramping up on activity post vacation..)

Max, I think that your patch is missing the case where default+read+poll
queues are higher than controller queue limit but we can still fit
a queue separation.

For example:
- requested 10/10/10 (default/read/poll)
- supported 28

If I read your patch correctly, this will fall-back to shared read/write
queue maps with no poll queues (10/0/0), while we'd want in this case
to still have the separation but simply have less poll queues (10/10/8).

I posted an alternative patch for review.
