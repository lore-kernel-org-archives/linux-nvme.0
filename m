Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03AA8C2BB3F
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Nov 2023 17:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DXx1kRcTuEFK4mccGqm5831VvuU1uPnHScDnHgpQHYA=; b=pJtzEv5A/X5Xk9tUhCdOW47Wh5
	3DC3hmXP45QLMCbPktSLCbyqGkMYIeUnRF6X/1+OcOfKCjFcx/kIw2KFmUN/+FCs5Cs/cLKv8zt8P
	K7NudCG4MXFuWuJT1NJlCrcL+jkPhtxQzw0VN0aBknbW9wTED/a8aOQOo05vs4SU6XBCvftQEAlDY
	AFp6mESZX6uAn/r/76iTukmpwIarNiqP9hHGnTV3VTUKpVRCQZDT1de/dzc6LqfPq95IA95tjKO/m
	4/s2RSpXPNiwubC4Tx36GyEK2r/pyjzDuAg7WHlXQUpbIwciBvhM2AR9diW255H2kECDjV6ZIp1w+
	NC/62dyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r58QA-00E2ZC-2r;
	Mon, 20 Nov 2023 17:50:54 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r58Q6-00E2SW-27
	for linux-nvme@lists.infradead.org;
	Mon, 20 Nov 2023 17:50:53 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKHZuOC007096
	for <linux-nvme@lists.infradead.org>; Mon, 20 Nov 2023 09:50:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=DXx1kRcTuEFK4mccGqm5831VvuU1uPnHScDnHgpQHYA=;
 b=c0GdWAAJRLivPtZN5Fy/zEefMT83Y8u9/B6cf48H9VcOqjCLLKyMGuzb7Wt1n19pQpja
 ihy1wIMa1j0GC4ImNWt/ALxieGzs4w1F6akSN2+9WBxG2IZONpnHkfJAUvpxJeUYfHBC
 fsBa7xx8h/VGWQqs4w1NyeDA2fRUb612+ofQM1ghiB0a/n4nXn+8rh2ErUadPuswE+M8
 rTkv3RoOiuN/EJ6b3V3h6zbxNSqM9S5S0VPJ5q1H1Bt4N5OCgB6XoV8eJsAD1bfJydfG
 N1Xa3YtJrCREWcwJL8Zpr0hQNdR1t3KPk1VB7zmwXKFPZKBqBas+UVbPFuco8n00IOhz KA== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ug8tpsnf9-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 20 Nov 2023 09:50:45 -0800
Received: from twshared32169.15.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 09:50:42 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 7CA7C21EF22AD; Mon, 20 Nov 2023 09:50:36 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>, Minh Hoang <mh2022@meta.com>
Subject: [PATCHv2 2/2] nvme: ensure reset state check ordering
Date: Mon, 20 Nov 2023 09:50:35 -0800
Message-ID: <20231120175035.978147-2-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120175035.978147-1-kbusch@meta.com>
References: <20231120175035.978147-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: o8UrMmDyMQAJcTwa1N2v2OGzcXsnHpBJ
X-Proofpoint-GUID: o8UrMmDyMQAJcTwa1N2v2OGzcXsnHpBJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_17,2023-11-20_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231120_095050_836778_15D5A550 
X-CRM114-Status: GOOD (  26.39  )
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

From: Keith Busch <kbusch@kernel.org>

A different CPU may be setting the ctrl->state value, so ensure proper
barriers to prevent optimizing to a stale state. Normally it isn't a
problem to observe the wrong state as it is merely advisory to take a
quicker path during initialization and error recovery, but seeing an old
state can report unexpected ENETRESET errors when a reset request was in
fact successful.

Reported-by: Minh Hoang <mh2022@meta.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 42 +++++++++++++++++++++-------------------
 drivers/nvme/host/fc.c   |  6 +++---
 drivers/nvme/host/pci.c  | 14 +++++++-------
 drivers/nvme/host/rdma.c | 23 +++++++++++++---------
 drivers/nvme/host/tcp.c  | 27 ++++++++++++++++----------
 5 files changed, 63 insertions(+), 49 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fd28e6b6574c0..524f2be472c02 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -131,7 +131,7 @@ void nvme_queue_scan(struct nvme_ctrl *ctrl)
 	/*
 	 * Only new queue scan work when admin and IO queues are both alive
 	 */
