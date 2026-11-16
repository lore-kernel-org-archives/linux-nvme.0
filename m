Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C5E606A323
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 07:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=v+weSmVs;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=MuCaAjjE;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=My3+7xc5;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=MuCaAjjE;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=My3+7xc5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=9trGDlFSjAnxpS1nKPV+qvur6TIn0NviliJ2D2qrvqk=; b=v+weSmVsHeM7nw
	kI15Fpt1wZ1HzRqojjJ5uiOEwZirmLUvzQrmFumBKWQqwMk7Eco/jZXth93r+BK4sCg86eMje2rCt
	ykNyW40OMzYdG5XV6o3sln29w900Omjmbc1YVaFnG6goNJT9dT/TOWjAY7tKu1dt1y0I2rqEfslRH
	CTFdQmY5o+FOPdyNMtkwq4Era0sPOthHJ1nClwz7170fmJeQPzoGulaokHPHc+bYnHPhfTEl62EuG
	0rSdcnX3Zoley82zgOLVYpsehjgLSMcP4DU10O9EVWlps/9UTMido8jYRNeO2L0AVX1aypZB38Gxy
	/hTUYKeqoQgArxc1SRkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSrW7-00000001TIQ-2l3v;
	Mon, 16 Nov 2026 07:52:43 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSrW4-00000001THo-3Vl8
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 07:52:42 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 569D622241;
	Mon, 16 Nov 2026 07:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794815558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9trGDlFSjAnxpS1nKPV+qvur6TIn0NviliJ2D2qrvqk=;
	b=MuCaAjjEphYK1RB7WLouBF5C87M3cWQ7QYy8wlvP+7rPaaPCQtv096smuCRPUdxX9WPV5D
	YofdRlv6e0XaggtL+BsNdvBwa24ZfQceLmR04myEe8NA0IPsIFt4oY2X1Z5pfyNRHRWNAH
	oRD+WOtWYb8OrQp3hnpWc0t4MsbqrsM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794815558;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9trGDlFSjAnxpS1nKPV+qvur6TIn0NviliJ2D2qrvqk=;
	b=My3+7xc5XxSYd4kFoRcFUqgEt+4Sjw4DOvluVPMSfr4M0Rc+6rhFSC/A8hhGy7fGW19Lub
	CX+NU+nv31jDU/Cw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MuCaAjjE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=My3+7xc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794815558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9trGDlFSjAnxpS1nKPV+qvur6TIn0NviliJ2D2qrvqk=;
	b=MuCaAjjEphYK1RB7WLouBF5C87M3cWQ7QYy8wlvP+7rPaaPCQtv096smuCRPUdxX9WPV5D
	YofdRlv6e0XaggtL+BsNdvBwa24ZfQceLmR04myEe8NA0IPsIFt4oY2X1Z5pfyNRHRWNAH
	oRD+WOtWYb8OrQp3hnpWc0t4MsbqrsM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794815558;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9trGDlFSjAnxpS1nKPV+qvur6TIn0NviliJ2D2qrvqk=;
	b=My3+7xc5XxSYd4kFoRcFUqgEt+4Sjw4DOvluVPMSfr4M0Rc+6rhFSC/A8hhGy7fGW19Lub
	CX+NU+nv31jDU/Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD1AB13408;
	Mon, 16 Nov 2026 07:52:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DMtyIEW2+mq7QQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 16 Nov 2026 07:52:37 +0000
Message-ID: <508eed68-2633-45dd-b503-65c62b5fe16c@suse.de>
Date: Mon, 16 Nov 2026 08:52:37 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 15/17] nvme-fc: Hold inflight requests while in FENCING
 state
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
 <20261114030454.2836543-16-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261114030454.2836543-16-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.50 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[15];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,gmail.com,kernel.org,nvidia.com,purestorage.com,suse.de,lists.infradead.org,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -13.50
