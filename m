Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF6E606A31C
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 02:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=XFQYGZaG;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=KP9mgoKM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=mshUeIONfV1AmdiMI9dxWTVYamiiHifaiVxGW+DSDUE=; b=XFQYGZaGWs+vX+hOKGDPpBm1Ks
	94xGZxykYhA1ry5kF1rBaOLCcxHWXYQxExg91UZd8pVvQqstCIDbQ/DgA5zBe1CxQzm4D0PikN4vY
	toweEtFhjh5+xOdsKnL+6uiZ/h4rJqXe9JIrpt476tgvl+TkrLFWaWc2CErPY0Uy5x3/TSE3TYVs5
	n2u9s/jwkvkpjJoD5+aqzKtBxgXdDo76i2oAkuynZPhvtAgj1nvrdT1GA1LvTPnrS42pD3IpnUwo5
	cVnQR/9LAGipSW5Cw6SdgOJvaNq+GnrHpZJs7Q5K7Oi4OX7Vb/AI0DNFmkyT+E88/blUd3XC0QEo3
	yF3+KFFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTVQm-00000007X9P-3NlP;
	Wed, 18 Nov 2026 02:29:52 +0000
Received: from mail-dy1-x1335.google.com ([2607:f8b0:4864:20::1335])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTVQj-00000007X81-1Ryx
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 02:29:51 +0000
Received: by mail-dy1-x1335.google.com with SMTP id 5a478bee46e88-382f4710a17so173593eec.0
        for <linux-nvme@lists.infradead.org>; Tue, 17 Nov 2026 18:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1794968988; x=1795573788; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mshUeIONfV1AmdiMI9dxWTVYamiiHifaiVxGW+DSDUE=;
        b=KP9mgoKMloMekEcQSG1HotOYUYBx0uKHyNm8nDTqqCo+c1Mw4HN7IOhWNlBcqZHtt/
         IUD7MlN1wajZ4U5RRgvA2o808bkC17+EfqzRv74F+madhgPbE7nf3kg+mfZ5V0O/ctaw
         Uto1EnvUiWSiv1px7niws34flPcjD7HpiXEAofB2csg/mFMWVCka2YkalBcZo0iOTFoZ
         eEclOn5ksMZMxMmUiWzPRg03PE3L7w7hiqbv3bPU095E2/BeoEfwWMJOnq5CANQzvE7k
         FLHK0YVDxIpyRcBael2av/uw/b0rAaRoBTZNK0ruj4iDsOEq2cAVrceXdZxQpM56QqwG
         ifnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794968988; x=1795573788;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mshUeIONfV1AmdiMI9dxWTVYamiiHifaiVxGW+DSDUE=;
        b=NP5ys9yWvu8RvNDnMcb5csdgDzz89FsUjtK9QJ/Kuu74DizwegrzN5Qp1BVHEUx2q5
         mVWbEc3iuQnOb0dyqdwEG9fAOgvHswCsvf8Udaj06TiKi/Lle+oMjw418nwcrKill/26
         xAcsUOaoMNvdo9p9/qCkL9Q6FLi9CzMqcqJ+6t/P7sbve1qW1WKVlyNigIxdjnlDVxFz
         Mv7qenjsuWyjQRNGvQ85xfAe9OJ946S08rXL/rMqDMeqrPtT8eoCq5wfOreJftVLXR1n
         2og548LZuu6moinuKUkQ87v4OpB3EP0b68LBZk4VYBspvyuhOYgBrS07EVltrdoqj+3K
         vSXg==
X-Gm-Message-State: APuU4Z9JM9Ty2TL0ZLhtJoQMz1gtqvLR+0GcNRyuLsx6E1PnboC9VW0q
	D4e+uMjKf6zPVYeg/8IaBZhEgPLJ+sISXTgyFNJCg3qz0ecPD40qIMJaoX/7PUuSxfS7HwtFxdp
	UcVuSJow=
X-Gm-Gg: AZFdTZckLylQin7tYPzIvyqRVnoQAACktcXgYVVDRxhInlDTzOLhtOE2qf2IdreTVol
	6SC8Lh1Wo/vFbERWkB59+YEr2decAJdq4nyahygsmz5uIv53LPIOHAPF6g1zVJAV30Ct1UlKPWp
	lfVpXOuZAn7oKgwhtfA1EhLHgVTQZacZvkV1ccVooXPO7x3BqE8eTlgi/PlyO2gEerqXI/PA91u
	SYocWSchhphtBkWYsiRVy4Ye+WXtSQpqRdR+ze2aSwlrR6P563sfCrtkjaqWgWBVgSSXnePGGUh
	rDSQZfpCj2Y5yJq4HzFWBeq9yeGWHrbvuuk1Z7vJNtgS7hcJdzZ0N3eQxJP2FoU+Xm3zAGnHSVN
	CMI6gAbur6YZzaanbJ+1iywWHOLs/HmGAE+UcNs46ZiZmU4U+ORpAzJ5WJxylHOMa8pnsG4TAp5
	u94PEomzfHCe3PK4hjV3WXG0RUvAJP+pPYjERHoLrDoY/QH80ibLLKAkR7Pg5s1+oHiA3k/wxsG
	7OGut1bF9bQzoGohlpMjeVaLTBY4i4fAlT1gn/drOBBVSETFokRPqz3ExFr72ovgHvELa410s8s
	ZS1+pVxODkUj4BuC35X1AJq7sEQ34IdM8+4KUuzU1M7cQjdyBw==
