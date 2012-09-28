From: willy@linux.intel.com (Matthew Wilcox)
Date: Fri, 28 Sep 2012 12:55:11 -0400
Subject: [GIT PULL] Fixes for the NVMe driver
Message-ID: <20120928165511.GB4244@linux.intel.com>


Hi Linus,

Now that actual hardware has been released (don't have any yet myself),
people are starting to want some of these fixes merged.  Could I trouble
you to pull?


The following changes since commit df3481399042200792822b6243e36a95a557b57e:

  NVMe: Set number of queues correctly (2012-01-11 09:22:24 -0500)

are available in the git repository at:

  git://git.infradead.org/users/willy/linux-nvme.git master

for you to fetch changes up to a09115b23e2002bb35b7bfd337683f00875671ec:

  NVMe: Cancel outstanding IOs on queue deletion (2012-08-07 15:56:23 -0400)

----------------------------------------------------------------
Dan Carpenter (1):
      NVMe: handle allocation failure in nvme_map_user_pages()

Keith Busch (7):
      NVMe: Set request queue logical block size
      NVMe: Fix nvme module init when nvme_major is set
      NVMe: replace nvme_ns with nvme_dev for user admin
      NVMe: use namespace id for nvme_get_features
      NVMe: Set block queue max sectors
      NVMe: Do not set IO queue depth beyond device max
      NVMe: Fix uninitialized iod compiler warning

Matthew Wilcox (3):
      NVMe: Fix whitespace damage in nvme_init
      NVMe: Free admin queue memory on initialisation failure
      NVMe: Cancel outstanding IOs on queue deletion

Quoc-Son Anh (1):
      NVMe: Use ida for nvme device instance

 drivers/block/nvme.c |  153 +++++++++++++++++++++++++++++++++-----------------
 include/linux/nvme.h |    2 +
 2 files changed, 105 insertions(+), 50 deletions(-)
