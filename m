Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EDEFE7718D
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Dec 2024 08:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T6gFiTl/AmzEo0pH/Oqh1ue84+cKqy2aF3STrHj4Hug=; b=Cjevze9LtpbT89MzsVqoyzH/JP
	GpQ85uwuqO5TIt1vtfUkQDy3vbmv+waQ++aftF/ERbwY4ihQcO83pf3nXDYUFdctfJ5K4yWhXcQv5
	O0HuDnIk81277HuXNadIIbLuCA0qrzGqJVF65sbP+nh/+sMNQOXXaBZirCpxkD0EFT9ddQO5op7NB
	vNCdpaXFnE63vXuN/KG9yQLiQFyqLUlqEcwoJ/hjBa6DBAoFO9C5vy6VF7/iIPhlJAYSz2jUtC3fs
	xZvk37FV4lPM6ILsIf5WMteF6W1iuhAUJpXNjeLf+v4qUIIrTaVKhd09HrAWm1Z92KgJuueWahrkE
	z3mGzx9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tQMnC-0000000DSWZ-3SrN;
	Wed, 25 Dec 2024 08:30:58 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tQMn6-0000000DSNL-2RPb
	for linux-nvme@lists.infradead.org;
	Wed, 25 Dec 2024 08:30:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4418E5C586C;
	Wed, 25 Dec 2024 08:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D6A3C4CED7;
	Wed, 25 Dec 2024 08:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735115451;
	bh=YdKNB4pVRYr/2MHKrur2dUR8gjK2bQLIHhLE78yQdaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VT8s2LS6VvFw2XiavrD914gdnuXYEqNvII7Lx94mknXW6flKFVv7qnWbLJbk68tW0
	 ZpH9YifZDLsKC9oDOt7mtUiXfGDeCIsBF3Wjou4Ht9/L2t+eac0vc00iO2Qex0ZJGM
	 w0wosJOTEm9WCA2wz5iqMGUQyWZabZoyGgEISSaULZBromGVmUT/DjS97vOc7+a9e6
	 J93yTWMj6x0Of7MA/M42CjWNjRYsBlY2thzguQRTalEITCdvv/7+BQyqdlGldpf+BE
	 akrDT0E/VicLHUwGH6KcIXOQ5AR/wtplT1BumPM0UoCo3/FS8nBbd32E2AvLsgw06k
	 GBm9+0fTrnU/g==
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
Subject: [PATCH v8 10/18] nvmet: Add support for I/O queue management admin commands
Date: Wed, 25 Dec 2024 17:29:47 +0900
Message-ID: <20241225082956.96650-11-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241225082956.96650-1-dlemoal@kernel.org>
References: <20241225082956.96650-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241225_003052_889403_9D08AAD5 
X-CRM114-Status: GOOD (  21.69  )
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

The I/O submission queue management admin commands
(nvme_admin_delete_sq, nvme_admin_create_sq, nvme_admin_delete_cq,
and nvme_admin_create_cq) are mandatory admin commands for I/O
controllers using the PCI transport, that is, support for these commands
is mandatory for a a PCI target I/O controller.

Implement support for these commands by adding the functions
nvmet_execute_delete_sq(), nvmet_execute_create_sq(),
nvmet_execute_delete_cq() and nvmet_execute_create_cq() to set as the
execute method of requests for these commands. These functions will
return an invalid opcode error for any controller that is not a PCI
target controller. Support for the I/O queue management commands is also
reported in the command effect log  of PCI target controllers (using
nvmet_get_cmd_effects_admin()).

Each management command is backed by a controller fabric operation
that can be defined by a PCI target controller driver to setup I/O
queues using nvmet_sq_create() and nvmet_cq_create() or delete I/O
queues using nvmet_sq_destroy().

As noted in a comment in nvmet_execute_create_sq(), we do not yet
support sharing a single CQ between multiple SQs.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/nvme/target/admin-cmd.c | 165 +++++++++++++++++++++++++++++++-
 drivers/nvme/target/nvmet.h     |   8 ++
 2 files changed, 170 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 6f7e5b0c91c7..c91864c185fc 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -12,6 +12,142 @@
 #include <linux/unaligned.h>
 #include "nvmet.h"
 
