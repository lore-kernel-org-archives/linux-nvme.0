Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0F9606A333
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2026 12:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ARKBOAu/;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=2O0DXevg;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=gXxrNEgl;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=2O0DXevg;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=gXxrNEgl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=VrzCEXTItTgWU3isMMl++QttF+TZDkdN61/UdJRYkJ0=; b=ARKBOAu/sWZc0v
	I6ttYXSfySH04M2OMzG0f5LKdpP0ZDHtTE9LmYHeM8J8AaOD5hV6BRsp/IMb85T0TXQj+QMT0edO7
	uLIHvXM9+BEm+/IO7A/U916qcAGsrK4JzpMn1NFR1r54vXu2JOnyqGJGfKaA15/Z59CO1qTz4pc5z
	GcgyIDwSVej58/YNbhdVe1ORF/RuMhRiaH0JjaNcu2Kfc8zE6WETKGDu8u3UB86GReWf2aw8dffe8
	+tiYOnp5CE6/o+W8cviFGEjqQTMUjDNbTAHQ/j+dBOSBb5nYlpWtaxLSuSe2vCdIjqDU6wlTiNfzB
	kLr8xb72BfGppurgoW2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRTyi-00000009tF0-3MVo;
	Thu, 12 Nov 2026 12:32:32 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRTyf-00000009tEK-2nCI
	for linux-nvme@lists.infradead.org;
	Thu, 12 Nov 2026 12:32:31 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4DC7021E77;
	Thu, 12 Nov 2026 12:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794486747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VrzCEXTItTgWU3isMMl++QttF+TZDkdN61/UdJRYkJ0=;
	b=2O0DXevgyuu/jUp2+yew4muEA5AQKrGz8ZgkZUqPSXdKFq5Jz0W3ld2Ovg00Dur5r1Edja
	uXl/PlzMsxsruDYFvCLgtRoC2a6nE6z2Luym7bVnjeebUYLSy+/xaFLoEP8RJ5p74TpwyC
	9c9GMJ/We10WnQb3wl9cXeAMCVHXLXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794486747;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VrzCEXTItTgWU3isMMl++QttF+TZDkdN61/UdJRYkJ0=;
	b=gXxrNEglvE6pCoMrIGfLl4HfT/gCxHBBqh7FW6gs/emGOLtb0jUqpNPJViQ5AQ5ey+sRX6
	c1nq73aUswFwDUCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=2O0DXevg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gXxrNEgl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794486747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VrzCEXTItTgWU3isMMl++QttF+TZDkdN61/UdJRYkJ0=;
	b=2O0DXevgyuu/jUp2+yew4muEA5AQKrGz8ZgkZUqPSXdKFq5Jz0W3ld2Ovg00Dur5r1Edja
	uXl/PlzMsxsruDYFvCLgtRoC2a6nE6z2Luym7bVnjeebUYLSy+/xaFLoEP8RJ5p74TpwyC
	9c9GMJ/We10WnQb3wl9cXeAMCVHXLXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794486747;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VrzCEXTItTgWU3isMMl++QttF+TZDkdN61/UdJRYkJ0=;
	b=gXxrNEglvE6pCoMrIGfLl4HfT/gCxHBBqh7FW6gs/emGOLtb0jUqpNPJViQ5AQ5ey+sRX6
	c1nq73aUswFwDUCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 068C213432;
	Thu, 12 Nov 2026 12:32:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YfV7NNqx9WqjRwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 12 Nov 2026 12:32:27 +0000
Message-ID: <8f7656ef-2730-484b-98cd-701616ef1a8f@suse.de>
Date: Thu, 12 Nov 2026 13:32:26 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] nvme-tcp: consume TLS records without application
 data
