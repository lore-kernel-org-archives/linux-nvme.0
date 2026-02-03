Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB1C0E87859
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Feb 2026 19:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2/Mi8mqqtpMlQ6U0+4KsMZZjH7saSPATz+Oc7ONk0U4=; b=2/iTwbwq7mxrQPzC2/E2DpzdTU
	/WpIm25Mm6eS7WCorKA2MsAArrfRe/zM4gL42orQ7aQBRGIhhiFgmCusOZr2ZavfOA0lW6s/l5qcf
	LojH2OXpaKS27TXnOeYaROerGXoVsRVwzSyXHCV8nXSMCPPQ7cSbHHGc+OD4GlgrN3/TtbTWZdI1z
	yBoTVwocZI3trPK+ZpD++pAVDjoOd+UPkGGAEw0uwfan1LzSTwo/o8RGf8BeKdAreeedIWB46R5Wc
	H8+L74c7g2DBKPf6eK/tpDEsBnb/8CsrmhOHzEUw92IFsJflO8NE1yfBeO3l6rNZGkAXqf3xU2d8X
	JHEFEZSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnLw1-00000007E0p-0JGE;
	Tue, 03 Feb 2026 19:19:37 +0000
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnLvx-00000007E0R-2YYD
	for linux-nvme@lists.infradead.org;
	Tue, 03 Feb 2026 19:19:35 +0000
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-45c93313721so3895543b6e.2
        for <linux-nvme@lists.infradead.org>; Tue, 03 Feb 2026 11:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770146372; x=1770751172; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2/Mi8mqqtpMlQ6U0+4KsMZZjH7saSPATz+Oc7ONk0U4=;
        b=TZ5fzXaDoxvewnzguPyeEjzNwhFEvqe8RmzwqT1OwFGrC6PoXFIrvbEulyk8dFK+I0
         Kgk8vencWxTYYZx6u6guVybhWdkMYUAqcX9Pidmiiq230WcLOWIYg19HJHRMEVH9wTLo
         Vg3fOQGKkOlpGhaUqGWyPk8lSa8Yoav+anhJ18l1aS9vVa2QkQt7ZavlvWupxy9dOcyx
         ASOXByyeAUKQKg6fTBTqU+8V6IRVWCefo8AqLvyLH+h5rfaZypm7zXBHrX8tsDAQDKoH
         KzocxL1vlcIFyOERT6IwfPXLxzOLDmIvghvPK9pYih4Nvkw/lplyAqblE64RaM55StGg
         xnaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770146372; x=1770751172;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2/Mi8mqqtpMlQ6U0+4KsMZZjH7saSPATz+Oc7ONk0U4=;
        b=kuCoseH63ifaPP7np2YetdR/lZ4RdNmafytUp9+DUCvCiU2t6U9U7GWrBGSnOBISQC
         aZZCFGxzYt/UHOi1ADUJ8/6qC07PWXUL6TCZBtaVIbzsqe6mgkj1swmM5WOaAJRWHVF4
         dZ4Zl/QLYKk2A0zm1ATUXchGE5eIEJ6BagBAlOfbuGSzjuBP+m0BytfdCdex3dIjkVlu
         gvViJf4QIYXDerpOFCHlrTAybeobGIKBwJtNGqJGpI5DRgeJzhpFS2QlH/jJEsYIM6TG
         YACJP47bDH08x5dZ/X/1+bOSJj5RU8SyGvWfm5c8mYfXgEoWsPloyTvGVz0uIeJV4n37
         KLew==
X-Forwarded-Encrypted: i=1; AJvYcCX/OitOhZTA6hFneOnO58B818wAmVhOf7809Teu6jngnwWNAfw7JV73uJQ34FzIGZWGM7XpaECE7M4U@lists.infradead.org
X-Gm-Message-State: AOJu0Yw1Pn3CI0f14spNO+ydbZSlCRqM0rI3jlqomXYM4/Sr0AMQ0fLB
	aXb7q44Xd38wM58/q47D9Rxlel+XAYN7HwGOlwcDF8Zp0WKsoRIj1oeu
