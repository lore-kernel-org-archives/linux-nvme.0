From: keith.busch@linux.intel.com (Keith Busch)
Date: Thu, 3 May 2018 09:29:48 -0600
Subject: [GIT PULL] nvme fixes for 4.17
Message-ID: <20180503152948.GM5938@localhost.localdomain>

The following changes since commit bf0ddaba65ddbb2715af97041da8e7a45b2d8628:

  blk-mq: fix sysfs inflight counter (2018-04-26 09:02:01 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-4.17-rc3

for you to fetch changes up to eb395977b73dce7af0eaa29412b3f6e13b87811d:

  nvmet: switch loopback target state to connecting when resetting (2018-05-03 08:11:38 -0600)

----------------------------------------------------------------
Chengguang Xu (1):
      nvme: fix potential memory leak in option parsing

Johannes Thumshirn (1):
      nvmet: switch loopback target state to connecting when resetting

Keith Busch (3):
      nvme: Set integrity flag for user passthrough commands
      nvme/multipath: Disable runtime writable enabling parameter
      nvme/multipath: Fix multipath disabled naming collisions

 drivers/nvme/host/core.c      | 27 ++-------------------------
 drivers/nvme/host/fabrics.c   |  6 ++++++
 drivers/nvme/host/multipath.c | 24 +++++++++++++++++++++++-
 drivers/nvme/host/nvme.h      | 12 ++++++++++++
 drivers/nvme/target/loop.c    |  6 ++++++
 5 files changed, 49 insertions(+), 26 deletions(-)
