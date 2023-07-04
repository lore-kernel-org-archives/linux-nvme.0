Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDEC4EB64D9
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Jul 2023 07:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=istjmR72xmUVS5rI2vvyVL/LQ2pxm+7xavn3IClgJQE=; b=PfceNiuv5H8zdyyVOBc+ja6MMB
	DF/hj2yFfMbmGt9wW92h2vGGA7AQObpY/sDgrjf9X8zxbORVeXHrrorDVx38ViGSVB9S5KYAAwFtT
	9ISLM42vrXR1rpdMeEpDJy8Q+r5dObSVm/6pPnZbWz3aGjGLAN5ffaSYbveDv7fHWQdEOFZdF7i8Z
	OZ23hi3zuDK2zN1s7DfmxCDrE1WTS5jNt7hiQoawQq4oSrJc+8WbE6hWJzHSVB8T3cRy+q2r6Xp/v
	cIxjVrXm38BGhfm6KruE5QYQNX2aOhHi9EgP+U/4dOaVGTLjHqlIpHiKSt//coWcNULRkJKFgVcXL
	wtFJGGbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGauD-00CVaO-2s;
	Tue, 04 Jul 2023 07:57:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGau9-00CVYQ-32
	for linux-nvme@lists.infradead.org;
	Tue, 04 Jul 2023 07:57:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688457415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=istjmR72xmUVS5rI2vvyVL/LQ2pxm+7xavn3IClgJQE=;
	b=ax6eAU/X4ixFLXXO0/pPpW6CG/eXdtLO43keNJwARXWOigHsILEPGyOIXznx1woPU2oQmi
	1hxepkT00oMb9nSkoi8/IIvulqFLcpTKDW35VeFhK1PuIPZOMonItmaiLPucl1lxhVMNPF
	5p7CUUmIh2OhxkjeGy4X7lxQgDyV9gc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-N0JaL__YNr-3PH67B72SzQ-1; Tue, 04 Jul 2023 03:56:54 -0400
X-MC-Unique: N0JaL__YNr-3PH67B72SzQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-635e2618aaeso9974906d6.0
        for <linux-nvme@lists.infradead.org>; Tue, 04 Jul 2023 00:56:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688457414; x=1691049414;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+QwsYV+8KHzcasoXqD88czstNAhElxwaokiJev5S4tQ=;
        b=On87YsycGwAz/xs9YiGVx0H5Qf5D6tsPecWs6CTFWbAE9xq7GNWRfAbxANV5niFxi3
         ILgoKDcEitKEZQ9tLlw3hPTVn6zM0cnYKjpotnu0ptSc4DsUSNohRAb76uWFSXzE6Ska
         U/DWowOuzi+U9/xa7FlfCklHk7wMPBsuov+0LmdPiaXb/e1kEhhtg7LnPgRMpapnXdMH
         aasmeHHu4I656kh4XcFyf+BTy8M+ak07qh/mURbf6CcLId4xm19ic9DPbMNydqoXON9+
         kOpn0OpPE+LQY8UzDZKWEUL8I8vFSh6ipepPA1umjuG3ybLM6K3dekdP7JpMx34uD9GP
         +FYA==
X-Gm-Message-State: ABy/qLYwCj5XOkHNIdQNAjbIxaeEI+aIP33WWWzUS52eM2n4rjtp2UiT
	cpYgmbgg7/m8ZletvsB1Lq6UcKuC1alfTlZYtoG9L0en1msPohvNGF/CsQkA6D1U+jAW1/+cTbt
	0WEChrgFb6LNo31uPu44MGjJR2eXn2Zi3k2A=
X-Received: by 2002:a05:6214:4018:b0:635:ec47:bfa4 with SMTP id kd24-20020a056214401800b00635ec47bfa4mr14522709qvb.4.1688457414137;
        Tue, 04 Jul 2023 00:56:54 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEsrSbYrFIjlPpDXHLxORCl46MfBXyKNAZB4pBK89BtTGL6AR9JTbBqa7MK387z/+I5RmdNDA==
