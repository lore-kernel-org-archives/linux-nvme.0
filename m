From: willy@linux.intel.com (Matthew Wilcox)
Date: Tue, 11 Jun 2013 17:04:14 -0400
Subject: [PULL REQUEST] NVMe driver fixes
Message-ID: <20130611210414.GN8211@linux.intel.com>


Hi Linus,

The following bugfixes have been accumulating for the last few weeks, and
it would be nice if they could be in 3.10.

The following changes since commit ec50f2a97a4a7098a81b40030e0bfe28bdc43740:

  Merge branch 'drm-next' of git://people.freedesktop.org/~airlied/linux (2013-05-16 19:01:46 -0700)

are available in the git repository at:


  git://git.infradead.org/users/willy/linux-nvme.git fixes-3.10

for you to fetch changes up to fa08a396647767abd24a9e7015cb177121d0cf15:

  NVMe: Add MSI support (2013-05-31 11:45:52 -0400)

----------------------------------------------------------------
Chayan Biswas (1):
      Return the result from user admin command IOCTL even in case of failure

Dan Carpenter (2):
      MAINTAINERS: update NVM EXPRESS DRIVER file list
      NVMe: check for integer overflow in nvme_map_user_pages()

Keith Busch (1):
      NVMe: Do not cancel command multiple times

Matthew Wilcox (1):
      NVMe: Use dma_set_mask() correctly

Ramachandra Rao Gajula (1):
      NVMe: Add MSI support

Sachin Kamat (1):
      NVMe: Remove redundant version.h header include

Vishal Verma (1):
      NVMe: Fix a signedness bug in nvme_trans_modesel_get_mp

Wei Yongjun (1):
      NVMe: fix error return code in nvme_submit_bio_queue()

 MAINTAINERS               |    2 +-
 drivers/block/nvme-core.c |   62 +++++++++++++++++++++++++++++++++++----------
 drivers/block/nvme-scsi.c |    3 +--
 3 files changed, 50 insertions(+), 17 deletions(-)
