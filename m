Return-Path: <SRS0=dhBa=DI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB3BC4727C
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Oct 2020 08:55:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0916F20B1F
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Oct 2020 08:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s/ty3owN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0916F20B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QGxIk3i9GB/vNYoEqIklofv3PoVQE5VsztR9dDuUSsQ=; b=s/ty3owNdhBR4qVb9t8x7xIZE
	R8TaSOQRPqyxj2e9d/FLl7j5zaPGQUJhnBEheomBSdZ/LyeWdh2SiwreUJpb3D1+bu0S4HdQh8b9q
	34VQcPk9fZRvGEUyIAhrK1GnCcswg70e5IxDFLHpS0xFTzBihiG6VJFMc5Y6LN/TePHTQakxYgq7T
	qt4gATw4zynX3vVKO19aANGIf4ANo3Fj8fGQChc325X1xUdd9h16TRqj1CEBq/ogFcUpHqnI4uel+
	DDtl9ENWueoEn5DVgP66x/bf3SBRQmsr023uzTaFGqj2Xu0ZUgYY8ExlT66JF3MC7/Jx7nd6upMBa
	Q/MqIJCtg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNuMl-00077w-05; Thu, 01 Oct 2020 08:55:07 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNuMh-00076c-P0
 for linux-nvme@lists.infradead.org; Thu, 01 Oct 2020 08:55:05 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 2472BAD0F;
 Thu,  1 Oct 2020 08:55:01 +0000 (UTC)
