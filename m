From: keith.busch@intel.com (Keith Busch)
Date: Mon,  8 Apr 2019 13:46:52 -0600
Subject: [PATCHv2] nvmet: Fix discover log page when offsets are used
Message-ID: <20190408194652.641-1-keith.busch@intel.com>

The nvme target hadn't been taking the Get Log Page offset parameter
into consideration, and so has been returning corrupted logs pages when
offsets are used. Since many tools, including nvme-cli, split the log
request to 4k, we've been breaking discovery log responses when more
than 3 subsystems exist.

Fix the log page by internally generating the entire discovery log page
and copying only the requested bytes into the user buffer.

Cc: Hannes Reinecke <hare at suse.de>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
v1 -> v2:

  Fixed releasing nvmet_config_sem read lock

  Fixed commit log spelling error

  Return invalid field if offset is not dword aligned. This is spec
  optional, but it's either check these bits or mask them off. I just
  chose the former.

 drivers/nvme/target/admin-cmd.c | 10 ++++++
 drivers/nvme/target/discovery.c | 68 ++++++++++++++++++++++++++---------------
 drivers/nvme/target/nvmet.h     |  1 +
 3 files changed, 55 insertions(+), 24 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 76250181fee0..e7f3f6e71853 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -24,6 +24,16 @@ u32 nvmet_get_log_page_len(struct nvme_command *cmd)
 	return len;
 }
 
+u64 nvmet_get_log_page_offset(struct nvme_command *cmd)
+{
+	u64 offset = le32_to_cpu(cmd->get_log_page.lpou);
+
+	offset <<= 32;
+	offset += le32_to_cpu(cmd->get_log_page.lpol);
+
+	return offset;
+}
+
 static void nvmet_execute_get_log_page_noop(struct nvmet_req *req)
 {
 	nvmet_req_complete(req, nvmet_zero_sgl(req, 0, req->data_len));
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index c872b47a88f3..0f1f32aa279b 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -131,54 +131,75 @@ static void nvmet_set_disc_traddr(struct nvmet_req *req, struct nvmet_port *port
 		memcpy(traddr, port->disc_addr.traddr, NVMF_TRADDR_SIZE);
 }
 
+static size_t discovery_log_entries(struct nvmet_req *req)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	struct nvmet_subsys_link *p;
+	struct nvmet_port *r;
+	u32 entries = 0;
+
+	list_for_each_entry(p, &req->port->subsystems, entry) {
+		if (!nvmet_host_allowed(p->subsys, ctrl->hostnqn))
+			continue;
+		entries++;
+	}
+	list_for_each_entry(r, &req->port->referrals, entry)
+		entries++;
+	return entries;
+}
+
 static void nvmet_execute_get_disc_log_page(struct nvmet_req *req)
 {
 	const int entry_size = sizeof(struct nvmf_disc_rsp_page_entry);
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvmf_disc_rsp_page_hdr *hdr;
+	u64 offset = nvmet_get_log_page_offset(req->cmd);
 	size_t data_len = nvmet_get_log_page_len(req->cmd);
-	size_t alloc_len = max(data_len, sizeof(*hdr));
-	int residual_len = data_len - sizeof(*hdr);
+	size_t alloc_len;
 	struct nvmet_subsys_link *p;
 	struct nvmet_port *r;
 	u32 numrec = 0;
 	u16 status = 0;
+	void *buffer;
+
+	if (offset & 0x3) {
+		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		goto out;
+	}
 
 	/*
 	 * Make sure we're passing at least a buffer of response header size.
 	 * If host provided data len is less than the header size, only the
 	 * number of bytes requested by host will be sent to host.
 	 */
-	hdr = kzalloc(alloc_len, GFP_KERNEL);
-	if (!hdr) {
+	down_read(&nvmet_config_sem);
+	alloc_len = sizeof(*hdr) + entry_size * discovery_log_entries(req);
+	buffer = kzalloc(alloc_len, GFP_KERNEL);
+	if (!buffer) {
+		up_read(&nvmet_config_sem);
 		status = NVME_SC_INTERNAL;
 		goto out;
 	}
 
-	down_read(&nvmet_config_sem);
+	hdr = buffer;
 	list_for_each_entry(p, &req->port->subsystems, entry) {
+		char traddr[NVMF_TRADDR_SIZE];
+
 		if (!nvmet_host_allowed(p->subsys, ctrl->hostnqn))
 			continue;
-		if (residual_len >= entry_size) {
-			char traddr[NVMF_TRADDR_SIZE];
-
-			nvmet_set_disc_traddr(req, req->port, traddr);
-			nvmet_format_discovery_entry(hdr, req->port,
-					p->subsys->subsysnqn, traddr,
-					NVME_NQN_NVME, numrec);
-			residual_len -= entry_size;
-		}
+
+		nvmet_set_disc_traddr(req, req->port, traddr);
+		nvmet_format_discovery_entry(hdr, req->port,
+				p->subsys->subsysnqn, traddr,
+				NVME_NQN_NVME, numrec);
 		numrec++;
 	}
 
 	list_for_each_entry(r, &req->port->referrals, entry) {
-		if (residual_len >= entry_size) {
-			nvmet_format_discovery_entry(hdr, r,
-					NVME_DISC_SUBSYS_NAME,
-					r->disc_addr.traddr,
-					NVME_NQN_DISC, numrec);
-			residual_len -= entry_size;
-		}
+		nvmet_format_discovery_entry(hdr, r,
+				NVME_DISC_SUBSYS_NAME,
+				r->disc_addr.traddr,
+				NVME_NQN_DISC, numrec);
 		numrec++;
 	}
 
@@ -187,11 +208,10 @@ static void nvmet_execute_get_disc_log_page(struct nvmet_req *req)
 	hdr->recfmt = cpu_to_le16(0);
 
 	nvmet_clear_aen_bit(req, NVME_AEN_BIT_DISC_CHANGE);
-
 	up_read(&nvmet_config_sem);
 
-	status = nvmet_copy_to_sgl(req, 0, hdr, data_len);
-	kfree(hdr);
+	status = nvmet_copy_to_sgl(req, 0, buffer + offset, data_len);
+	kfree(buffer);
 out:
 	nvmet_req_complete(req, status);
 }
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 51e49efd7849..1653d19b187f 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -428,6 +428,7 @@ u16 nvmet_copy_from_sgl(struct nvmet_req *req, off_t off, void *buf,
 u16 nvmet_zero_sgl(struct nvmet_req *req, off_t off, size_t len);
 
 u32 nvmet_get_log_page_len(struct nvme_command *cmd);
+u64 nvmet_get_log_page_offset(struct nvme_command *cmd);
 
 extern struct list_head *nvmet_ports;
 void nvmet_port_disc_changed(struct nvmet_port *port,
-- 
2.14.4
