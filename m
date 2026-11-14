Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DA1606A323
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 03:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UOTH5eh8;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jI07pCAf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=MWDj++VhiVpBPe+9FQv4N//V9wI3MP9RX6d9HTAVqxo=; b=UOTH5eh8wxs23AUrBur6OBhvGG
	8e2fjR3zv/7Sd8Bjz7SSO8XSYenGgsNrdvb/81NS5GZ17fYY/RNdDXWPfI+lQDUEBjVa1XtqOTeTF
	2hOfbjVDe4V+7X2BO6844ZSNdS3EVtNA7CL8+OnXPWM5Hg0+ai8pm2Y3oIRCBVu68NGnL/RwM4k7P
	ZELkbkS3hYELaAhRd7QWOP1g2pNRpbaeN1vL5UzOUFEjOGAOgDEfH8RZ0bTfCu/eTO6Ra02O8X5ws
	Y+mVxjmZHH2SN0Sfr0ISveDO8RCGNWaobyxzbaY+/EodiQ5YIhl79bmz4rtWR8GwapPeI/dSq3zyT
	D2wRvgzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS4j2-0000000FJJW-3tJA;
	Sat, 14 Nov 2026 03:46:48 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS4j1-0000000FJJ6-2tnk
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 03:46:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B35A56128B;
	Sat, 14 Nov 2026 03:46:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2FC1F000C4;
	Sat, 14 Nov 2026 03:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794628006;
	bh=MWDj++VhiVpBPe+9FQv4N//V9wI3MP9RX6d9HTAVqxo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jI07pCAfFR3OQsd3sRevfj6iKzx14eaWmRVbjsKrQOnz4/eAgF5r8ovWd5qCV/l1L
	 +IQuS+FzIqgD9AWoGrwembMg22CgaPxycNLOgoD0bBuNav6XnVjrLYwAEvv6l+nXSM
	 vTiOX20oe/pTvN9C/2DNsUg1AV43tuzfjVmV1KTYPT9VVkwfpdPVgVuisd/SN00Ww2
	 OaBJEpuWUmyfjqF7JGe35dX2RcMnE/AgKrFznDKWyL5RTocoy5bT5iMzLo3iXW4ygg
	 ddRXorISOJwWq+AAmBlmEKPoiiz++WTSwjQEUFee5+d5E68u/aFUGpYoeBx58SEa75
	 ahvN8jdf/eCCA==
Message-ID: <sashiko-outbox-214127@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 12/17] nvme-fc: start error recovery instead of
 aborting timed out IOs
To: "Mohamed Khalfella" <mkhalfella@purestorage.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261114030454.2836543-13-mkhalfella@purestorage.com>
References: <20261114030454.2836543-1-mkhalfella@purestorage.com>
 <20261114030454.2836543-13-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 03:46:45 +0000
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] nvme-fc: ignored errors in CONNECTING state allow broken
  association to go LIVE
- [Medium] nvme-fc: nvme_fc_timeout() leaves queue live after non-LIVE
  command abort
- [Medium] nvme-fc: missing abort drain before queue deletion in connect
  error paths
- [Low] nvme-fc: missing Fixes trailer for commit 52793d62a696 in commit
  message
--

commit 0a8f4b079afa7a27de6edf488747423c0c7e82ab
Author: Mohamed Khalfella <mkhalfella@purestorage.com>

> nvme-fc: start error recovery instead of aborting timed out IOs
>
> Aborts issued from the timeout handler run outside the FCCTRL_TERMIO
> window, so they are not counted in ctrl->iocnt and
> nvme_fc_delete_association() does not wait for them. The association
> can be torn down while the LLDD is still working on the abort.
>
> Instead of aborting the timed out command, reset the controller like
> the other fabrics transports do. The association teardown aborts the
> outstanding IOs, counts the aborts and waits for them to complete.
>
> Count every abort in ctrl->iocnt, not only the ones issued while
> FCCTRL_TERMIO is set, and do not reset the count when the teardown
> starts. An abort issued before the teardown is then waited for as well.
>
> Only a LIVE controller starts error recovery. In every other state the
> association is being set up, being torn down or already gone, so abort
> the timed out command from the timeout handler instead and return
> BLK_EH_DONE. The command completes through nvme_fc_fcpio_done() once
> the LLDD has finished the abort, and the abort is counted so a teardown
> that follows waits for it. This matters for a controller being deleted.
> The delete path drains the IOs itself and tears the association down in
> nvme_fc_delete_ctrl() once the drain is done, and DELETING cannot move
> to RESETTING, so without the abort a timed out IO would hang the drain
> against a dead target.
>
> The new nvme_fc_start_ioerr_recovery() is the common entry point for IO
> timeouts, transport errors reported by nvme_fc_fcpio_done(), Disconnect
> LS and connectivity loss. It moves the controller to RESETTING and
> queues ioerr_work only if that succeeds, so nothing is ever queued on a
> controller that is CONNECTING or being deleted. A Disconnect LS or a
> transport error received while CONNECTING is resolved when the inflight
> request fails, or times out and is aborted.
>
> ioerr_work still calls nvme_fc_error_recovery(), which returns without
> doing anything for a controller that is not LIVE. With the controller
> already in RESETTING when the work runs, no recovery takes place yet
> and the controller stays in RESETTING. The next patch moves the
> recovery into ioerr_work itself and completes the change.
>
> Link: https://lore.kernel.org/all/20250529214928.2112990-1-mkhalfella@pur=
estorage.com/
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>

