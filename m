Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C079DE94615
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Feb 2026 22:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VvTHFBmrns4yQH93HKtK+ym4aX4G0R9VvtkYylRm8E4=; b=AbmwtUQWiQmsVtjygCGy2551cy
	i6PCZFqfZdQ6EfOgsNW3u7YuSiMzxkFxJiKL+Ru0fJbhPGS9ecACuO6rz43AeCmC4iJP8OEL8Vt3L
	NBHoEuynZQEzzJruAQpxdox9TqVaQS4o8dhRC42DAvln/b84zUnSZvcnrAVVYc3CxuDXF/WVJRQDt
	KyIs1TuIoAuYe/ar/YfDlp+isl3dsi+slrs2WxJ1mscwPswl58ubvrdAqtYK0/I6sFq1rXj6Ugv1d
	K739BZqYsM6zVp8HYtGUUdGic5pm73HVOPqOrUzFgf0WVH/vfcTrPwH7r+/OJ90UEuTqnvwGeZumg
	rvFK7jiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpa85-0000000G9m3-13SP;
	Mon, 09 Feb 2026 22:53:17 +0000
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpa81-0000000G9lf-1dqs
	for linux-nvme@lists.infradead.org;
	Mon, 09 Feb 2026 22:53:15 +0000
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-4375d4fb4d4so159007f8f.0
        for <linux-nvme@lists.infradead.org>; Mon, 09 Feb 2026 14:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1770677591; x=1771282391; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VvTHFBmrns4yQH93HKtK+ym4aX4G0R9VvtkYylRm8E4=;
        b=diNY5dXsuOP2c0GBA4yQ1wtkEEbFfrqMLf/hcs8KHcyqxdvbMz/7MA+eZgfx1e1qs2
         gQLS5vivrxIAybpypqLiyEt+E52QocnHCDZs7bx3NfHwO+zoycyCm9DVzKxL5WDIcm17
         giqApmhEGh7q7M9QLSSb5eY5CJSt/iMRTxGtj8Vnh1pUL7nOrdJjC4RBmhFtLNNX7aFc
         nV11RsBbIn2nz3SeoZwap0yb79/e5PIVO9i1ZnqdKMjuVAL0RulX65xJmVxtBx7l+Hdg
         R/whLDrRs/ABkVUgQDDzGcaxfAXj3c6cnGURw3oYc5eAZ6E0d8qbdTLZxrbpCH1JhKFH
         OkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770677591; x=1771282391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VvTHFBmrns4yQH93HKtK+ym4aX4G0R9VvtkYylRm8E4=;
        b=VixxDYd7owuDfQYrGkabdBU5Lk7pYIX3Jde1gFh0tLlCr2B6+zNqeJKdi27+KDvA6z
         gDCWfFCckLdfy+AA0oVdW1r+7QYoJevVhh/K3xL46XPqY/GtH/cwCIIm3Jicl8pdThn/
         Rc/sspLGZHabUZQdUXFF7mnWvN20sclqK4kseiGHUr3KyTQQ16KJpdsm3oixu016FEJ7
         hgCBmbHgwQ3JdftTfZEa+Io0bFZo1vxaE4Dy6RciYFMjeu8zRAoW9EoqGgVTX+/cVdCZ
         yEakyw7fj5OHlH3l0HOlglz3Eseh6GZEaIWHmEN0g4o8YGJjx7/Tu8jpVvQOXyw4/BUD
         3new==
X-Forwarded-Encrypted: i=1; AJvYcCXmfVK0RRlydkcOBGXQ3I3f0MhQ6FKou55bfHaw7CkyXNYWH5cDlt/lsH8kLhMa+7q30dCRf34Tboxj@lists.infradead.org
X-Gm-Message-State: AOJu0YxHb/qrHspoJuMHAxG2wMvoa0DjX6DuwKKMRngAzh8NNV0UjsK8
	QhvRJYsBgjP7BZcIkNKBIa3uqf/jLT3sQlbiR8zXke5f5wC0Y48LGKuAHoC7nDEtTjI=
