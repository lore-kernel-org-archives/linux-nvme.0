From: hare@suse.de (Hannes Reinecke)
Date: Tue, 29 May 2018 12:14:21 +0200
Subject: [PATCH 00/10] nvme: ANA fixups
Message-ID: <20180529101431.62271-1-hare@suse.de>

Hi Christoph,

here's a set of patches and updates for the ANA support, both host and target.
It's mainly small issues I've found during testing.
Patches are relative to your nvme-ana branch.

As usual, comments and reviews are welcome.

Hannes Reinecke (10):
  nvme: add missing kfree() in nvme_configure_ana()
  nvme: ANA transition timeout handling
  nvme: Only update capacity for optimized or non-optimized paths
  nvme: clear current path on ANA state change
  nvme: retry nvme_get_log_ext() when processing ANA log
  nvme: simplify check for ANA in nvme_ns_id_attrs_are_visible()
  nvmet: make ANATT configurable
  nvmet: Set nanagrpid correctly
  nvmet: Set mnan correctly
  nvmet: set 'nuse' and 'nsze' to zero for inaccessible paths

 drivers/nvme/host/core.c        | 17 ++++++++++----
 drivers/nvme/host/multipath.c   | 51 +++++++++++++++++++++++++++++------------
 drivers/nvme/host/nvme.h        | 17 +++++++++++++-
 drivers/nvme/target/admin-cmd.c | 43 +++++++++++++++++++++++++++-------
 drivers/nvme/target/configfs.c  | 28 ++++++++++++++++++++++
 drivers/nvme/target/core.c      |  1 +
 drivers/nvme/target/nvmet.h     |  2 ++
 7 files changed, 131 insertions(+), 28 deletions(-)

-- 
2.12.3
