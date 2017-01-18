From: luto@kernel.org (Andy Lutomirski)
Date: Tue, 17 Jan 2017 17:54:17 -0800
Subject: [PATCH 0/3] nvme: APST support
Message-ID: <cover.1484703713.git.luto@kernel.org>

As far as I can tell, APST works fine on every NVMe device I'm aware
of with the single exception of a particular Samsung device.  This
series enables APST by default but quirks it off on the offending
Samsung device.  Some Samsung engineers are taking a look, and,
depending on what they find, we may be able to change the quirk to
work around the bug rather than disabling APST outright.

I think it would be nice to queue this up and give it a soak in
linux-next.

I restarted the numbering since I lost track of what version I was
on.  This version has roughly these changes from before:

 - Rebased to linux-block/for-next.
 - I added a quirk for the known-bad Samsung device.
 - It's fully integrated with dev_pm_qos.
 - I now program APST after all the queues are set up, which seems safer.
   (This didn't fix the Samsung problem, though.)

Andy Lutomirski (3):
  nvme: Enable autonomous power state transitions
  nvme: Add a quirk mechanism that uses identify_ctrl
  nvme: Add a quirk to disable APST on a buggy Samsung device

 drivers/nvme/host/core.c | 204 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  13 +++
 drivers/nvme/host/pci.c  |   2 +
 drivers/nvme/host/rdma.c |   2 +
 include/linux/nvme.h     |   6 ++
 5 files changed, 227 insertions(+)

-- 
2.9.3
