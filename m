Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962B3606A32E
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 03:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3cZj+zMe;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H8WqMXti
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=D7CefCWZnDATdIfCj+shwOmtJjWud/EiTml7MZ7Mj3k=; b=3cZj+zMevyDQETjEmqMhhDhYKM
	/9NqbGQdLCaJQrP1xkHVmPS15eSpKgTKdMyLRxPbqT4dn06YS7yTlX4ECDEZVD6QV4tVAu10BfWNH
	PLld+o6oQaXzgH4KnEu/SXho9EzKbG3AUVtwDD4+HBRO72DJ3x8akNQGZWdFbZ0yA/CgYCDaK/JMn
	XTAQTK5RmAdOXD0i5OVWH7tgNnwmx5mCZ2wXS82mQ36i3zzIzmVrIrFGnzjGscpTS2G6EQnFCAmw6
	hEwsfqzO9P7ppupJGGsGoS63lgOxuHgkD5+kcHgatyJPYCQvs7cdV17qZLhCcOkQ1EC79bDUCc+wB
	OCDckGlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS4bT-0000000FIRd-1Izz;
	Sat, 14 Nov 2026 03:38:59 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS4bR-0000000FIR9-1Jqp
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 03:38:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7E16641FC7;
	Sat, 14 Nov 2026 03:38:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C0B1F000C4;
	Sat, 14 Nov 2026 03:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794627536;
	bh=D7CefCWZnDATdIfCj+shwOmtJjWud/EiTml7MZ7Mj3k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H8WqMXti6G1M51KerxdbHpeQcc94XVljwGrVzDT5koD9yurrY0goMPGNthH8ls8z6
	 zKnGhVpLExdMGcBD8ZxiXUWZXCNTd2f7iKYeMEtpSk204KRuVud0VP5aaepRbxdn65
	 Kp+c8JkfJq9VzW+K2DjyNkNnjfiKy06dGK6qqYzBQHplsmjH3fxH6cKUVZOEAt53zD
	 vim2btSQ+JVZhwKnJMiXqhk+vKMDlt/9uljDKy5opr0YTATRO9MGHgDG/a6W6a1eyr
	 /G8LYciv8EIWzkUg9rzKtGNG1yl0GoKIJiGdUkYtDNl1m2dziia4JLIzIxFlfqM4FI
	 GNK2JxZj80Yhw==
Message-ID: <sashiko-outbox-214122@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/17] nvme-tcp: Use CCR to recover controller that
 hits an error
To: "Mohamed Khalfella" <mkhalfella@purestorage.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261114030454.2836543-11-mkhalfella@purestorage.com>
References: <20261114030454.2836543-1-mkhalfella@purestorage.com>
 <20261114030454.2836543-11-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 03:38:55 +0000
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [High] nvme-tcp: premature completion of in-flight requests in
  nvme_tcp_try_send()
- [High] nvme-tcp: non-multipath I/O retry exhaustion during
  NVME_CTRL_FENCING
- [High] nvme-tcp: race in nvme_tcp_fencing_work() skips err_work on
  reset
- [High] nvme-tcp: race between nvme_tcp_error_recovery() and
  nvme_tcp_stop_ctrl()
- [Medium] nvme-tcp: race in nvme_tcp_error_recovery() bypasses
  controller fencing
--

commit abb8e00ab3d00deda1ad0650e2f1521537edf566
Author: Mohamed Khalfella <mkhalfella@purestorage.com>

nvme-tcp: Use CCR to recover controller that hits an error

This commit transitions a live nvme-tcp controller to NVME_CTRL_FENCING on
error to attempt cross-controller reset via fencing_work before proceeding
to NVME_CTRL_RESETTING, while holding timed-out requests until fencing
completes.

> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 7ecc6c007f8d4..244c6c50cf990 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
[ ... ]
> @@ -651,6 +652,12 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_q=
ueue *queue)
> =20
>  static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
>  {
> +	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCING)) {
> +		dev_warn(ctrl->device, "starting controller fencing\n");
> +		queue_work(nvme_wq, &to_tcp_ctrl(ctrl)->fencing_work);
> +		return;
> +	}

[Severity: High]
Does leaving the queues unquiesced while ctrl is in NVME_CTRL_FENCING
cause non-multipath requests to exhaust their retries and fail
immediately?

When a request is dispatched to nvme_tcp_queue_rq() during
NVME_CTRL_FENCING or NVME_CTRL_FENCED, nvme_check_ready() returns false
and nvme_tcp_queue_rq() calls nvme_fail_nonready_command() before
nvme_tcp_setup_cmd_pdu():