X-Gm-Gg: AZuq6aIqTHkX1NllIVsgR/9NeELO7KDk8EaNZVbZgFSh6DT8wjYiVxqfm2ERfFopA5E
	8oQQRVakSvB53cpQoNLVj8daMNddCqDDgjaYzPHMP5mPZfq9Fj4rofTkjaIpVfgIGzeUXMhGL4u
	ItfajF4sFqwd5hGmnDRJADZIHQ7SmsoJgdMSih0UcCMBefW+dlr9BMf1OMPblGvGkH1nMs7AHLG
	DLDSKt3iZIBGAD1lFKKQc2Jj30MNCFpzS6gT2hKjjO/v2EEzU/hkh5eJcerECFELSWG0MAqoLI8
	0z/0f5VUP8lTPkYtsrruiqR9vKrrxn5wIBAkK/LS8Df+XzFbEAZsFMbtiD864WwQpvJi7wZ65kL
	RaeD+j1g/KrbB8pK/Tx0ABL69+32DAX2s9j4xy9CBCu0BAo86efxJpgy8WB7x+w3dXBlP9n0UOe
	zjjm+0nKROX7uJbwRE
X-Received: by 2002:a05:6808:4f4e:b0:45a:770c:d77b with SMTP id 5614622812f47-462d59edd49mr250710b6e.35.1770146372054;
        Tue, 03 Feb 2026 11:19:32 -0800 (PST)
Received: from [10.69.37.27] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-462d680ca17sm93947b6e.22.2026.02.03.11.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 11:19:31 -0800 (PST)
Message-ID: <383bbbe9-6cf5-465c-8811-0dddce34f883@gmail.com>
Date: Tue, 3 Feb 2026 11:19:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: James Smart <jsmart833426@gmail.com>
Subject: Re: [PATCH v2 12/14] nvme-fc: Decouple error recovery from controller
 reset
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Cc: Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jsmart833426@gmail.com
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-13-mkhalfella@purestorage.com>
Content-Language: en-US
In-Reply-To: <20260130223531.2478849-13-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260203_111933_675410_A2FA84E0 
X-CRM114-Status: GOOD (  44.06  )
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

On 1/30/2026 2:34 PM, Mohamed Khalfella wrote:
> nvme_fc_error_recovery() called from nvme_fc_timeout() while controller
> in CONNECTING state results in deadlock reported in link below. Update
> nvme_fc_timeout() to schedule error recovery to avoid the deadlock.
> 
> Previous to this change if controller was LIVE error recovery resets
> the controller and this does not match nvme-tcp and nvme-rdma.

It is not intended to match tcp/rda. Using the reset path was done to 
avoid code duplication of paths to teardown the association.  FC, given 
we interact with an HBA for device and io state and have a lot of async 
io completions, requires a lot more work than straight data structure 
teardown in rdma/tcp.

I agree with wanting to changeup the execution thread for the deadlock.


> Decouple> error recovery from controller reset to match other fabric transports.>
> Link: https://lore.kernel.org/all/20250529214928.2112990-1-mkhalfella@purestorage.com/
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   drivers/nvme/host/fc.c | 94 ++++++++++++++++++------------------------
>   1 file changed, 41 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 6948de3f438a..f8f6071b78ed 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -227,6 +227,8 @@ static DEFINE_IDA(nvme_fc_ctrl_cnt);
>   static struct device *fc_udev_device;
>   
>   static void nvme_fc_complete_rq(struct request *rq);
> +static void nvme_fc_start_ioerr_recovery(struct nvme_fc_ctrl *ctrl,
> +					 char *errmsg);
>   
>   /* *********************** FC-NVME Port Management ************************ */
>   
> @@ -788,7 +790,7 @@ nvme_fc_ctrl_connectivity_loss(struct nvme_fc_ctrl *ctrl)
>   		"Reconnect", ctrl->cnum);
>   
>   	set_bit(ASSOC_FAILED, &ctrl->flags);
> -	nvme_reset_ctrl(&ctrl->ctrl);
> +	nvme_fc_start_ioerr_recovery(ctrl, "Connectivity Loss");
>   }
>   
>   /**
> @@ -985,7 +987,7 @@ fc_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
>   static void nvme_fc_ctrl_put(struct nvme_fc_ctrl *);
>   static int nvme_fc_ctrl_get(struct nvme_fc_ctrl *);
>   
> -static void nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg);
> +static void nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl);
>   
>   static void
>   __nvme_fc_finish_ls_req(struct nvmefc_ls_req_op *lsop)
> @@ -1567,9 +1569,8 @@ nvme_fc_ls_disconnect_assoc(struct nvmefc_ls_rcv_op *lsop)
>   	 * for the association have been ABTS'd by
>   	 * nvme_fc_delete_association().
>   	 */
> -
> -	/* fail the association */
> -	nvme_fc_error_recovery(ctrl, "Disconnect Association LS received");
> +	nvme_fc_start_ioerr_recovery(ctrl,
> +				     "Disconnect Association LS received");
>   
>   	/* release the reference taken by nvme_fc_match_disconn_ls() */
>   	nvme_fc_ctrl_put(ctrl);
> @@ -1871,7 +1872,7 @@ nvme_fc_ctrl_ioerr_work(struct work_struct *work)
>   	struct nvme_fc_ctrl *ctrl =
>   			container_of(work, struct nvme_fc_ctrl, ioerr_work);
>   
> -	nvme_fc_error_recovery(ctrl, "transport detected io error");
> +	nvme_fc_error_recovery(ctrl);

