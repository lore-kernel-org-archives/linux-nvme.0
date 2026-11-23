Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C22606A31E
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 23:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=0xkWHQ4y;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cp/gHmxs
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=tJolaML7nXh+/zMsnr4Tk6vVra5UcnATgeuQ+8ROjZI=; b=0xkWHQ4yo5xQCr6zmqMbT8NP+5
	dWITSAdj0LEytAlIZkg4W+nGYgM7vX2YIwEMbv++Qw8cYiUX+bHfqT7LEMcihioBImC/6v59905za
	mJZb7EmBSuf45zOX011KhzDZggBdEZWtib61rgmTp3z842ZCYZ+QjSqbzKBd3wHVusFHVNvfO9im1
	oIk6S9Q/0ydx58VNGHexpXVju0b3JsjpsNLBWES8Ag/uWktPMVXbdIZdzgOkgXOHS5BcgInUlu7su
	bynvrBgV1iht93GkibSDvMjFfaqLbsHI4NiFAjl1gmlA7cOGyl4v8UkPj9ZNcUMvhJHfE/0a6/Zhp
	nYlnK/9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVd9y-0000000580v-2raw;
	Mon, 23 Nov 2026 23:09:18 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVd9w-0000000580o-3KrL
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 23:09:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9AC1260ED5;
	Mon, 23 Nov 2026 23:09:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE531F000D1;
	Mon, 23 Nov 2026 23:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795475354;
	bh=tJolaML7nXh+/zMsnr4Tk6vVra5UcnATgeuQ+8ROjZI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cp/gHmxsDAffzUTooCInyoCeUIeiuT/oL01Al9+1LhW189WeLhDmokr//kDuU356K
	 OKixjp4GmKHCtvlCG8/LEEXGLVisVAUIq1wV18yAo5D4p9rC5lOB1+od7Uyt0iTMD5
	 lmz6iI9QT6GU+qMXhpdumBIQmBR0YzrNKz6BGEFZACVr8ldV5aqEyuw3AAbRSAemzU
	 Ek4e29HjgigWey/BA2fy4NDxUXdgYszLAWjavSNYuEPU4r+Ukqw6CPIfjNJz77NMKX
	 ijJKvzdBNIy07MHlj546fpPNVw779Yu8JgFsF7k8yIUpPCmxzSm9EUddkvYMIu8ZKk
	 i/x+j9QR45tVA==
Message-ID: <sashiko-outbox-230185@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] nvme-tcp: set up R2T data transfer in the send path
To: "Zhenwen Liang" <zhenwenliang@google.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261123225246.1653658-1-zhenwenliang@google.com>
References: <20261114020250679P6SJTYtDDk-oB-bT_GjsW@zte.com.cn>
 <20261123225246.1653658-1-zhenwenliang@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 23:09:13 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] nvme-tcp: r2t_pending race in nvme_tcp_handle_r2t() and
  nvme_tcp_setup_r2t()
- [Medium] nvme-tcp: 32-bit overflow in r2t_length check in
  nvme_tcp_setup_r2t()
- [Medium] nvme-tcp: use-after-completion on send error after
  nvme_tcp_handle_r2t()
--

commit 7be091feb52782cced17a5c0c1c30a0e41652084
Author: Zhenwen Liang <zhenwenliang@google.com>

nvme-tcp: set up R2T data transfer in the send path

This commit defers H2CData PDU setup and exact R2T validation from
nvme_tcp_handle_r2t() in the receive path to nvme_tcp_try_send() in the
send path so that R2T handling does not race with req->data_sent and
req->pdu_sent updates after sock_sendmsg().

> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 62a594b8ab9bf..28a5d6da8f18c 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
[ ... ]
> @@ -847,17 +853,25 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queu=
e *queue,
>  		return -EPROTO;
>  	}
> =20
> -	if (unlikely(req->data_sent + r2t_length > req->data_len)) {
> +	/*
> +	 * The send path may not have accounted the last bytes of the
> +	 * previous R2T yet, so data_sent can still be too small here (it is
> +	 * written by the send path, hence READ_ONCE()).  data_sent only
> +	 * grows, so these checks never reject a valid R2T;
> +	 * nvme_tcp_setup_r2t() checks the R2T exactly.
> +	 */
> +	data_sent =3D READ_ONCE(req->data_sent);
> +	if (unlikely(data_sent + r2t_length > req->data_len)) {
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
> @@ -869,12 +883,18 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queu=
e *queue,
>  		return -EPROTO;
>  	}
> =20
> -	req->pdu_len =3D 0;
> -	req->h2cdata_left =3D r2t_length;
> -	req->h2cdata_offset =3D r2t_offset;
> -	req->ttag =3D pdu->ttag;
> -
> -	nvme_tcp_setup_h2c_data_pdu(req);
> +	/*
> +	 * The controller can send this R2T as soon as it has the last bytes
> +	 * of the previous one, while nvme_tcp_try_send_data() has not yet
> +	 * updated data_sent and pdu_sent for them.  Do not touch the send
> +	 * state here; record the R2T and let nvme_tcp_try_send() set it up
> +	 * when it takes the request off the list.  llist_add() orders these
> +	 * stores before the request is visible on req_list.
> +	 */
> +	WRITE_ONCE(req->r2t_ttag, pdu->ttag);
> +	WRITE_ONCE(req->r2t_offset, r2t_offset);
> +	WRITE_ONCE(req->r2t_length, r2t_length);
> +	req->r2t_pending =3D true;
> =20
>  	llist_add(&req->lentry, &queue->req_list);
>  	queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);