X-Received: by 2002:a05:6214:4018:b0:635:ec47:bfa4 with SMTP id kd24-20020a056214401800b00635ec47bfa4mr14522702qvb.4.1688457413910;
        Tue, 04 Jul 2023 00:56:53 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-247-156.dyn.eolo.it. [146.241.247.156])
        by smtp.gmail.com with ESMTPSA id b7-20020a0cfb47000000b006365a41c354sm4859826qvq.132.2023.07.04.00.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 00:56:53 -0700 (PDT)
Message-ID: <b44b9fdeafc0fb94a1e38c18732138db3726dd10.camel@redhat.com>
Subject: Re: [PATCH 5/5] net/tls: implement ->read_sock()
From: Paolo Abeni <pabeni@redhat.com>
To: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 linux-nvme@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>, netdev@vger.kernel.org, Boris Pismenny
 <boris.pismenny@gmail.com>
Date: Tue, 04 Jul 2023 09:56:49 +0200
In-Reply-To: <20230703090444.38734-6-hare@suse.de>
References: <20230703090444.38734-1-hare@suse.de>
	 <20230703090444.38734-6-hare@suse.de>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230704_005658_078330_6BC025DF 
X-CRM114-Status: GOOD (  18.00  )
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

On Mon, 2023-07-03 at 11:04 +0200, Hannes Reinecke wrote:
> Implement ->read_sock() function for use with nvme-tcp.
>=20
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Cc: Boris Pismenny <boris.pismenny@gmail.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: netdev@vger.kernel.org
> ---
>  net/tls/tls.h      |  2 ++
>  net/tls/tls_main.c |  2 ++
>  net/tls/tls_sw.c   | 78 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 82 insertions(+)
>=20
> diff --git a/net/tls/tls.h b/net/tls/tls.h
> index 86cef1c68e03..7e4d45537deb 100644
> --- a/net/tls/tls.h
> +++ b/net/tls/tls.h
> @@ -110,6 +110,8 @@ bool tls_sw_sock_is_readable(struct sock *sk);
>  ssize_t tls_sw_splice_read(struct socket *sock, loff_t *ppos,
>  =09=09=09   struct pipe_inode_info *pipe,
>  =09=09=09   size_t len, unsigned int flags);
> +int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
> +=09=09     sk_read_actor_t read_actor);
> =20
>  int tls_device_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)=
;
>  void tls_device_splice_eof(struct socket *sock);
> diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> index b6896126bb92..7dbb8cd8f809 100644
> --- a/net/tls/tls_main.c
> +++ b/net/tls/tls_main.c
> @@ -962,10 +962,12 @@ static void build_proto_ops(struct proto_ops ops[TL=
S_NUM_CONFIG][TLS_NUM_CONFIG]
>  =09ops[TLS_BASE][TLS_SW  ] =3D ops[TLS_BASE][TLS_BASE];
>  =09ops[TLS_BASE][TLS_SW  ].splice_read=09=3D tls_sw_splice_read;
>  =09ops[TLS_BASE][TLS_SW  ].poll=09=09=3D tls_sk_poll;
> +=09ops[TLS_BASE][TLS_SW  ].read_sock=09=3D tls_sw_read_sock;
> =20
>  =09ops[TLS_SW  ][TLS_SW  ] =3D ops[TLS_SW  ][TLS_BASE];
>  =09ops[TLS_SW  ][TLS_SW  ].splice_read=09=3D tls_sw_splice_read;
>  =09ops[TLS_SW  ][TLS_SW  ].poll=09=09=3D tls_sk_poll;
> +=09ops[TLS_SW  ][TLS_SW  ].read_sock=09=3D tls_sw_read_sock;
> =20
>  #ifdef CONFIG_TLS_DEVICE
>  =09ops[TLS_HW  ][TLS_BASE] =3D ops[TLS_BASE][TLS_BASE];
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index d0636ea13009..dbf1c8a71f61 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -2202,6 +2202,84 @@ ssize_t tls_sw_splice_read(struct socket *sock,  l=
off_t *ppos,
>  =09goto splice_read_end;
>  }
> =20
> +int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
> +=09=09     sk_read_actor_t read_actor)
> +{
> +=09struct tls_context *tls_ctx =3D tls_get_ctx(sk);
> +=09struct tls_sw_context_rx *ctx =3D tls_sw_ctx_rx(tls_ctx);
> +=09struct strp_msg *rxm =3D NULL;
> +=09struct tls_msg *tlm;
> +=09struct sk_buff *skb;
> +=09ssize_t copied =3D 0;
> +=09int err, used;
> +
> +=09err =3D tls_rx_reader_acquire(sk, ctx, true);
> +=09if (err < 0)
> +=09=09return err;
> +=09if (!skb_queue_empty(&ctx->rx_list)) {
> +=09=09skb =3D __skb_dequeue(&ctx->rx_list);
> +=09} else {
> +=09=09struct tls_decrypt_arg darg;
> +
> +=09=09err =3D tls_rx_rec_wait(sk, NULL, true, true);
> +=09=09if (err <=3D 0) {
> +=09=09=09tls_rx_reader_release(sk, ctx);
> +=09=09=09return err;

You can replace the 2 lines above with:

=09=09=09goto read_sock_end;

> +=09=09}
> +
> +=09=09memset(&darg.inargs, 0, sizeof(darg.inargs));
> +
> +=09=09err =3D tls_rx_one_record(sk, NULL, &darg);
> +=09=09if (err < 0) {
> +=09=09=09tls_err_abort(sk, -EBADMSG);
> +=09=09=09tls_rx_reader_release(sk, ctx);
> +=09=09=09return err;

Same here.

> +=09=09}
> +
> +=09=09tls_rx_rec_done(ctx);
> +=09=09skb =3D darg.skb;
> +=09}
> +
> +=09do {
> +=09=09rxm =3D strp_msg(skb);
> +=09=09tlm =3D tls_msg(skb);
> +
> +=09=09/* read_sock does not support reading control messages */
> +=09=09if (tlm->control !=3D TLS_RECORD_TYPE_DATA) {
> +=09=09=09err =3D -EINVAL;
> +=09=09=09goto read_sock_requeue;
> +=09=09}
> +
> +=09=09used =3D read_actor(desc, skb, rxm->offset, rxm->full_len);
> +=09=09if (used <=3D 0) {
> +=09=09=09err =3D used;
> +=09=09=09goto read_sock_end;
> +=09=09}
> +
> +=09=09copied +=3D used;
> +=09=09if (used < rxm->full_len) {
> +=09=09=09rxm->offset +=3D used;
> +=09=09=09rxm->full_len -=3D used;
> +=09=09=09if (!desc->count)
> +=09=09=09=09goto read_sock_requeue;
> +=09=09} else {
> +=09=09=09consume_skb(skb);
> +=09=09=09if (desc->count && !skb_queue_empty(&ctx->rx_list))
> +=09=09=09=09skb =3D __skb_dequeue(&ctx->rx_list);
> +=09=09=09else
> +=09=09=09=09skb =3D NULL;
> +=09=09}
> +=09} while (skb);
> +
> +read_sock_end:
> +=09tls_rx_reader_release(sk, ctx);
> +=09return copied ? : err;

WRT the return value, I think you should look at tcp_read_sock() as the
reference. The above LGTM. Some ->read_sock() callers ignore the =20
return value due to the specific 'read_actor' callback used.

WRT the deadlock you see, try to run your tests with lockdep enabled,
it should provide valuable information on the deadlock cause, if any.

Cheers,

Paolo