X-Received: by 2002:a05:7300:c7c4:b0:381:610e:4045 with SMTP id 5a478bee46e88-38280079f92mr1290757eec.8.1794968988031;
        Tue, 17 Nov 2026 18:29:48 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-382a76d70fasm2246385eec.22.2026.11.17.18.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 18:29:47 -0800 (PST)
Date: Tue, 17 Nov 2026 18:29:45 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH v7 10/17] nvme-tcp: Use CCR to recover controller that
 hits an error
Message-ID: <20261118022945.GI1670230-mkhalfella@purestorage.com>
References: <20261114030454.2836543-1-mkhalfella@purestorage.com>
 <20261114030454.2836543-11-mkhalfella@purestorage.com>
 <sashiko-outbox-214122@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-214122@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_182949_567111_86C8F96A 
X-CRM114-Status: GOOD (  41.35  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat 2026-11-14 03:38:55 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential
> issues to consider:
> - [High] nvme-tcp: premature completion of in-flight requests in
>   nvme_tcp_try_send()
> - [High] nvme-tcp: non-multipath I/O retry exhaustion during
>   NVME_CTRL_FENCING
> - [High] nvme-tcp: race in nvme_tcp_fencing_work() skips err_work on
>   reset
> - [High] nvme-tcp: race between nvme_tcp_error_recovery() and
>   nvme_tcp_stop_ctrl()
> - [Medium] nvme-tcp: race in nvme_tcp_error_recovery() bypasses
>   controller fencing
> --
> 
> commit abb8e00ab3d00deda1ad0650e2f1521537edf566
> Author: Mohamed Khalfella <mkhalfella@purestorage.com>
> 
> nvme-tcp: Use CCR to recover controller that hits an error
> 
> This commit transitions a live nvme-tcp controller to NVME_CTRL_FENCING on
> error to attempt cross-controller reset via fencing_work before proceeding
> to NVME_CTRL_RESETTING, while holding timed-out requests until fencing
> completes.
> 
> > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > index 7ecc6c007f8d4..244c6c50cf990 100644
> > --- a/drivers/nvme/host/tcp.c
> > +++ b/drivers/nvme/host/tcp.c
> [ ... ]
> > @@ -651,6 +652,12 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
> >  
> >  static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
> >  {
> > +	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCING)) {
> > +		dev_warn(ctrl->device, "starting controller fencing\n");
> > +		queue_work(nvme_wq, &to_tcp_ctrl(ctrl)->fencing_work);
> > +		return;
> > +	}
> 
> [Severity: High]
> Does leaving the queues unquiesced while ctrl is in NVME_CTRL_FENCING
> cause non-multipath requests to exhaust their retries and fail
> immediately?
> 
> When a request is dispatched to nvme_tcp_queue_rq() during
> NVME_CTRL_FENCING or NVME_CTRL_FENCED, nvme_check_ready() returns false
> and nvme_tcp_queue_rq() calls nvme_fail_nonready_command() before
> nvme_tcp_setup_cmd_pdu():
> 
> drivers/nvme/host/core.c:nvme_fail_nonready_command() {
> 	...
> 	if (state != NVME_CTRL_DELETING_NOIO &&
> 	    state != NVME_CTRL_DELETING &&
> 	    state != NVME_CTRL_FENCING &&
> 	    state != NVME_CTRL_FENCED &&
> 	    state != NVME_CTRL_DEAD &&
> 	    !test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags) &&
> 	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
> 		return BLK_STS_RESOURCE;
> 
> 	if (!(rq->rq_flags & RQF_DONTPREP))
> 		nvme_clear_nvme_request(rq);
> 
> 	return nvme_host_path_error(rq);
> }
> 
> Because NVME_CTRL_FENCING and NVME_CTRL_FENCED are excluded from returning
> BLK_STS_RESOURCE, a non-multipath request (without REQ_NVME_MPATH) sets
> RQF_DONTPREP and completes with NVME_SC_HOST_PATH_ERROR.
> nvme_decide_disposition() then chooses RETRY and nvme_retry_req() kicks
> the requeue list with zero delay on the still-unquiesced queue.  The
> request loops through nvme_tcp_queue_rq() five times in a tight loop until
> retries reach nvme_max_retries, logs an uninitialized or stale command in
> nvme_log_error(), and fails with BLK_STS_TRANSPORT instead of waiting for
> controller recovery.

