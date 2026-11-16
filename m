Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D20C606A32A
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 07:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jb14SwBM;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=OowYAJ57;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=hbiOBLB8;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=OowYAJ57;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=hbiOBLB8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=u1ukYDs6G6VuUfmsZP+zRpytgH58T0ALVC3YGhPO8j0=; b=jb14SwBMO3DeMQ
	i19bkc82tYmNzJ+1+po/yYjWsJWLq1GvBwlqlOndfY/F8ZJghoE28Xn1/abzWnAVj7pAdGlUjQhfO
	45JsdwSc4A71DIz5mQTE/9Q9BiBA2Q08weOCTcfI+3gRflyr26fSRKIieI9ygLg7Tzm45RJ4enCwU
	C+X5L2oiYc5sy+cbeb75ECqb4K0f1BQrn+pTpqfIoxbqLk7VtNCSyqpX+j5ilxTrqHQUt72ddpFvJ
	o3dfxjlm1tYhsyXi4nA4vfQNRXGcpJ1dPEfOwFe39cKjrfr4jcgvVIVafJttAp4R8amEhD3otl4Fe
	wqL05pp6M13Svyh67KOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSrBX-00000001PU7-0Gto;
	Mon, 16 Nov 2026 07:31:27 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSrBU-00000001PTc-1Vdn
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 07:31:25 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0FD6E1FCF5;
	Mon, 16 Nov 2026 07:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794814282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u1ukYDs6G6VuUfmsZP+zRpytgH58T0ALVC3YGhPO8j0=;
	b=OowYAJ57UmpKF4i8ukUIrqSiCRSh8RVaqfi84391mO+S2pWtHqhHe3OwA7/o2kaU1IwsAO
	xr75z211sfQImJUXCHKbL8ZccMmwWITPgYJpPoFG6rGfyQiEqMm0sNclU1Y7s/dkxh0CQT
	W8g42UoACNub4PIFfBLlIiijUX58zqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794814282;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u1ukYDs6G6VuUfmsZP+zRpytgH58T0ALVC3YGhPO8j0=;
	b=hbiOBLB8HdD9eCx28C8bTakCpfwnwNI5MvoFR0YEzBb53z0r+2ThpTGQ31JpnstFg3+bVL
	T9Oty+1zj8s7mYAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794814282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u1ukYDs6G6VuUfmsZP+zRpytgH58T0ALVC3YGhPO8j0=;
	b=OowYAJ57UmpKF4i8ukUIrqSiCRSh8RVaqfi84391mO+S2pWtHqhHe3OwA7/o2kaU1IwsAO
	xr75z211sfQImJUXCHKbL8ZccMmwWITPgYJpPoFG6rGfyQiEqMm0sNclU1Y7s/dkxh0CQT
	W8g42UoACNub4PIFfBLlIiijUX58zqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794814282;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u1ukYDs6G6VuUfmsZP+zRpytgH58T0ALVC3YGhPO8j0=;
	b=hbiOBLB8HdD9eCx28C8bTakCpfwnwNI5MvoFR0YEzBb53z0r+2ThpTGQ31JpnstFg3+bVL
	T9Oty+1zj8s7mYAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 68DA413408;
	Mon, 16 Nov 2026 07:31:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id J98sD0mx+mrDKwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 16 Nov 2026 07:31:21 +0000
Message-ID: <fbaf5c21-51c4-4935-b001-989ba79091b3@suse.de>
Date: Mon, 16 Nov 2026 08:31:20 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/17] nvme-fc: start error recovery instead of
 aborting timed out IOs
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@kernel.org>,
 Chaitanya Kulkarni <kch@nvidia.com>, James Smart <jsmart833426@gmail.com>,
 Randy Jennings <randyj@purestorage.com>, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261114030454.2836543-1-mkhalfella@purestorage.com>
 <20261114030454.2836543-13-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261114030454.2836543-13-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,gmail.com,kernel.org,nvidia.com,purestorage.com,suse.de,lists.infradead.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,purestorage.com:email]
