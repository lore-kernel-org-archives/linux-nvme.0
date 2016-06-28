From: daniel.verkamp@intel.com (Daniel Verkamp)
Date: Tue, 28 Jun 2016 11:20:23 -0700
Subject: [PATCH] nvme-fabrics: change NQN UUID to big-endian format
In-Reply-To: <20160628084547.GA31465@infradead.org>
References: <20160628084547.GA31465@infradead.org>
Message-ID: <1467138023-41671-1-git-send-email-daniel.verkamp@intel.com>

NVM Express 1.2.1 section 7.9, NVMe Qualified Names, specifies that the
UUID format of NQN uses a UUID based on RFC 4122.

RFC 4122 specifies that the UUID is encoded in big-endian byte order.

Switch the NVMe over Fabrics host ID field from little-endian UUID to
big-endian UUID to match the specification.

Signed-off-by: Daniel Verkamp <daniel.verkamp at intel.com>
---
 drivers/nvme/host/fabrics.c | 10 +++++-----
 drivers/nvme/host/fabrics.h |  2 +-
 include/linux/nvme.h        |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index b86b637..918310c 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -56,7 +56,7 @@ static struct nvmf_host *nvmf_host_add(const char *hostnqn)
 
 	kref_init(&host->ref);
 	memcpy(host->nqn, hostnqn, NVMF_NQN_SIZE);
-	uuid_le_gen(&host->id);
+	uuid_be_gen(&host->id);
 
 	list_add_tail(&host->list, &nvmf_hosts);
 out_unlock:
@@ -73,9 +73,9 @@ static struct nvmf_host *nvmf_host_default(void)
 		return NULL;
 
 	kref_init(&host->ref);
-	uuid_le_gen(&host->id);
+	uuid_be_gen(&host->id);
 	snprintf(host->nqn, NVMF_NQN_SIZE,
-		"nqn.2014-08.org.nvmexpress:NVMf:uuid:%pUl", &host->id);
+		"nqn.2014-08.org.nvmexpress:NVMf:uuid:%pUb", &host->id);
 
 	mutex_lock(&nvmf_hosts_mutex);
 	list_add_tail(&host->list, &nvmf_hosts);
@@ -371,7 +371,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 	if (!data)
 		return -ENOMEM;
 
-	memcpy(&data->hostid, &ctrl->opts->host->id, sizeof(uuid_le));
+	memcpy(&data->hostid, &ctrl->opts->host->id, sizeof(uuid_be));
 	data->cntlid = cpu_to_le16(0xffff);
 	strncpy(data->subsysnqn, ctrl->opts->subsysnqn, NVMF_NQN_SIZE);
 	strncpy(data->hostnqn, ctrl->opts->host->nqn, NVMF_NQN_SIZE);
@@ -430,7 +430,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 	if (!data)
 		return -ENOMEM;
 
-	memcpy(&data->hostid, &ctrl->opts->host->id, sizeof(uuid_le));
+	memcpy(&data->hostid, &ctrl->opts->host->id, sizeof(uuid_be));
 	data->cntlid = cpu_to_le16(ctrl->cntlid);
 	strncpy(data->subsysnqn, ctrl->opts->subsysnqn, NVMF_NQN_SIZE);
 	strncpy(data->hostnqn, ctrl->opts->host->nqn, NVMF_NQN_SIZE);
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index b540674..9d31466 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -34,7 +34,7 @@ struct nvmf_host {
 	struct kref		ref;
 	struct list_head	list;
 	char			nqn[NVMF_NQN_SIZE];
-	uuid_le			id;
+	uuid_be			id;
 };
 
 /**
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index d8b37ba..7676557 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -794,7 +794,7 @@ struct nvmf_connect_command {
 };
 
 struct nvmf_connect_data {
-	uuid_le		hostid;
+	uuid_be		hostid;
 	__le16		cntlid;
 	char		resv4[238];
 	char		subsysnqn[NVMF_NQN_FIELD_LEN];
-- 
2.7.4
