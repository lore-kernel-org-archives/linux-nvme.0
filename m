Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6D8606A31A
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 12:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=kxKekyN9;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OpLj81cb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=MkW51IfexOfVsGQLsaK30pOQvviRRu6RMhnTTUoE7K0=; b=kxKekyN9YbhEZY
	krsXKhET0VoilxLX8QiSt7q3F2Kj3ZPp8zj4UmE6hTwG2dM8kl8XxdMjkMQCh+ORZOVkWoPSgG8fY
	C7OMsGvd2M2+jxwHIfHTF+DIKT9odRvybBEGRHkcci6OB3rxitgooqwrwLFIxOoV5UQD81TyjHDBj
	Rr1vQsf7E5tr+OIBJtigkMU+w7z/q7bR3upQPfGZgQiWXH2zo2DOcf69XZImeZ7JqMwFL8C6zOZ8y
	y5xqXHQJ3R0Eh6NPmz+zbj8bw8E+fKRupSOu1RD0+DO+XSVcrSGruRWpd+ZVK7vu9kUB2DmtX7XEM
	3j/TRpvW9qYCOy5qN0Hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPG2-000000099Vg-0giQ;
	Thu, 29 Oct 2026 12:29:26 +0000
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPFy-000000099Im-0cQL
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 12:29:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793276958; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=MkW51IfexOfVsGQLsaK30pOQvviRRu6RMhnTTUoE7K0=;
	b=OpLj81cbMYYr7qjtwsmQTX5pGCJodiyHBUj+g40TPLLma7J+tQEbQCzSBLtwP3m/InpiQzpNP1+Qt1BYGrv6L6CRN9KAs1feX7qf/Mfh4jS2LGFEWxWmF1Gc35KaQPFWsWJOB/1eMTRsRQFPSd37BNPv0Yg+XUrwmKXP5ZdGjME=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XDjOyda_1793276957;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XDjOyda_1793276957 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 29 Oct 2026 20:29:17 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v3 10/12] nvmet: serve the FDP log pages
Date: Thu, 29 Oct 2026 20:28:31 +0800
Message-ID: <20261029122833.284572-11-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261029122833.284572-1-kanie@linux.alibaba.com>
References: <20261029122833.284572-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_052922_511862_787408BA 
X-CRM114-Status: GOOD (  18.89  )
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
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
handles, the handle types and the reclaim unit nominal size
reported by the backing device.  The page is addressed by the Endurance
Group Identifier in the Log Specific Identifier field.  Hosts first
request the 16 byte header to learn the page size and then the full
page; both request sizes are served from the same construction path.
Short reads and nonzero Log Page Offsets are served as windows of
the complete page, and a zero length forward is rejected so that no
command can reach the backing controller without a staging buffer.

The remaining pages are owned by the backing controller and are
forwarded to it over its admin queue, addressed by the Endurance
Group Identifier of the backing endurance group, so hosts read the
real reclaim unit handle usage, counters and events of the backing
device.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/admin-cmd.c |  16 ++++
 drivers/nvme/target/fdp.c       | 138 ++++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h     |  11 +++
 3 files changed, 165 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 523083eb0cee..e4efee44f5f4 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -220,6 +220,16 @@ static void nvmet_execute_get_supported_log_pages(struct nvmet_req *req)
 	logs->lids[NVME_LOG_FEATURES] = cpu_to_le32(NVME_LIDS_LSUPP);
 	logs->lids[NVME_LOG_RMI] = cpu_to_le32(NVME_LIDS_LSUPP);
 	logs->lids[NVME_LOG_RESERVATION] = cpu_to_le32(NVME_LIDS_LSUPP);
+	if (nvmet_req_subsys(req)->nr_ns_fdp_enabled) {
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
@@ -654,6 +664,12 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
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
index f615b2bdc3d6..dbd0250a1ee6 100644
--- a/drivers/nvme/target/fdp.c
+++ b/drivers/nvme/target/fdp.c
@@ -542,3 +542,141 @@ static int nvmet_fdp_init_backend(struct nvmet_ns *ns)
 	kfree(id);
 	return ret;
 }
