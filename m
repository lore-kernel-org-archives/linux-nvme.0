From: keith.busch@intel.com (Keith Busch)
Date: Mon, 5 Feb 2018 08:13:14 -0700
Subject: [PATCH 2/6] nvme-pci: fix the freeze and quiesce for shutdown
 and reset case
In-Reply-To: <d93d115b-bdb1-24c0-71be-72f1b7563e5a@oracle.com>
References: <1517554849-7802-1-git-send-email-jianchao.w.wang@oracle.com>
 <1517554849-7802-3-git-send-email-jianchao.w.wang@oracle.com>
 <20180202182413.GH24417@localhost.localdomain>
 <d93d115b-bdb1-24c0-71be-72f1b7563e5a@oracle.com>
Message-ID: <20180205151314.GP24417@localhost.localdomain>

On Mon, Feb 05, 2018@10:26:03AM +0800, jianchao.wang wrote:
> > Freezing is not just for shutdown. It's also used so
> > blk_mq_update_nr_hw_queues will work if the queue count changes across
> > resets.
> blk_mq_update_nr_hw_queues will freeze the queue itself. Please refer to.
> static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,

Yes, but how many requests are you letting enter to their demise by
freezing on the wrong side of the reset? We don't use the nuclear option
out of convenience.
