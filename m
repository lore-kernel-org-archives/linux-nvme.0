Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74D0606A33B
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 03:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jbD4qEiV;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UyX4vt9t
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=2bUg9J7vbUtzyS2y8UsLsTkjBSAbCdLxsthQzGNhouo=; b=jbD4qEiVXWraaTifrTXrcY22OT
	Q82wffSmi5e4RCkxCdLQhIm4SVtxFRq3rzLBIfro/2WvYfKgtIj2ZtT2Vaj/0EWhrWtL1k2PwMkQf
	Knh+kbXCjrUKyWqiR1itfVmumz41Hrc7y0Jq0dY4VBOS44fqDYjEMi01FI05oIpwIjjv4Qm5qcCjd
	ui0VS1sFlR9SNaUCX0aI4JNzvppiEaNz32loodUdsqmuD4CZ2ViCGv1ZqP/8huFMYrw84U4WJzr2M
	YXLcXAiJl36xR0NvN8yAowtuhPrFe3ts6RB2H74X/qC2LdOIRkJRsPqBEt2lTx65nmNuVGTQ1pjly
	l31Q8dOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS4Tr-0000000FHGp-2Azb;
	Sat, 14 Nov 2026 03:31:07 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS4Tp-0000000FHG5-3rTs
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 03:31:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5DAD762647;
	Sat, 14 Nov 2026 03:31:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D151F000C4;
	Sat, 14 Nov 2026 03:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794627065;
	bh=2bUg9J7vbUtzyS2y8UsLsTkjBSAbCdLxsthQzGNhouo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UyX4vt9tcSNuzU6BV/YcpA8eWpL/UrGjF2OmFiTKC0i1gHxLOh+dhVVDXL0xoRaQD
	 dDYS5+AesrlI7dGLDVMcrviqIQrgPWA/RriZIhhYe7t5y+L2IcmFlOJvmEBv3Lczbz
	 3LYd3y/UGoAAqVxFr8DcSvLezkXJFRpeMrtJuWfA4/+EPp1A2zUdw63Iq2xcncBUvk
	 U7wFWzj/NRoMiGVCPCQLD2ivFkmQSaFYhwTtIrP9cgJf6JVfdDWyY+b/CuLYoTHx4J
	 Q2cJxgPh/xXPgoohTlOapfr/PvqRv02pjGYS7PoIHkuG2DEbQJAeQXMZlB6jNPTvjn
	 dRy2/UE1X1gRA==
Message-ID: <sashiko-outbox-214114@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 13/17] nvme-fc: perform error recovery directly from
 ioerr_work
To: "Mohamed Khalfella" <mkhalfella@purestorage.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261114030454.2836543-14-mkhalfella@purestorage.com>
References: <20261114030454.2836543-1-mkhalfella@purestorage.com>
 <20261114030454.2836543-14-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 03:31:04 +0000
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
- [High] nvme-fc: race between nvme_fc_ctrl_ioerr_work() and controller
  deletion
- [Low] nvme-fc: unused forward declaration of
  __nvme_fc_abort_outstanding_ios()
--

commit f47f39335cf25a25520dc165768b29ed4e1e01c4
Author: Mohamed Khalfella <mkhalfella@purestorage.com>

nvme-fc: perform error recovery directly from ioerr_work

This commit replaces nvme_fc_error_recovery() with direct association
teardown, controller stop, and reconnect scheduling inside
nvme_fc_ctrl_ioerr_work().

> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index c4603be381445..0ba621649afed 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -229,6 +229,8 @@ static struct device *fc_udev_device;
>  static void nvme_fc_complete_rq(struct request *rq);
>  static void nvme_fc_start_ioerr_recovery(struct nvme_fc_ctrl *ctrl,
>  					 char *errmsg);
> +static void __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl,
> +					    bool start_queues);

