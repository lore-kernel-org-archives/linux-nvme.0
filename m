Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D7F106FD87
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Mar 2026 07:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kDAZ5pSvfrGwLtFe8qAb5gXyiRfjMf3HaCC9FDcp/iM=; b=AwVDe3PZcdmDFiNzWY8G/Abkio
	9JPoCbW/GqUmacqzisiRLcN6j8HCqXW7BLhqvfF7JBLWktodtGG6V7fqZHrPSBq1d9eSWWUfoy17O
	KQ9WC3zkTFV2nghDlCPDGhJHPYIAV4v6yA9xTwbAdNIQ4AO6DwT91viyBU1DZferH1LpWtb2fbNL4
	jQQxYbu9JdS78HU1TN/+ydK4QudZYt3M4RZXlEqazhqzQW3QmLvPpe6t4kaJHbnzycPvMAb1oLTIH
	6SKsjW7p9SJgUVKIzcVPU+gV9V0s+DkFQ8ZzQM8ZjCKpA3moTY0JZ4hgYbFoEfnM49IEiPXmjYTPj
	qUJLz2Kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0wf5-0000000Gz7J-0Y9f;
	Fri, 13 Mar 2026 07:10:19 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0wez-0000000Gz5g-3ksu
	for linux-nvme@lists.infradead.org;
	Fri, 13 Mar 2026 07:10:18 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D94E25CED6;
	Fri, 13 Mar 2026 07:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773385809; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kDAZ5pSvfrGwLtFe8qAb5gXyiRfjMf3HaCC9FDcp/iM=;
	b=X3soQnUK0QQqpy1oj8umgwAMa6xcUMyLDz7LPCqntzR7q1e228xZ5SaFk38cAj/TFkEALU
	ZsKCJppOD8dn3OoXVH4oLKxxwoqHtCZoWt9vPaAAI4TZ7AHb1zXyg4KwbeRe7WjT00zC2j
	k91WzjT/1Xc+SEPAyQsd99u0cupVLrM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773385809;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kDAZ5pSvfrGwLtFe8qAb5gXyiRfjMf3HaCC9FDcp/iM=;
	b=kjUwRV7f/UHMM6wvAswDQDksj/kqFG2TEGKbQh4E1pUtE5sRPlPPOFPWn4Z/EFtp1bgCAC
	zfyVVpNKyFtdEdBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SWT4dR5O;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="K8Q8/ar4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773385808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kDAZ5pSvfrGwLtFe8qAb5gXyiRfjMf3HaCC9FDcp/iM=;
	b=SWT4dR5OHXLbUGcXWwNIt3nGEhYTEjdi+niaJNvlwTa5sNoY5f0e6FsccNRAcdK0cPjhO8
	osiPLMWgPPO0GlU2UJqwjcRFKe1KpnvxOcNOnXxjo8Dn82pmabIj+JSChF9NmyGS3xVin7
	pGIiyMImpA7nFF4XfHEFuFJKcHA9iL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773385808;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kDAZ5pSvfrGwLtFe8qAb5gXyiRfjMf3HaCC9FDcp/iM=;
	b=K8Q8/ar4GJJJ/iMxC+EQN5RvxePVEIYGukldearSOStHk2+TCYU5ApYk942uCRcxrnbXqy
	XtqMCCab6S+xqcAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A7C1403D0;
	Fri, 13 Mar 2026 07:10:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XKBXJFC4s2mecAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 13 Mar 2026 07:10:08 +0000
Message-ID: <67675bf0-dfe4-4ed5-bf4f-dddac48b1c96@suse.de>
Date: Fri, 13 Mar 2026 08:10:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] nvmet-tcp: propagate nvmet_tcp_build_pdu_iovec()
 errors to its callers
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, dwagner@suse.de, yjshin0438@gmail.com,
 sagi@grimberg.me, chaitanyak@nvidia.com, mlombard@arkamax.eu
References: <20260312134057.110274-1-mlombard@redhat.com>
 <20260312134057.110274-2-mlombard@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260312134057.110274-2-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,suse.de,gmail.com,grimberg.me,nvidia.com,arkamax.eu];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: D94E25CED6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260313_001014_125540_8119C057 
X-CRM114-Status: GOOD (  21.57  )
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

