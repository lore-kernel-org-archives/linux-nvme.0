Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A917B606A328
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 10:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wVf4n1GH;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bium94FB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=O0fjQPq1Utyp/JkUxjjN8JTyQO1cujYP6iXiE7tPsow=; b=wVf4n1GHxV9MrEfaF6tosYhAGk
	QWm1m3m0z3eIPRyL3tjK6+R7VCSumsFvOH7RwN45vvRr6lVHzkEs6jTqmaDsOc7p/mzWYD20/2wBm
	o2+u32g5ndkzZJVEehCGYjn4/9RVWP7yrPFIrZvKAjCAgsZ6MDt6kawvgptZuRopuoMCj2ImqJELY
	IwAB5B8jnm60Ogmb5pGM7y2nXN4JRUDiPhRTxjLR2FCNUrZnzoohcNuhi5H4OQPygAvu6UpKcMOc8
	pRoMad5drJEnekgE/8ozMl9hVSAbtUOgvfrnSZu7uCnOaZWqjD28tO2NESSJemb8wXSL14wLIs1xt
	gibywtUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOXx4-00000004xrt-3CMX;
	Wed, 04 Nov 2026 10:10:42 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOXx3-00000004xr8-2IEH
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 10:10:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 01BCF408CE;
	Wed,  4 Nov 2026 10:10:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1AC91F00A16;
	Wed,  4 Nov 2026 10:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793787040;
	bh=O0fjQPq1Utyp/JkUxjjN8JTyQO1cujYP6iXiE7tPsow=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bium94FBITv3iUpQ8gmXJOT/Ph5EOQHa1bWxu2gTS0sxJ+TFqKvelKSWWEg93AkDr
	 rR130rQ/qQv3mj+dYY+fIl6U12OZb9g1uceGppTOinlKXne8iFlIKejWN5pP/ElnPe
	 pOCwApOVWQUdf0pbaE1JaFxmK9nuY3aO4CQQSxFk0El4ndb4pJOLM+QKaobZJrjPrg
	 /EseSBMKe6jNJzuQQ+lkyYfFqygMY2FE4Cc6xTfzONEwCehSM1W30p0JpwaPp/NCEV
	 uZ9lgPj1ZEr7aMyq76UB6h4yWRvVogbZv1xleWDDACPPt9xn3fjydUX429AauZhuOq
	 OuYuZXN/x9mPA==
Message-ID: <sashiko-outbox-197048@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] nvme: stop asynchronous event work before ANA teardown
To: "Yaohan Li" <shunsheng1218@gmail.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <179378587000.73780.18152328009023418065@gmail.com>
References: <179378587000.73780.18152328009023418065@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 10:10:40 +0000
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
- [Low] nvme: inaccurate comment on async_event_work in nvme_uninit_ctrl()
--

commit ce7eff9e841922523de71205d5552ff0e0d5e58d
Author: Yaohan Li <shunsheng1218@gmail.com>

nvme: stop asynchronous event work before ANA teardown

This commit cancels async_event_work in nvme_uninit_ctrl() and ana_work in
nvme_mpath_uninit() to prevent use-after-free during controller teardown.

> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index a7a4d09644c13..017aae1189de1 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -5182,6 +5182,15 @@ EXPORT_SYMBOL_GPL(nvme_start_ctrl);
>  void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
>  {
>  	nvme_stop_keep_alive(ctrl);
> +
> +	/*
> +	 * Stop the async event worker before the final put: it processes
> +	 * ANA change events by re-queueing ctrl->ana_work, which is
> +	 * embedded in ctrl and cancelled in nvme_free_ctrl(); a worker
> +	 * running past that point would re-queue it onto freed memory.
> +	 */
> +	cancel_work_sync(&ctrl->async_event_work);

[Severity: Low]
This isn't a bug in the code change itself, but is the explanation in this
comment and in the commit message accurate about how ctrl->ana_work gets
requeued?

Looking at drivers/nvme/host/core.c, ctrl->async_event_work runs
nvme_async_event_work(), which only sends a uevent and resubmits an async
event request if the controller is live:

static void nvme_async_event_work(struct work_struct *work)
{
	struct nvme_ctrl *ctrl =3D
		container_of(work, struct nvme_ctrl, async_event_work);

	nvme_aen_uevent(ctrl);

	if (nvme_ctrl_state(ctrl) =3D=3D NVME_CTRL_LIVE)
		ctrl->ops->submit_async_event(ctrl);
}

Instead, ctrl->ana_work is queued synchronously from the AEN completion path
nvme_complete_async_event() -> nvme_handle_aen_notice() before
nvme_complete_async_event() queues ctrl->async_event_work:

	case NVME_AER_NOTICE_ANA:
		if (!ctrl->ana_log_buf)
			break;
		queue_work(nvme_wq, &ctrl->ana_work);
		break;

In addition, nvme_scan_work() (flushed in nvme_remove_namespaces() after
nvme_stop_ctrl()) and nvme_failover_req() can also queue ctrl->ana_work
after nvme_stop_ctrl() has run.

Cancelling ctrl->async_event_work in nvme_uninit_ctrl() is still needed
because nvme_complete_async_event() queues ctrl->async_event_work and the
work item is embedded in struct nvme_ctrl (and accesses ctrl->aen_result,
ctrl->device->kobj, and ctrl->state), rather than because
nvme_async_event_work() requeues ctrl->ana_work.

Could the comment in nvme_uninit_ctrl() and the commit message be updated to
reflect the actual paths that queue ctrl->async_event_work and
ctrl->ana_work?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179378587000.73780.=
18152328009023418065@gmail.com?part=3D1

