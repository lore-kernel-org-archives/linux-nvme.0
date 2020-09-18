Return-Path: <SRS0=7z9d=C3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0FCC43463
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2020 20:39:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 939C521D7F
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2020 20:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UugXbXYO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 939C521D7F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pql5edn8GJm4n9NFyJIABKosAYWsB1JHYPa9xmUNLf4=; b=UugXbXYOLNElcCUaJ3uA9ThNd
	3s4dL5yCmM1wD8ykRJwg2cbawp3hZYvxO4chEf55hMyAe4QzUSTGKr3O+Ap26jZEwo/5vQvMkYOeE
	ji3UvsgNhkQwybHMxuRITpGgpFxNx4q4Y+uv+L7W9I25uq0Hy0lPhR22hpCZfYJSiQDxsHD38900k
	jo7KQv0tTzTymK8aSYfXMhNqBvnJ6404Kdw+9WaTXdAvr+Ajx/saZTzkKNfwptTggUKLyLxxShBZK
	fEqi3p1sDdlBuWtPHEuLgNH9t/yZJW9s89Yhirg/Z7BoOE+d2ckjDIS/zgrN0IHsMScaNrbt455RO
	JylmXTuag==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kJN9w-0000rc-HS; Fri, 18 Sep 2020 20:39:08 +0000
