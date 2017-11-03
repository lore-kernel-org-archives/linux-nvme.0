From: jg@lightnvm.io (=?UTF-8?q?Javier=20Gonz=C3=A1lez?=)
Date: Fri,  3 Nov 2017 11:02:47 +0100
Subject: [PATCH 0/3] nvme: small fixes reported by smatch
Message-ID: <1509703370-20379-1-git-send-email-javier@cnexlabs.com>

Fix a number of small things reported by smatch on the nvme driver

Javier Gonz?lez (3):
  nvme: do not check for ns on rw path
  nvme: compare NQN string with right size
  nvme: fix eui_show() print format

 drivers/nvme/host/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.7.4