X-Spam-Score: -13.29
X-Spam-Level: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261115_233124_595606_8A81DE1C 
X-CRM114-Status: GOOD (  42.68  )
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/14/26 4:04 AM, Mohamed Khalfella wrote:
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
> Link: https://lore.kernel.org/all/20250529214928.2112990-1-mkhalfella@purestorage.com/
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   drivers/nvme/host/fc.c | 66 ++++++++++++++++++++++++++++++------------
>   1 file changed, 47 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 0b9ff50d26ff..c4603be38144 100644
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
> @@ -1569,7 +1571,8 @@ nvme_fc_ls_disconnect_assoc(struct nvmefc_ls_rcv_op *lsop)
>   	 */
>   
>   	/* fail the association */
> -	nvme_fc_error_recovery(ctrl, "Disconnect Association LS received");
> +	nvme_fc_start_ioerr_recovery(ctrl,
> +				     "Disconnect Association LS received");
>   
>   	/* release the reference taken by nvme_fc_match_disconn_ls() */
>   	nvme_fc_ctrl_put(ctrl);
> @@ -1813,11 +1816,18 @@ __nvme_fc_abort_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_fcp_op *op)
>   	unsigned long flags;
>   	int opstate;
>   
> +	/*
> +	 * Every abort is counted, not only those issued by the association
> +	 * teardown: the teardown waits for iocnt to drop to zero before it
> +	 * deletes the hw queues, and an abort issued earlier, by
> +	 * nvme_fc_timeout() while deleting or by the CONNECTING recovery
> +	 * path, must not still be in progress in the LLDD then.
> +	 */
>   	spin_lock_irqsave(&ctrl->lock, flags);
>   	opstate = atomic_xchg(&op->state, FCPOP_STATE_ABORTED);
> -	if (opstate != FCPOP_STATE_ACTIVE)
> +	if (opstate != FCPOP_STATE_ACTIVE) {
>   		atomic_set(&op->state, opstate);
> -	else if (test_bit(FCCTRL_TERMIO, &ctrl->flags)) {
> +	} else {
>   		op->flags |= FCOP_FLAGS_TERMIO;
>   		ctrl->iocnt++;
>   	}
> @@ -1856,8 +1866,7 @@ __nvme_fc_fcpop_chk_teardowns(struct nvme_fc_ctrl *ctrl,
>   
>   	if (opstate == FCPOP_STATE_ABORTED) {
>   		spin_lock_irqsave(&ctrl->lock, flags);
> -		if (test_bit(FCCTRL_TERMIO, &ctrl->flags) &&
> -		    op->flags & FCOP_FLAGS_TERMIO) {
> +		if (op->flags & FCOP_FLAGS_TERMIO) {
>   			if (!--ctrl->iocnt)
>   				wake_up(&ctrl->ioabort_wait);
>   		}
> @@ -1892,6 +1901,19 @@ char *nvme_fc_io_getuuid(struct nvmefc_fcp_req *req)
>   }
>   EXPORT_SYMBOL_GPL(nvme_fc_io_getuuid);
>   
> +/*
> + * Start recovery only if this caller can claim it with a state change.
> + */
> +static void
> +nvme_fc_start_ioerr_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
> +{
> +	if (nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING)) {
> +		dev_warn(ctrl->ctrl.device, "NVME-FC{%d}: starting error recovery %s\n",
> +			 ctrl->cnum, errmsg);
> +		queue_work(nvme_reset_wq, &ctrl->ioerr_work);
> +	}
> +}
> +
>   static void
>   nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
>   {
> @@ -2049,9 +2071,8 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
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
> @@ -2548,24 +2569,32 @@ static enum blk_eh_timer_return nvme_fc_timeout(struct request *rq)
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
> +
> +	if (nvme_ctrl_state(&ctrl->ctrl) != NVME_CTRL_LIVE) {
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

Nit: With this change __nvme_fc_abort_op() can be made a void function
as every caller is ignoring the return value.

>   
>   	/*
> -	 * the io abort has been initiated. Have the reset timer
> -	 * restarted and the abort completion will complete the io
> -	 * shortly. Avoids a synchronous wait while the abort finishes.
> +	 * A LIVE controller starts error recovery, which tears the
> +	 * association down and completes this request.
>   	 */
> +	nvme_fc_start_ioerr_recovery(ctrl, "io timeout");
>   	return BLK_EH_RESET_TIMER;
>   }
>   
> @@ -3217,7 +3246,6 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
>   
>   	spin_lock_irqsave(&ctrl->lock, flags);
>   	set_bit(FCCTRL_TERMIO, &ctrl->flags);
> -	ctrl->iocnt = 0;
>   	spin_unlock_irqrestore(&ctrl->lock, flags);
>   
>   	__nvme_fc_abort_outstanding_ios(ctrl, false);

Otherwise looks good.

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

