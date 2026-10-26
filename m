Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626E2606A31A
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Oct 2026 18:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=J0w2Dw/k;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QB9akI7K
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=mBteM7uh0neiMgZA+K/xWc7JS2IrfcXFGSxUlafqCzs=; b=J0w2Dw/kKiNf7eaTkqLfvmfuzZ
	T3wAvW9pACV9oJLcsi4GZZseE/FL3IMhyo73oWeOiJ3Hy3pvR3lrLhEZ7sfZucqLxqjb/H/Btbu58
	wu7jtmtlNc1nrC8u6AokFyrg9vVM5vZTL/ovZ83hVMg2UJlN/syGFgtDAlPeuhJ4kUlyFYOs/xjIz
	0PhPIvX5ey7HmWo31yiZsjGfEa75uL0Ew1WbzYmHSLgnkURZicR02DftKHDrSUsNpsEtymWmuAUUL
	AipIKNLZM0Rj7/i+uO+Vqw3qEBQa1C2aEp3yfhx6PXNXG+GUFNy2IdVl3oAj1xm5cuH7HMdcCDJHt
	T8NIVHvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLPMf-00000003401-41Su;
	Mon, 26 Oct 2026 18:24:09 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLPMd-000000033zn-3FWq
	for linux-nvme@lists.infradead.org;
	Mon, 26 Oct 2026 18:24:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C1998601F9;
	Mon, 26 Oct 2026 18:24:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 521491F01825;
	Mon, 26 Oct 2026 18:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793039046;
	bh=mBteM7uh0neiMgZA+K/xWc7JS2IrfcXFGSxUlafqCzs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QB9akI7Kk5jXvw+yvYwaMBh9EUfZo4uglif5OeqNGMTZnClaeWjfEtREHHOiGiACs
	 1oGx5o/zpM+oz8AmPEiB9vyXAV6T4WVnI8z7hYCt2wyd5PtFWA3Qx8dfC2KgwK0AVz
	 CUX3186yb9WX/cmKe3XmmVJlsZx4HuCtaeseFPanmG97EQW46Ll7KDlrrssmITl3XP
	 0djgL+7AgVMdh7hboEEePUHDy9OFLo/2giQqBUXvm2LRhRkm1U8Rewx22kdKy6Y6/Y
	 fGNbZ0GXpLWRS5+etiOOPmqwFCWMFV00agidCpqxGGP9PnSneOLYt7Q+leeP3PiwUG
	 9q72D4JxftcKg==
Message-ID: <sashiko-outbox-185615@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] nvme-tcp: skip TLS control records while waiting
 for the ICResp
To: "Martin Belanger" <martin.nvme.dev@gmail.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261026-nvme-tcp-ctrlrec-fixes-v1-2-ebf6ff7eff34@gmail.com>
References: <20261026-nvme-tcp-ctrlrec-fixes-v1-0-ebf6ff7eff34@gmail.com>
 <20261026-nvme-tcp-ctrlrec-fixes-v1-2-ebf6ff7eff34@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 18:24:04 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] nvme-tcp: missing msg_control in nvme_tcp_skip_tls_record() causes=
 -EIO
- [Medium] nvme-tcp: unhandled EOF in nvme_tcp_recv_icresp() on TLS queues
--

commit e6540f770ca0b1e419e220cc7a58ea6cad9fb1eb
Author: Martin Belanger <martin.belanger@dell.com>

nvme-tcp: skip TLS control records while waiting for the ICResp

This commit updates nvme-tcp connection initialization to skip non-data TLS
records (such as TLS 1.3 NewSessionTicket handshake records) and process
TLS alerts while waiting for the ICResp PDU.

> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index a03476f0f69d5..2d361a9e87101 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
[ ... ]
> @@ -1548,12 +1554,138 @@ static void nvme_tcp_free_queue(struct nvme_ctrl=
 *nctrl, int qid)
