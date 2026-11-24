Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118A0606A31E
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2026 05:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Vj7cODis;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FX4iqWn5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=VH6r9jMj6omA5/PglqP4/zkH6WUkWNa62390qhGmDZI=; b=Vj7cODis8F5gEeRct5cyJ0MFYl
	SLV4MnjU50gyYA67hhEGRsEPnJhGOBygvH5bf9uMFX20fgf1kZ3I+VU1ffwsSngiymfzBLirB1WUZ
	/29fkv6fsfFiwJokdH8SW+1S6mD3u0cLvkIibLu5DP7jPyiiZ5RdeUF3k1mp80HRb3BZreU/pVv2P
	gaOG+FO5Mack/j51R7Lt6ggy+Yx1g4fqWs3gjMgpKd6cyAthGyHI6lblo7A1UR9ek5TNXZUwFc5DN
	tuqjnycTlSdGPICl/r+BnOx3ojby+AwQ3+SnhbTjO5J3k/ZXaRocS2mgG3ea9rh+kY6TKfPnBmUyc
	SDXOQ/nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVjC3-00000005cQZ-0ifD;
	Tue, 24 Nov 2026 05:35:51 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVjC1-00000005cQQ-1nkU
	for linux-nvme@lists.infradead.org;
	Tue, 24 Nov 2026 05:35:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C03BD43861;
	Tue, 24 Nov 2026 05:35:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70281F000C6;
	Tue, 24 Nov 2026 05:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795498547;
	bh=VH6r9jMj6omA5/PglqP4/zkH6WUkWNa62390qhGmDZI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FX4iqWn59ZMcd3Ed+ZOab4QI0EmKs0cpWw+I7fUVBqNNxJKkzD76iAHd786DUw+4S
	 0LzASnRRyZIFzE3llTw1rbaEnHQ1SrFk6lmiwaowQfpgTN5YuB/WmQ0AhqCTZorKIk
	 41dW/vYOwMo5hcSZ5El7MlOIPI4DeUo0lRJ8KLfxb2dnkxjjFehwNBXbaZAc+Y8W3I
	 Lp06jgB2YvrstlU7kXHSCPgMsprE4Dpxm/MstBG8LVm6uZQ/Qh5ydYHSq0ei6v+7DQ
	 XU33whdPD5DxlZR9/miR2DUELTfLaC43SJfFMlGhmJtynB8MYz2VzmB+msApNzilkT
	 97M2ItOhQZ8VQ==
Message-ID: <sashiko-outbox-230556@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] nvme-tcp: set up R2T data transfer in the send
 path
To: "Zhenwen Liang" <zhenwenliang@google.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261124051041.3099796-3-zhenwenliang@google.com>
References: <20261124051041.3099796-1-zhenwenliang@google.com>
 <20261124051041.3099796-3-zhenwenliang@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 05:35:47 +0000
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

Thank you for your contribution! Sashiko AI review found 6 potential
issues to consider:
- [High] nvme-tcp: use-after-completion in nvme_tcp_try_send_cmd_pdu()
  on req->flags
- [High] nvme-tcp: early R2T in nvme_tcp_handle_r2t() corrupts req_list
  or bypasses CMD_SENT
- [High] nvme-tcp: clearing R2T_BUSY on final R2T allows duplicate or
  inline-write R2Ts
- [High] nvme-tcp: deferred R2T check lets nvme_tcp_process_nvme_cqe()
  complete queued req
- [Medium] nvme-tcp: clearing R2T_BUSY in nvme_tcp_setup_r2t() allows
  concurrent R2Ts
- [Medium] nvme-tcp: send failure in nvme_tcp_try_send() leaves
  R2T_READY on queued request
--

commit 323f0b4025551d9c40345790574456e643351f07
Author: Zhenwen Liang <zhenwenliang@google.com>

nvme-tcp: set up R2T data transfer in the send path

This commit records incoming R2T PDUs in struct nvme_tcp_request on the
receive path and defers exact offset validation and H2CData PDU setup to
the send path under send_mutex.

> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 4fa4b0199deef..b7a44b56b2f53 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
[ ... ]
> @@ -847,17 +866,25 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queu=
e *queue,
>  		return -EPROTO;
>  	}
> =20
> -	if (unlikely(r2t_length > req->data_len - req->data_sent)) {
> +	/*
> +	 * The send path may not have accounted the last bytes of the
> +	 * previous R2T yet, so data_sent can still be too small here (it is
> +	 * written by the send path, hence READ_ONCE()).  data_sent only
> +	 * grows, so these checks never reject a valid R2T;
> +	 * nvme_tcp_setup_r2t() checks the R2T exactly.
> +	 */
> +	data_sent =3D READ_ONCE(req->data_sent);
> +	if (unlikely(r2t_length > req->data_len - data_sent)) {
>  		dev_err(queue->ctrl->ctrl.device,
>  			"req %d r2t len %u exceeded data len %u (%zu sent)\n",
> -			rq->tag, r2t_length, req->data_len, req->data_sent);
> +			rq->tag, r2t_length, req->data_len, data_sent);
>  		return -EPROTO;
>  	}
> =20
> -	if (unlikely(r2t_offset !=3D req->data_sent)) {
> +	if (unlikely(r2t_offset < data_sent)) {
>  		dev_err(queue->ctrl->ctrl.device,
>  			"req %d unexpected r2t offset %u (expected %zu)\n",
> -			rq->tag, r2t_offset, req->data_sent);
> +			rq->tag, r2t_offset, data_sent);
>  		return -EPROTO;
>  	}
> =20
> @@ -869,12 +896,28 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queu=
e *queue,
>  		return -EPROTO;
>  	}
> =20
> -	req->pdu_len =3D 0;
> -	req->h2cdata_left =3D r2t_length;
> -	req->h2cdata_offset =3D r2t_offset;
> -	req->ttag =3D pdu->ttag;
> +	/* Only one R2T may be outstanding (we advertise maxr2t =3D 0). */
> +	if (test_and_set_bit(NVME_TCP_REQ_R2T_BUSY, &req->flags)) {
> +		dev_err(queue->ctrl->ctrl.device,
> +			"req %d unexpected r2t while another r2t is pending\n",
> +			rq->tag);
> +		return -EPROTO;
> +	}

[Severity: High]
Can an R2T arriving before the command PDU is sent corrupt queue->req_list
or bypass the NVME_TCP_REQ_CMD_SENT check?

nvme_tcp_setup_cmd_pdu() initializes req->flags =3D 0 (with
NVME_TCP_REQ_R2T_BUSY clear), and nvme_tcp_handle_r2t() does not check
NVME_TCP_REQ_CMD_SENT.  In nvme_tcp_queue_rq(), nvme_start_request(rq)
makes rq visible to nvme_find_rq() before nvme_tcp_queue_request() adds
req->lentry to queue->req_list:

CPU0                                  CPU1
nvme_tcp_queue_rq()
  nvme_start_request(rq)
                                      nvme_tcp_handle_r2t()
                                        nvme_find_rq() -> rq
                                        llist_on_list(&req->lentry) =3D=3D =
false
                                        test_and_set_bit(R2T_BUSY) =3D=3D f=
alse
                                        llist_add(&req->lentry,
                                                  &queue->req_list)
  nvme_tcp_queue_request()
    llist_add(&req->lentry,
              &queue->req_list)  <-- duplicate llist_add() cycles req_list

A second window opens after nvme_tcp_fetch_request() pops req into
queue->request and clears req->entry and req->lentry.  If an R2T arrives
while nvme_tcp_try_send_cmd_pdu() is sending the command PDU (or waiting
to retry after -EAGAIN), nvme_tcp_handle_r2t() accepts it and queues req
onto queue->req_list.  When nvme_tcp_try_send_cmd_pdu() then finishes
sending the command PDU, it sets NVME_TCP_REQ_CMD_SENT, so the later
nvme_tcp_setup_r2t() sees NVME_TCP_REQ_CMD_SENT set (and for inline-data
writes req remains active in queue->request in NVME_TCP_SEND_DATA while
also queued on queue->req_list).

> =20
> -	nvme_tcp_setup_h2c_data_pdu(req);
> +	/*
> +	 * The controller can send this R2T as soon as it has the last bytes
> +	 * of the previous one, while nvme_tcp_try_send_data() has not yet
> +	 * updated data_sent and pdu_sent for them.  Do not touch the send
> +	 * state here; record the R2T and let nvme_tcp_try_send() set it up
> +	 * when it takes the request off the list.  llist_add() orders these
> +	 * stores before the request is visible on req_list.
> +	 */
> +	req->r2t_ttag =3D pdu->ttag;
> +	req->r2t_offset =3D r2t_offset;
> +	req->r2t_length =3D r2t_length;
> +	/* Pairs with test_bit_acquire() in nvme_tcp_try_send() */
> +	smp_mb__before_atomic();
> +	set_bit(NVME_TCP_REQ_R2T_READY, &req->flags);
> =20
>  	llist_add(&req->lentry, &queue->req_list);
>  	queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);

