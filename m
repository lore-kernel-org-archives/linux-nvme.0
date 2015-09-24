From: keith.busch@intel.com (Keith Busch)
Date: Thu, 24 Sep 2015 13:51:33 +0000 (UTC)
Subject: [PATCH 2/7] nvme: switch AEN processing to use
 blk_execute_rq_nowait
In-Reply-To: <20150924133850.GA6350@lst.de>
References: <1442860853-26447-1-git-send-email-hch@lst.de>
 <1442860853-26447-3-git-send-email-hch@lst.de>
 <alpine.LNX.2.00.1509232128470.23840@localhost.lm.intel.com>
 <20150924133850.GA6350@lst.de>
Message-ID: <alpine.LNX.2.00.1509241346570.23840@localhost.lm.intel.com>

On Thu, 24 Sep 2015, Christoph Hellwig wrote:
> Unfortunately we really need to keep the struct request around to
> avoid special casing AENs in the completion path.
>
> Yigal, is there a nice easy way to trigger the CPU hotplug migration
> through sysfs or another userspace interface?  I think I can solve
> this without freeing the AEN early with a little more thought.

To take a cpu offline and trigger a removal:

   echo 0 > /sys/devices/system/cpu/cpu1/online
