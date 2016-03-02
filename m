From: hch@lst.de (Christoph Hellwig)
Date: Wed,  2 Mar 2016 18:07:09 +0100
Subject: [for 4.5] fix regression for large NVMe user command
Message-ID: <1456938434-20387-1-git-send-email-hch@lst.de>

Hi Jens, hi Keith,

Jeff reported and issue to me where my change of the NVMe userspace
passthrough ioctls to the generic block code caused a regression for a
firmward dump tool that uses 1MB+ vendor specific userspace command
to dump a large buffer.

While (re)implementing support for multiple bios in blk_rq_map_user
I also ran into lots of existing NVMe bugs that limit I/O size either
in general or specific to some workloads:

 (1) we never set BLK_MQ_F_SHOULD_MERGE for admin commands.  This doesn't
     really affect us here, but we should be consistant with the I/O queue.
 (2) we never set any queue limits for the admin queue, just leaving
     the defaults in place.  Besides causing low I/O limits this also means
     that flags like the virt boundary weren't set and we might pass on
     incorrectly formed SGLs to the driver for admin passthrough.
 (3) because the max_segments field in the queue limits structure is an
     unsigned short we get an integer truncation that would cause all
     NVMe controller that don't set a low MDTS value to actually just get
     a single segment per request.
 (4) last but not least we were applying the low FS request limits to all
     driver private request types, which doesn't make sense.