X-Spam-Level: 
X-Rspamd-Queue-Id: 569D622241
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261115_235241_709785_8D6B3454 
X-CRM114-Status: GOOD (  50.70  )
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
> When a controller enters FENCING, its inflight requests must not be
> completed until CCR or CQT guarantees that the target can no longer
> execute them. Completing them earlier lets multipath resubmit them on
> another path while the original command may still run on this one.
> 
> nvme-fc currently cannot hold requests across the fence.
> nvme_fc_fencing_work() tears the association down first, so the LLDD
> can finish unregistering the remoteport/localport, and
> nvme_fc_delete_association() completes all requests as part of the
> teardown. nvme_fc_fcpio_done() also completes requests that finish with
> an error, which happens to every request aborted by the teardown.
> 
> Split nvme_fc_delete_association() in two:
> 
>   - __nvme_fc_teardown_association() aborts outstanding ios, waits for
>     the aborts to drain, sends Disconnect, deletes the hw queues and
>     marks the controller inactive on the rport. It completes no
>     requests.
> 
>   - nvme_fc_flush_held_requests() completes the held requests and
>     unquiesces the queues.
> 
> nvme_fc_delete_association() calls both, as before.
> nvme_fc_fencing_work() calls the teardown up front and the flush only
> after nvme_fence_ctrl() returns, before moving to FENCED. The queues
> stay quiesced in between, so nothing new reaches the dead association.
> 
> In nvme_fc_fcpio_done(), start recovery first and hold the request
> only if the controller is FENCING afterwards, since a held request is
> completed only by the flush that fencing_work runs. If the claim fails
> because a reset, a delete, or a connect in progress owns the controller,
> the request is completed at once and that owner finishes the teardown.
> A held request cannot be completed behind the fence's back because
> nvme_fc_timeout() returns BLK_EH_RESET_TIMER while FENCING, and
> nvme_fc_start_ioerr_recovery() does nothing in FENCING.
> 
> Track held requests explicitly in op->state with a new
> FCPOP_STATE_HELD, and have the flush complete only those. An op enters
> HELD only through cmpxchg(COMPLETE -> HELD) in nvme_fc_fcpio_done().
> For each busy request, the flush does cmpxchg(COMPLETE -> IDLE) and
> cancels the request only if it saw HELD. This settles the race with an
> nvme_fc_fcpio_done() that has already moved its op to COMPLETE but has
> not yet decided whether to hold it. Teardown does not wait for such an
> op, since it was no longer ACTIVE when the aborts were issued:
> 
>   - nvme_fc_fcpio_done() wins: the op is HELD and the flush cancels it.
>   - The flush wins: the op is IDLE, the hold cmpxchg fails and
>     nvme_fc_fcpio_done() completes the request itself.
> 
> The flush must use a single cmpxchg. Reading the state and then acting
> on it would let the op become HELD in between and leave the request
> with nothing to complete it.
> 
> Both cases rely on the flush being the only thing that can move an op
> out of COMPLETE behind nvme_fc_fcpio_done(), so make
> __nvme_fc_abort_op() use cmpxchg(ACTIVE -> ABORTED). It used
> xchg(ABORTED) and then restored the old value if the op was not ACTIVE,
> so for a moment such an op read as ABORTED. A hold cmpxchg that ran in
> that moment would fail and complete the request in the middle of the
> fence.
> 
> Count an aborted op down only after nvme_fc_fcpio_done() has completed
> or held its request, so that teardown, once it stops waiting, knows
> every aborted request has been decided. The count-down now runs outside
> ctrl->lock, so make ctrl->iocnt an atomic_t and wait for it with
> wait_event().
> 
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   drivers/nvme/host/fc.c | 171 +++++++++++++++++++++++++++++++++--------
>   1 file changed, 139 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 095adc9011cc..5e8977ad51cf 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -83,6 +83,7 @@ enum nvme_fcpop_state {
>   	FCPOP_STATE_ACTIVE	= 2,
>   	FCPOP_STATE_ABORTED	= 3,
>   	FCPOP_STATE_COMPLETE	= 4,
> +	FCPOP_STATE_HELD	= 5,
>   };
>   
>   struct nvme_fc_fcp_op {
> @@ -172,7 +173,7 @@ struct nvme_fc_ctrl {
>   
>   	struct kref		ref;
>   	unsigned long		flags;
> -	u32			iocnt;
> +	atomic_t		iocnt;
>   	wait_queue_head_t	ioabort_wait;
>   
>   	struct nvme_fc_fcp_op	aen_ops[NVME_NR_AEN_COMMANDS];
> @@ -990,6 +991,8 @@ fc_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
>   static void nvme_fc_ctrl_put(struct nvme_fc_ctrl *);
>   static int nvme_fc_ctrl_get(struct nvme_fc_ctrl *);
>   
> +static void __nvme_fc_teardown_association(struct nvme_fc_ctrl *ctrl);
> +static void nvme_fc_flush_held_requests(struct nvme_fc_ctrl *ctrl);
>   static void nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl);
>   static void nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status);
>   
> @@ -1828,12 +1831,11 @@ __nvme_fc_abort_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_fcp_op *op)
>   	 * path, must not still be in progress in the LLDD then.
>   	 */
>   	spin_lock_irqsave(&ctrl->lock, flags);
> -	opstate = atomic_xchg(&op->state, FCPOP_STATE_ABORTED);
> -	if (opstate != FCPOP_STATE_ACTIVE) {
> -		atomic_set(&op->state, opstate);
> -	} else {
> +	opstate = atomic_cmpxchg(&op->state, FCPOP_STATE_ACTIVE,
> +				 FCPOP_STATE_ABORTED);
> +	if (opstate == FCPOP_STATE_ACTIVE) {
>   		op->flags |= FCOP_FLAGS_TERMIO;
> -		ctrl->iocnt++;
> +		atomic_inc(&ctrl->iocnt);
>   	}
>   	spin_unlock_irqrestore(&ctrl->lock, flags);
>   

Nit: You could've moved the change from atomic_xchg() to 
atomic_cmpxchg() to patch 12, to keep this change cleaner.

> @@ -1863,19 +1865,27 @@ nvme_fc_abort_aen_ops(struct nvme_fc_ctrl *ctrl)
>   }
>   
>   static inline void
> +__nvme_fc_fcpop_count_one_down(struct nvme_fc_ctrl *ctrl)
> +{
> +	if (atomic_dec_return(&ctrl->iocnt) == 0)
> +		wake_up(&ctrl->ioabort_wait);
> +}
> +
> +static inline bool
>   __nvme_fc_fcpop_chk_teardowns(struct nvme_fc_ctrl *ctrl,
>   		struct nvme_fc_fcp_op *op, int opstate)
>   {
>   	unsigned long flags;
> +	bool ret = false;
>   
>   	if (opstate == FCPOP_STATE_ABORTED) {
>   		spin_lock_irqsave(&ctrl->lock, flags);
> -		if (op->flags & FCOP_FLAGS_TERMIO) {
> -			if (!--ctrl->iocnt)
> -				wake_up(&ctrl->ioabort_wait);
> -		}
> +		if (op->flags & FCOP_FLAGS_TERMIO)
> +			ret = true;
>   		spin_unlock_irqrestore(&ctrl->lock, flags);
>   	}
> +
> +	return ret;
>   }
>   
>   static void nvme_fc_fencing_work(struct work_struct *work)
> @@ -1894,12 +1904,14 @@ static void nvme_fc_fencing_work(struct work_struct *work)
>   	 */
>   	nvme_stop_keep_alive(ctrl);
>   	cancel_work_sync(&ctrl->async_event_work);
> -	nvme_fc_delete_association(fc_ctrl);
> +	if (test_and_clear_bit(ASSOC_ACTIVE, &fc_ctrl->flags))
> +		__nvme_fc_teardown_association(fc_ctrl);
>   
>   	rem = nvme_fence_ctrl(ctrl);
>   	if (rem)
>   		dev_info(ctrl->device, "CCR failed, starting error recovery\n");
>   
> +	nvme_fc_flush_held_requests(fc_ctrl);
>   	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
>   	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
>   		queue_work(nvme_reset_wq, &fc_ctrl->ioerr_work);
> @@ -1982,7 +1994,7 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
>   	struct nvme_command *sqe = &op->cmd_iu.sqe;
>   	__le16 status = cpu_to_le16(NVME_SC_SUCCESS << 1);
>   	union nvme_result result;
> -	bool terminate_assoc = true;
> +	bool op_term, hold = false, terminate_assoc = true;
>   	int opstate;
>   
>   	/*
> @@ -2113,22 +2125,58 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
>   	terminate_assoc = false;
>   
>   done:
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
> +		hold = nvme_ctrl_state(&ctrl->ctrl) == NVME_CTRL_FENCING;
> +	}
> +
>   	if (op->flags & FCOP_FLAGS_AEN) {
>   		nvme_complete_async_event(&queue->ctrl->ctrl, status, &result);
> -		__nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate);
> +		if (__nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate))
> +			__nvme_fc_fcpop_count_one_down(ctrl);
>   		atomic_set(&op->state, FCPOP_STATE_IDLE);
>   		op->flags = FCOP_FLAGS_AEN;	/* clear other flags */
>   		nvme_fc_ctrl_put(ctrl);
> -		goto check_error;
> +		return;
>   	}
>   
> -	__nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate);
> +	/*
> +	 * We can not access op after the request is completed because it can
> +	 * be reused immediately. At the same time we want to wakeup the thread
> +	 * waiting for ongoing IOs _after_ requests are completed. This is
> +	 * necessary because that thread will start canceling inflight IOs
> +	 * and we want to avoid request completion racing with cancellation.
> +	 */
> +	op_term = __nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate);
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
> +				   FCPOP_STATE_HELD) == FCPOP_STATE_COMPLETE)
> +		goto check_op_term;
> +
>   	if (!nvme_try_complete_req(rq, status, result))
>   		nvme_fc_complete_rq(rq);
>   
> -check_error:
> -	if (terminate_assoc)
> -		nvme_fc_start_ioerr_recovery(ctrl, "io error");
> +check_op_term:
> +	if (op_term)
> +		__nvme_fc_fcpop_count_one_down(ctrl);
>   }
>   
>   static int
> @@ -2803,7 +2851,8 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
>   		 * cmd with the csn was supposed to arrive.
>   		 */
>   		opstate = atomic_xchg(&op->state, FCPOP_STATE_COMPLETE);
> -		__nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate);
> +		if (__nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate))
> +			__nvme_fc_fcpop_count_one_down(ctrl);
>   
>   		if (!(op->flags & FCOP_FLAGS_AEN)) {
>   			nvme_fc_unmap_data(ctrl, op->rq, op);
> @@ -3261,22 +3310,22 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
>   	return ret;
>   }
>   
> -
>   /*
> - * This routine stops operation of the controller on the host side.
> - * On the host os stack side: Admin and IO queues are stopped,
> - *   outstanding ios on them terminated via FC ABTS.
> - * On the link side: the association is terminated.
> + * This routine tears down the association on the link side and releases
> + * all LLDD resources: outstanding ios are terminated via FC ABTS, hw
> + * queues are deleted and the controller is marked inactive on the
> + * rport. Requests that nvme_fc_fcpio_done() decided to hold are NOT
> + * completed here, the caller must follow up with
> + * nvme_fc_flush_held_requests() once it is safe to release them.
> + *
> + * The caller must own the ASSOC_ACTIVE bit (test_and_clear_bit()).
>    */
>   static void
> -nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
> +__nvme_fc_teardown_association(struct nvme_fc_ctrl *ctrl)
>   {
>   	struct nvmefc_ls_rcv_op *disls = NULL;
>   	unsigned long flags;
>   
> -	if (!test_and_clear_bit(ASSOC_ACTIVE, &ctrl->flags))
> -		return;
> -
>   	spin_lock_irqsave(&ctrl->lock, flags);
>   	set_bit(FCCTRL_TERMIO, &ctrl->flags);
>   	spin_unlock_irqrestore(&ctrl->lock, flags);
> @@ -3287,8 +3336,8 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
>   	nvme_fc_abort_aen_ops(ctrl);
>   
>   	/* wait for all io that had to be aborted */
> +	wait_event(ctrl->ioabort_wait, atomic_read(&ctrl->iocnt) == 0);
>   	spin_lock_irq(&ctrl->lock);
> -	wait_event_lock_irq(ctrl->ioabort_wait, ctrl->iocnt == 0, ctrl->lock);
>   	clear_bit(FCCTRL_TERMIO, &ctrl->flags);
>   	spin_unlock_irq(&ctrl->lock);
>   

But this makes the spin_lock() here a bit pointless, protecting as it is
only a single 'flags' value.

> @@ -3323,13 +3372,71 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
>   	__nvme_fc_delete_hw_queue(ctrl, &ctrl->queues[0], 0);
>   	nvme_fc_free_queue(&ctrl->queues[0]);
>   
> +	nvme_fc_ctlr_inactive_on_rport(ctrl);
> +}
> +
> +static bool
> +nvme_fc_cancel_held_request(struct request *req, void *data)
> +{
> +	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(req);
> +	struct nvme_ctrl *ctrl = data;
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
> +			   FCPOP_STATE_IDLE) == FCPOP_STATE_HELD)
> +		nvme_cancel_request(req, ctrl);

