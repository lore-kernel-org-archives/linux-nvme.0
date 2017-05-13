From: jsmart2021@gmail.com (James Smart)
Date: Sat, 13 May 2017 12:05:57 -0700
Subject: [PATCH v2 0/2] nvme_fc: add uevent to allow dynamic connects
Message-ID: <20170513190559.25484-1-jsmart2021@gmail.com>

These patches add support for generating a uevent which can be
caugth and converted to a nvme-cli connect-all request for the
FC initiator and target ports.

The patches were cut on nvme-4.12 after apply the patches contained in
http://lists.infradead.org/pipermail/linux-nvme/2017-May/010156.html

James Smart (2):
  nvme_fc: create fc class and transport device
  nvme_fc: add uevent for auto-connect

 drivers/nvme/host/fc.c         | 102 +++++++++++++++++++++++++++++++++++++++--
 include/linux/nvme-fc-driver.h |   2 +
 2 files changed, 100 insertions(+), 4 deletions(-)

-- 
2.11.0
