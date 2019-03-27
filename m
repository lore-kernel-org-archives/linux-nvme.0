From: hare@suse.de (Hannes Reinecke)
Date: Wed, 27 Mar 2019 09:09:26 +0100
Subject: [PATCH 0/3] nvme: fixup race with namespace removal
Message-ID: <20190327080929.27918-1-hare@suse.de>

Hi all,

nvme namespace scanning might race with controller reset, causing the
system to crash in myriad ways if nvme_scan_ns_list() decides to remove
a namespace while resetting is active on another thread.
The main problem here is that namespace removal is not atomic.
The namespace mutex needs to be dropped before calling nvme_ns_remove(),
so if nvme_ns_remove() is called while traversing the list of namespaces
there always will be a race condition.

This patchset tries to fix this problem by shortening the race window
and check for valid namespaces in nvme_start_queue()/nvme_stop_queue().

As usual, comments and reviews are welcome.

Hannes Reinecke (3):
  nvme: do not quiesce or unquiesce invalid namespaces
  nvme: shorten race window in nvme_ns_remove()
  nvme-multipath: test namespace state when selecting a new path

 drivers/nvme/host/core.c      | 18 ++++++++++++------
 drivers/nvme/host/multipath.c |  6 ++++--
 2 files changed, 16 insertions(+), 8 deletions(-)

-- 
2.16.4