NVME_CTRL_FENCING and NVME_CTRL_FENCED have been delted from
nvme_fail_nonready_command() in review of pervious path.

> 
> > +
> >  	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> >  		return;
> 
> [Severity: Medium]
> Can this fallback nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING) call
> transition a newly NVME_CTRL_LIVE controller directly to
> NVME_CTRL_RESETTING and bypass fencing?
> 
> In nvme-tcp, ctrl->state leaves NVME_CTRL_NEW before any queues or sockets
> exist, so NVME_CTRL_RESETTING can only be entered from NVME_CTRL_LIVE or
> NVME_CTRL_FENCED.  If a socket callback triggers nvme_tcp_error_recovery()
> while nvme_tcp_setup_ctrl() is finishing connection setup, the two state
> changes can interleave:
> 
> CPU0                                  CPU1
> nvme_tcp_error_recovery()             nvme_tcp_setup_ctrl()
>   nvme_change_ctrl_state(...,
>     NVME_CTRL_FENCING) -> false
>     (state is NVME_CTRL_CONNECTING)
>                                         nvme_change_ctrl_state(...,
>                                           NVME_CTRL_LIVE) -> true
>                                           nvme_kick_requeue_lists()
>   nvme_change_ctrl_state(...,
>     NVME_CTRL_RESETTING) -> true
>   queue_work(..., &err_work)          <-- skips fencing_work
> 
> Requests dispatched as the controller became NVME_CTRL_LIVE are then
> canceled by err_work and retried on another path without fencing the
> controller first.  Removing the NVME_CTRL_RESETTING fallback from
> nvme_tcp_error_recovery() avoids this race, since nvme-tcp only needs to
> trigger error recovery from NVME_CTRL_LIVE.

Good point. Updated nvme_tcp_error_recovery() to only change the
controller state to FENCING. This should be okay because the
was-only-valid transition LIVE -> RESETTING is now claimed by FENCING.

> 
> > @@ -2767,6 +2774,22 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
> >  	nvme_tcp_reconnect_or_remove(ctrl, ret);
> >  }
> >  
> > +static void nvme_tcp_fencing_work(struct work_struct *work)
> > +{
> > +	struct nvme_tcp_ctrl *tcp_ctrl = container_of(work,
> > +			struct nvme_tcp_ctrl, fencing_work);
> > +	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
> > +	unsigned long rem;
> > +
> > +	rem = nvme_fence_ctrl(ctrl);
> > +	if (rem)
> > +		dev_info(ctrl->device, "CCR failed, starting error recovery\n");
> > +
> > +	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
> > +	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> > +		queue_work(nvme_reset_wq, &tcp_ctrl->err_work);
> > +}
> 
> [Severity: High]
> Can another caller claim the NVME_CTRL_FENCED to NVME_CTRL_RESETTING
> transition between these two nvme_change_ctrl_state() calls and prevent
> tcp_ctrl->err_work from running?
> 
> nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED) sets ctrl->state to
> NVME_CTRL_FENCED, calls wake_up_all(&ctrl->state_wq), and drops ctrl->lock
> before the second nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING) call:
> 
> CPU0                                  CPU1
> nvme_tcp_fencing_work()               nvmf_subsystem_reset()
>   nvme_change_ctrl_state(...,           nvme_wait_reset(ctrl)
>     NVME_CTRL_FENCED)
>     wake_up_all(&ctrl->state_wq)
>                                           nvme_change_ctrl_state(...,
>                                             NVME_CTRL_RESETTING) -> true
>   nvme_change_ctrl_state(...,
>     NVME_CTRL_RESETTING) -> false
>   (err_work not queued)
>                                         reg_write32() -> fails on dead sock
>                                         returns error  <-- stuck in RESETTING
> 
> When nvmf_subsystem_reset() wins the transition, reg_write32() fails over
> the broken transport before nvme_try_sched_reset(), leaving the controller
> permanently wedged in NVME_CTRL_RESETTING with neither err_work nor
> reset_work scheduled.  A concurrent nvme_reset_ctrl() (such as from
> nvme_keep_alive_work(), nvme_anatt_timeout(), or sysfs reset_controller)
> can likewise claim NVME_CTRL_RESETTING here and queue reset_work instead
> of err_work, which attempts nvme_disable_ctrl() over the dead admin socket
> and leaves the queues quiesced if nvme_tcp_setup_ctrl() fails.

This is a pre-existing issue. nvmf_subsystem_reset() is broken today and
can leave the controller in RESETTING state if reg_write32() fails.
Will not address part of this patchset.

