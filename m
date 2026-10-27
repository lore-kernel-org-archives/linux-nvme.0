Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D159D606A31A
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2026 09:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lefBwiP4;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xu9siiAW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=w9GQy28DtehOTmM2bkZEyOcFhaJz1cw7O3yMOwMYiz4=; b=lefBwiP4kUaRjE6VeuUL1pqjdZ
	91UxtDDtyfXP9wJoLcuNve0DffD6P8rvarLSt49Br3/WMzLBRLYPJMbSv63gM14SwcT1OJXKKS4A5
	Gg1Mfx+vBHiIuMLXE984R+EXY11UmugFD7bXmNRr0cITc+7mqnKgLUmHr0ndJ8Wl48dcCScf/C5g0
	RCYlfhjJSo85OQZLLNeiUnJwhcr3bqQjx8SuTKGpKxM63fNrRHllstnIaDGHlBM96nqSA/iCJ+arO
	9clQeHQgQheZobutoVnrpNFZnchALYRUcypu6a0ifLouyN3qhQHXnUJ+r1kv0r+DsCylvKqkY7TTd
	nIuVK4iA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLdmN-00000004D2k-1X6v;
	Tue, 27 Oct 2026 09:47:39 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLdmL-00000004D2J-3GuJ
	for linux-nvme@lists.infradead.org;
	Tue, 27 Oct 2026 09:47:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CDDAC601FB;
	Tue, 27 Oct 2026 09:47:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663EE1F031E0;
	Tue, 27 Oct 2026 09:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793094456;
	bh=w9GQy28DtehOTmM2bkZEyOcFhaJz1cw7O3yMOwMYiz4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Xu9siiAWuaI8GxzCMth3Q/in+9LtE6R0T1DDnrrT+fDoBkNR/CllSOmoe+zGQ8pze
	 oI9n5sGvLEkYr5hpLW3olhkFWQtwI0XXCZnjl63880Weevee9YF+NE4tSrdi/xw+pX
	 TnC+XZqqCxE7hfrqegdoE9Er+qI7pgAJFEdz+2mVBL/YLaXNO7ngt/mB3mYu+tH/Af
	 WlEdsEkv5fFCZw4so463A9vBsrLAijsmP5eY0DHE7L7/KuQ8MbuglEzsIlgMroQRBq
	 qIw97yp+IyvfT8jQ50wHywDr8Y2c5BTisK8jW/XIOR/NRbhLrXYOCNraMeaE1eh8f7
	 WL9s43j7obKKw==
Message-ID: <sashiko-outbox-186332@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] nvme-tcp: validate the TLS handshake timeout
To: "Yingjie Wang" <1075151112@qq.com>, linux-nvme@lists.infradead.org
In-Reply-To: <tencent_E33FE1732968D0AADAB39548E7D2F3C4F705@qq.com>
References: <20261027093552.3934437-1-1075151112@qq.com>
 <tencent_E33FE1732968D0AADAB39548E7D2F3C4F705@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 09:47:35 +0000
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] nvme-tcp: truncation of remaining jiffies to int in nvme_tcp_start=
_tls()
--

commit 078728fd450c0f2c7191dfe3e169bb181ef6783e
Author: Yingjie Wang <1075151112@qq.com>

nvme-tcp: validate the TLS handshake timeout

This commit changes tls_handshake_timeout to an unsigned int and validates
that its value fits within both tls_handshake_args::ta_timeout_ms and
MAX_JIFFY_OFFSET / HZ. It also snapshots tls_handshake_timeout with
READ_ONCE() in nvme_tcp_start_tls() and widens tmo to unsigned long.

> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 7190eb10c2481..bc7a60ecfa356 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c

[ ... ]

> @@ -48,9 +49,24 @@ MODULE_PARM_DESC(wq_unbound, "Use unbound workqueue fo=
r nvme-tcp IO context (def
>  /*
>   * TLS handshake timeout
>   */
> -static int tls_handshake_timeout =3D 10;
> +static unsigned int tls_handshake_timeout =3D 10;
>  #ifdef CONFIG_NVME_TCP_TLS
> -module_param(tls_handshake_timeout, int, 0644);
> +static int tls_handshake_timeout_set(const char *val,
> +				     const struct kernel_param *kp)
> +{
> +	return param_set_uint_minmax(val, kp, 0,
> +		min_t(unsigned long, UINT_MAX / MSEC_PER_SEC,
> +		      MAX_JIFFY_OFFSET / HZ));
> +}

[ ... ]

> @@ -1796,7 +1812,8 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nct=
rl,
>  	int qid =3D nvme_tcp_queue_id(queue);
>  	int ret;
>  	struct tls_handshake_args args;
> -	unsigned long tmo =3D tls_handshake_timeout * HZ;
> +	unsigned int timeout =3D READ_ONCE(tls_handshake_timeout);
> +	unsigned long tmo =3D (unsigned long)timeout * HZ;
>  	key_serial_t keyring =3D nvme_keyring_id();

[Severity: High]
When tmo exceeds INT_MAX, can wait_for_completion_interruptible_timeout()
truncate the remaining jiffies into int ret and treat a completed TLS
handshake as a failure?

In tls_handshake_timeout_set(), values up to UINT_MAX / MSEC_PER_SEC
(4,294,967 seconds on 64-bit systems) are accepted. With HZ=3D1000 and
tls_handshake_timeout set to a value in [2147484, 4294967] (including
2147484 from the commit message), tmo =3D (unsigned long)timeout * HZ is in
[2147484000, 4294967000], which exceeds INT_MAX.

Later in nvme_tcp_start_tls(), the signed long return value from
wait_for_completion_interruptible_timeout() is stored in int ret:

drivers/nvme/host/tcp.c:nvme_tcp_start_tls() {
	...
	ret =3D wait_for_completion_interruptible_timeout(&queue->tls_complete, tm=
o);
	if (ret <=3D 0) {
		if (ret =3D=3D 0)
			ret =3D -ETIMEDOUT;

		dev_err(nctrl->device,
			"queue %d: TLS handshake failed, error %d\n",
			qid, ret);
		tls_handshake_cancel(queue->sock->sk);
	} else {
	...
	return ret;
}

When the handshake completes normally while more than INT_MAX jiffies
remain, assigning the positive long return value to int ret truncates it to
a negative int (for example, around -2147483296). That causes ret <=3D 0 to
trigger, cancelling the handshake and returning a large negative value
smaller than -MAX_ERRNO.

Through the call chain:

  nvmf_dev_write()
    -> nvmf_create_ctrl()
      -> nvme_tcp_create_ctrl()
        -> nvme_tcp_setup_ctrl()
          -> nvme_tcp_configure_admin_queue()
            -> nvme_tcp_alloc_admin_queue()
              -> nvme_tcp_alloc_queue()
                -> nvme_tcp_start_tls()

nvme_tcp_create_ctrl() then converts that truncated ret via ERR_PTR(ret):

drivers/nvme/host/tcp.c:nvme_tcp_create_ctrl() {
	...
	if (ret > 0)
		ret =3D -EIO;
	return ERR_PTR(ret);
}

Because ret is less than -MAX_ERRNO, IS_ERR() in nvmf_create_ctrl() and
nvmf_dev_write() evaluates to false on the freed controller pointer, storing
an invalid pointer in seq_file->private that is dereferenced on subsequent
read or release of /dev/nvme-fabrics.

Should the wait return value in nvme_tcp_start_tls() be stored in a separate
long variable (or should ret be widened to long across the wait check)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_39AF670751C=
A25EA49D4BFD8E76C509F5506@qq.com?part=3D2

