Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F02E7BDB0
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Feb 2026 12:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gU1m8rwIhAk+8fLwq0aHpEphDQz5TPlMEAqnFKuRWiM=; b=EEI8c/6Nc05lGg8tYf9A1QGiL8
	ytRoXAGlAMZsyfFkO+ByHCADju6fMFtOtqnM9aFW6fdk7LZkvL3D7N2MAglZFHED7Yd5PQutjVtnL
	RFCjc2tSJ9wCIjERDRImN1xi2kplzeC7HERKcm2tYNOWlNZGdLYDz59KdEoRo2p5bp0eE712vJG/p
	pGn524Nr5ecIPFfgg8UxOHJvvQP8MAFFG5BpAzyNX0RSm5pPu5UhHp4sNTQSZzjYL90/CfGx6mJAy
	iDMuZQXwvBx8/cWvwNZ/39w33sEIc2XsXyHdRTnZr3lSyV5aN1RsNREQ4b4YEOu84H6Sxozf4iGnz
	11oYnj1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vry0T-00000006YBg-0Xmr;
	Mon, 16 Feb 2026 12:47:17 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vry0Q-00000006YBM-0mAr
	for linux-nvme@lists.infradead.org;
	Mon, 16 Feb 2026 12:47:15 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1AD013E733;
	Mon, 16 Feb 2026 12:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771246032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gU1m8rwIhAk+8fLwq0aHpEphDQz5TPlMEAqnFKuRWiM=;
	b=GPHXW/UHIRbQlpkg+poZ8SQQ+LqI/Fyt55CwGmxCmJ62H84DZzuTaOqH2DDaP3asNYwQRw
	ZUijGEUg1/R5efyhfKOAYIUZwnapd6gF4ezzsKsvgX4ZHXzsWL180w3omn5/oR3t29wk/D
	Pk2j84K7yd712Zc3SoWXh5A4fOh3vnk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771246032;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gU1m8rwIhAk+8fLwq0aHpEphDQz5TPlMEAqnFKuRWiM=;
	b=YVHzCIV3Xofwl7qVLPV3zEBcODsyshSxLdJnlebZwtIAF1rvPOwEnalVzeOvp8pfETQG1+
	PrZiSWJSuAz1rUDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="GPHXW/UH";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YVHzCIV3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771246032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gU1m8rwIhAk+8fLwq0aHpEphDQz5TPlMEAqnFKuRWiM=;
	b=GPHXW/UHIRbQlpkg+poZ8SQQ+LqI/Fyt55CwGmxCmJ62H84DZzuTaOqH2DDaP3asNYwQRw
	ZUijGEUg1/R5efyhfKOAYIUZwnapd6gF4ezzsKsvgX4ZHXzsWL180w3omn5/oR3t29wk/D
	Pk2j84K7yd712Zc3SoWXh5A4fOh3vnk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771246032;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gU1m8rwIhAk+8fLwq0aHpEphDQz5TPlMEAqnFKuRWiM=;
	b=YVHzCIV3Xofwl7qVLPV3zEBcODsyshSxLdJnlebZwtIAF1rvPOwEnalVzeOvp8pfETQG1+
	PrZiSWJSuAz1rUDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9EB953EA62;
	Mon, 16 Feb 2026 12:47:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g0hxGM4Rk2l7QgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 16 Feb 2026 12:47:10 +0000
Message-ID: <e8bc9e37-00ea-4d05-a786-195d79acdeae@suse.de>
Date: Mon, 16 Feb 2026 13:47:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/21] nvme-tcp: Use CCR to recover controller that
 hits an error
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 James Smart <jsmart833426@gmail.com>
Cc: Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
 <20260214042753.4073668-11-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260214042753.4073668-11-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[purestorage.com,broadcom.com,gmail.com,nvidia.com,lst.de,kernel.dk,kernel.org,grimberg.me];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,purestorage.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 1AD013E733
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260216_044714_374494_D84F8CF8 
X-CRM114-Status: GOOD (  22.64  )
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

