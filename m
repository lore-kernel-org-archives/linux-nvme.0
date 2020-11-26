Return-Path: <SRS0=VgBB=FA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AFAC56202
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 01:50:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54A4C206F7
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 01:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uE2TRmcO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54A4C206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6Bg5nEbVvd+M6hR7beTBwUS5vKATKG/z5w20VuKwAZE=; b=uE2TRmcOZn9B5NojX6NWgZZ5q
	4RNgxZsYToUP9aOde8PpMsPB92THtD3qMl7L4MoMZyvkUmfCSPt9+iRZ8J12Byn46zTqLIZg/u1UR
	vsgnZV9z4F6ZfbabTGW3RIRjDA//sqe/pIE3/04dL4MIJZYxGBpNFW1huY5jdLGbP9Nj5Ooq+4Ygk
	vf4BorYN2f6AG0v2EXfSZidUxJ0DK0d76ylb0zBvoQqbZTJSdkWHeEcKMpYF5WyaIIe9I5oY5vaUr
	qZt5ZA6lfxUJz2XImJj72nMtg3lxviqA1zq7UoYDyBBbJzHLidKB8q//ONZ/ZhCVydvxz0HZlH98H
	l+kkMwuzA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ki6Qd-00023j-JN; Thu, 26 Nov 2020 01:50:35 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ki6QZ-000233-B2
 for linux-nvme@lists.infradead.org; Thu, 26 Nov 2020 01:50:33 +0000
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.53])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ChLKt2DPbz4xrw;
 Thu, 26 Nov 2020 09:49:54 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Thu, 26 Nov 2020 09:50:21 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Thu, 26
 Nov 2020 09:50:19 +0800
Subject: Re: [PATCH v11] nvme-fabrics: reject I/O to offline device
To: Victor Gladkov <Victor.Gladkov@kioxia.com>, Christoph Hellwig
 <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
References: <bf6b3ed97dec401ab9ba9626d7764ab1@kioxia.com>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <4cfe3787-659c-8300-609a-d6cb2901e04e@huawei.com>
Date: Thu, 26 Nov 2020 09:50:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <bf6b3ed97dec401ab9ba9626d7764ab1@kioxia.com>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme709-chm.china.huawei.com (10.1.199.105) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201125_205032_401222_E4ACA6EA 
X-CRM114-Status: GOOD (  50.41  )
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
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 Hannes Reinecke <hare@suse.de>, "Ewan D. Milne" <emilne@redhat.com>, Sagi
 Grimberg <sagi@grimberg.me>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good. It might be better to add fast_io_fail_tmo to nvme_dev_attrs
so that it can be viewed and modified dynamically.

Reviewed-by: Chao Leng <lengchao@huawei.com>

