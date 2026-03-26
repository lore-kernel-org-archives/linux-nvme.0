Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2DAA109E53D
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2026 02:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k9kEmpa36Y5vTCjxOeRrg3+IOOIPShrE+kuP9CcuV2s=; b=3r6v7HNxOy2GU4yjvmBJcwCcuV
	Kh+hIsKzhYHoqJXiBFYpjV7Ku61Bxqnbzyo3d58yCEIdeYlbaS/j7+Ty0dUvViX1KEH5HykFCr8S7
	qRPwNwN396iS8X3cl/4MI6UhjxzysiB1wQNNJou+L09QuaCwRKf8EeiNXRmRLX8sKLS4OEI9d+env
	2FJhaWiGNmi692qTfQDZhBtDxAwJgpul7g4EnNQ+QbrNqgPhPRB9dARuMhJlFqRel0xtDUcM1f/RV
	3xEgE5as1U35Y+MM6NGd/KeWRo0s/M1QNoKe+/YUVBBJoHc9jhj7DPLIKumH4BjmFFeZkNWzDv2zw
	jbF6ECRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5ab0-00000004aag-1l1i;
	Thu, 26 Mar 2026 02:37:18 +0000
Received: from mail-dl1-x122a.google.com ([2607:f8b0:4864:20::122a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5aax-00000004aZt-0Vqn
	for linux-nvme@lists.infradead.org;
	Thu, 26 Mar 2026 02:37:16 +0000
Received: by mail-dl1-x122a.google.com with SMTP id a92af1059eb24-12a693cdf29so1447498c88.0
        for <linux-nvme@lists.infradead.org>; Wed, 25 Mar 2026 19:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1774492634; x=1775097434; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k9kEmpa36Y5vTCjxOeRrg3+IOOIPShrE+kuP9CcuV2s=;
        b=fXGIIjArOPZByYq1JFEYkF1TzPzgQskL3ptul+3BQvAaBiMo9Zz213xS2CxIOPSBVW
         DIGvgqa8k34Jr57JqI1E9Yaf3KmqgO2bA6rpSFbUEQmxwKFIPoekpJPiw5wHytXpWNX2
         FZE2dlQuTrW8VMvuzKDKtz0vTCazBcHt9XmGRHG4RYRJnY5VICHkwFYLwpPZF7FaKnzS
         /krvHqN4O251cajeTL8doP6leqpzdj3E/IUfY/hlPjMvHt32TKFRgBSOjCWlYLRNDGs7
         45EW158wJGQyXgAqZseMdHl/ILmaHMoo1BGn96D5IpJCbTZOD7n6faIg/Q/1HyLTc5Jl
         Pj6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774492634; x=1775097434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k9kEmpa36Y5vTCjxOeRrg3+IOOIPShrE+kuP9CcuV2s=;
        b=cRZm8tA8iFz0DXOBoLxLm0kyKNv7jZg5ujgtMTefl1uHX1XN3ova59rn71TYarREMP
         E5zlgPrW4uk2lZvkz9b/6v9fqlJjBjv0pnftN95kasqJj7xmqqsrG0sGKQ5FkD8e2eex
         zJOb1tZPlWCrPHGsRL/MT2XVLKQIebE6CRfG72maEYwONUuRkwDAQw5Cu3shg7/mjILW
         YYvafuERVROSqf1b2OBAiGZQX4+Coopk7w0tH31avaB+YvuePQYUeXe2LSgZ34TYBCnS
         g/dnoglc2wzwfvNj38vjSrF0PLmyeBPUgV1VK6nHLwzYvY8EsAdNU+125xn9AKAhq9qQ
         eETA==
X-Forwarded-Encrypted: i=1; AJvYcCVOViO9JAVAfXHRHkw5LXGrfMaSg5TC4yJyTUp064coIyaXipyRMRMr035b63IIzZ5CO+QyPoIXdkLF@lists.infradead.org
X-Gm-Message-State: AOJu0YzA3YgZtgwLSmEJjRlBsQwNRKFCt+YUcJ7oI+C0wX1auGSyN8SL
	r55Pcx9zZBVdZ3/qAiWiV7h1EYbedttZ26WpviUS4A2m68aa4EOEOPNBC+XmMLA/kzc=
X-Gm-Gg: ATEYQzwj/eiCV4Hr/RQ8TAUT8uTysd3SZq2Bhp/zoREerHIsIxyuVrUjY28W6oSwQjz
	dEa8v4JrRHAWNIiEwKiPB/Rx2BAPOzdkyDwKvur/Wh8z1zBgaJb2Tdf7guk+lGFNkyOPSWqpynY
	Rd5oHIAYjemnPf9Qfl6Rrrw9QGdn+cyTktitEJKppAOG3DSrva99dRv/+LYFWPlU+UEdV9XpNe/
	WVgNLS1wyuwtkZeYEj33S1y4qs6AuwH6SHcGroUNvvM9wME+00ZrYgl9h/9bUlrXzWe8U3ISP0z
	WYpvvvQw5dvVUrF7NdcEFmxnbNRIlLrDUhM3bxaoJmbAiKU+tRIhcTYiweWpUJaM2BHLB5MH0kI
	FiiXMAqq39DI6DvNZQDLHB+nNOQ7EMlq68lYQshbqct2a5iDYSo24U2xDDzPpiBZ6YT3Xa1fjNq
	feKrI7TfqQB81DTdZeMB8G1obJGF++k+IIlTjfy5E=
X-Received: by 2002:a05:7022:2386:b0:11b:2a5:3b9b with SMTP id a92af1059eb24-12a968676a8mr2688886c88.8.1774492633484;
        Wed, 25 Mar 2026 19:37:13 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([2601:640:8202:6fb0::9c63])
        by smtp.googlemail.com with UTF8SMTPSA id a92af1059eb24-12aa7248731sm1803130c88.4.2026.03.25.19.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 19:37:12 -0700 (PDT)
Date: Wed, 25 Mar 2026 19:37:11 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: James Smart <jsmart833426@gmail.com>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 12/21] nvme-fc: Decouple error recovery from
 controller reset
Message-ID: <20260326023711.GA724739-mkhalfella@purestorage.com>
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
 <20260214042753.4073668-13-mkhalfella@purestorage.com>
 <f3886902-12ed-4d9c-abee-0b2363a0ada8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3886902-12ed-4d9c-abee-0b2363a0ada8@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260325_193715_217277_E75FA885 
X-CRM114-Status: GOOD (  46.64  )
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

On Fri 2026-02-27 16:12:05 -0800, James Smart wrote:
> On 2/13/2026 8:25 PM, Mohamed Khalfella wrote:
> > nvme_fc_error_recovery() called from nvme_fc_timeout() while controller
> > in CONNECTING state results in deadlock reported in link below. Update
> > nvme_fc_timeout() to schedule error recovery to avoid the deadlock.
> 
> This seems misleading on what is changing...
> 
> How about:
> Add new nvme_fc_start_ioerr_recovery() routine which effectively
>    "resets" a the controller.
> Refactor error points that invoked routines that reset the controller
>    to now call nvme_fc_start_ioerr_recovery().
> Eliminated io abort on io error, as we will be resetting the controller.
> 

nvme-fc: Refactor IO error recovery

Added new nvme_fc_start_ioerr_recovery() to trigger error recovery
instead of directly queueing ctrl->ioerr_work. nvme_fc_error_recovery()
now called only from ctrl->ioerr_work has been updated to not depend on
nvme_reset_ctrl() to handle error recovery. nvme_fc_error_recovery()
effectively resets the controller and attempts reconnection if needed.
This makes nvme-fc ioerr handling similar to other fabric transports.

Update nvme_fc_timeout() to not abort timed out IOs. IOs aborted from
nvme_fc_timeout() are not accounted for in ctrl->iocnt and this causes
nvme_fc_delete_association() not to wait for them. Instead of aborting
IOs nvme_fc_timeout() calls nvme_fc_start_ioerr_recovery() to start IO
error recovery. Since error recovery runs in ctrl->ioerr_work this
change fixes the issue reported in the link below.

Above is the updated commit message. Let me know if there is any part
you want me to change before I submit v4.

> 
> > 
> > Previous to this change if controller was LIVE error recovery resets
> > the controller and this does not match nvme-tcp and nvme-rdma. Decouple
> > error recovery from controller reset to match other fabric transports.
> 
> Please delete. It's irrelevant to the patch.

Deleted.

> 
> 
> ...
> > @@ -1871,7 +1874,22 @@ nvme_fc_ctrl_ioerr_work(struct work_struct *work)
> >   	struct nvme_fc_ctrl *ctrl =
> >   			container_of(work, struct nvme_fc_ctrl, ioerr_work);
> >   
> > -	nvme_fc_error_recovery(ctrl, "transport detected io error");
> > +	/*
> > +	 * if an error (io timeout, etc) while (re)connecting, the remote
> > +	 * port requested terminating of the association (disconnect_ls)
> > +	 * or an error (timeout or abort) occurred on an io while creating
> > +	 * the controller.  Abort any ios on the association and let the
> > +	 * create_association error path resolve things.
> > +	 */
> > +	if (nvme_ctrl_state(&ctrl->ctrl) == NVME_CTRL_CONNECTING) {
> > +		__nvme_fc_abort_outstanding_ios(ctrl, true);
> > +		dev_warn(ctrl->ctrl.device,
> > +			 "NVME-FC{%d}: transport error during (re)connect\n",
> > +			 ctrl->cnum);
> > +		return;
> > +	}
> > +
> > +	nvme_fc_error_recovery(ctrl);
> >   }
> 
> ok - but see below...
> 
> 
> > +static void nvme_fc_start_ioerr_recovery(struct nvme_fc_ctrl *ctrl,
> > +					 char *errmsg)
> > +{
> > +	enum nvme_ctrl_state state;
> > +
> > +	if (nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING)) {
> > +		dev_warn(ctrl->ctrl.device, "NVME-FC{%d}: starting error recovery %s\n",
> > +			 ctrl->cnum, errmsg);
> > +		queue_work(nvme_reset_wq, &ctrl->ioerr_work);
> > +		return;
> > +	}
> > +
> > +	state = nvme_ctrl_state(&ctrl->ctrl);
> > +	if (state == NVME_CTRL_CONNECTING || state == NVME_CTRL_DELETING ||
> > +	    state == NVME_CTRL_DELETING_NOIO) {
> > +		queue_work(nvme_reset_wq, &ctrl->ioerr_work);
> > +	}
> > +}
> 
> What bothers me about this (true of the tcp and rmda transports) is 
> there is little difference between this and using the core 
> nvme_reset_ctrl(), excepting that even when the state change fails, the 
> code continues to schedule the work element that does the reset.

