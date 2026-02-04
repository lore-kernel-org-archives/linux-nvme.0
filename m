Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C45E8B385
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Feb 2026 00:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2jP26M7o+Ifm1/uX3uWla62PNTgBSnoCzNniwdV0Pg8=; b=ELtR4cIyeUmaUg/xyYRUON8cSO
	6xmn1O9hCoNK9/W1zrC1xm9T8BJPkxaQKjpNxmdX9WW0/QXcWmGZ2MVK+SSIoz0SR7TGRLJFu2tS2
	EuncS+a9dBcnXa1OadjrC2MJ8/JsRSMbSz6toWFK6++HD/R3PEb+pqYoyVbfExkZaYGgVwouQTHbr
	A3noCl3gUGt1jalsvDejsqRxtDWMHIdNk4dZpWZahz9G9Kj24URO/quU3cVkUt4GwdbijllhID4Ct
	9/DuZ85XQMpT6REjmL/zCWERUPcHQxCV9DnV+o24XzuBWTLr2UvoXaegnOA4EOS2yiVR1E8+bEpL9
	W73XZsVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnQUX-00000007cFH-48eO;
	Wed, 04 Feb 2026 00:11:34 +0000
Received: from mail-dl1-x122a.google.com ([2607:f8b0:4864:20::122a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnQUV-00000007cEk-0Jaa
	for linux-nvme@lists.infradead.org;
	Wed, 04 Feb 2026 00:11:32 +0000
Received: by mail-dl1-x122a.google.com with SMTP id a92af1059eb24-124afd03fd1so9380906c88.0
        for <linux-nvme@lists.infradead.org>; Tue, 03 Feb 2026 16:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1770163890; x=1770768690; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2jP26M7o+Ifm1/uX3uWla62PNTgBSnoCzNniwdV0Pg8=;
        b=bafIOp0bU5DUeNCuNeK5HW9vuF7iuj8ceqdOlt1tdyrpGewQkQUhOlt4oZ6tGIR3Y2
         gwdtJ6G+2P2uYg68SPaTkn0pjAFletWMoROl87HgQmYKfdX2myy7d1XjGX9ma82cInLl
         8CLN9Uy0ZeLp9xc2YdRkGn4BiBNG6tvAf9gFyAKxQJ6DP5tseENITYdbO4xlK8y9O0Oy
         nnQpSaY+aLrHWwfuspWUi8H9pNOxcQKx5gVhsw2VT3ZHUgiVD4X29aMxe8mGPFyCEX0X
         SXgche5Dcs/YBRv6fwn8dUh4vJ+nz3e16Il7WJ2KePnxgwHCIr56D/ROKVcRUxLE436t
         WbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770163890; x=1770768690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2jP26M7o+Ifm1/uX3uWla62PNTgBSnoCzNniwdV0Pg8=;
        b=jre9zdd62CrE9FzYOcuYAFFiERftglquqtu1vSCWnQYd/buhIb3sp3+cMpTiGJS+9V
         jo1mjnC33LOfoRILLFdHoHa5t714h7Q/rpE7EQqTHCSwi9K4tDJknD3lbnMVTow4hntU
         ljZSugR89E5NTxOeQpsSW1cLXsS1EeJCFIk7ybJmMNVzOhO3LJztsVKXDa4vjyKNfMp+
         NcXupN5+WTyP95FBX0pMA7jIWUBtzBzqrMiO2b3Uy6UaoLUKFeiM8lQonmhNnj10nuO/
         7pi6JzVtLMA7YT1TeTRU1CClOsLNrWQtD6ZoYMSFvEeW81XE8JZe05zS/EChOFlzbp6C
         Cd8A==
X-Forwarded-Encrypted: i=1; AJvYcCUpAQrku9nF1o2WwOgVM/GUNah3q9ufr/cMUDeqoIU0HAXfSIj4EXARuqn0cpYKNXUZl+ygT439vwSc@lists.infradead.org
X-Gm-Message-State: AOJu0YxQEnUhEjtI4mHqplSFFdmROuRZd1IttfDuZ+FJqXY3405Ffp1J
	bjfxFW/Ur/WiRZ3UdUJs05W4TsZOoMkjq19zSOBSvWWi4kUoRwoAZL9snQsxVku0LSw=
X-Gm-Gg: AZuq6aJWmc6wqBWmE/Nww63Ap1SQrfpTUAVyCcB3cMhwWXzaIlM58vhDKGjUrcTeWFD
	JyPFSHc85yNH/+IRrVIAPaRPvkHwDQKFwYiHNa2OKWtLIqiCO9mNumlmZXU3PLlS4eobMLF4vG3
	aYEEkV7QhQFlPUiByL6MnKtXUDJKX+Xdumk3qxZkXAm8JgLtcBaaaN6uveZUAgZQse2qLFF/Mch
	t/HXD+7Zygi922a7SOjgq4aVl64k30p3PjaSB4syWZ0mg91fc1yXRcrudWrHr2Qx34STYOhrFpI
	Ltsr3etPvYOQk5TwnnNeW0GduViNPk1t6UUBgwDqDBxdnpThd2GUROHkHbKP5Wk9bUk+pOTi16N
	O/B00KQeATMz/B/n1igms8pvhi8ONBPiZFKPQ/cCRyOi/VBF2MFKCFofZPVO2dxyPRGo1t+yWY7
	OmasGrVz77YeEliIhOhvNA3+jmE/uRho4=
X-Received: by 2002:a05:7022:6085:b0:11b:b3a1:714a with SMTP id a92af1059eb24-126f478ff49mr495068c88.12.1770163889839;
        Tue, 03 Feb 2026 16:11:29 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id 5a478bee46e88-2b832e1290csm616834eec.1.2026.02.03.16.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 16:11:29 -0800 (PST)
Date: Tue, 3 Feb 2026 16:11:28 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: James Smart <jsmart833426@gmail.com>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/14] nvme-fc: Decouple error recovery from
 controller reset
Message-ID: <20260204001128.GI3729-mkhalfella@purestorage.com>
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-13-mkhalfella@purestorage.com>
 <383bbbe9-6cf5-465c-8811-0dddce34f883@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <383bbbe9-6cf5-465c-8811-0dddce34f883@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260203_161131_177277_FD2DC1F3 
X-CRM114-Status: GOOD (  58.19  )
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

On Tue 2026-02-03 11:19:28 -0800, James Smart wrote:
> On 1/30/2026 2:34 PM, Mohamed Khalfella wrote:
> > nvme_fc_error_recovery() called from nvme_fc_timeout() while controller
> > in CONNECTING state results in deadlock reported in link below. Update
> > nvme_fc_timeout() to schedule error recovery to avoid the deadlock.
> > 
> > Previous to this change if controller was LIVE error recovery resets
> > the controller and this does not match nvme-tcp and nvme-rdma.
> 
> It is not intended to match tcp/rda. Using the reset path was done to 
> avoid code duplication of paths to teardown the association.  FC, given 
> we interact with an HBA for device and io state and have a lot of async 
> io completions, requires a lot more work than straight data structure 
> teardown in rdma/tcp.
> 
> I agree with wanting to changeup the execution thread for the deadlock.
> 
> 
> > Decouple> error recovery from controller reset to match other fabric transports.>
> > Link: https://lore.kernel.org/all/20250529214928.2112990-1-mkhalfella@purestorage.com/
> > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> > ---
> >   drivers/nvme/host/fc.c | 94 ++++++++++++++++++------------------------
> >   1 file changed, 41 insertions(+), 53 deletions(-)
> > 
> > diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> > index 6948de3f438a..f8f6071b78ed 100644
> > --- a/drivers/nvme/host/fc.c
> > +++ b/drivers/nvme/host/fc.c
> > @@ -227,6 +227,8 @@ static DEFINE_IDA(nvme_fc_ctrl_cnt);
> >   static struct device *fc_udev_device;
> >   
> >   static void nvme_fc_complete_rq(struct request *rq);
> > +static void nvme_fc_start_ioerr_recovery(struct nvme_fc_ctrl *ctrl,
> > +					 char *errmsg);
> >   
> >   /* *********************** FC-NVME Port Management ************************ */
> >   
> > @@ -788,7 +790,7 @@ nvme_fc_ctrl_connectivity_loss(struct nvme_fc_ctrl *ctrl)
> >   		"Reconnect", ctrl->cnum);
> >   
> >   	set_bit(ASSOC_FAILED, &ctrl->flags);
> > -	nvme_reset_ctrl(&ctrl->ctrl);
> > +	nvme_fc_start_ioerr_recovery(ctrl, "Connectivity Loss");
> >   }
> >   
> >   /**
> > @@ -985,7 +987,7 @@ fc_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
> >   static void nvme_fc_ctrl_put(struct nvme_fc_ctrl *);
> >   static int nvme_fc_ctrl_get(struct nvme_fc_ctrl *);
> >   
> > -static void nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg);
> > +static void nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl);
> >   
> >   static void
> >   __nvme_fc_finish_ls_req(struct nvmefc_ls_req_op *lsop)
> > @@ -1567,9 +1569,8 @@ nvme_fc_ls_disconnect_assoc(struct nvmefc_ls_rcv_op *lsop)
> >   	 * for the association have been ABTS'd by
> >   	 * nvme_fc_delete_association().
> >   	 */
> > -
> > -	/* fail the association */
> > -	nvme_fc_error_recovery(ctrl, "Disconnect Association LS received");
> > +	nvme_fc_start_ioerr_recovery(ctrl,
> > +				     "Disconnect Association LS received");
> >   
> >   	/* release the reference taken by nvme_fc_match_disconn_ls() */
> >   	nvme_fc_ctrl_put(ctrl);
> > @@ -1871,7 +1872,7 @@ nvme_fc_ctrl_ioerr_work(struct work_struct *work)
> >   	struct nvme_fc_ctrl *ctrl =
> >   			container_of(work, struct nvme_fc_ctrl, ioerr_work);
> >   
> > -	nvme_fc_error_recovery(ctrl, "transport detected io error");
> > +	nvme_fc_error_recovery(ctrl);
> 
> hmm.. not sure how I feel about this. There is at least a break in reset 
> processing that is no longer present - e.g. prior queued ioerr_work, 
> which would then queue reset_work. This effectively calls the reset_work 
> handler directly. I assume it should be ok.
> 
> >   }
> >   
> >   /*
> > @@ -1892,6 +1893,17 @@ char *nvme_fc_io_getuuid(struct nvmefc_fcp_req *req)
> >   }
> >   EXPORT_SYMBOL_GPL(nvme_fc_io_getuuid);
> >   
> > +static void nvme_fc_start_ioerr_recovery(struct nvme_fc_ctrl *ctrl,
> > +					 char *errmsg)
> > +{
> > +	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
> > +		return;
>  > +> +	dev_warn(ctrl->ctrl.device, "NVME-FC{%d}: starting error 
> recovery %s\n",
> > +		 ctrl->cnum, errmsg);
> > +	queue_work(nvme_reset_wq, &ctrl->ioerr_work);
> > +}
> > +
> 
> Disagree with this.
> 
> The clause in error_recovery around the CONNECTING state is pretty 
> important to terminate io occurring during connect/reconnect where the 
> ctrl state should not change. we don't want start_ioerr making it RESETTING.
> 
> This should be reworked.

Like you pointed out this changes the current behavior for CONNECTING
state.

Before this change, as you pointed out the controller state stays in
CONNECTING while all IOs are aborted. Aborting the IOs causes
nvme_fc_create_association() to fail and reconnect might be attempted
again.

The new behavior switches to RESETTING and queues ctr->ioerr_work.
ioerr_work will abort oustanding IOs, swich back to CONNECING and
attempt reconnect.

nvme_fc_error_recovery() ->
  nvme_stop_keep_alive() /* should not make a difference */
  nvme_stop_ctrl()       /* should be okay to run */
  nvme_fc_delete_association() ->
    __nvme_fc_abort_outstanding_ios(ctrl, false)
    nvme_unquiesce_admin_queue()
    nvme_unquiesce_io_queues()
    nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)
    if (port_state == ONLINE)
      queue_work(ctrl->connect)
    else
      nvme_fc_reconnect_or_delete();

