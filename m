Return-Path: <SRS0=dhu5=2W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA3FC2D0DC
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jan 2020 16:45:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D587D206E6
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jan 2020 16:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dDb6Kmyk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D587D206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kioxia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=m8cAF1rXhdzjfXwcBnlkQNELfS7YRG3V+Et74h/LPJQ=; b=dDb6KmykZWKbuC
	uLR9Q/PEF4QWFBsWBB4gTamfhnlYjCytIvAuPCYd11zRLzHnyZmxAKTVoSLNkAp5UwZyLXmeJEL9A
	H9xXd2lopF1q4/oHu31oIi76zLzPiVahedQNcfR5bxNIIXwgnlz93xMqeF7q238wxS38bNVYNe0R0
	GMumHSQPUtbh0onh8hZJDo0pcaCY/vIBEiwq+RQeESr2XpJPrXGW9I729p623EfHogOtCSmR5U+5v
	gmw34W92ncCXZB9R/2PzcV/SFqnXKkYff8R8UsUO6Sdd27tikS2OLRC1TsmY2DWDbbHcnijTBl4k/
	ZMYIkIdB8+hUNdZIwGFw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1imh7R-0007W8-Ss; Wed, 01 Jan 2020 16:45:13 +0000
Received: from ip-12-0-68-226-us.kioxia.com ([12.0.68.226]
 helo=SJSMAIL01.us.kioxia.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1imh7N-0006eO-Fn
 for linux-nvme@lists.infradead.org; Wed, 01 Jan 2020 16:45:12 +0000
Received: from SJSMAIL01.us.kioxia.com (10.90.133.90) by
 SJSMAIL01.us.kioxia.com (10.90.133.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 1 Jan 2020 08:45:02 -0800
Received: from SJSMAIL01.us.kioxia.com ([fe80::65fa:7220:c1b7:572e]) by
 SJSMAIL01.us.kioxia.com ([fe80::65fa:7220:c1b7:572e%3]) with mapi id
 15.01.1779.004; Wed, 1 Jan 2020 08:45:02 -0800
From: Victor Gladkov <Victor.Gladkov@kioxia.com>
To: Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>, 
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: [PATCH v2] nvme-fabrics: reject I/O to offline device
Thread-Topic: [PATCH v2] nvme-fabrics: reject I/O to offline device
Thread-Index: AdXAws2i7K3jkb2QTo+39ruHWzRzNw==
Date: Wed, 1 Jan 2020 16:45:02 +0000
Message-ID: <49c2e737f21b4c2795de71c8d8d578ee@kioxia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.93.66.127]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200101_084509_530387_8656CFFE 
X-CRM114-Status: GOOD (  12.47  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Issue Description:
Commands get stuck while Host NVMe controller (TCP or RDMA) is in reconnect state. 
NVMe controller enters into reconnect state when it loses connection with the target. It tries to reconnect every 10 seconds (default) until successful reconnection or until reconnect time-out is reached. The default reconnect time out is 10 minutes.
This behavior is different than ISCSI where Commands during reconnect state returns with the following error: "rejecting I/O to offline device"

Fix Description:
Following your suggestions:
1. Add a new session parameter called "fast_fail_tmo". 
	The timeout is measured in seconds from the controller reconnect, any command beyond that timeout is rejected. 
	The new parameter value may be passed during 'connect', and its default value is 30 seconds. 
	A value of 0 means no timeout (in similar to current behavior).
2. Add a controller flag of "failfast_expired".
3. Add dedicated delayed_work that update the "failfast_expired" controller flag.
4. When entering CONNECTING, schedule the delayed_work based on failfast timeout value. 
	If transition out of CONNECTING, terminate delayed work item and ensure failfast_expired is false.
	If delayed work item expires: set "failfast_expired" flag to true.
5. Update nvmf_fail_nonready_command() with check the "failfast_expired" controller flag.

branch nvme/for-5.5
---------------------------------
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2a84e14..8e30e03 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -93,6 +93,8 @@
 static void nvme_put_subsystem(struct nvme_subsystem *subsys);
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 					   unsigned nsid);
+static void nvme_start_failfast_work(struct nvme_ctrl *ctrl);
+static void nvme_stop_failfast_work(struct nvme_ctrl *ctrl);
  static void nvme_set_queue_dying(struct nvme_ns *ns)
 {
@@ -339,6 +341,8 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		case NVME_CTRL_CONNECTING:
 			changed = true;
 			/* FALLTHRU */
+			if(old_state == NVME_CTRL_CONNECTING)
+				nvme_stop_failfast_work(ctrl);
 		default:
 			break;
 		}
@@ -359,6 +363,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		case NVME_CTRL_RESETTING:
 			changed = true;
 			/* FALLTHRU */
+			nvme_start_failfast_work(ctrl);
 		default:
 			break;
 		}
@@ -1033,6 +1038,36 @@ void nvme_stop_keep_alive(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_stop_keep_alive);
 +static void nvme_failfast_work(struct work_struct *work)
