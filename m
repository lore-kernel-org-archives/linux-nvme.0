Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CBE3E77182
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2024 11:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MdAcO6xDuglkyrjFdv+0Qa8mS6L2ucw9f6rQ3ItUsaY=; b=z4OWQRgWUgyzW/a+Xm2b0dAqnR
	lTt94FnyGrabtTJlsLDY1wuWTOun6masPjvXa/4M40lfj+bUHmsDD1h2IR2sx7NzQKFoiB2nAtYNp
	7VoBCpXQWPUb9sI6LFe3OjPUsAqi/jfuMOpicNGL+k8rVmWTuzeOGTSPaZB1YKHNpAdE5oaC82yA/
	KlnGKfLIfrQgvnGyTMXtyGTtjNk+RNU5GAPNp2qVupUUULF8DASUkLkxAx29E5q3ijQ7wEWG+rXJl
	i5Wd6lfDWT/UgksQwiL5Igo3tvxwWDCWBTo3dI49Jzeh3MLvfgUF7Wa40F5o6VZ+XAqsQeWQmcUON
	0xOGhuCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLhVT-00000000Dnb-0g9z;
	Thu, 12 Dec 2024 11:37:23 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLhTU-00000000Cwg-1eUm
	for linux-nvme@lists.infradead.org;
	Thu, 12 Dec 2024 11:35:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 62A235C67A7;
	Thu, 12 Dec 2024 11:34:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C5BC4CED1;
	Thu, 12 Dec 2024 11:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734003319;
	bh=H9jVSUxLfPp9Bn3hInwNoM6ixwWU7m3iDsWe3Y51OeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uhXa1rw06bJMoWQbaejUFXSOeQcNDXdSX7B+W1zECIDclbgqU0NbLbpzVKLzPVsoL
	 Y3HMsfbA0jzW1kqaQ+Rr6nv4316HpNnpds4AYV5mt/TzyhfAzznpw293VqrbMt9jSV
	 zvP/PD21XcV3FdIsLdSS/6EmaENyZdiH5HNni+pW2eXURH9nc6oAA1KHPsJ/nKvSwM
	 4pHw11nFg+yTIF9nBB3EU8XkZE7N52JIZlGujVuKchbcbP6AXFVhYlGstloowBgTRF
	 dfo3f1XqM1C3yIzt6Vyj2bQJHkxsdVkKsO6Qo1JQtX0pZjtB0sI7IoQ+BUq+Abycgk
	 pgmW1+ReXTFDg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v4 07/18] nvmet: Improve nvmet_alloc_ctrl() interface and implementation
Date: Thu, 12 Dec 2024 20:34:29 +0900
Message-ID: <20241212113440.352958-8-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212113440.352958-1-dlemoal@kernel.org>
References: <20241212113440.352958-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241212_033520_522580_733B9950 
X-CRM114-Status: GOOD (  22.42  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Introduce struct nvmet_alloc_ctrl_args to define the arguments for
the function nvmet_alloc_ctrl() to avoid the need for passing a pointer
to a struct nvmet_req as an argument. This new data structure aggregates
together the arguments that were passed to nvmet_alloc_ctrl()
(subsysnqn, hostnqn and kato), together with the struct nvmet_req fields
used by nvmet_alloc_ctrl(), that is, the fields port, p2p_client, and
ops as input and the result and error_loc fields as output, as well as a
status field. nvmet_alloc_ctrl() is also changed to return a pointer
to the allocated and initialized controller structure instead of a
status code, as the status is now returned through the status field of
struct nvmet_alloc_ctrl_args.

The function nvmet_setup_p2p_ns_map() is changed to not take a pointer
to a struct nvmet_req as argument, instead, directly specify the
p2p_client device pointer needed as argument.

The code in nvmet_execute_admin_connect() that initializes a new target
controller after allocating it is moved into nvmet_alloc_ctrl().
The code that sets up an admin queue for the controller (and the call
to nvmet_install_queue()) remains in nvmet_execute_admin_connect().

Finally, nvmet_alloc_ctrl() is also exported to allow target drivers to
use this function directly to allocate and initialize a new controller
structure without the need to rely on a fabrics connect command request.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 drivers/nvme/target/core.c        | 83 ++++++++++++++++++++-----------
 drivers/nvme/target/fabrics-cmd.c | 58 ++++++++++-----------
 drivers/nvme/target/nvmet.h       | 18 +++++--
 3 files changed, 94 insertions(+), 65 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 4b5594549ae6..4909f3e5a552 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1350,15 +1350,15 @@ bool nvmet_host_allowed(struct nvmet_subsys *subsys, const char *hostnqn)
  * Note: ctrl->subsys->lock should be held when calling this function
  */
 static void nvmet_setup_p2p_ns_map(struct nvmet_ctrl *ctrl,
-		struct nvmet_req *req)
+		struct device *p2p_client)
 {
 	struct nvmet_ns *ns;
 	unsigned long idx;
 
-	if (!req->p2p_client)
+	if (!p2p_client)
 		return;
 
-	ctrl->p2p_client = get_device(req->p2p_client);
+	ctrl->p2p_client = get_device(p2p_client);
 
 	xa_for_each(&ctrl->subsys->namespaces, idx, ns)
 		nvmet_p2pmem_ns_add_p2p(ctrl, ns);
@@ -1387,45 +1387,44 @@ static void nvmet_fatal_error_handler(struct work_struct *work)
 	ctrl->ops->delete_ctrl(ctrl);
 }
 
