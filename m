Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 359A2E94625
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Feb 2026 01:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lf6rEMus2Jrg40/ZF9R05k3o24FBeZ8c1ipcsIQjdLs=; b=FDYVo//mk+oJHY0dDtVqbmqxgR
	oDTwTBH0WU2mJLNy+WJx/yX25kv2LuH16+4fzJ86Fx3G4N3IHZK7DiWmN+zV0EFvw4ipPoGx1CmCy
	zsVPETNqSF7U5VC3MtHux/AO9GP/9Uva+QNfVgtIXCUW1ARpgPH6eQ4PlMtUQeZ8qPULhf6l3Nm5B
	Z/8e7daE2TvAF7Cgft9ImWRz7fwQG5WP+plWV9eFcsEPyZfHbZC8VMpY2nAKiWlCVY2ozuzrFhsAC
	KXxPazln1x1CMprXA/5/CWqbGGnNTLyiVb8Z1gmGx8u9Vtj7U2z57H72XE/VVh2AHXsDWgDF39fN8
	wJSNm5yA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpcie-0000000GHyM-2cNr;
	Tue, 10 Feb 2026 01:39:12 +0000
Received: from mail-dy1-x132a.google.com ([2607:f8b0:4864:20::132a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpciY-0000000GHxz-0clk
	for linux-nvme@lists.infradead.org;
	Tue, 10 Feb 2026 01:39:07 +0000
Received: by mail-dy1-x132a.google.com with SMTP id 5a478bee46e88-2b82c605dbdso805948eec.0
        for <linux-nvme@lists.infradead.org>; Mon, 09 Feb 2026 17:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1770687544; x=1771292344; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lf6rEMus2Jrg40/ZF9R05k3o24FBeZ8c1ipcsIQjdLs=;
        b=QdHZVuZMkNGTRDKtRSSmiG7EQRRrbighjKvlP3Pinzxfh8d5ajwlzS0MxbIFaRYdn4
         Emmg7ZolOI0ZNIu9Af6tAWcbWZE3VvrsruDjKx2Ki9xfrkl0agCD1VcA/SmsHOaglIMs
         IgXbkt/a2G2k/Tzd1kkhJDSK7YIkS0W+XGNMCmFWAQ+xJhdbsW321qvolk3Bn60slwpJ
         24wgo+e3qugZmVolLOeXcjlL+jBYntlhJ72/0oH17X23urJKTeFy6YXU8xN8BSrZUK8w
         S6s1uBf2tpoTzwOmPKbGnLPpPtBpDA+vAkKI/jgaIytMolFH3+ivFfATvcNFcovllFrY
         gR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770687544; x=1771292344;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lf6rEMus2Jrg40/ZF9R05k3o24FBeZ8c1ipcsIQjdLs=;
        b=Q5PRvbyVfJHZMmSUKlNfRK0O0+W+CKyS63e6ASpvVIW9nddFooQ3r/JLYoIwASD1Au
         NGJaJ6ZLNoQJ6c4Eyzw0RRBp8dnqV0qqe8KW/hjjeKGK1J9V+YbOmCOvIuJVPHNR3Xuu
         R/szowdC9xGu2sm+zQTt6nvPwsGxXt/rf7scLo/6wR5ZENEeDV29tclR/+ABXifIBO2W
         mDAzinYHtZPC+srdNlK2N16enArCH8l9x+4O2d10ZzYYprHlltp13B/bV7DPXte/mOXD
         O9E/7hR53zQcGBi3GI0eQgActFF/W00jIDbW1H7yCwAG6exHy/PUJ7rjjxvoW1ghaoK1
         LUMw==
X-Forwarded-Encrypted: i=1; AJvYcCXW2y9PWzB0p5pObzVgAT0DllUhZjBLW9MWMKuIiiVdVipxKOHQqbvLFXrRVrDP5oOUPmKgOB+D4W7u@lists.infradead.org
X-Gm-Message-State: AOJu0YzqToHmLtMmpnxZeTmCFWetFiVCZmyGdBIyYAPmX08qtviCalkd
	ouguO8cJ2ofRsmAGgl28qCrjTkIrFiPsnOzQLmy/ob0ZLvBL+DSITG+m07b1UjEfsGM=
X-Gm-Gg: AZuq6aLMrFtAvTTGDGzzdhABut9DTJDa00LlTqwlSu7M5Vqspipbn4l0lfVggK1HwyP
	IGdYQeDjzXTKRlQMiYkUR4eLMliGulYOjXZuEO9UwjNHJsn1zCU3q6/kWBjGJmZdHlZeSYmXOLg
	fKsFx+rDyySTlbuCmQCyCn6DmjxJdDQOV0UTGE1eD4n0A3of6eiwOD/qUIyMxrmMPCLQmHLniwr
	2GcpMhk5/Al0QfyWbb8RXCjwjSrQy4rYK3ACwcSZo5S8lcggbgdsbGAs0v5EMWnUyUS6lUD0KKl
	8XZc3ulajNpY88ZBWm8JryJY/eDIQN0uvVrqkf7qBFNTLF1H+H1uJhDGIjt0dAWhf00n59aOBzu
	ZAHJNSY3v1oAEWZV3se8fhUxFTRt+kqqsOxZGVU0N7N8RAKtzHTkYFgMrK/O2dIfz+yAH8ohDop
	i7LQ5omKUqCdBjtsCeq26lltBRl1o=
X-Received: by 2002:a05:7300:570f:b0:2ba:7863:f0aa with SMTP id 5a478bee46e88-2ba786420c0mr1714641eec.11.1770687544043;
        Mon, 09 Feb 2026 17:39:04 -0800 (PST)
Received: from medusa.lab.kspace.sh ([2601:640:8202:6fb0::68dd])
        by smtp.googlemail.com with UTF8SMTPSA id a92af1059eb24-1270433ab31sm11220843c88.11.2026.02.09.17.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 17:39:03 -0800 (PST)
Date: Mon, 9 Feb 2026 17:39:01 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/14] nvme-tcp: Use CCR to recover controller that
 hits an error
Message-ID: <20260210013901.GE2392949-mkhalfella@purestorage.com>
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-11-mkhalfella@purestorage.com>
 <48a05027-9ca2-4e84-a7ac-946391ed1e26@suse.de>
 <20260203212409.GG3729-mkhalfella@purestorage.com>
 <2c35f0df-5ef3-4919-9f65-3b67eaf8c823@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c35f0df-5ef3-4919-9f65-3b67eaf8c823@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260209_173906_277393_51CC5469 
X-CRM114-Status: GOOD (  62.95  )
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

On Wed 2026-02-04 03:57:20 +0100, Hannes Reinecke wrote:
> On 2/3/26 22:24, Mohamed Khalfella wrote:
> > On Tue 2026-02-03 06:34:51 +0100, Hannes Reinecke wrote:
> >> On 1/30/26 23:34, Mohamed Khalfella wrote:
> >>> An alive nvme controller that hits an error now will move to FENCING
> >>> state instead of RESETTING state. ctrl->fencing_work attempts CCR to
> >>> terminate inflight IOs. If CCR succeeds, switch to FENCED -> RESETTING
> >>> and continue error recovery as usual. If CCR fails, the behavior depends
> >>> on whether the subsystem supports CQT or not. If CQT is not supported
> >>> then reset the controller immediately as if CCR succeeded in order to
> >>> maintain the current behavior. If CQT is supported switch to time-based
> >>> recovery. Schedule ctrl->fenced_work resets the controller when time
> >>> based recovery finishes.
> >>>
> >>> Either ctrl->err_work or ctrl->reset_work can run after a controller is
> >>> fenced. Flush fencing work when either work run.
> >>>
> >>> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> >>> ---
> >>>    drivers/nvme/host/tcp.c | 62 ++++++++++++++++++++++++++++++++++++++++-
> >>>    1 file changed, 61 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> >>> index 69cb04406b47..af8d3b36a4bb 100644
> >>> --- a/drivers/nvme/host/tcp.c
> >>> +++ b/drivers/nvme/host/tcp.c
> >>> @@ -193,6 +193,8 @@ struct nvme_tcp_ctrl {
> >>>    	struct sockaddr_storage src_addr;
> >>>    	struct nvme_ctrl	ctrl;
> >>>    
> >>> +	struct work_struct	fencing_work;
> >>> +	struct delayed_work	fenced_work;
> >>>    	struct work_struct	err_work;
> >>>    	struct delayed_work	connect_work;
> >>>    	struct nvme_tcp_request async_req;
> >>> @@ -611,6 +613,12 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
> >>>    
> >>>    static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
> >>>    {
> >>> +	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCING)) {
> >>> +		dev_warn(ctrl->device, "starting controller fencing\n");
> >>> +		queue_work(nvme_wq, &to_tcp_ctrl(ctrl)->fencing_work);
> >>> +		return;
> >>> +	}
> >>> +
> >>
> >> Don't you need to flush any outstanding 'fenced_work' queue items here
> >> before calling 'queue_work()'?
> > 
> > I do not think we need to flush ctr->fencing_work. It can not be running
> > at this time.
> > 
> Hmm. If you say so ... I'd rather make sure here.
> These things have a habit of popping up unexpectdly.

A LIVE controller that hits an error queues ctrl->fencing_work.
fencing_work will do CCR. If CCR succeeds then it will queue
ctrl->err_work. If CCR fails then it will queue ctrl->fenced_work.
ctrl->err_work flushes both fencing_work and fenced_work before doing
anything. In the event where a controller is reset just after transition
FENCING->FENCED before FENCED->RESETTING then reset work will run.
ctrl->reset_work also flushes both work.

In all cases these works should be flushed before going to CONNECTING
state. That means by the time they are queued again they should not be
running.

> 
> >>
> >>>    	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> >>>    		return;
> >>>    
> >>> @@ -2470,12 +2478,59 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
> >>>    	nvme_tcp_reconnect_or_remove(ctrl, ret);
> >>>    }
> >>>    
> >>> +static void nvme_tcp_fenced_work(struct work_struct *work)
> >>> +{
> >>> +	struct nvme_tcp_ctrl *tcp_ctrl = container_of(to_delayed_work(work),
> >>> +					struct nvme_tcp_ctrl, fenced_work);
> >>> +	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
> >>> +
> >>> +	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
> >>> +	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> >>> +		queue_work(nvme_reset_wq, &tcp_ctrl->err_work);
> >>> +}
> >>> +
> >>> +static void nvme_tcp_fencing_work(struct work_struct *work)
> >>> +{
> >>> +	struct nvme_tcp_ctrl *tcp_ctrl = container_of(work,
> >>> +			struct nvme_tcp_ctrl, fencing_work);
> >>> +	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
> >>> +	unsigned long rem;
> >>> +
> >>> +	rem = nvme_fence_ctrl(ctrl);
> >>> +	if (!rem)
> >>> +		goto done;
> >>> +
> >>> +	if (!ctrl->cqt) {
> >>> +		dev_info(ctrl->device,
> >>> +			 "CCR failed, CQT not supported, skip time-based recovery\n");
> >>> +		goto done;
> >>> +	}
> >>> +
> >>
> >> As mentioned, cqt handling should be part of another patchset.
> > 
> > Let us suppose we drop cqt from this patchset
> > 
> > - How will we be able to calculate CCR time budget?
> >    Currently it is calculated by nvme_fence_timeout_ms()
> > 
> The CCR time budget is calculated by the current KATO value.
> CQT is the time a controler requires _after_ KATO expires
> to clear out commands.

So it is the same formulate in nvme_fence_timeout_ms() with cqt=0?

> 
> > - What should we do if CCR fails? Retry requests immediately?
> > 
> No. If CCR fails we should fall back to error handling.
> In our case it would mean we let the command timeout handler
> initate a controller reset.

Assuming that we are not implementing CQT delay then we should just
retry requests after CCR finishes. Regardless of the CCR success or
failure. What else we can do if we do not want to hold requests?

What is being suggested is to transition the controller to FENCED state
and leave it there. timeout callback handler should trigger error
recovery which transition to RESETTING as usual. Did I get this part
correctly?

If this is correct then why wait for antoher timeout, which can be 60
seconds for admin requests? We know the controller should be reset I
think we should do what the code does now and proceed with reset.

> _Eventually_ (ie after we implemented CCR _and_ CQT) we would
> wait for KATO (+ CQT) to expire and _then_ reset the controller.

This is what has been implemented in this patchset, right?

> 
> >>> +	dev_info(ctrl->device,
> >>> +		 "CCR failed, switch to time-based recovery, timeout = %ums\n",
> >>> +		 jiffies_to_msecs(rem));
> >>> +	queue_delayed_work(nvme_wq, &tcp_ctrl->fenced_work, rem);
> >>> +	return;
> >>> +
> >>
> >> Why do you need the 'fenced' workqueue at all? All it does is queing yet
> >> another workqueue item, which certainly can be done from the 'fencing'
> >> workqueue directly, no?
> > 
> > It is possible to drop ctr->fenced_work and requeue ctrl->fencing_work
> > as delayed work to implement request hold time. If we do that then we
> > need to modify nvme_tcp_fencing_work() to tell if it is being called for
> > 'fencing' or 'fenced'. The first version of this patch used a controller
> > flag RECOVERED for that and it has been suggested to use a separate work
> > to simplify the logic and drop the controller flag.
> > 
> But that's just because you integrated CCR within the current error 
> recovery.
> If you were to implement CCR as to be invoked from 
> nvme_keep_alive_end_io() we would not need to touch that,
> and we would need just one workqueue.
> 
> Let me see if I can draft up a patch.

I look forward to seeing this draft patch.

> 
> >>
> >>> +done:
> >>> +	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
> >>> +	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> >>> +		queue_work(nvme_reset_wq, &tcp_ctrl->err_work);
> >>> +}
> >>> +
> >>> +static void nvme_tcp_flush_fencing_work(struct nvme_ctrl *ctrl)
> >>> +{
> >>> +	flush_work(&to_tcp_ctrl(ctrl)->fencing_work);
> >>> +	flush_delayed_work(&to_tcp_ctrl(ctrl)->fenced_work);
> >>> +}
> >>> +
> >>>    static void nvme_tcp_error_recovery_work(struct work_struct *work)
> >>>    {
> >>>    	struct nvme_tcp_ctrl *tcp_ctrl = container_of(work,
> >>>    				struct nvme_tcp_ctrl, err_work);
> >>>    	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
> >>>    
> >>> +	nvme_tcp_flush_fencing_work(ctrl);
> >>
> >> Why not 'fenced_work' ?
> > 
> > You mean rename nvme_tcp_flush_fencing_work() to
> > nvme_tcp_flush_fenced_work()?
> > 
> > If yes, then I can do that if you think it makes more sense.
> > 
> Thing is, you have two workqueues dealing with CCR.
> You really need to avoid that _both_ are empty when this
> funciton is called.

Yes, that is why we call nvme_tcp_flush_fencing_work().

> 
> >>
> >>>    	if (nvme_tcp_key_revoke_needed(ctrl))
> >>>    		nvme_auth_revoke_tls_key(ctrl);
> >>>    	nvme_stop_keep_alive(ctrl);
> >>> @@ -2518,6 +2573,7 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
> >>>    		container_of(work, struct nvme_ctrl, reset_work);
> >>>    	int ret;
> >>>    
> >>> +	nvme_tcp_flush_fencing_work(ctrl);
> >>
> >> Same.
> >>
> >>>    	if (nvme_tcp_key_revoke_needed(ctrl))
> >>>    		nvme_auth_revoke_tls_key(ctrl);
> >>>    	nvme_stop_ctrl(ctrl);
> >>> @@ -2643,13 +2699,15 @@ static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
> >>>    	struct nvme_tcp_cmd_pdu *pdu = nvme_tcp_req_cmd_pdu(req);
> >>>    	struct nvme_command *cmd = &pdu->cmd;
> >>>    	int qid = nvme_tcp_queue_id(req->queue);
> >>> +	enum nvme_ctrl_state state;
> >>>    
> >>>    	dev_warn(ctrl->device,
> >>>    		 "I/O tag %d (%04x) type %d opcode %#x (%s) QID %d timeout\n",
> >>>    		 rq->tag, nvme_cid(rq), pdu->hdr.type, cmd->common.opcode,
> >>>    		 nvme_fabrics_opcode_str(qid, cmd), qid);
> >>>    
> >>> -	if (nvme_ctrl_state(ctrl) != NVME_CTRL_LIVE) {
> >>> +	state = nvme_ctrl_state(ctrl);
> >>> +	if (state != NVME_CTRL_LIVE && state != NVME_CTRL_FENCING) {
> >>
> >> 'FENCED' too, presumably?
> > 
> > I do not think it makes a difference here. FENCED and RESETTING are
> > almost the same states.
> > 
> Yeah, but in FENCED all commands will be aborted, and the same action 
> will be invoked when this if() clause is entered. So you need to avoid
> entering the if() clause to avoid races.

That is okay. FENCED controller means either CCR succeeded or requests
have been held for time-based recovery. In both cases it should be okay
for these requests to be canceled. The only reason FENCED state exists
is that we do not want to have state transition from FENCING ->
RESETTING because we do not want anyone to reset the controller while it
is being fenced. Otherwise FENCED = RESETTING.

> 
> >>
> >>>    		/*
> >>>    		 * If we are resetting, connecting or deleting we should
> >>>    		 * complete immediately because we may block controller
> >>> @@ -2904,6 +2962,8 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
> >>>    
> >>>    	INIT_DELAYED_WORK(&ctrl->connect_work,
> >>>    			nvme_tcp_reconnect_ctrl_work);
> >>> +	INIT_DELAYED_WORK(&ctrl->fenced_work, nvme_tcp_fenced_work);
> >>> +	INIT_WORK(&ctrl->fencing_work, nvme_tcp_fencing_work);
> >>>    	INIT_WORK(&ctrl->err_work, nvme_tcp_error_recovery_work);
> >>>    	INIT_WORK(&ctrl->ctrl.reset_work, nvme_reset_ctrl_work);
> >>>    
> >>
> >> Here you are calling CCR whenever error recovery is triggered.
> >> This will cause CCR to be send from a command timeout, which is
> >> technically wrong (CCR should be send when the KATO timeout expires,
> >> not when a command timout expires). Both could be vastly different.
> > 
> > KATO is driven by the host. What does KTO expires mean?
> > I think KATO expiry is more applicable to target, no?
> > 
> KATO expiry (for this implementation) means the nvme_keep_alive_end_io()
> is called with rtt > deadline.
> 
> > KATO timeout is a signal of an error that target is not reachable or
> > something is wrong with the target?
> > 
> Yes. It explicitely means that the Keep-Alive command was not completed
> within a time period specified by the Keep-Alive timeout value.
> 
> >>
> >> So I'd prefer to have CCR send whenever KATO timeout triggers, and
> >> lease to current command timeout mechanism in place.
> > 
> > Assuming we used CCR only when KATO request times out.
> > What should we do when we hit other errors?
> > 
> Leave it. This patchset is _NOT_ about fixing the error handler.
> This patchset is about implementing CCR.
> And CCR is just a step towared fixing the error handler.

If we leave it then an IO request timeout will cause controller reset
and inflight IOs will be retried immediately, is that what we want?

What if we have a target that responds to keepalive commands but not IO
commands, should we reset the controller if we hit IO timeout?

If we should not reset the controller, then what else we should do?

If we should reset the controller, then what should happen to inflight
IOs?

I do not agree that CCR should be triggered only if keepalive request
timesout. I do not see the link between the two.

> 
> > should nvme_tcp_error_recovery() is called from many places to handle
> > errors and it effectively resets the controller. What should this
> > function do if not trigger CCR?
> > 
> The same things as before. CCR needs to be invoked when the Keep-Alive
> timeout period expires. And that is what we should be implementing here.
> 
> It _might_ (and arguably should) be invoked when error handling needs
> to be done. But with a later patchset.
> 
> Yes, this will result in a patchset where the error handler still has
> gaps. But it will result in a patchset which focusses on a single thing,
> with the added benefit that the workings are clearly outlined in the 
> spec. So the implementation is pretty easy to review.
> 
> Hooking CCR into the error handler itself is _not_ mandated by the spec,
> and inevitably needs to larger discussions (as this thread nicely 
> demonstrates). So I would prefer to keep it simple first, and focus
> on the technical implementation of CCR.
> And concentrate on fixing up the error handler once CCR is in.

Let us say CCR is only triggered by keepalive timeout, and we landed CCR
this way and now it is time to fix the error handler.

What should error handler do to handle say IO timeout?

Let us say we attempted to cancel the timedout comamnd and cancel
command failed. What is the next step in this case?

> 
> Cheers,
> 
> Hannes
> >>
> >> Cheers,
> >>
> >> Hannes
> >> -- 
> >> Dr. Hannes Reinecke                  Kernel Storage Architect
> >> hare@suse.de                                +49 911 74053 688
> >> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
> >> HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
> 
> 
> -- 
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
> HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

