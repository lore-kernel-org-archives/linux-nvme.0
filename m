Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECBC606A321
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 22:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=oDWvUCBs;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=epQWErkR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=naxNwZ6tJQ8x5kDOHdT3G4qtMK7SLlDWliD2iV9e/88=; b=oDWvUCBsT8JgEXRNFc0KSSBvli
	OGM5Ov278PmpilLWwQgiOfqnEHEKz5smyEHntck09u4cHRXVKSl5D2qUk+Q78RRUtxgsD4LCMGxaU
	6aT/xm/IGXWLRVAKC429dZ0ENEQmnEP+SBjrchJgUTg+Km4+NHxsO71zspqN7P44/zOttC7df4Dmv
	gDUzwxo3UmeNnsQfM9327A4xUjcHT4whA24AZ8cVZOvt5Z6RLFB3BG15BykM2dmJ4fvwi0w7StLHh
	xke/07DS7dmDdSV+MnrWLibJzN8B095l0L192R9FIbbDGzWDRAtmq7rdnm0Ku/XAgvtBTafQmQJzT
	kD48HOEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRHDG-000000084Yl-1xTZ;
	Wed, 11 Nov 2026 22:54:42 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRHDE-000000084YW-3QTz
	for linux-nvme@lists.infradead.org;
	Wed, 11 Nov 2026 22:54:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id F275C62E33;
	Wed, 11 Nov 2026 22:54:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BEB31F00A05;
	Wed, 11 Nov 2026 22:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794437679;
	bh=naxNwZ6tJQ8x5kDOHdT3G4qtMK7SLlDWliD2iV9e/88=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=epQWErkRCZir30NUw9xt/kPVAG1tCg8f51UP6CcxLp/q5zRDIeuYH574KGEP3JPI8
	 OHZzmRboQi7aW2eA/m87iCDLRi24JQAmWp7wKN+YYkd0VPEgbJJdtiUjiMoYx5V7Qb
	 a22uLAxAga6uG/5UkApQKQ/Vl9XM/nRWypexrby+d4HfeVsqn/V3bvwoxlx1WJOH8A
	 rBs/7URPHR1hqoEHU0kwhL6EqDs/ILXeyh/RH1/tYFydKd/j7SHhCxuFeo4nJfSIEl
	 YyYbhiZUxK53p7asxSjT8iv3rOAOv582lJVLQFZubx8DjIPJ1LQLYk0FBgJ+/9rcFx
	 KzF/4A08NDKDA==
Message-ID: <sashiko-outbox-209836@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] nvme-tcp: consume TLS records without
 application data
To: "Martin Belanger" <martin.nvme.dev@gmail.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261111-nvme-tcp-live-ctrlrec-v2-3-6295202b84de@gmail.com>
References: <20261111-nvme-tcp-live-ctrlrec-v2-0-6295202b84de@gmail.com>
 <20261111-nvme-tcp-live-ctrlrec-v2-3-6295202b84de@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 22:54:39 +0000
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
- [Medium] nvme-tcp: incomplete receive drain and NVME_TCP_Q_TLS_RECORD
  race in nvme_tcp_try_recv()
--

commit d757e1f5d7985445d8f4d6e3e3fcd651f850e3d7
Author: Martin Belanger <martin.belanger@dell.com>

nvme-tcp: consume TLS records without application data

This commit handles -EINVAL returns from sock->ops->read_sock() on TLS
queues by reading non-application-data TLS records via kernel_recvmsg(),
discarding post-handshake records such as NewSessionTicket while failing
the queue on KeyUpdate or fatal alerts.

> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index c3bf345c4e921..cc6a46f118b25 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
[ ... ]
> @@ -1462,10 +1465,31 @@ static int nvme_tcp_try_recv(struct nvme_tcp_queu=
e *queue)
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
> +		/*
> +		 * On a poll queue, nvme_tcp_poll() and nvme_tcp_io_work() can
> +		 * both get here for the same record. Only one of them reads it.
> +		 */
> +		if (test_and_set_bit(NVME_TCP_Q_TLS_RECORD, &queue->flags)) {
> +			consumed =3D 0;
> +		} else {
> +			release_sock(sk);
> +			consumed =3D nvme_tcp_recv_tls_record(queue);
> +			lock_sock(sk);
> +			clear_bit(NVME_TCP_Q_TLS_RECORD, &queue->flags);
> +		}
> +	}

[Severity: Medium]
Can nvme_tcp_try_recv() leave subsequent TLS records or NVMe PDUs stranded
on a poll queue after consuming a control record?

When tls_sw_read_sock() hits a non-data record (record 1),
tls_rx_rec_done() calls tls_strp_check_rcv(), which parses the next queued
record (record 2, such as an R2T PDU, completion, or a second
NewSessionTicket) and sets strp->msg_ready.  Before returning -EINVAL,
tls_rx_reader_release() sets strp->msg_announced and calls
nvme_tcp_data_ready(sk).

If nvme_tcp_poll() and nvme_tcp_io_work() race on a TLS poll queue:

CPU0 (nvme_tcp_poll)              CPU1 (nvme_tcp_io_work)
set_bit(NVME_TCP_Q_POLLING, ...)
nvme_tcp_try_recv()
  lock_sock(sk)
  read_sock() -> -EINVAL
    /* announces record 2;
     * NVME_TCP_Q_POLLING skips
     * queueing io_work */
  test_and_set_bit(TLS_RECORD)
  release_sock(sk)
                                  nvme_tcp_try_recv()
                                    lock_sock(sk)
                                    read_sock() -> -EINVAL
                                    test_and_set_bit(TLS_RECORD)
                                    consumed =3D 0
                                    release_sock(sk)
                                  /* result =3D=3D 0 -> pending =3D=3D fals=
e,
                                   * io_work exits */
  nvme_tcp_recv_tls_record()
    /* consumes only record 1 */
  lock_sock(sk)
  clear_bit(TLS_RECORD)
  release_sock(sk)
clear_bit(NVME_TCP_Q_POLLING, ...)
/* returns nr_cqe =3D=3D 0 without
 * retrying read_sock() */

Even without the race, nvme_tcp_poll() calls nvme_tcp_try_recv() once with
NVME_TCP_Q_POLLING set, so consuming record 1 returns nr_cqe =3D=3D 0 witho=
ut
re-running read_sock() for record 2.  Likewise, kernel_recvmsg() inside
nvme_tcp_recv_tls_record() drops the socket lock after consuming record 1
while NVME_TCP_Q_TLS_RECORD is still set; if record 2 is a second
NewSessionTicket, CPU1 can enter read_sock() in that window, decrypt
record 2 onto rx_list, see NVME_TCP_Q_TLS_RECORD still set, and return 0.

Because strp->msg_ready and strp->msg_announced are already set, later TCP
data will not trigger nvme_tcp_data_ready(), stalling the queue until I/O
times out.  Looping back to read_sock() after nvme_tcp_recv_tls_record()
succeeds would drain any remaining records under the same receive call.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-nvme-tcp-l=
ive-ctrlrec-v2-0-6295202b84de@gmail.com?part=3D3

