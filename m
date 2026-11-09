Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DCA606A31C
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 19:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qTqOggLi;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f6dIn/Sh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=HgzCAHh8zkMqYvUo8m1Ft/XFwEMuOT2wBFxSUDNYV6Y=; b=qTqOggLiYRpTo5EJxWxWNSc9OU
	v8ugNsGwwfj283PYnD4BhqnvbJD5pwVTpXfDG9nnrz6TaeA0/4V5wa3Ur2J0g0hZdt2yJLscmP7GQ
	CMeQNCAmwWD7qogLIOKGPYDE0idSY33/IfxRE9xJAcgxlfgCnkSoXgLoB0uWJcJ181O2PzcSgUHFS
	dvg6HEbXQVTKiwyQYk6OstiZF8435eK1Ga9rFRkt7BqIPZU+bFWz0nIYu98nlTzL1qkMgnNv7LcDZ
	aQiXnWmg/lQPZ0CgrQQoKgdDixfJMKhfg2QNrX9FApTDRwO1vFuz0DAMWXCrijejxRlHHER2wtKFs
	1XHMiQYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQUmJ-00000001Wbu-1aar;
	Mon, 09 Nov 2026 19:11:39 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQUm8-00000001WbX-012x
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 19:11:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5F472429C5;
	Mon,  9 Nov 2026 19:11:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261191F0089F;
	Mon,  9 Nov 2026 19:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794251487;
	bh=HgzCAHh8zkMqYvUo8m1Ft/XFwEMuOT2wBFxSUDNYV6Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f6dIn/Sh4gE5qsvT8ld9wRHEXKVQBb1qP8rrwjYjA/gCCg6W1loSinJsaSDySGB/r
	 hrt6Nan9Y+jD4dMPbsLoTpaQEFyGck5K4IIKfYr6bcMPYSV1dR27qRg+vXLa6UNv1X
	 bHOjPEbNRa+3gjNYyq2DZ37QWAo2LIMrPIOy/rD31m7OCCBHlB0rzhVbmGd1idIbr7
	 T69W6D11vLhEg2outQ90x65QIb18WSpMYrDDzdFT2jIlWohn4c5Ig1Mf20qC/1Tviu
	 XfRcP6dOgNbFX+pL2WcmTtOoliK/rzcAQ4TQOK00m5fuoCPut9KaqNZmGFKt/iLWnc
	 RMb1PpdoPNY6g==
Message-ID: <sashiko-outbox-205465@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] nvme-tcp: move the TLS record read loop into a
 helper
To: "Martin Belanger" <martin.nvme.dev@gmail.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261109-nvme-tcp-live-ctrlrec-v1-1-47ba61670e65@gmail.com>
References: <20261109-nvme-tcp-live-ctrlrec-v1-0-47ba61670e65@gmail.com>
 <20261109-nvme-tcp-live-ctrlrec-v1-1-47ba61670e65@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 19:11:26 +0000
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Medium] nvme-tcp: unaligned cmsghdr access in
  nvme_tcp_init_connection() [1]
--

commit b550db6841afde16fa08cb67f259ffa9462cfbdb
Author: Martin Belanger <martin.belanger@dell.com>

nvme-tcp: move the TLS record read loop into a helper

This commit extracts the TLS record draining loop from
nvme_tcp_skip_tls_record() into a new nvme_tcp_drain_tls_record() helper.

> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 7ecc6c007f8d4..bf71e6f6a6ef6 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1623,31 +1623,16 @@ static int nvme_tcp_recv_tls_alert(struct nvme_tc=
p_queue *queue,
>  }
> =20
>  /*
> - * Discard a TLS record that arrived in place of the ICResp. A peer may =
send
> - * a NewSessionTicket as soon as the handshake completes.
> + * Read the rest of a TLS record whose first part was read into @msg.
>   *
> - * Returns 0 when the record was discarded and the ICResp can be read, o=
r a
> - * negative errno if the connection cannot continue.
> + * Returns the bytes read, or a negative errno.
>   */
> -static int nvme_tcp_skip_tls_record(struct nvme_tcp_queue *queue,
> -				    struct msghdr *msg, u8 ctype, int len)
> +static int nvme_tcp_drain_tls_record(struct nvme_tcp_queue *queue,
> +				     struct msghdr *msg, int flags)
>  {
>  	u8 buf[NVME_TCP_TLS_REC_CHUNK];
> -	int ret;
> +	int ret, drained =3D 0;
> =20
> -	switch (ctype) {
> -	case TLS_RECORD_TYPE_HANDSHAKE:
> -		break;
> -	case TLS_RECORD_TYPE_ALERT:
> -		ret =3D nvme_tcp_recv_tls_alert(queue, msg, len);
> -		return ret ? : -ENOTCONN;
> -	default:
> -		pr_err("queue %d: unhandled TLS record %u\n",
> -		       nvme_tcp_queue_id(queue), ctype);
> -		return -ENOTCONN;
> -	}
> -
> -	/* the ICResp is in a later record, drain this one first */
>  	while (!(msg->msg_flags & MSG_EOR)) {
>  		struct kvec iov =3D {
>  			.iov_base =3D buf,
> @@ -1661,16 +1646,47 @@ static int nvme_tcp_skip_tls_record(struct nvme_t=
cp_queue *queue,
>  		};
> =20
>  		ret =3D kernel_recvmsg(queue->sock, &drain, &iov, 1, sizeof(buf),
> -				     0);
> +				     flags);

[Severity: Medium]
This problem wasn't introduced by this patch, but can passing the unaligned
char cbuf[] array as msg_control [1] cause unaligned struct cmsghdr
accesses?

Both here in nvme_tcp_drain_tls_record() and in its caller
nvme_tcp_recv_icresp() (called from nvme_tcp_init_connection()), cbuf is
declared as a plain char array with 1-byte alignment:

drivers/nvme/host/tcp.c:nvme_tcp_recv_icresp() {
	char cbuf[CMSG_LEN(sizeof(char))];
	...
		if (nvme_tcp_queue_tls(queue)) {
			msg.msg_control =3D cbuf;
			msg.msg_controllen =3D sizeof(cbuf);
		}
		msg.msg_flags =3D MSG_WAITALL;
		ret =3D kernel_recvmsg(queue->sock, &msg, &iov, 1,
				     iov.iov_len, msg.msg_flags);
		if (ret <=3D 0 || !nvme_tcp_queue_tls(queue))
			return ret;

		ctype =3D tls_get_record_type(queue->sock->sk,
					    (struct cmsghdr *)cbuf);
}

During kernel_recvmsg(), put_cmsg() casts msg->msg_control to
struct cmsghdr * and writes fields such as cmsg_len directly, and
tls_get_record_type() likewise dereferences cbuf as a struct cmsghdr.  If t=
he
compiler places cbuf at a stack offset not aligned to
__alignof__(struct cmsghdr), these accesses trigger UBSAN alignment warnings
or alignment faults on strict-alignment architectures.

[1] https://sashiko.dev/#/bug/linux-1e37cffb-41dc-487d-9c96-e0b9b82c4e63

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-nvme-tcp-l=
ive-ctrlrec-v1-0-47ba61670e65@gmail.com?part=3D1

