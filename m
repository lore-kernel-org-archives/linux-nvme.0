Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A804DC0015E
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Jul 2023 13:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r7AigSJzBSopcbILkG5FSFyMZFmYvz0/D2O0fag+1Bw=; b=d3nCXmHbBd9TFi9RUFPXgv/GcO
	zyhEvgclzCeabe7eKhSYtwP1Q6h1ZmLpW7vWuhzjb3HT3mYrI2wg5nfETjVHGwZtJPWGpJHqJamEA
	Si27/xw/GKQrpGrq1Ux5+ZH/vwIBw41X3kfQZj61D9dQIDjGyJP7YRCl3PUyyNGd6dRZhwQ4XeWDy
	LF7f73u4Cd1kmTfslsgYL+B/OhCPB2b7kjVXqu/qBcQLVwJ+xdqKJmfXfkQ8x+TMTCDWwsEfaiO70
	oJb3ToJo4JscmknRz8YLL/WujKN/Ja7EM5D6w5qspDEForJYJx2CtzHfYsgzWgftAZu847fd2peTN
	P5UI/NEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qMqZI-00ECGF-29;
	Fri, 21 Jul 2023 13:53:16 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qMqZF-00ECFa-29
	for linux-nvme@lists.infradead.org;
	Fri, 21 Jul 2023 13:53:15 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2F8FA218A2;
	Fri, 21 Jul 2023 13:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1689947586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r7AigSJzBSopcbILkG5FSFyMZFmYvz0/D2O0fag+1Bw=;
	b=CI2tpv+YQZ3jgwWfoJM0uUH3jnABrgVldeQCbNJ4wyoUkhrM9Ps+sYtG6JYaiPb2YzbB3o
	NV6BvJu1DMny5Y2+ZW1Ig1z4MKd/WHz3l4rHNH1fv4ViRzXobyjAqhlefDPPPN2bQcw2y8
	iflQ7AUfo9oEzieTEC1jbnm16SQ3cSs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1689947586;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r7AigSJzBSopcbILkG5FSFyMZFmYvz0/D2O0fag+1Bw=;
	b=COnD9RE23tWhG0x1VWGrZ9H/kSEz+ejTwNaZ5xjYTjzNZ3Qi1qsGhpye4H5ViAIsEcpnzb
	zDUzTS11nsDHd5BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D8733134B0;
	Fri, 21 Jul 2023 13:53:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id MKElNMGNumTleQAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 21 Jul 2023 13:53:05 +0000
Message-ID: <a3184117-751a-c582-6295-f45a26398deb@suse.de>
Date: Fri, 21 Jul 2023 15:53:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 6/6] net/tls: implement ->read_sock()
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Boris Pismenny <boris.pismenny@gmail.com>
References: <20230719113836.68859-1-hare@suse.de>
 <20230719113836.68859-7-hare@suse.de> <20230720200216.4bf1bf4b@kernel.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230720200216.4bf1bf4b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230721_065313_870257_0E759610 
X-CRM114-Status: GOOD (  23.75  )
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

On 7/21/23 05:02, Jakub Kicinski wrote:
> On Wed, 19 Jul 2023 13:38:36 +0200 Hannes Reinecke wrote:
>> Implement ->read_sock() function for use with nvme-tcp.
> 
>> +int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
>> +		     sk_read_actor_t read_actor)
>> +{
>> +	struct tls_context *tls_ctx = tls_get_ctx(sk);
>> +	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
>> +	struct strp_msg *rxm = NULL;
>> +	struct tls_msg *tlm;
>> +	struct sk_buff *skb;
>> +	struct sk_psock *psock;
>> +	ssize_t copied = 0;
>> +	bool bpf_strp_enabled;
> 
> bubble up the longer lines, like this:
> 
> +	struct tls_context *tls_ctx = tls_get_ctx(sk);
> +	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
> +	struct strp_msg *rxm = NULL;
> +	struct sk_psock *psock;
> +	bool bpf_strp_enabled;
> +	struct tls_msg *tlm;
> +	struct sk_buff *skb;
> +	ssize_t copied = 0;
> +	int err, used;
> 
Ok.

>> +	int err, used;
>> +
>> +	psock = sk_psock_get(sk);
>> +	err = tls_rx_reader_acquire(sk, ctx, true);
>> +	if (err < 0)
>> +		goto psock_put;
>> +	bpf_strp_enabled = sk_psock_strp_enabled(psock);
> 
> You're not servicing the BPF out of band queue, just error out if
> the BPF psock is enabled. It's barely used and endlessly buggy anyway.
> 
Have been wondering about that; will do.

>> +	/* If crypto failed the connection is broken */
>> +	err = ctx->async_wait.err;
>> +	if (err)
>> +		goto read_sock_end;
>> +
>> +	do {
>> +		if (!skb_queue_empty(&ctx->rx_list)) {
>> +			skb = __skb_dequeue(&ctx->rx_list);
>> +			rxm = strp_msg(skb);
>> +		} else {
>> +			struct tls_decrypt_arg darg;
>> +
>> +			err = tls_rx_rec_wait(sk, psock, true, true);
>> +			if (err <= 0)
>> +				goto read_sock_end;
>> +
>> +			memset(&darg.inargs, 0, sizeof(darg.inargs));
>> +			darg.zc = !bpf_strp_enabled && ctx->zc_capable;
> 
> And what are you zero-copying into my friend? zc == zero copy.
> Leave the zc be 0, like splice does, otherwise passing msg=NULL
> to tls_rx_one_record() may explode. Testing with TLS 1.2 should
> show that.
> 
Still beginning to learn how the stream parser works.
(And have been wondering about the 'msg == NULL' case, too).
Will fix it.

>> +			rxm = strp_msg(tls_strp_msg(ctx));
>> +			tlm = tls_msg(tls_strp_msg(ctx));
>> +
>> +			/* read_sock does not support reading control messages */
>> +			if (tlm->control != TLS_RECORD_TYPE_DATA) {
>> +				err = -EINVAL;
>> +				goto read_sock_requeue;
>> +			}
>> +
>> +			if (!bpf_strp_enabled)
>> +				darg.async = ctx->async_capable;
>> +			else
>> +				darg.async = false;
> 
> Also don't bother with async. TLS 1.3 can't do async, anyway,
> and I don't think you wait for the completion :S
> 
Ok.

>> +			err = tls_rx_one_record(sk, NULL, &darg);
>> +			if (err < 0) {
>> +				tls_err_abort(sk, -EBADMSG);
>> +				goto read_sock_end;
>> +			}
>> +
>> +			sk_flush_backlog(sk);
> 
> Hm, could be a bit often but okay.
> 
When would you suggest to do it?
(Do I need to do it at all?)

>> +			skb = darg.skb;
>> +			rxm = strp_msg(skb);
>> +
>> +			tls_rx_rec_done(ctx);
>> +		}
>> +
>> +		used = read_actor(desc, skb, rxm->offset, rxm->full_len);
>> +		if (used <= 0) {
>> +			if (!copied)
>> +				err = used;
>> +			goto read_sock_end;
> 
> You have to requeue on error.
> 
Ah, right. Did it in the previous version, but somehow got
lost here.

Will be fixing it up.

>> +		}
>> +		copied += used;
>> +		if (used < rxm->full_len) {
>> +			rxm->offset += used;
>> +			rxm->full_len -= used;
>> +			if (!desc->count)
>> +				goto read_sock_requeue;
> 
> And here. Like splice_read does. Otherwise you leak the skb.
> 
Will do.

Thanks for the review!

Cheers,

Hannes



