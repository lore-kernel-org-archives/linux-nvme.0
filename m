From: hare@suse.de (Hannes Reinecke)
Date: Fri, 17 Aug 2018 09:29:02 +0200
Subject: [PATCH 0/6] nvme-cli fixes and ANA updates
Message-ID: <20180817072908.56784-1-hare@suse.de>

Hi Keith,

here's a small set of fixes and an update to have nvme list-subsys printing
out the ANA state for all paths.
This brings nvme-cli output on par with that from multipath-tools.

As usual, comments and reviews welcome.

Hannes Reinecke (6):
  nvme-ana-log: fixup compiler warning in show_ana_log()
  nvme-vendor: fixup c99 declaration in huawei plugin
  nvme-discover: sanitize options
  nvme-discover: Retry discovery log if the generation counter changes
  nvme-list-subsys: Print PCIe controller address
  nvme-list-subsys: Add device name argument and print out ANA state

 Documentation/nvme-discover.txt    |  13 ++-
 Documentation/nvme-list-subsys.txt |   4 +-
 fabrics.c                          |  15 ++--
 huawei-nvme.c                      |   3 +-
 nvme-print.c                       |  13 ++-
 nvme.c                             | 169 ++++++++++++++++++++++++++++++++++---
 nvme.h                             |   1 +
 7 files changed, 195 insertions(+), 23 deletions(-)

-- 
2.13.7
