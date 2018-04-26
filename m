From: ming.lei@redhat.com (Ming Lei)
Date: Thu, 26 Apr 2018 20:39:54 +0800
Subject: [PATCH 0/2] nvme: pci: fix & improve timeout handling
Message-ID: <20180426123956.26039-1-ming.lei@redhat.com>

Hi,

This first patch introduces EH kthread for handling timeout, and
simplifies the logics a lot, and fixes reports on block/011.

The 2nd one fixes the issue reported by Jianchao, in which admin
req may time out in EH.


Ming Lei (2):
  nvme: pci: simplify timeout handling
  nvme: pci: guarantee EH can make progress

 drivers/nvme/host/core.c |  11 ++++
 drivers/nvme/host/nvme.h |   1 +
 drivers/nvme/host/pci.c  | 161 ++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 158 insertions(+), 15 deletions(-)

Cc: Jianchao Wang <jianchao.w.wang at oracle.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: linux-nvme at lists.infradead.org


-- 
2.9.5