> 
> [ ... ]
> 
> > @@ -2842,6 +2865,7 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
> >  
> >  static void nvme_tcp_stop_ctrl(struct nvme_ctrl *ctrl)
> >  {
> > +	flush_work(&to_tcp_ctrl(ctrl)->fencing_work);
> >  	flush_work(&to_tcp_ctrl(ctrl)->err_work);
> >  	cancel_delayed_work_sync(&to_tcp_ctrl(ctrl)->connect_work);
> >  }
> 
> [Severity: High]
> Can nvme_tcp_stop_ctrl() run flush_work(&to_tcp_ctrl(ctrl)->fencing_work)
> before nvme_tcp_error_recovery() calls queue_work(), allowing fencing_work
> to run during and after controller deletion?
> 
> In nvme_do_delete_ctrl(), nvme_stop_ctrl() runs before
> ctrl->ops->delete_ctrl() stops the sockets and queues, and
> nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING) is permitted from
> NVME_CTRL_FENCING:
> 
> CPU0                                  CPU1
> nvme_tcp_error_recovery()             nvme_do_delete_ctrl()
>   nvme_change_ctrl_state(...,
>     NVME_CTRL_FENCING) -> true
>                                         nvme_change_ctrl_state(...,
>                                           NVME_CTRL_DELETING) -> true
>                                         nvme_stop_ctrl()
>                                           nvme_tcp_stop_ctrl()
>                                             flush_work(&fencing_work)
>   dev_warn(...)
>   queue_work(nvme_wq, &fencing_work)
>                                         ...
>                                         nvme_free_ctrl()
>                                           kfree(ctrl)
> nvme_tcp_fencing_work()
>   nvme_fence_ctrl(ctrl)               <-- use-after-free
> 
> Because flush_work() returns immediately when fencing_work has not been
> queued yet, fencing_work is never flushed again before the controller is
> freed.

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d079ca6412a5..d83daf10f50d 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2794,6 +2788,10 @@ static void nvme_tcp_fencing_work(struct work_struct *work)
 	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
 	unsigned long rem;

+	/* Skip fencing if the controller has been deleted */
+	if (nvme_ctrl_state(ctrl) != NVME_CTRL_FENCING)
+		return;
+
 	rem = nvme_fence_ctrl(ctrl);
 	if (!rem)
 		goto done;
@@ -2856,6 +2854,8 @@ static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 static void nvme_tcp_delete_ctrl(struct nvme_ctrl *ctrl)
 {
 	nvme_tcp_teardown_ctrl(ctrl, true);
+	cancel_work_sync(&to_tcp_ctrl(ctrl)->fencing_work);
+	cancel_delayed_work_sync(&to_tcp_ctrl(ctrl)->fenced_work);
 }

 static void nvme_reset_ctrl_work(struct work_struct *work)


This is a valid point. Fixed with the change above.

> 
> [ ... ]
> 
> > @@ -2944,17 +2968,19 @@ static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
> [ ... ]
> >  	/*
> >  	 * LIVE state should trigger the normal error recovery which will
> > -	 * handle completing this request.
> > +	 * handle completing this request. In FENCING state the request must
> > +	 * not be completed before fencing has finished, so just rearm the
> > +	 * timer and let the error recovery pick it up.
> >  	 */
> >  	nvme_tcp_error_recovery(ctrl);
> >  	return BLK_EH_RESET_TIMER;
> 
> [Severity: High]
> While nvme_tcp_timeout() holds timed-out requests during NVME_CTRL_FENCING,
> does nvme_tcp_try_send() still complete in-flight requests immediately on
> a socket send error before fencing finishes?
> 
> When a controller enters NVME_CTRL_FENCING, its queues and queue->io_work
> remain active until fencing_work finishes and queues err_work.  If an
> in-flight write request has already sent its command capsule (or received
> an R2T) and sock_sendmsg() fails while sending H2C data,
> nvme_tcp_try_send() fails and completes the request right away:
> 
> drivers/nvme/host/tcp.c:nvme_tcp_try_send() {
> 	...
> 	} else if (ret < 0) {
> 		dev_err(queue->ctrl->ctrl.device,
> 			"failed to send request %d\n", ret);
> 		nvme_tcp_fail_request(queue->request);
> 		nvme_tcp_done_send_req(queue);
> 	}
> 	...
> }
> 
> nvme_tcp_fail_request() completes the request with
> NVME_SC_HOST_PATH_ERROR, which triggers multipath failover while the
> controller is still in NVME_CTRL_LIVE or NVME_CTRL_FENCING and before
> nvme_fence_ctrl() has terminated the command on the target.

This is not an issue. At this point queue->request has not been
completely sent to the target. IOW, the target can not complete
processing this request because it is missing data. It should be okay to
complete the request immediately.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261114030454.2836543-1-mkhalfella@purestorage.com?part=10

