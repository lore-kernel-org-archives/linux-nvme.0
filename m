Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E13606A897
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 03:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=F+sMnXUH;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xr6AK/Mu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=k/yp0EQ3u979bMW2ePdKGcLl5vB9hfDHr8pGWVMCVS8=; b=F+sMnXUHPHzYL5KwTFbP9Pnk5z
	UI50Prn08/57Mo1H2sCAcC1LuO4O5PpWdfngwQxry/2l9Hs6ZYoheYGu5KPCTvAUEynV/dQC4ilnh
	aslANiaWXyK8zAUET4kbeoXnSRW/JTaSx5he11M1XqzW7XZ8P3urviiBtaFbaopddG/QpXQKZDC+I
	XcbQvTttcVoITAGstnDyOQO7/HPC1NgBmZ1tsvyUIdXY9GI+RQ230fsIp52A+Le8kBgfBoUCzfXmH
	y6/rP37xewFV24TEVi6KRwsjPVfSJfZIgaIS/3hEjjwYhb/DUnyhkPWZe9IveTnRhr9nd3bGQjKSx
	+NSSRzXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS4SM-0000000FGg2-06GM;
	Sat, 14 Nov 2026 03:29:34 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS4SL-0000000FGfa-0637
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 03:29:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6845F4132F;
	Sat, 14 Nov 2026 03:29:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E26D1F000C4;
	Sat, 14 Nov 2026 03:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794626972;
	bh=k/yp0EQ3u979bMW2ePdKGcLl5vB9hfDHr8pGWVMCVS8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xr6AK/MuOzJ0/wTcH39xjAok9VuR5izn5cxOqMQlnTFA74mzpZDDJPO4Nmr3mQuZW
	 zU5dNU2jC0jWRTPwXDmPNG5TkoSgTJq+Ea9CRmN7LNm1HyVkm8bGqRMsn0N7q30TSe
	 B/8UGFJChYkD7/IHS7V8MQVXW2RKKkFwnZXfKVwf83rDGg+Inpw9MtCEWweYc0Ow+y
	 bRfFXsEPpwROoGrus0gxSfWRkuGC25T0Z0asnjEPbRdfEheTfwkxqW+7ztMtspjqV4
	 gCXUYiC01pE9ThwY3+fVyghebshJvj9ANdLVtSW3/Lb4KwS21uyq3g6oKLy0ATrhe1
	 Oi4GUaEPzVXyg==
Message-ID: <sashiko-outbox-214110@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/17] nvme: Introduce FENCING and FENCED controller
 states
To: "Mohamed Khalfella" <mkhalfella@purestorage.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261114030454.2836543-8-mkhalfella@purestorage.com>
References: <20261114030454.2836543-1-mkhalfella@purestorage.com>
 <20261114030454.2836543-8-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 03:29:31 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] nvme: premature non-mpath I/O failure in
  nvme_fail_nonready_command()
- [Medium] nvme: live queues re-enabled in nvme_check_ready() when
  deleting from FENCING
--

commit 78ddca4023a9ef3590c04ed05791d87621f68277
Author: Mohamed Khalfella <mkhalfella@purestorage.com>

nvme: Introduce FENCING and FENCED controller states

This commit adds the NVME_CTRL_FENCING and NVME_CTRL_FENCED controller
states along with their state machine transitions, readiness checks,
multipath path availability handling, and sysfs state names.

> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 38b27d8db0119..4be3ce2e72a78 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c

[ ... ]

> @@ -622,6 +641,8 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>  		case NVME_CTRL_LIVE:
>  		case NVME_CTRL_RESETTING:
>  		case NVME_CTRL_CONNECTING:
> +		case NVME_CTRL_FENCING:
> +		case NVME_CTRL_FENCED:
>  			changed =3D true;
>  			fallthrough;
>  		default:

[Severity: Medium]
When a controller in NVME_CTRL_FENCING or NVME_CTRL_FENCED transitions
to NVME_CTRL_DELETING, can new I/O be dispatched onto its still-live
queues while nvme_stop_ctrl() waits for fencing to finish?

While in NVME_CTRL_FENCING, the transport queues remain live and new
requests are blocked only because __nvme_check_ready() and
nvme_path_get_state() reject NVME_CTRL_FENCING and NVME_CTRL_FENCED.
In nvme_do_delete_ctrl(), ctrl->state stays NVME_CTRL_DELETING across
nvme_stop_ctrl() until nvme_remove_namespaces() sets
NVME_CTRL_DELETING_NOIO, and both nvme_check_ready() and
nvme_path_get_state() treat NVME_CTRL_DELETING on a live queue as ready
and enabled:

drivers/nvme/host/nvme.h:nvme_check_ready() {
	if (likely(state =3D=3D NVME_CTRL_LIVE))
		return true;
	if (ctrl->ops->flags & NVME_F_FABRICS && state =3D=3D NVME_CTRL_DELETING)
		return queue_live;
	return __nvme_check_ready(ctrl, rq, queue_live, state);
}

drivers/nvme/host/multipath.c:nvme_path_get_state() {
	if (state !=3D NVME_CTRL_LIVE && state !=3D NVME_CTRL_DELETING)
		return NVME_PATH_DISABLED_CTRL_DOWN;
}

As a result, deleting a fencing controller re-enables multipath
selection and allows new requests to be queued to the broken controller
throughout the fence wait instead of failing over immediately.

> @@ -786,6 +807,8 @@ blk_status_t nvme_fail_nonready_command(struct nvme_c=
trl *ctrl,
> =20
>  	if (state !=3D NVME_CTRL_DELETING_NOIO &&
>  	    state !=3D NVME_CTRL_DELETING &&
> +	    state !=3D NVME_CTRL_FENCING &&
> +	    state !=3D NVME_CTRL_FENCED &&
>  	    state !=3D NVME_CTRL_DEAD &&
>  	    !test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags) &&
>  	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))

[Severity: High]
Does excluding NVME_CTRL_FENCING and NVME_CTRL_FENCED here cause
non-multipath I/O to fail immediately with BLK_STS_TRANSPORT during
fencing?

Multipath requests (REQ_NVME_MPATH or REQ_FAILFAST_TRANSPORT) already
bypass the BLK_STS_RESOURCE return via the trailing checks and call
nvme_host_path_error(rq), so excluding NVME_CTRL_FENCING and
NVME_CTRL_FENCED here only changes the behavior for normal
non-multipath requests.  Because the queues are not quiesced during
NVME_CTRL_FENCING, nvme_host_path_error() -> nvme_complete_rq() ->
nvme_decide_disposition() returns RETRY, and nvme_retry_req() requeues
the request with zero delay until nvme_max_retries is exhausted in a
tight loop, after which __nvme_end_req() logs an uninitialized
nr->cmd->common.opcode in nvme_log_error() (since nvme_check_ready()
failed before nvme_setup_cmd()) and fails the I/O to the caller.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114030454.2836=
543-1-mkhalfella@purestorage.com?part=3D7