Received: from mail-pg1-f195.google.com ([209.85.215.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kJN9q-0000rF-PP
 for linux-nvme@lists.infradead.org; Fri, 18 Sep 2020 20:39:04 +0000
Received: by mail-pg1-f195.google.com with SMTP id u13so4165358pgh.1
 for <linux-nvme@lists.infradead.org>; Fri, 18 Sep 2020 13:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HfCdvGm6q5BdQGtS29GWYsMi3BElICPinzlHLEJLcJM=;
 b=iGMzs9NuaPErdS95zDEBA7XlnJqz0jLJC22Hz/tQhSpa5cyQu9qD6GI+H/MrREgrBL
 DXMQjTxJrpNNAK7kXKoBsPW/soPj3j/4X28Fsfj9rQTMtG3Rb0CTG0bP15sMLUt1Wsw8
 J9pWBULCmxy9Bn8jBMmhbS92+b6FMuT6YC6hAsbuDr8z4WLDB0EENtUsAv8aM0joo+Gy
 VAsi0eetMybSWEgxyLHkO5zYjY5A/j5nEvvK/o1oGNpP41oeE+YnzwXKtNqTKT4soId9
 ezNuF9qU8jRiAXxAlbrLviDFKCKtUtS8W5AEQpZLDp3N+gcEDS5OB4kikQaFP2cjhkiD
 bLsA==
X-Gm-Message-State: AOAM533YFNiIAaTvqhiXnSY2c4Yj60n/qR2pEj9zO/O7G5FmiZLkNa2F
 kw2CMC5HO7FS2C08Apqyz73HI8thfGo=
X-Google-Smtp-Source: ABdhPJzhaXtjjU6Uutl1Of18XrN8by6mP8jgwZKvk3xrbEF6e6jL7QdQHhYkgXKsDe9tq6OGNmtjEA==
X-Received: by 2002:a63:ba5e:: with SMTP id l30mr28220974pgu.425.1600461541263; 
 Fri, 18 Sep 2020 13:39:01 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:c1f8:eff6:9706:30c?
 ([2601:647:4802:9070:c1f8:eff6:9706:30c])
 by smtp.gmail.com with ESMTPSA id gx5sm3576459pjb.57.2020.09.18.13.38.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2020 13:39:00 -0700 (PDT)
Subject: Re: [PATCH v8] nvme-fabrics: reject I/O to offline device
To: Victor Gladkov <Victor.Gladkov@kioxia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <0f73b032a39748c3beb8c1cb743f0783@kioxia.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <52462339-084c-90ae-4ca7-62e2ae37dd7e@grimberg.me>
Date: Fri, 18 Sep 2020 13:38:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0f73b032a39748c3beb8c1cb743f0783@kioxia.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200918_163902_863784_AF2362FA 
X-CRM114-Status: GOOD (  53.29  )
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
Cc: James Smart <james.smart@broadcom.com>, "Ewan D. Milne" <emilne@redhat.com>,
 Hannes Reinecke <hare@suse.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 9/6/20 11:21 PM, Victor Gladkov wrote:
> Commands get stuck while Host NVMe-oF controller is in reconnect
> state. NVMe controller enters into reconnect state when it loses
> connection with the target. It tries to reconnect every 10 seconds
> (default) until successful reconnection or until reconnect time-out
> is reached. The default reconnect time out is 10 minutes.
> 
> Applications are expecting commands to complete with success or error
> within a certain timeout (30 seconds by default).  The NVMe host is
> enforcing that timeout while it is connected, never the less, during
> reconnection, the timeout is not enforced and commands may get stuck
> for a long period or even forever.
> 
> To fix this long delay due to the default timeout we introduce new
> session parameter "fast_io_fail_tmo". The timeout is measured in
> seconds from the controller reconnect, any command beyond that
> timeout is rejected. The new parameter value may be passed during
> 'connect'.
> The default value of 0 means no timeout (similar to current behavior).

I think you mean here -1.

> 
> We add a new controller NVME_CTRL_FAILFAST_EXPIRED and respective
> delayed work that updates the NVME_CTRL_FAILFAST_EXPIRED flag.
> 
> When the controller is entering the CONNECTING state, we schedule
> the delayed_work based on failfast timeout value. If the transition
> is out of CONNECTING, terminate delayed work item and ensure
> failfast_expired is false. If delayed work item expires then set
> "NVME_CTRL_FAILFAST_EXPIRED" flag to true.
> 
> We also update nvmf_fail_nonready_command() and
> nvme_available_path() functions with check the
> "NVME_CTRL_FAILFAST_EXPIRED" controller flag.
> 
> Signed-off-by: Victor Gladkov <victor.gladkov at kioxia.com>
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
> Reviewed-by: Hannes Reinecke <hare at suse.de>
> 
> ---
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
>   drivers/nvme/host/core.c      | 49 ++++++++++++++++++++++++++++++++++++++++++-
>   drivers/nvme/host/fabrics.c   | 25 +++++++++++++++++++---
>   drivers/nvme/host/fabrics.h   |  5 +++++
>   drivers/nvme/host/multipath.c |  5 ++++-
>   drivers/nvme/host/nvme.h      |  3 +++
>   5 files changed, 82 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f3c037f..ca990bb 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -137,6 +137,37 @@ int nvme_try_sched_reset(struct nvme_ctrl *ctrl)
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
>   int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
>   {
>   	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> @@ -387,8 +418,21 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>   	}
> 
>   	spin_unlock_irqrestore(&ctrl->lock, flags);
> -	if (changed && ctrl->state == NVME_CTRL_LIVE)
> +	if (changed) {
> +		switch (ctrl->state) {
> +			case NVME_CTRL_LIVE:
> +				if (old_state == NVME_CTRL_CONNECTING)
> +					nvme_stop_failfast_work(ctrl);
>    				nvme_kick_requeue_lists(ctrl);
> +				break;
> +			case NVME_CTRL_CONNECTING:
> +				if (old_state == NVME_CTRL_RESETTING)
> +					nvme_start_failfast_work(ctrl);
> +				break;
> +			default:
> +				break;
> +		}
> +	}
>   	return changed;
>   }
>   EXPORT_SYMBOL_GPL(nvme_change_ctrl_state);
> @@ -4045,6 +4089,7 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
>   {
>   	nvme_mpath_stop(ctrl);
>   	nvme_stop_keep_alive(ctrl);
> +	nvme_stop_failfast_work(ctrl);
>   	flush_work(&ctrl->async_event_work);
>   	cancel_work_sync(&ctrl->fw_act_work);
>   }
> @@ -4111,6 +4156,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>   	int ret;
> 
>   	ctrl->state = NVME_CTRL_NEW;
> +	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
>   	spin_lock_init(&ctrl->lock);
>   	mutex_init(&ctrl->scan_lock);
>   	INIT_LIST_HEAD(&ctrl->namespaces);
> @@ -4125,6 +4171,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>   	init_waitqueue_head(&ctrl->state_wq);
> 
>   	INIT_DELAYED_WORK(&ctrl->ka_work, nvme_keep_alive_work);
> +	INIT_DELAYED_WORK(&ctrl->failfast_work, nvme_failfast_work);
>   	memset(&ctrl->ka_cmd, 0, sizeof(ctrl->ka_cmd));
>   	ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 2a6c819..4afe173 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -549,6 +549,7 @@ blk_status_t nvmf_fail_nonready_command(struct nvme_ctrl *ctrl,
>   {
>   	if (ctrl->state != NVME_CTRL_DELETING &&
>   	    ctrl->state != NVME_CTRL_DEAD &&
> +	    !test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags) &&
>   	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
>   		return BLK_STS_RESOURCE;
> 
> @@ -612,6 +613,7 @@ bool __nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
>   	{ NVMF_OPT_NR_WRITE_QUEUES,	"nr_write_queues=%d"	},
>   	{ NVMF_OPT_NR_POLL_QUEUES,	"nr_poll_queues=%d"	},
>   	{ NVMF_OPT_TOS,			"tos=%d"		},
> +	{ NVMF_OPT_FAIL_FAST_TMO,	"fast_io_fail_tmo=%d"	},
>   	{ NVMF_OPT_ERR,			NULL			}
>   };
> 
> @@ -631,6 +633,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   	opts->reconnect_delay = NVMF_DEF_RECONNECT_DELAY;
>   	opts->kato = NVME_DEFAULT_KATO;
>   	opts->duplicate_connect = false;
> +	opts->fast_io_fail_tmo = NVMF_DEF_FAIL_FAST_TMO;
>   	opts->hdr_digest = false;
>   	opts->data_digest = false;
>   	opts->tos = -1; /* < 0 == use transport default */
> @@ -751,6 +754,17 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
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
> +				pr_warn("I/O will fail on reconnect controller after"
> +					" %d sec\n", token);

This warning doesn't make sense. You warn the user after it requested
it ecplicitly? You should remove that.

> +			opts->fast_io_fail_tmo = token;
> +			break;

Also, please expose this timeout via sysfs.

>   		case NVMF_OPT_HOSTNQN:
>   			if (opts->host) {
>   				pr_err("hostnqn already user-assigned: %s\n",
> @@ -881,11 +895,16 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
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
> +			pr_warn("failfast tmo (%d) larger than controller "
> +				"loss tmo (%d)\n",
> +				opts->fast_io_fail_tmo, ctrl_loss_tmo);
> +	}
> 
>   	if (!opts->host) {
>   		kref_get(&nvmf_default_host->ref);
> @@ -985,7 +1004,7 @@ void nvmf_free_options(struct nvmf_ctrl_options *opts)
>   #define NVMF_ALLOWED_OPTS	(NVMF_OPT_QUEUE_SIZE | NVMF_OPT_NR_IO_QUEUES | \
>   				 NVMF_OPT_KATO | NVMF_OPT_HOSTNQN | \
>   				 NVMF_OPT_HOST_ID | NVMF_OPT_DUP_CONNECT |\
> -				 NVMF_OPT_DISABLE_SQFLOW)
> +				 NVMF_OPT_DISABLE_SQFLOW | NVMF_OPT_FAIL_FAST_TMO)
> 
>   static struct nvme_ctrl *
>   nvmf_create_ctrl(struct device *dev, const char *buf)
> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
> index a0ec40a..05a1158 100644
> --- a/drivers/nvme/host/fabrics.h
> +++ b/drivers/nvme/host/fabrics.h
> @@ -15,6 +15,8 @@
>   #define NVMF_DEF_RECONNECT_DELAY	10
>   /* default to 600 seconds of reconnect attempts before giving up */
>   #define NVMF_DEF_CTRL_LOSS_TMO		600
> +/* default is -1: the fail fast mechanism is disable  */
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
> index 54603bd..d8b7f45 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -278,9 +278,12 @@ static bool nvme_available_path(struct nvme_ns_head *head)
> 
>   	list_for_each_entry_rcu(ns, &head->list, siblings) {
>   		switch (ns->ctrl->state) {
> +		case NVME_CTRL_CONNECTING:
> +			if (test_bit(NVME_CTRL_FAILFAST_EXPIRED,
> +				     &ns->ctrl->flags))
> +				break;
>   		case NVME_CTRL_LIVE:
>   		case NVME_CTRL_RESETTING:
> -		case NVME_CTRL_CONNECTING:
>   			/* fallthru */
>   			return true;
>   		default:

This is too subtle to not document.
The parameter is a controller property, but here it will affect
the mpath device node.

This is changing the behavior of "queue as long as we have an available
path" to "queue until all our paths said to fail fast".

I guess that by default we will have the same behavior, and the
behavior will change only if all the controller have failfast parameter
tuned.

At the very least it is an important undocumented change that needs to
be called in the change log.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