[Severity: Low]
Should this bug fix include a Fixes tag for the commit that gated
ctrl->iocnt accounting on the FCCTRL_TERMIO flag:

  Fixes: 52793d62a696 ("nvme-fc: fix io timeout to abort I/O")

> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 0b9ff50d26ff3..c4603be381445 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
[ ... ]
> @@ -1569,7 +1571,8 @@ nvme_fc_ls_disconnect_assoc(struct nvmefc_ls_rcv_op=
 *lsop)
>  	 */
> =20
>  	/* fail the association */
> -	nvme_fc_error_recovery(ctrl, "Disconnect Association LS received");
> +	nvme_fc_start_ioerr_recovery(ctrl,
> +				     "Disconnect Association LS received");
> =20
>  	/* release the reference taken by nvme_fc_match_disconn_ls() */
>  	nvme_fc_ctrl_put(ctrl);
> @@ -1813,11 +1816,18 @@ __nvme_fc_abort_op(struct nvme_fc_ctrl *ctrl, str=
uct nvme_fc_fcp_op *op)
>  	unsigned long flags;
>  	int opstate;
> =20
> +	/*
> +	 * Every abort is counted, not only those issued by the association
> +	 * teardown: the teardown waits for iocnt to drop to zero before it
> +	 * deletes the hw queues, and an abort issued earlier, by
> +	 * nvme_fc_timeout() while deleting or by the CONNECTING recovery
> +	 * path, must not still be in progress in the LLDD then.
> +	 */
>  	spin_lock_irqsave(&ctrl->lock, flags);
>  	opstate =3D atomic_xchg(&op->state, FCPOP_STATE_ABORTED);
> -	if (opstate !=3D FCPOP_STATE_ACTIVE)
> +	if (opstate !=3D FCPOP_STATE_ACTIVE) {
>  		atomic_set(&op->state, opstate);
> -	else if (test_bit(FCCTRL_TERMIO, &ctrl->flags)) {
> +	} else {
>  		op->flags |=3D FCOP_FLAGS_TERMIO;
>  		ctrl->iocnt++;
>  	}

[Severity: Medium]
Can the connect failure unwind paths in nvme_fc_create_association(),
nvme_fc_create_io_queues(), and nvme_fc_recreate_io_queues() delete
hardware queues while an abort or asynchronous request is still active in
the lower-level driver?

Previously, a transport error or Disconnect Association link service while
connecting ran nvme_fc_error_recovery() ->
__nvme_fc_abort_outstanding_ios(), which quiesced the queues, aborted busy
requests on both tagsets, and waited for completion.  With
nvme_fc_start_ioerr_recovery() becoming a no-op while connecting and
nvme_fc_timeout() incrementing ctrl->iocnt for timed-out commands, an
in-flight keep-alive command (started by nvme_init_ctrl_finish()) or an
abort from nvme_fc_timeout() can still be running when a later connect step
fails.  The error labels in nvme_fc_create_io_queues() and
nvme_fc_create_association() call nvme_fc_delete_hw_io_queues() and
__nvme_fc_delete_hw_queue() and clear the active association flag without
aborting outstanding requests or waiting on ctrl->ioabort_wait for
ctrl->iocnt to reach zero:

drivers/nvme/host/fc.c:nvme_fc_create_association() {
    ...
out_delete_hw_queue:
	__nvme_fc_delete_hw_queue(ctrl, &ctrl->queues[0], 0);
out_free_queue:
	nvme_fc_free_queue(&ctrl->queues[0]);
	clear_bit(ASSOC_ACTIVE, &ctrl->flags);
    ...
}

Because the active association flag is cleared there, even a subsequent
nvme_fc_delete_association() returns immediately without waiting for
ctrl->iocnt to drop to zero.

[ ... ]

> @@ -1892,6 +1901,19 @@ char *nvme_fc_io_getuuid(struct nvmefc_fcp_req *re=
q)
>  }
>  EXPORT_SYMBOL_GPL(nvme_fc_io_getuuid);
> =20
> +/*
> + * Start recovery only if this caller can claim it with a state change.
> + */
> +static void
> +nvme_fc_start_ioerr_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
> +{
> +	if (nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING)) {
> +		dev_warn(ctrl->ctrl.device, "NVME-FC{%d}: starting error recovery %s\n=
",
> +			 ctrl->cnum, errmsg);
> +		queue_work(nvme_reset_wq, &ctrl->ioerr_work);
> +	}
> +}
> +
>  static void
>  nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
>  {
> @@ -2049,9 +2071,8 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
>  		nvme_fc_complete_rq(rq);
> =20
>  check_error:
> -	if (terminate_assoc &&
> -	    nvme_ctrl_state(&ctrl->ctrl) !=3D NVME_CTRL_RESETTING)
> -		queue_work(nvme_reset_wq, &ctrl->ioerr_work);
> +	if (terminate_assoc)
> +		nvme_fc_start_ioerr_recovery(ctrl, "io error");
>  }

