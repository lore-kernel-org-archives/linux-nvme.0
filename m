Return-Path: <SRS0=B4mB=DH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F61C4727F
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 13:14:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 701622075F
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 13:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TVtJtray"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 701622075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=H/IZOT3sjLoKzKeI4AItWYBl/oRDXxzE3yprSdIAfyQ=; b=TVtJtray9Gk3eu4UP/5QJkjaQ
	6oBK8DjDbigssFH9jpvhMEnzP9f8+Fyd8CIU9pKTGqIR16oXSit4FV21rrf9NM3mpSW9p4ebO7VmI
	uFi97tYclSq5nKteKgNgYdSyh/6JIacQvW8JMb2sRnKZmgMu3ToAW8qnkrwijUMm8YD/ZhudYU+x7
	3J86wVkrzWbTFGFyIs1+H6B0fqRKpJMxyTGI6DJgOLTabm2V8oknyCUCajvo5t1BypS3obayxaKCI
	mAzHRAkgwdcalc3JLZx7ErhcjevGxaFx84Ld/RibKHiSXoTvJzj1C2uHmngVUhQPV3xqdXGw14QnM
	7+OS+RztA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNbw3-0007nj-8Y; Wed, 30 Sep 2020 13:14:19 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNbw0-0007mR-1t
 for linux-nvme@lists.infradead.org; Wed, 30 Sep 2020 13:14:17 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id B3565B195;
 Wed, 30 Sep 2020 13:14:13 +0000 (UTC)
