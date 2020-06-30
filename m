Return-Path: <SRS0=73dC=AL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EC4C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2020 14:25:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 547A920672
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2020 14:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0XVt8GFS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 547A920672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kioxia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rj7Qhpbt2t2qpXTsFNhQplJRCC90hNWqVTa/9lM/5Z0=; b=0XVt8GFStnszwQ6Sg3MQuf8Z2i
	q2+p1gX8X/8/i4A1hURqywVvtup7eB5y6FbggcP6oGX5uQCk6zjHqv7bhkRDVmu9fOhWExvVMWJrc
	P/VM8sr+X6T5NylO6uLp+8qJCYDrQfbwkypaSqKl1duFuuezyDCqvTKRiD1EBmc/2oIPWt0TmyEWW
	080syG//LHZys/5/EZvvhJ6ait5sXtLuws5Qubu9gNsWi4VX4V5plsrOYqykArCpQoFmggZrVtgw2
	BHIwuadS7WedBV2YaY3dBJkjoPZS4dVKJrHsks8Cv43B9iHtVTU03PXh7l2EU7bnoodLrnuiUACuG
	dbzwiwIA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqHC0-0003AU-U7; Tue, 30 Jun 2020 14:25:01 +0000
Received: from usmailhost21.kioxia.com ([12.0.68.226]
 helo=SJSMAIL01.us.kioxia.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqHBv-00038R-PI
 for linux-nvme@lists.infradead.org; Tue, 30 Jun 2020 14:24:59 +0000
Received: from SJSMAIL01.us.kioxia.com (10.90.133.90) by
 SJSMAIL01.us.kioxia.com (10.90.133.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 30 Jun 2020 07:24:52 -0700
Received: from SJSMAIL01.us.kioxia.com ([fe80::39f9:a76d:ffe7:907a]) by
 SJSMAIL01.us.kioxia.com ([fe80::39f9:a76d:ffe7:907a%3]) with mapi id
 15.01.1779.004; Tue, 30 Jun 2020 07:24:52 -0700
From: Victor Gladkov <Victor.Gladkov@kioxia.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: [PATCH v5] nvme-fabrics: reject I/O to offline device
Thread-Topic: [PATCH v5] nvme-fabrics: reject I/O to offline device
Thread-Index: AdZO51QUZ1UzrwgRQOiNPNcL4QrT+A==
Date: Tue, 30 Jun 2020 14:24:52 +0000
Message-ID: <cde32cd53001412889cea1e1fe28e7f7@kioxia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.93.66.127]
MIME-Version: 1.0
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
Cc: Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Commands get stuck while Host NVMe controller (TCP or RDMA) is in
reconnect state. NVMe controller enters into reconnect state when it
loses connection with the target. It tries to reconnect every 10
seconds (default) until successful reconnection or until reconnect
time-out is reached. The default reconnect time out is 10 minutes.

To fix this long delay due to the default timeout we introduce new
session parameter "fast_io_fail_tmo". The timeout is measured in
seconds from the controller reconnect, any command beyond that
timeout is rejected. The new parameter value may be passed during
'connect'.
The default value of 0 means no timeout (similar to current behavior).

We add a new controller NVME_CTRL_FAILFAST_EXPIRED and respective
delayed work that updates the NVME_CTRL_FAILFAST_EXPIRED flag.

When the controller is entering the CONNECTING state, we schedule
the delayed_work based on failfast timeout value. If the transition
is out of CONNECTING, terminate delayed work item and ensure
failfast_expired is false. If delayed work item expires then set
"NVME_CTRL_FAILFAST_EXPIRED" flag to true.

We also update nvmf_fail_nonready_command() and
nvme_available_path() functions with check the
"NVME_CTRL_FAILFAST_EXPIRED" controller flag.

Signed-off-by: Victor Gladkov <victor.gladkov at kioxia.com>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>

---
Changes From V4:

1. Remove subsysnqn from dev_info just keep "failfast expired" 
    in nvme_failfast_work().
2. Remove excess lock in nvme_failfast_work().
3. Change "timeout disabled" value to -1, '0' is to fail I/O right away now.
4. Add "off" string for fast_io_fail_tmo option as a -1 equivalent.

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
 drivers/nvme/host/core.c      | 53 ++++++++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/fabrics.c   | 37 +++++++++++++++++++++++++++---
 drivers/nvme/host/fabrics.h   |  5 ++++
 drivers/nvme/host/multipath.c |  5 +++-
 drivers/nvme/host/nvme.h      |  3 +++
 5 files changed, 98 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f3c037f..5627f76 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -137,6 +137,41 @@ int nvme_try_sched_reset(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_try_sched_reset);

+static void nvme_failfast_work(struct work_struct *work)
+{
+	struct nvme_ctrl *ctrl = container_of(to_delayed_work(work),
+			struct nvme_ctrl, failfast_work);
+
+	if (ctrl->state != NVME_CTRL_CONNECTING)
+		return;
+
+	set_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
+	dev_info(ctrl->device, "failfast expired\n");
+	nvme_kick_requeue_lists(ctrl);
+}
+
+static inline void nvme_start_failfast_work(struct nvme_ctrl *ctrl)
+{
+	if (!ctrl->opts || ctrl->opts->fast_io_fail_tmo == -1)
+		return;
+
+	if (ctrl->opts->fast_io_fail_tmo == 0) {
+		nvme_failfast_work(&ctrl->failfast_work.work);
+		return;
+	}
+
+	schedule_delayed_work(&ctrl->failfast_work,
+			      ctrl->opts->fast_io_fail_tmo * HZ);
+}
+
+static inline void nvme_stop_failfast_work(struct nvme_ctrl *ctrl)
+{
+	if (!ctrl->opts || ctrl->opts->fast_io_fail_tmo == -1)
+		return;
+	cancel_delayed_work_sync(&ctrl->failfast_work);
+	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
+}
+
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
 {
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
@@ -387,8 +422,21 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 	}

 	spin_unlock_irqrestore(&ctrl->lock, flags);
-	if (changed && ctrl->state == NVME_CTRL_LIVE)
+	if (changed) {
+		switch (ctrl->state) {
+			case NVME_CTRL_LIVE:
+				if (old_state == NVME_CTRL_CONNECTING)
+					nvme_stop_failfast_work(ctrl);
 				nvme_kick_requeue_lists(ctrl);
+				break;
+			case NVME_CTRL_CONNECTING:
+				if (old_state == NVME_CTRL_RESETTING)
+					nvme_start_failfast_work(ctrl);
+				break;
+			default:
+				break;
+		}
+	}
 	return changed;
 }
 EXPORT_SYMBOL_GPL(nvme_change_ctrl_state);
