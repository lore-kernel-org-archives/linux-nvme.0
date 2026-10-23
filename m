Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23531606A31B
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2026 08:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JYELsXOi;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lZAy5bQP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=WBDpuGnlcRTVcNYvdHcb0aUPDjciemnVqD/r9RsLGgs=; b=JYELsXOirHAukC
	wmpwE9jAn0Zh5j0Wk5HV7IBOYHNvyvoBRdCbyO8wSa29fJaeNbrldiGqp+lMrjuvqGxouHZljwzjd
	g1ziCtkv45fEPuCRr4s42oVF+OhJhFRA/um61wq+Qb2lnLU6Ut40KCET3ys5f9z1LrU7kGmxnVzbF
	cYTzwLIwgnrfHq/FLSeW5CfAIhCaF8p92zjbqMJsk/+jp0ekVTnc1jdhWjPP1d+2D/DPHuMUUTZFg
	spGN3jWpyQ1GAbk+M3qDyZAS5B+/gNtGN0kxKk6vEc5YbVRAv5RVb9TokqM+ROE9ER8OzrBvMrDZT
	5ZxkFL+Aq45XVvCovFjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKAFC-0000000FqwQ-2hXr;
	Fri, 23 Oct 2026 08:03:18 +0000
Received: from out30-100.freemail.mail.aliyun.com ([115.124.30.100])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKAF5-0000000FqlT-2Z0Y
	for linux-nvme@lists.infradead.org;
	Fri, 23 Oct 2026 08:03:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792742589; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=WBDpuGnlcRTVcNYvdHcb0aUPDjciemnVqD/r9RsLGgs=;
	b=lZAy5bQPFjx3nwK994QudUAWijW09Sw34fSbKwWdWUv+uhpYXUMao0Cbusx3WBX/MFBKl+TsExFaPTiNF7HiIjpFHwmeQkjiwbGyDP+pznAB2AoswAgEByaZLuZWeYi+585VTG77fbTDdZy8bXmoXHft+6Qv1uE9At+Eln0yecQ=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XDLPeK4_1792742587;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XDLPeK4_1792742587 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 23 Oct 2026 16:03:08 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 09/11] nvmet: serve the FDP log pages
Date: Fri, 23 Oct 2026 16:02:49 +0800
Message-ID: <20261023080251.2606443-10-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261023080251.2606443-1-kanie@linux.alibaba.com>
References: <20261023080251.2606443-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261023_010311_883272_2B901676 
X-CRM114-Status: GOOD (  16.58  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-26.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The bridge advertises the FDP log pages 20h to 23h as supported;
serve them.

The FDP Configurations log page (LID 20h) is constructed from the
snapshot taken at namespace enable time: one valid configuration
with a single reclaim group, the backing number of reclaim unit
handles, all of the Initially Isolated type, and the backing reclaim
unit nominal size.  The page is addressed by the Endurance Group
Identifier in the Log Specific Identifier field.  Hosts first
request the 16 byte header to learn the page size and then the full
page; both request sizes are served from the same construction path.

The remaining pages are owned by the backing controller and are
forwarded to it over its admin queue, addressed by the Endurance
Group Identifier of the backing endurance group, so hosts read the
real reclaim unit handle usage, counters and events of the backing
device.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/admin-cmd.c | 16 ++++++
 drivers/nvme/target/fdp.c       | 98 ++++++++++++++++++++++++++++++++-
 drivers/nvme/target/nvmet.h     | 14 +++++
 3 files changed, 127 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 72606c0eeefd9..75119786a0ad2 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -220,6 +220,16 @@ static void nvmet_execute_get_supported_log_pages(struct nvmet_req *req)
 	logs->lids[NVME_LOG_FEATURES] = cpu_to_le32(NVME_LIDS_LSUPP);
 	logs->lids[NVME_LOG_RMI] = cpu_to_le32(NVME_LIDS_LSUPP);
 	logs->lids[NVME_LOG_RESERVATION] = cpu_to_le32(NVME_LIDS_LSUPP);
+	if (nvmet_fdp_subsys_configured(nvmet_req_subsys(req))) {
+		logs->lids[NVME_LOG_FDP_CONFIGS] =
+			cpu_to_le32(NVME_LIDS_LSUPP);
+		logs->lids[NVME_LOG_FDP_RUH_USAGE] =
+			cpu_to_le32(NVME_LIDS_LSUPP);
+		logs->lids[NVME_LOG_FDP_STATS] =
+			cpu_to_le32(NVME_LIDS_LSUPP);
+		logs->lids[NVME_LOG_FDP_EVENTS] =
+			cpu_to_le32(NVME_LIDS_LSUPP);
+	}
 
 	status = nvmet_copy_to_sgl(req, 0, logs, sizeof(*logs));
 	kfree(logs);
@@ -648,6 +658,12 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 		return nvmet_execute_get_log_page_rmi(req);
 	case NVME_LOG_RESERVATION:
 		return nvmet_execute_get_log_page_resv(req);
+	case NVME_LOG_FDP_CONFIGS:
+		return nvmet_execute_get_log_page_fdp_configs(req);
+	case NVME_LOG_FDP_RUH_USAGE:
+	case NVME_LOG_FDP_STATS:
+	case NVME_LOG_FDP_EVENTS:
+		return nvmet_fdp_log_forward(req);
 	}
 	pr_debug("unhandled lid %d on qid %d\n",
 	       req->cmd->get_log_page.lid, req->sq->qid);
