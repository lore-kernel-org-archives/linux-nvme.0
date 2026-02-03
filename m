Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A97E83056
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Feb 2026 05:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/Od9GF/9akB/DkstLrIkJ9LIZHoUCl5hJPDP0Ui7mXM=; b=snzpyaF28CFxwyLIBOmzfXD4vq
	djQbQ5W4qVAZ5wabus7QEu7OKrCEezd9KWKl2qHkjMuR/kfD3SzcQxQYV0pqp4PIKldR/hbF6WiBR
	2qo9KQ1c3oPgOnwdptfcgjjsR4o/cEXRoHqcoLjnMe4JlWM21hacXy/0eOfo9tP9TlaXgIk3y6yQK
	i2+Y9v90MNMbnBxTEwB3daVOLWCiVUS+2FRq5lLgXDlehYTwG4S9j8GcD0XuyQ6vc8sv+v5YN1K6b
	5LAVVkq92YyLqHFT5Rmjyz8WTPE/gz/r96BPsqEkmf8xpyTjJS0L0UvlzskoFVlcr+MF3My2+3siy
	WaFXIV8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vn99X-000000067XI-2yI1;
	Tue, 03 Feb 2026 05:40:43 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vn99S-000000067Wc-16zt
	for linux-nvme@lists.infradead.org;
	Tue, 03 Feb 2026 05:40:42 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7A89E5BCC6;
	Tue,  3 Feb 2026 05:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770097236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Od9GF/9akB/DkstLrIkJ9LIZHoUCl5hJPDP0Ui7mXM=;
	b=Oh+MrD+R/gu3zfvPaqB30biRWMs9khgYNagd8fp9FrsYq1G+Z5617ROHQGN52bqNZZQlar
	TWqTMrKU4hl6yXgTmZVk5P9Jsb9pUIlfQcFiuC57PoaWHF+VO4LO1lhm4xUKmyNPsu+vcf
	3bKXoda3C+ou+bhZIfvR0YT/J21QtZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770097236;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Od9GF/9akB/DkstLrIkJ9LIZHoUCl5hJPDP0Ui7mXM=;
	b=syevM63glm/gLro/XE2PSUN3OllzE4iy4tZzx1aAFudavxb2NOYBshcAg4CGtRrUZ+5zWf
	lC3Xe7df99seQrAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770097236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Od9GF/9akB/DkstLrIkJ9LIZHoUCl5hJPDP0Ui7mXM=;
	b=Oh+MrD+R/gu3zfvPaqB30biRWMs9khgYNagd8fp9FrsYq1G+Z5617ROHQGN52bqNZZQlar
	TWqTMrKU4hl6yXgTmZVk5P9Jsb9pUIlfQcFiuC57PoaWHF+VO4LO1lhm4xUKmyNPsu+vcf
	3bKXoda3C+ou+bhZIfvR0YT/J21QtZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770097236;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Od9GF/9akB/DkstLrIkJ9LIZHoUCl5hJPDP0Ui7mXM=;
	b=syevM63glm/gLro/XE2PSUN3OllzE4iy4tZzx1aAFudavxb2NOYBshcAg4CGtRrUZ+5zWf
	lC3Xe7df99seQrAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 487523EA62;
	Tue,  3 Feb 2026 05:40:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tEprNU6KgWlDVAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 03 Feb 2026 05:40:30 +0000