X-Gm-Gg: AZuq6aL0650wPS2oJECH6QJCTCiZSVEmMCVFl8YqdDctFPtOSkr1ONXhSTygp/nim07
	/nBU/Ih/MxxyQrIBvPatDF7I7BYYzF/kYt60A+iJ62ttaS2oNpSu+r4qaRJc8N4+x68UHF+CsQQ
	+oKe/yhPNGrNTFFFBGY0+3QTjPDELKPzipWKIacM7ZaTKRt+wzPSPAH3j0zsXttZFF54/rMG1lH
	/bKdT8VAjklWj2QC4GDyJqY7mb6SQl47XFsaJP+MAhO6RzEOUD7CUbSLBq4JrNYouZ+wYcsaSB4
	S2iakxLve2yJ0iSA9gYLN3Ed9XFMEsyw8TONwinEM+nJgTM9dWhcB51DGplGs3qDH+p1y/sFnmG
	P7GjsPI4zXoC2zdhKfSc4q+qBW44h1pUUoHV2DXCtweCRk2/jhHfKVp8gqjAH5Nl6mTiLc0a6+X
	TSupUl+6EUPgOZcyXAjMFbXE9dKM6ituM=
X-Received: by 2002:a05:6000:1863:b0:437:69c0:9619 with SMTP id ffacd0b85a97d-43769c098a6mr9427408f8f.29.1770677591071;
        Mon, 09 Feb 2026 14:53:11 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id ffacd0b85a97d-436309ed238sm28379826f8f.19.2026.02.09.14.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 14:53:10 -0800 (PST)
Date: Mon, 9 Feb 2026 14:53:07 -0800
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
Message-ID: <20260209225307.GO3729-mkhalfella@purestorage.com>
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-13-mkhalfella@purestorage.com>
 <383bbbe9-6cf5-465c-8811-0dddce34f883@gmail.com>
 <20260204001128.GI3729-mkhalfella@purestorage.com>
 <8487298a-ea00-4c3e-a882-bfdf97021a1f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8487298a-ea00-4c3e-a882-bfdf97021a1f@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260209_145313_644364_E8F53C69 
X-CRM114-Status: GOOD (  62.41  )
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

On Wed 2026-02-04 16:08:12 -0800, James Smart wrote:
> On 2/3/2026 4:11 PM, Mohamed Khalfella wrote:
> > On Tue 2026-02-03 11:19:28 -0800, James Smart wrote:
> >> On 1/30/2026 2:34 PM, Mohamed Khalfella wrote:
> ...
> >>>    
> >>> +static void nvme_fc_start_ioerr_recovery(struct nvme_fc_ctrl *ctrl,
> >>> +					 char *errmsg)
> >>> +{
> >>> +	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
> >>> +		return;
> >>   > +> +	dev_warn(ctrl->ctrl.device, "NVME-FC{%d}: starting error
> >> recovery %s\n",
> >>> +		 ctrl->cnum, errmsg);
> >>> +	queue_work(nvme_reset_wq, &ctrl->ioerr_work);
> >>> +}
> >>> +
> >>
> >> Disagree with this.
> >>
> >> The clause in error_recovery around the CONNECTING state is pretty
> >> important to terminate io occurring during connect/reconnect where the
> >> ctrl state should not change. we don't want start_ioerr making it RESETTING.
> >>
> >> This should be reworked.
> > 
> > Like you pointed out this changes the current behavior for CONNECTING
> > state.
> > 
> > Before this change, as you pointed out the controller state stays in
> > CONNECTING while all IOs are aborted. Aborting the IOs causes
> > nvme_fc_create_association() to fail and reconnect might be attempted
> > again.
> > The new behavior switches to RESETTING and queues ctr->ioerr_work.
> > ioerr_work will abort oustanding IOs, swich back to CONNECING and
> > attempt reconnect.
> 
> Well, it won't actually switch to RESETTING, as CONNECTING->RESETTING is 
> not a valid transition.  So things will silently stop in 
> start_ioerr_recovery when the state transition fails (also a reason I 
> dislike silent state transition failures).

I changed nvme_fc_start_ioerr_recovery() such that if the controller is
in CONNECTING state it will queue ctrl->ioerr_work  without changing the
controller state. This should address this issue. Will do more testing
before putting this change in the next version of the patchset.