-	if (ctrl->state =3D=3D NVME_CTRL_LIVE && ctrl->tagset)
+	if (nvme_ctrl_state(ctrl) =3D=3D NVME_CTRL_LIVE && ctrl->tagset)
 		queue_work(nvme_wq, &ctrl->scan_work);
 }
=20
@@ -143,7 +143,7 @@ void nvme_queue_scan(struct nvme_ctrl *ctrl)
  */
 int nvme_try_sched_reset(struct nvme_ctrl *ctrl)
 {
-	if (ctrl->state !=3D NVME_CTRL_RESETTING)
+	if (nvme_ctrl_state(ctrl) !=3D NVME_CTRL_RESETTING)
 		return -EBUSY;
 	if (!queue_work(nvme_reset_wq, &ctrl->reset_work))
 		return -EBUSY;
@@ -156,7 +156,7 @@ static void nvme_failfast_work(struct work_struct *wo=
rk)
 	struct nvme_ctrl *ctrl =3D container_of(to_delayed_work(work),
 			struct nvme_ctrl, failfast_work);
=20
-	if (ctrl->state !=3D NVME_CTRL_CONNECTING)
+	if (nvme_ctrl_state(ctrl) !=3D NVME_CTRL_CONNECTING)
 		return;
=20
 	set_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
@@ -200,7 +200,7 @@ int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl)
 	ret =3D nvme_reset_ctrl(ctrl);
 	if (!ret) {
 		flush_work(&ctrl->reset_work);
-		if (ctrl->state !=3D NVME_CTRL_LIVE)
+		if (nvme_ctrl_state(ctrl) !=3D NVME_CTRL_LIVE)
 			ret =3D -ENETRESET;
 	}
=20
@@ -500,7 +500,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
=20
 	spin_lock_irqsave(&ctrl->lock, flags);
