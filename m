From: willy@linux.intel.com (Matthew Wilcox)
Date: Thu, 2 May 2013 16:13:56 -0400
Subject: Tree updated (2013-05-02)
Message-ID: <20130502201356.GD6057@linux.intel.com>


Hi all,

I've integrated a number of patches into the tree at
http://git.infradead.org/users/willy/linux-nvme.git

Relative to my last update, I've added the following patches:

    NVMe: Set TASK_INTERRUPTIBLE before processing queues
    NVMe: queue usage fixes in nvme-scsi
    NVMe: Add scsi unmap to SG_IO
    NVMe: Free admin queue on request_irq error
    NVMe: Fix error clean-up on nvme_alloc_queue
    NVMe: Check for NULL memory in nvme_dev_add
    NVMe: Remove dead code in nvme_dev_add
    NVMe: Split non-mergeable bio requests
    NVMe: Device specific stripe size handling
    NVMe: Meta-data support in NVME_IOCTL_SUBMIT_IO
    NVMe: Schedule timeout for sync commands

These, plus the patches I integrated earlier will be going to Linus for
3.10 some time next week, before the merge window opens.  If I've messed
up the patches somehow, please let me know.

For the sake of having a complete list, here're the other patches that
have been integrated since 3.9:

    NVMe: Add discard support for capable devices
    NVMe: Rename nvme.c to nvme-core.c
    NVMe: Move structures & definitions to header file
    NVMe: Add definitions for format command
    NVMe: Add nvme-scsi.c
    NVMe: Use round_jiffies_relative() for the periodic, once-per-second timer
    NVMe: Abstract out sector to block number conversion
    NVMe: Don't fail initialisation unnecessarily
    NVMe: Fix sparse warnings in scsi emulation
    NVMe: Fix I/O cancellation status on big-endian machines
    NVMe: Fix endian-related problems in user I/O submission path
    NVMe: Add a character device for each nvme device

I'm still looking at the multiple-MSI patch from Rama.  Keith's still
refining the suspend/resume patches.  Other than that, I think the
backlog of patches sent to the mailing list is clear (ie if you sent a
patch and it's not in this list, remind me).
