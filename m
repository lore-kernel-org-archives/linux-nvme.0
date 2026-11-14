Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F96606A885
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 03:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lttgGPf0;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HqL0QvfJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=GFLZyNR2FpdmJ5XKPVOQITy4iMOIkXAAN0wbOblKnsI=; b=lttgGPf0/RKbbJH/U8BeOj9L1f
	Vg8L3aPonjPEHLfQhIK0fKnJgiE/DeJF8WpIKGqOzPMpNWz9aHhwEYQlbxoqnm1C9oGBPTO/865Pk
	O3H0Kr8fxLHYTQz3JUh3vMXbP66bJaUaSyy/8ZFvo3K98HHXfhGxLzCo4FcFWrTZNd5CYyTBXTzN9
	1KuCptfyljtDXfPIraqa/ec4YuxFh9g01ovCHf75DJvYwsicnDgdJVaf+augqGP06t8rNnsvd0cjx
	NKpAYqQwcmHpdYBG5m18vA6JP2CeufAxF9WbaaaMF6x+BCb43B1467SF7TmifjSIusKheYzG8z0MN
	k3OMMVPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS4SS-0000000FGhu-0QRj;
	Sat, 14 Nov 2026 03:29:40 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS4SQ-0000000FGhN-3Rln
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 03:29:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4012861246;
	Sat, 14 Nov 2026 03:29:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37671F000C4;
	Sat, 14 Nov 2026 03:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794626978;
	bh=GFLZyNR2FpdmJ5XKPVOQITy4iMOIkXAAN0wbOblKnsI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HqL0QvfJg7bh1IHYOJe49rp0nkCIm6c+Q2+sYV66RIpROzDtCe3R7qIfJaGPzO8n1
	 FmqesR4pY08x+3FCh9kdQ6w8zGlOemyzaPi0bUWR5q5JHsZbQ22A2hJr2NIVFi0hYl
	 H8Yx9qyYtgN4v9KP4Y6kxRqxcNxNHzCvskTvC5/CVPl7Cbf8z7mykXts05EwVoNNwH
	 EpQHIgKyFwjlCHPFThB04dE66/kMUTd3CUPq3oqPS7dznU4vCCuU2CBs8HJMSe/g2Y
	 vIMv61oRLoSRju0tx/RikmsFq00KYti8FkRh4kfdMdlDrr9JQC6oX1u6bbmCDC5i2i
	 oY7pcOaOLnIuA==
Message-ID: <sashiko-outbox-214111@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/17] nvme: Implement cross-controller reset
 completion
To: "Mohamed Khalfella" <mkhalfella@purestorage.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261114030454.2836543-10-mkhalfella@purestorage.com>
References: <20261114030454.2836543-1-mkhalfella@purestorage.com>
 <20261114030454.2836543-10-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 03:29:37 +0000
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
- [High] nvme: UAF and deadlock in nvme_ccr_work() when controller is
  not LIVE
--

commit ccb451fbdaf89eaa6e4be835d2b43da8b0854559
Author: Mohamed Khalfella <mkhalfella@purestorage.com>

nvme: Implement cross-controller reset completion

This commit adds ctrl->ccr_work and handles NVME_AER_NOTICE_CCR_COMPLETED
events by reading the NVME_LOG_CCR log page and completing matching entries=
 on
ctrl->ccr_list.

> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 27c33dc49175e..54b83092a9e8f 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
[ ... ]
> @@ -5060,6 +5061,48 @@ static void nvme_get_fw_slot_info(struct nvme_ctrl=
 *ctrl)
>  	kfree(log);
>  }
> =20
> +static void nvme_ccr_work(struct work_struct *work)
> +{
> +	struct nvme_ctrl *ctrl =3D container_of(work, struct nvme_ctrl, ccr_wor=
k);
> +	struct nvme_ccr_entry *ccr;
> +	struct nvme_ccr_log_entry *entry;
> +	struct nvme_ccr_log *log;
> +	int num_entries, ret, i;
> +	unsigned long flags;
> +
> +	log =3D kmalloc_obj(*log);
> +	if (!log)
> +		return;
> +
> +	ret =3D nvme_get_log(ctrl, 0, NVME_LOG_CCR, 0x01,
> +			   0x00, log, sizeof(*log), 0);

[Severity: High]
Can nvme_ccr_work() submit a Get Log Page command to a destroyed or quiesced
ctrl->admin_q when the controller is no longer live?

During controller deletion, nvme_do_delete_ctrl() calls nvme_stop_ctrl()
before ctrl->ops->delete_ctrl() stops the admin queue, and
nvme_uninit_ctrl() runs only after nvme_remove_admin_tag_set() has already
destroyed ctrl->admin_q and freed ctrl->admin_tagset.  If an in-flight AEN
completes with NVME_AER_NOTICE_CCR_COMPLETED after nvme_stop_ctrl() cancels
ctrl->ccr_work, nvme_ccr_work() is re-queued and can access ctrl->admin_q
while or after it is destroyed:

CPU0                                  CPU1
nvme_do_delete_ctrl()
  nvme_stop_ctrl()
    cancel_work_sync(&ctrl->ccr_work)
                                      nvme_complete_async_event()
                                        nvme_handle_aen_notice()
                                          queue_work(nvme_wq, &ctrl->ccr_wo=
rk)
  ctrl->ops->delete_ctrl()
    ...
    nvme_remove_admin_tag_set()
      blk_mq_destroy_queue(ctrl->admin_q)
      blk_mq_free_tag_set(ctrl->admin_tagset)
                                      nvme_ccr_work()
                                        nvme_get_log(ctrl, ...)
                                          <-- use-after-free on admin_q
  nvme_uninit_ctrl()
    cancel_work_sync(&ctrl->ccr_work)

Because nvme_ccr_work() does not check nvme_ctrl_state(ctrl) =3D=3D
NVME_CTRL_LIVE, it can also run while ctrl->admin_q is quiesced during reset
or transport error recovery; nvme_get_log() then blocks in blk_execute_rq()
waiting for the queue to be unquiesced, and the next nvme_stop_ctrl() ->
cancel_work_sync(&ctrl->ccr_work) deadlocks before teardown can unquiesce
ctrl->admin_q.

Checking nvme_ctrl_state(ctrl) !=3D NVME_CTRL_LIVE at the start of
nvme_ccr_work() (like nvme_ana_work() and nvme_scan_work()) and cancelling
ctrl->ccr_work in nvme_remove_admin_tag_set() before destroying
ctrl->admin_q would avoid both issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114030454.2836=
543-1-mkhalfella@purestorage.com?part=3D9