-u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
-		struct nvmet_req *req, u32 kato, struct nvmet_ctrl **ctrlp,
-		uuid_t *hostid)
+struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 {
 	struct nvmet_subsys *subsys;
 	struct nvmet_ctrl *ctrl;
+	u32 kato = args->kato;
+	u8 dhchap_status;
 	int ret;
-	u16 status;
 
-	status = NVME_SC_CONNECT_INVALID_PARAM | NVME_STATUS_DNR;
-	subsys = nvmet_find_get_subsys(req->port, subsysnqn);
+	args->status = NVME_SC_CONNECT_INVALID_PARAM | NVME_STATUS_DNR;
+	subsys = nvmet_find_get_subsys(args->port, args->subsysnqn);
 	if (!subsys) {
 		pr_warn("connect request for invalid subsystem %s!\n",
-			subsysnqn);
-		req->cqe->result.u32 = IPO_IATTR_CONNECT_DATA(subsysnqn);
-		req->error_loc = offsetof(struct nvme_common_command, dptr);
-		goto out;
+			args->subsysnqn);
+		args->result = IPO_IATTR_CONNECT_DATA(subsysnqn);
+		args->error_loc = offsetof(struct nvme_common_command, dptr);
+		return NULL;
 	}
 
 	down_read(&nvmet_config_sem);
-	if (!nvmet_host_allowed(subsys, hostnqn)) {
+	if (!nvmet_host_allowed(subsys, args->hostnqn)) {
 		pr_info("connect by host %s for subsystem %s not allowed\n",
-			hostnqn, subsysnqn);
-		req->cqe->result.u32 = IPO_IATTR_CONNECT_DATA(hostnqn);
+			args->hostnqn, args->subsysnqn);
+		args->result = IPO_IATTR_CONNECT_DATA(hostnqn);
 		up_read(&nvmet_config_sem);
-		status = NVME_SC_CONNECT_INVALID_HOST | NVME_STATUS_DNR;
-		req->error_loc = offsetof(struct nvme_common_command, dptr);
+		args->status = NVME_SC_CONNECT_INVALID_HOST | NVME_STATUS_DNR;
+		args->error_loc = offsetof(struct nvme_common_command, dptr);
 		goto out_put_subsystem;
 	}
 	up_read(&nvmet_config_sem);
 
-	status = NVME_SC_INTERNAL;
+	args->status = NVME_SC_INTERNAL;
 	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
 	if (!ctrl)
 		goto out_put_subsystem;
 	mutex_init(&ctrl->lock);
 
-	ctrl->port = req->port;
-	ctrl->ops = req->ops;
+	ctrl->port = args->port;
+	ctrl->ops = args->ops;
 
 #ifdef CONFIG_NVME_TARGET_PASSTHRU
 	/* By default, set loop targets to clear IDS by default */
@@ -1439,8 +1438,8 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	INIT_WORK(&ctrl->fatal_err_work, nvmet_fatal_error_handler);
 	INIT_DELAYED_WORK(&ctrl->ka_work, nvmet_keep_alive_timer);
 
-	memcpy(ctrl->subsysnqn, subsysnqn, NVMF_NQN_SIZE);
-	memcpy(ctrl->hostnqn, hostnqn, NVMF_NQN_SIZE);
+	memcpy(ctrl->subsysnqn, args->subsysnqn, NVMF_NQN_SIZE);
+	memcpy(ctrl->hostnqn, args->hostnqn, NVMF_NQN_SIZE);
 
 	kref_init(&ctrl->ref);
 	ctrl->subsys = subsys;