Yes, this is a different behavior. IMO it is simpler to follow and
closer to what other transports do, keeping in mind async abort nature
of fc.

Aside from it is different, what is wrong with it?

> 
> >   static void
> >   nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
> >   {
> > @@ -2049,9 +2061,8 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
> >   		nvme_fc_complete_rq(rq);
> >   
> >   check_error:
> > -	if (terminate_assoc &&
> > -	    nvme_ctrl_state(&ctrl->ctrl) != NVME_CTRL_RESETTING)
> > -		queue_work(nvme_reset_wq, &ctrl->ioerr_work);
> > +	if (terminate_assoc)
> > +		nvme_fc_start_ioerr_recovery(ctrl, "io error");
> 
> this is ok. the ioerr_recovery will bounce the RESETTING state if it's 
> already in the state. So this is a little cleaner.
> 
> >   }
> >   
> >   static int
> > @@ -2495,39 +2506,6 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
> >   		nvme_unquiesce_admin_queue(&ctrl->ctrl);
> >   }
> >   
> > -static void
> > -nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
> > -{
> > -	enum nvme_ctrl_state state = nvme_ctrl_state(&ctrl->ctrl);
> > -
> > -	/*
> > -	 * if an error (io timeout, etc) while (re)connecting, the remote
> > -	 * port requested terminating of the association (disconnect_ls)
> > -	 * or an error (timeout or abort) occurred on an io while creating
> > -	 * the controller.  Abort any ios on the association and let the
> > -	 * create_association error path resolve things.
> > -	 */
> > -	if (state == NVME_CTRL_CONNECTING) {
> > -		__nvme_fc_abort_outstanding_ios(ctrl, true);
> > -		dev_warn(ctrl->ctrl.device,
> > -			"NVME-FC{%d}: transport error during (re)connect\n",
> > -			ctrl->cnum);
> > -		return;
> > -	}
> 
> This logic needs to be preserved. Its no longer part of 
> nvme_fc_start_ioerr_recovery(). Failures during CONNECTING should not be 
> "fenced". They should fail immediately.

I think this is similar to the point above.

> 
> > -
> > -	/* Otherwise, only proceed if in LIVE state - e.g. on first error */
> > -	if (state != NVME_CTRL_LIVE)
> > -		return;
> 
> This was to filter out multiple requests of the reset. I guess that is 
> what happens now in start_ioerr when attempting to set state to 
> RESETTING and already RESETTING.

Yes. In this case nvme_fc_start_ioerr_recovery() will do nothing.

> 
> There is a small difference here in that The existing code avoids doing 
> the ctrl reset if the controller is NEW. start_ioerr will change the 
> ctrl to RESETTING. I'm not sure how much of an impact that is.
> 

I think there is little done while controller in NEW state.
Let me know if I am missing something.

> 
> > -
> > -	dev_warn(ctrl->ctrl.device,
> > -		"NVME-FC{%d}: transport association event: %s\n",
> > -		ctrl->cnum, errmsg);
> > -	dev_warn(ctrl->ctrl.device,
> > -		"NVME-FC{%d}: resetting controller\n", ctrl->cnum);
> 
> I haven't paid much attention, but keeping the transport messages for 
> these cases is very very useful for diagnosis.
> 
> > -
> > -	nvme_reset_ctrl(&ctrl->ctrl);
> > -}
> > -
> >   static enum blk_eh_timer_return nvme_fc_timeout(struct request *rq)
> >   {
> >   	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(rq);
> > @@ -2536,24 +2514,14 @@ static enum blk_eh_timer_return nvme_fc_timeout(struct request *rq)
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
> 
> Why get rid of the abort logic ?
> Note: the error recovery/controller reset is only called when the abort 
> failed.
> 
> I believe you should continue to abort the op.  The fence logic will 
> kick in when the op completes later (along with other io completions). 
> If nothing else, it allows a hw resource to be freed up.

The abort logic from nvme_fc_timeout() is problematic and it does not
play well with abort initiatored from ioerr_work or reset_work. The
problem is that op aborted from nvme_fc_timeout() is not accounted for
when the controller is reset.

Here is an example scenario.

The first time a request times out it gets aborted we see this codepath

nvme_fc_timeout() ->
  __nvme_fc_abort_op() ->
    atomic_xchg(&op->state, FCPOP_STATE_ABORTED)
      ops->abort()
        return 0;

nvme_fc_timeout() always return BLK_EH_RESET_TIMER so the same request
can timeout again. If the same request hits timeout again then
__nvme_fc_abort_op() returns -ECANCELED and nvme_fc_error_recovery()
gets called. Assuming the controller is LIVE it will be reset.

nvme_fc_reset_ctrl_work() ->
  nvme_fc_delete_association() ->
    __nvme_fc_abort_outstanding_ios() ->
      nvme_fc_terminate_exchange() ->
        __nvme_fc_abort_op()

__nvme_fc_abort_op() finds that op already aborted. As a result of that
ctrl->iocnt will not be incrmented for this op. This means that
nvme_fc_delete_association() will not wait for this op to be aborted.

I do not think we wait this behavior.

To continue the scenario above. The controller switches to CONNECTING
and the request times out again. This time we hit the deadlock described
in [1].

I think the first abort is the cause of the issue here. with this change
we should not hit the scenario described above.

1 - https://lore.kernel.org/all/20250529214928.2112990-1-mkhalfella@purestorage.com/

> 
> 
> >   	return BLK_EH_RESET_TIMER;
> >   }
> >   
> > @@ -3352,6 +3320,26 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
> >   	}
> >   }
> >   
> > +static void
> > +nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl)
> > +{
> > +	nvme_stop_keep_alive(&ctrl->ctrl);
> 
> Curious, why did the stop_keep_alive() call get added to this ?
> Doesn't hurt.
> 
> I assume it was due to other transports having it as they originally 
> were calling stop_ctrl, but then moved to stop_keep_alive. Shouldn't 
> this be followed by flush_work((&ctrl->ctrl.async_event_work) ?

Yes. I added it because it matches what other transports do.

nvme_fc_error_recovery() ->
  nvme_fc_delete_association() ->
    nvme_fc_abort_aen_ops() ->
      nvme_fc_term_aen_ops() ->
        cancel_work_sync(&ctrl->ctrl.async_event_work);

The above codepath takes care of async_event_work.

> 
> > +	nvme_stop_ctrl(&ctrl->ctrl);
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
> 
> This code and that in nvme_fc_reset_ctrl_work() need to be collapsed 
> into a common helper function invoked by the 2 routines.  Also addresses 
> the missing flush_delayed work in this routine.
> 

Agree, nvme_fc_error_recovery() and nvme_fc_reset_ctrl_work() have
common code that can be refactored. However, I do not plan to do this
part of this change. I will take a look after I get CCR work done.

> >   
> >   static const struct nvme_ctrl_ops nvme_fc_ctrl_ops = {
> >   	.name			= "fc",
> 
> 
> -- James
> 
> (new email address. can always reach me at james.smart@broadcom.com as well)
> 

