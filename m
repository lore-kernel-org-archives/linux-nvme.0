From: jsmart2021@gmail.com (James Smart)
Date: Thu, 14 Sep 2017 10:38:40 -0700
Subject: [PATCH v3 0/3] nvme_fc: add uevent to allow dynamic connects
Message-ID: <20170914173843.3195-1-jsmart2021@gmail.com>

These patches add support for generating a uevent which can be
caught and converted to a nvme-cli connect-all request for the
FC initiator and target ports.

Also contains a patch to catch connection attempts that duplicate
already-in-existence associations.

Cut on nvme-4.14

James Smart (3):
  nvme_fc: create fc class and transport device
  nvme_fc: add uevent for auto-connect
  nvme_fc: Avoid duplicate associations between same port pairs

 drivers/nvme/host/fc.c         | 132 ++++++++++++++++++++++++++++++++++++++++-
 include/linux/nvme-fc-driver.h |   2 +
 2 files changed, 133 insertions(+), 1 deletion(-)

-- 
2.13.1
