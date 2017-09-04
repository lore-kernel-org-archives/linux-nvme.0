From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Tue,  5 Sep 2017 00:23:28 +0900
Subject: [PATCH 0/2] nvme-pci: fix rety handling of host memory buffer
 allocation
Message-ID: <1504538610-15670-1-git-send-email-akinobu.mita@gmail.com>

I found a problem in rety handling of host memory buffer allocation when
using v4.13 kernel with Toshiba NVMe device which supports HMB.

Akinobu Mita (2):
  nvme-pci: avoid arrary index out of bounds in retry HMB allocation
  nvme-pci: use appropriate initial chunk size for HMB allocation

 drivers/nvme/host/pci.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

Cc: Keith Busch <keith.busch at intel.com>
Cc: Jens Axboe <axboe at fb.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
-- 
2.7.4