> 
> When I look a little further into patch 13, I see the change to FENCING 
> added. But that state transition will also fail for CONNECTING->FENCING. 
> It will then fall into the resetting state change, which will silently 
> fail, and we're stopped.  It says to me there was no consideration or 
> testing of failures while CONNECTING with this patch set.  Even if 
> RESETTING were allowed, its injecting a new flow into the code paths.

This should be addressed by the change above.

> 
> The CONNECTING issue also applies to tcp and rdma transports. I don't 
> know if they call the error_recovery routines in the same way.

Other fabric transports tcp and rdma rely on timeout callback to
complete the timedout request with an error, without changing controller
state. This what tcp does for example.

nvme_tcp_timeout() ->
  nvme_tcp_complete_timed_out() ->
    blk_mq_complete_request()

This causes connect work to notice the error and fail. Then it should
decide wether to try connect again or delete the controller.

> 
> To be honest I'm not sure I remember the original reasons this loop was 
> put in, but I do remember pain I went through when generating it and the 
> number of test cases that were needed to cover testing. It may well be 
> because I couldn't invoke the reset due to the CONNECTING->RESETTING 
> block.  I'm being pedantic as I still feel residual pain for it.
> 
> 
> > 
> > nvme_fc_error_recovery() ->
> >    nvme_stop_keep_alive() /* should not make a difference */
> >    nvme_stop_ctrl()       /* should be okay to run */
> >    nvme_fc_delete_association() ->
> >      __nvme_fc_abort_outstanding_ios(ctrl, false)
> >      nvme_unquiesce_admin_queue()
> >      nvme_unquiesce_io_queues()
> >      nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)
> >      if (port_state == ONLINE)
> >        queue_work(ctrl->connect)
> >      else
> >        nvme_fc_reconnect_or_delete();
> > 
> > Yes, this is a different behavior. IMO it is simpler to follow and
> > closer to what other transports do, keeping in mind async abort nature
> > of fc.
> > 
> > Aside from it is different, what is wrong with it?
> 
> See above.
> 
> ...
> >>>    static int
> >>> @@ -2495,39 +2506,6 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
> >>>    		nvme_unquiesce_admin_queue(&ctrl->ctrl);
> >>>    }
> >>>    
> >>> -static void
> >>> -nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
> >>> -{
> >>> -	enum nvme_ctrl_state state = nvme_ctrl_state(&ctrl->ctrl);
> >>> -
> >>> -	/*
> >>> -	 * if an error (io timeout, etc) while (re)connecting, the remote
> >>> -	 * port requested terminating of the association (disconnect_ls)
> >>> -	 * or an error (timeout or abort) occurred on an io while creating
> >>> -	 * the controller.  Abort any ios on the association and let the
> >>> -	 * create_association error path resolve things.
> >>> -	 */
> >>> -	if (state == NVME_CTRL_CONNECTING) {
> >>> -		__nvme_fc_abort_outstanding_ios(ctrl, true);
> >>> -		dev_warn(ctrl->ctrl.device,
> >>> -			"NVME-FC{%d}: transport error during (re)connect\n",
> >>> -			ctrl->cnum);
> >>> -		return;
> >>> -	}
> >>
> >> This logic needs to be preserved. Its no longer part of
> >> nvme_fc_start_ioerr_recovery(). Failures during CONNECTING should not be
> >> "fenced". They should fail immediately.
> > 
> > I think this is similar to the point above.
> 
> Forgetting whether or not the above "works", what I'm pointing out is 
> that when in CONNECTING I don't believe you should be enacting the 
> FENCED state and delaying. For CONNECTING, the cleanup should be 
> immediate with no delay and no CCR attempt.  Only LIVE should transition 
> to FENCED.

Agreed. FENCING state is entered only from LIVE state.

> 
> Looking at patch 14, fencing_work calls nvme_fence_ctrl() which 
> unconditionally delays and tries to do CCR. We only want this if LIVE. 
> I'll comment on that patch.

Yes. Fencing only applies for live controllers where we expect to have
inflight IO requests. Failure of controller in other states should not
result in requests delay.

> 
> 
> >> There is a small difference here in that The existing code avoids doing
> >> the ctrl reset if the controller is NEW. start_ioerr will change the
> >> ctrl to RESETTING. I'm not sure how much of an impact that is.
> >>
> > 
> > I think there is little done while controller in NEW state.
> > Let me know if I am missing something.
> 
> No - I had to update my understanding I was really out of date. Used to 
> be NEW is what initial controller create was done under. Everybody does 
> it now under CONNECTING.
> 
> ...
> >>>    static enum blk_eh_timer_return nvme_fc_timeout(struct request *rq)
> >>>    {
> >>>    	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(rq);
> >>> @@ -2536,24 +2514,14 @@ static enum blk_eh_timer_return nvme_fc_timeout(struct request *rq)
> >>>    	struct nvme_fc_cmd_iu *cmdiu = &op->cmd_iu;
> >>>    	struct nvme_command *sqe = &cmdiu->sqe;
> >>>    
> >>> -	/*
> >>> -	 * Attempt to abort the offending command. Command completion
> >>> -	 * will detect the aborted io and will fail the connection.
> >>> -	 */
> >>>    	dev_info(ctrl->ctrl.device,
> >>>    		"NVME-FC{%d.%d}: io timeout: opcode %d fctype %d (%s) w10/11: "
> >>>    		"x%08x/x%08x\n",
> >>>    		ctrl->cnum, qnum, sqe->common.opcode, sqe->fabrics.fctype,
> >>>    		nvme_fabrics_opcode_str(qnum, sqe),
> >>>    		sqe->common.cdw10, sqe->common.cdw11);
> >>> -	if (__nvme_fc_abort_op(ctrl, op))
> >>> -		nvme_fc_error_recovery(ctrl, "io timeout abort failed");
> >>>    
> >>> -	/*
> >>> -	 * the io abort has been initiated. Have the reset timer
> >>> -	 * restarted and the abort completion will complete the io
> >>> -	 * shortly. Avoids a synchronous wait while the abort finishes.
> >>> -	 */
> >>> +	nvme_fc_start_ioerr_recovery(ctrl, "io timeout");
> >>
> >> Why get rid of the abort logic ?
> >> Note: the error recovery/controller reset is only called when the abort
> >> failed.
> >>
> >> I believe you should continue to abort the op.  The fence logic will
> >> kick in when the op completes later (along with other io completions).
> >> If nothing else, it allows a hw resource to be freed up.
> > 
> > The abort logic from nvme_fc_timeout() is problematic and it does not
> > play well with abort initiatored from ioerr_work or reset_work. The
> > problem is that op aborted from nvme_fc_timeout() is not accounted for
> > when the controller is reset.
> 
> note: I'll wait to be shown otherwise, but if this were true it would be 
> horribly broken for a long time.

I think calling __nvme_fc_abort_op() from nvme_fc_timeout() causes reset
to not account for the aborted requests while waiting for IO to complete.
This results in controller transitions RESETTING->CONNECTING->LIVE while
some requests are inflight.

I tested kernel version 8dfce8991b95d8625d0a1d2896e42f93b9d7f68d

[  839.513016] nvme nvme0: NVME-FC{0}: create association : host wwpn 0x100070b7e41ed630  rport wwpn 0x524a937d171c5e08: NQN "nqn.2010-06.com.purestorage:flasharray.5452b4ac21023d99"
[  839.537061] nvme nvme0: queue_size 128 > ctrl maxcmd 32, reducing to maxcmd
[  839.584019] nvme nvme0: NVME-FC{0}: controller connect complete
[  839.592280] nvme nvme0: NVME-FC{0}: new ctrl: NQN "nqn.2010-06.com.purestorage:flasharray.5452b4ac21023d99", hostnqn: nqn.2014-08.org.nvmexpress:uuid:e622dc39-ebed-4641-9d5c-6936ac234566
[  891.507377] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 2 fctype 10 (Read) w10/11: x00000000/x00000000, rq = ff110020edc3aa80, op = ff110020edc3ab80, cmdid = 17
[  891.524718] nvme nvme0: __nvme_fc_abort_op: op = ff110020edc3ab80
[  891.533355] nvme nvme0: NVME-FC{0}: transport association event: transport detected io error
[  891.543575] nvme nvme0: NVME-FC{0}: resetting controller
[  891.560361] nvme nvme0: __nvme_fc_abort_op: op = ff110021c3c04980
[  891.572329] nvme_ns_head_submit_bio: 10 callbacks suppressed
[  891.572335] block nvme0n1: no usable path - requeuing I/O
[  891.587334] nvme nvme0: __nvme_fc_abort_op: op = ff1100217375c5d0
[  891.603886] nvme nvme0: NVME-FC{0}: create association : host wwpn 0x100070b7e41ed630  rport wwpn 0x524a937d171c5e08: NQN "nqn.2010-06.com.purestorage:flasharray.5452b4ac21023d99"
[  891.652728] nvme nvme0: NVME-FC{0}: controller connect complete


              dd-3571    [075] .....   862.875279: nvme_setup_cmd: nvme0: disk=nvme0c0n1, qid=4, cmdid=17, nsid=10, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=0, len=0, ctrl=0x0, dsmgmt=0, reftag=0)
  kworker/u385:6-611     [009] .....   871.458388: nvme_setup_cmd: nvme0: qid=0, cmdid=12289, nsid=0, flags=0x0, meta=0x0, cmd=(nvme_admin_keep_alive cdw10=00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00)
    ksoftirqd/10-79      [010] ..s..   871.458587: nvme_complete_rq: nvme0: qid=0, cmdid=12289, res=0x0, retries=0, flags=0x0, status=0x0
  kworker/u386:0-3234    [027] .....   886.818707: nvme_setup_cmd: nvme0: qid=0, cmdid=16384, nsid=0, flags=0x0, meta=0x0, cmd=(nvme_admin_keep_alive cdw10=00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00)
    ksoftirqd/28-188     [028] ..s..   886.818907: nvme_complete_rq: nvme0: qid=0, cmdid=16384, res=0x0, retries=0, flags=0x0, status=0x0
 irq/734-lpfc:27-1475    [028] .....   892.998612: nvme_complete_rq: nvme0: disk=nvme0c0n1, qid=4, cmdid=17, res=0x46, retries=0, flags=0x4, status=0x371

The target has bee configured to drop IO requests while allowing for
admin requests to complete. io_timeout is 30s and keepalive is 5s.

op ff110020edc3ab80 cmdid = 17 was issued at 862.875279. The request
timedout at 891.507377. Another transport error was detected at
891.533355 causing controller reset for this live controller. Couple
of ops were aborted because of the controller reset and controller
connected again. Only at 892.998612 we get cmdid17 completed.

Removing __nvme_fc_abort_op() in nvme_fc_timeout() should avoid this
problem. When hit an error jump straight to error recovery. This way we
account for all aborted requests and wait for them to complete.

> 
> > 
> > Here is an example scenario.
> > 
> > The first time a request times out it gets aborted we see this codepath
> > 
> > nvme_fc_timeout() ->
> >    __nvme_fc_abort_op() ->
> >      atomic_xchg(&op->state, FCPOP_STATE_ABORTED)
> >        ops->abort()
> >          return 0;
> 
> there's more than this in in the code:
> it changes op state to ABORTED, saving the old opstate.
> if the opstate wasn't active - it means something else changed and it 
> restores the old state (e.g. the aborts for the reset may have hit it).
> if it was active (e.g. the aborts the reset haven't hit it yet) it 
> checks the ctlr flag to see if the controller is being reset and 
> tracking io termination (the TERMIO flag) and if so, increments the 
> iocnt. So it is "included" in the reset.
> 
> if old state was active, it then sends the ABTS.
> if old state wasn't active (we've been here before or io terminated by 
> reset) it returns -ECANCELED, which will cause a controller reset to be 
> attempted if there's not already one in process.
> 
> 
> > 
> > nvme_fc_timeout() always return BLK_EH_RESET_TIMER so the same request
> > can timeout again. If the same request hits timeout again then
> > __nvme_fc_abort_op() returns -ECANCELED and nvme_fc_error_recovery()
> > gets called. Assuming the controller is LIVE it will be reset.
> 
> The normal case is timeout generates ABTS. ABTS usually completes 
> quickly with the io completing and the io callback to iodone, which sees 
> abort error status and resets controller. Its very typical for the ABTS 
> to complete long before the 2nd EH timer timing out.
> 
> Abnormal case is ABTS takes longer to complete than the 2nd EH timer 
> timing. Yes, that forces the controller reset.   I am aware that some 
> arrays will delay ABTS ACC while they terminate the back end, but there 
> are also frame drop conditions to consider.
> 
> if the controller is already resetting, all the above is largely n/a.
> 
> I see no reason to avoid the ABTS and wait for a 2nd EH timer to fire.
> 
> > 
> > nvme_fc_reset_ctrl_work() ->
> >    nvme_fc_delete_association() ->
> >      __nvme_fc_abort_outstanding_ios() ->
> >        nvme_fc_terminate_exchange() ->
> >          __nvme_fc_abort_op()
> > 
> > __nvme_fc_abort_op() finds that op already aborted. As a result of that
> > ctrl->iocnt will not be incrmented for this op. This means that
> > nvme_fc_delete_association() will not wait for this op to be aborted.
> 
> see missing code stmt above.
> 
> > 
> > I do not think we wait this behavior.
> > 
> > To continue the scenario above. The controller switches to CONNECTING
> > and the request times out again. This time we hit the deadlock described
> > in [1].
> > 
> > I think the first abort is the cause of the issue here. with this change
> > we should not hit the scenario described above.
> > 
> > 1 - https://lore.kernel.org/all/20250529214928.2112990-1-mkhalfella@purestorage.com/
> 
> Something else happened here. You can't get to CONNECTING state unless 
> all outstanding io was reaped in delete association. What is also harder 
> to understand is how there was an io to timeout if they've all been 
> reaped and queues haven't been restarted.  Timeout on one of the ios to 
> instatiate/init the controller maybe, but it shouldn't have been one of 
> those in the blk layer.

I think it is possible to get to CONNECTING state while IOs are inflight
because aborted requests are not counted as described above.

[ 3166.239944] nvme nvme0: NVME-FC{0}: create association : host wwpn 0x100070b7e41ed630  rport wwpn 0x524a937d171c5e08: NQN "nqn.2010-06.com.purestorage:flasharray.5452b4ac21023d99"
[ 3176.327597] nvme nvme0: NVME-FC{0.0}: io timeout: opcode 6 fctype 0 (Identify) w10/11: x00000001/x00000000, rq = ff110001f4292300, op = ff110001f4292400, cmdid = 14
[ 3176.345180] nvme nvme0: __nvme_fc_abort_op: op = ff110001f4292400
[ 3186.373826] nvme nvme0: NVME-FC{0.0}: io timeout: opcode 6 fctype 0 (Identify) w10/11: x00000001/x00000000, rq = ff110001f4292300, op = ff110001f4292400, cmdid = 14

  kworker/u386:9-4677    [081] .....  3167.681805: nvme_setup_cmd: nvme0: qid=0, cmdid=14, nsid=0, flags=0x0, meta=0x0, cmd=(nvme_admin_identify cns=1, ctrlid=0)
    ksoftirqd/34-225     [034] ..s..  3219.097132: nvme_complete_rq: nvme0: qid=0, cmdid=14, res=0x22, retries=0, flags=0x0, status=0x371

This is another way to repro the deadlock above. admin_timeout is set to
10s. Identify request was issued at 3167.681805 and timedout twice. The
second time it was not aborted and we head straight to the deadlock.
Eventually the HBA did abort the request, but it was too late by then.

[ 3325.117253] INFO: task kworker/3:4H:3337 blocked for more than 122 seconds.
[ 3325.125600]       Tainted: G S          E       6.19.0-rc7-vanilla+ #1
[ 3325.133408] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 3325.142643] task:kworker/3:4H    state:D stack:0     pid:3337  tgid:3337  ppid:2      task_flags:0x4208060 flags:0x00080000
[ 3325.155587] Workqueue: kblockd blk_mq_timeout_work
[ 3325.161412] Call Trace:
[ 3325.164589]  <TASK>
[ 3325.167389]  __schedule+0x81f/0x1230
[ 3325.195863]  schedule+0xcd/0x250
[ 3325.199864]  schedule_timeout+0x163/0x240
[ 3325.242655]  wait_for_completion+0x16f/0x3c0
[ 3325.263211]  __flush_work+0xfe/0x190
[ 3325.287450]  cancel_work_sync+0x82/0xb0
[ 3325.292094]  __nvme_fc_abort_outstanding_ios+0x1da/0x320 [nvme_fc]
[ 3325.299326]  nvme_fc_timeout+0x482/0x4f0 [nvme_fc]
[ 3325.317080]  blk_mq_handle_expired+0x194/0x2d0
[ 3325.328586]  bt_iter+0x24e/0x380
[ 3325.336998]  blk_mq_queue_tag_busy_iter+0x6ec/0x1660
[ 3325.360841]  blk_mq_timeout_work+0x3f0/0x5c0
[ 3325.385455]  process_one_work+0x82c/0x1450
[ 3325.404744]  worker_thread+0x5ee/0xfd0
[ 3325.414173]  kthread+0x3a0/0x750
[ 3325.441260]  ret_from_fork+0x439/0x670
[ 3325.459645]  ret_from_fork_asm+0x1a/0x30
[ 3325.464267]  </TASK>