+
+static void nvmet_fdp_configs_work(struct nvmet_req *req)
+{
+	u32 lsi = le16_to_cpu(req->cmd->get_log_page.lsi);
+	u64 lpo = nvmet_get_log_page_offset(req->cmd);
+	struct nvme_fdp_config_desc *desc;
+	struct nvme_fdp_config_log *log;
+	size_t dsze, total, avail, len;
+	struct nvmet_ns *ns;
+	u16 status = 0;
+	int i;
+
+	if (req->transfer_len > NVMET_FDP_MAX_TRANSFER_SIZE) {
+		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+		goto out;
+	}
+
+	ns = nvmet_fdp_lookup_ns(req, lsi, true);
+	if (!ns) {
+		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+		goto out;
+	}
+
+	dsze = ALIGN(struct_size(desc, ruhs, ns->fdp.nruh), 8);
+	total = sizeof(*log) + dsze;
+	len = max(total, req->transfer_len);
+
+	/* single configuration, 0's based */
+	log = kzalloc(len, GFP_KERNEL);
+	if (!log) {
+		status = NVME_SC_INTERNAL;
+		goto out_put;
+	}
+
+	log->numfdpc = 0;
+	log->ver = 0;
+	log->sze = cpu_to_le32(total);
+	desc = (void *)(log + 1);
+	desc->dsze = cpu_to_le16(dsze);
+	/* FDPCV set, FDPVWC clear, RGIF 0 for the single RG */
+	desc->fdpa = 1 << 7;
+	desc->nrg = cpu_to_le32(1);
+	desc->nruh = cpu_to_le16(ns->fdp.nruh);
+	desc->maxpids = cpu_to_le16(ns->fdp.nruh - 1);
+	desc->nns = cpu_to_le32(1);
+	desc->runs = cpu_to_le64(ns->fdp.runs);
+	for (i = 0; i < ns->fdp.nruh; i++)
+		desc->ruhs[i].ruht = ns->fdp.ruht[i];
+
+	if (lpo >= total) {
+		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+		goto free_log;
+	}
+
+	/*
+	 * Serve the requested window of the complete log: a short read
+	 * gets the true prefix, and a nonzero Log Page Offset gets the
+	 * bytes at that offset, with zeroes only past the end of the log.
+	 */
+	avail = total - lpo;
+	memmove(log, (void *)log + lpo, avail);
+	memset((void *)log + avail, 0, len - avail);
+	status = nvmet_copy_to_sgl(req, 0, log, req->transfer_len);
+free_log:
+	kfree(log);
+out_put:
+	percpu_ref_put(&ns->ref);
+out:
+	nvmet_req_complete(req, status);
+}
+
+void nvmet_execute_get_log_page_fdp_configs(struct nvmet_req *req)
+{
+	nvmet_fdp_defer(req, nvmet_fdp_configs_work);
+}
+
+/*
+ * Forward an FDP log page that the backing controller owns, addressed
+ * by the Endurance Group Identifier of the backing endurance group.
+ */
+static void nvmet_fdp_log_forward_work(struct nvmet_req *req)
+{
+	struct nvme_command c = {};
+	struct nvmet_ns *ns;
+	u16 status = 0;
+	void *buf;
+	u32 numd;
+	int ret;
+
+	if (!req->transfer_len ||
+	    req->transfer_len > NVMET_FDP_MAX_TRANSFER_SIZE) {
+		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+		goto out;
+	}
+
+	ns = nvmet_fdp_lookup_ns(req,
+				 le16_to_cpu(req->cmd->get_log_page.lsi),
+				 true);
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
+	c.common.metadata = 0;
+	c.common.dptr = (union nvme_data_ptr){};
+	/* the backend must not transfer more than the staging buffer holds */
+	numd = nvme_bytes_to_numd(req->transfer_len);
+	c.get_log_page.numdl = cpu_to_le16(numd);
+	c.get_log_page.numdu = cpu_to_le16(numd >> 16);
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
+
+void nvmet_fdp_log_forward(struct nvmet_req *req)
+{
+	nvmet_fdp_defer(req, nvmet_fdp_log_forward_work);
+}
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 0a20c22b0b23..c61cfe66f336 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -1008,6 +1008,8 @@ u16 nvmet_set_feat_fdp(struct nvmet_req *req);
 u16 nvmet_get_feat_fdp(struct nvmet_req *req);
 void nvmet_execute_io_mgmt_recv(struct nvmet_req *req);
 void nvmet_execute_io_mgmt_send(struct nvmet_req *req);
+void nvmet_execute_get_log_page_fdp_configs(struct nvmet_req *req);
+void nvmet_fdp_log_forward(struct nvmet_req *req);
 #else
 static inline bool nvmet_fdp_enabled(struct nvmet_ns *ns)
 {
@@ -1036,6 +1038,15 @@ static inline void nvmet_execute_io_mgmt_send(struct nvmet_req *req)
 {
 	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_STATUS_DNR);
 }
+static inline void nvmet_execute_get_log_page_fdp_configs(
+		struct nvmet_req *req)
+{
+	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_STATUS_DNR);
+}
+static inline void nvmet_fdp_log_forward(struct nvmet_req *req)
+{
+	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_STATUS_DNR);
+}
 #endif
 
 /*
-- 
2.43.7


