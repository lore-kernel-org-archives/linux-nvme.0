Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 947D5D44150
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Nov 2024 12:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hUzFZ+6FshEO8qDOzDKYYt7UzsaW6ENPIVFJY3i4Ksc=; b=03+SlBpuCH2da3o90117MCJU8R
	45mCvHcWnsCB3Tvs+8ZQQ2ffnJzxQMRYWbNDpdxSg188iCoWnwzX69gqENTw//GhgXH/6M1xgSINH
	npBd88jwXKtvT8YjDYAZt0I0nP53qO8qpGu1HD9KvaNOWGEN2S1qeLXwjFWK7FxjMee3e60E9Kd2D
	TJOgvT6aFrCWvIB0/5ofr9hDmdYg7i3hJKhsFSJbkKDO5/xIf1aDCaXkzXZHIBiUH7Lj6bkRj/KTX
	wUWiTLmQ+S30Wq9ft1iQi9yqT4eelamK+MbXlNdx2SUbF6iLOfxtsRWNu0tkEdK6E8wCnPsvZ4yc3
	6MBevaJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDNAU-0000000CJPH-2ssh;
	Tue, 19 Nov 2024 12:17:18 +0000
Received: from 2a02-8389-2341-5b80-1731-a089-d2b1-3edf.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:1731:a089:d2b1:3edf] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDNAR-0000000CJMO-0zoF;
	Tue, 19 Nov 2024 12:17:15 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Hui Qi <hui81.qi@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Jan Kara <jack@suse.cz>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: [PATCH 14/15] nvme: enable FDP support
Date: Tue, 19 Nov 2024 13:16:28 +0100
Message-ID: <20241119121632.1225556-15-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241119121632.1225556-1-hch@lst.de>
References: <20241119121632.1225556-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Wire up the block level write streams to the NVMe Flexible Data Placement
(FDP) feature as ratified in TP 4146a.

Based on code from Kanchan Joshi <joshi.k@samsung.com>,
Hui Qi <hui81.qi@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com> and
Keith Busch <kbusch@kernel.org>, but a lot of it has been rewritten to
fit the block layer write stream infrastructure.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 129 +++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |   4 ++
 2 files changed, 133 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b61225201b47..543bbe7de063 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -673,6 +673,7 @@ static void nvme_free_ns_head(struct kref *ref)
 	ida_free(&head->subsys->ns_ida, head->instance);
 	cleanup_srcu_struct(&head->srcu);
 	nvme_put_subsystem(head->subsys);
+	kfree(head->plids);
 	kfree(head);
 }
 
@@ -990,6 +991,15 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 	if (req->cmd_flags & REQ_RAHEAD)
 		dsmgmt |= NVME_RW_DSM_FREQ_PREFETCH;
 
+	if (op == nvme_cmd_write && ns->head->nr_plids) {
+		u16 write_stream = req->bio->bi_write_stream;
+
+		if (WARN_ON_ONCE(write_stream > ns->head->nr_plids))
+			return BLK_STS_INVAL;
+		dsmgmt |= ns->head->plids[write_stream - 1] << 16;
+		control |= NVME_RW_DTYPE_DPLCMT;
+	}
+
 	if (req->cmd_flags & REQ_ATOMIC && !nvme_valid_atomic_write(req))
 		return BLK_STS_INVAL;
 
@@ -2142,6 +2152,107 @@ static int nvme_update_ns_info_generic(struct nvme_ns *ns,
 	return ret;
 }
 
