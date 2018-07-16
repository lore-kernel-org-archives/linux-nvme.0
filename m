From: hare@suse.de (Hannes Reinecke)
Date: Mon, 16 Jul 2018 12:58:32 +0200
Subject: [PATCH 0/5] nvme: ANA implementation fixes
Message-ID: <20180716105837.101125-1-hare@suse.de>

Hi Christoph,

here's a set of patches relative to your nvme-ana branch.
Most of these issues have been encountered when running
my blktest test case (to be submitted separately).
With these patches I haven't found any other issues with
the ANA implementation, so we're good to go in principle.

Note, I've submitted another patch ("nvme: register ns_id attributes ...")
which will probably clash with the ANA series and these patches.

But we can fix it up once we've agreed on when and how to
submit the ANA series proper.

As usual, comments and reviews are welcome.

Hannes Reinecke (5):
  nvme: count all ANA groups for ANA Log page
  nvmet: fixup crash on NULL device path
  nvme-multipath: fixup crash during disconnect
  nvme-multipath: disable ANA support if parsing fails
  nvme-multipath: parse entire ANA log page in nvme_set_ns_ana_state()

 drivers/nvme/host/core.c        |  2 +-
 drivers/nvme/host/multipath.c   | 77 ++++++++++++++++++++++++++++-------------
 drivers/nvme/target/admin-cmd.c |  5 +++
 drivers/nvme/target/configfs.c  |  6 ++++
 drivers/nvme/target/core.c      |  6 +++-
 5 files changed, 69 insertions(+), 27 deletions(-)

-- 
2.12.3