[ ... ]
> +static int nvme_tcp_skip_tls_record(struct nvme_tcp_queue *queue,
> +				    struct msghdr *msg, u8 ctype, int len)
> +{
> +	u8 buf[NVME_TCP_TLS_REC_CHUNK];
> +	int ret;
> +
> +	switch (ctype) {
> +	case TLS_RECORD_TYPE_HANDSHAKE:
> +		break;
> +	case TLS_RECORD_TYPE_ALERT:
> +		ret =3D nvme_tcp_recv_tls_alert(queue, msg, len);
> +		return ret ? : -ENOTCONN;
> +	default:
> +		pr_err("queue %d: unhandled TLS record %u\n",
> +		       nvme_tcp_queue_id(queue), ctype);
> +		return -ENOTCONN;
> +	}
> +
> +	/* the ICResp is in a later record, drain this one first */
> +	while (!(msg->msg_flags & MSG_EOR)) {
> +		struct kvec iov =3D {
> +			.iov_base =3D buf,
> +			.iov_len =3D sizeof(buf),
> +		};
> +		struct msghdr drain =3D {};
> +
> +		ret =3D kernel_recvmsg(queue->sock, &drain, &iov, 1, sizeof(buf),
> +				     0);
> +		if (ret <=3D 0) {
> +			pr_warn("queue %d: failed to drain TLS record: %d\n",
> +				nvme_tcp_queue_id(queue), ret);
> +			return ret ? : -ECONNRESET;
> +		}
> +		msg->msg_flags =3D drain.msg_flags;
> +	}

[Severity: High]
Will draining a handshake record larger than sizeof(*icresp) (128 bytes) in
drivers/nvme/host/tcp.c:nvme_tcp_skip_tls_record() always fail with -EIO?

When a TLS peer (such as an OpenSSL target sending a TLS 1.3
NewSessionTicket) sends a TLS_RECORD_TYPE_HANDSHAKE record larger than 128
bytes, the initial kernel_recvmsg() in nvme_tcp_recv_icresp() reads the
first 128 bytes and returns without setting MSG_EOR in msg.msg_flags.

In nvme_tcp_skip_tls_record(), the drain msghdr is zero-initialized with
drain.msg_control set to NULL and drain.msg_controllen set to 0 before
calling kernel_recvmsg().

In the kTLS receive path:

  kernel_recvmsg()
    -> tls_sw_recvmsg()
      -> process_rx_list()
        -> tls_record_content_type()
          -> put_cmsg()

net/core/scm.c:put_cmsg() checks msg->msg_control:

	if (!msg->msg_control || msg->msg_controllen < sizeof(struct cmsghdr)) {
		msg->msg_flags |=3D MSG_CTRUNC;
		return 0; /* XXX: return error? check spec. */
	}

And net/tls/tls_sw.c:tls_record_content_type() rejects non-data records
when MSG_CTRUNC is set:

	if (!*control) {
		*control =3D tlm->control;
		if (!*control)
			return -EBADMSG;

		err =3D put_cmsg(msg, SOL_TLS, TLS_GET_RECORD_TYPE,
			       sizeof(*control), control);
		if (*control !=3D TLS_RECORD_TYPE_DATA) {
			if (err || msg->msg_flags & MSG_CTRUNC)
				return -EIO;
		}
	}

Because drain does not provide a control message buffer,
tls_record_content_type() returns -EIO without consuming the rest of the
handshake record, causing nvme_tcp_skip_tls_record() and
nvme_tcp_init_connection() to fail with -EIO.

Should drain.msg_control and drain.msg_controllen be populated with a
cmsg buffer on each iteration of the drain loop?

> +
> +	return 0;
> +}
> +
> +/*
> + * Receive the ICResp. Over TLS, skip the records that a peer may send
> + * ahead of it.
> + *
> + * Returns the length received, or a negative errno.
> + */
> +static int nvme_tcp_recv_icresp(struct nvme_tcp_queue *queue,
> +				struct nvme_tcp_icresp_pdu *icresp)
> +{
> +	char cbuf[CMSG_LEN(sizeof(char))];
> +	struct msghdr msg;
> +	struct kvec iov;
> +	u8 ctype;
> +	int i, ret;
> +
> +	for (i =3D 0; i < NVME_TCP_ICRESP_MAX_RECORDS; i++) {
> +		memset(&msg, 0, sizeof(msg));
> +		memset(cbuf, 0, sizeof(cbuf));
> +		iov.iov_base =3D icresp;
> +		iov.iov_len =3D sizeof(*icresp);
> +		if (nvme_tcp_queue_tls(queue)) {
> +			msg.msg_control =3D cbuf;
> +			msg.msg_controllen =3D sizeof(cbuf);
> +		}
> +		msg.msg_flags =3D MSG_WAITALL;
> +		ret =3D kernel_recvmsg(queue->sock, &msg, &iov, 1,
> +				     iov.iov_len, msg.msg_flags);
> +		if (ret < 0 || !nvme_tcp_queue_tls(queue))
> +			return ret;

[Severity: Medium]
What happens in drivers/nvme/host/tcp.c:nvme_tcp_recv_icresp() if the TLS
peer closes the connection cleanly before sending the ICResp and
kernel_recvmsg() returns 0?

When kernel_recvmsg() returns 0 on EOF over a TLS-enabled queue, the check
above (ret < 0 || !nvme_tcp_queue_tls(queue)) is false, so execution
continues to tls_get_record_type() with the zeroed cbuf.

Since cmsg->cmsg_level is 0, tls_get_record_type() returns 0, and
nvme_tcp_skip_tls_record() hits the default case:

	default:
		pr_err("queue %d: unhandled TLS record %u\n",
		       nvme_tcp_queue_id(queue), ctype);
		return -ENOTCONN;

This logs a spurious "unhandled TLS record 0" error and returns -ENOTCONN,
bypassing the EOF handling in nvme_tcp_init_connection():

	ret =3D nvme_tcp_recv_icresp(queue, icresp);
	if (ret >=3D 0 && ret < sizeof(*icresp))
		ret =3D -ECONNRESET;

Should the early return condition in nvme_tcp_recv_icresp() check ret <=3D 0
instead of ret < 0?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-nvme-tcp-c=
trlrec-fixes-v1-0-ebf6ff7eff34@gmail.com?part=3D2

