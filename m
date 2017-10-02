From: hare@suse.de (Hannes Reinecke)
Date: Mon,  2 Oct 2017 15:55:53 +0200
Subject: [PATCH 0/6] nvme: sanitize multipathing
Message-ID: <1506952559-1588-1-git-send-email-hare@suse.de>

Hi Christoph,

here's a patchset to sanitize nvme multipath handling, following
the discusion we've had at ALPSS.
Here I've settled for the '/dev/nvmsXnZ' device nodes (which you
said I could do :-), and added the necessary bits and piece to
get it registered nicely with sysfs.
We've also found an issue when retrying I/O after path failures;
we probably should be checking if this is multipath I/O before
deciding on retry or not.

Patches are relative to your nvme-mpath branch.

As usual, comments and reviews are welcome.

Hannes Reinecke (5):
  nvme: display 'CMIC' controller attribute
  nvme: use 'nvmsXnZ' instead of 'nvm-subXnZ'
  nvme: claim block devices
  nvme: Export subsystems to /sys/class/nvme-subsys
  nvme: ignore retries for multipath devices

Johannes Thumshirn (1):
  nvme: display 'NMIC' namespace attribute

 drivers/nvme/host/core.c | 99 +++++++++++++++++++++++++++++++++++++-----------
 drivers/nvme/host/nvme.h |  5 ++-
 2 files changed, 80 insertions(+), 24 deletions(-)

-- 
1.8.5.6
