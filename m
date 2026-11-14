Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26FC60A2617
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 03:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=IKFOYNXN;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n65kucq/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=A7JqKAA3wCv3mZFhjUwtK2PE6PiXRdVPZFE3pmj/HPY=; b=IKFOYNXNgiYh/1OdyAJWgGs260
	DpHTWk10K4rGaokSwUY8M5UDu7bo8WuIukFhFhjgMg8OKez2CQHIyYGBLRoKpHKCmo8qcJkZZKJ+T
	wNZXh/ctiNPezDWU4xFyBPM1HCtEiUzj5y8wh5hOKxdqbDywriFeyCTyxFCdOp8YKrjCFS1DgFGCo
	7pWaKrOcEdFo5iW4ncA98yA4EHbn63UvTdFgRIu0JnuCxZVxlpIIkel9Qka+RoIDF0bbdfAaDAeWU
	a6rKhso3YjxkeC/yqxAlJcq0AVTvToL9FItCMm+haxITHHE2mcxx7hA+VcZBnhNle1DAm2Ztgh55F
	3miexAow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS4b8-0000000FINN-0inh;
	Sat, 14 Nov 2026 03:38:38 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS4b6-0000000FIMz-0eff
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 03:38:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 95FD14647B;
	Sat, 14 Nov 2026 03:38:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B8A1F000CD;
	Sat, 14 Nov 2026 03:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794627515;
	bh=A7JqKAA3wCv3mZFhjUwtK2PE6PiXRdVPZFE3pmj/HPY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n65kucq/zOtygMzhgyoyTESFL7z/iBHauBLhFNzbVKqxBmxudw2kEFoiUmAswEwjP
	 P/z1plWGMPgRIKtZvm1CYxTzOtGRQAFsm8j2RkZfCjzWnVcj8v2nTJKI2rkdutJ3gU
	 4u1JDZHjWUH7IodIHfpJTRNbQmWIdZtmcHK8gZUNVhFg0RpPERleNwA+5yc9KdLTcO
	 ZTJa4sysalhswQHa25PQRKvXo6RMrbcHgM3rxVNLN0LJWV5OJiBGZaIY+kHWeV95ok
	 uqD7kdBPzb5LQVDUWzNi6C4r2vnlp8FCKnf5YCX9qMTsrnwio5+1Q8EWOvooTxyimg
	 flN6Ew2I4xUYw==
Message-ID: <sashiko-outbox-214121@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 14/17] nvme-fc: Use CCR to recover controller that
 hits an error
To: "Mohamed Khalfella" <mkhalfella@purestorage.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261114030454.2836543-15-mkhalfella@purestorage.com>
References: <20261114030454.2836543-1-mkhalfella@purestorage.com>
 <20261114030454.2836543-15-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 03:38:34 +0000
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
- [Medium] nvme-fc: race between nvme_fc_start_ioerr_recovery() and
  controller delete
--

commit f16da5f8edc4e397a5fc84e9cd9ede4c82bfa5d8
Author: Mohamed Khalfella <mkhalfella@purestorage.com>

nvme-fc: Use CCR to recover controller that hits an error

This commit transitions LIVE NVMe/FC controllers to FENCING on I/O errors
and runs Cross-Controller Reset (CCR) via fencing_work before proceeding to
RESETTING.

> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 0ba621649afed..095adc9011ccd 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
[ ... ]
> @@ -1921,11 +1949,20 @@ char *nvme_fc_io_getuuid(struct nvmefc_fcp_req *r=
eq)
>  EXPORT_SYMBOL_GPL(nvme_fc_io_getuuid);
> =20
>  /*
> - * Start recovery only if this caller can claim it with a state change.
> + * Start recovery only if this caller can claim it with a state change:
> + * FENCING from LIVE, or RESETTING otherwise.
>   */
>  static void
>  nvme_fc_start_ioerr_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
>  {
> +	if (nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_FENCING)) {
> +		dev_warn(ctrl->ctrl.device,
> +			 "NVME-FC{%d}: starting controller fencing %s\n",
> +			 ctrl->cnum, errmsg);
> +		queue_work(nvme_wq, &ctrl->fencing_work);
> +		return;
> +	}
> +
>  	if (nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING)) {
>  		dev_warn(ctrl->ctrl.device, "NVME-FC{%d}: starting error recovery %s\n=
",
>  			 ctrl->cnum, errmsg);
> @@ -2439,6 +2476,12 @@ nvme_fc_ctrl_get(struct nvme_fc_ctrl *ctrl)
>  	return kref_get_unless_zero(&ctrl->ref);
>  }
> =20
> +static void
> +nvme_fc_stop_ctrl(struct nvme_ctrl *nctrl)
> +{
> +	flush_work(&to_fc_ctrl(nctrl)->fencing_work);
> +}

[Severity: Medium]
Can ctrl->fencing_work be queued after nvme_fc_stop_ctrl() has already
flushed it if controller deletion races with nvme_fc_start_ioerr_recovery()?

nvme_change_ctrl_state() allows transitioning from NVME_CTRL_FENCING to
NVME_CTRL_DELETING, and nvme_fc_start_ioerr_recovery() drops ctrl->ctrl.lock
before calling dev_warn() and queue_work():

CPU0                                  CPU1
nvme_fc_start_ioerr_recovery()
  nvme_change_ctrl_state(...,
    NVME_CTRL_FENCING)
                                      nvme_delete_ctrl()
                                        nvme_change_ctrl_state(...,
                                          NVME_CTRL_DELETING)
                                      nvme_do_delete_ctrl()
                                        nvme_stop_ctrl()
                                          nvme_fc_stop_ctrl()
                                            flush_work(&ctrl->fencing_work)
  dev_warn(...)
  queue_work(nvme_wq,
    &ctrl->fencing_work)
                                        ...
                                        nvme_uninit_ctrl()
                                          nvme_put_ctrl() -> frees ctrl
                                      nvme_fc_fencing_work() <-- use-after-=
free

Because flush_work() returns immediately when fencing_work has not been
queued yet, nothing in the remainder of nvme_do_delete_ctrl() stops
nvme_fc_fencing_work() from running concurrently with nvme_fc_delete_ctrl()
or after struct nvme_fc_ctrl is freed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114030454.2836=
543-1-mkhalfella@purestorage.com?part=3D14