hmm.. not sure how I feel about this. There is at least a break in reset 
processing that is no longer present - e.g. prior queued ioerr_work, 
which would then queue reset_work. This effectively calls the reset_work 
handler directly. I assume it should be ok.

>   }
>   
>   /*
> @@ -1892,6 +1893,17 @@ char *nvme_fc_io_getuuid(struct nvmefc_fcp_req *req)
>   }
>   EXPORT_SYMBOL_GPL(nvme_fc_io_getuuid);
>   
> +static void nvme_fc_start_ioerr_recovery(struct nvme_fc_ctrl *ctrl,
> +					 char *errmsg)
> +{
> +	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
> +		return;
 > +> +	dev_warn(ctrl->ctrl.device, "NVME-FC{%d}: starting error 
recovery %s\n",
> +		 ctrl->cnum, errmsg);
> +	queue_work(nvme_reset_wq, &ctrl->ioerr_work);
> +}
> +

Disagree with this.

The clause in error_recovery around the CONNECTING state is pretty 
important to terminate io occurring during connect/reconnect where the 
ctrl state should not change. we don't want start_ioerr making it RESETTING.

This should be reworked.

>   static void
>   nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
>   {
> @@ -2049,9 +2061,8 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
>   		nvme_fc_complete_rq(rq);
>   
>   check_error:
> -	if (terminate_assoc &&
> -	    nvme_ctrl_state(&ctrl->ctrl) != NVME_CTRL_RESETTING)
> -		queue_work(nvme_reset_wq, &ctrl->ioerr_work);
> +	if (terminate_assoc)
> +		nvme_fc_start_ioerr_recovery(ctrl, "io error");

this is ok. the ioerr_recovery will bounce the RESETTING state if it's 
already in the state. So this is a little cleaner.

>   }
>   
>   static int
> @@ -2495,39 +2506,6 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
>   		nvme_unquiesce_admin_queue(&ctrl->ctrl);
>   }
>   
> -static void
> -nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
> -{
> -	enum nvme_ctrl_state state = nvme_ctrl_state(&ctrl->ctrl);
> -
> -	/*
> -	 * if an error (io timeout, etc) while (re)connecting, the remote
> -	 * port requested terminating of the association (disconnect_ls)
> -	 * or an error (timeout or abort) occurred on an io while creating
> -	 * the controller.  Abort any ios on the association and let the
> -	 * create_association error path resolve things.
> -	 */
> -	if (state == NVME_CTRL_CONNECTING) {
> -		__nvme_fc_abort_outstanding_ios(ctrl, true);
> -		dev_warn(ctrl->ctrl.device,
> -			"NVME-FC{%d}: transport error during (re)connect\n",
> -			ctrl->cnum);
> -		return;
> -	}

This logic needs to be preserved. Its no longer part of 
nvme_fc_start_ioerr_recovery(). Failures during CONNECTING should not be 
"fenced". They should fail immediately.

