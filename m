Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13365606A31C
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 19:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=n47rypjX;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ezLRM4BI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=bR/ig/M+S+AOlo88/njlqf0JGsXf5sBbRM8v7fHb3GU=; b=n47rypjXO74OgkbHPDt4oO2ikh
	Ykw8o3c4+c2/SDc9og2uh2zPZPcnSUXHlRR7o787oTlhI4E16GKuut/euNJgF6xw5XHB+4ij43iT8
	yXYpHn7pgqfPf82Gyno19Qc4nuJWJ09ZiQm55Vh0LzqI9JHtLsulmu/VTKRo1KeoswFSBnf7Rku5F
	7uZLSmcdL4lPpqxcvn7SHvTzs1Vdt9S9CNAkbuR50UIbGudnXF93H+3eYjGPKyoxeMc+IDICp7vX8
	H92rTIaLH+tnZKxfKRAA4QYh/YlBCE39zba9x7wz3ECKmgmtv67fyRQupe1YfTsYoD7JaOEyoqAdx
	eK9MGYWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQUvh-00000001XGo-3gsU;
	Mon, 09 Nov 2026 19:21:21 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQUvg-00000001XGe-2sHv
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 19:21:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2A5D842AA2;
	Mon,  9 Nov 2026 19:21:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA1E1F008A1;
	Mon,  9 Nov 2026 19:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794252080;
	bh=bR/ig/M+S+AOlo88/njlqf0JGsXf5sBbRM8v7fHb3GU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ezLRM4BIYECDON1cgI5B7IRP2b5NbchXaK38nNVpcbaiaJXrZfu1J544Hrt785Qf2
	 TjaNs4VtmChZgdmBJOpWBV1rPW87e2c/RDXc5f7TpStCqlGlsPqIVP+ziLhZMlUVjH
	 AWRVEaf0jcWSrZHbjIUwN0fIoAVo3OTgBN/6iqK08K/1PAnsMiiSjxeRSFcJPaqHsb
	 1Bbj2N6NE+DFZ1AeoOkHAzzEHS/lL0YIKQv4RWeDJHSgTh17H1yc2hlseugUfDZgt2
	 n5AWpRByVHlTLcVYh/4VcLwiEWcH6E0BpM6YpizSqGAcczGgqilDzHPuGOVx4g5GFm
	 ay5UsmfJYNbxg==
Message-ID: <sashiko-outbox-205483@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] nvme-tcp: consume TLS records without application
 data
To: "Martin Belanger" <martin.nvme.dev@gmail.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261109-nvme-tcp-live-ctrlrec-v1-2-47ba61670e65@gmail.com>
References: <20261109-nvme-tcp-live-ctrlrec-v1-0-47ba61670e65@gmail.com>
 <20261109-nvme-tcp-live-ctrlrec-v1-2-47ba61670e65@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 19:21:19 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] nvme-tcp: race in nvme_tcp_try_recv() when dropping socket
  lock for TLS
--

commit 4ab07d4aae9edb0e5cd1d1957a5ff53b1dd8bb2d
Author: Martin Belanger <martin.belanger@dell.com>

nvme-tcp: consume TLS records without application data

This commit handles -EINVAL returns from read_sock() on TLS-enabled queues
by dropping the socket lock and reading non-application-data TLS records via
kernel_recvmsg().

> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index bf71e6f6a6ef6..d460273a328a1 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1444,6 +1444,8 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue =
*queue)
>  	return ret;
>  }
> =20
> +static int nvme_tcp_recv_tls_record(struct nvme_tcp_queue *queue);
> +
>  static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
>  {
>  	struct socket *sock =3D queue->sock;
> @@ -1456,6 +1458,18 @@ static int nvme_tcp_try_recv(struct nvme_tcp_queue=
 *queue)
>  	lock_sock(sk);
>  	queue->nr_cqe =3D 0;
>  	consumed =3D sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
> +	/*
> +	 * kTLS cannot pass a TLS record without application data to
> +	 * nvme_tcp_recv_skb(). It returns -EINVAL and leaves the record at
> +	 * the head of the receive queue. recvmsg() takes the socket lock,
> +	 * so read the record without it.
> +	 */
> +	if (unlikely(consumed =3D=3D -EINVAL && nvme_tcp_queue_tls(queue) &&
> +		     queue->rd_enabled)) {
> +		release_sock(sk);
> +		consumed =3D nvme_tcp_recv_tls_record(queue);
> +		lock_sock(sk);
> +	}

[Severity: Medium]
Can dropping the socket lock here let concurrent callers of
nvme_tcp_try_recv() race on the same TLS control record?

On a TLS-enabled poll queue, nvme_tcp_queue_request() always schedules
queue->io_work, so nvme_tcp_io_work() and nvme_tcp_poll() (or two polling
threads) can enter nvme_tcp_try_recv() concurrently without a queue-level
lock:

CPU0 (nvme_tcp_io_work)           CPU1 (nvme_tcp_poll)
nvme_tcp_try_recv()               nvme_tcp_try_recv()
  lock_sock(sk)
  read_sock() -> -EINVAL
  release_sock(sk)
                                    lock_sock(sk)
                                    read_sock() -> -EINVAL
                                    release_sock(sk)
  nvme_tcp_recv_tls_record()
    kernel_recvmsg()
                                    nvme_tcp_recv_tls_record()
                                      kernel_recvmsg()
                                      <-- -EAGAIN or reads data record

Once CPU0 consumes the control record, CPU1's kernel_recvmsg() either gets
-EAGAIN (which nvme_tcp_recv_tls_record() turns into -EPROTO) or consumes up
to 256 bytes of a following TLS_RECORD_TYPE_DATA record and fails with
-EPROTO on the unexpected record type.  In both cases nvme_tcp_try_recv()
disables the queue and triggers nvme_tcp_error_recovery().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-nvme-tcp-l=
ive-ctrlrec-v1-0-47ba61670e65@gmail.com?part=3D2

