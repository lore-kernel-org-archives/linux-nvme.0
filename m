From: logang@deltatee.com (Logan Gunthorpe)
Date: Wed, 31 Jul 2019 17:35:30 -0600
Subject: [PATCH v3 0/4] Varios NVMe Fixes
Message-ID: <20190731233534.4841-1-logang@deltatee.com>

Hey,

These patches are just a resend of a bunch I've sent that
haven't been picked up yet. I don't want them to get forgotten.

Thanks,

Logan

--

Logan Gunthorpe (4):
  nvmet: Fix use-after-free bug when a port is removed
  nvmet-loop: Flush nvme_delete_wq when removing the port
  nvmet-file: fix nvmet_file_flush() always returning an error
  nvme-core: Fix extra device_put() call on error path

 drivers/nvme/host/core.c       |  2 +-
 drivers/nvme/target/configfs.c |  1 +
 drivers/nvme/target/core.c     | 15 +++++++++++++++
 drivers/nvme/target/loop.c     |  8 ++++++++
 drivers/nvme/target/nvmet.h    |  3 +++
 5 files changed, 28 insertions(+), 1 deletion(-)

--
2.20.1
