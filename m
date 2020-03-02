Return-Path: <SRS0=ymBk=4T=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5F7C3F2D1
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2020 03:30:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38C5E22B48
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2020 03:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JK9XUqon";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RP/i8ZcF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38C5E22B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=bjga4XFTJVgExulC13Wf/CVy/MI7b9FWXzoD7i1G+ps=; b=JK9XUqon2afq6I
	4chiU5Wowd0K7eXN4Ee/1nuKiTU/M/QFqiJ0YA34EyVlPGg4bQU10J2T54fLLgYNk6vs9chbaz2Ge
	xdWIJ+SmnfLcmidnbQq0BzmW6utyI2mADayQZWhxYKQF3W/KABva7ejKIDLGda35bqucRKCrNdqTf
	IS1IK+OQQvyFCyXM+DjIRYJK1DmQVwNI48mHeAJtaLuTO5ZFEnWpIGbKAR9hPdwSz7SvFQAxGJWUH
	kIx7Vmdu3Hv+x1qDuC6omwGZxkE3KorzbFpS8KrLmeOXRg1behXOhr1Ufz+fJRrD/lvVxKgah8DBh
	Z7u41MruJQCYY2gKOLsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j8bn2-0003mh-0N; Mon, 02 Mar 2020 03:30:44 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j8bmy-0003kb-Hg
 for linux-nvme@lists.infradead.org; Mon, 02 Mar 2020 03:30:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1583119840; x=1614655840;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=fyl+mormd7+O+jKnN9UayHfBtj0LmVi32xHEjEdwLdM=;
 b=RP/i8ZcFE2KGmJDISqUHS+8T/3Kp8bluXCAUGctFY+estJEgFA6Fgmt4
 dBSahbcPVk0Gyq1lRU6Y2Pz12SHZpbFHbzIdtVFGDQcDx32g+shkUhw9n
 ujo4J5za4S2sIONYS6il/VFZpop/F/0RZ40RzebEpKGY3NCNywNjNm25b
 SW/7Vr2gEZ3rXUDzq9WhlxgJJ8F8c2vgIaLUu9IAuuJm1AalFbUIOJ0VH
 9/VkG5ArOYRxN5BOIOOYh5ELZzL3iNVTc5cE0kz6Kv+TbME2IUXfAmfhd
 sA92FjIUoxytblN7Wy68e9EC1OQ8cFwswyLnmdeYyK+ONQnruYVKr6uOZ g==;
IronPort-SDR: UfTcdao5xgN19lBSrvfR8WAiWery0TXfXNy8DQODVnyyXgXwIPWZMlbTOEOQuM3SC7P153xZ+S
 peLSumM+BOXspieYtdVOmKmtyN2DaIptd+z1bJD3NDbAt9/ckx/Cv9tPq2I9LV6EWf2XHeNLoJ
 r2oCtKI+nM/WM2AcPMawGPpvS0Yo/EIl3PdgcjImqdAuOM0B9QiYPwh6nWcwzr6DKHoZICd78t
 qznDHOuzbSaacH4Dn4KougYXvy8WrLjMS3S42VDiIvf5S0dupuusniRaoFe9o0SknkYILhn1Lx
 y/o=
