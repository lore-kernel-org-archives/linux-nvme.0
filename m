Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17461C982FA
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2026 12:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=a/jO7u2J+j0Rg2I8epUbqA0H0qDpx3zTqWPn7IlamBI=; b=20Cvw4T1PnFCALisSblyPgvjPX
	dYgU/pIwm1Zn3WJBq5oHlNwdf8Lb50qtcqnO2RmpzBXH/1fQ12d3PWhoiUyPm0jp5C/zuWv0P/rGB
	jtOGg8D8fjmh/XoHkOUHoK7DDVCWZgiH/jXbtdzQIDuUdPfoJoLuBVfxU5iJAexp3kSNzzOaUgbxJ
	u2i94zYauN7qHc0jOLvTe0Y2sQ9SYtVLMqfJMIqeyK0BDs0IgWhAEzFe7l3VTwwRnDg8D/Kdiowa4
	fXxphZVUnacl+sutNYSOPK20DHNN5Zzao7m8MJKA3GOMd8DoLkzOIy4Gojs/c8bjCNBL8D/tTADXP
	9H1Qqqig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8zs1-00000005LXL-1xNP;
	Tue, 22 Sep 2026 12:45:13 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8zry-00000005LW3-3faj
	for linux-nvme@lists.infradead.org;
	Tue, 22 Sep 2026 12:45:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1790081111; x=1821617111;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=i6jeDc3B6zH/Erp5ru49ZC4Qt6oixSSO86Prsl+Gb0Y=;
  b=p1VknQavg9zMeexVPfSsYYSjpgEC+akk6W9Pq0TqQr3sgqg36G+poYVb
   ZTEJsdYpA1gkLmvx45S4FQsDgwQn9rm3fuVpL0B6FYY/jl8KUieVFGPAK
   axogAjt+zxuXZThUQC/2k2sMHiu8b008jvJD4nXKADbkNsCWql4kCDW/S
   NB1YpP2WkQbscsNpwO3N9d2dZ+gvBFJhUISpStj2IInEgVepo4faFRyTh
   v65Mx73BE3J+xc5uzCHvnR+7U2GjnqbKZLe+yA8QotKUpwq21XtqLVEGd
   qaBh6QdSmYubxbwf+jQHHUF8DvW5oelXkSewWlrghfovRfKHl82zsJAKX
   A==;
X-CSE-ConnectionGUID: LkDh33xeTeGdvYThL5ks6A==
X-CSE-MsgGUID: ouXBj6e/Qsa+89cau8+tBA==
X-IronPort-AV: E=Sophos;i="6.27,116,1786982400"; 
   d="scan'208";a="156271928"
Received: from unknown (HELO uls-op-esad1-o.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Sep 2026 20:45:10 +0800
X-CSE-ConnectionGUID: Ik39VdufSYGl98iHGIQrwA==
X-CSE-MsgGUID: RE6Tvo+iQEueQkX36Mh/OQ==
IronPort-SDR: 6ab27841_iLagrK4WpHpRyO91SSUmtxp7aZtNgl4KoFRrEjKBo1xh8BB
 LxHdvv79tvwaI6TwcyJjLQ3nG1c6zVR2tj+PvgQ==
Received: from uls-op-esai2-o.wdc.com ([10.248.3.38])
  by uls-op-esad1-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Sep 2026 05:44:49 -0700
X-CSE-ConnectionGUID: A5qPXATHRGGVq5O0zt4GoA==
X-CSE-MsgGUID: fcThb6BCT+ST1CIBI4+wWQ==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-esai2-o.wdc.com with ESMTP; 22 Sep 2026 05:44:49 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@opensource.wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Surabhi Gogte <sgogte@purestorage.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] nvmet-rdma: handle commands of established queue outside the CM handler
Date: Tue, 22 Sep 2026 21:44:47 +0900
Message-ID: <20260922124447.588057-1-shinichiro.kawasaki@opensource.wdc.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_054510_943060_3F1BEC29 
X-CRM114-Status: GOOD (  21.80  )
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

