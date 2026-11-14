Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291D0606A330
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 04:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=NNXjmGk/;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JcymG/FN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=9Km/gSgBC2ZurZ3HmB0YZ3RQOQ+UxF22IOZA8hCBP0A=; b=NNXjmGk/2k2/Bep8DJdHzPOvrN
	MQ4d0tbs+1QSySIWrvGS03+TdLC1hScEiWxoANrC+7APg9CIJpm4FZjP6MLTTDoFtl0SjhkYwxjoA
	2uEMcahV++flIEO1hANWXi2rW8Cx4bqMA9LqImuIKC56UxdxRAHDxXl7dCc1CWAKVW0As4YpaO6kp
	SaejuSUYQXt0ElCxbdGEGgGjiUG8lFko6tnu0gb4e1qunDL3i9FVRJ2iMVPfwjiH4n3cgKgdvjhDB
	nngBSHYc0CGdum68f7p6hJLct6wjNqoON2Hz0fgsLweUvMnyE8IBpjqJ9VuYw5LZN/7JWPWdnFhks
	oJlRdp8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS52R-0000000FLYn-48Sr;
	Sat, 14 Nov 2026 04:06:51 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS52Q-0000000FLYh-1EK6
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 04:06:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A86E64129A;
	Sat, 14 Nov 2026 04:06:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDA91F000C4;
	Sat, 14 Nov 2026 04:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794629209;
	bh=9Km/gSgBC2ZurZ3HmB0YZ3RQOQ+UxF22IOZA8hCBP0A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JcymG/FNknbgvJ8Ro71IchaB/OeBlpv3B/QO9IdhvrmLg8ILeapMPVKPJmlZJ+vPP
	 HxWaPRV2wIHOTwKksCxv0G/lycO7tDz9PrT/5c4RylQHFtf7k3qa+BL2Ck9+WvrJsA
	 YrS5MUyLTjrkk715tRqyS1Mcr2/49+c4ynyfUCWaRh9qUFieFtCttThK8WAJRS1aW/
	 MOT+c/ds7CIPhuclyu9yv1CJx2ckA6cZBwDo5fvfdlzUmNOUklDlFrKwC7BWOrZftM
	 azNoB2Xpj7DMouNYpm8XyxmycnxO/83F97tXG6hDJ2wwUFeiq3z4mDwSLDv+zVWOZB
	 U/VKmr3op2RAw==
Message-ID: <sashiko-outbox-214135@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 15/17] nvme-fc: Hold inflight requests while in
 FENCING state
To: "Mohamed Khalfella" <mkhalfella@purestorage.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261114030454.2836543-16-mkhalfella@purestorage.com>
References: <20261114030454.2836543-1-mkhalfella@purestorage.com>
 <20261114030454.2836543-16-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 04:06:48 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] nvme-fc: use-after-free on ctrl in nvme_fc_fcpio_done() after
  completing rq
- [High] nvme-fc: missing drain of completing ops in
  nvme_fc_fcpio_done()
--

commit 37b80917265ea84d22dcb27e9731ac42994f67a4
Author: Mohamed Khalfella <mkhalfella@purestorage.com>

nvme-fc: Hold inflight requests while in FENCING state

This commit splits nvme_fc_delete_association() into teardown and request
flushing helpers, tracks held requests with FCPOP_STATE_HELD, and delays
completing in-flight requests until controller fencing finishes.

> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 095adc9011ccd..5e8977ad51cf8 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
[ ... ]
> @@ -2113,22 +2125,58 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
>  	terminate_assoc =3D false;
> =20
>  done:
> +	/*
> +	 * Start recovery before completing or holding anything. A held
> +	 * request is only completed by nvme_fc_flush_held_requests(), which
> +	 * fencing_work runs once the fence is over, so a request may only be
> +	 * held once FENCING has been claimed and fencing_work is guaranteed
> +	 * to run. If the claim fails because a reset or a delete already owns
> +	 * the controller, the request is completed below and that owner
> +	 * tears the association down.
> +	 */
> +	if (terminate_assoc) {
> +		nvme_fc_start_ioerr_recovery(ctrl, "io error");
> +		hold =3D nvme_ctrl_state(&ctrl->ctrl) =3D=3D NVME_CTRL_FENCING;
> +	}
> +
>  	if (op->flags & FCOP_FLAGS_AEN) {
>  		nvme_complete_async_event(&queue->ctrl->ctrl, status, &result);
> -		__nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate);
> +		if (__nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate))
> +			__nvme_fc_fcpop_count_one_down(ctrl);
>  		atomic_set(&op->state, FCPOP_STATE_IDLE);
>  		op->flags =3D FCOP_FLAGS_AEN;	/* clear other flags */
>  		nvme_fc_ctrl_put(ctrl);
> -		goto check_error;
> +		return;
>  	}
> =20
> -	__nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate);
> +	/*
> +	 * We can not access op after the request is completed because it can
> +	 * be reused immediately. At the same time we want to wakeup the thread
> +	 * waiting for ongoing IOs _after_ requests are completed. This is
> +	 * necessary because that thread will start canceling inflight IOs
> +	 * and we want to avoid request completion racing with cancellation.
> +	 */
> +	op_term =3D __nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate);
> +
> +	/*
> +	 * If the controller is FENCING, do not complete this request now.
> +	 * Move the op to HELD and let nvme_fc_cancel_held_requests() cancel
> +	 * it when it is safe to do so. HELD is only reachable from COMPLETE
> +	 * through this cmpxchg: if the cancellation has already walked the
> +	 * tagset it moved the op out of COMPLETE, the cmpxchg fails and the
> +	 * request is completed here instead. Either way exactly one path
> +	 * completes it.
> +	 */
> +	if (hold && atomic_cmpxchg(&op->state, FCPOP_STATE_COMPLETE,
> +				   FCPOP_STATE_HELD) =3D=3D FCPOP_STATE_COMPLETE)
> +		goto check_op_term;
> +
>  	if (!nvme_try_complete_req(rq, status, result))
>  		nvme_fc_complete_rq(rq);
> =20
> -check_error:
> -	if (terminate_assoc)
> -		nvme_fc_start_ioerr_recovery(ctrl, "io error");
> +check_op_term:
> +	if (op_term)
> +		__nvme_fc_fcpop_count_one_down(ctrl);
>  }

[Severity: High]
Can __nvme_fc_fcpop_count_one_down(ctrl) cause a use-after-free on ctrl
when a non-held aborted request completes?

nvme_fc_complete_rq(rq) drops the FCP op's reference via
nvme_fc_ctrl_put(ctrl) before check_op_term runs.  When
__nvme_fc_fcpop_count_one_down() then decrements ctrl->iocnt to 0, a
concurrent controller deletion can finish teardown and free ctrl before
wake_up(&ctrl->ioabort_wait) runs:

CPU0                                  CPU1
nvme_fc_fcpio_done()                  nvme_do_delete_ctrl()
  nvme_fc_complete_rq(rq)               nvme_fc_delete_ctrl()
    nvme_fc_ctrl_put(ctrl)                ...
  __nvme_fc_fcpop_count_one_down()          wait_event(..., iocnt =3D=3D 0)
    atomic_dec_return(&ctrl->iocnt)
                                          ...
                                        nvme_uninit_ctrl()
                                        nvme_put_ctrl()
                                          ...
                                            kfree(ctrl)
    wake_up(&ctrl->ioabort_wait)  <-- use-after-free

Acquiring an extra reference on ctrl around
__nvme_fc_fcpop_count_one_down(ctrl), or dropping the op's ctrl reference
only after check_op_term when the request is completed, would keep ctrl
alive across the wakeup.

[ ... ]

