From: willy@linux.intel.com (Matthew Wilcox)
Date: Wed, 11 Jan 2012 09:50:02 -0500
Subject: Version 0.8 uploaded
Message-ID: <20120111145002.GY14291@linux.intel.com>


I've just pushed out version 0.8 of the driver.  Here's the shortlog:

Matthew Wilcox (13):
      NVMe: Implement doorbell stride capability
      NVMe: Update Identify Controller data structure
      NVMe: Simplify completion handling
      NVMe: Change get_nvmeq to take a dev instead of a namespace
      NVMe: Change nvme_completion_fn to take a dev
      NVMe: Merge the nvme_bio and nvme_prp data structures
      NVMe: Rename IO_TIMEOUT to NVME_IO_TIMEOUT
      NVMe: Fix DMA mapping for admin commands
      NVMe: Mark the end of the sg list
      NVMe: Simplify nvme_unmap_user_pages
      NVMe: Set queue flags correctly
      NVMe: Version 0.8
      NVMe: Set number of queues correctly

Mostly bugfixes, but the big change is merging the nvme_bio and nvme_prp
data structures.  I've been made aware that certain applications mostly
send I/Os larger than a single page; in particular MySQL uses 16k I/Os.
That was probably the pessimal size for the NVMe driver; just large
enough to cause it to allocate an nvme_prp data structure and small
enough that per-I/O overhead is still meaningful.

So I merged the nvme_bio and nvme_prp data structures into the new
nvme_iod data structure.  This was a bit of a challenge since it needs
to contain two variable-length arrays, which C does not permit you to
express neatly.  I hope the comments around the data structure make it
clear what I'm doing.  I saw noticable reductions in per-I/O CPU overhead
with the new scheme, so I think it's worthwhile.  Also, the additional
overhead for 512-byte I/Os was down in the noise and it was completely
unmeasurable for 4k I/Os.

I plan to ask Linus to merge this version of the driver for Linux 3.3.
I know there's still a lot on the TODO list, but we'll have a chance to
merge more patches in April.  I have a couple of patches from Keith Busch
still to review (adding a character device to represent the controller
and the beginnings of an error handler), but I'd rather get what we have
merged now than wait for the next merge window.
