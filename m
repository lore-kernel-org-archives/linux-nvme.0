From: willy@linux.intel.com (Matthew Wilcox)
Date: Sun, 2 Feb 2014 13:28:33 -0500
Subject: [PATCHv2 0/4] IO Queue fixes rewrite
In-Reply-To: <1391212422-14764-1-git-send-email-keith.busch@intel.com>
References: <1391212422-14764-1-git-send-email-keith.busch@intel.com>
Message-ID: <20140202182833.GC2285@linux.intel.com>

On Fri, Jan 31, 2014@04:53:38PM -0700, Keith Busch wrote:
> The only patch different in v2 from the previous is the "Per-cpu IO
> queues". The feedback on using the per cpu variable to point to an index
> rather than a struct nvme_queue pointer was a great idea!
> 
> I only included all 4 in this set because I wanted to make sure they
> apply cleanly against the new tree.
> 
> I also ran sparse this time; I've exceeded my fair share of sparse errors
> working on this driver. :)

Unfortunately, you missed a CONFIG option to enable checking of __rcu.
You need CONFIG_SPARSE_RCU_POINTER=y

With that enabled, I get a bunch of warnings like this:

drivers/block/nvme-core.c:942:48: warning: incorrect type in argument 1 (different address spaces)
drivers/block/nvme-core.c:942:48:    expected struct nvme_queue *nvmeq
drivers/block/nvme-core.c:942:48:    got struct nvme_queue [noderef] <asn:4>*<noident>
drivers/block/nvme-core.c:948:49: warning: incorrect type in argument 1 (different address spaces)
drivers/block/nvme-core.c:948:49:    expected struct nvme_queue *nvmeq
drivers/block/nvme-core.c:948:49:    got struct nvme_queue [noderef] <asn:4>*<noident>

The problem is that only the IO queues need to be RCU-protected, but every
time we access the admin queue, we get a warning, because clearly there's
no way to tell sparse "element 0 of this array isn't RCU protected,
only elements 1-n are".

So ... I think I'll just include patch 1 out of this set and send a pull
request to Linux today.
