From: keith.busch@intel.com (Keith Busch)
Date: Thu, 18 May 2017 10:13:07 -0400
Subject: [PATCH 1/2] nvme: fix race between removing and reseting failure
In-Reply-To: <20170517012729.13469-2-ming.lei@redhat.com>
References: <20170517012729.13469-1-ming.lei@redhat.com>
 <20170517012729.13469-2-ming.lei@redhat.com>
Message-ID: <20170518141307.GD28520@localhost.localdomain>

On Wed, May 17, 2017@09:27:28AM +0800, Ming Lei wrote:
> When one NVMe PCI device is being resetted and found reset failue,
> nvme_remove_dead_ctrl() is called to handle the failure: blk-mq hw queues
> are put into stopped first, then schedule .remove_work to release the driver.
> 
> Unfortunately if the driver is being released via sysfs store
> just before the .remove_work is run, del_gendisk() from
> nvme_remove() may hang forever because hw queues are stopped and
> the submitted writeback IOs from fsync_bdev() can't be completed at all.
> 
> This patch fixes the following issue[1][2] by moving nvme_kill_queues()
> into nvme_remove_dead_ctrl() to avoid the issue because nvme_remove()
> flushs .reset_work, and this way is reasonable and safe because
> nvme_dev_disable() has started to suspend queues and canceled requests
> already.

I'm still not sure moving where we kill the queues is the correct way
to fix this problem. The nvme_kill_queues restarts all the hardware
queues to force all IO to failure already, so why is this really stuck?
We should be able to make forward progress even if we kill the queues
while calling into del_gendisk, right? That could happen with a different
sequence of events, so that also needs to work.
