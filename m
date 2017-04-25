From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Tue, 25 Apr 2017 15:31:45 -0700
Subject: [PATCH 0/2] nvme_fc: add support for new ctrl_loss_tmo
Message-ID: <20170425223147.3784-1-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

This patch adds support for the new ctrl_loss_tmo option.

It also addresses the MAX_RECONNECTS comment in Sagi's review.
http://lists.infradead.org/pipermail/linux-nvme/2017-April/009261.html

James Smart (2):
  nvme_fc: get rid of local reconnect_delay
  nvme_fc: Support ctrl_loss_tmo

 drivers/nvme/host/fc.c | 118 ++++++++++++++++++++-----------------------------
 1 file changed, 49 insertions(+), 69 deletions(-)

-- 
2.9.3