@@ -1463,12 +1462,12 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 			     subsys->cntlid_min, subsys->cntlid_max,
 			     GFP_KERNEL);
 	if (ret < 0) {
-		status = NVME_SC_CONNECT_CTRL_BUSY | NVME_STATUS_DNR;
+		args->status = NVME_SC_CONNECT_CTRL_BUSY | NVME_STATUS_DNR;
 		goto out_free_sqs;
 	}
 	ctrl->cntlid = ret;
 
-	uuid_copy(&ctrl->hostid, hostid);
+	uuid_copy(&ctrl->hostid, args->hostid);
 
 	/*
 	 * Discovery controllers may use some arbitrary high value
@@ -1490,12 +1489,35 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	if (ret)
 		goto init_pr_fail;
 	list_add_tail(&ctrl->subsys_entry, &subsys->ctrls);
-	nvmet_setup_p2p_ns_map(ctrl, req);
+	nvmet_setup_p2p_ns_map(ctrl, args->p2p_client);
 	nvmet_debugfs_ctrl_setup(ctrl);
 	mutex_unlock(&subsys->lock);
 
-	*ctrlp = ctrl;
-	return 0;
+	if (args->hostid)
+		uuid_copy(&ctrl->hostid, args->hostid);
+
+	dhchap_status = nvmet_setup_auth(ctrl);
+	if (dhchap_status) {
+		pr_err("Failed to setup authentication, dhchap status %u\n",
+		       dhchap_status);
+		nvmet_ctrl_put(ctrl);
+		if (dhchap_status == NVME_AUTH_DHCHAP_FAILURE_FAILED)
+			args->status =
+				NVME_SC_CONNECT_INVALID_HOST | NVME_STATUS_DNR;
+		else
+			args->status = NVME_SC_INTERNAL;
+		return NULL;
+	}
+
+	args->status = NVME_SC_SUCCESS;
+
+	pr_info("Created %s controller %d for subsystem %s for NQN %s%s%s.\n",
+		nvmet_is_disc_subsys(ctrl->subsys) ? "discovery" : "nvm",
+		ctrl->cntlid, ctrl->subsys->subsysnqn, ctrl->hostnqn,
+		ctrl->pi_support ? " T10-PI is enabled" : "",
+		nvmet_has_auth(ctrl) ? " with DH-HMAC-CHAP" : "");
+
+	return ctrl;
 
 init_pr_fail:
 	mutex_unlock(&subsys->lock);
@@ -1509,9 +1531,9 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	kfree(ctrl);
 out_put_subsystem:
 	nvmet_subsys_put(subsys);
-out:
-	return status;
+	return NULL;
 }
+EXPORT_SYMBOL_GPL(nvmet_alloc_ctrl);
 
 static void nvmet_ctrl_free(struct kref *ref)
 {
@@ -1547,6 +1569,7 @@ void nvmet_ctrl_put(struct nvmet_ctrl *ctrl)
 {
 	kref_put(&ctrl->ref, nvmet_ctrl_free);
 }
+EXPORT_SYMBOL_GPL(nvmet_ctrl_put);
 
 void nvmet_ctrl_fatal_error(struct nvmet_ctrl *ctrl)
 {
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index c49904ebb6c2..8dbd7df8c9a0 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -213,73 +213,67 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 	struct nvmf_connect_command *c = &req->cmd->connect;
 	struct nvmf_connect_data *d;
 	struct nvmet_ctrl *ctrl = NULL;
-	u16 status;
-	u8 dhchap_status;
+	struct nvmet_alloc_ctrl_args args = {
+		.port = req->port,
+		.ops = req->ops,
+		.p2p_client = req->p2p_client,
+		.kato = le32_to_cpu(c->kato),
+	};
 
 	if (!nvmet_check_transfer_len(req, sizeof(struct nvmf_connect_data)))
 		return;
 
 	d = kmalloc(sizeof(*d), GFP_KERNEL);
 	if (!d) {
-		status = NVME_SC_INTERNAL;
+		args.status = NVME_SC_INTERNAL;
 		goto complete;
 	}
 
-	status = nvmet_copy_from_sgl(req, 0, d, sizeof(*d));
-	if (status)
+	args.status = nvmet_copy_from_sgl(req, 0, d, sizeof(*d));
+	if (args.status)
 		goto out;
 
 	if (c->recfmt != 0) {
 		pr_warn("invalid connect version (%d).\n",
 			le16_to_cpu(c->recfmt));
-		req->error_loc = offsetof(struct nvmf_connect_command, recfmt);
-		status = NVME_SC_CONNECT_FORMAT | NVME_STATUS_DNR;
+		args.error_loc = offsetof(struct nvmf_connect_command, recfmt);
+		args.status = NVME_SC_CONNECT_FORMAT | NVME_STATUS_DNR;
 		goto out;
 	}
 
 	if (unlikely(d->cntlid != cpu_to_le16(0xffff))) {
 		pr_warn("connect attempt for invalid controller ID %#x\n",
 			d->cntlid);
-		status = NVME_SC_CONNECT_INVALID_PARAM | NVME_STATUS_DNR;
-		req->cqe->result.u32 = IPO_IATTR_CONNECT_DATA(cntlid);
+		args.status = NVME_SC_CONNECT_INVALID_PARAM | NVME_STATUS_DNR;
+		args.result = IPO_IATTR_CONNECT_DATA(cntlid);
 		goto out;
 	}
 
 	d->subsysnqn[NVMF_NQN_FIELD_LEN - 1] = '\0';
 	d->hostnqn[NVMF_NQN_FIELD_LEN - 1] = '\0';
-	status = nvmet_alloc_ctrl(d->subsysnqn, d->hostnqn, req,
-				  le32_to_cpu(c->kato), &ctrl, &d->hostid);
-	if (status)
-		goto out;
 
-	dhchap_status = nvmet_setup_auth(ctrl);
-	if (dhchap_status) {
-		pr_err("Failed to setup authentication, dhchap status %u\n",
-		       dhchap_status);
-		nvmet_ctrl_put(ctrl);
-		if (dhchap_status == NVME_AUTH_DHCHAP_FAILURE_FAILED)
-			status = (NVME_SC_CONNECT_INVALID_HOST | NVME_STATUS_DNR);
-		else
-			status = NVME_SC_INTERNAL;
+	args.subsysnqn = d->subsysnqn;
+	args.hostnqn = d->hostnqn;
+	args.hostid = &d->hostid;
+	args.kato = c->kato;
+
+	ctrl = nvmet_alloc_ctrl(&args);
+	if (!ctrl)
 		goto out;
-	}
 
-	status = nvmet_install_queue(ctrl, req);
-	if (status) {
+	args.status = nvmet_install_queue(ctrl, req);
+	if (args.status) {
 		nvmet_ctrl_put(ctrl);
 		goto out;
 	}
 
-	pr_info("creating %s controller %d for subsystem %s for NQN %s%s%s.\n",
-		nvmet_is_disc_subsys(ctrl->subsys) ? "discovery" : "nvm",
-		ctrl->cntlid, ctrl->subsys->subsysnqn, ctrl->hostnqn,
-		ctrl->pi_support ? " T10-PI is enabled" : "",
-		nvmet_has_auth(ctrl) ? " with DH-HMAC-CHAP" : "");
-	req->cqe->result.u32 = cpu_to_le32(nvmet_connect_result(ctrl));
+	args.result = cpu_to_le32(nvmet_connect_result(ctrl));
 out:
 	kfree(d);
 complete:
-	nvmet_req_complete(req, status);
+	req->error_loc = args.error_loc;
+	req->cqe->result.u32 = args.result;
+	nvmet_req_complete(req, args.status);
 }
 
 static void nvmet_execute_io_connect(struct nvmet_req *req)
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 4dad413e5fef..ed7e8cd890e4 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -549,9 +549,21 @@ int nvmet_sq_init(struct nvmet_sq *sq);
 void nvmet_ctrl_fatal_error(struct nvmet_ctrl *ctrl);
 
 void nvmet_update_cc(struct nvmet_ctrl *ctrl, u32 new);
-u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
-		struct nvmet_req *req, u32 kato, struct nvmet_ctrl **ctrlp,
-		uuid_t *hostid);
+
+struct nvmet_alloc_ctrl_args {
+	struct nvmet_port	*port;
+	char			*subsysnqn;
+	char			*hostnqn;
+	uuid_t			*hostid;
+	const struct nvmet_fabrics_ops *ops;
+	struct device		*p2p_client;
+	u32			kato;
+	u32			result;
+	u16			error_loc;
+	u16			status;
+};
+
+struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args);
 struct nvmet_ctrl *nvmet_ctrl_find_get(const char *subsysnqn,
 				       const char *hostnqn, u16 cntlid,
 				       struct nvmet_req *req);
-- 
2.47.1


