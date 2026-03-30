Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A1CFB3D15
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Mar 2026 11:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9ep2Ne1zwvkIuZyKM5oDYQk3F+nTH2jmvGRqTmJkI24=; b=1RdMhAj0UG6inH63Gc8DYjdNlS
	xXqW574qJpMGBMDBQqoVoHBJoorGR0MtfR1zz5OfK1LFhMukusXBuiesTNzes4MLLTZrCOf7rmQQP
	YJhoJRn8yIAntOg0W/5Y48NAJVb8RcNLIFp5U2Fyo2p9P8rXkPz237jK7PGhfVWFOehWMypbclL+X
	lgnrBTIHzT/Vz7aNMs8ez2+n+MABSsnVtxQBlNv3AgRiMxhgQKWUIwj/1oGCdWM+upKKe7Dp+cKd6
	tWMyugTAn92r+bbqS2mC9JjUqM/dhD2sB0M1rGUfMSFjZTsEY9qn7xE4CHIKtmeuhrYuLoPVTvEeE
	vL3ePeLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7AM2-0000000B7da-39SS;
	Mon, 30 Mar 2026 11:00:22 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7AM1-0000000B7dA-01HW
	for linux-nvme@lists.infradead.org;
	Mon, 30 Mar 2026 11:00:22 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F2B894D1F1;
	Mon, 30 Mar 2026 11:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774868419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ep2Ne1zwvkIuZyKM5oDYQk3F+nTH2jmvGRqTmJkI24=;
	b=LLWs931OThFnQX2sbTLGQjC6P89Um9+b85mX1oxcgfzuG/yhpDqAxyNHP9cikRLonbgbq2
	pVgdd3z+2LJn/raDa7GNpl7nJGn5jNaFrCaULe+yLi12Lc+kooA3WIEKnsX3Q8syV7+Wb+
	KSsk47QCFbbyIbUcsce2MeFlvxliwV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774868419;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ep2Ne1zwvkIuZyKM5oDYQk3F+nTH2jmvGRqTmJkI24=;
	b=YlSWkQk5H8rCq6o8Kq1fXd3zzVdrFFVYoU2UpO+CrbUgn1U8VErRhk9awQjDn/XvbWiOP/
	664JCtUGQFOOR4Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774868418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ep2Ne1zwvkIuZyKM5oDYQk3F+nTH2jmvGRqTmJkI24=;
	b=li9UhWxOLt31RSZzqSLJ3oX7cGf01DuyoxRmIP9f4d8QEmFaFlGitrnIVLQumnQXm5yGZk
	dwLSEW9Ih2Pyg2e9kjbOpe1GJYHmpcE+LoQm4KLSQohbOmXTquBPltGzgAwPNfKd6tzA7Z
	kRu+W2OPc9s64g3YPlZraSJsfD89ZLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774868418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ep2Ne1zwvkIuZyKM5oDYQk3F+nTH2jmvGRqTmJkI24=;
	b=i1HNBRZHswYjO6/JGOoRPxtcRyesC63mfUAm9Cuua8eObm7OHL5IWRgteGgNz4qw8V6KPq
	t+/R1dao7wqNe3DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4AD14A0A2;
	Mon, 30 Mar 2026 11:00:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pDeeL8FXymmiAQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 30 Mar 2026 11:00:17 +0000
Message-ID: <37c751e9-f842-4532-b4fd-919fae7295b4@suse.de>
Date: Mon, 30 Mar 2026 13:00:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/15] nvme-tcp: Use CCR to recover controller that
 hits an error
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <jsmart833426@gmail.com>
Cc: Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260328004518.1729186-1-mkhalfella@purestorage.com>
 <20260328004518.1729186-11-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260328004518.1729186-11-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[purestorage.com,broadcom.com,gmail.com,nvidia.com,kernel.dk,kernel.org,grimberg.me];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[purestorage.com:email,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260330_040021_194185_B75838BE 
X-CRM114-Status: GOOD (  22.07  )
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

On 3/28/26 01:43, Mohamed Khalfella wrote:
> An alive nvme controller that hits an error now will move to FENCING
> state instead of RESETTING state. ctrl->fencing_work attempts CCR to
> terminate inflight IOs. Regardless of the success or failure of CCR
> operation the controller is transitioned to RESETTING state to continue
> error recovery process.
> 
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   drivers/nvme/host/tcp.c | 30 +++++++++++++++++++++++++++++-
>   1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 243dab830dc8..6393ec2b3b55 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -194,6 +194,7 @@ struct nvme_tcp_ctrl {
>   	struct sockaddr_storage src_addr;
>   	struct nvme_ctrl	ctrl;
>   
> +	struct work_struct	fencing_work;
>   	struct work_struct	err_work;
>   	struct delayed_work	connect_work;
>   	struct nvme_tcp_request async_req;
> @@ -612,6 +613,12 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
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
> @@ -2471,12 +2478,29 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
>   	nvme_tcp_reconnect_or_remove(ctrl, ret);
>   }
>   
> +static void nvme_tcp_fencing_work(struct work_struct *work)
> +{
> +	struct nvme_tcp_ctrl *tcp_ctrl = container_of(work,
> +			struct nvme_tcp_ctrl, fencing_work);
> +	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
> +	int ret;
> +
> +	ret = nvme_fence_ctrl(ctrl);
> +	if (ret)
> +		dev_info(ctrl->device, "CCR failed with error %d\n", ret);
> +
> +	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
> +	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> +		queue_work(nvme_reset_wq, &tcp_ctrl->err_work);
> +}
> +

To follow up to my comments on the previous patches:
As we're already using a work queue, wouldn't it be better / easier
to make 'nvme_fence_ctrl()' asynchronous and explicitely call 
'nvme_fence_wait()' or something here?

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
> @@ -2519,6 +2543,7 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
>   		container_of(work, struct nvme_ctrl, reset_work);
>   	int ret;
>   
> +	flush_work(&to_tcp_ctrl(ctrl)->fencing_work);
>   	if (nvme_tcp_key_revoke_needed(ctrl))
>   		nvme_auth_revoke_tls_key(ctrl);
>   	nvme_stop_ctrl(ctrl);
> @@ -2644,13 +2669,15 @@ static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
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

Do we need to call nvme_tcp_error_recovery() even if the controller is
in 'FENCING'?
Don't we just need to return BLK_EH_RESET_TIMER when in 'FENCING' ?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