=20
-	old_state =3D ctrl->state;
+	old_state =3D nvme_ctrl_state(ctrl);
 	switch (new_state) {
 	case NVME_CTRL_LIVE:
 		switch (old_state) {
@@ -568,7 +568,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 	}
=20
 	if (changed) {
-		ctrl->state =3D new_state;
+		WRITE_ONCE(ctrl->state, new_state);
 		wake_up_all(&ctrl->state_wq);
 	}
=20
@@ -576,11 +576,11 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 	if (!changed)
 		return false;
=20
-	if (ctrl->state =3D=3D NVME_CTRL_LIVE) {
+	if (new_state =3D=3D NVME_CTRL_LIVE) {
 		if (old_state =3D=3D NVME_CTRL_CONNECTING)
 			nvme_stop_failfast_work(ctrl);
 		nvme_kick_requeue_lists(ctrl);
-	} else if (ctrl->state =3D=3D NVME_CTRL_CONNECTING &&
+	} else if (new_state =3D=3D NVME_CTRL_CONNECTING &&
 		old_state =3D=3D NVME_CTRL_RESETTING) {
 		nvme_start_failfast_work(ctrl);
 	}
@@ -593,7 +593,7 @@ EXPORT_SYMBOL_GPL(nvme_change_ctrl_state);
  */
 static bool nvme_state_terminal(struct nvme_ctrl *ctrl)
 {
-	switch (ctrl->state) {
+	switch (nvme_ctrl_state(ctrl)) {
 	case NVME_CTRL_NEW:
 	case NVME_CTRL_LIVE:
 	case NVME_CTRL_RESETTING:
@@ -618,7 +618,7 @@ bool nvme_wait_reset(struct nvme_ctrl *ctrl)
 	wait_event(ctrl->state_wq,
 		   nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING) ||
 		   nvme_state_terminal(ctrl));
-	return ctrl->state =3D=3D NVME_CTRL_RESETTING;
+	return nvme_ctrl_state(ctrl) =3D=3D NVME_CTRL_RESETTING;
 }
 EXPORT_SYMBOL_GPL(nvme_wait_reset);
=20
@@ -705,9 +705,11 @@ EXPORT_SYMBOL_GPL(nvme_init_request);
 blk_status_t nvme_fail_nonready_command(struct nvme_ctrl *ctrl,
 		struct request *rq)
 {
-	if (ctrl->state !=3D NVME_CTRL_DELETING_NOIO &&
-	    ctrl->state !=3D NVME_CTRL_DELETING &&
-	    ctrl->state !=3D NVME_CTRL_DEAD &&
+	enum nvme_ctrl_state state =3D nvme_ctrl_state(ctrl);
+
+	if (state !=3D NVME_CTRL_DELETING_NOIO &&
+	    state !=3D NVME_CTRL_DELETING &&
+	    state !=3D NVME_CTRL_DEAD &&
 	    !test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags) &&
 	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
 		return BLK_STS_RESOURCE;
@@ -737,7 +739,7 @@ bool __nvme_check_ready(struct nvme_ctrl *ctrl, struc=
t request *rq,
 		 * command, which is require to set the queue live in the
 		 * appropinquate states.
 		 */
-		switch (ctrl->state) {
+		switch (nvme_ctrl_state(ctrl)) {
 		case NVME_CTRL_CONNECTING:
 			if (blk_rq_is_passthrough(rq) && nvme_is_fabrics(req->cmd) &&
 			    (req->cmd->fabrics.fctype =3D=3D nvme_fabrics_type_connect ||
@@ -2530,7 +2532,7 @@ static void nvme_set_latency_tolerance(struct devic=
e *dev, s32 val)
=20
 	if (ctrl->ps_max_latency_us !=3D latency) {
 		ctrl->ps_max_latency_us =3D latency;
-		if (ctrl->state =3D=3D NVME_CTRL_LIVE)
+		if (nvme_ctrl_state(ctrl) =3D=3D NVME_CTRL_LIVE)
 			nvme_configure_apst(ctrl);
 	}
 }
@@ -3218,7 +3220,7 @@ static int nvme_dev_open(struct inode *inode, struc=
t file *file)
 	struct nvme_ctrl *ctrl =3D
 		container_of(inode->i_cdev, struct nvme_ctrl, cdev);
=20
-	switch (ctrl->state) {
+	switch (nvme_ctrl_state(ctrl)) {
 	case NVME_CTRL_LIVE:
 		break;
 	default:
@@ -3904,7 +3906,7 @@ static void nvme_scan_work(struct work_struct *work=
)
 	int ret;
=20
 	/* No tagset on a live ctrl means IO queues could not created */
-	if (ctrl->state !=3D NVME_CTRL_LIVE || !ctrl->tagset)
+	if (nvme_ctrl_state(ctrl) !=3D NVME_CTRL_LIVE || !ctrl->tagset)
 		return;
=20
 	/*
@@ -3974,7 +3976,7 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	 * removing the namespaces' disks; fail all the queues now to avoid
 	 * potentially having to clean up the failed sync later.
 	 */
-	if (ctrl->state =3D=3D NVME_CTRL_DEAD)
+	if (nvme_ctrl_state(ctrl) =3D=3D NVME_CTRL_DEAD)
 		nvme_mark_namespaces_dead(ctrl);
=20
 	/* this is a no-op when called from the controller reset handler */
@@ -4056,7 +4058,7 @@ static void nvme_async_event_work(struct work_struc=
t *work)
 	 * flushing ctrl async_event_work after changing the controller state
 	 * from LIVE and before freeing the admin queue.
 	*/
-	if (ctrl->state =3D=3D NVME_CTRL_LIVE)
+	if (nvme_ctrl_state(ctrl) =3D=3D NVME_CTRL_LIVE)
 		ctrl->ops->submit_async_event(ctrl);
 }
=20
@@ -4450,7 +4452,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct d=
evice *dev,
 {
 	int ret;
=20
-	ctrl->state =3D NVME_CTRL_NEW;
+	WRITE_ONCE(ctrl->state, NVME_CTRL_NEW);
 	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
 	spin_lock_init(&ctrl->lock);
 	mutex_init(&ctrl->scan_lock);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 49c3e46eaa1ee..1446149f5d0e1 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -557,7 +557,7 @@ nvme_fc_rport_get(struct nvme_fc_rport *rport)
 static void
 nvme_fc_resume_controller(struct nvme_fc_ctrl *ctrl)
 {
-	switch (ctrl->ctrl.state) {
+	switch (nvme_ctrl_state(&ctrl->ctrl)) {
 	case NVME_CTRL_NEW:
 	case NVME_CTRL_CONNECTING:
 		/*
@@ -793,7 +793,7 @@ nvme_fc_ctrl_connectivity_loss(struct nvme_fc_ctrl *c=
trl)
 		"NVME-FC{%d}: controller connectivity lost. Awaiting "
 		"Reconnect", ctrl->cnum);
=20
-	switch (ctrl->ctrl.state) {
+	switch (nvme_ctrl_state(&ctrl->ctrl)) {
 	case NVME_CTRL_NEW:
 	case NVME_CTRL_LIVE:
 		/*
@@ -3322,7 +3322,7 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ct=
rl, int status)
 	unsigned long recon_delay =3D ctrl->ctrl.opts->reconnect_delay * HZ;
 	bool recon =3D true;
=20
-	if (ctrl->ctrl.state !=3D NVME_CTRL_CONNECTING)
+	if (nvme_ctrl_state(&ctrl->ctrl) !=3D NVME_CTRL_CONNECTING)
 		return;
=20
 	if (portptr->port_state =3D=3D FC_OBJSTATE_ONLINE) {
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 507bc149046dc..fad4cccce745c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1233,7 +1233,7 @@ static bool nvme_should_reset(struct nvme_dev *dev,=
 u32 csts)
 	bool nssro =3D dev->subsystem && (csts & NVME_CSTS_NSSRO);
=20
 	/* If there is a reset/reinit ongoing, we shouldn't reset again. */
-	switch (dev->ctrl.state) {
+	switch (nvme_ctrl_state(&dev->ctrl)) {
 	case NVME_CTRL_RESETTING:
 	case NVME_CTRL_CONNECTING:
 		return false;
@@ -1321,7 +1321,7 @@ static enum blk_eh_timer_return nvme_timeout(struct=
 request *req)
 	 * cancellation error. All outstanding requests are completed on
 	 * shutdown, so we return BLK_EH_DONE.
 	 */
-	switch (dev->ctrl.state) {
+	switch (nvme_ctrl_state(&dev->ctrl)) {
 	case NVME_CTRL_CONNECTING:
 		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
 		fallthrough;
@@ -1593,7 +1593,7 @@ static int nvme_setup_io_queues_trylock(struct nvme=
_dev *dev)
 	/*
 	 * Controller is in wrong state, fail early.
 	 */
-	if (dev->ctrl.state !=3D NVME_CTRL_CONNECTING) {
+	if (nvme_ctrl_state(&dev->ctrl) !=3D NVME_CTRL_CONNECTING) {
 		mutex_unlock(&dev->shutdown_lock);
 		return -ENODEV;
 	}
@@ -2573,13 +2573,13 @@ static bool nvme_pci_ctrl_is_dead(struct nvme_dev=
 *dev)
=20
 static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 {
+	enum nvme_ctrl_state state =3D nvme_ctrl_state(&dev->ctrl);
 	struct pci_dev *pdev =3D to_pci_dev(dev->dev);
 	bool dead;
=20
 	mutex_lock(&dev->shutdown_lock);
 	dead =3D nvme_pci_ctrl_is_dead(dev);
-	if (dev->ctrl.state =3D=3D NVME_CTRL_LIVE ||
-	    dev->ctrl.state =3D=3D NVME_CTRL_RESETTING) {
+	if (state =3D=3D NVME_CTRL_LIVE || state =3D=3D NVME_CTRL_RESETTING) {
 		if (pci_is_enabled(pdev))
 			nvme_start_freeze(&dev->ctrl);
 		/*
@@ -2690,7 +2690,7 @@ static void nvme_reset_work(struct work_struct *wor=
k)
 	bool was_suspend =3D !!(dev->ctrl.ctrl_config & NVME_CC_SHN_NORMAL);
 	int result;
=20
-	if (dev->ctrl.state !=3D NVME_CTRL_RESETTING) {
+	if (nvme_ctrl_state(&dev->ctrl) !=3D NVME_CTRL_RESETTING) {
 		dev_warn(dev->ctrl.device, "ctrl state %d is not RESETTING\n",
 			 dev->ctrl.state);
 		result =3D -ENODEV;
@@ -3192,7 +3192,7 @@ static int nvme_suspend(struct device *dev)
 	nvme_wait_freeze(ctrl);
 	nvme_sync_queues(ctrl);
=20
-	if (ctrl->state !=3D NVME_CTRL_LIVE)
+	if (nvme_ctrl_state(ctrl) !=3D NVME_CTRL_LIVE)
 		goto unfreeze;
=20
 	/*
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index a7fea4cbacd75..2c9aafbaadb76 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -984,10 +984,11 @@ static void nvme_rdma_free_ctrl(struct nvme_ctrl *n=
ctrl)
=20
 static void nvme_rdma_reconnect_or_remove(struct nvme_rdma_ctrl *ctrl)
 {
+	enum nvme_ctrl_state state =3D nvme_ctrl_state(ctrl);
+
 	/* If we are resetting/deleting then do nothing */
-	if (ctrl->ctrl.state !=3D NVME_CTRL_CONNECTING) {
-		WARN_ON_ONCE(ctrl->ctrl.state =3D=3D NVME_CTRL_NEW ||
-			ctrl->ctrl.state =3D=3D NVME_CTRL_LIVE);
+	if (state !=3D NVME_CTRL_CONNECTING) {
+		WARN_ON_ONCE(state =3D=3D NVME_CTRL_NEW || state =3D=3D NVME_CTRL_LIVE=
);
 		return;
 	}
=20
@@ -1059,8 +1060,10 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_c=
trl *ctrl, bool new)
 		 * unless we're during creation of a new controller to
 		 * avoid races with teardown flow.
 		 */
-		WARN_ON_ONCE(ctrl->ctrl.state !=3D NVME_CTRL_DELETING &&
-			     ctrl->ctrl.state !=3D NVME_CTRL_DELETING_NOIO);
+		enum nvme_ctrl_state state =3D nvme_ctrl_state(ctrl);
+
+		WARN_ON_ONCE(state !=3D NVME_CTRL_DELETING &&
+			     state !=3D NVME_CTRL_DELETING_NOIO);
 		WARN_ON_ONCE(new);
 		ret =3D -EINVAL;
 		goto destroy_io;
@@ -1128,8 +1131,10 @@ static void nvme_rdma_error_recovery_work(struct w=
ork_struct *work)
=20
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
 		/* state change failure is ok if we started ctrl delete */
-		WARN_ON_ONCE(ctrl->ctrl.state !=3D NVME_CTRL_DELETING &&
-			     ctrl->ctrl.state !=3D NVME_CTRL_DELETING_NOIO);
+		enum nvme_ctrl_state state =3D nvme_ctrl_state(ctrl);
+
+		WARN_ON_ONCE(state !=3D NVME_CTRL_DELETING &&
+			     state !=3D NVME_CTRL_DELETING_NOIO);
 		return;
 	}
=20
@@ -1161,7 +1166,7 @@ static void nvme_rdma_wr_error(struct ib_cq *cq, st=
ruct ib_wc *wc,
 	struct nvme_rdma_queue *queue =3D wc->qp->qp_context;
 	struct nvme_rdma_ctrl *ctrl =3D queue->ctrl;
=20
-	if (ctrl->ctrl.state =3D=3D NVME_CTRL_LIVE)
+	if (nvme_ctrl_state(ctrl) =3D=3D NVME_CTRL_LIVE)
 		dev_info(ctrl->ctrl.device,
 			     "%s for CQE 0x%p failed with status %s (%d)\n",
 			     op, wc->wr_cqe,
@@ -1944,7 +1949,7 @@ static enum blk_eh_timer_return nvme_rdma_timeout(s=
truct request *rq)
 	dev_warn(ctrl->ctrl.device, "I/O %d QID %d timeout\n",
 		 rq->tag, nvme_rdma_queue_idx(queue));
=20
-	if (ctrl->ctrl.state !=3D NVME_CTRL_LIVE) {
+	if (nvme_ctrl_state(ctrl) !=3D NVME_CTRL_LIVE) {
 		/*
 		 * If we are resetting, connecting or deleting we should
 		 * complete immediately because we may block controller
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 6ed7948155174..a026a3281364f 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2155,10 +2155,11 @@ static void nvme_tcp_teardown_io_queues(struct nv=
me_ctrl *ctrl,
=20
 static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
 {
+	enum nvme_ctrl_state state =3D nvme_ctrl_state(ctrl);
+
 	/* If we are resetting/deleting then do nothing */
-	if (ctrl->state !=3D NVME_CTRL_CONNECTING) {
-		WARN_ON_ONCE(ctrl->state =3D=3D NVME_CTRL_NEW ||
-			ctrl->state =3D=3D NVME_CTRL_LIVE);
+	if (state !=3D NVME_CTRL_CONNECTING) {
+		WARN_ON_ONCE(state =3D=3D NVME_CTRL_NEW || state =3D=3D NVME_CTRL_LIVE=
);
 		return;
 	}
=20
@@ -2218,8 +2219,10 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *c=
trl, bool new)
 		 * unless we're during creation of a new controller to
 		 * avoid races with teardown flow.
 		 */
-		WARN_ON_ONCE(ctrl->state !=3D NVME_CTRL_DELETING &&
-			     ctrl->state !=3D NVME_CTRL_DELETING_NOIO);
+		enum nvme_ctrl_state state =3D nvme_ctrl_state(ctrl);
+
+		WARN_ON_ONCE(state !=3D NVME_CTRL_DELETING &&
+			     state !=3D NVME_CTRL_DELETING_NOIO);
 		WARN_ON_ONCE(new);
 		ret =3D -EINVAL;
 		goto destroy_io;
@@ -2282,8 +2285,10 @@ static void nvme_tcp_error_recovery_work(struct wo=
rk_struct *work)
=20
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
 		/* state change failure is ok if we started ctrl delete */
-		WARN_ON_ONCE(ctrl->state !=3D NVME_CTRL_DELETING &&
-			     ctrl->state !=3D NVME_CTRL_DELETING_NOIO);
+		enum nvme_ctrl_state state =3D nvme_ctrl_state(ctrl);
+
+		WARN_ON_ONCE(state !=3D NVME_CTRL_DELETING &&
+			     state !=3D NVME_CTRL_DELETING_NOIO);
 		return;
 	}
=20
@@ -2313,8 +2318,10 @@ static void nvme_reset_ctrl_work(struct work_struc=
t *work)
=20
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
 		/* state change failure is ok if we started ctrl delete */
-		WARN_ON_ONCE(ctrl->state !=3D NVME_CTRL_DELETING &&
-			     ctrl->state !=3D NVME_CTRL_DELETING_NOIO);
+		enum nvme_ctrl_state state =3D nvme_ctrl_state(ctrl);
+
+		WARN_ON_ONCE(state !=3D NVME_CTRL_DELETING &&
+			     state !=3D NVME_CTRL_DELETING_NOIO);
 		return;
 	}
=20
@@ -2432,7 +2439,7 @@ static enum blk_eh_timer_return nvme_tcp_timeout(st=
ruct request *rq)
 		nvme_tcp_queue_id(req->queue), nvme_cid(rq), pdu->hdr.type,
 		opc, nvme_opcode_str(qid, opc, fctype));
=20
-	if (ctrl->state !=3D NVME_CTRL_LIVE) {
+	if (nvme_ctrl_state(ctrl) !=3D NVME_CTRL_LIVE) {
 		/*
 		 * If we are resetting, connecting or deleting we should
 		 * complete immediately because we may block controller
--=20
2.34.1