[Severity: High]
Because nvme_tcp_handle_r2t() defers the r2t_offset !=3D req->data_sent
check to the send path, it now queues req onto queue->req_list and returns
0 for an R2T with r2t_offset > data_sent.  Can a subsequent CQE on the
receive path complete rq while req->lentry is still on queue->req_list?

When nvme_tcp_handle_r2t() returns 0, nvme_tcp_recv_skb() keeps
queue->rd_enabled set and continues processing PDUs.  If the controller
follows the bad R2T with a response CQE before the send path runs
nvme_tcp_setup_r2t(), nvme_tcp_process_nvme_cqe() completes rq while req
is still linked on queue->req_list or queue->send_list.

> @@ -1320,6 +1363,7 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tc=
p_request *req)
> =20
>  	len -=3D ret;
>  	if (!len) {
> +		set_bit(NVME_TCP_REQ_CMD_SENT, &req->flags);
>  		if (inline_data) {
>  			req->state =3D NVME_TCP_SEND_DATA;
>  			if (queue->data_digest)

[Severity: High]
Can set_bit(NVME_TCP_REQ_CMD_SENT, &req->flags) modify req after the
request has already been completed and reallocated?

For any command with !inline_data, the command PDU is the final bytes sent
before the controller can reply with a CQE:

CPU0 (send path)                      CPU1 (receive / submit)
nvme_tcp_try_send_cmd_pdu()
  sock_sendmsg()
                                      nvme_tcp_process_nvme_cqe()
                                        nvme_complete_rq(rq)
                                      ...
                                      nvme_tcp_setup_cmd_pdu()
                                        req->flags =3D 0;
  set_bit(NVME_TCP_REQ_CMD_SENT,
          &req->flags)  <-- overwrites new request's flags

Setting NVME_TCP_REQ_CMD_SENT on the reallocated request before its own
command PDU is sent defeats the NVME_TCP_REQ_CMD_SENT check for that new
request.

> @@ -1401,20 +1445,77 @@ static int nvme_tcp_try_send_ddgst(struct nvme_tc=
p_request *req)
>  	return -EAGAIN;
>  }
> =20
> +static int nvme_tcp_setup_r2t(struct nvme_tcp_request *req)
> +{
> +	struct nvme_tcp_queue *queue =3D req->queue;
> +	struct request *rq =3D blk_mq_rq_from_pdu(req);
> +
> +	if (unlikely(!test_bit(NVME_TCP_REQ_CMD_SENT, &req->flags))) {
> +		dev_err(queue->ctrl->ctrl.device,
> +			"req %d unexpected r2t before the command was sent\n",
> +			rq->tag);
> +		return -EPROTO;
> +	}
> +
> +	if (unlikely(req->r2t_length > req->data_len - req->data_sent)) {
> +		dev_err(queue->ctrl->ctrl.device,
> +			"req %d r2t len %u exceeded data len %u (%zu sent)\n",
> +			rq->tag, req->r2t_length, req->data_len, req->data_sent);
> +		return -EPROTO;
> +	}
> +
> +	if (unlikely(req->r2t_offset !=3D req->data_sent)) {
> +		dev_err(queue->ctrl->ctrl.device,
> +			"req %d unexpected r2t offset %u (expected %zu)\n",
> +			rq->tag, req->r2t_offset, req->data_sent);
> +		return -EPROTO;
> +	}
> +
> +	req->pdu_len =3D 0;
> +	req->h2cdata_left =3D req->r2t_length;
> +	req->h2cdata_offset =3D req->r2t_offset;
> +	req->ttag =3D req->r2t_ttag;
> +	/*
> +	 * The R2T is copied; accept the next one.  Pairs with
> +	 * test_and_set_bit() in nvme_tcp_handle_r2t().  On error the bits
> +	 * stay set, so no further R2T is accepted for this request.
> +	 */
> +	clear_bit(NVME_TCP_REQ_R2T_READY, &req->flags);
> +	clear_bit_unlock(NVME_TCP_REQ_R2T_BUSY, &req->flags);

[Severity: Medium]
Does clearing NVME_TCP_REQ_R2T_BUSY here allow a second R2T to be accepted
while the first R2T is still being sent?

nvme_tcp_fetch_request() has already cleared req->entry and req->lentry,
and nvme_tcp_setup_r2t() clears NVME_TCP_REQ_R2T_BUSY before any H2CData
PDU bytes are transmitted.  While req remains in queue->request sending the
first R2T (for example, across multiple H2CData PDUs or -EAGAIN retries),
both the list checks and test_and_set_bit(NVME_TCP_REQ_R2T_BUSY) in
nvme_tcp_handle_r2t() will pass for a second R2T with r2t_offset at the
end of the first R2T, queuing req onto queue->req_list while it is still
active in queue->request.

> +
> +	nvme_tcp_setup_h2c_data_pdu(req);
> +	return 0;
> +}

[Severity: High]
What prevents a duplicate final R2T or an R2T on an inline-data write from
being accepted and re-sending data after all payload bytes have already
been transmitted?

In nvme_tcp_try_send_data(), nvme_tcp_advance_req() is skipped on the
final payload send of a request:

drivers/nvme/host/tcp.c:nvme_tcp_try_send_data() {
    ...
		if (req_data_sent + ret < req_data_len)
			nvme_tcp_advance_req(req, ret);
    ...
}

Because req->data_sent is not updated on the last send, and
nvme_tcp_setup_r2t() clears NVME_TCP_REQ_R2T_BUSY even when the R2T covers
the remainder of the request (req->r2t_length =3D=3D req->data_len -
req->data_sent), a single-R2T write (or an inline write, which never sets
NVME_TCP_REQ_R2T_BUSY) finishes sending with req->data_sent =3D=3D 0,
NVME_TCP_REQ_CMD_SENT =3D=3D 1, and NVME_TCP_REQ_R2T_BUSY =3D=3D 0.  A dupl=
icate
R2T with r2t_offset =3D=3D 0 then passes both nvme_tcp_handle_r2t() and
nvme_tcp_setup_r2t(), re-queuing req onto queue->req_list while the
request can complete concurrently on the receive path.

[ ... ]

> @@ -1443,7 +1544,16 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue=
 *queue)
