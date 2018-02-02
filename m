From: keith.busch@intel.com (Keith Busch)
Date: Fri, 2 Feb 2018 11:24:13 -0700
Subject: [PATCH 2/6] nvme-pci: fix the freeze and quiesce for shutdown
 and reset case
In-Reply-To: <1517554849-7802-3-git-send-email-jianchao.w.wang@oracle.com>
References: <1517554849-7802-1-git-send-email-jianchao.w.wang@oracle.com>
 <1517554849-7802-3-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <20180202182413.GH24417@localhost.localdomain>

On Fri, Feb 02, 2018@03:00:45PM +0800, Jianchao Wang wrote:
> Currently, request queue will be frozen and quiesced for both reset
> and shutdown case. This will trigger ioq requests in RECONNECTING
> state which should be avoided to prepare for following patch.
> Just freeze request queue for shutdown case and drain all the resudual
> entered requests after controller has been shutdown.

Freezing is not just for shutdown. It's also used so
blk_mq_update_nr_hw_queues will work if the queue count changes across
resets.
