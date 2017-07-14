From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 14 Jul 2017 14:53:26 +0200
Subject: [PATCH v3 0/3] Provide a stable serial number
Message-ID: <20170714125329.18430-1-jthumshirn@suse.de>

This pathset is a follow up to
http://lists.infradead.org/pipermail/linux-nvme/2017-July/011934.html.

The 1st patch moves the serial attribute from the contrller to the subsystem,
while the 2nd patch makes it configurable via configfs.

Changes to v2:
* Add attr_ prefix to version (Christoph)
* Re-add random serial comment(Christoph)

Changes to v1:
* Move generation of random serial to nvmet_subsys_alloc() (Christoph)

Johannes Thumshirn (3):
  nvmet: prefix version configfs file with attr
  nvmet: Move serial number from controller to subsystem
  nvmet: preserve controller serial number between reboots

 drivers/nvme/target/admin-cmd.c |  2 +-
 drivers/nvme/target/configfs.c  | 30 ++++++++++++++++++++++++++----
 drivers/nvme/target/core.c      |  7 ++++---
 drivers/nvme/target/nvmet.h     |  2 +-
 4 files changed, 32 insertions(+), 9 deletions(-)

-- 
2.12.3