[Severity: Low]
This isn't a bug, but nothing calls __nvme_fc_abort_outstanding_ios()
before its definition now that nvme_fc_error_recovery() is removed, so this
forward declaration is unused.

[ ... ]

> @@ -1880,7 +1883,23 @@ nvme_fc_ctrl_ioerr_work(struct work_struct *work)
>  	struct nvme_fc_ctrl *ctrl =3D
>  			container_of(work, struct nvme_fc_ctrl, ioerr_work);
> =20
> -	nvme_fc_error_recovery(ctrl, "transport detected io error");
> +	nvme_stop_keep_alive(&ctrl->ctrl);
> +	flush_work(&ctrl->ctrl.async_event_work);
> +
> +	/* will block while waiting for io to terminate */
> +	nvme_fc_delete_association(ctrl);
> +	nvme_stop_ctrl(&ctrl->ctrl);
> +
> +	/* Do not reconnect if controller is being deleted */
> +	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
> +		return;
> +
> +	if (ctrl->rport->remoteport.port_state =3D=3D FC_OBJSTATE_ONLINE) {
> +		queue_delayed_work(nvme_wq, &ctrl->connect_work, 0);
> +		return;
> +	}
> +
> +	nvme_fc_reconnect_or_delete(ctrl, -ENOTCONN);
>  }

[Severity: High]
Can nvme_fc_ctrl_ioerr_work() race with controller deletion and re-arm
ctrl->connect_work after nvme_fc_delete_ctrl() has already canceled it?

Previously, error recovery called nvme_reset_ctrl(), and
nvme_do_delete_ctrl() flushed ctrl->reset_work before calling
nvme_stop_ctrl(), nvme_remove_namespaces(), and ctrl->ops->delete_ctrl().
Unlike rdma and tcp, nvme_fc_ctrl_ops does not implement .stop_ctrl to
flush ioerr_work, and nvme_fc_delete_ctrl() cancels connect_work before
canceling ioerr_work:

drivers/nvme/host/fc.c:nvme_fc_delete_ctrl() {
	...
	cancel_delayed_work_sync(&ctrl->connect_work);
	...
	nvme_fc_delete_association(ctrl);
	cancel_work_sync(&ctrl->ioerr_work);
	...
}

If controller deletion starts right after nvme_fc_ctrl_ioerr_work() moves
the controller to NVME_CTRL_CONNECTING, connect_work can be queued after
cancel_delayed_work_sync(&ctrl->connect_work) has already completed:

CPU0                                    CPU1
nvme_fc_ctrl_ioerr_work()
  ...
  nvme_change_ctrl_state(...,
    NVME_CTRL_CONNECTING)
                                        nvme_delete_ctrl()
                                          nvme_change_ctrl_state(...,
                                            NVME_CTRL_DELETING)
                                          ...
                                          nvme_do_delete_ctrl()
                                            ...
                                            nvme_fc_delete_ctrl()
                                              cancel_delayed_work_sync(
                                                &ctrl->connect_work)
                                              ...
                                              cancel_work_sync(
                                                &ctrl->ioerr_work)
  queue_delayed_work(nvme_wq,
    &ctrl->connect_work, 0)
                                              nvme_remove_io_tag_set()
                                              nvme_remove_admin_tag_set()
                                            nvme_uninit_ctrl()
                                        nvme_fc_connect_ctrl_work()
                                          nvme_fc_create_association()
                                            <-- use-after-free

This leaves connect_work running nvme_fc_create_association() while the
tag sets are torn down and struct nvme_fc_ctrl is freed.

In addition, because nvme_do_delete_ctrl() does not wait for ioerr_work
before calling nvme_remove_namespaces(), nvme_fc_delete_association() in
ioerr_work can run concurrently with nvme_remove_namespaces(), racing on
quiescing and unquiescing the I/O queues while scan_work is flushed and
hardware queues are deleted.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114030454.2836=
543-1-mkhalfella@purestorage.com?part=3D13

