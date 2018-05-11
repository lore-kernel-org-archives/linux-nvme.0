From: keith.busch@linux.intel.com (Keith Busch)
Date: Fri, 11 May 2018 15:13:52 -0600
Subject: [GIT PULL] nvme fixes for 4.17-rc5
Message-ID: <20180511211352.GD7772@localhost.localdomain>

The following changes since commit 75bc37fefc4471e718ba8e651aa74673d4e0a9eb:

  Linux 4.17-rc4 (2018-05-06 16:57:38 -1000)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-4.17-rc5

for you to fetch changes up to 9abd68ef454c824bfd18629033367b4382b5f390:

  nvme: add quirk to force medium priority for SQ creation (2018-05-11 13:37:14 -0600)

----------------------------------------------------------------
Charles Machalow (1):
      nvme: Fix sync controller reset return

Jens Axboe (1):
      nvme: add quirk to force medium priority for SQ creation

Jianchao Wang (1):
      nvme: fix use-after-free in nvme_free_ns_head

 drivers/nvme/host/core.c |  8 +++++++-
 drivers/nvme/host/nvme.h |  5 +++++
 drivers/nvme/host/pci.c  | 12 +++++++++++-
 3 files changed, 23 insertions(+), 2 deletions(-)