X-IronPort-AV: E=Sophos;i="5.70,506,1574092800"; d="scan'208";a="239326480"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2020 11:30:31 +0800
IronPort-SDR: Aai4n/FmZM6EXNakLeJ0/m6qrq8mIHeqbBLYS1l6KIS7s77egFJ5LQEhiZ7SAMJK4jtBgowzgc
 MV3XfOqXxj6Zelz/ole/aInvh6jynwnaRnAUgJ6naWz1Yp2Bb9GrubeXE6sNhluTBQ9ya8H5Fb
 pvdI1jnKr5bOJOZ6FawX4jFMjvnRX5DWGY0wAFs24VtCkRQ9BRfA7rprecEn73iEBkUjBAvKJx
 mIq7zdnN9eTmj696fZ4HaK7r/FUqYTiWZky7PfD1faEu1Xf215IHNWS4ubloe+OHt8HWqLfZcS
 HNNk0UZZc2yLT8kXpU+bTcIV
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2020 19:22:26 -0800
IronPort-SDR: 3Okn6yVTEjPPKGPz15G/0mJOeBAemNAKdqXixRVSXnRj7RL8yh2Ass1JhWKdTywXsTWyfK392p
 K5n0Ge7o5rB9glWAHKNfXRoxS1WtTW2fkkG0f90TVJBdkEiFYYiaVwBH/+YEzgb5VRKDxAtxvP
 dhnjFNyD0HMEdnttt75+tYFZJ2R0jkTHi28fbsDXb6XhgmnwnmuRf9D+jZVABtSRwLtd4Qw/F5
 TqC6iNBQfWd1NIarn5p1FsyK06CqmqQ0iEFJaB7GEfvZjtPUp8uTE8FZfo9zBCVHp0UPqYK3KT
 Pk8=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 01 Mar 2020 19:30:32 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V4] nvme-fabrics: reject I/O to offline device
