From: m@bjorling.me (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Thu, 11 Feb 2016 12:36:28 +0100
Subject: nvme: lightnvm: return ppa completion status
Message-ID: <1455190589-20016-1-git-send-email-m@bjorling.me>

For LightNVM, the PPA completion status is communicated through DW0 and
DW1 of the completion queue entry. The patch is based on top of
Christoph's

 "nvme: return the whole CQE through the request passthrough interface"

that exposes the full CQE during completion.

Matias Bj?rling (1):
  nvme: lightnvm: return ppa completion status

 drivers/nvme/host/lightnvm.c | 17 +++++++++++++++--
 include/linux/lightnvm.h     |  1 +
 2 files changed, 16 insertions(+), 2 deletions(-)

-- 
2.1.4