> @@ -3323,13 +3372,71 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *c=
trl)
>  	__nvme_fc_delete_hw_queue(ctrl, &ctrl->queues[0], 0);
>  	nvme_fc_free_queue(&ctrl->queues[0]);
> =20
> +	nvme_fc_ctlr_inactive_on_rport(ctrl);
> +}
> +
> +static bool
> +nvme_fc_cancel_held_request(struct request *req, void *data)
> +{
> +	struct nvme_fc_fcp_op *op =3D blk_mq_rq_to_pdu(req);
> +	struct nvme_ctrl *ctrl =3D data;
> +
> +	/*
> +	 * A single cmpxchg decides who completes this request. If the op is
> +	 * HELD, nvme_fc_fcpio_done() is done with it and we cancel it. If it
> +	 * is still COMPLETE, nvme_fc_fcpio_done() has not decided yet: move
> +	 * it to IDLE so its own cmpxchg to HELD fails and it completes the
> +	 * request itself (nvme_fc_complete_rq() sets IDLE anyway). Doing this
> +	 * as read-then-cmpxchg would let the op become HELD in between and
> +	 * leave it with no one to complete it.
> +	 */
> +	if (atomic_cmpxchg(&op->state, FCPOP_STATE_COMPLETE,
> +			   FCPOP_STATE_IDLE) =3D=3D FCPOP_STATE_HELD)
> +		nvme_cancel_request(req, ctrl);
> +
> +	return true;
> +}
> +
> +static void
> +nvme_fc_cancel_held_requests(struct nvme_ctrl *ctrl, struct blk_mq_tag_s=
et *set)
> +{
> +	if (!set)
> +		return;
> +
> +	blk_mq_tagset_busy_iter(set, nvme_fc_cancel_held_request, ctrl);
> +	blk_mq_tagset_wait_completed_request(set);
> +}

[Severity: High]
Does nvme_fc_cancel_held_requests() return without waiting when it wins
the cmpxchg against an in-progress nvme_fc_fcpio_done()?

When nvme_fc_fcpio_done() exchanges op->state to FCPOP_STATE_COMPLETE
before __nvme_fc_abort_op() runs, ctrl->iocnt is not incremented for that
op.  If nvme_fc_cancel_held_request() then runs before nvme_fc_fcpio_done()
reaches the hold cmpxchg, it moves op->state from FCPOP_STATE_COMPLETE to
FCPOP_STATE_IDLE without calling nvme_cancel_request().  Because
blk_mq_tagset_wait_completed_request() only waits for requests in
MQ_RQ_COMPLETE state, and rq is still MQ_RQ_IN_FLIGHT until
nvme_fc_fcpio_done() calls nvme_try_complete_req(), the flush and fence
can finish while nvme_fc_fcpio_done() is still executing:

CPU0                                  CPU1
nvme_fc_fcpio_done()
  atomic_xchg(&op->state, COMPLETE)
  dev_info(...)
                                      nvme_fc_fencing_work()
                                        __nvme_fc_teardown_association()
                                        nvme_fence_ctrl()
                                        nvme_fc_flush_held_requests()
                                          nvme_fc_cancel_held_request()
                                            cmpxchg(COMPLETE -> IDLE)
                                          blk_mq_tagset_wait_completed_requ=
est()
                                        ...
                                        /* reconnects to NVME_CTRL_LIVE */
  nvme_fc_start_ioerr_recovery()
    /* enters NVME_CTRL_FENCING */
  cmpxchg(COMPLETE -> HELD) /* fails */
  nvme_try_complete_req(rq, ...)  <-- completes rq during FENCING

A late nvme_fc_fcpio_done() from the old association can then trigger
nvme_fc_start_ioerr_recovery() on the new association and complete rq
immediately while in NVME_CTRL_FENCING because op->state is already
FCPOP_STATE_IDLE.

In addition, for AEN ops in nvme_fc_fcpio_done(), calling
__nvme_fc_fcpop_count_one_down() before resetting op->state and op->flags
lets __nvme_fc_teardown_association() proceed to nvme_fc_term_aen_ops() ->
__nvme_fc_exit_request() (which unmaps DMA and sets FCPOP_STATE_UNINIT)
while nvme_fc_fcpio_done() is still accessing the AEN op and subsequently
overwrites op->state back to FCPOP_STATE_IDLE.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114030454.2836=
543-1-mkhalfella@purestorage.com?part=3D15