From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

The commit 2a8513091d2f ("nvme-rdma: parallelize I/O queue allocation
and startup") modified the timing of command handling. The commands
queued before the establishment are kept in &queue->rsp_wait_list. After
the commit, the commands are executed in the rdma_cm handler, which
holds id_priv->handler_mutex. The command execution takes nvmet locks
such as nvmet_config_sem. This inverts the lock order in
nvmet_port_subsys_drop_link(), which calls rdma_destroy_id() through
nvmet_disable_port() under the nvmet_config_sem lock. This results in
the lockdep WARN below:

    WARNING: possible circular locking dependency detected
    rm/7346 is trying to acquire lock:
     (&id_priv->handler_mutex){+.+.}-{4:4}, at: rdma_destroy_id+0x17/0x20 [rdma_cm]
    but task is already holding lock:
     (nvmet_config_sem){++++}-{4:4}, at: nvmet_port_subsys_drop_link+0x52/0x340 [nvmet]

    -> #1 (nvmet_config_sem){++++}-{4:4}:
           down_read+0xa6/0x530
           nvmet_find_get_subsys+0x1f4/0x630 [nvmet]
           nvmet_ctrl_find_get+0xaa/0x320 [nvmet]
           nvmet_execute_io_connect+0x1e0/0x480 [nvmet]
           nvmet_rdma_execute_command+0x18e/0x480 [nvmet_rdma]
           nvmet_rdma_handle_command+0x428/0xb30 [nvmet_rdma]
           nvmet_rdma_cm_handler+0x8a8/0x30f0 [nvmet_rdma]
           cma_cm_event_handler+0xb0/0x3c0 [rdma_cm]
           cma_ib_handler+0x28a/0x9b0 [rdma_cm]
           cm_process_work+0x4b/0x3e0 [ib_cm]
           cm_work_handler+0x2485/0xac10 [ib_cm]

    -> #0 (&id_priv->handler_mutex){+.+.}-{4:4}:
           rdma_destroy_id+0x17/0x20 [rdma_cm]
           nvmet_rdma_disable_port+0x44/0x300 [nvmet_rdma]
           nvmet_rdma_remove_port+0x42/0x60 [nvmet_rdma]
           nvmet_disable_port+0x120/0x1f0 [nvmet]
           nvmet_port_subsys_drop_link+0x261/0x340 [nvmet]
           configfs_unlink+0x36d/0x790
           vfs_unlink+0x278/0xb40
           filename_unlinkat+0x31d/0x670
           __x64_sys_unlinkat+0xae/0x100

    other info that might help us debug this:

     Possible unsafe locking scenario:

           CPU0                    CPU1
           ----                    ----
      lock(nvmet_config_sem);
                                   lock(&id_priv->handler_mutex);
                                   lock(nvmet_config_sem);
      lock(&id_priv->handler_mutex);

     *** DEADLOCK ***

This WARN can be recreated by repeating the blktests test case nvme/004
or nvme/031 for rdma transport and rxe driver.

To avoid the lockdep WARN, handle the commands of established queue
outside the CM handler. Add a work item nvmet_rdma_establish_queue_work,
and schedule it from nvmet_rdma_queue_established() that holds
id_priv->handler_mutex. The work executes the commands, and changes the
queue state to LIVE. By doing this, the lock order is no longer
inverted.

Fixes: 2a8513091d2f ("nvme-rdma: parallelize I/O queue allocation and startup")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/nvme/target/rdma.c | 42 +++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index ffa1e172c259..95c27eba816c 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -104,6 +104,7 @@ struct nvmet_rdma_queue {
 	struct nvmet_rdma_cmd	*cmds;
 
 	struct work_struct	release_work;
+	struct work_struct	establish_work;
 	struct list_head	rsp_wait_list;
 	struct list_head	rsp_wr_wait_list;
 	spinlock_t		rsp_wr_wait_lock;
@@ -170,6 +171,7 @@ static void nvmet_rdma_read_data_done(struct ib_cq *cq, struct ib_wc *wc);
 static void nvmet_rdma_write_data_done(struct ib_cq *cq, struct ib_wc *wc);
 static void nvmet_rdma_qp_event(struct ib_event *event, void *priv);
 static void nvmet_rdma_queue_disconnect(struct nvmet_rdma_queue *queue);
+static void nvmet_rdma_establish_queue_work(struct work_struct *work);
 static void nvmet_rdma_free_rsp(struct nvmet_rdma_device *ndev,
 				struct nvmet_rdma_rsp *r);
 static int nvmet_rdma_alloc_rsp(struct nvmet_rdma_device *ndev,
@@ -1380,6 +1382,7 @@ static void nvmet_rdma_free_queue(struct nvmet_rdma_queue *queue)
 {
 	pr_debug("freeing queue %d\n", queue->idx);
 
+	cancel_work_sync(&queue->establish_work);
 	nvmet_sq_destroy(&queue->nvme_sq);
 	nvmet_cq_put(&queue->nvme_cq);
 
@@ -1481,6 +1484,7 @@ nvmet_rdma_alloc_queue(struct nvmet_rdma_device *ndev,
 	 * inside a CM callback would trigger a deadlock. (great API design..)
 	 */
 	INIT_WORK(&queue->release_work, nvmet_rdma_release_queue_work);
+	INIT_WORK(&queue->establish_work, nvmet_rdma_establish_queue_work);
 	queue->dev = ndev;
 	queue->cm_id = cm_id;
 	queue->port = port->nport;
@@ -1658,18 +1662,20 @@ static int nvmet_rdma_queue_connect(struct rdma_cm_id *cm_id,
 	return ret;
 }
 
-static void nvmet_rdma_queue_established(struct nvmet_rdma_queue *queue)
+/*
+ * Execute the commands which were received before the queue became LIVE and
+ * then move the queue to the LIVE state.
+ */
+static void nvmet_rdma_establish_queue_work(struct work_struct *work)
 {
+	struct nvmet_rdma_queue *queue =
+		container_of(work, struct nvmet_rdma_queue, establish_work);
 	unsigned long flags;
 
 	spin_lock_irqsave(&queue->state_lock, flags);
-	if (queue->state != NVMET_RDMA_Q_CONNECTING) {
-		pr_warn("trying to establish a connected queue\n");
-		goto out_unlock;
-	}
-	queue->state = NVMET_RDMA_Q_LIVE;
 
-	while (!list_empty(&queue->rsp_wait_list)) {
+	while (queue->state == NVMET_RDMA_Q_CONNECTING &&
+	       !list_empty(&queue->rsp_wait_list)) {
 		struct nvmet_rdma_rsp *cmd;
 
 		cmd = list_first_entry(&queue->rsp_wait_list,
@@ -1681,6 +1687,28 @@ static void nvmet_rdma_queue_established(struct nvmet_rdma_queue *queue)
 		spin_lock_irqsave(&queue->state_lock, flags);
 	}
 
+	if (queue->state == NVMET_RDMA_Q_CONNECTING)
+		queue->state = NVMET_RDMA_Q_LIVE;
+
+	spin_unlock_irqrestore(&queue->state_lock, flags);
+}
+
+static void nvmet_rdma_queue_established(struct nvmet_rdma_queue *queue)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&queue->state_lock, flags);
+	if (queue->state != NVMET_RDMA_Q_CONNECTING) {
+		pr_warn("trying to establish a connected queue\n");
+		goto out_unlock;
+	}
+
+	/*
+	 * Defer the command execution and the transition to the LIVE state to
+	 * nvmet_wq. This avoids acquiring nvmet locks here.
+	 */
+	queue_work(nvmet_wq, &queue->establish_work);
+
 out_unlock:
 	spin_unlock_irqrestore(&queue->state_lock, flags);
 }
-- 
2.54.0


