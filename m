From: hch@lst.de (Christoph Hellwig)
Date: Mon, 18 Apr 2016 22:37:14 +0200
Subject: [PATCH] nvme: fix nvme_ns_remove() deadlock
In-Reply-To: <20160418183214.GC4640@localhost.localdomain>
References: <1461003703-18950-1-git-send-email-mlin@kernel.org>
 <20160418183214.GC4640@localhost.localdomain>
Message-ID: <20160418203714.GA6484@lst.de>

On Mon, Apr 18, 2016@06:32:15PM +0000, Keith Busch wrote:
> This fixes one deadlock by introducing another.
> 
> The reason we don't hold the namespace lock during nvme_ns_remove is
> because del_gendisk blocks until all IO is flushed. If the controller
> fails during this, you'll deadlock nvme_dev_disable as it tries to
> recover. 

Should we switch to RCU freeing the namespace structure?  If we do
that nvme_start_queues, nvme_stop_queues and nvme_kill_queues would
be able to get away with only a RCU read side critical section,
and Mings should be fine on top of that.
