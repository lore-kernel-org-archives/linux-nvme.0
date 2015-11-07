From: hch@lst.de (Christoph Hellwig)
Date: Sat,  7 Nov 2015 09:44:54 +0100
Subject: nvme completion path optimizations and fixes V3
Message-ID: <1446885906-20967-1-git-send-email-hch@lst.de>

This series optimized the NVMe completion path by taking full advantage
to the block layer multiple completion protection.  For that we'll need
to switch the remaining internal NVMe admin commands over to use the
block layer queuing.

But to do that we first have to special case the magic AEN requests.  This
only ends up being a single unlikely branch in the completion path, so
I think we're way better off than before.

The other important change is that block layer timeouts now call the driver
from workqueue context, which will make life much easier not just for NVMe,
but also for SCSI.  The way we use the workqueue API for this isn't quite
optimal, but I've Cced Tejun in case he can help out there.


Changes since V2:
 - not too much left from the original version except for the high level
   concept

Changes since V1:
 - various hotplug CPU fixes, including a patch from Akinobu Mita