On 2/14/26 05:25, Mohamed Khalfella wrote:
> An alive nvme controller that hits an error now will move to FENCING
> state instead of RESETTING state. ctrl->fencing_work attempts CCR to
> terminate inflight IOs. Regardless of the success or failure of CCR
> operation the controller is transitioned to RESETTING state to continue
> error recovery process.
> 
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   drivers/nvme/host/tcp.c | 32 +++++++++++++++++++++++++++++++-
>   1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 69cb04406b47..229cfdffd848 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -193,6 +193,7 @@ struct nvme_tcp_ctrl {
>   	struct sockaddr_storage src_addr;
>   	struct nvme_ctrl	ctrl;
>   
> +	struct work_struct	fencing_work;
>   	struct work_struct	err_work;
>   	struct delayed_work	connect_work;
>   	struct nvme_tcp_request async_req;
> @@ -611,6 +612,12 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
>   
>   static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
>   {
> +	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCING)) {
> +		dev_warn(ctrl->device, "starting controller fencing\n");
> +		queue_work(nvme_wq, &to_tcp_ctrl(ctrl)->fencing_work);
> +		return;
> +	}
> +
>   	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
>   		return;
>   
> @@ -2470,12 +2477,31 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
>   	nvme_tcp_reconnect_or_remove(ctrl, ret);
>   }
>   
> +static void nvme_tcp_fencing_work(struct work_struct *work)
> +{
> +	struct nvme_tcp_ctrl *tcp_ctrl = container_of(work,
> +			struct nvme_tcp_ctrl, fencing_work);
> +	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
> +	unsigned long rem;
> +
> +	rem = nvme_fence_ctrl(ctrl);
> +	if (rem) {
> +		dev_info(ctrl->device,
> +			 "CCR failed, skipping time-based recovery\n");
> +	}
> +
> +	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
> +	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> +		queue_work(nvme_reset_wq, &tcp_ctrl->err_work);
> +}
> +
>   static void nvme_tcp_error_recovery_work(struct work_struct *work)
>   {
>   	struct nvme_tcp_ctrl *tcp_ctrl = container_of(work,
>   				struct nvme_tcp_ctrl, err_work);
>   	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
>   
> +	flush_work(&to_tcp_ctrl(ctrl)->fencing_work);
>   	if (nvme_tcp_key_revoke_needed(ctrl))
>   		nvme_auth_revoke_tls_key(ctrl);
>   	nvme_stop_keep_alive(ctrl);
> @@ -2518,6 +2544,7 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
>   		container_of(work, struct nvme_ctrl, reset_work);
>   	int ret;
>   
> +	flush_work(&to_tcp_ctrl(ctrl)->fencing_work);
>   	if (nvme_tcp_key_revoke_needed(ctrl))
>   		nvme_auth_revoke_tls_key(ctrl);
>   	nvme_stop_ctrl(ctrl);
> @@ -2643,13 +2670,15 @@ static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
>   	struct nvme_tcp_cmd_pdu *pdu = nvme_tcp_req_cmd_pdu(req);
>   	struct nvme_command *cmd = &pdu->cmd;
>   	int qid = nvme_tcp_queue_id(req->queue);
> +	enum nvme_ctrl_state state;
>   
>   	dev_warn(ctrl->device,
>   		 "I/O tag %d (%04x) type %d opcode %#x (%s) QID %d timeout\n",
>   		 rq->tag, nvme_cid(rq), pdu->hdr.type, cmd->common.opcode,
>   		 nvme_fabrics_opcode_str(qid, cmd), qid);
>   
> -	if (nvme_ctrl_state(ctrl) != NVME_CTRL_LIVE) {
> +	state = nvme_ctrl_state(ctrl);
> +	if (state != NVME_CTRL_LIVE && state != NVME_CTRL_FENCING) {
>   		/*
>   		 * If we are resetting, connecting or deleting we should
>   		 * complete immediately because we may block controller
> @@ -2904,6 +2933,7 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
>   
>   	INIT_DELAYED_WORK(&ctrl->connect_work,
>   			nvme_tcp_reconnect_ctrl_work);
> +	INIT_WORK(&ctrl->fencing_work, nvme_tcp_fencing_work);
>   	INIT_WORK(&ctrl->err_work, nvme_tcp_error_recovery_work);
>   	INIT_WORK(&ctrl->ctrl.reset_work, nvme_reset_ctrl_work);
>   

I still would love to have the 'FENCING/FENCED' state handled in the
generic code, but that would require quite some twiddling with the
transport-specific error handlings. So probably not for this round.

Other than that:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

