From: nab@linux-iscsi.org (Nicholas A. Bellinger)
Date: Tue, 14 Jun 2016 04:35:36 +0000
Subject: [RFC-v2 01/11] nvme-fabrics: Export nvmf_host_add + generate hostnqn
 if necessary
In-Reply-To: <1465878946-26556-1-git-send-email-nab@linux-iscsi.org>
References: <1465878946-26556-1-git-send-email-nab@linux-iscsi.org>
Message-ID: <1465878946-26556-2-git-send-email-nab@linux-iscsi.org>

From: Nicholas Bellinger <nab@linux-iscsi.org>

This patch allows nvmf_host_add() to be used externally,
and optionally if no hostnqn is passed will generate a
hostnqn based on host->id, following nvmf_host_default().

Note it's required for nvme-loop multi-controller support,
in order to drive nvmet_port creation directly via configfs
attribute write from in ../nvmet/subsystems/$NQN/ports/$PORT/
group context.

Cc: Jens Axboe <axboe at fb.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Keith Busch <keith.busch at intel.com>
Cc: Jay Freyensee <james.p.freyensee at intel.com>
Cc: Martin Petersen <martin.petersen at oracle.com>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Hannes Reinecke <hare at suse.de>
Cc: Mike Christie <michaelc at cs.wisc.edu>
Signed-off-by: Nicholas Bellinger <nab at linux-iscsi.org>
---
 drivers/nvme/host/fabrics.c | 18 +++++++++++++-----
 drivers/nvme/host/fabrics.h |  1 +
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index ee4b7f1..2e0086a 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -41,28 +41,36 @@ static struct nvmf_host *__nvmf_host_find(const char *hostnqn)
 	return NULL;
 }
 
-static struct nvmf_host *nvmf_host_add(const char *hostnqn)
+struct nvmf_host *nvmf_host_add(const char *hostnqn)
 {
 	struct nvmf_host *host;
 
 	mutex_lock(&nvmf_hosts_mutex);
-	host = __nvmf_host_find(hostnqn);
-	if (host)
-		goto out_unlock;
+	if (hostnqn) {
+		host = __nvmf_host_find(hostnqn);
+		if (host)
+			goto out_unlock;
+	}
 
 	host = kmalloc(sizeof(*host), GFP_KERNEL);
 	if (!host)
 		goto out_unlock;
 
 	kref_init(&host->ref);
-	memcpy(host->nqn, hostnqn, NVMF_NQN_SIZE);
 	uuid_le_gen(&host->id);
 
+	if (hostnqn)
+		memcpy(host->nqn, hostnqn, NVMF_NQN_SIZE);
+	else
+		snprintf(host->nqn, NVMF_NQN_SIZE,
+			"nqn.2014-08.org.nvmexpress:NVMf:uuid:%pUl", &host->id);
+
 	list_add_tail(&host->list, &nvmf_hosts);
 out_unlock:
 	mutex_unlock(&nvmf_hosts_mutex);
 	return host;
 }
+EXPORT_SYMBOL_GPL(nvmf_host_add);
 
 static struct nvmf_host *nvmf_host_default(void)
 {
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index b540674..956eab4 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -128,6 +128,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl);
 int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid);
 void nvmf_register_transport(struct nvmf_transport_ops *ops);
 void nvmf_unregister_transport(struct nvmf_transport_ops *ops);
+struct nvmf_host *nvmf_host_add(const char *hostnqn);
 void nvmf_free_options(struct nvmf_ctrl_options *opts);
 const char *nvmf_get_subsysnqn(struct nvme_ctrl *ctrl);
 int nvmf_get_address(struct nvme_ctrl *ctrl, char *buf, int size);
-- 
1.9.1
