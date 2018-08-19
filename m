From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 19 Aug 2018 15:45:07 +0300
Subject: [PATCH] block: fix rdma queue mapping
In-Reply-To: <20180817223823.19566-1-sagi@grimberg.me>
References: <20180817223823.19566-1-sagi@grimberg.me>
Message-ID: <5973cbfe-1466-cf44-c33e-d9b0dbcc9ca6@mellanox.com>

Hi Sagi,
did you have a chance to look on Israel's and mine fixes that we 
attached to the first thread ?

there are few issues with this approach. For example in case you don't 
have a "free" cpu in the mask for Qi and you take cpu from Qi+j mask.

Also in case we have a non-symetrical affinity for 2 queues e.g. and the 
system has 32 cpus, the mapping is 16 for each (and not according to the 
user affinity...).

-Max.