Date: Sun,  1 Mar 2020 19:30:04 -0800
Message-Id: <20200302033004.19474-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200301_193040_628652_68131E62 
X-CRM114-Status: GOOD (  23.10  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: sagi@grimberg.me, snitzer@redhat.com,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, james.smart@broadcom.com,
 Victor.Gladkov@kioxia.com, hare@suse.de, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Victor Gladkov <victor.gladkov@kioxia.com>

Commands get stuck while Host NVMe controller (TCP or RDMA) is in
reconnect state. NVMe controller enters into reconnect state when it
loses connection with the target. It tries to reconnect every 10
seconds (default) until successful reconnection or until reconnect
time-out is reached. The default reconnect time out is 10 minutes.

To fix this long delay due to the default timeout we introduce new
session parameter "fast_io_fail_tmo". The timeout is measured in
seconds from the controller reconnect, any command beyond that timeout
is rejected. The new parameter value may be passed during 'connect'.
The default value of 0 means no timeout (similar to current behavior).

We add a new controller NVME_CTRL_FAILFAST_EXPIRED and respective
delayed work that updates the NVME_CTRL_FAILFAST_EXPIRED flag.

When the controller is entering the CONNECTING state, we schedule the
delayed_work based on failfast timeout value. If the transition is out
of CONNECTING, terminate delayed work item and ensure failfast_expired
is false. If delayed work item expires then set
"NVME_CTRL_FAILFAST_EXPIRED" flag to true.

We also update nvmf_fail_nonready_command() and nvme_available_path()
functions with check the "NVME_CTRL_FAILFAST_EXPIRED" controller flag.

Signed-off-by: Victor Gladkov <victor.gladkov@kioxia.com>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
Changes From V3:

1. BUG_FIX: Fix a bug in nvme_start_failfast_work() amd 
   nvme_stop_failfast_work() when accessing ctrl->opts as it will fail
   for PCIe transport when is called nvme_change_ctrl_state()
   from nvme_reset_work(), since we don't set the ctrl->opts for
   PCIe transport.
2. Line wrap in nvme_start_failfast_work(), nvme_parse_option() and
   for macro NVMF_ALLOWED_OPTS definition.
3. Just like all the state change code add a switch for newly
   added state handling outside of the state machine in
   nvme_state_change().
4. nvme_available_path() add /* fallthru */ after if..break inside
   switch which is under list_for_each_entry_rcu().
5. Align newly added member nvmf_ctrl_options fast_io_fail_tmp.
6. Fix the tabs before if in nvme_available_path() and line wrap
   for the same.
7. In nvme_failfast_work() use state != NVME_CTRL_CONNECTING
   instead of == to get rid of the parentheses and avoid char > 80.
8. Get rid of the ";" at the end of the comment for @fast_io_fail_tmp.
9. Change the commit log style to match the one we have in the NVMe
   repo.

Changes from V2:

1. Several coding style and small fixes.
2. Fix the comment for NVMF_DEF_FAIL_FAST_TMO.
3. Don't call functionality from the state machine.
4. Rename fast_fail_tmo -> fast_io_fail_tmo to match SCSI
   semantics.

Changes from V1:

1. Add a new session parameter called "fast_fail_tmo". The timeout
   is measured in seconds from the controller reconnect, any command
   beyond that timeout is rejected. The new parameter value may be
   passed during 'connect', and its default value is 30 seconds. 
   A value of 0 means no timeout (similar to current behavior).
2. Add a controller flag of "failfast_expired".
3. Add dedicated delayed_work that update the "failfast_expired" 
   controller flag.
4. When entering CONNECTING, schedule the delayed_work based on
   failfast timeout value. If transition out of CONNECTING, terminate
   delayed work item and ensure failfast_expired is false.
   If delayed work item expires: set "failfast_expired" flag to true.
5. Update nvmf_fail_nonready_command() with check the
   "failfast_expired" controller flag.
---
 drivers/nvme/host/core.c      | 53 +++++++++++++++++++++++++++++++++--
 drivers/nvme/host/fabrics.c   | 32 +++++++++++++++++----
 drivers/nvme/host/fabrics.h   |  5 ++++
 drivers/nvme/host/multipath.c |  6 +++-
 drivers/nvme/host/nvme.h      |  3 ++
 5 files changed, 90 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 84914223c537..fb7b3ce2a271 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -136,6 +136,39 @@ int nvme_try_sched_reset(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_try_sched_reset);
 
+static void nvme_failfast_work(struct work_struct *work)
+{
+	struct nvme_ctrl *ctrl = container_of(to_delayed_work(work),
+			struct nvme_ctrl, failfast_work);
+
+	spin_lock_irq(&ctrl->lock);
+	if (ctrl->state != NVME_CTRL_CONNECTING)
+		goto out;
+
+	set_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
+	dev_info(ctrl->device, "failfast expired set for controller %s\n",
+		ctrl->opts->subsysnqn);
+	nvme_kick_requeue_lists(ctrl);
+out:
+	spin_unlock_irq(&ctrl->lock);
+}
+
+static inline void nvme_start_failfast_work(struct nvme_ctrl *ctrl)
+{
+	if (!ctrl->opts || ctrl->opts->fast_io_fail_tmo == 0)
+		return;
+	schedule_delayed_work(&ctrl->failfast_work,
+			      ctrl->opts->fast_io_fail_tmo * HZ);
+}
+
+static inline void nvme_stop_failfast_work(struct nvme_ctrl *ctrl)
+{
+	if (!ctrl->opts || ctrl->opts->fast_io_fail_tmo == 0)
+		return;
+	cancel_delayed_work_sync(&ctrl->failfast_work);
+	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
+}
+
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
 {
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
@@ -395,8 +428,21 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 	}
 
 	spin_unlock_irqrestore(&ctrl->lock, flags);
-	if (changed && ctrl->state == NVME_CTRL_LIVE)
-		nvme_kick_requeue_lists(ctrl);
+	if (changed) {
+		switch (ctrl->state) {
+		case NVME_CTRL_LIVE:
+			nvme_kick_requeue_lists(ctrl);
+			if (old_state == NVME_CTRL_CONNECTING)
+				nvme_stop_failfast_work(ctrl);
+			break;
+		case NVME_CTRL_CONNECTING:
+			if (old_state == NVME_CTRL_RESETTING)
+				nvme_start_failfast_work(ctrl);
+			break;
+		default:
+			break;
+		}
+	}
 	return changed;
 }
 EXPORT_SYMBOL_GPL(nvme_change_ctrl_state);
