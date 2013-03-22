From: willy@linux.intel.com (Matthew Wilcox)
Date: Fri, 22 Mar 2013 16:30:17 -0400
Subject: [GIT PULL] Updates for the NVMe driver
Message-ID: <20130322203017.GE4671@linux.intel.com>


Hi Linus,

These patches have mostly been baking for a few months; sorry I didn't
get them in during the merge window.  They're all bug fixes, except for
the addition of the SMART log and the addition to MAINTAINERS.


The following changes since commit 9924a1992a86ebdb7ca36ef790d2ba0da506296c:

  Merge git://git.kernel.org/pub/scm/virt/kvm/kvm (2012-11-12 17:37:53 -0800)

are available in the git repository at:


  git://git.infradead.org/users/willy/linux-nvme.git master

for you to fetch changes up to 122090366d1d5c6ec1bfb6dfdb3a6d121ff074aa:

  NVMe: Add namespaces with no LBA range feature (2013-03-22 14:50:23 -0400)

----------------------------------------------------------------
Keith Busch (7):
      NVMe: Free cmdid on nvme_submit_bio error
      NVMe: End queued bio requests when freeing queue
      NVMe: Set result from user admin command
      NVMe: Add result to nvme_get_features
      NVMe: Define SMART log
      NVMe: Initialize iod nents to 0
      NVMe: Add namespaces with no LBA range feature

Matthew Wilcox (1):
      MAINTAINERS: Add entry for the NVMe driver

 MAINTAINERS          |    8 ++++++++
 drivers/block/nvme.c |   33 ++++++++++++++++++++++++---------
 include/linux/nvme.h |   28 ++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 9 deletions(-)
