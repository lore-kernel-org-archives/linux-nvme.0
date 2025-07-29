Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C025C87FCE
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jul 2025 15:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DwdTTHdeOVI0z++8NUCczywVnQjEIDhs65XxyQb9Kfc=; b=wwobSl72UwbBVAYiDeqU67ruOH
	1nsOUmSFDQkwdpUh//wrTEb4Is8SOO3ok9ORV9tNiVDP/viJvuHm9gLG3OLqTH471EgfbnCDxQZSZ
	C6Z0RaVGm/2W9hwlO0NNAyiPQmHrFebf05S1O36UMxEFrcWMnZxj+pYXK671k/sGiY/Y42MiRe1ht
	6vzSZWyeRcwR553mTNnDzaONAlSA+9tUUZsHF3fR2Qc26rKd+qT31WKTzQ1474ruZ5wWIiB8y/yGe
	QaQLo/pcly+Ow4Y3JFZYIbzhkKTY1jfKJvRz+FWBOUF6cNhtRW656hUSwYSeYdU2/xbXOtEktbsgA
	4hkAVzaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uh94U-00000001sWW-3hrW;
	Wed, 30 Jul 2025 15:50:26 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugfVz-0000000GEWZ-2JrK
	for linux-nvme@lists.infradead.org;
	Tue, 29 Jul 2025 08:16:52 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F3F17219EE;
	Tue, 29 Jul 2025 08:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753777010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DwdTTHdeOVI0z++8NUCczywVnQjEIDhs65XxyQb9Kfc=;
	b=ENbrR8y0h9sYQ9VqCDBKwiY+mwKM4c9w5COpbioJtplUI+4cGemJvvVj/9muB4CulQiF3i
	BGJnajQxSRvlfjO2kd0LfezZN7Vn3iiyd395694j9lP6Ifh5UawBWhqZ6OZYw2UqvxoLNH
	zmvUUQKnZkkFUT7zK8e7oDF1JfRJBMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753777010;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DwdTTHdeOVI0z++8NUCczywVnQjEIDhs65XxyQb9Kfc=;
	b=r8qxkebHUBSbmI/LyFKMwOeB7QlHIAM8pA+/l55u5AeTFIExFe9Wnz/vd62cpB9vgjHW+e
	o4KA/rY5jOvrQsBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iTaV1cmq;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4+Bzf8c4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753777009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DwdTTHdeOVI0z++8NUCczywVnQjEIDhs65XxyQb9Kfc=;
	b=iTaV1cmqqBGDrMYnlAI1K3KQa47nelnskJQ2pHt0cGSPGd8bjuLUEMan7BTBuJWopIlEQM
	ocyneezXYvP1lFDYKzHtspkcxYKqU4UtKt2LovCEWIZ4rp4FweeRCsBwIG+jQvHOpuV5Dq
	ExdcozV81Blcnh/LBidfzKzwjhPdXfo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753777009;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DwdTTHdeOVI0z++8NUCczywVnQjEIDhs65XxyQb9Kfc=;
	b=4+Bzf8c4476+e9thuIX+OaX5NFXgGffWpsXoU+yjkXaK5qYtkoexCTbDp3LWN1vIW+3bxH
	tz6dgX9UkwnqYYBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 51F9113876;
	Tue, 29 Jul 2025 08:16:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AmvkEnCDiGhKNwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 29 Jul 2025 08:16:48 +0000
Message-ID: <3339e2d0-02ac-470a-9511-0e60ed1d0598@suse.de>
Date: Tue, 29 Jul 2025 10:16:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 4/4] nvme/target/tcp: set max record size in the tls context
To: Wilfred Mallawa <wilfred.opensource@gmail.com>, alistair.francis@wdc.com,
 dlemoal@kernel.org, chuck.lever@oracle.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 donald.hunter@gmail.com, corbet@lwn.net, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de, sagi@grimberg.me, kch@nvidia.com, borisp@nvidia.com,
 john.fastabend@gmail.com, jlayton@kernel.org, neil@brown.name,
 okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org,
 anna@kernel.org, kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
References: <20250729024150.222513-2-wilfred.opensource@gmail.com>
 <20250729024150.222513-7-wilfred.opensource@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250729024150.222513-7-wilfred.opensource@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,wdc.com,kernel.org,oracle.com,davemloft.net,google.com,redhat.com,lwn.net,kernel.dk,lst.de,grimberg.me,nvidia.com,brown.name,talpey.com,lists.linux.dev,vger.kernel.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	R_RATELIMIT(0.00)[to_ip_from(RLhu34id7c3duw89qhx7eswje4)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,wdc.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: F3F17219EE
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250729_011651_743682_A0DC23E4 
X-CRM114-Status: GOOD (  20.08  )
X-Mailman-Approved-At: Wed, 30 Jul 2025 08:35:22 -0700
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

On 7/29/25 04:41, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> During a tls handshake, a host may specify the tls record size limit
> using the tls "record_size_limit" extension. Currently, the NVMe target
> driver does not specify this value to the tls layer.
> 
> This patch adds support for setting the tls record size limit into the
> tls context, such that outgoing records may not exceed this limit
> specified by the endpoint.
> 
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> ---
>   drivers/nvme/target/tcp.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 60e308401a54..f2ab473ea5de 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1784,6 +1784,7 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
>   					size_t tls_record_size_limit)
>   {
>   	struct nvmet_tcp_queue *queue = data;
> +	struct tls_context *tls_ctx = tls_get_ctx(queue->sock->sk);
>   
>   	pr_debug("queue %d: TLS handshake done, key %x, status %d\n",
>   		 queue->idx, peerid, status);
> @@ -1795,6 +1796,17 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
>   	if (!status) {
>   		queue->tls_pskid = peerid;
>   		queue->state = NVMET_TCP_Q_CONNECTING;
> +
> +		/* Endpoint has specified a maximum tls record size limit */
> +		if (tls_record_size_limit > TLS_MAX_PAYLOAD_SIZE) {
> +			pr_err("queue %d: invalid tls max record size limit: %zu\n",
> +			       queue->idx, tls_record_size_limit);
> +			queue->state = NVMET_TCP_Q_FAILED;
> +		} else if (tls_record_size_limit > 0) {
> +			tls_ctx->tls_record_size_limit = (u32)tls_record_size_limit;
> +			pr_debug("queue %d: host specified tls max record size %u\n",
> +				 queue->idx, tls_ctx->tls_record_size_limit);
> +		}
>   	} else
>   		queue->state = NVMET_TCP_Q_FAILED;
>   	spin_unlock_bh(&queue->state_lock);
> @@ -1808,6 +1820,7 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
>   		nvmet_tcp_schedule_release_queue(queue);
>   	else
>   		nvmet_tcp_set_queue_sock(queue);
> +
>   	kref_put(&queue->kref, nvmet_tcp_release_queue);
>   }
>   
Again, why?

I'd rather have the TLS layer handling that internally.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