That is _soo_ odd. So you're doing a compare-exchange, but decode to act 
on it only if the compare-exchange fails for one specific reason.
What happens if 'op-state' has any other value?
Is it still okay to move on?

> +
> +	return true;
> +}
> +
> +static void
> +nvme_fc_cancel_held_requests(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set)
> +{
> +	if (!set)
> +		return;
> +
> +	blk_mq_tagset_busy_iter(set, nvme_fc_cancel_held_request, ctrl);
> +	blk_mq_tagset_wait_completed_request(set);
> +}
> +
> +/* Complete the requests nvme_fc_fcpio_done() held during the fence */
> +static void
> +nvme_fc_flush_held_requests(struct nvme_fc_ctrl *fc_ctrl)
> +{
> +	struct nvme_ctrl *ctrl = &fc_ctrl->ctrl;
> +
> +	nvme_fc_cancel_held_requests(ctrl, ctrl->tagset);
> +	nvme_fc_cancel_held_requests(ctrl, ctrl->admin_tagset);
> +
>   	/* re-enable the admin_q so anything new can fast fail */
> -	nvme_unquiesce_admin_queue(&ctrl->ctrl);
> +	nvme_unquiesce_admin_queue(ctrl);
>   
>   	/* resume the io queues so that things will fast fail */
> -	nvme_unquiesce_io_queues(&ctrl->ctrl);
> +	nvme_unquiesce_io_queues(ctrl);
> +}
>   
> -	nvme_fc_ctlr_inactive_on_rport(ctrl);
> +/*
> + * This routine stops operation of the controller on the host side.
> + * On the host os stack side: Admin and IO queues are stopped,
> + *   outstanding ios on them terminated via FC ABTS.
> + * On the link side: the association is terminated.
> + */
> +static void
> +nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
> +{
> +	if (!test_and_clear_bit(ASSOC_ACTIVE, &ctrl->flags))
> +		return;
> +
> +	__nvme_fc_teardown_association(ctrl);
> +	nvme_fc_flush_held_requests(ctrl);
>   }
>   
>   static void

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