@@ -3992,6 +4038,7 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 {
 	nvme_mpath_stop(ctrl);
 	nvme_stop_keep_alive(ctrl);
+	nvme_stop_failfast_work(ctrl);
 	flush_work(&ctrl->async_event_work);
 	cancel_work_sync(&ctrl->fw_act_work);
 }
@@ -4056,6 +4103,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	int ret;
 
 	ctrl->state = NVME_CTRL_NEW;
+	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
 	spin_lock_init(&ctrl->lock);
 	mutex_init(&ctrl->scan_lock);
 	INIT_LIST_HEAD(&ctrl->namespaces);
@@ -4070,6 +4118,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	init_waitqueue_head(&ctrl->state_wq);
 
 	INIT_DELAYED_WORK(&ctrl->ka_work, nvme_keep_alive_work);
+	INIT_DELAYED_WORK(&ctrl->failfast_work, nvme_failfast_work);
 	memset(&ctrl->ka_cmd, 0, sizeof(ctrl->ka_cmd));
 	ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;
 
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 74b8818ac9a1..7f54e7e4f528 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -549,6 +549,7 @@ blk_status_t nvmf_fail_nonready_command(struct nvme_ctrl *ctrl,
 {
 	if (ctrl->state != NVME_CTRL_DELETING &&
 	    ctrl->state != NVME_CTRL_DEAD &&
+	    !test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags) &&
 	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
 		return BLK_STS_RESOURCE;
 
@@ -612,6 +613,7 @@ static const match_table_t opt_tokens = {
 	{ NVMF_OPT_NR_WRITE_QUEUES,	"nr_write_queues=%d"	},
 	{ NVMF_OPT_NR_POLL_QUEUES,	"nr_poll_queues=%d"	},
 	{ NVMF_OPT_TOS,			"tos=%d"		},
+	{ NVMF_OPT_FAIL_FAST_TMO,	"fast_io_fail_tmo=%d"	},
 	{ NVMF_OPT_ERR,			NULL			}
 };
 
@@ -631,6 +633,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	opts->reconnect_delay = NVMF_DEF_RECONNECT_DELAY;
 	opts->kato = NVME_DEFAULT_KATO;
 	opts->duplicate_connect = false;
+	opts->fast_io_fail_tmo = NVMF_DEF_FAIL_FAST_TMO;
 	opts->hdr_digest = false;
 	opts->data_digest = false;
 	opts->tos = -1; /* < 0 == use transport default */
@@ -751,6 +754,19 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 				pr_warn("ctrl_loss_tmo < 0 will reconnect forever\n");
 			ctrl_loss_tmo = token;
 			break;
+		case NVMF_OPT_FAIL_FAST_TMO:
+			if (match_int(args, &token)) {
+				ret = -EINVAL;
+				goto out;
+			}
+
+			if (token)
+				pr_warn("fail_fast_tmo != 0, I/O will fail on"
+					" reconnect controller after %d sec\n",
+					token);
+
+			opts->fast_io_fail_tmo = token;
+			break;
 		case NVMF_OPT_HOSTNQN:
 			if (opts->host) {
 				pr_err("hostnqn already user-assigned: %s\n",
@@ -881,11 +897,14 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 		opts->nr_poll_queues = 0;
 		opts->duplicate_connect = true;
 	}
-	if (ctrl_loss_tmo < 0)
+	if (ctrl_loss_tmo < 0) {
 		opts->max_reconnects = -1;
-	else
-		opts->max_reconnects = DIV_ROUND_UP(ctrl_loss_tmo,
-						opts->reconnect_delay);
+	} else {
+		if (ctrl_loss_tmo < opts->fast_io_fail_tmo)
+			pr_warn("failfast tmo (%d) larger than controller "
+				"loss tmo (%d)\n",
+				opts->fast_io_fail_tmo, ctrl_loss_tmo);
+	}
 
 	if (!opts->host) {
 		kref_get(&nvmf_default_host->ref);
@@ -984,8 +1003,9 @@ EXPORT_SYMBOL_GPL(nvmf_free_options);
 #define NVMF_REQUIRED_OPTS	(NVMF_OPT_TRANSPORT | NVMF_OPT_NQN)
 #define NVMF_ALLOWED_OPTS	(NVMF_OPT_QUEUE_SIZE | NVMF_OPT_NR_IO_QUEUES | \
 				 NVMF_OPT_KATO | NVMF_OPT_HOSTNQN | \
-				 NVMF_OPT_HOST_ID | NVMF_OPT_DUP_CONNECT |\
-				 NVMF_OPT_DISABLE_SQFLOW)
+				 NVMF_OPT_HOST_ID | NVMF_OPT_DUP_CONNECT | \
+				 NVMF_OPT_DISABLE_SQFLOW | \
+				 NVMF_OPT_FAIL_FAST_TMO)
 
 static struct nvme_ctrl *
 nvmf_create_ctrl(struct device *dev, const char *buf)
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index a0ec40ab62ee..a078ddea9429 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -15,6 +15,8 @@
 #define NVMF_DEF_RECONNECT_DELAY	10
 /* default to 600 seconds of reconnect attempts before giving up */
 #define NVMF_DEF_CTRL_LOSS_TMO		600
+/* default is 0: the fail fast mechanism is disable  */
+#define NVMF_DEF_FAIL_FAST_TMO		0
 
 /*
  * Define a host as seen by the target.  We allocate one at boot, but also
@@ -56,6 +58,7 @@ enum {
 	NVMF_OPT_NR_WRITE_QUEUES = 1 << 17,
 	NVMF_OPT_NR_POLL_QUEUES = 1 << 18,
 	NVMF_OPT_TOS		= 1 << 19,
+	NVMF_OPT_FAIL_FAST_TMO	= 1 << 20,
 };
 
 /**
@@ -89,6 +92,7 @@ enum {
  * @nr_write_queues: number of queues for write I/O
  * @nr_poll_queues: number of queues for polling I/O
  * @tos: type of service
+ * @fast_io_fail_tmo: Fast I/O fail timeout in seconds
  */
 struct nvmf_ctrl_options {
 	unsigned		mask;
@@ -111,6 +115,7 @@ struct nvmf_ctrl_options {
 	unsigned int		nr_write_queues;
 	unsigned int		nr_poll_queues;
 	int			tos;
+	unsigned int		fast_io_fail_tmo;
 };
 
 /*
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 797c18337d96..7bccdad52a78 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -281,9 +281,13 @@ static bool nvme_available_path(struct nvme_ns_head *head)
 
 	list_for_each_entry_rcu(ns, &head->list, siblings) {
 		switch (ns->ctrl->state) {
+		case NVME_CTRL_CONNECTING:
+			if (test_bit(NVME_CTRL_FAILFAST_EXPIRED,
+				     &ns->ctrl->flags))
+				break;
+			/* fallthru */
 		case NVME_CTRL_LIVE:
 		case NVME_CTRL_RESETTING:
-		case NVME_CTRL_CONNECTING:
 			/* fallthru */
 			return true;
 		default:
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1024fec7914c..b6a199eaac68 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -256,6 +256,7 @@ struct nvme_ctrl {
 	struct work_struct scan_work;
 	struct work_struct async_event_work;
 	struct delayed_work ka_work;
+	struct delayed_work failfast_work;
 	struct nvme_command ka_cmd;
 	struct work_struct fw_act_work;
 	unsigned long events;
@@ -289,6 +290,8 @@ struct nvme_ctrl {
 	u16 icdoff;
 	u16 maxcmd;
 	int nr_reconnects;
+	unsigned long flags;
+#define NVME_CTRL_FAILFAST_EXPIRED	0
 	struct nvmf_ctrl_options *opts;
 
 	struct page *discard_page;
-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
