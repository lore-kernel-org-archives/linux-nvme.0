Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127F960A383A
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2026 07:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dnyoLM1l;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=CgGmlpU1;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=HDsnFhuU;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=AEOoK2Wt;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=gMO2O6px
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=5mOy1Nx9Nt52I5GK5rG1oj7yfpJvH/VLyGjzbqoN6l0=; b=dnyoLM1loLXt1a
	lem9ZQA1h66ZwonCvc5UJbdqUwYnJea2EFLBMn3jG/p6BDndvQqTFrAVozUKjcH5tUP9LUMbMvDMo
	oRkP7nO3zWKjUvwsdLm94J9P/p6WvXttrTL/UOAKbH/SZnshQBtJBMWgf8CzNkxBo5JzGpKFK/mzi
	O36HwtYiHSxwJkhyG7eXQio/1D250uYu+UfdSFzUjccw29J20WCJOj7/xl3F0rzstfyj8LEpCdlDR
	aVMMo9+YOZL6t9+UGIjLwKotqeia1EDbkghLY4pruD8qPKteiZv/fk9SXvMfZ51ZDl5U+ltVu1vuy
	4iFaMT2yzpogtlUSEtCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLbjn-00000003uSf-0ZUq;
	Tue, 27 Oct 2026 07:36:51 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLbjl-00000003uRt-07W1
	for linux-nvme@lists.infradead.org;
	Tue, 27 Oct 2026 07:36:50 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DF3DB1F791;
	Tue, 27 Oct 2026 07:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793086607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5mOy1Nx9Nt52I5GK5rG1oj7yfpJvH/VLyGjzbqoN6l0=;
	b=CgGmlpU17VGQw9iiEjkClU6UfPZqktpx4pfrFyd4PohVOang9hlRupyS07Ut/y+iEuyVJq
	Tqtf9DD7vf5GUn6dp2B0ZehZQvyusAz5jindwO2PecQH5yVZmzFfWzWmBOnPobjoi1T6u9
	BHBuibqzfCXkFt0/LHU3B0gsOG+Dv+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793086607;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5mOy1Nx9Nt52I5GK5rG1oj7yfpJvH/VLyGjzbqoN6l0=;
	b=HDsnFhuU88nCN2tE7dl3AXryPBRqNrKAKtmBnGAb7px9mIJqz9obZPKuahYGSqIBexMUWY
	JNVsWZCGDIxkLzDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AEOoK2Wt;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gMO2O6px
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793086604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5mOy1Nx9Nt52I5GK5rG1oj7yfpJvH/VLyGjzbqoN6l0=;
	b=AEOoK2WttG9+DbFszI1H1qzda/dhmstiHWk9j7YVW1+x/pgWcGgVlmKOo/kzfmbn3QBYLV
	8ZM3cjLaGkhWOTLws9yNmc2QyM+eRf38xRl5U0eCVkp5cW13ejUHOWre+q7GIf/dhTgz5P
	RPxGpQx+jhlv6DKccjfYWrxu3hxFEL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793086604;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5mOy1Nx9Nt52I5GK5rG1oj7yfpJvH/VLyGjzbqoN6l0=;
	b=gMO2O6pxhyPYD48UgtlxgvClsg58CCPlYmm8rQy0SISaYd0kae8BHv5gCSctRulZCn54Qi
	HRWPch0pGRriF1CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 02C9313319;
	Tue, 27 Oct 2026 07:36:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MxCqJ4tU4GoHXAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 27 Oct 2026 07:36:43 +0000
Message-ID: <b7334814-eb15-4c94-b227-8102c84dbb47@suse.de>
Date: Tue, 27 Oct 2026 08:36:42 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme-tcp: skip TLS control records while waiting for
 the ICResp
To: martin.nvme.dev@gmail.com, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Martin Belanger <martin.belanger@dell.com>
References: <20261026-nvme-tcp-ctrlrec-fixes-v1-0-ebf6ff7eff34@gmail.com>
 <20261026-nvme-tcp-ctrlrec-fixes-v1-2-ebf6ff7eff34@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261026-nvme-tcp-ctrlrec-fixes-v1-2-ebf6ff7eff34@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-12.00 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,kernel.dk,lst.de,grimberg.me];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -12.00
