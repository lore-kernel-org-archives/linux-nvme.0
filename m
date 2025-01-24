Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 835E3C02181
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jan 2025 07:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=I90cSkW2vWibvVYymjY+BtOCZ3uAaG1vkgyo3121g3k=; b=3lvSBtu2BYd96TXoF7vsbTjOSw
	Tne3c1ExNVEcc8lTHh4Eeh3RDH7iiAMZdZr5rUVKaUuNSbLeI4GS0aqKsX++Djn1nVg8CJwia1QZv
	MBEkHvARAkWHOrgEyvKl8KlDKhzJV7nGjOo0bzW+Sb2YM5N5lpYGfZGg2hxUA8D602C4vht4cBRE5
	7+nmE9b00lVYgBiX3jAmLBuwGB/f51jiqQDwSpsJGAAl35szJIrTnUDA020tszG9+Ofgio3Uas57Q
	oIVKM80vQ5xZ7i3wsbUkLUvmwMYIla1BoQscDfXOb6TRbWbM9z0VaGKu4JN/GmE1Dfu/YzQnbbf16
	V41tBBiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tbDtx-0000000E5YM-305I;
	Fri, 24 Jan 2025 07:14:49 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tbDtv-0000000E5Xg-1mbB
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jan 2025 07:14:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 151A4A40CFB;
	Fri, 24 Jan 2025 07:12:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A87C4CED2;
	Fri, 24 Jan 2025 07:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737702886;
	bh=KSJk9o+GXI4JiPacn7UHqRgNI2yPzJFpr9ik4x1KU+Y=;
	h=From:To:Cc:Subject:Date:From;
	b=fLV3VmfKjdMBExiSiZfkWWRRwTTpzaXLCsYO1a349VDcOUFnfi4Kpw2DPIIv2yAmL
	 VH31prQExZgu0jCAiHHhDub40pwugLoMpNeb9CysZ3YLlJ3dUVLtj+m6qQ8cUdGbVV
	 ynbtXEcMwz5sSpp1LyJGBHC9EaUJ5mKZ5wUBRfCyiq53s7y7TPuCRTUEoBszKW315S
	 WPHb1ZaxkcJdN+0l9FbGzf2FqZo5Uo6nOavNmX8VefLHNkHJ8vKO+7Lbg6vnllvaz7
	 lYDo90ESSPEdorQAe9GJHjEUxSJe5GoCY12CfjhdY0SzpLvCDckmqlQ5weWmyCUo2e
	 oVMRUpaYnSZqQ==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH] nvme-multipath: fix lockdep warning on shutdown
Date: Fri, 24 Jan 2025 08:14:39 +0100
Message-Id: <20250124071439.106663-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250123_231447_600471_1945DF4A 
X-CRM114-Status: GOOD (  16.62  )
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

From: Hannes Reinecke <hare@kernel.org>

During shutdown of multipath devices lockdep complained about a
potential circular locking:

WARNING: possible circular locking dependency detected
(udev-worker)/2792 is trying to acquire lock:
ffff8881012a4348 ((wq_completion)kblockd){+.+.}-{0:0}, at: touch_wq_lockdep_map+0
x26/0x90

but task is already holding lock:
ffff88811e4b7cc8 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_release+0x61/0x1a0
which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:
-> #2 (&disk->open_mutex){+.+.}-{4:4}:
        __mutex_lock+0xa5/0xe00
       nvme_partition_scan_work+0x31/0x60
        process_scheduled_works+0x37c/0x6f0
-> #1 ((work_completion)(&head->partition_scan_work)){+.+.}-{0:0}:
        process_scheduled_works+0x348/0x6f0
        worker_thread+0x127/0x2a0
-> #0 ((wq_completion)kblockd){+.+.}-{0:0}:
        __lock_acquire+0x11f9/0x1790
        lock_acquire+0x245/0x2d0
        touch_wq_lockdep_map+0x3b/0x90
        __flush_work+0x240/0x4b0
        nvme_mpath_remove_disk+0x2b/0x50
        nvme_free_ns_head+0x19/0x90

So the problem is that nvme_mpath_remove_disk() is called with the
disk->open_mutex held, hence calling flush_work on partition_scan_work
(which also will try to lock disk->open_mutex) will deadlock.
Fix this by checking for NVME_NSHEAD_DISK_LIVE before trying to lock
disk->open_mutex.

Fixes: 1f021341eef4 ("nvme-multipath: defer partition scanning")

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 block/blk-ioprio.c                |  6 ++++-
 drivers/nvme/host/multipath.c     |  2 ++
 drivers/nvme/target/core.c        | 42 +++++++++++++++----------------
 drivers/nvme/target/io-cmd-bdev.c |  9 +++++++
 4 files changed, 37 insertions(+), 22 deletions(-)