On 2020/11/25 2:34, Victor Gladkov wrote:
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
> Changes from V10:
> 
> 1. Fix patch apply issue for nvme-5.11
> 
> Changes from V9:
> 
> 1. Updated to branch nvme-5.11
> 
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
>   drivers/nvme/host/core.c      | 46 ++++++++++++++++++++++++++++++++++-
>   drivers/nvme/host/fabrics.c   | 25 ++++++++++++++++---
>   drivers/nvme/host/fabrics.h   |  5 ++++
>   drivers/nvme/host/multipath.c |  2 ++
>   drivers/nvme/host/nvme.h      |  3 +++
>   5 files changed, 77 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index fff90200497c..9c1645f28a7a 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -148,6 +148,38 @@ int nvme_try_sched_reset(struct nvme_ctrl *ctrl)
>   }
>   EXPORT_SYMBOL_GPL(nvme_try_sched_reset);
>   
> +static void nvme_failfast_work(struct work_struct *work)
> +{
> +	struct nvme_ctrl *ctrl = container_of(to_delayed_work(work),
> +			struct nvme_ctrl, failfast_work);
> +
> +	if (ctrl->state != NVME_CTRL_CONNECTING)
> +		return;
> +
> +	set_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
> +	dev_info(ctrl->device, "failfast expired\n");
> +	nvme_kick_requeue_lists(ctrl);
> +}
> +
> +static inline void nvme_start_failfast_work(struct nvme_ctrl *ctrl)
> +{
> +	if (!ctrl->opts || ctrl->opts->fast_io_fail_tmo == -1)
> +		return;
> +
> +	schedule_delayed_work(&ctrl->failfast_work,
> +			      ctrl->opts->fast_io_fail_tmo * HZ);
> +}
> +
> +static inline void nvme_stop_failfast_work(struct nvme_ctrl *ctrl)
> +{
> +	if (!ctrl->opts)
> +		return;
> +
> +	cancel_delayed_work_sync(&ctrl->failfast_work);
> +	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
> +}
> +
> +
>   int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
>   {
>   	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> @@ -433,8 +465,17 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>   	}
>   
>   	spin_unlock_irqrestore(&ctrl->lock, flags);
> -	if (changed && ctrl->state == NVME_CTRL_LIVE)
> +	if (!changed)
> +		return false;
> +
> +	if (ctrl->state == NVME_CTRL_LIVE) {
> +		if (old_state == NVME_CTRL_CONNECTING)
> +			nvme_stop_failfast_work(ctrl);
>   		nvme_kick_requeue_lists(ctrl);
> +	} else if (ctrl->state == NVME_CTRL_CONNECTING &&
> +		old_state == NVME_CTRL_RESETTING) {
> +		nvme_start_failfast_work(ctrl);
> +	}
>   	return changed;
>   }
>   EXPORT_SYMBOL_GPL(nvme_change_ctrl_state);
> @@ -4372,6 +4413,7 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
>   {
>   	nvme_mpath_stop(ctrl);
>   	nvme_stop_keep_alive(ctrl);
> +	nvme_stop_failfast_work(ctrl);
>   	flush_work(&ctrl->async_event_work);
>   	cancel_work_sync(&ctrl->fw_act_work);
>   }
> @@ -4437,6 +4479,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>   	int ret;
>   
>   	ctrl->state = NVME_CTRL_NEW;
> +	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
>   	spin_lock_init(&ctrl->lock);
>   	mutex_init(&ctrl->scan_lock);
>   	INIT_LIST_HEAD(&ctrl->namespaces);
> @@ -4453,6 +4496,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>   	init_waitqueue_head(&ctrl->state_wq);
>   
>   	INIT_DELAYED_WORK(&ctrl->ka_work, nvme_keep_alive_work);
> +	INIT_DELAYED_WORK(&ctrl->failfast_work, nvme_failfast_work);
>   	memset(&ctrl->ka_cmd, 0, sizeof(ctrl->ka_cmd));
>   	ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;
>   
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 8575724734e0..72ac00173500 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -549,6 +549,7 @@ blk_status_t nvmf_fail_nonready_command(struct nvme_ctrl *ctrl,
>   {
>   	if (ctrl->state != NVME_CTRL_DELETING_NOIO &&
>   	    ctrl->state != NVME_CTRL_DEAD &&
> +	    !test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags) &&
>   	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
>   		return BLK_STS_RESOURCE;
>   
> @@ -615,6 +616,7 @@ static const match_table_t opt_tokens = {
>   	{ NVMF_OPT_NR_WRITE_QUEUES,	"nr_write_queues=%d"	},
>   	{ NVMF_OPT_NR_POLL_QUEUES,	"nr_poll_queues=%d"	},
>   	{ NVMF_OPT_TOS,			"tos=%d"		},
> +	{ NVMF_OPT_FAIL_FAST_TMO,	"fast_io_fail_tmo=%d"	},
>   	{ NVMF_OPT_ERR,			NULL			}
>   };
>   
> @@ -634,6 +636,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   	opts->reconnect_delay = NVMF_DEF_RECONNECT_DELAY;
>   	opts->kato = NVME_DEFAULT_KATO;
>   	opts->duplicate_connect = false;
> +	opts->fast_io_fail_tmo = NVMF_DEF_FAIL_FAST_TMO;
>   	opts->hdr_digest = false;
>   	opts->data_digest = false;
>   	opts->tos = -1; /* < 0 == use transport default */
> @@ -754,6 +757,17 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   				pr_warn("ctrl_loss_tmo < 0 will reconnect forever\n");
>   			ctrl_loss_tmo = token;
>   			break;
> +		case NVMF_OPT_FAIL_FAST_TMO:
> +			if (match_int(args, &token)) {
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +
> +			if (token >= 0)
> +				pr_warn("I/O fail on reconnect controller after %d sec\n",
> +					token);
> +			opts->fast_io_fail_tmo = token;
> +			break;
>   		case NVMF_OPT_HOSTNQN:
>   			if (opts->host) {
>   				pr_err("hostnqn already user-assigned: %s\n",
> @@ -884,11 +898,15 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   		opts->nr_poll_queues = 0;
>   		opts->duplicate_connect = true;
>   	}
> -	if (ctrl_loss_tmo < 0)
> +	if (ctrl_loss_tmo < 0) {
>   		opts->max_reconnects = -1;
> -	else
> +	} else {
>   		opts->max_reconnects = DIV_ROUND_UP(ctrl_loss_tmo,
>   						opts->reconnect_delay);
> +		if (ctrl_loss_tmo < opts->fast_io_fail_tmo)
> +			pr_warn("failfast tmo (%d) larger than controller loss tmo (%d)\n",
> +				opts->fast_io_fail_tmo, ctrl_loss_tmo);
> +	}
>   
>   	if (!opts->host) {
>   		kref_get(&nvmf_default_host->ref);
> @@ -988,7 +1006,8 @@ EXPORT_SYMBOL_GPL(nvmf_free_options);
>   #define NVMF_ALLOWED_OPTS	(NVMF_OPT_QUEUE_SIZE | NVMF_OPT_NR_IO_QUEUES | \
>   				 NVMF_OPT_KATO | NVMF_OPT_HOSTNQN | \
>   				 NVMF_OPT_HOST_ID | NVMF_OPT_DUP_CONNECT |\
> -				 NVMF_OPT_DISABLE_SQFLOW)
> +				 NVMF_OPT_DISABLE_SQFLOW |\
> +				 NVMF_OPT_FAIL_FAST_TMO)
>   
>   static struct nvme_ctrl *
>   nvmf_create_ctrl(struct device *dev, const char *buf)
> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
> index a9c1e3b4585e..733010d2eafd 100644
> --- a/drivers/nvme/host/fabrics.h
> +++ b/drivers/nvme/host/fabrics.h
> @@ -15,6 +15,8 @@
>   #define NVMF_DEF_RECONNECT_DELAY	10
>   /* default to 600 seconds of reconnect attempts before giving up */
>   #define NVMF_DEF_CTRL_LOSS_TMO		600
> +/* default is -1: the fail fast mechanism is disabled  */
> +#define NVMF_DEF_FAIL_FAST_TMO		-1
>   
>   /*
>    * Define a host as seen by the target.  We allocate one at boot, but also
> @@ -56,6 +58,7 @@ enum {
>   	NVMF_OPT_NR_WRITE_QUEUES = 1 << 17,
>   	NVMF_OPT_NR_POLL_QUEUES = 1 << 18,
>   	NVMF_OPT_TOS		= 1 << 19,
> +	NVMF_OPT_FAIL_FAST_TMO	= 1 << 20,
>   };
>   
>   /**
> @@ -89,6 +92,7 @@ enum {
>    * @nr_write_queues: number of queues for write I/O
>    * @nr_poll_queues: number of queues for polling I/O
>    * @tos: type of service
> + * @fast_io_fail_tmo: Fast I/O fail timeout in seconds
>    */
>   struct nvmf_ctrl_options {
>   	unsigned		mask;
> @@ -111,6 +115,7 @@ struct nvmf_ctrl_options {
>   	unsigned int		nr_write_queues;
>   	unsigned int		nr_poll_queues;
>   	int			tos;
> +	int			fast_io_fail_tmo;
>   };
>   
>   /*
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 74896be40c17..71696819c228 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -279,6 +279,8 @@ static bool nvme_available_path(struct nvme_ns_head *head)
>   	struct nvme_ns *ns;
>   
>   	list_for_each_entry_rcu(ns, &head->list, siblings) {
> +		if (test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ns->ctrl->flags))
> +			continue;
>   		switch (ns->ctrl->state) {
>   		case NVME_CTRL_LIVE:
>   		case NVME_CTRL_RESETTING:
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 83fb30e317e0..ae017f727798 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -305,6 +305,7 @@ struct nvme_ctrl {
>   	struct work_struct scan_work;
>   	struct work_struct async_event_work;
>   	struct delayed_work ka_work;
> +	struct delayed_work failfast_work;
>   	struct nvme_command ka_cmd;
>   	struct work_struct fw_act_work;
>   	unsigned long events;
> @@ -338,6 +339,8 @@ struct nvme_ctrl {
>   	u16 icdoff;
>   	u16 maxcmd;
>   	int nr_reconnects;
> +	unsigned long flags;
> +#define NVME_CTRL_FAILFAST_EXPIRED	0
>   	struct nvmf_ctrl_options *opts;
>   
>   	struct page *discard_page;
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
