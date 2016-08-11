From: james_p_freyensee@linux.intel.com (Jay Freyensee)
Date: Wed, 10 Aug 2016 21:07:15 -0700
Subject: [PATCH RFC 1/4] fabrics: define admin sqsize min default, per spec
In-Reply-To: <1470888438-823-1-git-send-email-james_p_freyensee@linux.intel.com>
References: <1470888438-823-1-git-send-email-james_p_freyensee@linux.intel.com>
Message-ID: <1470888438-823-2-git-send-email-james_p_freyensee@linux.intel.com>

Upon admin queue connect(), the rdma qp was being
set based on NVMF_AQ_DEPTH.  However, the fabrics layer was
using the sqsize field value set for I/O queues for the admin
queue, which through the nvme layer and rdma layer off-whack:

root at fedora23-fabrics-host1 nvmf]# dmesg
[ 3507.798642] nvme_fabrics: nvmf_connect_admin_queue():admin sqsize
being sent is: 128
[ 3507.798858] nvme nvme0: creating 16 I/O queues.
[ 3507.896407] nvme nvme0: new ctrl: NQN "nullside-nqn", addr
192.168.1.3:4420

Thus, to have a different admin queue value (which the fabrics
spec states the minimum depth for a fabrics admin queue is 32 via
the ASQSZ definition), we need also a new variable to hold
the sqsize for admin fabrics queue.  This also allows fabric
implementation layers to set an admin sqsize greater than the
specification-defined minimum, which the fabrics spec allows.

Reported-by: Daniel Verkamp <daniel.verkamp at intel.com>
Signed-off-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
---
 drivers/nvme/host/fabrics.c | 16 +++++++++++++++-
 drivers/nvme/host/nvme.h    |  1 +
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index dc99676..cfc3607 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -363,7 +363,14 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 	cmd.connect.opcode = nvme_fabrics_command;
 	cmd.connect.fctype = nvme_fabrics_type_connect;
 	cmd.connect.qid = 0;
-	cmd.connect.sqsize = cpu_to_le16(ctrl->sqsize);
+
+	/*
+	 * fabrics spec sets a minimum of depth 32 for admin queue, but
+	 * fabric implementation layer may choose to define something deeper.
+	 */
+	cmd.connect.sqsize = (ctrl->admin_sqsize < NVMF_AQ_DEPTH-1) ?
+			     cpu_to_le16(NVMF_AQ_DEPTH-1) :
+			     cpu_to_le16(ctrl->admin_sqsize);
 	/*
 	 * Set keep-alive timeout in seconds granularity (ms * 1000)
 	 * and add a grace period for controller kato enforcement
@@ -833,6 +840,13 @@ static ssize_t nvmf_dev_write(struct file *file, const char __user *ubuf,
 
 	seq_file->private = ctrl;
 
+	/*
+	 * set admin_sqsize a minimum default value
+	 * but allow fabric implementation modules
+	 * to define a larger sqsize, if desired
+	 */
+	ctrl->admin_sqsize = NVMF_AQ_DEPTH-1;
+
 out_unlock:
 	mutex_unlock(&nvmf_dev_mutex);
 	kfree(buf);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ab18b78..32577a7 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -137,6 +137,7 @@ struct nvme_ctrl {
 	struct delayed_work ka_work;
 
 	/* Fabrics only */
+	u16 admin_sqsize;
 	u16 sqsize;
 	u32 ioccsz;
 	u32 iorcsz;
-- 
2.7.4
