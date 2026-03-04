Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FA2EDEC1E
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2026 07:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hx6QBAZ/g48FrY3KwtZ+m4mLgleN1Z8nKszuKUbXlAA=; b=1NANP4zaySb2tb4WPyH+553uYl
	XbbyeJ4kxQpEN3w3lTxdWxfZCI6XU4ho3vfecLxm90UvkjslMY5eBo81RhKxQ0JZVSBN4SjO/Lzmr
	+XnvU73b+ai6YoHk3pd8BlgWYyn8ykTEKwZe0ISg8V99a7pT4f72vWiCyyjcAiwhazGhAezdnUeH7
	xaBTSkkQ/oBMBL9209u9S5LapiczlndgEAvI60hv2Y1ChGW896Ycm8JhJixP2hbtbppoKdqU6c6K5
	EgC4/VBcFV71U//GcYV/PP+a9CuwPdu3ww4lI1ofWwAYMnERt77ueA9bVsWQb98Y74RPjuCa3zLY5
	twNaG7zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxgq1-0000000GdAb-2Rg0;
	Wed, 04 Mar 2026 07:40:09 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxgpz-0000000Gd8x-00eD
	for linux-nvme@lists.infradead.org;
	Wed, 04 Mar 2026 07:40:08 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F3AA13F778;
	Wed,  4 Mar 2026 07:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772610004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hx6QBAZ/g48FrY3KwtZ+m4mLgleN1Z8nKszuKUbXlAA=;
	b=E6vGClwNDLUB3Nt39zL+Uv4g1EKF3tgURy5iNvMD+VJarmFyYTHzOFjvUMo6scb5TIqdJK
	iy599/BxOghpLpRIZ8sRdbl7kaS+jg9Mm4Lg5M9ibzncHs1KqFXu5BI5dQnk5LdP9vgSEU
	P5t7B9zcIzbSieTxh7iKt+5IhPtUvS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772610004;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hx6QBAZ/g48FrY3KwtZ+m4mLgleN1Z8nKszuKUbXlAA=;
	b=+nB8IvXRH00vrXkJdtdgl4/RhZYEQdVF1yhm1Gi4gfTza1Uq+1pq/Iwdv7DkR5NxYWC6qS
	pkQeJfnDaErPEuBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772610002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hx6QBAZ/g48FrY3KwtZ+m4mLgleN1Z8nKszuKUbXlAA=;
	b=geFxisl7YkRy/RMf7sQhkfF87QEmHXiE6wv3B9DQ8u8rO8C4RgLdwgNfxotkflNc0A1oiN
	sU4O9kj2lIb95pICnKkjyNYhKX9LuomKgsUbr94Ck1T//ofYkoxkZDAyPOoS1UN//mEIGB
	nGq0Tgzq3N3PHcXl1uDnZHTaCkUbhGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772610002;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hx6QBAZ/g48FrY3KwtZ+m4mLgleN1Z8nKszuKUbXlAA=;
	b=42wvlBEbt9zZEV1FWhsWg2TdimuiQ5+IIAlcFn92nVDxXbn0xY6zUvpMi4Vttjl5GHkeyI
	ifX1ghQc5aBpXbBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E2F733EA69;
	Wed,  4 Mar 2026 07:40:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ytg2MtDhp2kWWgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 04 Mar 2026 07:40:00 +0000