diff --git a/block/blk-ioprio.c b/block/blk-ioprio.c
index 8fff7ccc0ac7..9f1b2069a3c9 100644
--- a/block/blk-ioprio.c
+++ b/block/blk-ioprio.c
@@ -141,9 +141,13 @@ static struct blkcg_policy ioprio_policy = {
 
 void blkcg_set_ioprio(struct bio *bio)
 {
-	struct ioprio_blkcg *blkcg = blkcg_to_ioprio_blkcg(bio->bi_blkg->blkcg);
+	struct ioprio_blkcg *blkcg;
 	u16 prio;
 
+	if (WARN_ON(!bio->bi_blkg || ! bio->bi_blkg->blkcg))
+		return;
+
+	blkcg = blkcg_to_ioprio_blkcg(bio->bi_blkg->blkcg);
 	if (!blkcg || blkcg->prio_policy == POLICY_NO_CHANGE)
 		return;
 
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index a85d190942bd..af763ac4d657 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -593,6 +593,8 @@ static void nvme_partition_scan_work(struct work_struct *work)
 	if (WARN_ON_ONCE(!test_and_clear_bit(GD_SUPPRESS_PART_SCAN,
 					     &head->disk->state)))
 		return;
+	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
+		return;
 
 	mutex_lock(&head->disk->open_mutex);
 	bdev_disk_changed(head->disk, false);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 78ba6162361a..5f7b5d1f78c0 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -423,20 +423,37 @@ void nvmet_stop_keep_alive_timer(struct nvmet_ctrl *ctrl)
 	cancel_delayed_work_sync(&ctrl->ka_work);
 }
 
+static inline u16 nvmet_check_ana_state(struct nvmet_port *port,
+		struct nvmet_ns *ns)
+{
+	enum nvme_ana_state state = port->ana_state[ns->anagrpid];
+
+	if (unlikely(state == NVME_ANA_INACCESSIBLE))
+		return NVME_SC_ANA_INACCESSIBLE;
+	if (unlikely(state == NVME_ANA_PERSISTENT_LOSS))
+		return NVME_SC_ANA_PERSISTENT_LOSS;
+	if (unlikely(state == NVME_ANA_CHANGE))
+		return NVME_SC_ANA_TRANSITION;
+	return 0;
+}
+
 u16 nvmet_req_find_ns(struct nvmet_req *req)
 {
 	u32 nsid = le32_to_cpu(req->cmd->common.nsid);
 	struct nvmet_subsys *subsys = nvmet_req_subsys(req);
+	u16 status = 0;
 
 	req->ns = xa_load(&subsys->namespaces, nsid);
 	if (unlikely(!req->ns || !req->ns->enabled)) {
 		req->error_loc = offsetof(struct nvme_common_command, nsid);
 		if (!req->ns) /* ns doesn't exist! */
 			return NVME_SC_INVALID_NS | NVME_STATUS_DNR;
-
-		/* ns exists but it's disabled */
+		status = nvmet_check_ana_state(req->port, req->ns);
+		if (!status)
+			/* ns exists but it's disabled */
+			status = NVME_SC_INTERNAL_PATH_ERROR;
 		req->ns = NULL;
-		return NVME_SC_INTERNAL_PATH_ERROR;
+		return status;
 	}
 
 	percpu_ref_get(&req->ns->ref);
@@ -965,20 +982,6 @@ int nvmet_sq_init(struct nvmet_sq *sq)
 }
 EXPORT_SYMBOL_GPL(nvmet_sq_init);
 
-static inline u16 nvmet_check_ana_state(struct nvmet_port *port,
-		struct nvmet_ns *ns)
-{
-	enum nvme_ana_state state = port->ana_state[ns->anagrpid];
-
-	if (unlikely(state == NVME_ANA_INACCESSIBLE))
-		return NVME_SC_ANA_INACCESSIBLE;
-	if (unlikely(state == NVME_ANA_PERSISTENT_LOSS))
-		return NVME_SC_ANA_PERSISTENT_LOSS;
-	if (unlikely(state == NVME_ANA_CHANGE))
-		return NVME_SC_ANA_TRANSITION;
-	return 0;
-}
-
 static inline u16 nvmet_io_cmd_check_access(struct nvmet_req *req)
 {
 	if (unlikely(req->ns->readonly)) {
@@ -1040,14 +1043,11 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 		return nvmet_parse_passthru_io_cmd(req);
 
 	ret = nvmet_req_find_ns(req);
-	if (unlikely(ret))
-		return ret;
-
-	ret = nvmet_check_ana_state(req->port, req->ns);
 	if (unlikely(ret)) {
 		req->error_loc = offsetof(struct nvme_common_command, nsid);
 		return ret;
 	}
+
 	ret = nvmet_io_cmd_check_access(req);
 	if (unlikely(ret)) {
 		req->error_loc = offsetof(struct nvme_common_command, nsid);
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 2b09b2c69857..4533e9997c7e 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -285,8 +285,16 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 		bio_init(bio, req->ns->bdev, req->inline_bvec,
 			 ARRAY_SIZE(req->inline_bvec), opf);
 	} else {
+		if (!req->ns->enabled) {
+			nvmet_req_complete(req, NVME_SC_INTERNAL_PATH_ERROR);
+			return;
+		}
 		bio = bio_alloc(req->ns->bdev, bio_max_segs(sg_cnt), opf,
 				GFP_KERNEL);
+		if (!bio) {
+			nvmet_req_complete(req, NVME_SC_INTERNAL);
+			return;
+		}
 	}
 	bio->bi_iter.bi_sector = sector;
 	bio->bi_private = req;
@@ -313,6 +321,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 
 			bio = bio_alloc(req->ns->bdev, bio_max_segs(sg_cnt),
 					opf, GFP_KERNEL);
+			WARN_ON(!bio);
 			bio->bi_iter.bi_sector = sector;
 
 			bio_chain(bio, prev);
-- 
2.35.3


