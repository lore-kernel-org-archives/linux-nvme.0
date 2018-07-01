From: zhangweiping@didichuxing.com (Weiping Zhang)
Date: Sun, 1 Jul 2018 23:20:11 +0800
Subject: [PATCH 0/2] release /dev/nvmeX if nvme_probe failed
Message-ID: <cover.1530457943.git.zhangweiping@didichuxing.com>

First patch only remove whitespace, coding style fixup.
Second patch, remove nvme_ctrl device (/dev/nvmeX) if failed to alloc
memory for iod_mempool in nvme_probe.

Weiping Zhang (2):
  nvme-pci: remove whitespace
  nvme-pci: release nvme_ctrl if failed to alloc memory in nvme_probe

 drivers/nvme/host/pci.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

-- 
2.14.1
