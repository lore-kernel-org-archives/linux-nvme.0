Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC26C83F17
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Jul 2025 06:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m5peT/4DC5+FF+PRDRM8Nv2vvrMLTiYqMPlHl4IV5MQ=; b=RwsRI8t1JcvVLzgo+1QCcU3eS6
	llLwnH6wNkptuj9UcQjfa4NUX25eumDiYesl73c670DW15dg1hskVyOchsO1HK4MNhWglVJrWY02G
	ca9PWmNB7ymNR72x2Aqcy5rPgaA75CURp6CybteHPepDQiO5IxtrxPgMJOMbCkH9FaT7eKMhxxj1o
	isQbXJd3C+m+pPHVQ8qHXRThnNdQ6fyTUaJIMsrZC+2eeQ1WQx6SgO7nW9MR9qQzA3OQB1sXp4ZoL
	1HoGyKA08bfsycTzYGjDA3fB3ug91HmUd52Kgid6z5dhGTm8sQwRj2cbLXxg526vsb2x8F1EIG5YK
	NSQshHAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhMUf-00000002y7J-1C4o;
	Thu, 31 Jul 2025 06:10:21 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhMUd-00000002y6t-0l58
	for linux-nvme@lists.infradead.org;
	Thu, 31 Jul 2025 06:10:20 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DB99C1F814;
	Thu, 31 Jul 2025 06:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753942216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m5peT/4DC5+FF+PRDRM8Nv2vvrMLTiYqMPlHl4IV5MQ=;
	b=Gp3um7CtjeP/h5EH4NLe08AkG0m9fH7Hfkn9c2T/2KaW/B8469SbtU/M2fXGxsg6xbdYyB
	xNl0paq+gaf6GPUsZ33Wv0mJoU4oMdPYgIjyKKosn0U/L+XAevwi6eOxBwPu6Mb7rHZ+Me
	oIOSFRTo+qxZ4Ao8WrD289o90MZYdNk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753942216;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m5peT/4DC5+FF+PRDRM8Nv2vvrMLTiYqMPlHl4IV5MQ=;
	b=yU2k1JZ2h00mrWST2iuYtMPnhYtqA0nM8iR8LLxOR151tm+3plMzLxXU3ASoz1kfZIgv2D
	XJWMcXN+qL7St3BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753942215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m5peT/4DC5+FF+PRDRM8Nv2vvrMLTiYqMPlHl4IV5MQ=;
	b=ganIxKE39h1A9vjag2QEdleK9lxcMk1koDFT1S2QaUr2hn9Sjjp7iVhbzWLM0M2zzOHRNH
	Bg4Mm0XkEfT4hoaTxKnFSfwSusYjVL1FG0wTmhKZVdq5wR4abIwfJBmugKb8GoTwLh/R9h
	fgVX9B742Mxl0ITo16l6mk0gQ89siD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753942215;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m5peT/4DC5+FF+PRDRM8Nv2vvrMLTiYqMPlHl4IV5MQ=;
	b=ev530m5zITR+U4Of4GaFtzLkpzqwQ1mDJLiBybZEj3nosrqHZu7zh7X4YCL7pFKHGKa/j+
	KQPvnXQKrw5ZfvAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 505F113A43;
	Thu, 31 Jul 2025 06:10:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id W8viEccIi2hkWAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 31 Jul 2025 06:10:15 +0000
Message-ID: <cdeb5e12-5c61-4a95-8e31-c56a3a90d6a3@suse.de>
Date: Thu, 31 Jul 2025 08:10:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] nvmet-tcp: fix handling of tls alerts
To: Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com,
 jlayton@kernel.org, trondmy@hammerspace.com, anna.schumaker@oracle.com,
 hch@lst.de, sagi@grimberg.me, kch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: linux-nfs@vger.kernel.org, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev,
 neil@brown.name, Dai.Ngo@oracle.com, tom@talpey.com, horms@kernel.org,
 kbusch@kernel.org
References: <20250730200835.80605-1-okorniev@redhat.com>
 <20250730200835.80605-4-okorniev@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250730200835.80605-4-okorniev@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250730_231019_376645_787910E5 
