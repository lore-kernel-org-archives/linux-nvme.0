From: hare@suse.de (Hannes Reinecke)
Date: Thu, 15 Nov 2018 13:29:25 +0100
Subject: [PATCH 0/2] nvme-multipath: round-robin I/O policy
Message-ID: <20181115122927.40431-1-hare@suse.de>

Hi all,

after my NUMA path balancing patch hasn't met with universal approval,
here's now my take on a 'real' round-robin I/O scheduler for NVMe multipathing.
With this patch I'm able to boost I/O performance from 127k/127k randrw
to 156k/156k randrw (as measured by fio).
Testbed was two dual 32G FC HBAs connected back-to-back with nvmet
against a 1G zram-backed namespace.

As usual, comments and reviews are welcome.

Hannes Reinecke (2):
  nvme-multipath: add 'iopolicy' subsystem attribute
  nvme-multipath: round-robin I/O policy

 drivers/nvme/host/core.c      |  6 +++
 drivers/nvme/host/multipath.c | 88 ++++++++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h      |  8 ++++
 3 files changed, 101 insertions(+), 1 deletion(-)

-- 
2.16.4
