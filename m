From: keith.busch@intel.com (Keith Busch)
Date: Tue, 29 Sep 2015 22:45:47 +0000 (UTC)
Subject: [PATCH 0/3] blk-mq & nvme: introduce .map_changed
In-Reply-To: <CACVXFVNQAO0rPQ_S4VWiywqa=7vzzAeoS7fN5ENw55DyL4Hzcw@mail.gmail.com>
References: <1443496857-26887-1-git-send-email-tom.leiming@gmail.com>
 <alpine.LNX.2.00.1509291418270.23840@localhost.lm.intel.com>
 <560AA46A.9060205@kernel.dk>
 <CACVXFVNQAO0rPQ_S4VWiywqa=7vzzAeoS7fN5ENw55DyL4Hzcw@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1509292240250.23840@localhost.lm.intel.com>

On Tue, 29 Sep 2015, Ming Lei wrote:
> Yes, I thought of that before, but it has the following cons:
>
> - some drivers/devices may need different IRQ affinity policy, such as virtio
> devices which has its own set affinity handler(see virtqueue_set_affinity()),

That's not a very good example to support your cause; virtio_scsi's use
is a perfect example for one that would benefit from letting blk-mq
handle affinity. virtio_scsi sets affinity only when there is a 1:1
mapping of cpu's to queue's, but this driver doesn't know the mapping
that blk-mq used, creating a potentially less than optimal mapping.

> - block core has to get the irq vector information which has to be
> setup/finalized
> before blk-mq uses that for setting irq affinity, for example, in case
> NVMe's admin
> queue, its vector can be changed after admin queue's initialization.

Why do you want to put a hint on the admin queue's irq?