X-CRM114-Status: GOOD (  24.59  )
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

On 7/30/25 22:08, Olga Kornievskaia wrote:
> Revert kvec msg iterator before trying to process a TLS alert
> when possible.
> 
> In nvmet_tcp_try_recv_data(), it's assumed that no msg control
> message buffer is set prior to sock_recvmsg(). Hannes suggested
> that upon detecting that TLS control message is received log a
> message and error out. Left comments in the code for the future
> improvements.
> 
> Fixes: a1c5dd8355b1 ("nvmet-tcp: control messages for recvmsg()")
> Suggested-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Hannes Reinecky <hare@susu.de>
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> ---
>   drivers/nvme/target/tcp.c | 30 +++++++++++++++++++-----------
>   1 file changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 688033b88d38..055e420d3f2e 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1161,6 +1161,7 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
>   	if (unlikely(len < 0))
>   		return len;
>   	if (queue->tls_pskid) {
> +		iov_iter_revert(&msg.msg_iter, len);
>   		ret = nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
>   		if (ret < 0)
>   			return ret;
> @@ -1217,19 +1218,28 @@ static void nvmet_tcp_prep_recv_ddgst(struct nvmet_tcp_cmd *cmd)
>   static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
>   {
>   	struct nvmet_tcp_cmd  *cmd = queue->cmd;
> -	int len, ret;
> +	int len;
>   
>   	while (msg_data_left(&cmd->recv_msg)) {
> +		/* to detect that we received a TlS alert, we assumed that
> +		 * cmg->recv_msg's control buffer is not setup. kTLS will
> +		 * return an error when no control buffer is set and
> +		 * non-tls-data payload is received.
> +		 */
>   		len = sock_recvmsg(cmd->queue->sock, &cmd->recv_msg,
>   			cmd->recv_msg.msg_flags);
> +		if (cmd->recv_msg.msg_flags & MSG_CTRUNC) {
> +			if (len == 0 || len == -EIO) {
> +				pr_err("queue %d: unhandled control message\n",
> +				       queue->idx);
> +				/* note that unconsumed TLS control message such
> +				 * as TLS alert is still on the socket.
> +				 */

Hmm. Will it get cleared when we close the socket?
Or shouldn't we rather introduce proper cmsg handling?
(If we do, we'll need it to do on the host side, too)

> +				return -EAGAIN;
> +			}
> +		}
>   		if (len <= 0)
>   			return len;
> -		if (queue->tls_pskid) {
> -			ret = nvmet_tcp_tls_record_ok(cmd->queue,
> -					&cmd->recv_msg, cmd->recv_cbuf);
> -			if (ret < 0)
> -				return ret;
> -		}
>   
>   		cmd->pdu_recv += len;
>   		cmd->rbytes_done += len;
> @@ -1267,6 +1277,7 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
>   	if (unlikely(len < 0))
>   		return len;
>   	if (queue->tls_pskid) {
> +		iov_iter_revert(&msg.msg_iter, len);
>   		ret = nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
>   		if (ret < 0)
>   			return ret;
> @@ -1453,10 +1464,6 @@ static int nvmet_tcp_alloc_cmd(struct nvmet_tcp_queue *queue,
>   	if (!c->r2t_pdu)
>   		goto out_free_data;
>   
> -	if (queue->state == NVMET_TCP_Q_TLS_HANDSHAKE) {
> -		c->recv_msg.msg_control = c->recv_cbuf;
> -		c->recv_msg.msg_controllen = sizeof(c->recv_cbuf);
> -	}

As you delete this you can also remove the definition of 'recv_msg'
from nvmet_tcp_cmd structure.

>   	c->recv_msg.msg_flags = MSG_DONTWAIT | MSG_NOSIGNAL;
>   
>   	list_add_tail(&c->entry, &queue->free_list);
> @@ -1736,6 +1743,7 @@ static int nvmet_tcp_try_peek_pdu(struct nvmet_tcp_queue *queue)
>   		return len;
>   	}
>   
> +	iov_iter_revert(&msg.msg_iter, len);
>   	ret = nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
>   	if (ret < 0)
>   		return ret;

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

