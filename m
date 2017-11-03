From: jsmart2021@gmail.com (James Smart)
Date: Fri,  3 Nov 2017 08:13:15 -0700
Subject: [REPOST PATCH 0/2] nvme_fc: fix unregistrations and stale resume
Message-ID: <20171103151317.16431-1-jsmart2021@gmail.com>

These patches fix some errors in the nvme_fc_register_localport resume
as well as reworking remoteport and localport unregister behavior relative
to their callbacks to the lldd.

patches cut against nvme-4.15

James Smart (2):
  nvme_fc: fix localport resume using stale values
  nvme_fc: decouple ns references from lldd references

 drivers/nvme/host/fc.c | 96 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 88 insertions(+), 8 deletions(-)

-- 
2.13.1