[Severity: High]
Can nvme_fc_create_association() transition a broken or disconnected
association to the live state when a timeout, transport error, or
Disconnect Association link service occurs while connecting?

While ctrl->ctrl.state is connecting, nvme_change_ctrl_state() rejects a
transition to resetting, so nvme_fc_start_ioerr_recovery() is a no-op and
neither sets the association failed flag nor calls
__nvme_fc_abort_outstanding_ios() to clear the queue live bit and mark
requests cancelled:

1. When an admin command times out in nvme_fc_timeout() while connecting,
__nvme_fc_abort_op() aborts the command without setting the cancelled
request flag on op->nreq.flags.  nvme_fc_fcpio_done() then completes the
request with positive status NVME_SC_HOST_ABORTED_CMD (0x371) instead of
-EINTR.  If that command is nvme_set_queue_count() in
nvme_fc_create_io_queues(), nvme_set_queue_count() treats positive status
as non-fatal, sets nr_io_queues to 0, and returns 0, allowing
nvme_fc_create_association() to transition the controller to live with zero
I/O queues.

2. Likewise, optional commands in nvme_init_ctrl_finish() (such as
nvme_get_effects_log() or nvme_configure_apst()) and asynchronous
keep-alive commands ignore positive status codes from transport errors or
aborts, and a Disconnect Association request received in
nvme_fc_ls_disconnect_assoc() after ctrl->association_id is set stores
ctrl->rcv_disconn and calls nvme_fc_start_ioerr_recovery() without setting
the association failed flag.  When the remaining setup commands finish,
nvme_fc_create_association() sees no error, moves the controller to live,
and leaves ctrl->rcv_disconn unanswered:

drivers/nvme/host/fc.c:nvme_fc_create_association() {
    ...
	if (!ret && test_bit(ASSOC_FAILED, &ctrl->flags))
		ret =3D -EIO;
	if (ret)
		goto out_term_aen_ops;

	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE)) {
    ...
}

> @@ -2548,24 +2569,32 @@ static enum blk_eh_timer_return nvme_fc_timeout(s=
truct request *rq)
>  	struct nvme_fc_cmd_iu *cmdiu =3D &op->cmd_iu;
>  	struct nvme_command *sqe =3D &cmdiu->sqe;
> =20
> -	/*
> -	 * Attempt to abort the offending command. Command completion
> -	 * will detect the aborted io and will fail the connection.
> -	 */
>  	dev_info(ctrl->ctrl.device,
>  		"NVME-FC{%d.%d}: io timeout: opcode %d fctype %d (%s) w10/11: "
>  		"x%08x/x%08x\n",
>  		ctrl->cnum, qnum, sqe->common.opcode, sqe->fabrics.fctype,
>  		nvme_fabrics_opcode_str(qnum, sqe),
>  		sqe->common.cdw10, sqe->common.cdw11);
> -	if (__nvme_fc_abort_op(ctrl, op))
> -		nvme_fc_error_recovery(ctrl, "io timeout abort failed");
> +
> +	if (nvme_ctrl_state(&ctrl->ctrl) !=3D NVME_CTRL_LIVE) {
> +		/*
> +		 * The association is being set up, being torn down or is
> +		 * already gone, so recovery cannot be started from here.
> +		 * Abort the command so the connect or teardown it would
> +		 * block can make progress. It completes through
> +		 * nvme_fc_fcpio_done() once the LLDD has finished the
> +		 * abort, and the abort is counted so a teardown that
> +		 * follows waits for it.
> +		 */
> +		__nvme_fc_abort_op(ctrl, op);
> +		return BLK_EH_DONE;
> +	}

[Severity: Medium]
Does aborting a timed-out request here without clearing the queue live flag
or marking the request cancelled allow the request to be retried against a
dead target while deleting?

During controller deletion, nvme_do_delete_ctrl() runs
nvme_remove_namespaces() before nvme_fc_delete_ctrl() ->
nvme_fc_delete_association(), so the queue live flag is still set on
op->queue->flags.  When the abort finishes, nvme_fc_fcpio_done() completes
the request with NVME_SC_HOST_ABORTED_CMD (without do-not-retry), so
non-multipath requests (such as del_gendisk() writeback before the queue is
marked dying) or retryable internal commands are retried by
nvme_decide_disposition().  Because op->queue->flags still has the queue
live bit set, nvme_check_ready() returns true in nvme_fc_queue_rq() and
re-dispatches the request to the dead target for up to nvme_max_retries
additional timeouts instead of fast-failing via
nvme_fail_nonready_command().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114030454.2836=
543-1-mkhalfella@purestorage.com?part=3D12

