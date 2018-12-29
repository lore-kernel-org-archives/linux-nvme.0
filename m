From: ming.lei@redhat.com (Ming Lei)
Date: Sat, 29 Dec 2018 11:26:50 +0800
Subject: [PATCH V2 3/3] nvme pci: introduce module parameter of
 'default_queues'
In-Reply-To: <20181229032650.27256-1-ming.lei@redhat.com>
References: <20181229032650.27256-1-ming.lei@redhat.com>
Message-ID: <20181229032650.27256-4-ming.lei@redhat.com>

On big system with lots of CPU cores, it is easy to consume up irq
vectors by assigning defaut queue with num_possible_cpus() irq vectors.
Meantime it is often not necessary to allocate so many vectors for
reaching NVMe's top performance under that situation.

This patch introduces module parameter of 'default_queues' to try
to address this issue reported by Shan Hai.

Reported-by: Shan Hai <shan.hai at oracle.com>
Cc: Shan Hai <shan.hai at oracle.com>
Cc: Keith Busch <keith.busch at intel.com>
Cc: Jens Axboe <axboe at fb.com>
Signed-off-by: Ming Lei <ming.lei at redhat.com>
---
 drivers/nvme/host/pci.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 584ea7a57122..17a261e7f941 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -81,6 +81,12 @@ static const struct kernel_param_ops queue_count_ops = {
 	.get = param_get_int,
 };
 
+static int default_queues;
+module_param_cb(default_queues, &queue_count_ops, &default_queues, 0644);
+MODULE_PARM_DESC(default_queues,
+	"Number of queues to use DEFAULT queue type. If not set, "
+	"num_possible_cpus() will be used.");
+
 static int write_queues;
 module_param_cb(write_queues, &queue_count_ops, &write_queues, 0644);
 MODULE_PARM_DESC(write_queues,
@@ -254,7 +260,9 @@ static inline void _nvme_check_size(void)
 
 static unsigned int max_io_queues(void)
 {
-	return num_possible_cpus() + write_queues + poll_queues;
+	int def_io_queues = default_queues ?: num_possible_cpus();
+
+	return def_io_queues + write_queues + poll_queues;
 }
 
 static unsigned int max_queue_count(void)
-- 
2.9.5
