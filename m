Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD94CAC5B0
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Oct 2025 05:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QbTdrNWNk7FaUtNBwf9W4q3p4EZ63J3H9dHdEMD1rVQ=; b=IRyZODh8bRj4xH3gzDbcQ+5nEk
	afCKmVbE6TuyqEoRgc2qoUo6qZaYESiPcgcEOdfgFpLz2URO/dJsHe12YjsSaG09idctJs0qWq1rz
	jUatFgjA0kuwyLFy1sx/LfPsxdHZYIkG47X6N4nQyteRPAhw2npzXbTlJ7ysP6ZzQbmH24bG/pMjm
	PnOEg4m0jgY/ojGfj7/g9a7h2mVPnS7PW/tqGy35aIrlU9btIa1MZuf5ZEKaXuQF1W5ydm7koZhlI
	/eqOHo7mK/SnXCdIgBDLtZZMSaO3ky21VgHpJWcOClExCfalMlMr/U1mEUBNZIEX8ifdqvQIg0Y3z
	yUdLCLXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v606t-00000001HNk-1OhJ;
	Tue, 07 Oct 2025 05:19:39 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v606q-00000001HNL-1h7M
	for linux-nvme@lists.infradead.org;
	Tue, 07 Oct 2025 05:19:37 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DB44033777;
	Tue,  7 Oct 2025 05:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759814374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QbTdrNWNk7FaUtNBwf9W4q3p4EZ63J3H9dHdEMD1rVQ=;
	b=jjqnFoXXPw1E6Os6S1erCCVqKzQNmZw1qEGgXZKQ27JlSMh3KBU9ho5jKZD3h5Gaejy7KY
	DOLsfDqL5CxD5ADGkByIMbTTLv5dHKO6WxQdsdCz/Jbt+FhPu7qHCXpAXIBBfVSuV60ngD
	DRu8Yiopy5K8YnrQLm1j6iYT7JapBVw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759814374;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QbTdrNWNk7FaUtNBwf9W4q3p4EZ63J3H9dHdEMD1rVQ=;
	b=JkWzDtG7IM2t2Z2wmEoIuMYoGxhrTuszeMJlrbmR81MuvBAX+kjd6E1hAO10wDD0lRM2w+
	e3dZk6teusVoa8DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759814373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QbTdrNWNk7FaUtNBwf9W4q3p4EZ63J3H9dHdEMD1rVQ=;
	b=VcUSFJBXBNLO8mG8u17LzSDk+qoUvNwT4odR8HXmWFN8kgABj9ZLneF/D7tq/jmm1m+WR4
	mRn/Pd8zm8aMrYolBSCLdvk7gaS8DYk88Smdvqsf8r03BnIDeuooVy8vVAKGMFjSkjYf2F
	3BpKg2yJDanLNUDNLFTjDq0/7C/qYW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759814373;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QbTdrNWNk7FaUtNBwf9W4q3p4EZ63J3H9dHdEMD1rVQ=;
	b=LMBtUVYWcvehjTsZT8b+pJXv5KzPvrAqitgDGM3MTcnlgCJHw47pqG6Hv6Y1tXrvsH5EEV
	KbDoCMy2DvsO1IBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5EBBE13693;
	Tue,  7 Oct 2025 05:19:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ABR5FeWi5Gg0BQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 07 Oct 2025 05:19:33 +0000
Message-ID: <0bf649d5-112f-42a8-bc8d-6ef2199ed19d@suse.de>
Date: Tue, 7 Oct 2025 07:19:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme/tcp: handle tls partially sent records in
 write_space()
To: Wilfred Mallawa <wilfred.opensource@gmail.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Sabrina Dubroca <sd@queasysnail.net>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
References: <20251007004634.38716-2-wilfred.opensource@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251007004634.38716-2-wilfred.opensource@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,lst.de,grimberg.me,gmail.com,queasysnail.net,davemloft.net,google.com,redhat.com,wdc.com];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org,vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251006_221936_606545_515BEA4B 
X-CRM114-Status: GOOD (  27.37  )
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