+{
+	struct nvme_ctrl *ctrl = container_of(to_delayed_work(work),
+			struct nvme_ctrl, failfast_work);
+
+	spin_lock_irq(&ctrl->lock);
+	if (ctrl->state == NVME_CTRL_CONNECTING) {
+		set_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
+		dev_info(ctrl->device, "failfast expired set for controller %s\n", ctrl->opts->subsysnqn);
+	}
+	spin_unlock_irq(&ctrl->lock);
+}
+
+static void nvme_start_failfast_work(struct nvme_ctrl *ctrl)
+{
+	if (unlikely(ctrl->opts->fail_fast_tmo == 0))
+		return;
+
+	schedule_delayed_work(&ctrl->failfast_work, ctrl->opts->fail_fast_tmo * HZ);
+}
+
+static void nvme_stop_failfast_work(struct nvme_ctrl *ctrl)
+{
+	if (unlikely(ctrl->opts->fail_fast_tmo == 0))
+		return;
+
+	cancel_delayed_work_sync(&ctrl->failfast_work);
+	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
+}
+
 static int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
 {
 	struct nvme_command c = { };
@@ -3979,6 +4014,7 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 {
 	nvme_mpath_stop(ctrl);
 	nvme_stop_keep_alive(ctrl);
+	nvme_stop_failfast_work(ctrl);
 	flush_work(&ctrl->async_event_work);
 	cancel_work_sync(&ctrl->fw_act_work);
 }
@@ -4043,6 +4079,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	int ret;
 	ctrl->state = NVME_CTRL_NEW;
+	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
 	spin_lock_init(&ctrl->lock);
 	mutex_init(&ctrl->scan_lock);
 	INIT_LIST_HEAD(&ctrl->namespaces);
@@ -4057,6 +4094,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	init_waitqueue_head(&ctrl->state_wq);
 	INIT_DELAYED_WORK(&ctrl->ka_work, nvme_keep_alive_work);
+	INIT_DELAYED_WORK(&ctrl->failfast_work, nvme_failfast_work);
 	memset(&ctrl->ka_cmd, 0, sizeof(ctrl->ka_cmd));
 	ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 74b8818..e952e5d 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -549,6 +549,7 @@ blk_status_t nvmf_fail_nonready_command(struct nvme_ctrl *ctrl,
 {
 	if (ctrl->state != NVME_CTRL_DELETING &&
 	    ctrl->state != NVME_CTRL_DEAD &&
+	    !test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags) &&
 	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
 		return BLK_STS_RESOURCE;
@@ -612,6 +613,7 @@ bool __nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
 	{ NVMF_OPT_NR_WRITE_QUEUES,	"nr_write_queues=%d"	},
 	{ NVMF_OPT_NR_POLL_QUEUES,	"nr_poll_queues=%d"	},
 	{ NVMF_OPT_TOS,			"tos=%d"		},
+	{ NVMF_OPT_FAIL_FAST_TMO,	"fail_fast_tmo=%d"	},
 	{ NVMF_OPT_ERR,			NULL			}
 };
@@ -630,6 +632,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	opts->nr_io_queues = num_online_cpus();
 	opts->reconnect_delay = NVMF_DEF_RECONNECT_DELAY;
 	opts->kato = NVME_DEFAULT_KATO;
+	opts->fail_fast_tmo = NVMF_DEF_FAIL_FAST_TMO;
 	opts->duplicate_connect = false;
 	opts->hdr_digest = false;
 	opts->data_digest = false;
@@ -751,6 +754,17 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
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
+				pr_warn("fail_fast_tmo != 0, I/O will failed on reconnect controller after %d sec\n", token);
+
+			opts->fail_fast_tmo  = token;
+			break;
 		case NVMF_OPT_HOSTNQN:
 			if (opts->host) {
 				pr_err("hostnqn already user-assigned: %s\n",
@@ -881,11 +895,14 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 		opts->nr_poll_queues = 0;
 		opts->duplicate_connect = true;
 	}
-	if (ctrl_loss_tmo < 0)
+	if (ctrl_loss_tmo < 0){
 		opts->max_reconnects = -1;
-	else
+	}else{
 		opts->max_reconnects = DIV_ROUND_UP(ctrl_loss_tmo,
 						opts->reconnect_delay);
+		if(ctrl_loss_tmo < opts->fail_fast_tmo)
+			pr_warn("failfast tmo (%d) larger than controller loss tmo (%d)\n", opts->fail_fast_tmo, ctrl_loss_tmo);
+	}

 	if (!opts->host) {
 		kref_get(&nvmf_default_host->ref);
@@ -985,7 +1002,7 @@ void nvmf_free_options(struct nvmf_ctrl_options *opts)
 #define NVMF_ALLOWED_OPTS	(NVMF_OPT_QUEUE_SIZE | NVMF_OPT_NR_IO_QUEUES | \
 				 NVMF_OPT_KATO | NVMF_OPT_HOSTNQN | \
 				 NVMF_OPT_HOST_ID | NVMF_OPT_DUP_CONNECT |\
-				 NVMF_OPT_DISABLE_SQFLOW)
+				 NVMF_OPT_DISABLE_SQFLOW|NVMF_OPT_FAIL_FAST_TMO)

static struct nvme_ctrl *
nvmf_create_ctrl(struct device *dev, const char *buf)
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index a0ec40a..fd8c7dd 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -15,6 +15,8 @@
 #define NVMF_DEF_RECONNECT_DELAY	10
/* default to 600 seconds of reconnect attempts before giving up */
 #define NVMF_DEF_CTRL_LOSS_TMO		600
+/* default to 0: don't fail fast IO commands  */
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
+ * @fast_fail_tmo: Fast I/O fail timeout in seconds;
  */
 struct nvmf_ctrl_options {
 	unsigned		mask;
@@ -111,6 +115,7 @@ struct nvmf_ctrl_options {
 	unsigned int		nr_write_queues;
 	unsigned int		nr_poll_queues;
 	int			tos;
+	unsigned int	fail_fast_tmo;
 };

 /*
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1024fec..b6a199e 100644
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

-----------------
Regards,
Victor


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
