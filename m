From: yi.zhang@redhat.com (Yi Zhang)
Date: Tue, 19 Dec 2017 10:30:16 -0500 (EST)
Subject: [PATCH V2 0/6] blk-mq: fix race related with device
 deletion/reset/switching sched
In-Reply-To: <20171214023103.18272-1-ming.lei@redhat.com>
References: <20171214023103.18272-1-ming.lei@redhat.com>
Message-ID: <1119473730.1189848.1513697416782.JavaMail.zimbra@redhat.com>

Thanks ming.

Tested-by: Yi Zhang <yi.zhang at redhat.com>

Best Regards,
  Yi Zhang


----- Original Message -----
From: "Ming Lei" <ming.lei@redhat.com>
To: linux-nvme at lists.infradead.org, "Christoph Hellwig" <hch at lst.de>, "Jens Axboe" <axboe at fb.com>, linux-block at vger.kernel.org
Cc: "Yi Zhang" <yi.zhang at redhat.com>, "Sagi Grimberg" <sagi at grimberg.me>, "Ming Lei" <ming.lei at redhat.com>, "Keith Busch" <keith.busch at intel.com>, "Johannes Thumshirn" <jthumshirn at suse.de>, "Bart Van Assche" <bart.vanassche at sandisk.com>
Sent: Thursday, December 14, 2017 10:30:57 AM
Subject: [PATCH V2 0/6] blk-mq: fix race related with device deletion/reset/switching sched

Hi,

The 1st patch fixes one kernel oops triggered by IOs vs. deleting SCSI
device, and this issue can be triggered easily on scsi_debug.

The other 5 patch fixes recent Yi Zhang's reports about his NVMe stress
tests, most of them are related with switching io sched, NVMe reset or
updating nr_hw_queues.

V2:
	- address stale queue mapping in blk_mq_update_queue_map(), instead
	of PCI transport, since such issue exists on other transport too,
	as suggested by Christoph
	- avoid to introduce nvme_admin_queue_rq() since the nvme queue can
	be got from hctx->driver_data, which is reliable


Thanks,
Ming

Ming Lei (6):
  blk-mq: quiesce queue before freeing queue
  blk-mq: support concurrent blk_mq_quiesce_queue()
  blk-mq: quiesce queue during switching io sched and updating
    nr_requests
  blk-mq: avoid to map CPU into stale hw queue
  blk-mq: fix race between updating nr_hw_queues and switching io sched
  nvme-pci: remove .init_request callback

 block/blk-core.c         |  9 ++++++
 block/blk-mq.c           | 74 ++++++++++++++++++++++++++++++++++++++++++------
 block/elevator.c         |  2 ++
 drivers/nvme/host/core.c |  4 +--
 drivers/nvme/host/pci.c  | 21 +++-----------
 include/linux/blk-mq.h   |  7 ++++-
 include/linux/blkdev.h   |  2 ++
 7 files changed, 91 insertions(+), 28 deletions(-)

-- 
2.9.5


_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