X-Spam-Level: 
X-Rspamd-Queue-Id: DF3DB1F791
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261027_003649_230351_94758861 
X-CRM114-Status: GOOD (  36.05  )
X-Spam-Score: -4.4 (----)
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
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/26/26 7:09 PM, Martin Belanger via B4 Relay wrote:
> From: Martin Belanger <martin.belanger@dell.com>
> 
> A peer may send a NewSessionTicket as soon as the handshake completes,
> ahead of the ICResp. nvme_tcp_init_connection() fails the connection on
> any record that is not application data, so such a target cannot be
> reached at all. An OpenSSL-based target does this by default.
> 
> Discard such a record and read again, up to a fixed number of records.
> Report an alert, and fail the connection for any other record type.
> 
> The record type is now checked before the length. A control record
> shorter than the ICResp was reported as -ECONNRESET, which hid the real
> cause.
> 
> Fixes: 2837966ab2a8 ("nvme-tcp: control message handling for recvmsg()")
> Assisted-by: LLM
> Signed-off-by: Martin Belanger <martin.belanger@dell.com>
> ---
>   drivers/nvme/host/tcp.c | 157 +++++++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 135 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index a03476f0f69d..2d361a9e8710 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -55,6 +55,12 @@ MODULE_PARM_DESC(tls_handshake_timeout,
>   		 "nvme TLS handshake timeout in seconds (default 10)");
>   #endif
>   
> +/* read a TLS control record in chunks of this size */
> +#define NVME_TCP_TLS_REC_CHUNK 256
> +
> +/* TLS records read while waiting for the ICResp, the ICResp included */
> +#define NVME_TCP_ICRESP_MAX_RECORDS 8
> +
>   static int nvme_tcp_cpu_queues[NR_CPUS];
>   static DEFINE_SPINLOCK(nvme_tcp_cpu_queues_lock);
>   
> @@ -1548,12 +1554,138 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
>   	mutex_destroy(&queue->pf_cache_lock);
>   }
>   
> +static int nvme_tcp_recv_tls_alert(struct nvme_tcp_queue *queue,
> +				   struct msghdr *msg, int len)
> +{
> +	struct sock *sk = queue->sock->sk;
> +	u8 level, description;
> +
> +	if (len < 2) {
> +		dev_err(queue->ctrl->ctrl.device,
> +			"queue %d: truncated TLS alert\n",
> +			nvme_tcp_queue_id(queue));
> +		return -ENOTCONN;
> +	}
> +
> +	/* tls_alert_recv() reads through the iterator */
> +	iov_iter_revert(&msg->msg_iter, len);
> +	tls_alert_recv(sk, msg, &level, &description);
> +
> +	if (level == TLS_ALERT_LEVEL_FATAL) {
> +		dev_err(queue->ctrl->ctrl.device,
> +			"queue %d: fatal TLS alert %u\n",
> +			nvme_tcp_queue_id(queue), description);
> +		return -ENOTCONN;
> +	}
> +
> +	/* a peer shutting down normally is not worth a warning */
> +	if (description == TLS_ALERT_DESC_CLOSE_NOTIFY)
> +		dev_dbg(queue->ctrl->ctrl.device,
> +			"queue %d: TLS close_notify\n",
> +			nvme_tcp_queue_id(queue));
> +	else
> +		dev_warn(queue->ctrl->ctrl.device,
> +			 "queue %d: TLS alert %u\n",
> +			 nvme_tcp_queue_id(queue), description);
> +
> +	return 0;
> +}
> +
> +/*
> + * Discard a TLS record that arrived in place of the ICResp. A peer may send
> + * a NewSessionTicket as soon as the handshake completes.
> + *
> + * Returns 0 when the record was discarded and the ICResp can be read, or a
> + * negative errno if the connection cannot continue.
> + */
> +static int nvme_tcp_skip_tls_record(struct nvme_tcp_queue *queue,
> +				    struct msghdr *msg, u8 ctype, int len)
> +{
> +	u8 buf[NVME_TCP_TLS_REC_CHUNK];
> +	int ret;
> +
> +	switch (ctype) {
> +	case TLS_RECORD_TYPE_HANDSHAKE:
> +		break;
> +	case TLS_RECORD_TYPE_ALERT:
> +		ret = nvme_tcp_recv_tls_alert(queue, msg, len);
> +		return ret ? : -ENOTCONN;
> +	default:
> +		pr_err("queue %d: unhandled TLS record %u\n",
> +		       nvme_tcp_queue_id(queue), ctype);
> +		return -ENOTCONN;
> +	}
> +
> +	/* the ICResp is in a later record, drain this one first */
> +	while (!(msg->msg_flags & MSG_EOR)) {
> +		struct kvec iov = {
> +			.iov_base = buf,
> +			.iov_len = sizeof(buf),
> +		};
> +		struct msghdr drain = {};
> +
> +		ret = kernel_recvmsg(queue->sock, &drain, &iov, 1, sizeof(buf),
> +				     0);
> +		if (ret <= 0) {
> +			pr_warn("queue %d: failed to drain TLS record: %d\n",
> +				nvme_tcp_queue_id(queue), ret);
> +			return ret ? : -ECONNRESET;
> +		}
> +		msg->msg_flags = drain.msg_flags;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Receive the ICResp. Over TLS, skip the records that a peer may send
> + * ahead of it.
> + *
> + * Returns the length received, or a negative errno.
> + */
> +static int nvme_tcp_recv_icresp(struct nvme_tcp_queue *queue,
> +				struct nvme_tcp_icresp_pdu *icresp)
> +{
> +	char cbuf[CMSG_LEN(sizeof(char))];
> +	struct msghdr msg;
> +	struct kvec iov;
> +	u8 ctype;
> +	int i, ret;
> +
> +	for (i = 0; i < NVME_TCP_ICRESP_MAX_RECORDS; i++) {
> +		memset(&msg, 0, sizeof(msg));
> +		memset(cbuf, 0, sizeof(cbuf));
> +		iov.iov_base = icresp;
> +		iov.iov_len = sizeof(*icresp);
> +		if (nvme_tcp_queue_tls(queue)) {
> +			msg.msg_control = cbuf;
> +			msg.msg_controllen = sizeof(cbuf);
> +		}
> +		msg.msg_flags = MSG_WAITALL;
> +		ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
> +				     iov.iov_len, msg.msg_flags);
> +		if (ret < 0 || !nvme_tcp_queue_tls(queue))
> +			return ret;
> +
> +		ctype = tls_get_record_type(queue->sock->sk,
> +					    (struct cmsghdr *)cbuf);
> +		if (ctype == TLS_RECORD_TYPE_DATA)
> +			return ret;
> +
> +		ret = nvme_tcp_skip_tls_record(queue, &msg, ctype, ret);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	pr_err("queue %d: too many TLS records before the ICResp\n",
> +	       nvme_tcp_queue_id(queue));
> +	return -EPROTO;
> +}
> +
>   static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
>   {
>   	struct nvme_tcp_icreq_pdu *icreq;
>   	struct nvme_tcp_icresp_pdu *icresp;
> -	char cbuf[CMSG_LEN(sizeof(char))] = {};
> -	u8 ctype;
>   	struct msghdr msg = {};
>   	struct kvec iov;
>   	bool ctrl_hdgst, ctrl_ddgst;
> @@ -1591,16 +1723,7 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
>   		goto free_icresp;
>   	}
>   
> -	memset(&msg, 0, sizeof(msg));
> -	iov.iov_base = icresp;
> -	iov.iov_len = sizeof(*icresp);
> -	if (nvme_tcp_queue_tls(queue)) {
> -		msg.msg_control = cbuf;
> -		msg.msg_controllen = sizeof(cbuf);
> -	}
> -	msg.msg_flags = MSG_WAITALL;
> -	ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
> -			iov.iov_len, msg.msg_flags);
> +	ret = nvme_tcp_recv_icresp(queue, icresp);
>   	if (ret >= 0 && ret < sizeof(*icresp))
>   		ret = -ECONNRESET;
>   	if (ret < 0) {
> @@ -1608,16 +1731,6 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
>   			nvme_tcp_queue_id(queue), ret);
>   		goto free_icresp;
>   	}
> -	ret = -ENOTCONN;
> -	if (nvme_tcp_queue_tls(queue)) {
> -		ctype = tls_get_record_type(queue->sock->sk,
> -					    (struct cmsghdr *)cbuf);
> -		if (ctype != TLS_RECORD_TYPE_DATA) {
> -			pr_err("queue %d: unhandled TLS record %d\n",
> -			       nvme_tcp_queue_id(queue), ctype);
> -			goto free_icresp;
> -		}
> -	}
>   	ret = -EINVAL;
>   	if (icresp->hdr.type != nvme_tcp_icresp) {
>   		pr_err("queue %d: bad type returned %d\n",
> 

Thanks for doing this. Turns out that the 'new' TLS RFC 9846 actually 
requires us to drop NewSessionTicket message as we don't do session
resumption.
Note to self: we could check to (ab-)use the NewSessionTicket mechanism
for I/O queues when creating the connection; might be interesting.
Anyway.

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