Message-ID: <103c958f-d5f9-47d3-9be8-dd7225368fd5@suse.de>
Date: Wed, 4 Mar 2026 08:40:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/5] nvme-tcp: Support KeyUpdate
To: alistair23@gmail.com, chuck.lever@oracle.com, hare@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, Alistair Francis <alistair.francis@wdc.com>
References: <20260304053500.590630-1-alistair.francis@wdc.com>
 <20260304053500.590630-5-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260304053500.590630-5-alistair.francis@wdc.com>
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
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_TO(0.00)[gmail.com,oracle.com,kernel.org,lists.linux.dev,vger.kernel.org,lists.infradead.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ietf.org:url,wdc.com:email,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260303_234007_188188_99FE830B 
X-CRM114-Status: GOOD (  32.32  )
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

On 3/4/26 06:34, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> If the nvme_tcp_try_send() or nvme_tcp_try_recv() functions return
> EKEYEXPIRED then the underlying TLS keys need to be updated. This occurs
> on an KeyUpdate event as described in RFC8446
> https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3.
> 
> If the NVMe Target (TLS server) initiates a KeyUpdate this patch will
> allow the NVMe layer to process the KeyUpdate request and forward the
> request to userspace. Userspace must then update the key to keep the
> connection alive.
> 
> This patch allows us to handle the NVMe target sending a KeyUpdate
> request without aborting the connection. At this time we don't support
> initiating a KeyUpdate.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v7:
>   - Use read_sock_cmsg instead of recvmsg() to handle KeyUpdate
> v6:
>   - Don't use `struct nvme_tcp_hdr` to determine TLS_HANDSHAKE_KEYUPDATE,
>     instead look at the cmsg fields.
>   - Don't flush async_event_work
> v5:
>   - Cleanup code flow
>   - Check for MSG_CTRUNC in the msg_flags return from recvmsg
>     and use that to determine if it's a control message
> v4:
>   - Remove all support for initiating KeyUpdate
>   - Don't call cancel_work() when updating keys
> v3:
>   - Don't cancel existing handshake requests
> v2:
>   - Don't change the state
>   - Use a helper function for KeyUpdates
>   - Continue sending in nvme_tcp_send_all() after a KeyUpdate
>   - Remove command message using recvmsg
> 
>   drivers/nvme/host/tcp.c | 59 ++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 8b6172dd1c0f..ade11d2ac9ef 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -171,6 +171,7 @@ struct nvme_tcp_queue {
>   	bool			tls_enabled;
>   	u32			rcv_crc;
>   	u32			snd_crc;
> +	key_serial_t		handshake_session_id;
>   	__le32			exp_ddgst;
>   	__le32			recv_ddgst;
>   	struct completion       tls_complete;
> @@ -1361,6 +1362,59 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
>   	return ret;
>   }
>   
> +static void update_tls_keys(struct nvme_tcp_queue *queue)
> +{
> +	int qid = nvme_tcp_queue_id(queue);
> +	int ret;
> +
> +	dev_dbg(queue->ctrl->ctrl.device,
> +		"updating key for queue %d\n", qid);
> +
> +	ret = nvme_tcp_start_tls(&(queue->ctrl->ctrl),
> +				 queue, queue->ctrl->ctrl.tls_pskid,
> +				 HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED);
> +
> +	if (ret < 0) {
> +		dev_err(queue->ctrl->ctrl.device,
> +			"failed to update the keys %d\n", ret);
> +		nvme_tcp_fail_request(queue->request);
> +	}
> +}
> +
> +static int nvme_tcp_recv_cmsg(read_descriptor_t *desc,
> +			      struct sk_buff *skb,
> +			      unsigned int offset, size_t len,
> +			      u8 content_type)
> +{
> +	struct nvme_tcp_queue *queue = desc->arg.data;
> +	struct socket *sock = queue->sock;
> +	struct sock *sk = sock->sk;
> +
> +	switch (content_type) {
> +	case TLS_RECORD_TYPE_HANDSHAKE:
> +		if (len == 5) {
> +			u8 header[5];
> +
> +			if (!skb_copy_bits(skb, offset, header,
> +					   sizeof(header))) {
> +				if (header[0] == TLS_HANDSHAKE_KEYUPDATE) {
> +					dev_err(queue->ctrl->ctrl.device, "KeyUpdate message\n");
> +					release_sock(sk);
> +					update_tls_keys(queue);
> +					lock_sock(sk);
> +					return 0;
> +				}
> +			}
> +		}
> +
> +		break;
> +	default:
> +		break;
> +	}

I think a simple 'if' condition would be sufficient here, or do you have
handling of other TLS record types queued somewhere?
And we should log unhandled TLS records.

> +
> +	return -EAGAIN;
> +}
> +
>   static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
>   {
>   	struct socket *sock = queue->sock;
> @@ -1372,7 +1426,8 @@ static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
>   	rd_desc.count = 1;
>   	lock_sock(sk);
>   	queue->nr_cqe = 0;
> -	consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
> +	consumed = sock->ops->read_sock_cmsg(sk, &rd_desc, nvme_tcp_recv_skb,
> +					     nvme_tcp_recv_cmsg);
>   	release_sock(sk);
>   	return consumed == -EAGAIN ? 0 : consumed;
>   }
> @@ -1708,6 +1763,7 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid,
>   			ctrl->ctrl.tls_pskid = key_serial(tls_key);
>   		key_put(tls_key);
>   		queue->tls_err = 0;
> +		queue->handshake_session_id = handshake_session_id;
>   	}
>   
>   out_complete:
> @@ -1737,6 +1793,7 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
>   		keyring = key_serial(nctrl->opts->keyring);
>   	args.ta_keyring = keyring;
>   	args.ta_timeout_ms = tls_handshake_timeout * 1000;
> +	args.ta_handshake_session_id = queue->handshake_session_id;
>   	queue->tls_err = -EOPNOTSUPP;
>   	init_completion(&queue->tls_complete);
>   	if (keyupdate == HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC)

Otherwise looks good.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

