From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Sun, 23 Apr 2017 08:30:05 -0700
Subject: [PATCH 0/3] nvme_fc: changes for controller reset support
Message-ID: <20170423153008.22795-1-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

Here are the 3 remaining patches for nvme_fc that were part of the
prior patch sets but were not merged into nvme-412.

Patches were cut from nvme-4.12 and apply cleanly to there and
the for-4.12/block tree.

James Smart (3):
  nvme_fc: fix command id check
  nvme_fc: add aen abort to teardown
  nvme_fc: add controller reset support

 drivers/nvme/host/fc.c | 1165 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 777 insertions(+), 388 deletions(-)

-- 
2.9.3