To: martin.nvme.dev@gmail.com, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Martin Belanger <martin.belanger@dell.com>, stable@vger.kernel.org
References: <20261111-nvme-tcp-live-ctrlrec-v2-0-6295202b84de@gmail.com>
 <20261111-nvme-tcp-live-ctrlrec-v2-3-6295202b84de@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261111-nvme-tcp-live-ctrlrec-v2-3-6295202b84de@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4DC7021E77
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email]
X-Spam-Score: -12.00
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_043230_009048_CB84092E 
X-CRM114-Status: GOOD (  35.92  )
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/11/26 9:42 PM, Martin Belanger via B4 Relay wrote:
> From: Martin Belanger <martin.belanger@dell.com>
> 
> A peer may send a TLS record without application data at any time
> after the handshake: a NewSessionTicket, a KeyUpdate or an alert.
> tls_sw_read_sock() cannot pass such a record to nvme_tcp_recv_skb().
> It returns -EINVAL and leaves the record at the head of the receive
> queue. nvme_tcp_try_recv() then starts error recovery, and the
> controller reconnects.
> 
> TLS 1.3 allows a server to send a NewSessionTicket at any time after
> the handshake (RFC 8446, section 4.6.1). Alerts can also arrive at any
> time.
> 
> On -EINVAL, read the record with recvmsg(), which reports the record
> type. Discard handshake messages other than KeyUpdate. Log alerts, and
> fail the queue on a fatal alert. Fail the queue on a KeyUpdate, which
> nvme-tcp cannot answer, and on any other record type. recvmsg() takes
> the socket lock, so release it around the read.
> 
> On a poll queue, nvme_tcp_poll() and nvme_tcp_io_work() can both see
> the record while the socket lock is released. A queue flag makes sure
> that only one of them reads it.
> 
> svc_tcp_recvfrom() in sunrpc handles -EINVAL from read_sock() the same
> way.
> 
> Fixes: be8e82caa685 ("nvme-tcp: enable TLS handshake upcall")
> Cc: stable@vger.kernel.org
> Signed-off-by: Martin Belanger <martin.belanger@dell.com>
> ---
>   drivers/nvme/host/tcp.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 94 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index c3bf345c4e92..cc6a46f118b2 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -123,6 +123,7 @@ enum nvme_tcp_queue_flags {
>   	NVME_TCP_Q_LIVE		= 1,
>   	NVME_TCP_Q_POLLING	= 2,
>   	NVME_TCP_Q_IO_CPU_SET	= 3,
> +	NVME_TCP_Q_TLS_RECORD	= 4,
>   };
>   
>   #define NVME_TCP_OPT_NR_QUEUES(opts) ((opts)->nr_io_queues + \
> @@ -1450,6 +1451,8 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
>   	return ret;
>   }
>   
> +static int nvme_tcp_recv_tls_record(struct nvme_tcp_queue *queue);
> +
>   static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
>   {
>   	struct socket *sock = queue->sock;
> @@ -1462,10 +1465,31 @@ static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
>   	lock_sock(sk);
>   	queue->nr_cqe = 0;
>   	consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
> +	/*
> +	 * kTLS cannot pass a TLS record without application data to
> +	 * nvme_tcp_recv_skb(). It returns -EINVAL and leaves the record at
> +	 * the head of the receive queue. recvmsg() takes the socket lock,
> +	 * so read the record without it.
> +	 */
> +	if (unlikely(consumed == -EINVAL && nvme_tcp_queue_tls(queue) &&
> +		     queue->rd_enabled)) {
> +		/*
> +		 * On a poll queue, nvme_tcp_poll() and nvme_tcp_io_work() can
> +		 * both get here for the same record. Only one of them reads it.
> +		 */
> +		if (test_and_set_bit(NVME_TCP_Q_TLS_RECORD, &queue->flags)) {
> +			consumed = 0;
> +		} else {
> +			release_sock(sk);
> +			consumed = nvme_tcp_recv_tls_record(queue);
> +			lock_sock(sk);
> +			clear_bit(NVME_TCP_Q_TLS_RECORD, &queue->flags);
> +		}
> +	}
>   	/*
>   	 * nvme_tcp_recv_skb() handles its own errors, so a queue that is
> -	 * still enabled failed inside read_sock(). Handle it before
> -	 * release_sock() processes the backlog.
> +	 * still enabled failed inside read_sock() or while reading a TLS
> +	 * record. Handle it before release_sock() processes the backlog.
>   	 */
>   	if (unlikely(consumed < 0 && consumed != -EAGAIN &&
>   		     queue->rd_enabled)) {
> @@ -1665,6 +1689,74 @@ static int nvme_tcp_drain_tls_record(struct nvme_tcp_queue *queue,
>   	return drained;
>   }
>   
> +/*
> + * Read the TLS record that read_sock() could not pass to
> + * nvme_tcp_recv_skb(). The caller must not hold the socket lock.
> + *
> + * A KeyUpdate needs new keys that nothing here can supply. Other handshake
> + * messages, such as a NewSessionTicket, are discarded.
> + *
> + * Returns the bytes consumed, or a negative errno if the connection cannot
> + * continue.
> + */
> +static int nvme_tcp_recv_tls_record(struct nvme_tcp_queue *queue)
> +{
> +	u8 buf[NVME_TCP_TLS_REC_CHUNK];
> +	union nvme_tcp_tls_cmsg u = {};
> +	struct kvec iov = {
> +		.iov_base = buf,
> +		.iov_len = sizeof(buf),
> +	};
> +	struct msghdr msg = {
> +		.msg_control = &u,
> +		.msg_controllen = sizeof(u),
> +	};
> +	int len, ret;
> +	u8 ctype;
> +
> +	len = kernel_recvmsg(queue->sock, &msg, &iov, 1, sizeof(buf),
> +			     MSG_DONTWAIT);
> +	if (len <= 0)
> +		goto fail;
> +
> +	ctype = tls_get_record_type(queue->sock->sk, &u.cmsg);
> +	switch (ctype) {
> +	case TLS_RECORD_TYPE_HANDSHAKE:
> +		if (buf[0] == TLS_HANDSHAKE_KEYUPDATE) {
> +			dev_err(queue->ctrl->ctrl.device,
> +				"queue %d: peer sent a TLS KeyUpdate, which is not supported\n",

A bit awkward; maybe 'TLS KeyUpdate is not supported'?

> +				nvme_tcp_queue_id(queue));
> +			return -EKEYEXPIRED;
> +		}
> +		break;
> +	case TLS_RECORD_TYPE_ALERT:
> +		ret = nvme_tcp_recv_tls_alert(queue, &msg, len);
> +		if (ret)
> +			return ret;
> +		break;
> +	default:
> +		dev_err(queue->ctrl->ctrl.device,
> +			"queue %d: unexpected TLS record %u\n",
> +			nvme_tcp_queue_id(queue), ctype);
> +		return -EPROTO;
> +	}
> +
> +	ret = nvme_tcp_drain_tls_record(queue, &msg, MSG_DONTWAIT);

Hmm. Doesn't this assume that the KeyUpdate is always the first record?
And we do have similar logic in nvme_tcp_skip_tls_record(); can't we
merge both (ie just call nvme_tcp_drain_tls_record(), and drop
this switch statement?

> +	if (ret < 0) {
> +		len = ret;
> +		goto fail;
> +	}
> +
> +	return len + ret;
> +
> +fail:
> +	/* read_sock() left a whole record, so none of it can be missing */
> +	if (len == -EAGAIN)
> +		return -EPROTO;
> +
> +	return len ? : -ECONNRESET;
> +}
> +
>   /*
>    * Discard a TLS record that arrived in place of the ICResp. A peer may send
>    * a NewSessionTicket as soon as the handshake completes.
> 

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