diff --git a/drivers/nvme/target/fdp.c b/drivers/nvme/target/fdp.c
index 807f54c73c4e1..011f022e857aa 100644
--- a/drivers/nvme/target/fdp.c
+++ b/drivers/nvme/target/fdp.c
@@ -173,7 +173,6 @@ u16 nvmet_get_feat_fdp(struct nvmet_req *req)
 	return 0;
 }
 
-
 static u16 nvmet_fdp_io_mgmt_check(struct nvmet_req *req)
 {
 	if (!nvmet_fdp_enabled(req->ns))
@@ -355,3 +354,100 @@ static int nvmet_fdp_init_backend(struct nvmet_ns *ns)
 	return ret;
 }
 
+void nvmet_execute_get_log_page_fdp_configs(struct nvmet_req *req)
+{
+	u32 lsi = le16_to_cpu(req->cmd->get_log_page.lsi);
+	struct nvme_fdp_config_desc *desc;
+	struct nvme_fdp_config_log *log;
+	struct nvmet_ns *ns;
+	size_t dsze, total;
+	u16 status = 0;
+	int i;
+
+	ns = nvmet_fdp_lookup_ns(req, lsi);
+	if (!ns) {
+		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+		goto out;
+	}
+
+	dsze = ALIGN(struct_size(desc, ruhs, ns->fdp.nruh), 8);
+	total = sizeof(*log) + dsze;
+
+	log = kzalloc(req->transfer_len, GFP_KERNEL);
+	if (!log) {
+		status = NVME_SC_INTERNAL;
+		goto out_put;
+	}
+
+	if (req->transfer_len >= sizeof(*log)) {
+		/* single configuration, 0's based */
+		log->numfdpc = 0;
+		log->ver = 0;
+		log->sze = cpu_to_le32(total);
+	}
+	if (req->transfer_len >= total) {
+		desc = (void *)(log + 1);
+		desc->dsze = cpu_to_le16(dsze);
+		/* FDPCV set, FDPVWC clear, RGIF 0 for the single RG */
+		desc->fdpa = 1 << 7;
+		desc->nrg = cpu_to_le32(1);
+		desc->nruh = cpu_to_le16(ns->fdp.nruh);
+		desc->maxpids = cpu_to_le16(ns->fdp.nruh - 1);
+		desc->nns = cpu_to_le32(1);
+		desc->runs = cpu_to_le64(ns->fdp.runs);
+		/* all handles Initially Isolated */
+		for (i = 0; i < ns->fdp.nruh; i++)
+			desc->ruhs[i].ruht = 0x1;
+	}
+
+	status = nvmet_copy_to_sgl(req, 0, log, req->transfer_len);
+	kfree(log);
+out_put:
+	percpu_ref_put(&ns->ref);
+out:
+	nvmet_req_complete(req, status);
+}
+
+/*
+ * Forward an FDP log page that the backing controller owns, addressed
+ * by the Endurance Group Identifier of the backing endurance group.
+ */
+void nvmet_fdp_log_forward(struct nvmet_req *req)
+{
+	struct nvme_command c = {};
+	struct nvmet_ns *ns;
+	u16 status = 0;
+	void *buf;
+	int ret;
+
+	ns = nvmet_fdp_lookup_ns(req,
+				 le16_to_cpu(req->cmd->get_log_page.lsi));
+	if (!ns) {
+		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+		goto out;
+	}
+
+	buf = kzalloc(req->transfer_len, GFP_KERNEL);
+	if (!buf) {
+		status = NVME_SC_INTERNAL;
+		goto out_put;
+	}
+
+	c = *req->cmd;
+	c.get_log_page.nsid = cpu_to_le32(0);
+	c.get_log_page.lsi = cpu_to_le16(ns->fdp.backend_endgid);
+	ret = nvme_submit_sync_cmd(ns->fdp.backend_ctrl->admin_q, &c, buf,
+				   req->transfer_len);
+	if (ret) {
+		status = ret > 0 ? ret : NVME_SC_INTERNAL;
+		goto free;
+	}
+
+	status = nvmet_copy_to_sgl(req, 0, buf, req->transfer_len);
+free:
+	kfree(buf);
+out_put:
+	percpu_ref_put(&ns->ref);
+out:
+	nvmet_req_complete(req, status);
+}
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index c86fb2c19c152..8f48227323fea 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -1007,6 +1007,8 @@ u16 nvmet_set_feat_fdp(struct nvmet_req *req);
 u16 nvmet_get_feat_fdp(struct nvmet_req *req);
 void nvmet_execute_io_mgmt_recv(struct nvmet_req *req);
 void nvmet_execute_io_mgmt_send(struct nvmet_req *req);
+void nvmet_execute_get_log_page_fdp_configs(struct nvmet_req *req);
+void nvmet_fdp_log_forward(struct nvmet_req *req);
 #else
 static inline bool nvmet_fdp_enabled(struct nvmet_ns *ns)
 {
@@ -1039,6 +1041,18 @@ static inline void nvmet_execute_io_mgmt_send(struct nvmet_req *req)
 {
 	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_STATUS_DNR);
 }
+static inline void nvmet_execute_get_log_page_fdp_configs(struct nvmet_req *req)
+{
+	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_STATUS_DNR);
+}
+static inline void nvmet_fdp_log_forward(struct nvmet_req *req)
+{
+	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_STATUS_DNR);
+}
+static inline u8 nvmet_fdp_write_stream(struct nvmet_req *req)
+{
+	return 0;
+}
 #endif
 
 /*
-- 
2.43.7


