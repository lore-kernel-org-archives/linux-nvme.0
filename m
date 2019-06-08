From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun,  9 Jun 2019 03:02:17 +0900
Subject: [PATCH 1/3] nvme-pci: remove unnecessary zero for static var
In-Reply-To: <20190608180219.17523-1-minwoo.im.dev@gmail.com>
References: <20190608180219.17523-1-minwoo.im.dev@gmail.com>
Message-ID: <20190608180219.17523-2-minwoo.im.dev@gmail.com>

poll_queues will be zero even without zero initialization here.

Cc: Jens Axboe <axboe at fb.com>
Cc: Ming Lei <ming.lei at redhat.com>
Cc: Keith Busch <kbusch at kernel.org>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5c051a8470d4..047785023892 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -80,7 +80,7 @@ MODULE_PARM_DESC(write_queues,
 	"Number of queues to use for writes. If not set, reads and writes "
 	"will share a queue set.");
 
-static int poll_queues = 0;
+static int poll_queues;
 module_param_cb(poll_queues, &queue_count_ops, &poll_queues, 0644);
 MODULE_PARM_DESC(poll_queues, "Number of queues to use for polled IO.");
 
-- 
2.21.0
