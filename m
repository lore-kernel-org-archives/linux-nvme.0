Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C395E77182
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2024 11:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sRzXvMDIGlbcN+I/yyn1kCEIHGVCHuLr1P5ftXxM398=; b=UjEVy+4bz27bzOBd1fpXM98gAq
	7Ig+I0RbcSH3wv00P8f/2wlEuRUtKoVVEftWodh26/SYrtMYKxJ0FCACr2fAL7fVde5Xvzct39lAc
	15RfK5FqFeeN14t5oV7tswhUKLk2IIO9VDR6aEhsAPyaNIwRPRA0Gu6TIY+PJ5mPlawdUat7ge0fG
	64Zhndv17ShblJz7tbrCj1sxLS5Fx6lpxLzntYu/eP8ENfAXe19FAMGNvV9D17WM+8waeoAfTkG6p
	2QemmxSlb8vNtBjXULRwvzBbn1jPfm670HbdX3ZhOG+EuP7bbn/oAKUvt97sHbIfNPdWOutMnP8vN
	Lv4acLYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLhVV-00000000Dr3-4890;
	Thu, 12 Dec 2024 11:37:25 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLhTX-00000000Cyc-3GtI
	for linux-nvme@lists.infradead.org;
	Thu, 12 Dec 2024 11:35:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id BED595C62C0;
	Thu, 12 Dec 2024 11:34:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75062C4CED4;
	Thu, 12 Dec 2024 11:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734003322;
	bh=mwQyUgDWPHDk5FyOL3o2ssht9G9ehr6tuqOO3PQbywA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gA+qp/nrdD3V5qpKpJvieen/9qP2w6Ff9qxWsNY6e0j5HhKJ358P+XPaQLIyDu9+r
	 lkS0EsIuhwOJqFpeLFbpcUDHNxr5ePPcBkbYXt6oN6fEfYbWRm+XcwIupF15GmzO37
	 Iqcz7EagkU7MPGpSqNVfwP+18HLO2wrKOSLzbm/kizVTrbwVEILr/4f9Prtk0T0VGp
	 gCdZydGJFLuVMEWb8+QoXYAgUferJ99KjRKZ0yDI5FgZz++qWHmXVNXVkeEPE1Lmgb
	 Pqv/WKI+FML7GIXc8CO7BMW8wCD5Kk1vagbMEpZwrX2wO9NhGE1b+KcZINsNgJLNy+
	 vsPaEUcXRlSIg==
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
Subject: [PATCH v4 09/18] nvmet: Introduce nvmet_sq_create() and nvmet_cq_create()
Date: Thu, 12 Dec 2024 20:34:31 +0900
Message-ID: <20241212113440.352958-10-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212113440.352958-1-dlemoal@kernel.org>
References: <20241212113440.352958-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241212_033523_903452_F9C5634E 
X-CRM114-Status: GOOD (  18.67  )
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

Introduce the new functions nvmet_sq_create() and nvmet_cq_create() to
allow a target driver to initialize and setup admin and IO queues
directly, without needing to execute connect fabrics commands.
The helper functions nvmet_check_cqid() and nvmet_check_sqid() are
implemented to check the correctness of SQ and CQ IDs when
nvmet_sq_create() and nvmet_cq_create() are called.

nvmet_sq_create() and nvmet_cq_create() are primarily intended for use
with PCI target controller drivers and thus are not well integrated
with the current queue creation of fabrics controllers using the connect
command. These fabrices drivers are not modified to use these functions.
This simple implementation of SQ and CQ management for PCI target
controller drivers does not allow multiple SQs to share the same CQ,
similarly to other fabrics transports. This is a specification
violation. A more involved set of changes will follow to add support for
this required completion queue sharing feature.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 drivers/nvme/target/core.c  | 83 +++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h |  6 +++
 2 files changed, 89 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 9bca3e576893..3a92e3a81b46 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -818,6 +818,89 @@ static void nvmet_confirm_sq(struct percpu_ref *ref)
 	complete(&sq->confirm_done);
 }
 