Message-ID: <692717f0-d0c7-4674-8e65-f8bae8dad4fd@suse.de>
Date: Tue, 3 Feb 2026 06:40:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/14] nvme-fc: Decouple error recovery from controller
 reset
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Cc: Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-13-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260130223531.2478849-13-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[purestorage.com,broadcom.com,gmail.com,nvidia.com,lst.de,kernel.dk,kernel.org,grimberg.me];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[purestorage.com:email,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260202_214038_533406_2E1190D2 
X-CRM114-Status: GOOD (  30.54  )
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

On 1/30/26 23:34, Mohamed Khalfella wrote:
> nvme_fc_error_recovery() called from nvme_fc_timeout() while controller
> in CONNECTING state results in deadlock reported in link below. Update
> nvme_fc_timeout() to schedule error recovery to avoid the deadlock.
> 
> Previous to this change if controller was LIVE error recovery resets
> the controller and this does not match nvme-tcp and nvme-rdma. Decouple
> error recovery from controller reset to match other fabric transports.
> 
> Link: https://lore.kernel.org/all/20250529214928.2112990-1-mkhalfella@purestorage.com/
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   drivers/nvme/host/fc.c | 94 ++++++++++++++++++------------------------
>   1 file changed, 41 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 6948de3f438a..f8f6071b78ed 100644
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
> @@ -985,7 +987,7 @@ fc_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
>   static void nvme_fc_ctrl_put(struct nvme_fc_ctrl *);
>   static int nvme_fc_ctrl_get(struct nvme_fc_ctrl *);
>   
> -static void nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg);
> +static void nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl);
>   
>   static void
>   __nvme_fc_finish_ls_req(struct nvmefc_ls_req_op *lsop)
> @@ -1567,9 +1569,8 @@ nvme_fc_ls_disconnect_assoc(struct nvmefc_ls_rcv_op *lsop)
>   	 * for the association have been ABTS'd by
>   	 * nvme_fc_delete_association().
>   	 */
> -
> -	/* fail the association */
> -	nvme_fc_error_recovery(ctrl, "Disconnect Association LS received");
> +	nvme_fc_start_ioerr_recovery(ctrl,
> +				     "Disconnect Association LS received");
>   
>   	/* release the reference taken by nvme_fc_match_disconn_ls() */
>   	nvme_fc_ctrl_put(ctrl);
> @@ -1871,7 +1872,7 @@ nvme_fc_ctrl_ioerr_work(struct work_struct *work)
>   	struct nvme_fc_ctrl *ctrl =
>   			container_of(work, struct nvme_fc_ctrl, ioerr_work);
>   
> -	nvme_fc_error_recovery(ctrl, "transport detected io error");
> +	nvme_fc_error_recovery(ctrl);
>   }
>   
>   /*
> @@ -1892,6 +1893,17 @@ char *nvme_fc_io_getuuid(struct nvmefc_fcp_req *req)
>   }
>   EXPORT_SYMBOL_GPL(nvme_fc_io_getuuid);
>   
> +static void nvme_fc_start_ioerr_recovery(struct nvme_fc_ctrl *ctrl,
> +					 char *errmsg)
> +{
> +	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
> +		return;
> +
> +	dev_warn(ctrl->ctrl.device, "NVME-FC{%d}: starting error recovery %s\n",
> +		 ctrl->cnum, errmsg);
> +	queue_work(nvme_reset_wq, &ctrl->ioerr_work);
> +}
> +
>   static void
>   nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
>   {
> @@ -2049,9 +2061,8 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
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
> @@ -2495,39 +2506,6 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
>   		nvme_unquiesce_admin_queue(&ctrl->ctrl);
>   }
>   
> -static void
> -nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
> -{
> -	enum nvme_ctrl_state state = nvme_ctrl_state(&ctrl->ctrl);
> -
> -	/*
> -	 * if an error (io timeout, etc) while (re)connecting, the remote
> -	 * port requested terminating of the association (disconnect_ls)
> -	 * or an error (timeout or abort) occurred on an io while creating
> -	 * the controller.  Abort any ios on the association and let the
> -	 * create_association error path resolve things.
> -	 */
> -	if (state == NVME_CTRL_CONNECTING) {
> -		__nvme_fc_abort_outstanding_ios(ctrl, true);
> -		dev_warn(ctrl->ctrl.device,
> -			"NVME-FC{%d}: transport error during (re)connect\n",
> -			ctrl->cnum);
> -		return;
> -	}
> -
> -	/* Otherwise, only proceed if in LIVE state - e.g. on first error */
> -	if (state != NVME_CTRL_LIVE)
> -		return;
> -
> -	dev_warn(ctrl->ctrl.device,
> -		"NVME-FC{%d}: transport association event: %s\n",
> -		ctrl->cnum, errmsg);
> -	dev_warn(ctrl->ctrl.device,
> -		"NVME-FC{%d}: resetting controller\n", ctrl->cnum);
> -
> -	nvme_reset_ctrl(&ctrl->ctrl);
> -}
> -
>   static enum blk_eh_timer_return nvme_fc_timeout(struct request *rq)
>   {
>   	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(rq);
> @@ -2536,24 +2514,14 @@ static enum blk_eh_timer_return nvme_fc_timeout(struct request *rq)
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
> @@ -3352,6 +3320,26 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
>   	}
>   }
>   
> +static void
> +nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl)
> +{
> +	nvme_stop_keep_alive(&ctrl->ctrl);
> +	nvme_stop_ctrl(&ctrl->ctrl);
> +
> +	/* will block while waiting for io to terminate */
> +	nvme_fc_delete_association(ctrl);
> +
> +	/* Do not reconnect if controller is being deleted */
> +	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
> +		return;
> +
> +	if (ctrl->rport->remoteport.port_state == FC_OBJSTATE_ONLINE) {
> +		queue_delayed_work(nvme_wq, &ctrl->connect_work, 0);
> +		return;
> +	}
> +
> +	nvme_fc_reconnect_or_delete(ctrl, -ENOTCONN);
> +}
>   
>   static const struct nvme_ctrl_ops nvme_fc_ctrl_ops = {
>   	.name			= "fc",

I really don't get it. Why do you need to do additional steps here, when
all you do is split an existing function in half?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

