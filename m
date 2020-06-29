Return-Path: <SRS0=U6YU=AK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F25C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 19:17:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D4D6206A5
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 19:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GrzZR/Q+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D4D6206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Dn+cjJ52WtN1mk3bcci6raOH3n+DJGgJKui4M9rStbM=; b=GrzZR/Q+SwYs5M6QfA71dnvy3
	Ba8lfpgKMQXUamCb8Q6+FYtPHOtRhaJhd7EPSBqHtuL0uvHYY9qbqhYJCIc2ARYf/BmGYwceKJFOL
	dU+fpiNtAcRseGIgMcpv7nB6eHWliw57htcIGGy8CaaTFMF93d2o1Qa/N6MxbQSnsvrXsQZDkYP2t
	DTbP/4usxRj9cYCd9EmUDlRD0iCPmlUHcrl73LMhpxCtpjnUNVthX9WX7qcQ0SnFMZI5cLXdpMCVq
	OmHsm9DF9Rj71kUWcvQFe6ylxAHSnNpEVYPCycFBo1JMlaNavmoFdQ0RNSBEtNIZKoB0eVooRSXDu
	aCvLgpqTw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jpzH0-0000Wb-Hc; Mon, 29 Jun 2020 19:16:58 +0000
Received: from mail-wr1-f65.google.com ([209.85.221.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jpzGx-0000Vm-CP
 for linux-nvme@lists.infradead.org; Mon, 29 Jun 2020 19:16:57 +0000
Received: by mail-wr1-f65.google.com with SMTP id f18so9642100wrs.0
 for <linux-nvme@lists.infradead.org>; Mon, 29 Jun 2020 12:16:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NmSfdlmFKxK+ndn/fI97t6tp3gy4jFbqw55VN6MhH9c=;
 b=JaJu7426g3hYjgQewvdtqdjmLLl0dVgv/DjpXuWJhJUhPdSdrH7VaJW+spLvdDUMyN
 VPqStJxcRACOHoUzjAo7hBCi5Z3/YNC5Gql43Rz0Unu4pxlyYzQB3WTA1/bhq+ftYZfo
 7S23sTvClPGlNvBoFSRoslL7Yn4gbRi0qgR+fNpVrr0wntKV2v1J5LGho1wrR76SY987
 dJ4R7CJ0BoXGZMwIoWdgh8L+iLGqOh316JV6RvWZvkeByAAEork3r5fDYHSPt4hV+jdV
 T/gVkTT6U8HNGnAa3ZCB4cot4airG/RGSKHibum1NS4G2OawCd+qUNPlvgWmxug6Y0eV
 U3Jg==
X-Gm-Message-State: AOAM533FHy4coaOApg4eMDOb0SlbgtKCMHOPjaY7QN0H5ZGDJFDHzywo
 danlZT7HgPUh5L3UAkGv5oR1aF+M
X-Google-Smtp-Source: ABdhPJz2D8tWSwIpAFA343Mvw45xK8WczPbcyKD/swUSMOqptizrdTYTra2/TuhYSoWYVlZxmHtT5Q==
X-Received: by 2002:adf:ef89:: with SMTP id d9mr19610666wro.124.1593458212852; 
 Mon, 29 Jun 2020 12:16:52 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:944d:12b0:5a40:4890?
 ([2601:647:4802:9070:944d:12b0:5a40:4890])
 by smtp.gmail.com with ESMTPSA id c11sm756205wmb.45.2020.06.29.12.16.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 12:16:52 -0700 (PDT)
Subject: Re: [PATCH V4] nvme-fabrics: reject I/O to offline device
To: Victor Gladkov <Victor.Gladkov@kioxia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20200302033004.19474-1-chaitanya.kulkarni@wdc.com>
 <CAOcd+r3VVcjM=deQxZYskw=E+qZN68PKAy6vL8yvyCc4FTxJgg@mail.gmail.com>
 <bb9948035bea461a8864a8cc88513e1b@kioxia.com>
 <c32f734c29e34ab6a419e2b1215e71ae@kioxia.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b9fca7a9-218f-ae62-9ecf-f56dff684a00@grimberg.me>
Date: Mon, 29 Jun 2020 12:16:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <c32f734c29e34ab6a419e2b1215e71ae@kioxia.com>
Content-Language: en-US
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f3c037f..8010f83 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -137,6 +137,39 @@ int nvme_try_sched_reset(struct nvme_ctrl *ctrl)
>   }
>   EXPORT_SYMBOL_GPL(nvme_try_sched_reset);
> 
> +static void nvme_failfast_work(struct work_struct *work)
> +{
> +	struct nvme_ctrl *ctrl = container_of(to_delayed_work(work),
> +			struct nvme_ctrl, failfast_work);
> +
> +	spin_lock_irq(&ctrl->lock);
> +	if (ctrl->state != NVME_CTRL_CONNECTING)
> +		goto out;
> +
> +	set_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
> +	dev_info(ctrl->device, "failfast expired set for controller %s\n",
> +		ctrl->opts->subsysnqn);

What does the subsysnqn has to do with anything? just keep "failfast 
expired"

> +	nvme_kick_requeue_lists(ctrl);
> +out:
> +	spin_unlock_irq(&ctrl->lock);

What is the lock protecting against? I don't see why this is
needed.

> +}
> +
> +static inline void nvme_start_failfast_work(struct nvme_ctrl *ctrl)
> +{
> +	if (!ctrl->opts || ctrl->opts->fast_io_fail_tmo == 0)

the timeout disabled should be -1, 0 is to fail I/O right away.

Maybe also add "off" string as a -1 equivalent.

> +		return;
> +	schedule_delayed_work(&ctrl->failfast_work,
> +			      ctrl->opts->fast_io_fail_tmo * HZ);
> +}
> +
> +static inline void nvme_stop_failfast_work(struct nvme_ctrl *ctrl)
> +{
> +	if (!ctrl->opts || ctrl->opts->fast_io_fail_tmo == 0)
> +		return;
> +	cancel_delayed_work_sync(&ctrl->failfast_work);
> +	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
> +}
> +
>   int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
>   {
>   	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> @@ -387,8 +420,21 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>   	}
> 
>   	spin_unlock_irqrestore(&ctrl->lock, flags);
> -	if (changed && ctrl->state == NVME_CTRL_LIVE)
> +	if (changed) {
> +		switch (ctrl->state) {
> +		case NVME_CTRL_LIVE:
>   			nvme_kick_requeue_lists(ctrl);
> +			if (old_state == NVME_CTRL_CONNECTING)
> +				nvme_stop_failfast_work(ctrl);
> +			break;
> +		case NVME_CTRL_CONNECTING:
> +			if (old_state == NVME_CTRL_RESETTING)
> +				nvme_start_failfast_work(ctrl);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
>   	return changed;
>   }
>   EXPORT_SYMBOL_GPL(nvme_change_ctrl_state);
> @@ -4045,6 +4091,7 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
>   {
>   	nvme_mpath_stop(ctrl);
>   	nvme_stop_keep_alive(ctrl);
> +	nvme_stop_failfast_work(ctrl);
>   	flush_work(&ctrl->async_event_work);
>   	cancel_work_sync(&ctrl->fw_act_work);
>   }
> @@ -4111,6 +4158,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>   	int ret;
> 
>   	ctrl->state = NVME_CTRL_NEW;
> +	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
>   	spin_lock_init(&ctrl->lock);
>   	mutex_init(&ctrl->scan_lock);
>   	INIT_LIST_HEAD(&ctrl->namespaces);
> @@ -4125,6 +4173,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>   	init_waitqueue_head(&ctrl->state_wq);
> 
>   	INIT_DELAYED_WORK(&ctrl->ka_work, nvme_keep_alive_work);
> +	INIT_DELAYED_WORK(&ctrl->failfast_work, nvme_failfast_work);
>   	memset(&ctrl->ka_cmd, 0, sizeof(ctrl->ka_cmd));
>   	ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 2a6c819..3a39714 100644
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
> @@ -751,6 +754,19 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   				pr_warn("ctrl_loss_tmo < 0 will reconnect forever\n");
>   			ctrl_loss_tmo = token;
>   			break;
> +		case NVMF_OPT_FAIL_FAST_TMO:
> +			if (match_int(args, &token)) {
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +
> +			if (token)
> +				pr_warn("fail_fast_tmo != 0, I/O will fail on"
> +					" reconnect controller after %d sec\n",
> +					token);
> +
> +			opts->fast_io_fail_tmo = token;
> +			break;

Again, -1 should disable, not 0.

>   		case NVMF_OPT_HOSTNQN:
>   			if (opts->host) {
>   				pr_err("hostnqn already user-assigned: %s\n",
> @@ -881,11 +897,14 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   		opts->nr_poll_queues = 0;
>   		opts->duplicate_connect = true;
>   	}
> -	if (ctrl_loss_tmo < 0)
> +	if (ctrl_loss_tmo < 0) {
>   		opts->max_reconnects = -1;
> -	else
> -		opts->max_reconnects = DIV_ROUND_UP(ctrl_loss_tmo,
> -						opts->reconnect_delay);
> +	} else {
> +		if (ctrl_loss_tmo < opts->fast_io_fail_tmo)
> +			pr_warn("failfast tmo (%d) larger than controller "
> +				"loss tmo (%d)\n",
> +				opts->fast_io_fail_tmo, ctrl_loss_tmo);
> +	}

it can be that ctrl_loss_tmo=-1 which means reconnect forever.

> 
>   	if (!opts->host) {
>   		kref_get(&nvmf_default_host->ref);
> @@ -985,7 +1004,8 @@ void nvmf_free_options(struct nvmf_ctrl_options *opts)
>   #define NVMF_ALLOWED_OPTS	(NVMF_OPT_QUEUE_SIZE | NVMF_OPT_NR_IO_QUEUES | \
>   				 NVMF_OPT_KATO | NVMF_OPT_HOSTNQN | \
>   				 NVMF_OPT_HOST_ID | NVMF_OPT_DUP_CONNECT | \
> -				 NVMF_OPT_DISABLE_SQFLOW)
> +				 NVMF_OPT_DISABLE_SQFLOW | \
> +				 NVMF_OPT_FAIL_FAST_TMO)
> 
>   static struct nvme_ctrl *
>   nvmf_create_ctrl(struct device *dev, const char *buf)
> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
> index a0ec40a..a078dde 100644
> --- a/drivers/nvme/host/fabrics.h
> +++ b/drivers/nvme/host/fabrics.h
> @@ -15,6 +15,8 @@
>   #define NVMF_DEF_RECONNECT_DELAY	10
>   /* default to 600 seconds of reconnect attempts before giving up */
>   #define NVMF_DEF_CTRL_LOSS_TMO		600
> +/* default is 0: the fail fast mechanism is disable  */
> +#define NVMF_DEF_FAIL_FAST_TMO		0
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
> +	unsigned int		fast_io_fail_tmo;
>   };
> 
>   /*
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 54603bd..4b66504 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -278,9 +278,13 @@ static bool nvme_available_path(struct nvme_ns_head *head)
> 
>   	list_for_each_entry_rcu(ns, &head->list, siblings) {
>   		switch (ns->ctrl->state) {
> +		case NVME_CTRL_CONNECTING:
> +			if (test_bit(NVME_CTRL_FAILFAST_EXPIRED,
> +				     &ns->ctrl->flags))
> +				break;
> +			/* fallthru */

I absolutely don't see why this needs to happen. this setting is
on a controller, so this absolutely should not affect the mpath
device node. so nak on this.

>   		case NVME_CTRL_LIVE:
>   		case NVME_CTRL_RESETTING:
> -		case NVME_CTRL_CONNECTING:
>   			/* fallthru */
>   			return true;
>   		default:
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 2e04a36..9112886 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -256,6 +256,7 @@ struct nvme_ctrl {
>   	struct work_struct scan_work;
>   	struct work_struct async_event_work;
>   	struct delayed_work ka_work;
> +	struct delayed_work failfast_work;
>   	struct nvme_command ka_cmd;
>   	struct work_struct fw_act_work;
>   	unsigned long events;
> @@ -290,6 +291,8 @@ struct nvme_ctrl {
>   	u16 icdoff;
>   	u16 maxcmd;
>   	int nr_reconnects;
> +	unsigned long flags;
> +#define NVME_CTRL_FAILFAST_EXPIRED	0
>   	struct nvmf_ctrl_options *opts;
> 
>   	struct page *discard_page;
> --
> 1.8.3.1
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