@@ -4045,6 +4093,7 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 {
 	nvme_mpath_stop(ctrl);
 	nvme_stop_keep_alive(ctrl);
+	nvme_stop_failfast_work(ctrl);
 	flush_work(&ctrl->async_event_work);
 	cancel_work_sync(&ctrl->fw_act_work);
 }
@@ -4111,6 +4160,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	int ret;

 	ctrl->state = NVME_CTRL_NEW;
+	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
 	spin_lock_init(&ctrl->lock);
 	mutex_init(&ctrl->scan_lock);
 	INIT_LIST_HEAD(&ctrl->namespaces);
@@ -4125,6 +4175,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	init_waitqueue_head(&ctrl->state_wq);

 	INIT_DELAYED_WORK(&ctrl->ka_work, nvme_keep_alive_work);
+	INIT_DELAYED_WORK(&ctrl->failfast_work, nvme_failfast_work);
 	memset(&ctrl->ka_cmd, 0, sizeof(ctrl->ka_cmd));
 	ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 2a6c819..e44fdc4 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -549,6 +549,7 @@ blk_status_t nvmf_fail_nonready_command(struct nvme_ctrl *ctrl,
 {
 	if (ctrl->state != NVME_CTRL_DELETING &&
 	    ctrl->state != NVME_CTRL_DEAD &&
+	    !test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags) &&
 	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
 		return BLK_STS_RESOURCE;

@@ -612,6 +613,8 @@ bool __nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
 	{ NVMF_OPT_NR_WRITE_QUEUES,	"nr_write_queues=%d"	},
 	{ NVMF_OPT_NR_POLL_QUEUES,	"nr_poll_queues=%d"	},
 	{ NVMF_OPT_TOS,			"tos=%d"		},
+	{ NVMF_OPT_FAIL_FAST_TMO,	"fast_io_fail_tmo=%d"	},
+	{ NVMF_OPT_FAIL_FAST_TMO,	"fast_io_fail_tmo=%s"	},
 	{ NVMF_OPT_ERR,			NULL			}
 };

@@ -631,6 +634,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	opts->reconnect_delay = NVMF_DEF_RECONNECT_DELAY;
 	opts->kato = NVME_DEFAULT_KATO;
 	opts->duplicate_connect = false;
+	opts->fast_io_fail_tmo = NVMF_DEF_FAIL_FAST_TMO;
 	opts->hdr_digest = false;
 	opts->data_digest = false;
 	opts->tos = -1; /* < 0 == use transport default */
@@ -751,6 +755,28 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 				pr_warn("ctrl_loss_tmo < 0 will reconnect forever\n");
 			ctrl_loss_tmo = token;
 			break;
+		case NVMF_OPT_FAIL_FAST_TMO:
+			if (match_int(args, &token)) {
+				p = match_strdup(args);
+				if (!p) {
+					ret = -EINVAL;
+					goto out;
+				}
+
+				token = strcasecmp(p, "off") ? 0 : -1;
+				kfree(p);
+
+				if (!token) {
+					ret = -EINVAL;
+					goto out;
+				}
+			}
+
+			if (token >= 0)
+				pr_warn("I/O will fail on reconnect controller after"
+					" %d sec\n", token);
+			opts->fast_io_fail_tmo = token;
+			break;
 		case NVMF_OPT_HOSTNQN:
 			if (opts->host) {
 				pr_err("hostnqn already user-assigned: %s\n",
@@ -881,11 +907,16 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 		opts->nr_poll_queues = 0;
 		opts->duplicate_connect = true;
 	}
-	if (ctrl_loss_tmo < 0)
+	if (ctrl_loss_tmo < 0) {
 		opts->max_reconnects = -1;
-	else
+	} else {
 		opts->max_reconnects = DIV_ROUND_UP(ctrl_loss_tmo,
 						opts->reconnect_delay);
+		if (ctrl_loss_tmo < opts->fast_io_fail_tmo)
+			pr_warn("failfast tmo (%d) larger than controller "
+				"loss tmo (%d)\n",
+				opts->fast_io_fail_tmo, ctrl_loss_tmo);
+	}

 	if (!opts->host) {
 		kref_get(&nvmf_default_host->ref);
@@ -985,7 +1016,7 @@ void nvmf_free_options(struct nvmf_ctrl_options *opts)
 #define NVMF_ALLOWED_OPTS	(NVMF_OPT_QUEUE_SIZE | NVMF_OPT_NR_IO_QUEUES | \
 				 NVMF_OPT_KATO | NVMF_OPT_HOSTNQN | \
 				 NVMF_OPT_HOST_ID | NVMF_OPT_DUP_CONNECT |\
-				 NVMF_OPT_DISABLE_SQFLOW)
+				 NVMF_OPT_DISABLE_SQFLOW | NVMF_OPT_FAIL_FAST_TMO)

 static struct nvme_ctrl *
 nvmf_create_ctrl(struct device *dev, const char *buf)
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index a0ec40a..05a1158 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -15,6 +15,8 @@
 #define NVMF_DEF_RECONNECT_DELAY	10
 /* default to 600 seconds of reconnect attempts before giving up */
 #define NVMF_DEF_CTRL_LOSS_TMO		600
+/* default is -1: the fail fast mechanism is disable  */
+#define NVMF_DEF_FAIL_FAST_TMO		-1

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
+	int			fast_io_fail_tmo;
 };

 /*
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 54603bd..d8b7f45 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -278,9 +278,12 @@ static bool nvme_available_path(struct nvme_ns_head *head)

 	list_for_each_entry_rcu(ns, &head->list, siblings) {
 		switch (ns->ctrl->state) {
+		case NVME_CTRL_CONNECTING:
+			if (test_bit(NVME_CTRL_FAILFAST_EXPIRED,
+				     &ns->ctrl->flags))
+				break;
 		case NVME_CTRL_LIVE:
 		case NVME_CTRL_RESETTING:
-		case NVME_CTRL_CONNECTING:
 			/* fallthru */
 			return true;
 		default:
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2e04a36..9112886 100644
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
@@ -290,6 +291,8 @@ struct nvme_ctrl {
 	u16 icdoff;
 	u16 maxcmd;
 	int nr_reconnects;
+	unsigned long flags;
+#define NVME_CTRL_FAILFAST_EXPIRED	0
 	struct nvmf_ctrl_options *opts;

 	struct page *discard_page;
--
1.8.3.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
