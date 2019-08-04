From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun,  4 Aug 2019 16:50:46 +0900
Subject: [PATCH 0/4] nvme: add support for Get LBA Status tracing
Message-ID: <20190804075050.14642-1-minwoo.im.dev@gmail.com>

Hi All,

This series introduces command tracing in both host and target side for
the Get LBA Statas admin command which has been added from NVMe 1.4.

Please review.

Thanks,

Minwoo Im (4):
  nvme: add Get LBA Status command opcode
  nvme: trace: support for Get LBA Status opcode parsed
  nvme: trace: parse Get LBA Status command in detail
  nvmet: trace: parse Get LBA Status command in detail

 drivers/nvme/host/trace.c   | 18 ++++++++++++++++++
 drivers/nvme/target/trace.c | 18 ++++++++++++++++++
 include/linux/nvme.h        |  4 +++-
 3 files changed, 39 insertions(+), 1 deletion(-)

-- 
2.17.1
