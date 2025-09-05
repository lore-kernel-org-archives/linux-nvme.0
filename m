Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88CB9CAC582
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Sep 2025 16:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fpvdRI1ZAXJavu/kEZ1LRvZEjSIJPwt91BUOmF3PxR4=; b=lUa+Fc/lVtcOOgKpYm+NRXiywD
	URkansbtKX432XLO45zNIgVMeh1/8a0FoP1VvjoTv00tsYrww0lj8PXwHinU9iV7bF0TCT05bv3Qb
	AvdaZylHh0zZ+kZr5Js5c0dx/YhFfGwsl8nf34VU1aSdNMDnWnMrZn1zxZ/WLSLeovb+nMhRRFnII
	v3xiR64LE8Hhsa/5Y7l6b5N/fKx98F/m5YrUUvnuindCP4T5OhUzJEJFY5qvp2s3gahKMmvulQYgx
	+IrHqLBmyx/alya2ZxLIGByHVglj6+WEdJtheCKudVWailJwTOF62dj+3X4SvzTFIzxkParigLZk1
	cUJsv3VA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuZVg-00000003BFg-3YXk;
	Fri, 05 Sep 2025 16:42:00 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuWKk-00000001vDT-0R4L
	for linux-nvme@lists.infradead.org;
	Fri, 05 Sep 2025 13:18:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 61D8360282;
	Fri,  5 Sep 2025 13:18:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A15DC4CEF1;
	Fri,  5 Sep 2025 13:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757078309;
	bh=RAA4rrJfeN8TQeFhBzYY5lBVITfb6FXS1EgUHDAhgbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sfalbbc0wK3mEOrEVsTZbNdHh1qtaNoFYkoXswu86BJXqgZtkB2p7ll0PmNFm+UF+
	 gROQHu45kiB2fB6zc9OocpeaCAl/VSUHMQTcK5dzzrBgfqKjEqoouiaYe0mVXn3hhP
	 2kpcsQKNAXGCMaKeCuDHKvZBNbFWuLrnetV5rnBM+Lul+hxu1a3YiWmsb1sWrI+HmF
	 8pxiMX2HVdqmxtozF5RFbwrNM7Av4MtV5kA9VGPoVeyr66E1EOBfErHIwl+nZDi9gV
	 BRPm5dt9TEUB/FB/dwkJLJ+Ks+3zD13gCA3XbAUMRYXVgNRQ6rjKqP7qlrGvZJFGPw
	 1nGF+gV/jf+bw==
Date: Fri, 5 Sep 2025 14:18:23 +0100
From: Simon Horman <horms@kernel.org>
To: alistair23@gmail.com
Cc: chuck.lever@oracle.com, hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
	kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2 1/7] net/handshake: Store the key serial number on
 completion
Message-ID: <20250905131823.GE553991@horms.kernel.org>
References: <20250905024659.811386-1-alistair.francis@wdc.com>
 <20250905024659.811386-2-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905024659.811386-2-alistair.francis@wdc.com>
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

On Fri, Sep 05, 2025 at 12:46:53PM +1000, alistair23@gmail.com wrote:

...

> diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c

...

> @@ -83,6 +87,13 @@ static void tls_handshake_remote_peerids(struct tls_handshake_req *treq,
>  		if (i >= treq->th_num_peerids)
>  			break;
>  	}
> +
> +	nla_for_each_attr(nla, head, len, rem) {
> +		if (nla_type(nla) == HANDSHAKE_A_DONE_SESSION_ID) {
> +			treq->user_session_id = nla_get_u32(nla);

Hi Alistair,

This appears to be addressed by patch 5/7 of this series.
But struct tls_handshake_req does not have a user_session_id member
with (only) this patch applied on top of net-next.

This breaks bisection and should be addressed: when each patch is applied
in turn the resulting source tree should compile.

...

> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index e2c5e0e626f9..1d5829aecf45 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -450,7 +450,8 @@ static void svc_tcp_kill_temp_xprt(struct svc_xprt *xprt)
>   * is present" flag on the xprt and let an upper layer enforce local
>   * security policy.
>   */

Please also add user_session_id to the kernel doc for this function (above).

Flagged by W=1 builds and ./scripts/kernel-doc -none 

> -static void svc_tcp_handshake_done(void *data, int status, key_serial_t peerid)
> +static void svc_tcp_handshake_done(void *data, int status, key_serial_t peerid,
> +				   key_serial_t user_session_id)
>  {
>  	struct svc_xprt *xprt = data;
>  	struct svc_sock *svsk = container_of(xprt, struct svc_sock, sk_xprt);
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index c5f7bbf5775f..3489c4693ff4 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -2591,7 +2591,8 @@ static int xs_tcp_tls_finish_connecting(struct rpc_xprt *lower_xprt,
>   * @peerid: serial number of key containing the remote's identity
>   *
>   */
> -static void xs_tls_handshake_done(void *data, int status, key_serial_t peerid)
> +static void xs_tls_handshake_done(void *data, int status, key_serial_t peerid,
> +				  key_serial_t user_session_id)

Ditto.

>  {
>  	struct rpc_xprt *lower_xprt = data;
>  	struct sock_xprt *lower_transport =
> -- 
> 2.50.1
> 
> 

