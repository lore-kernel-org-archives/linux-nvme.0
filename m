Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CF4606A31F
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2026 10:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=SvOnx4p2;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KdTvWrho
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6A6yJDChGAjnhYV4h08pUIFeRVH5G9WSjV0B9ydYDgo=; b=SvOnx4p2KUdcVZZU8lzx3J1xnD
	5mehv/4dVn5ols48bvFaoLxPfOFX01r8YWSpfWWpSFpVHrTVsdJ7zF3/CSBXFY9irDEXvPCdbP7YD
	hevlK879eezEX2ZmVDb3eum52t4wO3pZRdXtq2YwlS7nExTiuhB2tuzVO7fmatNu9oUaz1P9DZl0Y
	VIGO+ELPO3jXWr0krd9lT0lMIjoSKH2RUkAAl7+jXEF8Dht8QQ2kcbxeI9ZsRqicgen6tOjEAum8g
	Ap12VBv4yf7fk02RzayPWt/XmEQoRW2rP4faNQgRnI8x5P6aIIewEq4VGKDnCB7mAtFzxRE5Pq/ZO
	lwruMA2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKCuS-0000000GBgb-3GLz;
	Fri, 23 Oct 2026 10:54:04 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKCuQ-0000000GBgI-3dEs
	for linux-nvme@lists.infradead.org;
	Fri, 23 Oct 2026 10:54:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5125D41701;
	Fri, 23 Oct 2026 10:54:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159B71F01828;
	Fri, 23 Oct 2026 10:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792752842;
	bh=6A6yJDChGAjnhYV4h08pUIFeRVH5G9WSjV0B9ydYDgo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KdTvWrhomHZEOnevSlKT/BLC6bRShnA19UBejCXcvL11lmqm2aavrdPl7zyu6QP0T
	 9xpReuYm1UkvTxldB1LsB3F9L34Zf/InRogMSdA0LDRtzbfi/6qsPy9BW2+rwp3yrA
	 odlC5ritvj/Jtr6ZoVw75kwaEAwhLi8sSaSQVnMV+Khoq1zNhWSmUjXwhORTXO1Udh
	 jxcuTOVilDTWUq7XXwSbGSTiaFVKs5wOTJO6Yfs+/lrlarvQFfR6JVRVO5UtkRE+E1
	 q1xqDHuYEiSspdIfZR88bAWJYnac+RvbMFZALv/ciVdxNS9WkO6vlDglT4rValp4c5
	 0mWFruTDGs/zw==
Message-ID: <sashiko-outbox-182710@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] nvme-pci: disable accessible controller on error paths
To: "Eduard Zateev" <hackerowskiy@gmail.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261023101825.139040-1-hackerowskiy@gmail.com>
References: <20261023101825.139040-1-hackerowskiy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 10:54:01 +0000
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
- [High] nvme-pci: skipped nvme_dev_disable() in nvme_reset_work() after de=
ad suspend
--

commit e486876c5c5632e71a9ede664c55c8b5d653c958
Author: Eduard Zateev <hackerowskiy@gmail.com>

nvme-pci: disable accessible controller on error paths

This commit separates PCI accessibility checks from controller health in
nvme_dev_disable() so that nvme_disable_ctrl() is called whenever the PCI
device remains accessible, even if the controller reports a fatal status
or is not ready.

Link: https://syzkaller.appspot.com/bug?extid=3Df4353e96f7004ae5a09e

> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index ea552ac5501f6..bb8e84f062db7 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c

[ ... ]

> @@ -3552,10 +3557,16 @@ static void nvme_dev_disable(struct nvme_dev *dev=
, bool shutdown)
> =20
>  	nvme_quiesce_io_queues(&dev->ctrl);
> =20
> -	if (!dead && dev->ctrl.queue_count > 0) {
> +	if (!dead && dev->ctrl.queue_count > 0)
>  		nvme_delete_io_queues(dev);
> -		nvme_disable_ctrl(&dev->ctrl, shutdown);
> -		nvme_poll_irqdisable(&dev->queues[0]);
> +	if (dev->ctrl.queue_count > 0 && nvme_pci_ctrl_is_accessible(dev)) {
> +		/*
> +		 * Stop an accessible controller even if it reports itself dead.
> +		 * Otherwise it may complete requests after they have been cancelled.
> +		 */
> +		nvme_disable_ctrl(&dev->ctrl, shutdown && !dead);
> +		if (!dead)
> +			nvme_poll_irqdisable(&dev->queues[0]);
>  	}

[Severity: High]
Can calling nvme_disable_ctrl(&dev->ctrl, shutdown && !dead) here leave
I/O queues unquiesced during nvme_reset_work() when resuming from a
suspend where the controller was dead?

During system suspend, nvme_suspend() and nvme_simple_suspend() call
nvme_disable_prepare_reset(ndev, true) -> nvme_dev_disable(ndev, true).
If the controller reports NVME_CSTS_CFS or !NVME_CSTS_RDY while PCI MMIO
is still accessible, dead is true and nvme_disable_ctrl(&dev->ctrl, false)
clears NVME_CC_ENABLE in dev->ctrl.ctrl_config:

drivers/nvme/host/core.c:nvme_disable_ctrl() {
	ctrl->ctrl_config &=3D ~NVME_CC_SHN_MASK;
	if (shutdown)
		ctrl->ctrl_config |=3D NVME_CC_SHN_NORMAL;
	else
		ctrl->ctrl_config &=3D ~NVME_CC_ENABLE;
...
}

At the end of nvme_dev_disable(dev, true), the shutdown block still runs
because shutdown is true, which unquiesces the I/O and admin queues:

drivers/nvme/host/pci.c:nvme_dev_disable() {
...
	if (shutdown) {
		nvme_unquiesce_io_queues(&dev->ctrl);
		if (dev->ctrl.admin_q && !blk_queue_dying(dev->ctrl.admin_q))
			nvme_unquiesce_admin_queue(&dev->ctrl);
	}
...
}

When resuming via nvme_resume() or nvme_simple_resume() ->
nvme_try_sched_reset() -> nvme_reset_work(), nvme_reset_work() checks
NVME_CC_ENABLE before calling nvme_dev_disable(dev, false):

drivers/nvme/host/pci.c:nvme_reset_work() {
...
	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE)
		nvme_dev_disable(dev, false);
	nvme_sync_queues(&dev->ctrl);
...
}

Previously, NVME_CC_ENABLE remained set in dev->ctrl.ctrl_config across
nvme_dev_disable(dev, true), so nvme_reset_work() always called
nvme_dev_disable(dev, false) and re-quiesced the I/O queues via
nvme_quiesce_io_queues(&dev->ctrl).

With NVME_CC_ENABLE cleared during suspend when dead is true, won't
nvme_reset_work() skip nvme_dev_disable(dev, false) and leave the I/O
queues unquiesced while resetting the controller and setting up queues,
allowing entered or requeued requests to be dispatched before queue setup
and nvme_dbbuf_set() complete?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023101825.1390=
40-1-hackerowskiy@gmail.com?part=3D1