It does bother me too. The existance of controller reset and error
recovery as two separate and very similar codepaths has been pointed to
in emails in this very patchset. I think at some point the two codepaths
should be refactored. Until this happens the change above should be easy
to understand.

> 
> And the latter odd snippet to reset anyway is only to get the CONNECTING 
> code snippet, which failed the RESETTING transition, to be performed. 
> I'd prefer the connecting snippet be at the top of start_ioerr_recovery 
> before any state change attempt so its in the same place as prior.

Updated nvme_fc_start_ioerr_recovery() to handle the case of CONNECTING,
DELETING, DELETING_NOIO first.

> 
> 
> ...
> >   static enum blk_eh_timer_return nvme_fc_timeout(struct request *rq)
> >   {
> >   	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(rq);
> > @@ -2536,24 +2539,14 @@ static enum blk_eh_timer_return nvme_fc_timeout(struct request *rq)
> >   	struct nvme_fc_cmd_iu *cmdiu = &op->cmd_iu;
> >   	struct nvme_command *sqe = &cmdiu->sqe;
> >   
> > -	/*
> > -	 * Attempt to abort the offending command. Command completion
> > -	 * will detect the aborted io and will fail the connection.
> > -	 */
> >   	dev_info(ctrl->ctrl.device,
> >   		"NVME-FC{%d.%d}: io timeout: opcode %d fctype %d (%s) w10/11: "
> >   		"x%08x/x%08x\n",
> >   		ctrl->cnum, qnum, sqe->common.opcode, sqe->fabrics.fctype,
> >   		nvme_fabrics_opcode_str(qnum, sqe),
> >   		sqe->common.cdw10, sqe->common.cdw11);
> > -	if (__nvme_fc_abort_op(ctrl, op))
> > -		nvme_fc_error_recovery(ctrl, "io timeout abort failed");
> >   
> > -	/*
> > -	 * the io abort has been initiated. Have the reset timer
> > -	 * restarted and the abort completion will complete the io
> > -	 * shortly. Avoids a synchronous wait while the abort finishes.
> > -	 */
> > +	nvme_fc_start_ioerr_recovery(ctrl, "io timeout");
> >   	return BLK_EH_RESET_TIMER;
> >   }
> 
> I eventually gave in on not doing the abort of the io as the 
> start_ioerr_recovery() will be resetting the controller.
> 
> 
> >   
> > @@ -3352,6 +3345,27 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
> >   	}
> >   }
> >   
> > +static void
> > +nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl)
> > +{
> > +	nvme_stop_keep_alive(&ctrl->ctrl);
> > +	nvme_stop_ctrl(&ctrl->ctrl);
> > +	flush_work(&ctrl->ctrl.async_event_work);
> > +
> > +	/* will block while waiting for io to terminate */
> > +	nvme_fc_delete_association(ctrl);
> > +
> > +	/* Do not reconnect if controller is being deleted */
> > +	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
> > +		return;
> > +
> > +	if (ctrl->rport->remoteport.port_state == FC_OBJSTATE_ONLINE) {
> > +		queue_delayed_work(nvme_wq, &ctrl->connect_work, 0);
> > +		return;
> > +	}
> > +
> > +	nvme_fc_reconnect_or_delete(ctrl, -ENOTCONN);
> > +}
> >   
> >   static const struct nvme_ctrl_ops nvme_fc_ctrl_ops = {
> >   	.name			= "fc",
> 
> There is no reason to duplicate the code that is already in ioerr_work. 
> I prototyped a simple service routine. The net/net is showed what little 
> reason there is to have an ioerr_work and a reset_work - as they are 
> effectively the same. So I then eliminated ioerr_work and use reset_work 
> and the service routine (kept the nvme_fc_error_recovery() name).
> 
> 
> Here's a revised diff for this patch... I have compiled but not tested.
> 
> 
> --- fc.c.START	2026-02-27 14:10:07.631705123 -0800
> +++ fc.c	2026-02-27 15:41:09.777836476 -0800
> @@ -166,7 +166,6 @@ struct nvme_fc_ctrl {
>   	struct blk_mq_tag_set	admin_tag_set;
>   	struct blk_mq_tag_set	tag_set;
> 
> -	struct work_struct	ioerr_work;
>   	struct delayed_work	connect_work;
> 
>   	struct kref		ref;
> @@ -227,6 +226,8 @@ static DEFINE_IDA(nvme_fc_ctrl_cnt);
>   static struct device *fc_udev_device;
> 
>   static void nvme_fc_complete_rq(struct request *rq);
> +static void nvme_fc_start_ioerr_recovery(struct nvme_fc_ctrl *ctrl,
> +					char *errmsg);
> 
>   /* *********************** FC-NVME Port Management 
> ************************ */
> 
> @@ -788,7 +789,7 @@ nvme_fc_ctrl_connectivity_loss(struct nv
>   		"Reconnect", ctrl->cnum);
> 
>   	set_bit(ASSOC_FAILED, &ctrl->flags);
> -	nvme_reset_ctrl(&ctrl->ctrl);
> +	nvme_fc_start_ioerr_recovery(ctrl, "Connectivity Loss");
>   }
> 
>   /**
> @@ -985,8 +986,6 @@ fc_dma_unmap_sg(struct device *dev, stru
>   static void nvme_fc_ctrl_put(struct nvme_fc_ctrl *);
>   static int nvme_fc_ctrl_get(struct nvme_fc_ctrl *);
> 
> -static void nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char 
> *errmsg);
> -
>   static void
>   __nvme_fc_finish_ls_req(struct nvmefc_ls_req_op *lsop)
>   {
> @@ -1569,7 +1568,8 @@ nvme_fc_ls_disconnect_assoc(struct nvmef
>   	 */
> 
>   	/* fail the association */
> -	nvme_fc_error_recovery(ctrl, "Disconnect Association LS received");
> +	nvme_fc_start_ioerr_recovery(ctrl,
> +				     "Disconnect Association LS received");
> 
>   	/* release the reference taken by nvme_fc_match_disconn_ls() */
>   	nvme_fc_ctrl_put(ctrl);
> @@ -1865,15 +1865,6 @@ __nvme_fc_fcpop_chk_teardowns(struct nvm
>   	}
>   }
> 
> -static void
> -nvme_fc_ctrl_ioerr_work(struct work_struct *work)
> -{
> -	struct nvme_fc_ctrl *ctrl =
> -			container_of(work, struct nvme_fc_ctrl, ioerr_work);
> -
> -	nvme_fc_error_recovery(ctrl, "transport detected io error");
> -}
> -
>   /*
>    * nvme_fc_io_getuuid - Routine called to get the appid field
>    * associated with request by the lldd
> @@ -2049,9 +2040,8 @@ done:
>   		nvme_fc_complete_rq(rq);
> 
>   check_error:
> -	if (terminate_assoc &&
> -	    nvme_ctrl_state(&ctrl->ctrl) != NVME_CTRL_RESETTING)
> -		queue_work(nvme_reset_wq, &ctrl->ioerr_work);
> +	if (terminate_assoc)
> +		nvme_fc_start_ioerr_recovery(ctrl, "io error");
>   }
> 
>   static int
> @@ -2496,7 +2486,7 @@ __nvme_fc_abort_outstanding_ios(struct n
>   }
> 
>   static void
> -nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
> +nvme_fc_start_ioerr_recovery(struct nvme_fc_ctrl *ctrl,	char *errmsg)
>   {
>   	enum nvme_ctrl_state state = nvme_ctrl_state(&ctrl->ctrl);
> 
> @@ -2515,17 +2505,15 @@ nvme_fc_error_recovery(struct nvme_fc_ct
>   		return;
>   	}
> 
> -	/* Otherwise, only proceed if in LIVE state - e.g. on first error */
> -	if (state != NVME_CTRL_LIVE)
> +	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
>   		return;
> 
>   	dev_warn(ctrl->ctrl.device,
>   		"NVME-FC{%d}: transport association event: %s\n",
>   		ctrl->cnum, errmsg);
> -	dev_warn(ctrl->ctrl.device,
> -		"NVME-FC{%d}: resetting controller\n", ctrl->cnum);
> -
> -	nvme_reset_ctrl(&ctrl->ctrl);
> +	dev_warn(ctrl->ctrl.device, "NVME-FC{%d}: starting error recovery %s\n",
> +		 ctrl->cnum, errmsg);
> +	queue_work(nvme_reset_wq, &ctrl->ctrl.reset_work);
>   }
> 
>   static enum blk_eh_timer_return nvme_fc_timeout(struct request *rq)
> @@ -2536,24 +2524,14 @@ static enum blk_eh_timer_return nvme_fc_
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
>   	return BLK_EH_RESET_TIMER;
>   }
> 
> @@ -3264,7 +3242,7 @@ nvme_fc_delete_ctrl(struct nvme_ctrl *nc
>   	 * waiting for io to terminate
>   	 */
>   	nvme_fc_delete_association(ctrl);
> -	cancel_work_sync(&ctrl->ioerr_work);
> +	cancel_work_sync(&ctrl->ctrl.reset_work);
> 
>   	if (ctrl->ctrl.tagset)
>   		nvme_remove_io_tag_set(&ctrl->ctrl);
> @@ -3324,20 +3302,27 @@ nvme_fc_reconnect_or_delete(struct nvme_
>   }
> 
>   static void
> -nvme_fc_reset_ctrl_work(struct work_struct *work)
> +nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl)
>   {
> -	struct nvme_fc_ctrl *ctrl =
> -		container_of(work, struct nvme_fc_ctrl, ctrl.reset_work);
> -
> +	nvme_stop_keep_alive(&ctrl->ctrl);
> +	flush_work(&ctrl->ctrl.async_event_work);
>   	nvme_stop_ctrl(&ctrl->ctrl);
> 
>   	/* will block will waiting for io to terminate */
>   	nvme_fc_delete_association(ctrl);
> 
> -	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
> +	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
> +		enum nvme_ctrl_state state = nvme_ctrl_state(&ctrl->ctrl);
> +
> +		/* state change failure is ok if we started ctrl delete */
> +		if (state == NVME_CTRL_DELETING ||
> +		    state == NVME_CTRL_DELETING_NOIO)
> +			return;
> +
>   		dev_err(ctrl->ctrl.device,
> -			"NVME-FC{%d}: error_recovery: Couldn't change state "
> -			"to CONNECTING\n", ctrl->cnum);
> +			"NVME-FC{%d}: error_recovery: Couldn't change "
> +			"state to CONNECTING (%d)\n", ctrl->cnum, state);
> +	}
> 
>   	if (ctrl->rport->remoteport.port_state == FC_OBJSTATE_ONLINE) {
>   		if (!queue_delayed_work(nvme_wq, &ctrl->connect_work, 0)) {
> @@ -3352,6 +3337,15 @@ nvme_fc_reset_ctrl_work(struct work_stru
>   	}
>   }
> 
> +static void
> +nvme_fc_reset_ctrl_work(struct work_struct *work)
> +{
> +	struct nvme_fc_ctrl *ctrl =
> +		container_of(work, struct nvme_fc_ctrl, ctrl.reset_work);
> +
> +	nvme_fc_error_recovery(ctrl);
> +}
> +
> 
>   static const struct nvme_ctrl_ops nvme_fc_ctrl_ops = {
>   	.name			= "fc",
> @@ -3483,7 +3477,6 @@ nvme_fc_alloc_ctrl(struct device *dev, s
> 
>   	INIT_WORK(&ctrl->ctrl.reset_work, nvme_fc_reset_ctrl_work);
>   	INIT_DELAYED_WORK(&ctrl->connect_work, nvme_fc_connect_ctrl_work);
> -	INIT_WORK(&ctrl->ioerr_work, nvme_fc_ctrl_ioerr_work);
>   	spin_lock_init(&ctrl->lock);
> 
>   	/* io queue count */
> @@ -3581,7 +3574,6 @@ nvme_fc_init_ctrl(struct device *dev, st
> 
>   fail_ctrl:
>   	nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_DELETING);
> -	cancel_work_sync(&ctrl->ioerr_work);
>   	cancel_work_sync(&ctrl->ctrl.reset_work);
>   	cancel_delayed_work_sync(&ctrl->connect_work);
> 

nvme_fc_timeout() ->
  nvme_fc_start_ioerr_recovery() ->
    __nvme_fc_abort_outstanding_ios() ->
      blk_sync_queue();

The codepath in the patch above will cause a deadlock.


nvme_fc_unregister_remoteport() ->
  nvme_fc_ctrl_connectivity_loss() ->
    nvme_fc_start_ioerr_recovery()

nvme_fc_fcpio_done() ->
  nvme_fc_start_ioerr_recovery()

The above codepaths use LLDD threads to do recovery. I thought we should
not be doing that.