> 
> > 
> >>
> >>
> >>>    	return BLK_EH_RESET_TIMER;
> >>>    }
> >>>    
> >>> @@ -3352,6 +3320,26 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
> >>>    	}
> >>>    }
> >>>    
> >>> +static void
> >>> +nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl)
> >>> +{
> >>> +	nvme_stop_keep_alive(&ctrl->ctrl);
> >>
> >> Curious, why did the stop_keep_alive() call get added to this ?
> >> Doesn't hurt.
> >>
> >> I assume it was due to other transports having it as they originally
> >> were calling stop_ctrl, but then moved to stop_keep_alive. Shouldn't
> >> this be followed by flush_work((&ctrl->ctrl.async_event_work) ?
> > 
> > Yes. I added it because it matches what other transports do.
> > 
> > nvme_fc_error_recovery() ->
> >    nvme_fc_delete_association() ->
> >      nvme_fc_abort_aen_ops() ->
> >        nvme_fc_term_aen_ops() ->
> >          cancel_work_sync(&ctrl->ctrl.async_event_work);
> > 
> > The above codepath takes care of async_event_work.
> 
> True, but the flush_works were added for a reason to the other 
> transports so I'm guessing timing matters. So waiting till ther later 
> term_aen call isn't great.  But I also guess, we haven't had an issue 
> prior and since we did take care if it in the aen routines, its likely 
> unneeded now.  Ok to add it but if so, we should keep the flush_work as 
> well. Also good to look same as the other transports.

I added flush_work(&ctrl->ctrl.async_event_work) to nvme_fc_error_recovery()
just after nvme_stop_ctrl(&ctrl->ctrl).

> 
> > 
> >>
> >>> +	nvme_stop_ctrl(&ctrl->ctrl);
> >>> +
> >>> +	/* will block while waiting for io to terminate */
> >>> +	nvme_fc_delete_association(ctrl);
> >>> +
> >>> +	/* Do not reconnect if controller is being deleted */
> >>> +	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
> >>> +		return;
> >>> +
> >>> +	if (ctrl->rport->remoteport.port_state == FC_OBJSTATE_ONLINE) {
> >>> +		queue_delayed_work(nvme_wq, &ctrl->connect_work, 0);
> >>> +		return;
> >>> +	}
> >>> +
> >>> +	nvme_fc_reconnect_or_delete(ctrl, -ENOTCONN);
> >>> +}
> >>
> >> This code and that in nvme_fc_reset_ctrl_work() need to be collapsed
> >> into a common helper function invoked by the 2 routines.  Also addresses
> >> the missing flush_delayed work in this routine.
> >>

flush_delayed_work(&ctrl->connect_work) has been added to
nvme_fc_reset_ctrl_work() in commit ac9b820e713b ("nvme-fc: remove
nvme_fc_terminate_io()"). I understood the idea is to make reset to wait
for at least the first connect attempt.

This should not be applicable to error recovery, right?

> > 
> > Agree, nvme_fc_error_recovery() and nvme_fc_reset_ctrl_work() have
> > common code that can be refactored. However, I do not plan to do this
> > part of this change. I will take a look after I get CCR work done.
> 
> Don't put it off. You are adding as much code as the refactoring is. 
> Just make the change.
> 
> -- james
> 
> 