drivers/nvme/host/core.c:nvme_fail_nonready_command() {
	...
	if (state !=3D NVME_CTRL_DELETING_NOIO &&
	    state !=3D NVME_CTRL_DELETING &&
	    state !=3D NVME_CTRL_FENCING &&
	    state !=3D NVME_CTRL_FENCED &&
	    state !=3D NVME_CTRL_DEAD &&
	    !test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags) &&
	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
		return BLK_STS_RESOURCE;

	if (!(rq->rq_flags & RQF_DONTPREP))
		nvme_clear_nvme_request(rq);

	return nvme_host_path_error(rq);
}

Because NVME_CTRL_FENCING and NVME_CTRL_FENCED are excluded from returning
BLK_STS_RESOURCE, a non-multipath request (without REQ_NVME_MPATH) sets
RQF_DONTPREP and completes with NVME_SC_HOST_PATH_ERROR.
nvme_decide_disposition() then chooses RETRY and nvme_retry_req() kicks
the requeue list with zero delay on the still-unquiesced queue.  The
request loops through nvme_tcp_queue_rq() five times in a tight loop until
retries reach nvme_max_retries, logs an uninitialized or stale command in
nvme_log_error(), and fails with BLK_STS_TRANSPORT instead of waiting for
controller recovery.

> +
>  	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
>  		return;

[Severity: Medium]
Can this fallback nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING) call
transition a newly NVME_CTRL_LIVE controller directly to
NVME_CTRL_RESETTING and bypass fencing?

In nvme-tcp, ctrl->state leaves NVME_CTRL_NEW before any queues or sockets
exist, so NVME_CTRL_RESETTING can only be entered from NVME_CTRL_LIVE or
NVME_CTRL_FENCED.  If a socket callback triggers nvme_tcp_error_recovery()
while nvme_tcp_setup_ctrl() is finishing connection setup, the two state
changes can interleave:

CPU0                                  CPU1
nvme_tcp_error_recovery()             nvme_tcp_setup_ctrl()
  nvme_change_ctrl_state(...,
    NVME_CTRL_FENCING) -> false
    (state is NVME_CTRL_CONNECTING)
                                        nvme_change_ctrl_state(...,
                                          NVME_CTRL_LIVE) -> true
                                          nvme_kick_requeue_lists()
  nvme_change_ctrl_state(...,
    NVME_CTRL_RESETTING) -> true
  queue_work(..., &err_work)          <-- skips fencing_work

Requests dispatched as the controller became NVME_CTRL_LIVE are then
canceled by err_work and retried on another path without fencing the
controller first.  Removing the NVME_CTRL_RESETTING fallback from
nvme_tcp_error_recovery() avoids this race, since nvme-tcp only needs to
trigger error recovery from NVME_CTRL_LIVE.

> @@ -2767,6 +2774,22 @@ static void nvme_tcp_reconnect_ctrl_work(struct wo=
rk_struct *work)
>  	nvme_tcp_reconnect_or_remove(ctrl, ret);
>  }
> =20
> +static void nvme_tcp_fencing_work(struct work_struct *work)
> +{
> +	struct nvme_tcp_ctrl *tcp_ctrl =3D container_of(work,
> +			struct nvme_tcp_ctrl, fencing_work);
> +	struct nvme_ctrl *ctrl =3D &tcp_ctrl->ctrl;
> +	unsigned long rem;
> +
> +	rem =3D nvme_fence_ctrl(ctrl);
> +	if (rem)
> +		dev_info(ctrl->device, "CCR failed, starting error recovery\n");
> +
> +	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
> +	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> +		queue_work(nvme_reset_wq, &tcp_ctrl->err_work);
> +}

[Severity: High]
Can another caller claim the NVME_CTRL_FENCED to NVME_CTRL_RESETTING
transition between these two nvme_change_ctrl_state() calls and prevent
tcp_ctrl->err_work from running?

nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED) sets ctrl->state to
NVME_CTRL_FENCED, calls wake_up_all(&ctrl->state_wq), and drops ctrl->lock
before the second nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING) call:

CPU0                                  CPU1
nvme_tcp_fencing_work()               nvmf_subsystem_reset()
  nvme_change_ctrl_state(...,           nvme_wait_reset(ctrl)
    NVME_CTRL_FENCED)
    wake_up_all(&ctrl->state_wq)
                                          nvme_change_ctrl_state(...,
                                            NVME_CTRL_RESETTING) -> true
  nvme_change_ctrl_state(...,
    NVME_CTRL_RESETTING) -> false
  (err_work not queued)
                                        reg_write32() -> fails on dead sock
                                        returns error  <-- stuck in RESETTI=
