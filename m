Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B66606A324
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 19:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=CuQZt6Lq;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R++6T6X+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ypKkIoZaSkEKQ0+HiG+3vFco7+GxRkCVTGlWVAEEXOw=; b=CuQZt6LqgSQMYV8dXYWYu7JPGw
	zP0dxCL462NTadsbUY1uGKJsQtOXLJzUtEGiV1zxFluhWBnRgOi2ddn6zexvdHjka21hZabhS8sOC
	l6c3qCT30Y6XfW5aVhrcZrpb31Wv4OGQ/kI4M3FujQV+RfAWk2UtnTvQAgVAcEZzjf4Ab9oNEk0YN
	J0+Fo9ZThTe94G5Ui6LjYdnXUWFWUqs+ZdY6W5CGgPxchCPFrwf33znHwQUhZxNTIDJU8mWGlbflr
	dMXoA1PPY0HMDPXZidDn+9FLwpAHyk1sLTbjrlQwNkV65pBCyPghLOkgFMhbaFBdyo2znnXSHvFCN
	uEijsZdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOK9r-00000003Wo8-3Dao;
	Tue, 03 Nov 2026 19:26:59 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOK9q-00000003Wo2-1Op8
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 19:26:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9AC8960136;
	Tue,  3 Nov 2026 19:26:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A96A1F000C1;
	Tue,  3 Nov 2026 19:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793734017;
	bh=ypKkIoZaSkEKQ0+HiG+3vFco7+GxRkCVTGlWVAEEXOw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R++6T6X+62CxMr3Wm/zm/cck27MMHhEz2DXqauDgAp9bhPeYhFAB5kUJ9VPIel5IS
	 Trdr9x1qvUP3CgTY7WXgp6RTML3HR9n7hN4/7NtTQ7kQq+0Jeqv7IFo0eG8RNOrYfV
	 s/gtgJrfYmMTP5MyABe3IieJY6OubscU+KyM+nbQr8CVM4r+3/dRvHOzxbflTxN2n8
	 oFZTRPOQr7FV+a6mMjGZ0Set8GGZYtO9nj/E7uDQDYiEqjeKw5MeaK2dHDvTMUfCLC
	 0bsx91sBas683HL63CXgQP004p2dgYaanvs80S/sWkfAzkoi8gbHMzDcRoPigyu1IV
	 Ttij7X1eMPz9Q==
Message-ID: <sashiko-outbox-195914@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] nvme: reject completions for requests that are not in
 flight
To: "Mauricio Faria de Oliveira" <mfo@igalia.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261103-nvme-double-cmpl-uaf-blk-mq-v1-1-b10fea474423@igalia.com>
References: <20261103-nvme-double-cmpl-uaf-blk-mq-v1-1-b10fea474423@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 19:26:56 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] nvme: unratelimited dev_err() in nvme_find_rq() on completion ir=
q path
--

commit 2696cd6e7dfab32aa750573cdd163f831092e123
Author: Chao Shi <coshi036@gmail.com>

nvme: reject completions for requests that are not in flight

This commit checks that a request looked up in nvme_find_rq() is in the
MQ_RQ_IN_FLIGHT state before returning it for completion, avoiding a NULL
pointer dereference on rq->mq_hctx when a spurious completion matches an
idle request.

Link: https://lore.kernel.org/linux-nvme/20260522153034.2168862-1-coshi036@=
gmail.com/
Link: https://lore.kernel.org/linux-nvme/20260715005105.1115958-1-coshi036@=
gmail.com/

> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 2d8f681079e85..3ba0666da7be6 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -708,6 +708,11 @@ static inline struct request *nvme_find_rq(struct bl=
k_mq_tags *tags,
>  			tag, genctr, nvme_genctr_mask(nvme_req(rq)->genctr));
>  		return NULL;
>  	}
> +	if (unlikely(blk_mq_rq_state(rq) !=3D MQ_RQ_IN_FLIGHT)) {
> +		dev_err(nvme_req(rq)->ctrl->device,
> +			"completion for request %#x not in flight\n", tag);
> +		return NULL;
> +	}

[Severity: Medium]
Should this use dev_err_ratelimited() instead of dev_err()?

Commit c05c86681170 ("nvme: ratelimit the completion-path messages driven
by device data") switched the existing error messages in nvme_find_rq() and
nvme_handle_cqe() to ratelimited variants because device-supplied command
IDs are processed directly in interrupt context via
nvme_irq()->nvme_poll_cq()->nvme_handle_cqe()->nvme_find_rq() (as well as
in the apple, rdma, tcp, and loop completion handlers):

drivers/nvme/host/nvme.h:nvme_find_rq() {
	...
	rq =3D blk_mq_tag_to_rq(tags, tag);
	if (unlikely(!rq)) {
		pr_err_ratelimited("could not locate request for tag %#x\n",
				   tag);
		return NULL;
	}
	if (unlikely(nvme_genctr_mask(nvme_req(rq)->genctr) !=3D genctr)) {
		dev_err_ratelimited(nvme_req(rq)->ctrl->device,
			"request %#x genctr mismatch (got %#x expected %#x)\n",
			tag, genctr, nvme_genctr_mask(nvme_req(rq)->genctr));
		return NULL;
	}
}

Because nvme_find_rq() returns NULL before nvme_try_complete_req()
increments nvme_req(rq)->genctr, a malfunctioning controller or remote
Fabrics target sending repeated completions for an idle request with a
matching tag and generation counter will hit this path on every completion
and flood the kernel log from interrupt context.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-nvme-doubl=
e-cmpl-uaf-blk-mq-v1-1-b10fea474423@igalia.com?part=3D1