On 10/7/25 02:46, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> With TLS enabled, records that are encrypted and appended to TLS TX
> list can fail to see a retry if the underlying TCP socket is busy, for
> example, hitting an EAGAIN from tcp_sendmsg_locked(). This is not known
> to the NVMe TCP driver, as the TLS layer successfully generated a record.
> 
> Typically, the TLS write_space() callback would ensure such records are
> retried, but in the NVMe TCP Host driver, write_space() invokes
> nvme_tcp_write_space(). This causes a partially sent record in the TLS TX
> list to timeout after not being retried.
> 
> This patch aims to address the above by first publically exposing
> tls_is_partially_sent_record(), then, using this in the NVMe TCP host
> driver to invoke the TLS write_space() handler where appropriate.
> 
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> Fixes: be8e82caa685 ("nvme-tcp: enable TLS handshake upcall")
> ---
>   drivers/nvme/host/tcp.c | 8 ++++++++
>   include/net/tls.h       | 5 +++++
>   net/tls/tls.h           | 5 -----
>   3 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 1413788ca7d5..e3d02c33243b 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1076,11 +1076,18 @@ static void nvme_tcp_data_ready(struct sock *sk)
>   static void nvme_tcp_write_space(struct sock *sk)
>   {
>   	struct nvme_tcp_queue *queue;
> +	struct tls_context *ctx = tls_get_ctx(sk);
>   
>   	read_lock_bh(&sk->sk_callback_lock);
>   	queue = sk->sk_user_data;
> +
>   	if (likely(queue && sk_stream_is_writeable(sk))) {
>   		clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
> +		/* Ensure pending TLS partial records are retried */
> +		if (nvme_tcp_queue_tls(queue) &&
> +		    tls_is_partially_sent_record(ctx))
> +			queue->write_space(sk);
> +
>   		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
>   	}
>   	read_unlock_bh(&sk->sk_callback_lock);

I wonder: Do we really need to check for a partially assembled record,
or wouldn't it be easier to call queue->write_space() every time here?
We sure would end up with executing the callback more often, but if no
data is present it shouldn't do any harm.

IE just use

if (nvme_tcp_queue_tls(queue)
     queue->write_space(sk);

> @@ -1306,6 +1313,7 @@ static int nvme_tcp_try_send_ddgst(struct nvme_tcp_request *req)
>   static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
>   {
>   	struct nvme_tcp_request *req;
> +	struct tls_context *ctx = tls_get_ctx(queue->sock->sk);
>   	unsigned int noreclaim_flag;
>   	int ret = 1;
>   And we need this why?

> diff --git a/include/net/tls.h b/include/net/tls.h
> index 857340338b69..9c61a2de44bf 100644
> --- a/include/net/tls.h
> +++ b/include/net/tls.h
> @@ -373,6 +373,11 @@ static inline struct tls_context *tls_get_ctx(const struct sock *sk)
>   	return (__force void *)icsk->icsk_ulp_data;
>   }
>   
> +static inline bool tls_is_partially_sent_record(struct tls_context *ctx)
> +{
> +	return !!ctx->partially_sent_record;
> +}
> +
>   static inline struct tls_sw_context_rx *tls_sw_ctx_rx(
>   		const struct tls_context *tls_ctx)
>   {
> diff --git a/net/tls/tls.h b/net/tls/tls.h
> index 2f86baeb71fc..7839a2effe31 100644
> --- a/net/tls/tls.h
> +++ b/net/tls/tls.h
> @@ -271,11 +271,6 @@ int tls_push_partial_record(struct sock *sk, struct tls_context *ctx,
>   			    int flags);
>   void tls_free_partial_record(struct sock *sk, struct tls_context *ctx);
>   
> -static inline bool tls_is_partially_sent_record(struct tls_context *ctx)
> -{
> -	return !!ctx->partially_sent_record;
> -}
> -
>   static inline bool tls_is_pending_open_record(struct tls_context *tls_ctx)
>   {
>   	return tls_ctx->pending_open_record_frags;
See above. If we were calling ->write_space unconditionally we 
wouldn'teven need this export.Cheers,Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