Subject: Re: [PATCH v9] nvme-fabrics: reject I/O to offline device
To: Victor Gladkov <Victor.Gladkov@kioxia.com>
References: <3e9337bfbd7f410eb632e96a44b43924@kioxia.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <05e192d4-b57e-b934-302a-79bdc0e6a36f@suse.de>
Date: Wed, 30 Sep 2020 15:14:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <3e9337bfbd7f410eb632e96a44b43924@kioxia.com>
Content-Type: multipart/mixed; boundary="------------BC5F926006407B4D3E669565"
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200930_091416_326241_0B87B087 
X-CRM114-Status: GOOD (  37.85  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "Ewan D. Milne" <emilne@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This is a multi-part message in MIME format.
--------------BC5F926006407B4D3E669565
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/30/20 2:31 PM, Victor Gladkov wrote:
> On 9/30/20 8:47 PM, Hannes Reinecke wrote:
>   
>>>    		opts->max_reconnects = DIV_ROUND_UP(ctrl_loss_tmo,
>>>    						opts->reconnect_delay);
>>> +		if (ctrl_loss_tmo < opts->fast_io_fail_tmo)
>>> +			pr_warn("failfast tmo (%d) larger than controller "
>>> +				"loss tmo (%d)\n",
>>> +				opts->fast_io_fail_tmo, ctrl_loss_tmo);
>>> +	}
>>
>> If we already check for that condition, shouldn't we disable fast_io_fail_tmo in
>> that situation to clarify things?
>>
> 
> OK for me. I don't mind
> 
>>>
>>>    	if (!opts->host) {
>>>    		kref_get(&nvmf_default_host->ref);
>>> @@ -985,7 +1004,7 @@ void nvmf_free_options(struct nvmf_ctrl_options
>>> *opts)
>>>    #define NVMF_ALLOWED_OPTS	(NVMF_OPT_QUEUE_SIZE |
>>> NVMF_OPT_NR_IO_QUEUES | \
>>>    				 NVMF_OPT_KATO | NVMF_OPT_HOSTNQN | \
>>>    				 NVMF_OPT_HOST_ID | NVMF_OPT_DUP_CONNECT
>>> |\
>>> -				 NVMF_OPT_DISABLE_SQFLOW)
>>> +				 NVMF_OPT_DISABLE_SQFLOW |
>>> NVMF_OPT_FAIL_FAST_TMO)
>>>
>>>    static struct nvme_ctrl *
>>>    nvmf_create_ctrl(struct device *dev, const char *buf) diff --git
>>> a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h index
> 
>>> diff --git a/drivers/nvme/host/multipath.c
>>> b/drivers/nvme/host/multipath.c index 54603bd..d8b7f45 100644
>>> --- a/drivers/nvme/host/multipath.c
>>> +++ b/drivers/nvme/host/multipath.c
>>> @@ -278,9 +278,12 @@ static bool nvme_available_path(struct
>>> nvme_ns_head *head)
>>>
>>>    	list_for_each_entry_rcu(ns, &head->list, siblings) {
>>>    		switch (ns->ctrl->state) {
>>> +		case NVME_CTRL_CONNECTING:
>>> +			if (test_bit(NVME_CTRL_FAILFAST_EXPIRED,
>>> +				     &ns->ctrl->flags))
>>> +				break;
>>
>> No. We shouldn't select this path, but that doesn't mean that all other paths in
>> this list can't be selected, either; they might be coming from different
>> controllers.
>> Please use 'continue' here.
>>
> 
>   The 'break' doesn't interrupt the 'for_each' loop, but only go out from 'switch'
> 
Ah. But still; that is not quite correct as we'll need to intercept 
things at nvme_ns_head_submit_bio() to make the correct decision there.

I've attached the modified version I'm working with; please check if 
you're okay with it.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

--------------BC5F926006407B4D3E669565
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-nvme-fabrics-reject-I-O-to-offline-device.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-nvme-fabrics-reject-I-O-to-offline-device.patch"

From fc2e2c5ceff5d0807623ccd83d735965ba5b7ec0 Mon Sep 17 00:00:00 2001
From: Victor Gladkov <Victor.Gladkov@kioxia.com>
Date: Tue, 29 Sep 2020 15:27:38 +0000
Subject: [PATCH] nvme-fabrics: reject I/O to offline device

Commands get stuck while Host NVMe-oF controller is in reconnect state.
NVMe controller enters into reconnect state when it loses connection with the
target. It tries to reconnect every 10 seconds
(default) until successful reconnection or until reconnect time-out is reached.
The default reconnect time out is 10 minutes.

Applications are expecting commands to complete with success or error within
a certain timeout (30 seconds by default).  The NVMe host is enforcing that
timeout while it is connected, never the less, during reconnection, the timeout
is not enforced and commands may get stuck for a long period or even forever.

To fix this long delay due to the default timeout we introduce new session
parameter "fast_io_fail_tmo". The timeout is measured in seconds from the
controller reconnect, any command beyond that timeout is rejected. The new
parameter value may be passed during 'connect'.
The default value of -1 means no timeout (similar to current behavior).

We add a new controller NVME_CTRL_FAILFAST_EXPIRED and respective
delayed work that updates the NVME_CTRL_FAILFAST_EXPIRED flag.

When the controller is entering the CONNECTING state, we schedule the
delayed_work based on failfast timeout value. If the transition is out of
CONNECTING, terminate delayed work item and ensure failfast_expired is
false. If delayed work item expires then set "NVME_CTRL_FAILFAST_EXPIRED"
flag to true.

We also update nvmf_fail_nonready_command() and
nvme_available_path() functions with check the
"NVME_CTRL_FAILFAST_EXPIRED" controller flag.

For multipath (function nvme_available_path()):
The path will not be considered available if
"NVME_CTRL_FAILFAST_EXPIRED" controller flag  is set
and the controller in NVME_CTRL_CONNECTING state.
This prevents commands from getting stuck
when available paths have tried to reconnect for too long.

Signed-off-by: Victor Gladkov <victor.gladkov at kioxia.com>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
Reviewed-by: Hannes Reinecke <hare at suse.de>
---
 drivers/nvme/host/core.c      | 42 ++++++++++++++++++++++++++++++++++++++++--
 drivers/nvme/host/fabrics.c   | 24 ++++++++++++++++++++++--
 drivers/nvme/host/fabrics.h   |  5 +++++
 drivers/nvme/host/multipath.c |  4 ++++
 drivers/nvme/host/nvme.h      |  3 +++
 5 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 385b10317873..9610d81f2070 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -148,6 +148,37 @@ int nvme_try_sched_reset(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_try_sched_reset);
 
+static void nvme_failfast_work(struct work_struct *work) {
+	struct nvme_ctrl *ctrl = container_of(to_delayed_work(work),
+			struct nvme_ctrl, failfast_work);
+
+	if (ctrl->state != NVME_CTRL_CONNECTING)
+		return;
+
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
+	schedule_delayed_work(&ctrl->failfast_work,
+			      ctrl->opts->fast_io_fail_tmo * HZ);
+}
+
+static inline void nvme_stop_failfast_work(struct nvme_ctrl *ctrl)
+{
+	if (!ctrl->opts)
+		return;
+
+	cancel_delayed_work_sync(&ctrl->failfast_work);
+	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
+}
+
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
 {
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
@@ -360,9 +391,11 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 	switch (new_state) {
 	case NVME_CTRL_LIVE:
 		switch (old_state) {
+		case NVME_CTRL_CONNECTING:
+			nvme_stop_failfast_work(ctrl);
+			fallthrough;
 		case NVME_CTRL_NEW:
 		case NVME_CTRL_RESETTING:
-		case NVME_CTRL_CONNECTING:
 			changed = true;
 			fallthrough;
 		default:
@@ -381,8 +414,10 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		break;
 	case NVME_CTRL_CONNECTING:
 		switch (old_state) {
-		case NVME_CTRL_NEW:
 		case NVME_CTRL_RESETTING:
+			nvme_start_failfast_work(ctrl);
+			fallthrough;
+		case NVME_CTRL_NEW:
 			changed = true;
 			fallthrough;
 		default:
@@ -4343,6 +4378,7 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 {
 	nvme_mpath_stop(ctrl);
 	nvme_stop_keep_alive(ctrl);
+	nvme_stop_failfast_work(ctrl);
 	flush_work(&ctrl->async_event_work);
 	cancel_work_sync(&ctrl->fw_act_work);
 }
@@ -4408,6 +4444,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	int ret;
 
 	ctrl->state = NVME_CTRL_NEW;
+	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
 	spin_lock_init(&ctrl->lock);
 	mutex_init(&ctrl->scan_lock);
 	INIT_LIST_HEAD(&ctrl->namespaces);
@@ -4424,6 +4461,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	init_waitqueue_head(&ctrl->state_wq);
 
 	INIT_DELAYED_WORK(&ctrl->ka_work, nvme_keep_alive_work);
+	INIT_DELAYED_WORK(&ctrl->failfast_work, nvme_failfast_work);
 	memset(&ctrl->ka_cmd, 0, sizeof(ctrl->ka_cmd));
 	ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;
 
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 8575724734e0..6404cbf41c96 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -549,6 +549,7 @@ blk_status_t nvmf_fail_nonready_command(struct nvme_ctrl *ctrl,
 {
 	if (ctrl->state != NVME_CTRL_DELETING_NOIO &&
 	    ctrl->state != NVME_CTRL_DEAD &&
+	    !test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags) &&
 	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
 		return BLK_STS_RESOURCE;
 
@@ -615,6 +616,7 @@ static const match_table_t opt_tokens = {
 	{ NVMF_OPT_NR_WRITE_QUEUES,	"nr_write_queues=%d"	},
 	{ NVMF_OPT_NR_POLL_QUEUES,	"nr_poll_queues=%d"	},
 	{ NVMF_OPT_TOS,			"tos=%d"		},
+	{ NVMF_OPT_FAIL_FAST_TMO,	"fast_io_fail_tmo=%d"	},
 	{ NVMF_OPT_ERR,			NULL			}
 };
 
@@ -634,6 +636,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	opts->reconnect_delay = NVMF_DEF_RECONNECT_DELAY;
 	opts->kato = NVME_DEFAULT_KATO;
 	opts->duplicate_connect = false;
+	opts->fast_io_fail_tmo = NVMF_DEF_FAIL_FAST_TMO;
 	opts->hdr_digest = false;
 	opts->data_digest = false;
 	opts->tos = -1; /* < 0 == use transport default */
@@ -754,6 +757,17 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 				pr_warn("ctrl_loss_tmo < 0 will reconnect forever\n");
 			ctrl_loss_tmo = token;
 			break;
+		case NVMF_OPT_FAIL_FAST_TMO:
+			if (match_int(args, &token)) {
+				ret = -EINVAL;
+				goto out;
+			}
+
+			if (token >= 0)
+				pr_warn("I/O will fail on reconnect "
+					"controller after %d sec\n", token);
+			opts->fast_io_fail_tmo = token;
+			break;
 		case NVMF_OPT_HOSTNQN:
 			if (opts->host) {
 				pr_err("hostnqn already user-assigned: %s\n",
@@ -886,9 +900,14 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	}
 	if (ctrl_loss_tmo < 0)
 		opts->max_reconnects = -1;
-	else
+	else {
 		opts->max_reconnects = DIV_ROUND_UP(ctrl_loss_tmo,
 						opts->reconnect_delay);
+		if (ctrl_loss_tmo < opts->fast_io_fail_tmo)
+			pr_warn("failfast tmo (%d) larger than controller "
+				"dev loss tmo (%d)\n",
+				opts->fast_io_fail_tmo, ctrl_loss_tmo);
+	}
 
 	if (!opts->host) {
 		kref_get(&nvmf_default_host->ref);
@@ -988,7 +1007,8 @@ EXPORT_SYMBOL_GPL(nvmf_free_options);
 #define NVMF_ALLOWED_OPTS	(NVMF_OPT_QUEUE_SIZE | NVMF_OPT_NR_IO_QUEUES | \
 				 NVMF_OPT_KATO | NVMF_OPT_HOSTNQN | \
 				 NVMF_OPT_HOST_ID | NVMF_OPT_DUP_CONNECT |\
-				 NVMF_OPT_DISABLE_SQFLOW)
+				 NVMF_OPT_DISABLE_SQFLOW | \
+				 NVMF_OPT_FAIL_FAST_TMO)
 
 static struct nvme_ctrl *
 nvmf_create_ctrl(struct device *dev, const char *buf)
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index a9c1e3b4585e..2ce0451c00ff 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -15,6 +15,8 @@
 #define NVMF_DEF_RECONNECT_DELAY	10
 /* default to 600 seconds of reconnect attempts before giving up */
 #define NVMF_DEF_CTRL_LOSS_TMO		600
+/* default is -1: the fail fast mechanism is disabled */
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
index 74896be40c17..0e08ca6e0264 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -157,6 +157,8 @@ static bool nvme_path_is_disabled(struct nvme_ns *ns)
 	if (test_bit(NVME_NS_ANA_PENDING, &ns->flags) ||
 	    test_bit(NVME_NS_REMOVING, &ns->flags))
 		return true;
+	if (test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ns->ctrl->flags))
+		return true;
 	return false;
 }
 
@@ -279,6 +281,8 @@ static bool nvme_available_path(struct nvme_ns_head *head)
 	struct nvme_ns *ns;
 
 	list_for_each_entry_rcu(ns, &head->list, siblings) {
+		if (test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ns->ctrl->flags))
+			continue;
 		switch (ns->ctrl->state) {
 		case NVME_CTRL_LIVE:
 		case NVME_CTRL_RESETTING:
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 566776100126..37be7d16ab15 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -304,6 +304,7 @@ struct nvme_ctrl {
 	struct work_struct scan_work;
 	struct work_struct async_event_work;
 	struct delayed_work ka_work;
+	struct delayed_work failfast_work;
 	struct nvme_command ka_cmd;
 	struct work_struct fw_act_work;
 	unsigned long events;
@@ -337,6 +338,8 @@ struct nvme_ctrl {
 	u16 icdoff;
 	u16 maxcmd;
 	int nr_reconnects;
+	unsigned long flags;
+#define NVME_CTRL_FAILFAST_EXPIRED	0
 	struct nvmf_ctrl_options *opts;
 
 	struct page *discard_page;
-- 
2.16.4


--------------BC5F926006407B4D3E669565
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--------------BC5F926006407B4D3E669565--