> -
> -	/* Otherwise, only proceed if in LIVE state - e.g. on first error */
> -	if (state != NVME_CTRL_LIVE)
> -		return;

This was to filter out multiple requests of the reset. I guess that is 
what happens now in start_ioerr when attempting to set state to 
RESETTING and already RESETTING.

There is a small difference here in that The existing code avoids doing 
the ctrl reset if the controller is NEW. start_ioerr will change the 
ctrl to RESETTING. I'm not sure how much of an impact that is.


> -
> -	dev_warn(ctrl->ctrl.device,
> -		"NVME-FC{%d}: transport association event: %s\n",
> -		ctrl->cnum, errmsg);
> -	dev_warn(ctrl->ctrl.device,
> -		"NVME-FC{%d}: resetting controller\n", ctrl->cnum);

I haven't paid much attention, but keeping the transport messages for 
these cases is very very useful for diagnosis.

> -
> -	nvme_reset_ctrl(&ctrl->ctrl);
> -}
> -
>   static enum blk_eh_timer_return nvme_fc_timeout(struct request *rq)
>   {
>   	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(rq);
> @@ -2536,24 +2514,14 @@ static enum blk_eh_timer_return nvme_fc_timeout(struct request *rq)
>   	struct nvme_fc_cmd_iu *cmdiu = &op->cmd_iu;
>   	struct nvme_command *sqe = &cmdiu->sqe;
>   
> -	/*
> -	 * Attempt to abort the offending command. Command completion
> -	 * will detect the aborted io and will fail the connection.
> -	 */
>   	dev_info(ctrl->ctrl.device,
>   		"NVME-FC{%d.%d}: io timeout: opcode %d fctype %d (%s) w10/11: "
>   		"x%08x/x%08x\n",
>   		ctrl->cnum, qnum, sqe->common.opcode, sqe->fabrics.fctype,
>   		nvme_fabrics_opcode_str(qnum, sqe),
>   		sqe->common.cdw10, sqe->common.cdw11);
> -	if (__nvme_fc_abort_op(ctrl, op))
> -		nvme_fc_error_recovery(ctrl, "io timeout abort failed");
>   
> -	/*
> -	 * the io abort has been initiated. Have the reset timer
> -	 * restarted and the abort completion will complete the io
> -	 * shortly. Avoids a synchronous wait while the abort finishes.
> -	 */
> +	nvme_fc_start_ioerr_recovery(ctrl, "io timeout");

Why get rid of the abort logic ?
Note: the error recovery/controller reset is only called when the abort 
failed.

I believe you should continue to abort the op.  The fence logic will 
kick in when the op completes later (along with other io completions). 
If nothing else, it allows a hw resource to be freed up.


>   	return BLK_EH_RESET_TIMER;
>   }
>   
> @@ -3352,6 +3320,26 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
>   	}
>   }
>   
> +static void
> +nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl)
> +{
> +	nvme_stop_keep_alive(&ctrl->ctrl);

Curious, why did the stop_keep_alive() call get added to this ?
Doesn't hurt.

I assume it was due to other transports having it as they originally 
were calling stop_ctrl, but then moved to stop_keep_alive. Shouldn't 
this be followed by flush_work((&ctrl->ctrl.async_event_work) ?

> +	nvme_stop_ctrl(&ctrl->ctrl);
> +
> +	/* will block while waiting for io to terminate */
> +	nvme_fc_delete_association(ctrl);
> +
> +	/* Do not reconnect if controller is being deleted */
> +	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
> +		return;
> +
> +	if (ctrl->rport->remoteport.port_state == FC_OBJSTATE_ONLINE) {
> +		queue_delayed_work(nvme_wq, &ctrl->connect_work, 0);
> +		return;
> +	}
> +
> +	nvme_fc_reconnect_or_delete(ctrl, -ENOTCONN);
> +}

This code and that in nvme_fc_reset_ctrl_work() need to be collapsed 
into a common helper function invoked by the 2 routines.  Also addresses 
the missing flush_delayed work in this routine.

>   
>   static const struct nvme_ctrl_ops nvme_fc_ctrl_ops = {
>   	.name			= "fc",


-- James

(new email address. can always reach me at james.smart@broadcom.com as well)