Subject: Re: [PATCH v9] nvme-fabrics: reject I/O to offline device
To: Victor Gladkov <Victor.Gladkov@kioxia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <319b8b1869f34a48b26fbd902883ed71@kioxia.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <b6f09a8e-e633-e303-1f39-cd380fd92f2c@suse.de>
Date: Thu, 1 Oct 2020 10:55:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <319b8b1869f34a48b26fbd902883ed71@kioxia.com>
Content-Type: multipart/mixed; boundary="------------2AD3F6268F705ED1537BF947"
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201001_045504_038711_27F7EA68 
X-CRM114-Status: GOOD (  51.82  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, "Ewan D. Milne" <emilne@redhat.com>,
 James Smart <james.smart@broadcom.com>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This is a multi-part message in MIME format.
--------------2AD3F6268F705ED1537BF947
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/29/20 5:27 PM, Victor Gladkov wrote:
> Commands get stuck while Host NVMe-oF controller is in reconnect state.
> NVMe controller enters into reconnect state when it loses connection with the
> target. It tries to reconnect every 10 seconds
> (default) until successful reconnection or until reconnect time-out is reached.
> The default reconnect time out is 10 minutes.
> 
> Applications are expecting commands to complete with success or error within
> a certain timeout (30 seconds by default).  The NVMe host is enforcing that
> timeout while it is connected, never the less, during reconnection, the timeout
> is not enforced and commands may get stuck for a long period or even forever.
> 
> To fix this long delay due to the default timeout we introduce new session
> parameter "fast_io_fail_tmo". The timeout is measured in seconds from the
> controller reconnect, any command beyond that timeout is rejected. The new
> parameter value may be passed during 'connect'.
> The default value of -1 means no timeout (similar to current behavior).
> 
> We add a new controller NVME_CTRL_FAILFAST_EXPIRED and respective
> delayed work that updates the NVME_CTRL_FAILFAST_EXPIRED flag.
> 
> When the controller is entering the CONNECTING state, we schedule the
> delayed_work based on failfast timeout value. If the transition is out of
> CONNECTING, terminate delayed work item and ensure failfast_expired is
> false. If delayed work item expires then set "NVME_CTRL_FAILFAST_EXPIRED"
> flag to true.
> 
> We also update nvmf_fail_nonready_command() and
> nvme_available_path() functions with check the
> "NVME_CTRL_FAILFAST_EXPIRED" controller flag.
> 
> For multipath (function nvme_available_path()):
> The path will not be considered available if
> "NVME_CTRL_FAILFAST_EXPIRED" controller flag  is set
> and the controller in NVME_CTRL_CONNECTING state.
> This prevents commands from getting stuck
> when available paths have tried to reconnect for too long.
> 
> Signed-off-by: Victor Gladkov <victor.gladkov at kioxia.com>
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
> Reviewed-by: Hannes Reinecke <hare at suse.de>
> 
> ---
> Changes from V8:
> 
> 1. Added multipath behavior description as requested by Sagi Grimberg
>      (Fri Sep 18 16:38:58 EDT 2020)
> 
> Changes from V7:
> 
> 1. Expanded the patch description as requested by James Smart
>      (Thu Aug 13 11:00:25 EDT 2020)
> 
> Changes from V6:
> 
> 1. Changed according to Hannes Reinecke review:
>      in nvme_start_failfast_work() and nvme_stop_failfast_work() procedures.
> 
> Changes from V5:
> 
> 1. Drop the "off" string option for fast_io_fail_tmo.
> 
> Changes from V4:
> 
> 1. Remove subsysnqn from dev_info just keep "failfast expired"
>      in nvme_failfast_work().
> 2. Remove excess lock in nvme_failfast_work().
> 3. Change "timeout disabled" value to -1, '0' is to fail I/O right away now.
> 4. Add "off" string for fast_io_fail_tmo option as a -1 equivalent.
> 
> Changes from V3:
> 
> 1. BUG_FIX: Fix a bug in nvme_start_failfast_work() amd
>      nvme_stop_failfast_work() when accessing ctrl->opts as it will fail
>      for PCIe transport when is called nvme_change_ctrl_state()
>      from nvme_reset_work(), since we don't set the ctrl->opts for
>      PCIe transport.
> 2. Line wrap in nvme_start_failfast_work(), nvme_parse_option() and
>      for macro NVMF_ALLOWED_OPTS definition.
> 3. Just like all the state change code add a switch for newly
>      added state handling outside of the state machine in
>      nvme_state_change().
> 4. nvme_available_path() add /* fallthru */ after if..break inside
>      switch which is under list_for_each_entry_rcu().
> 5. Align newly added member nvmf_ctrl_options fast_io_fail_tmp.
> 6. Fix the tabs before if in nvme_available_path() and line wrap
>      for the same.
> 7. In nvme_failfast_work() use state != NVME_CTRL_CONNECTING
>      instead of == to get rid of the parentheses and avoid char > 80.
> 8. Get rid of the ";" at the end of the comment for @fast_io_fail_tmp.
> 9. Change the commit log style to match the one we have in the NVMe
>      repo.
> 
> Changes from V2:
> 
> 1. Several coding style and small fixes.
> 2. Fix the comment for NVMF_DEF_FAIL_FAST_TMO.
> 3. Don't call functionality from the state machine.
> 4. Rename fast_fail_tmo -> fast_io_fail_tmo to match SCSI
>      semantics.
> 
> Changes from V1:
> 
> 1. Add a new session parameter called "fast_fail_tmo". The timeout
>      is measured in seconds from the controller reconnect, any command
>      beyond that timeout is rejected. The new parameter value may be
>      passed during 'connect', and its default value is 30 seconds.
>      A value of 0 means no timeout (similar to current behavior).
> 2. Add a controller flag of "failfast_expired".
> 3. Add dedicated delayed_work that update the "failfast_expired"
>      controller flag.
> 4. When entering CONNECTING, schedule the delayed_work based on
>      failfast timeout value. If transition out of CONNECTING, terminate
>      delayed work item and ensure failfast_expired is false.
>      If delayed work item expires: set "failfast_expired" flag to true.
> 5. Update nvmf_fail_nonready_command() with check the
>      "failfast_expired" controller flag.
> 
> ---
>   drivers/nvme/host/core.c      | 49
> ++++++++++++++++++++++++++++++++++++++++++-
>   drivers/nvme/host/fabrics.c   | 25 +++++++++++++++++++---
>   drivers/nvme/host/fabrics.h   |  5 +++++
>   drivers/nvme/host/multipath.c |  5 ++++-
>   drivers/nvme/host/nvme.h      |  3 +++
>   5 files changed, 82 insertions(+), 5 deletions(-)
> 
I did some more experiments with this, and found that there are some 
issues with ANA handling.
If reconnect works, but the ANA state indicates that we still can't sent 
I/O (eg by still being in transitioning), we hit the 'requeueing I/O' 
state despite fast_io_fail_tmo being set. Not sure if that's the 
expected outcome.
For that it might be better to move the FAILFAST_EXPIRED bit into the 
namespace, as then we could selectively clear the bit in 
nvme_failfast_work():

@@ -151,12 +151,16 @@ EXPORT_SYMBOL_GPL(nvme_try_sched_reset);
  static void nvme_failfast_work(struct work_struct *work) {
         struct nvme_ctrl *ctrl = container_of(to_delayed_work(work),
                         struct nvme_ctrl, failfast_work);
+       struct nvme_ns *ns;

-       if (ctrl->state != NVME_CTRL_CONNECTING)
-               return;
-
-
-       set_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
+       down_read(&ctrl->namespaces_rwsem);
+       list_for_each_entry(ns, &ctrl->namespaces, list) {
+               if (ctrl->state != NVME_CTRL_LIVE ||
+                   (ns->ana_state != NVME_ANA_OPTIMIZED &&
+                    ns->ana_state != NVME_ANA_NONOPTIMIZED))
+                       set_bit(NVME_NS_FAILFAST_EXPIRED, &ns->flags);
+       }
+       up_read(&ctrl->namespaces_rwsem);
         dev_info(ctrl->device, "failfast expired\n");

...and we could leave the failfast worker running even after the 
controller transitioned to LIVE.
Cf the attached patch for details.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

--------------2AD3F6268F705ED1537BF947
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-nvme-move-FAILFAST_EXPIRED-bit-into-namespace.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-nvme-move-FAILFAST_EXPIRED-bit-into-namespace.patch"

From a9bfa1edc7566bdaac8d330cd813fe2c0d0728cb Mon Sep 17 00:00:00 2001
From: Hannes Reinecke <hare@suse.de>
Date: Thu, 1 Oct 2020 10:52:27 +0200
Subject: [PATCH] nvme: move FAILFAST_EXPIRED bit into namespace

Rather than having the FAILFAST_EXPIRED bit being a flag on the
controller move it into the namespace. This allows the failfast
mechanism to cover ANA states, too, which might indicate that
I/O isn't possible despite the controller being LIVE.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c      | 26 ++++++++++++++++----------
 drivers/nvme/host/fabrics.c   |  4 +++-
 drivers/nvme/host/multipath.c | 11 ++++++-----
 drivers/nvme/host/nvme.h      |  3 +--
 4 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0d571aa3cc97..b458508b0c91 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -151,12 +151,16 @@ EXPORT_SYMBOL_GPL(nvme_try_sched_reset);
 static void nvme_failfast_work(struct work_struct *work) {
 	struct nvme_ctrl *ctrl = container_of(to_delayed_work(work),
 			struct nvme_ctrl, failfast_work);
+	struct nvme_ns *ns;
 
-	if (ctrl->state != NVME_CTRL_CONNECTING)
-		return;
-
-
-	set_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
+	down_read(&ctrl->namespaces_rwsem);
+	list_for_each_entry(ns, &ctrl->namespaces, list) {
+		if (ctrl->state != NVME_CTRL_LIVE ||
+		    (ns->ana_state != NVME_ANA_OPTIMIZED &&
+		     ns->ana_state != NVME_ANA_NONOPTIMIZED))
+			set_bit(NVME_NS_FAILFAST_EXPIRED, &ns->flags);
+	}
+	up_read(&ctrl->namespaces_rwsem);
 	dev_info(ctrl->device, "failfast expired\n");
 	nvme_kick_requeue_lists(ctrl);
 }
@@ -172,11 +176,16 @@ static inline void nvme_start_failfast_work(struct nvme_ctrl *ctrl)
 
 static inline void nvme_stop_failfast_work(struct nvme_ctrl *ctrl)
 {
+	struct nvme_ns *ns;
+
 	if (!ctrl->opts)
 		return;
 
 	cancel_delayed_work_sync(&ctrl->failfast_work);
-	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
+	down_read(&ctrl->namespaces_rwsem);
+	list_for_each_entry(ns, &ctrl->namespaces, list)
+		clear_bit(NVME_NS_FAILFAST_EXPIRED, &ns->flags);
+	up_read(&ctrl->namespaces_rwsem);
 }
 
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
@@ -391,11 +400,9 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 	switch (new_state) {
 	case NVME_CTRL_LIVE:
 		switch (old_state) {
-		case NVME_CTRL_CONNECTING:
-			nvme_stop_failfast_work(ctrl);
-			fallthrough;
 		case NVME_CTRL_NEW:
 		case NVME_CTRL_RESETTING:
+		case NVME_CTRL_CONNECTING:
 			changed = true;
 			fallthrough;
 		default:
@@ -4482,7 +4489,6 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	int ret;
 
 	ctrl->state = NVME_CTRL_NEW;
-	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
 	spin_lock_init(&ctrl->lock);
 	mutex_init(&ctrl->scan_lock);
 	INIT_LIST_HEAD(&ctrl->namespaces);
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 6404cbf41c96..d706fb5c3b19 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -547,9 +547,11 @@ static struct nvmf_transport_ops *nvmf_lookup_transport(
 blk_status_t nvmf_fail_nonready_command(struct nvme_ctrl *ctrl,
 		struct request *rq)
 {
+	struct nvme_ns *ns = rq->rq_disk->private_data;
+
 	if (ctrl->state != NVME_CTRL_DELETING_NOIO &&
 	    ctrl->state != NVME_CTRL_DEAD &&
-	    !test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags) &&
+	    !test_bit(NVME_NS_FAILFAST_EXPIRED, &ns->flags) &&
 	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
 		return BLK_STS_RESOURCE;
 
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 0e08ca6e0264..2738f08b2a07 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -155,9 +155,8 @@ static bool nvme_path_is_disabled(struct nvme_ns *ns)
 	    ns->ctrl->state != NVME_CTRL_DELETING)
 		return true;
 	if (test_bit(NVME_NS_ANA_PENDING, &ns->flags) ||
-	    test_bit(NVME_NS_REMOVING, &ns->flags))
-		return true;
-	if (test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ns->ctrl->flags))
+	    test_bit(NVME_NS_REMOVING, &ns->flags) ||
+	    test_bit(NVME_NS_FAILFAST_EXPIRED, &ns->flags))
 		return true;
 	return false;
 }
@@ -281,7 +280,7 @@ static bool nvme_available_path(struct nvme_ns_head *head)
 	struct nvme_ns *ns;
 
 	list_for_each_entry_rcu(ns, &head->list, siblings) {
-		if (test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ns->ctrl->flags))
+		if (test_bit(NVME_NS_FAILFAST_EXPIRED, &ns->flags))
 			continue;
 		switch (ns->ctrl->state) {
 		case NVME_CTRL_LIVE:
@@ -490,8 +489,10 @@ static void nvme_update_ns_ana_state(struct nvme_ana_group_desc *desc,
 	ns->ana_state = desc->state;
 	clear_bit(NVME_NS_ANA_PENDING, &ns->flags);
 
-	if (nvme_state_is_live(ns->ana_state))
+	if (nvme_state_is_live(ns->ana_state)) {
+		clear_bit(NVME_NS_FAILFAST_EXPIRED, &ns->flags);
 		nvme_mpath_set_live(ns);
+	}
 }
 
 static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 37be7d16ab15..3163aa9fcf6d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -338,8 +338,6 @@ struct nvme_ctrl {
 	u16 icdoff;
 	u16 maxcmd;
 	int nr_reconnects;
-	unsigned long flags;
-#define NVME_CTRL_FAILFAST_EXPIRED	0
 	struct nvmf_ctrl_options *opts;
 
 	struct page *discard_page;
@@ -451,6 +449,7 @@ struct nvme_ns {
 #define NVME_NS_REMOVING	0
 #define NVME_NS_DEAD     	1
 #define NVME_NS_ANA_PENDING	2
+#define NVME_NS_FAILFAST_EXPIRED 3
 
 	struct nvme_fault_inject fault_inject;
 
-- 
2.16.4


--------------2AD3F6268F705ED1537BF947
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--------------2AD3F6268F705ED1537BF947--

