Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A15CFB443
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2024 04:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KWjNcIWCBu8C47Mg9Wb2HNl0cw9w705U3nfiKtmOPGM=; b=J1YmgrmihTixunHIcuBvBgnXXH
	P+Dz9lBdIWhWpYJ5ZZZAd2aj0p+WwjotX9C4pw+6buOyVOO7whvw4NNh7dmyki/gU5kwTT+gVQeq2
	ICqvatVTDlPtWWLhEcTwioIb1d7rgsWiw0KNOR22RvsFd7WdNc7ozEw0aeq618no0Bu/flWXwzTmj
	sYWhNA5ocK6Q2apL2sJfkpZHMx+H+xclVWtXUBIxcUCYSd4tN3QqykI3Vl/xgK2stVFj/m56YhzYy
	BWSzTkZOJcSwfbk5ADle7ETpnDzz6pkyf8qqUPC3Q24cu9AsU0ACkagkMj4fmjxCsiOvjsk2k4fc0
	i+PVtvfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sxfbG-00000001Fkw-28zl;
	Mon, 07 Oct 2024 04:44:02 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sxfbB-00000001FjF-0UXu
	for linux-nvme@lists.infradead.org;
	Mon, 07 Oct 2024 04:43:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 8F426A414F6;
	Mon,  7 Oct 2024 04:43:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448ACC4CED0;
	Mon,  7 Oct 2024 04:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728276235;
	bh=vfUOd45XU/XxutZyW6nJEnB0x4D/3FMkZDnFt4MKos8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NSNNkHhCzpQBZtqIoBqgdOZYO2asdfp+8w7pJB4t/Z172qFdLAKMgcZk+fwq6HI+M
	 hMpNxrZIr4f/bLTXI3ezRKpmNdSM7LfLzAY8IxS4FhaTiwp1A2wmSuBtM3KMrmrWC6
	 dtPCgf043bqSbstafIDWEBCVig8LC7wlb+Vz/NiHTgYEDuDYIYx2oT4CD54utsTLP3
	 q2+wNYCjio1fZFW7Jm3FaZogkufnpgl6h3Xa5O9NhgIy0tYaNNvt/1q7oNMr/NnMDo
	 1Z6xwVxJRUVNfzLpNXfpBcDYFxv8XPqLc0iRsrvYlJP5B2DFWJn5f4+o6I9lWnZy7Z
	 mEZNaCgTOJLIg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org
Cc: Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v1 1/5] nvmet: rename and move nvmet_get_log_page_len()
Date: Mon,  7 Oct 2024 13:43:47 +0900
Message-ID: <20241007044351.157912-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241007044351.157912-1-dlemoal@kernel.org>
References: <20241007044351.157912-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241006_214357_305172_0A83C4FC 
X-CRM114-Status: GOOD (  14.61  )
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

The code for nvmet_get_log_page_len() has no pedendency on nvme target
code and only depends on struct nvme_command. Move this helper function
out of drivers/nvme/target/admin-cmd.c and inline it as part of the
generic definitions in include/linux/nvme.h. Apply the same modification
to nvmet_get_log_page_offset().

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/nvme/target/admin-cmd.c | 20 +-------------------
 drivers/nvme/target/discovery.c |  4 ++--
 drivers/nvme/target/nvmet.h     |  3 ---
 include/linux/nvme.h            | 19 +++++++++++++++++++
 4 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 954d4c074770..b20cd1dba207 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -12,19 +12,6 @@
 #include <asm/unaligned.h>
 #include "nvmet.h"
 
-u32 nvmet_get_log_page_len(struct nvme_command *cmd)
-{
-	u32 len = le16_to_cpu(cmd->get_log_page.numdu);
-
-	len <<= 16;
-	len += le16_to_cpu(cmd->get_log_page.numdl);
-	/* NUMD is a 0's based value */
-	len += 1;
-	len *= sizeof(u32);
-
-	return len;
-}
-
 static u32 nvmet_feat_data_len(struct nvmet_req *req, u32 cdw10)
 {
 	switch (cdw10 & 0xff) {
@@ -35,11 +22,6 @@ static u32 nvmet_feat_data_len(struct nvmet_req *req, u32 cdw10)
 	}
 }
 
-u64 nvmet_get_log_page_offset(struct nvme_command *cmd)
-{
-	return le64_to_cpu(cmd->get_log_page.lpo);
-}
-
 static void nvmet_execute_get_log_page_noop(struct nvmet_req *req)
 {
 	nvmet_req_complete(req, nvmet_zero_sgl(req, 0, req->transfer_len));
@@ -319,7 +301,7 @@ static void nvmet_execute_get_log_page_ana(struct nvmet_req *req)
 
 static void nvmet_execute_get_log_page(struct nvmet_req *req)
 {
-	if (!nvmet_check_transfer_len(req, nvmet_get_log_page_len(req->cmd)))
+	if (!nvmet_check_transfer_len(req, nvme_get_log_page_len(req->cmd)))
 		return;
 
 	switch (req->cmd->get_log_page.lid) {
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index 28843df5fa7c..71c94a54bcd8 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -163,8 +163,8 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 	const int entry_size = sizeof(struct nvmf_disc_rsp_page_entry);
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvmf_disc_rsp_page_hdr *hdr;
-	u64 offset = nvmet_get_log_page_offset(req->cmd);
-	size_t data_len = nvmet_get_log_page_len(req->cmd);
+	u64 offset = nvme_get_log_page_offset(req->cmd);
+	size_t data_len = nvme_get_log_page_len(req->cmd);
 	size_t alloc_len;
 	struct nvmet_subsys_link *p;
 	struct nvmet_port *r;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 190f55e6d753..6e9499268c28 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -541,9 +541,6 @@ u16 nvmet_copy_from_sgl(struct nvmet_req *req, off_t off, void *buf,
 		size_t len);
 u16 nvmet_zero_sgl(struct nvmet_req *req, off_t off, size_t len);
 
-u32 nvmet_get_log_page_len(struct nvme_command *cmd);
-u64 nvmet_get_log_page_offset(struct nvme_command *cmd);
-
 extern struct list_head *nvmet_ports;
 void nvmet_port_disc_changed(struct nvmet_port *port,
 		struct nvmet_subsys *subsys);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b58d9405d65e..1f6d8cd0389a 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -10,6 +10,7 @@
 #include <linux/bits.h>
 #include <linux/types.h>
 #include <linux/uuid.h>
+#include <asm/byteorder.h>
 
 /* NQN names in commands fields specified one size */
 #define NVMF_NQN_FIELD_LEN	256
@@ -1856,6 +1857,24 @@ static inline bool nvme_is_write(const struct nvme_command *cmd)
 	return cmd->common.opcode & 1;
 }
 
+static inline __u32 nvme_get_log_page_len(struct nvme_command *cmd)
+{
+	__u32 len = le16_to_cpu(cmd->get_log_page.numdu);
+
+	len <<= 16;
+	len += le16_to_cpu(cmd->get_log_page.numdl);
+	/* NUMD is a 0's based value */
+	len += 1;
+	len *= sizeof(__u32);
+
+	return len;
+}
+
+static inline __u64 nvme_get_log_page_offset(struct nvme_command *cmd)
+{
+	return le64_to_cpu(cmd->get_log_page.lpo);
+}
+
 enum {
 	/*
 	 * Generic Command Status:
-- 
2.46.2


