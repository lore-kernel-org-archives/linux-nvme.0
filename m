Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F6FEB64DD
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Jul 2023 03:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K1jDQOS7z2fkCk3k6TiJFNYUNOKafASdhgxsLKZiyZg=; b=yXBqVp+2OhNb1PSeejwJ0m1g5C
	Nkixbv1ce2hLbj+JzVJeVH+pn6fM8v92mFtKr/mwRPZb6XnhRi/t9BOxASjbNtbOhbHRobvzavkb9
	UYEfLwtIY09PBORnSWf7AL502p/J/+lTpjfgB+N0dL8sJE5GOSy+STLoo7Vxoodqf4U5Yp3x1Ko0C
	aPMffR0pzvmTFOBR164y1qfvlgLFKc0mqLJ9uHKx0T8nxV326bbg4KaFZ2pqn9rB9pJkkVfAgKhds
	Jk95UzMYCaA6QvRwV8kQ5J84z2D8jj1LcJKZ7HuVdU2ObeY0gK3IIBvwDW8G5EkYEOpcFBscdRDOH
	33jUyYww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qMgPO-00Ch9e-2B;
	Fri, 21 Jul 2023 03:02:22 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qMgPL-00Ch6w-0z
	for linux-nvme@lists.infradead.org;
	Fri, 21 Jul 2023 03:02:20 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id BD15761CC8;
	Fri, 21 Jul 2023 03:02:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB334C433C8;
	Fri, 21 Jul 2023 03:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689908538;
	bh=iKUuOMZQqYBSqB9J+CgVXxUr5qGvS6AiXjXlER6cU8o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I/nfmOZEBdGC8dqweIX3zxGJbrQfeAcrU9OzsJEwnfb6i/ItjzEPP40QeqaztfXe7
	 NY0qJ4lVXlEfYF0JOyJOPtkAOZbweLE+hQa5zcUqOnXTlZKTlvkbm8NdPeyQ0m4p+W
	 Mq6kzBo74F0agoT6coPvoqCgQpGyU3z5rfu/IrwjkOPPHSvfbOkd6pRzc6P8mo68Ve
	 lvUrPjUB/ygEuGDgJEIADl04/keCYvBG8eStkhl2JVr0FpbYcji8BTGLowxfvsVTYJ
	 AV+tEjKLpVOPyymf5tTGd44qMOv7tF4PS8j1FswEYJ2qKd8L1S2z8Z4TzGX4TvMEto
	 /NzWN0/0ivSzw==
Date: Thu, 20 Jul 2023 20:02:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith
 Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Boris Pismenny <boris.pismenny@gmail.com>
Subject: Re: [PATCH 6/6] net/tls: implement ->read_sock()
Message-ID: <20230720200216.4bf1bf4b@kernel.org>
In-Reply-To: <20230719113836.68859-7-hare@suse.de>
References: <20230719113836.68859-1-hare@suse.de>
	<20230719113836.68859-7-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230720_200219_433583_E39009A3 
X-CRM114-Status: GOOD (  19.23  )
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

On Wed, 19 Jul 2023 13:38:36 +0200 Hannes Reinecke wrote:
> Implement ->read_sock() function for use with nvme-tcp.

> +int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
> +		     sk_read_actor_t read_actor)
> +{
> +	struct tls_context *tls_ctx = tls_get_ctx(sk);
> +	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
> +	struct strp_msg *rxm = NULL;
> +	struct tls_msg *tlm;
> +	struct sk_buff *skb;
> +	struct sk_psock *psock;
> +	ssize_t copied = 0;
> +	bool bpf_strp_enabled;

bubble up the longer lines, like this:

+	struct tls_context *tls_ctx = tls_get_ctx(sk);
+	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
+	struct strp_msg *rxm = NULL;
+	struct sk_psock *psock;
+	bool bpf_strp_enabled;
+	struct tls_msg *tlm;
+	struct sk_buff *skb;
+	ssize_t copied = 0;
+	int err, used;

> +	int err, used;
> +
> +	psock = sk_psock_get(sk);
> +	err = tls_rx_reader_acquire(sk, ctx, true);
> +	if (err < 0)
> +		goto psock_put;
> +	bpf_strp_enabled = sk_psock_strp_enabled(psock);

You're not servicing the BPF out of band queue, just error out if
the BPF psock is enabled. It's barely used and endlessly buggy anyway.

> +	/* If crypto failed the connection is broken */
> +	err = ctx->async_wait.err;
> +	if (err)
> +		goto read_sock_end;
> +
> +	do {
> +		if (!skb_queue_empty(&ctx->rx_list)) {
> +			skb = __skb_dequeue(&ctx->rx_list);
> +			rxm = strp_msg(skb);
> +		} else {
> +			struct tls_decrypt_arg darg;
> +
> +			err = tls_rx_rec_wait(sk, psock, true, true);
> +			if (err <= 0)
> +				goto read_sock_end;
> +
> +			memset(&darg.inargs, 0, sizeof(darg.inargs));
> +			darg.zc = !bpf_strp_enabled && ctx->zc_capable;

And what are you zero-copying into my friend? zc == zero copy.
Leave the zc be 0, like splice does, otherwise passing msg=NULL
to tls_rx_one_record() may explode. Testing with TLS 1.2 should
show that.

> +			rxm = strp_msg(tls_strp_msg(ctx));
> +			tlm = tls_msg(tls_strp_msg(ctx));
> +
> +			/* read_sock does not support reading control messages */
> +			if (tlm->control != TLS_RECORD_TYPE_DATA) {
> +				err = -EINVAL;
> +				goto read_sock_requeue;
> +			}
> +
> +			if (!bpf_strp_enabled)
> +				darg.async = ctx->async_capable;
> +			else
> +				darg.async = false;

Also don't bother with async. TLS 1.3 can't do async, anyway,
and I don't think you wait for the completion :S

> +			err = tls_rx_one_record(sk, NULL, &darg);
> +			if (err < 0) {
> +				tls_err_abort(sk, -EBADMSG);
> +				goto read_sock_end;
> +			}
> +
> +			sk_flush_backlog(sk);

Hm, could be a bit often but okay.

> +			skb = darg.skb;
> +			rxm = strp_msg(skb);
> +
> +			tls_rx_rec_done(ctx);
> +		}
> +
> +		used = read_actor(desc, skb, rxm->offset, rxm->full_len);
> +		if (used <= 0) {
> +			if (!copied)
> +				err = used;
> +			goto read_sock_end;

You have to requeue on error.

> +		}
> +		copied += used;
> +		if (used < rxm->full_len) {
> +			rxm->offset += used;
> +			rxm->full_len -= used;
> +			if (!desc->count)
> +				goto read_sock_requeue;

And here. Like splice_read does. Otherwise you leak the skb.

> +		} else {
> +			consume_skb(skb);
> +			if (!desc->count)
> +				skb = NULL;
> +		}
> +	} while (skb);
> +
> +read_sock_end:
> +	tls_rx_reader_release(sk, ctx);
> +psock_put:
> +	if (psock)
> +		sk_psock_put(sk, psock);
> +	return copied ? : err;
> +
> +read_sock_requeue:
> +	__skb_queue_head(&ctx->rx_list, skb);
> +	goto read_sock_end;
> +}
> +
>  bool tls_sw_sock_is_readable(struct sock *sk)
>  {
>  	struct tls_context *tls_ctx = tls_get_ctx(sk);


