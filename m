From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 14 Jul 2017 13:00:02 +0200
Subject: [PATCH 0/2] Provide a stable serial number
Message-ID: <20170714110004.11886-1-jthumshirn@suse.de>

This pathset is a follow up to
http://lists.infradead.org/pipermail/linux-nvme/2017-July/011934.html.

The 1st patch moves the serial attribute from the contrller to the subsystem,
while the 2nd patch makes it configurable via configfs.

Johannes Thumshirn (2):
  nvmet: Move serial number from controller to subsystem
  nvmet: preserve controller serial number between reboots

 drivers/nvme/target/admin-cmd.c |  2 +-
 drivers/nvme/target/configfs.c  | 22 ++++++++++++++++++++++
 drivers/nvme/target/core.c      |  6 ++++--
 drivers/nvme/target/nvmet.h     |  2 +-
 4 files changed, 28 insertions(+), 4 deletions(-)

-- 
2.12.3