NG

When nvmf_subsystem_reset() wins the transition, reg_write32() fails over
the broken transport before nvme_try_sched_reset(), leaving the controller
permanently wedged in NVME_CTRL_RESETTING with neither err_work nor
reset_work scheduled.  A concurrent nvme_reset_ctrl() (such as from
nvme_keep_alive_work(), nvme_anatt_timeout(), or sysfs reset_controller)
can likewise claim NVME_CTRL_RESETTING here and queue reset_work instead
of err_work, which attempts nvme_disable_ctrl() over the dead admin socket
and leaves the queues quiesced if nvme_tcp_setup_ctrl() fails.

[ ... ]

> @@ -2842,6 +2865,7 @@ static void nvme_reset_ctrl_work(struct work_struct=
 *work)
> =20
>  static void nvme_tcp_stop_ctrl(struct nvme_ctrl *ctrl)
>  {
> +	flush_work(&to_tcp_ctrl(ctrl)->fencing_work);
>  	flush_work(&to_tcp_ctrl(ctrl)->err_work);
>  	cancel_delayed_work_sync(&to_tcp_ctrl(ctrl)->connect_work);
>  }

[Severity: High]
Can nvme_tcp_stop_ctrl() run flush_work(&to_tcp_ctrl(ctrl)->fencing_work)
before nvme_tcp_error_recovery() calls queue_work(), allowing fencing_work
to run during and after controller deletion?

In nvme_do_delete_ctrl(), nvme_stop_ctrl() runs before
ctrl->ops->delete_ctrl() stops the sockets and queues, and
nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING) is permitted from
NVME_CTRL_FENCING:

CPU0                                  CPU1
nvme_tcp_error_recovery()             nvme_do_delete_ctrl()
  nvme_change_ctrl_state(...,
    NVME_CTRL_FENCING) -> true
                                        nvme_change_ctrl_state(...,
                                          NVME_CTRL_DELETING) -> true
                                        nvme_stop_ctrl()
                                          nvme_tcp_stop_ctrl()
                                            flush_work(&fencing_work)
  dev_warn(...)
  queue_work(nvme_wq, &fencing_work)
                                        ...
                                        nvme_free_ctrl()
                                          kfree(ctrl)
nvme_tcp_fencing_work()
  nvme_fence_ctrl(ctrl)               <-- use-after-free

Because flush_work() returns immediately when fencing_work has not been
queued yet, fencing_work is never flushed again before the controller is
freed.

[ ... ]

> @@ -2944,17 +2968,19 @@ static enum blk_eh_timer_return nvme_tcp_timeout(=
struct request *rq)
[ ... ]
>  	/*
>  	 * LIVE state should trigger the normal error recovery which will
> -	 * handle completing this request.
> +	 * handle completing this request. In FENCING state the request must
> +	 * not be completed before fencing has finished, so just rearm the
> +	 * timer and let the error recovery pick it up.
>  	 */
>  	nvme_tcp_error_recovery(ctrl);
>  	return BLK_EH_RESET_TIMER;

[Severity: High]
While nvme_tcp_timeout() holds timed-out requests during NVME_CTRL_FENCING,
does nvme_tcp_try_send() still complete in-flight requests immediately on
a socket send error before fencing finishes?

When a controller enters NVME_CTRL_FENCING, its queues and queue->io_work
remain active until fencing_work finishes and queues err_work.  If an
in-flight write request has already sent its command capsule (or received
an R2T) and sock_sendmsg() fails while sending H2C data,
nvme_tcp_try_send() fails and completes the request right away:

drivers/nvme/host/tcp.c:nvme_tcp_try_send() {
	...
	} else if (ret < 0) {
		dev_err(queue->ctrl->ctrl.device,
			"failed to send request %d\n", ret);
		nvme_tcp_fail_request(queue->request);
		nvme_tcp_done_send_req(queue);
	}
	...
}

nvme_tcp_fail_request() completes the request with
NVME_SC_HOST_PATH_ERROR, which triggers multipath failover while the
controller is still in NVME_CTRL_LIVE or NVME_CTRL_FENCING and before
nvme_fence_ctrl() has terminated the command on the target.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114030454.2836=
543-1-mkhalfella@purestorage.com?part=3D10