>  	} else if (ret < 0) {
>  		dev_err(queue->ctrl->ctrl.device,
>  			"failed to send request %d\n", ret);
> -		nvme_tcp_fail_request(queue->request);
> +		/*
> +		 * If the receive path has already accepted an R2T, the request
> +		 * is queued again and must not be completed here; leave it to
> +		 * the error recovery.  Otherwise the bit now blocks later R2Ts.
> +		 */
> +		if (test_and_set_bit(NVME_TCP_REQ_R2T_BUSY,
> +				     &queue->request->flags))
> +			nvme_tcp_error_recovery(&queue->ctrl->ctrl);
> +		else
> +			nvme_tcp_fail_request(queue->request);
>  		nvme_tcp_done_send_req(queue);
>  	}

[Severity: Medium]
When test_and_set_bit(NVME_TCP_REQ_R2T_BUSY, &queue->request->flags) sees
that the receive path has already queued req onto queue->req_list, can a
subsequent nvme_tcp_try_send() pick req back up before err_work stops the
queue?

nvme_tcp_done_send_req() clears queue->request while req remains on
queue->req_list with NVME_TCP_REQ_R2T_READY set, and nvme_tcp_io_work()
re-queues queue->io_work after breaking out of its send loop on result < 0.
Before asynchronous error recovery stops the queue, the next
nvme_tcp_try_send() fetches req and calls nvme_tcp_setup_r2t(req).  If
req->r2t_offset =3D=3D req->data_sent (for example, when sending the data
digest failed in nvme_tcp_try_send_ddgst() after nvme_tcp_try_send_data()
already advanced req->data_sent for the payload), nvme_tcp_setup_r2t()
succeeds, clears NVME_TCP_REQ_R2T_BUSY, and resumes sending the failed
request; if that send also fails, test_and_set_bit(NVME_TCP_REQ_R2T_BUSY)
is now false and nvme_tcp_fail_request() completes the request.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124051041.3099=
796-1-zhenwenliang@google.com?part=3D2