+u16 nvmet_check_cqid(struct nvmet_ctrl *ctrl, u16 cqid)
+{
+	if (!ctrl->sqs)
+		return NVME_SC_INTERNAL | NVME_STATUS_DNR;
+
+	if (cqid > ctrl->subsys->max_qid)
+		return NVME_SC_QID_INVALID | NVME_STATUS_DNR;
+
+	/*
+	 * Note: For PCI controllers, the NVMe specifications allows multiple
+	 * SQs to share a single CQ. However, we do not support this yet, so
+	 * check that there is no SQ defined for a CQ. If one exist, then the
+	 * CQ ID is invalid for creation as well as when the CQ is being
+	 * deleted (as that would mean that the SQ was not deleted before the
+	 * CQ).
+	 */
+	if (ctrl->sqs[cqid])
+		return NVME_SC_QID_INVALID | NVME_STATUS_DNR;
+
+	return NVME_SC_SUCCESS;
+}
+
+u16 nvmet_cq_create(struct nvmet_ctrl *ctrl, struct nvmet_cq *cq,
+		    u16 qid, u16 size)
+{
+	u16 status;
+
+	status = nvmet_check_cqid(ctrl, qid);
+	if (status != NVME_SC_SUCCESS)
+		return status;
+
+	nvmet_cq_setup(ctrl, cq, qid, size);
+
+	return NVME_SC_SUCCESS;
+}
+EXPORT_SYMBOL_GPL(nvmet_cq_create);
+
+u16 nvmet_check_sqid(struct nvmet_ctrl *ctrl, u16 sqid,
+		     bool create)
+{
+	if (!ctrl->sqs)
+		return NVME_SC_INTERNAL | NVME_STATUS_DNR;
+
+	if (sqid > ctrl->subsys->max_qid)
+		return NVME_SC_QID_INVALID | NVME_STATUS_DNR;
+
+	if ((create && ctrl->sqs[sqid]) ||
+	    (!create && !ctrl->sqs[sqid]))
+		return NVME_SC_QID_INVALID | NVME_STATUS_DNR;
+
+	return NVME_SC_SUCCESS;
+}
+
+u16 nvmet_sq_create(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq,
+		    u16 sqid, u16 size)
+{
+	u16 status;
+	int ret;
+
+	if (!kref_get_unless_zero(&ctrl->ref))
+		return NVME_SC_INTERNAL | NVME_STATUS_DNR;
+
+	status = nvmet_check_sqid(ctrl, sqid, true);
+	if (status != NVME_SC_SUCCESS)
+		return status;
+
+	ret = nvmet_sq_init(sq);
+	if (ret) {
+		status = NVME_SC_INTERNAL | NVME_STATUS_DNR;
+		goto ctrl_put;
+	}
+
+	nvmet_sq_setup(ctrl, sq, sqid, size);
+	sq->ctrl = ctrl;
+
+	return NVME_SC_SUCCESS;
+
+ctrl_put:
+	nvmet_ctrl_put(ctrl);
+	return status;
+}
+EXPORT_SYMBOL_GPL(nvmet_sq_create);
+
 void nvmet_sq_destroy(struct nvmet_sq *sq)
 {
 	struct nvmet_ctrl *ctrl = sq->ctrl;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 96c4c2489be7..5c8ed8f93918 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -545,10 +545,16 @@ void nvmet_execute_set_features(struct nvmet_req *req);
 void nvmet_execute_get_features(struct nvmet_req *req);
 void nvmet_execute_keep_alive(struct nvmet_req *req);
 
+u16 nvmet_check_cqid(struct nvmet_ctrl *ctrl, u16 cqid);
 void nvmet_cq_setup(struct nvmet_ctrl *ctrl, struct nvmet_cq *cq, u16 qid,
 		u16 size);
+u16 nvmet_cq_create(struct nvmet_ctrl *ctrl, struct nvmet_cq *cq, u16 qid,
+		u16 size);
+u16 nvmet_check_sqid(struct nvmet_ctrl *ctrl, u16 sqid, bool create);
 void nvmet_sq_setup(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, u16 qid,
 		u16 size);
+u16 nvmet_sq_create(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, u16 qid,
+		u16 size);
 void nvmet_sq_destroy(struct nvmet_sq *sq);
 int nvmet_sq_init(struct nvmet_sq *sq);
 
-- 
2.47.1


