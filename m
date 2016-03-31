From: jonathan.derrick@intel.com (Jon Derrick)
Date: Thu, 31 Mar 2016 14:19:14 -0600
Subject: [PATCH 2/2] block: add forced polling sysfs controls
In-Reply-To: <1459455554-2794-1-git-send-email-jonathan.derrick@intel.com>
References: <1459455554-2794-1-git-send-email-jonathan.derrick@intel.com>
Message-ID: <1459455554-2794-3-git-send-email-jonathan.derrick@intel.com>

This patch adds io polling force controls to sysfs. Setting this knob
forces direct-io to always poll, even if the io does not specify the
HIPRI flag.

Signed-off-by: Jon Derrick <jonathan.derrick at intel.com>
---
 block/blk-sysfs.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index dd93763..e3af748 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -347,6 +347,37 @@ static ssize_t queue_poll_store(struct request_queue *q, const char *page,
 	return ret;
 }
 
+static ssize_t queue_poll_force_show(struct request_queue *q, char *page)
+{
+	return queue_var_show(test_bit(QUEUE_FLAG_POLL_FORCE, &q->queue_flags),
+			      page);
+}
+
+static ssize_t queue_poll_force_store(struct request_queue *q, const char *page,
+				size_t count)
+{
+	unsigned long poll_force_on;
+	ssize_t ret;
+
+	if (!q->mq_ops || !q->mq_ops->poll ||
+	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
+		return -EINVAL;
+
+	ret = queue_var_store(&poll_force_on, page, count);
+	if (ret < 0)
+		return ret;
+
+	spin_lock_irq(q->queue_lock);
+	if (poll_force_on)
+		queue_flag_set(QUEUE_FLAG_POLL_FORCE, q);
+	else
+		queue_flag_clear(QUEUE_FLAG_POLL_FORCE, q);
+	spin_unlock_irq(q->queue_lock);
+
+	return ret;
+}
+
+
 static struct queue_sysfs_entry queue_requests_entry = {
 	.attr = {.name = "nr_requests", .mode = S_IRUGO | S_IWUSR },
 	.show = queue_requests_show,
@@ -478,6 +509,12 @@ static struct queue_sysfs_entry queue_poll_entry = {
 	.store = queue_poll_store,
 };
 
+static struct queue_sysfs_entry queue_poll_force_entry = {
+	.attr = {.name = "io_poll_force", .mode = S_IRUGO | S_IWUSR },
+	.show = queue_poll_force_show,
+	.store = queue_poll_force_store,
+};
+
 static struct attribute *default_attrs[] = {
 	&queue_requests_entry.attr,
 	&queue_ra_entry.attr,
@@ -503,6 +540,7 @@ static struct attribute *default_attrs[] = {
 	&queue_iostats_entry.attr,
 	&queue_random_entry.attr,
 	&queue_poll_entry.attr,
+	&queue_poll_force_entry.attr,
 	NULL,
 };
 
-- 
2.5.0
