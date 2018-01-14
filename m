From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun, 14 Jan 2018 20:40:17 +0900
Subject: [PATCH 0/2] clean-up HMB code
Message-ID: <1515930017-20501-1-git-send-email-minwoo.im.dev@gmail.com>

Hi all,

This patch set cleans unnecessary initialization and magic numbers.

Thanks,

Minwoo Im (2):
  nvme: pci: replace magic number with readable size macro in hmb code
  nvme: pci: remove unnecessary initialization of local variable

 drivers/nvme/host/pci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.7.4