+static int nvme_read_fdp_config(struct nvme_ns *ns, struct nvme_ns_info *info)
+{
+	struct nvme_fdp_config result;
+	struct nvme_fdp_config_log *log;
+	struct nvme_fdp_config_desc *configs;
+	size_t log_size;
+	int error;
+
+	error = nvme_get_features(ns->ctrl, NVME_FEAT_FDP, info->endgid, NULL,
+			0, &result);
+	if (error)
+		return error;
+
+	if (!(result.flags & FDPCFG_FDPE)) {
+		dev_warn(ns->ctrl->device, "FDP not enable in current config\n");
+		return -EINVAL;
+	}
+
+	log_size = sizeof(*log) + (result.fdpcidx + 1) * sizeof(*configs);
+	log = kmalloc(log_size, GFP_KERNEL);
+	if (!log)
+		return -ENOMEM;
+
+	error = nvme_get_log_lsi(ns->ctrl, info->nsid, NVME_LOG_FDP_CONFIGS,
+			0, 0, log, log_size, 0, info->endgid);
+	if (error) {
+		dev_warn(ns->ctrl->device,
+			"failed to read FDP config log: 0x%x\n", error);
+		goto out_free_log;
+	}
+
+	if (le32_to_cpu(log->size) < log_size) {
+		dev_warn(ns->ctrl->device, "FDP log too small: %d vs %zd\n",
+				le32_to_cpu(log->size), log_size);
+		error = -EINVAL;
+		goto out_free_log;
+	}
+
+	configs = (struct nvme_fdp_config_desc *)(log + 1);
+	if (le32_to_cpu(configs[result.fdpcidx].nrg) > 1) {
+		dev_warn(ns->ctrl->device, "FDP NRG > 1 not supported\n");
+		return -EINVAL;
+	}
+	ns->head->runs = le64_to_cpu(configs[result.fdpcidx].runs);
+
+out_free_log:
+	kfree(log);
+	return error;
+}
+
+static int nvme_fetch_fdp_plids(struct nvme_ns *ns, u32 nsid)
+{
+	struct nvme_ns_head *head = ns->head;
+	struct nvme_fdp_ruh_status *ruhs;
+	const unsigned int max_nr_plids = S8_MAX - 1;
+	size_t size = struct_size(ruhs, ruhsd, max_nr_plids);
+	struct nvme_command c = {
+		.imr.opcode	= nvme_cmd_io_mgmt_recv,
+		.imr.nsid	= cpu_to_le32(nsid),
+		.imr.mo		= NVME_IO_MGMT_RECV_MO_RUHS,
+		.imr.numd	= cpu_to_le32(nvme_bytes_to_numd(size)),
+	};
+	int ret, i;
+
+	ruhs = kzalloc(size, GFP_KERNEL);
+	if (!ruhs)
+		return -ENOMEM;
+
+	ret = nvme_submit_sync_cmd(ns->queue, &c, ruhs, size);
+	if (ret) {
+		dev_warn(ns->ctrl->device,
+			"failed to read FDP reclaim unit handles: 0x%x\n", ret);
+		goto out;
+	}
+
+	ns->head->nr_plids = le16_to_cpu(ruhs->nruhsd);
+	if (!ns->head->nr_plids)
+		goto out;
+
+	if (ns->head->nr_plids > max_nr_plids) {
+		dev_info(ns->ctrl->device,
+			"capping max write streams from %d to %d\n",
+			ns->head->nr_plids, max_nr_plids);
+		ns->head->nr_plids = max_nr_plids;
+	}
+
+	head->plids = kcalloc(ns->head->nr_plids, sizeof(head->plids),
+			      GFP_KERNEL);
+	if (!head->plids) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	for (i = 0; i < ns->head->nr_plids; i++)
+		head->plids[i] = le16_to_cpu(ruhs->ruhsd[i].pid);
+
+out:
+	kfree(ruhs);
+	return ret;
+}
+
 static int nvme_update_ns_info_block(struct nvme_ns *ns,
 		struct nvme_ns_info *info)
 {
@@ -2178,6 +2289,18 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 			goto out;
 	}
 
+	if (!(ns->ctrl->ctratt & NVME_CTRL_ATTR_FDPS)) {
+		ns->head->nr_plids = 0;
+		kfree(ns->head->plids);
+		ns->head->plids = NULL;
+	} else if (!ns->head->plids) {
+		ret = nvme_read_fdp_config(ns, info);
+		if (!ret)
+			ret = nvme_fetch_fdp_plids(ns, info->nsid);
+		if (ret < 0)
+			goto out;
+	}
+
 	blk_mq_freeze_queue(ns->disk->queue);
 	ns->head->lba_shift = id->lbaf[lbaf].ds;
 	ns->head->nuse = le64_to_cpu(id->nuse);
@@ -2211,6 +2334,10 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	if (!nvme_init_integrity(ns->head, &lim, info))
 		capacity = 0;
 
+	lim.max_write_streams = ns->head->nr_plids;
+	if (lim.max_write_streams)
+		lim.write_stream_granularity = ns->head->runs;
+
 	ret = queue_limits_commit_update(ns->disk->queue, &lim);
 	if (ret) {
 		blk_mq_unfreeze_queue(ns->disk->queue);
@@ -2313,6 +2440,8 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 			ns->head->disk->flags |= GENHD_FL_HIDDEN;
 		else
 			nvme_init_integrity(ns->head, &lim, info);
+		lim.max_write_streams = ns_lim->max_write_streams;
+		lim.write_stream_granularity = ns_lim->write_stream_granularity;
 		ret = queue_limits_commit_update(ns->head->disk->queue, &lim);
 
 		set_capacity_and_notify(ns->head->disk, get_capacity(ns->disk));
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 8cea8416b0d2..f10aa0cb6df5 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -493,6 +493,10 @@ struct nvme_ns_head {
 	struct gendisk		*disk;
 
 	u16			endgid;
+	u16                     nr_plids;
+	u16			*plids;
+	u64			runs;
+
 #ifdef CONFIG_NVME_MULTIPATH
 	struct bio_list		requeue_list;
 	spinlock_t		requeue_lock;
-- 
2.45.2


