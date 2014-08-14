From: keith.busch@intel.com (Keith Busch)
Date: Thu, 14 Aug 2014 12:20:24 -0600 (MDT)
Subject: [PATCH v11] NVMe: Convert to blk-mq
In-Reply-To: <53ECD842.40302@bjorling.me>
References: <1406365643-27020-1-git-send-email-m@bjorling.me>
 <1406365643-27020-2-git-send-email-m@bjorling.me>
 <CAOu_J6mW-2e2Jgm+khodLPah_-RZrD599SmSH+Mszd0AjterrQ@mail.gmail.com>
 <alpine.LRH.2.03.1408131519590.14603@AMR> <53EC7273.5060303@bjorling.me>
 <53ECD125.3080701@fb.com> <53ECD842.40302@bjorling.me>
Message-ID: <alpine.LRH.2.03.1408141209500.14603@AMR>

On Thu, 14 Aug 2014, Matias Bjorling wrote:
>> nr_tags must be uninitialized or screwed up somehow, otherwise I don't
>> see how that kmalloc() could warn on being too large. Keith, are you
>> running with slab debugging? Matias, might be worth trying.

The queue's tags were freed in 'blk_mq_map_swqueue' because some queues
weren't mapped to a s/w queue, but the driver has a pointer to that
freed memory, so it's a use-after-free error.

This part in the driver looks different than it used to be in v8 when I
last tested. The nvme_queue used to have a pointer to the 'hctx', but now
it points directly to the 'tags', but it doesn't appear to be very safe.