On 3/12/26 14:40, Maurizio Lombardi wrote:
> Currently, when nvmet_tcp_build_pdu_iovec() detects an out-of-bounds
> PDU length or offset, it triggers nvmet_tcp_fatal_error(cmd->queue)
> and returns early. However, because the function returns void, the
> callers are entirely unaware that a fatal error has occurred and
> that the cmd->recv_msg.msg_iter was left uninitialized.
> 
> Callers such as nvmet_tcp_handle_h2c_data_pdu() proceed to blindly
> overwrite the queue state with queue->rcv_state = NVMET_TCP_RECV_DATA
> Consequently, the socket receiving loop may attempt to read incoming
> network data into the uninitialized iterator.
> 
> Fix this by shifting the error handling responsibility to the callers.
> 
> Fixes: 52a0a9854934 ("nvmet-tcp: add bounds checks in nvmet_tcp_build_pdu_iovec")
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>   drivers/nvme/target/tcp.c | 51 ++++++++++++++++++++++-----------------
>   1 file changed, 29 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index acc71a26733f..1fbf12df1183 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -351,7 +351,7 @@ static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd)
>   
>   static void nvmet_tcp_fatal_error(struct nvmet_tcp_queue *queue);
>   
> -static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
> +static int nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
>   {
>   	struct bio_vec *iov = cmd->iov;
>   	struct scatterlist *sg;
> @@ -364,22 +364,19 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
>   	offset = cmd->rbytes_done;
>   	cmd->sg_idx = offset / PAGE_SIZE;
>   	sg_offset = offset % PAGE_SIZE;
> -	if (!cmd->req.sg_cnt || cmd->sg_idx >= cmd->req.sg_cnt) {
> -		nvmet_tcp_fatal_error(cmd->queue);
> -		return;
> -	}
> +	if (!cmd->req.sg_cnt || cmd->sg_idx >= cmd->req.sg_cnt)
> +		return -EPROTO;
> +
>   	sg = &cmd->req.sg[cmd->sg_idx];
>   	sg_remaining = cmd->req.sg_cnt - cmd->sg_idx;
>   
>   	while (length) {
> -		if (!sg_remaining) {
> -			nvmet_tcp_fatal_error(cmd->queue);
> -			return;
> -		}
> -		if (!sg->length || sg->length <= sg_offset) {
> -			nvmet_tcp_fatal_error(cmd->queue);
> -			return;
> -		}
> +		if (!sg_remaining)
> +			return -EPROTO;
> +
> +		if (!sg->length || sg->length <= sg_offset)
> +			return -EPROTO;
> +
>   		u32 iov_len = min_t(u32, length, sg->length - sg_offset);
>   
>   		bvec_set_page(iov, sg_page(sg), iov_len,
> @@ -394,6 +391,7 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
>   
>   	iov_iter_bvec(&cmd->recv_msg.msg_iter, ITER_DEST, cmd->iov,
>   		      nr_pages, cmd->pdu_len);
> +	return 0;
>   }
>   
>   static void nvmet_tcp_fatal_error(struct nvmet_tcp_queue *queue)
> @@ -931,7 +929,7 @@ static int nvmet_tcp_handle_icreq(struct nvmet_tcp_queue *queue)
>   	return 0;
>   }
>   
> -static void nvmet_tcp_handle_req_failure(struct nvmet_tcp_queue *queue,
> +static int nvmet_tcp_handle_req_failure(struct nvmet_tcp_queue *queue,
>   		struct nvmet_tcp_cmd *cmd, struct nvmet_req *req)
>   {
>   	size_t data_len = le32_to_cpu(req->cmd->common.dptr.sgl.length);
> @@ -947,19 +945,23 @@ static void nvmet_tcp_handle_req_failure(struct nvmet_tcp_queue *queue,
>   	if (!nvme_is_write(cmd->req.cmd) || !data_len ||
>   	    data_len > cmd->req.port->inline_data_size) {
>   		nvmet_prepare_receive_pdu(queue);
> -		return;
> +		return 0;
>   	}
>   
>   	ret = nvmet_tcp_map_data(cmd);
>   	if (unlikely(ret)) {
>   		pr_err("queue %d: failed to map data\n", queue->idx);
>   		nvmet_tcp_fatal_error(queue);
> -		return;
> +		return -EPROTO;
>   	}
>   
>   	queue->rcv_state = NVMET_TCP_RECV_DATA;
> -	nvmet_tcp_build_pdu_iovec(cmd);
>   	cmd->flags |= NVMET_TCP_F_INIT_FAILED;
> +	ret = nvmet_tcp_build_pdu_iovec(cmd);
> +	if (unlikely(ret))
> +		pr_err("queue %d: failed to build PDU iovec\n", queue->idx);

Why don't we call 'nvmet_tcp_fatal_error()' here?
The original code did ...

> +
> +	return ret;
>   }
>   
>   static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
> @@ -1011,7 +1013,10 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
>   		goto err_proto;
>   	}
>   	cmd->pdu_recv = 0;
> -	nvmet_tcp_build_pdu_iovec(cmd);
> +	if (unlikely(nvmet_tcp_build_pdu_iovec(cmd))) {
> +		pr_err("queue %d: failed to build PDU iovec\n", queue->idx);
> +		goto err_proto;
> +	}
>   	queue->cmd = cmd;
>   	queue->rcv_state = NVMET_TCP_RECV_DATA;
>   
> @@ -1074,8 +1079,7 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
>   			le32_to_cpu(req->cmd->common.dptr.sgl.length),
>   			le16_to_cpu(req->cqe->status));
>   
> -		nvmet_tcp_handle_req_failure(queue, queue->cmd, req);
> -		return 0;
> +		return nvmet_tcp_handle_req_failure(queue, queue->cmd, req);
>   	}
>   
>   	ret = nvmet_tcp_map_data(queue->cmd);
> @@ -1092,8 +1096,11 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
>   	if (nvmet_tcp_need_data_in(queue->cmd)) {
>   		if (nvmet_tcp_has_inline_data(queue->cmd)) {
>   			queue->rcv_state = NVMET_TCP_RECV_DATA;
> -			nvmet_tcp_build_pdu_iovec(queue->cmd);
> -			return 0;
> +			ret = nvmet_tcp_build_pdu_iovec(queue->cmd);
> +			if (unlikely(ret))
> +				pr_err("queue %d: failed to build PDU iovec\n",
> +					queue->idx);
> +			return ret;
>   		}
>   		/* send back R2T */
>   		nvmet_tcp_queue_response(&queue->cmd->req);

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