[Severity: Medium]
Can an early R2T leave a completed request linked on queue->req_list when a
send fails?

While req is actively being sent as queue->request, both req->lentry and
req->entry are empty.  Relaxing the offset check to r2t_offset < data_sent
allows an R2T with r2t_offset >=3D data_sent to pass while req is still
mid-send (for instance paused across -EAGAIN or sending its data digest) and
queue req->lentry onto queue->req_list.  If the active send then fails with
an error other than -EAGAIN, nvme_tcp_try_send() completes the request via
nvme_tcp_fail_request(queue->request) while req->lentry is still on
queue->req_list:

CPU0 (send path)                  CPU1 (recv path)
nvme_tcp_try_send()
  queue->request =3D
    nvme_tcp_fetch_request(queue)
                                  nvme_tcp_handle_r2t()
                                    r2t_offset >=3D data_sent
                                    llist_add(&req->lentry,
                                              &queue->req_list)
  nvme_tcp_try_send_data(req)
    sock_sendmsg() -> -EPIPE
  nvme_tcp_fail_request(req)
    nvme_tcp_end_request(rq, ...)
                                  nvme_tcp_process_req_list()
                                    <-- processes completed req

When queue->req_list is next drained, the completed request is processed
again, or if its tag was reallocated and re-queued, queue->req_list forms a
cycle.

> @@ -1401,20 +1421,72 @@ static int nvme_tcp_try_send_ddgst(struct nvme_tc=
p_request *req)
>  	return -EAGAIN;
>  }
> =20
> +static int nvme_tcp_setup_r2t(struct nvme_tcp_request *req)
> +{
> +	struct nvme_tcp_queue *queue =3D req->queue;
> +	struct request *rq =3D blk_mq_rq_from_pdu(req);
> +	/*
> +	 * Read the recorded R2T once: a controller that violates the protocol
> +	 * could send another R2T and rewrite these fields meanwhile.
> +	 */
> +	u32 r2t_length =3D READ_ONCE(req->r2t_length);
> +	u32 r2t_offset =3D READ_ONCE(req->r2t_offset);
> +	u16 r2t_ttag =3D READ_ONCE(req->r2t_ttag);
> +
> +	req->r2t_pending =3D false;

[Severity: Medium]
Can nvme_tcp_setup_r2t() race with a concurrent nvme_tcp_handle_r2t() and
clear req->r2t_pending after req has been re-added to queue->req_list?

nvme_tcp_fetch_request() clears req->entry and req->lentry before
nvme_tcp_setup_r2t() runs, and nvme_tcp_handle_r2t() only checks
llist_on_list(&req->lentry) || !list_empty(&req->entry) (not
req->r2t_pending or req->state =3D=3D NVME_TCP_SEND_CMD_PDU).  If a non-con=
forming
controller sends another R2T in that window, nvme_tcp_handle_r2t() can
overwrite the r2t_* fields and re-queue req on queue->req_list right before
nvme_tcp_setup_r2t() sets req->r2t_pending =3D false:

CPU0 (send path)                  CPU1 (recv path)
nvme_tcp_try_send()
  nvme_tcp_fetch_request()
    list_del_init(&req->entry)
    init_llist_node(&req->lentry)
                                  nvme_tcp_handle_r2t()
                                    WRITE_ONCE(req->r2t_*, ...)
                                    req->r2t_pending =3D true
                                    llist_add(&req->lentry,
                                              &queue->req_list)
  nvme_tcp_setup_r2t()
    req->r2t_pending =3D false  <-- clobbers pending flag for queued req

Besides reading a torn combination of r2t_length, r2t_offset, and r2t_ttag
or clobbering NVME_TCP_SEND_CMD_PDU before the initial command PDU is sent,
the second fetch from queue->req_list sees req->r2t_pending =3D=3D false, s=
kips
nvme_tcp_setup_r2t(), and re-enters the send state machine in the stale
state of the finished transfer.

> +
> +	if (unlikely(req->data_sent + r2t_length > req->data_len)) {
> +		dev_err(queue->ctrl->ctrl.device,
> +			"req %d r2t len %u exceeded data len %u (%zu sent)\n",
> +			rq->tag, r2t_length, req->data_len, req->data_sent);
> +		return -EPROTO;
> +	}

[Severity: Medium]
Can req->data_sent + r2t_length wrap around on 32-bit architectures?

On 32-bit kernels size_t is 32 bits, so adding u32 r2t_length to
req->data_sent (and to data_sent in nvme_tcp_handle_r2t()) can wrap around
when req->data_sent > 0 and bypass the req->data_len check.
nvme_tcp_setup_h2c_data_pdu() then sets req->pdu_len larger than the
remaining payload bytes in the request; once nvme_tcp_try_send_data() sends
the last actual payload byte (req_data_sent + ret =3D=3D req_data_len), it =
stops
calling nvme_tcp_advance_req(), so req->pdu_sent stops advancing and the
send loop spins indefinitely.

Checking r2t_length > req->data_len - req->data_sent (after verifying
req->data_sent <=3D req->data_len) avoids the overflow.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123225246.1653=
658-1-zhenwenliang@google.com?part=3D1