+static void nvmet_execute_delete_sq(struct nvmet_req *req)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	u16 sqid = le16_to_cpu(req->cmd->delete_queue.qid);
+	u16 status;
+
+	if (!nvmet_is_pci_ctrl(ctrl)) {
+		status = nvmet_report_invalid_opcode(req);
+		goto complete;
+	}
+
+	if (!sqid) {
+		status = NVME_SC_QID_INVALID | NVME_STATUS_DNR;
+		goto complete;
+	}
+
+	status = nvmet_check_sqid(ctrl, sqid, false);
+	if (status != NVME_SC_SUCCESS)
+		goto complete;
+
+	status = ctrl->ops->delete_sq(ctrl, sqid);
+
+complete:
+	nvmet_req_complete(req, status);
+}
+
+static void nvmet_execute_create_sq(struct nvmet_req *req)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	struct nvme_command *cmd = req->cmd;
+	u16 sqid = le16_to_cpu(cmd->create_sq.sqid);
+	u16 cqid = le16_to_cpu(cmd->create_sq.cqid);
+	u16 sq_flags = le16_to_cpu(cmd->create_sq.sq_flags);
+	u16 qsize = le16_to_cpu(cmd->create_sq.qsize);
+	u64 prp1 = le64_to_cpu(cmd->create_sq.prp1);
+	u16 status;
+
+	if (!nvmet_is_pci_ctrl(ctrl)) {
+		status = nvmet_report_invalid_opcode(req);
+		goto complete;
+	}
+
+	if (!sqid) {
+		status = NVME_SC_QID_INVALID | NVME_STATUS_DNR;
+		goto complete;
+	}
+
+	status = nvmet_check_sqid(ctrl, sqid, true);
+	if (status != NVME_SC_SUCCESS)
+		goto complete;
+
+	/*
+	 * Note: The NVMe specification allows multiple SQs to use the same CQ.
+	 * However, the target code does not really support that. So for now,
+	 * prevent this and fail the command if sqid and cqid are different.
+	 */
+	if (!cqid || cqid != sqid) {
+		pr_err("SQ %u: Unsupported CQID %u\n", sqid, cqid);
+		status = NVME_SC_CQ_INVALID | NVME_STATUS_DNR;
+		goto complete;
+	}
+
+	if (!qsize || qsize > NVME_CAP_MQES(ctrl->cap)) {
+		status = NVME_SC_QUEUE_SIZE | NVME_STATUS_DNR;
+		goto complete;
+	}
+
+	status = ctrl->ops->create_sq(ctrl, sqid, sq_flags, qsize, prp1);
+
+complete:
+	nvmet_req_complete(req, status);
+}
+
+static void nvmet_execute_delete_cq(struct nvmet_req *req)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	u16 cqid = le16_to_cpu(req->cmd->delete_queue.qid);
+	u16 status;
+
+	if (!nvmet_is_pci_ctrl(ctrl)) {
+		status = nvmet_report_invalid_opcode(req);
+		goto complete;
+	}
+
+	if (!cqid) {
+		status = NVME_SC_QID_INVALID | NVME_STATUS_DNR;
+		goto complete;
+	}
+
+	status = nvmet_check_cqid(ctrl, cqid);
+	if (status != NVME_SC_SUCCESS)
+		goto complete;
+
+	status = ctrl->ops->delete_cq(ctrl, cqid);
+
+complete:
+	nvmet_req_complete(req, status);
+}
+
+static void nvmet_execute_create_cq(struct nvmet_req *req)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	struct nvme_command *cmd = req->cmd;
+	u16 cqid = le16_to_cpu(cmd->create_cq.cqid);
+	u16 cq_flags = le16_to_cpu(cmd->create_cq.cq_flags);
+	u16 qsize = le16_to_cpu(cmd->create_cq.qsize);
+	u16 irq_vector = le16_to_cpu(cmd->create_cq.irq_vector);
+	u64 prp1 = le64_to_cpu(cmd->create_cq.prp1);
+	u16 status;
+
+	if (!nvmet_is_pci_ctrl(ctrl)) {
+		status = nvmet_report_invalid_opcode(req);
+		goto complete;
+	}
+
+	if (!cqid) {
+		status = NVME_SC_QID_INVALID | NVME_STATUS_DNR;
+		goto complete;
+	}
+
+	status = nvmet_check_cqid(ctrl, cqid);
+	if (status != NVME_SC_SUCCESS)
+		goto complete;
+
+	if (!qsize || qsize > NVME_CAP_MQES(ctrl->cap)) {
+		status = NVME_SC_QUEUE_SIZE | NVME_STATUS_DNR;
+		goto complete;
+	}
+
+	status = ctrl->ops->create_cq(ctrl, cqid, cq_flags, qsize,
+				      prp1, irq_vector);
+
+complete:
+	nvmet_req_complete(req, status);
+}
+
 u32 nvmet_get_log_page_len(struct nvme_command *cmd)
 {
 	u32 len = le16_to_cpu(cmd->get_log_page.numdu);
@@ -230,8 +366,18 @@ static void nvmet_execute_get_log_page_smart(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
-static void nvmet_get_cmd_effects_admin(struct nvme_effects_log *log)
+static void nvmet_get_cmd_effects_admin(struct nvmet_ctrl *ctrl,
+					struct nvme_effects_log *log)
 {
+	/* For a PCI target controller, advertize support for the . */
+	if (nvmet_is_pci_ctrl(ctrl)) {
+		log->acs[nvme_admin_delete_sq] =
+		log->acs[nvme_admin_create_sq] =
+		log->acs[nvme_admin_delete_cq] =
+		log->acs[nvme_admin_create_cq] =
+			cpu_to_le32(NVME_CMD_EFFECTS_CSUPP);
+	}
+
 	log->acs[nvme_admin_get_log_page] =
 	log->acs[nvme_admin_identify] =
 	log->acs[nvme_admin_abort_cmd] =
@@ -268,6 +414,7 @@ static void nvmet_get_cmd_effects_zns(struct nvme_effects_log *log)
 
 static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
 {
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvme_effects_log *log;
 	u16 status = NVME_SC_SUCCESS;
 
@@ -279,7 +426,7 @@ static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
 
 	switch (req->cmd->get_log_page.csi) {
 	case NVME_CSI_NVM:
-		nvmet_get_cmd_effects_admin(log);
+		nvmet_get_cmd_effects_admin(ctrl, log);
 		nvmet_get_cmd_effects_nvm(log);
 		break;
 	case NVME_CSI_ZNS:
@@ -287,7 +434,7 @@ static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
 			status = NVME_SC_INVALID_IO_CMD_SET;
 			goto free;
 		}
-		nvmet_get_cmd_effects_admin(log);
+		nvmet_get_cmd_effects_admin(ctrl, log);
 		nvmet_get_cmd_effects_nvm(log);
 		nvmet_get_cmd_effects_zns(log);
 		break;
@@ -1335,9 +1482,21 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 		return nvmet_parse_passthru_admin_cmd(req);
 
 	switch (cmd->common.opcode) {
+	case nvme_admin_delete_sq:
+		req->execute = nvmet_execute_delete_sq;
+		return 0;
+	case nvme_admin_create_sq:
+		req->execute = nvmet_execute_create_sq;
+		return 0;
 	case nvme_admin_get_log_page:
 		req->execute = nvmet_execute_get_log_page;
 		return 0;
+	case nvme_admin_delete_cq:
+		req->execute = nvmet_execute_delete_cq;
+		return 0;
+	case nvme_admin_create_cq:
+		req->execute = nvmet_execute_create_cq;
+		return 0;
 	case nvme_admin_identify:
 		req->execute = nvmet_execute_identify;
 		return 0;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 5c8ed8f93918..86bb2852a63b 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -408,6 +408,14 @@ struct nvmet_fabrics_ops {
 	void (*discovery_chg)(struct nvmet_port *port);
 	u8 (*get_mdts)(const struct nvmet_ctrl *ctrl);
 	u16 (*get_max_queue_size)(const struct nvmet_ctrl *ctrl);
+
+	/* Operations mandatory for PCI target controllers */
+	u16 (*create_sq)(struct nvmet_ctrl *ctrl, u16 sqid, u16 flags,
+			 u16 qsize, u64 prp1);
+	u16 (*delete_sq)(struct nvmet_ctrl *ctrl, u16 sqid);
+	u16 (*create_cq)(struct nvmet_ctrl *ctrl, u16 cqid, u16 flags,
+			 u16 qsize, u64 prp1, u16 irq_vector);
+	u16 (*delete_cq)(struct nvmet_ctrl *ctrl, u16 cqid);
 };
 
 #define NVMET_MAX_INLINE_BIOVEC	8
-- 
2.47.1


