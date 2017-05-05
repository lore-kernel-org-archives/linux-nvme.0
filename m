From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Fri,  5 May 2017 16:13:33 -0700
Subject: [PATCH 0/2] nvme_fc: add uevent to allow dynamic connects
Message-ID: <20170505231335.31726-1-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

These patches add support for generating a uevent which can be
caugth and converted to a nvme-cli connect-all request for the
FC initiator and target ports.

James Smart (2):
  nvme_fc: create fc class and transport device
  nvme_fc: add uevent for auto-connect

 drivers/nvme/host/fc.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 79 insertions(+), 4 deletions(-)

-- 
2.11.0
