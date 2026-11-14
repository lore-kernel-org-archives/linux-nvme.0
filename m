Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AD2606A332
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 03:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lEjtFEiu;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QngF+A0R
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=X0odMvH757RytC72ratFz/WtNNDqIQlZ8awX9/6JWwk=; b=lEjtFEiu7GXYvU3rX6G3WLxx88
	anz7Rfr8V0FQSvF7vcUvnMoRv2Yum9CgI+eS4tVAJSX1kPHc/S0/dzbTOwxxCnKPYmWINOFwl0jTS
	46q/NHEn4igpJ0fDuR06PK4FWtvbaD0r3GG+pCeRodh1b2IaRHA/QgLDKnoswP0R+kukRCvKas2Q5
	qn8WwnTggolED7iF479tz7S6c/a4xAxCtq/q+4wNvdEImxq5upcc2w0IVkDnNjTBlm+Q1EUwvZYnY
	G7dmc4FaKvPLZaBPrsV1ghhSTibIhuF7JLckNXWiHqyOxGwltYGkeJeoeReP3GLvvvRt5/LaUoUU4
	NJkqDowQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS4TX-0000000FHA0-0dyS;
	Sat, 14 Nov 2026 03:30:47 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS4TV-0000000FH9d-0wF6
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 03:30:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 84905405B1;
	Sat, 14 Nov 2026 03:30:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4F71F000C4;
	Sat, 14 Nov 2026 03:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794627044;
	bh=X0odMvH757RytC72ratFz/WtNNDqIQlZ8awX9/6JWwk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QngF+A0RsH9po5Jfy31hH/IHxijwYAIfDzE1xZYBhn0IjFgixQCsoMaOVdN6m4ROA
	 BQQMRHVMHVMbwaf+N4+UNUqx7E1HrsCWWZSoIwZHu/Q/n8J6mDt4P4+gmVIB1T1UJE
	 0qv6BBy1f08V0RY6B5Ou0fDDfjCz0kNXzctwU4h/7j9COXlm3Oa8JWLwvY17AdgrCo
	 jTDDTtqP30v4l4OQsLj8iVxjycdRX2Umk8MFxZ37PZQjizET1CK6y4hlkrOZ+qjmjO
	 ezfxz5QLEV1Xw0uYyt+LRMWoMzBAKYEy0Nx9zCSziAihOtJq2a6tuHUjIhHvmr1yDe
	 JNBvg9ahCu0ag==
Message-ID: <sashiko-outbox-214113@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 03/17] nvmet: Implement CCR nvme command
To: "Mohamed Khalfella" <mkhalfella@purestorage.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261114030454.2836543-4-mkhalfella@purestorage.com>
References: <20261114030454.2836543-1-mkhalfella@purestorage.com>
 <20261114030454.2836543-4-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 03:30:43 +0000
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
- [Medium] nvmet: TOCTOU race between nvmet_ctrl_find_get_ccr() and
  nvmet_start_ctrl()
--

commit 8afa887480a9e0f0751311107895be0ad6ed159f
Author: Mohamed Khalfella <mkhalfella@purestorage.com>

nvmet: Implement CCR nvme command

This commit implements the Cross-Controller Reset admin command for the
NVMe target, allowing a source controller to look up and trigger a fatal
error on an impacted controller matching the specified controller ID, ciu,
and cirn.

> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-=
cmd.c
> index 5710ae53eb83a..3df9db454db9c 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
[ ... ]
> @@ -1629,6 +1630,78 @@ void nvmet_execute_keep_alive(struct nvmet_req *re=
q)
>  	nvmet_req_complete(req, status);
>  }
> =20
> +void nvmet_execute_cross_ctrl_reset(struct nvmet_req *req)
> +{
[ ... ]
> +	/* Find and get impacted controller */
> +	ictrl =3D nvmet_ctrl_find_get_ccr(sctrl->subsys, sctrl->hostnqn,
> +					cmd->ccr.ciu, cntlid,
> +					le64_to_cpu(cmd->ccr.cirn));
[ ... ]
> +out_unlock:
> +	mutex_unlock(&sctrl->lock);
> +	if (status =3D=3D NVME_SC_SUCCESS)
> +		nvmet_ctrl_fatal_error(ictrl);
> +	nvmet_ctrl_put(ictrl);
> +out:
> +	nvmet_req_complete(req, status);
> +}
[ ... ]
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 9c9ad4d9b292d..86018e0fb1586 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
[ ... ]
> @@ -1432,6 +1446,7 @@ static void nvmet_start_ctrl(struct nvmet_ctrl *ctr=
l)
>  	if (!nvmet_is_disc_subsys(ctrl->subsys)) {
>  		ctrl->ciu =3D ((u8)(ctrl->ciu + 1)) ? : 1;
>  		ctrl->cirn =3D get_random_u64() ? : 1;
> +		nvmet_ctrl_cleanup_ccrs(ctrl, false);
>  	}
>  	ctrl->csts =3D NVME_CSTS_RDY;
> =20
> @@ -1537,6 +1552,42 @@ struct nvmet_ctrl *nvmet_ctrl_find_get(const char =
*subsysnqn,
>  	return ctrl;
>  }
> =20
> +struct nvmet_ctrl *nvmet_ctrl_find_get_ccr(struct nvmet_subsys *subsys,
> +					   const char *hostnqn, u8 ciu,
> +					   u16 cntlid, u64 cirn)
> +{
> +	struct nvmet_ctrl *ctrl, *ictrl =3D NULL;
> +	bool found =3D false;
> +
> +	mutex_lock(&subsys->lock);
> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> +		if (ctrl->cntlid !=3D cntlid)
> +			continue;
> +		if (strncmp(ctrl->hostnqn, hostnqn, NVMF_NQN_SIZE))
> +			continue;
> +
> +		/*
> +		 * Enabling the controller regenerates ciu and cirn under
> +		 * ctrl->lock. Hold the lock so that a controller becoming
> +		 * ready concurrently is matched against either the old or
> +		 * the new instance, never a mix of both.
> +		 */
> +		mutex_lock(&ctrl->lock);
> +		if (ctrl->ciu =3D=3D ciu && ctrl->cirn =3D=3D cirn)
> +			found =3D true;
> +		mutex_unlock(&ctrl->lock);

[Severity: Medium]
Can nvmet_execute_cross_ctrl_reset() race with nvmet_start_ctrl() and
trigger a fatal error on a newly enabled controller instance?

nvmet_ctrl_find_get_ccr() drops ctrl->lock right after matching ctrl->ciu
and ctrl->cirn.  Before nvmet_execute_cross_ctrl_reset() calls
nvmet_ctrl_fatal_error(ictrl), a concurrent nvmet_update_cc() can enable
ictrl and advance ictrl->ciu and ictrl->cirn:

CPU0                              CPU1
nvmet_execute_cross_ctrl_reset()
  nvmet_ctrl_find_get_ccr()
    mutex_lock(&ictrl->lock)
    /* matches ciu and cirn */
    mutex_unlock(&ictrl->lock)
                                  nvmet_update_cc()
                                    mutex_lock(&ictrl->lock)
                                    nvmet_start_ctrl()
                                      ictrl->ciu =3D ...;
                                      ictrl->cirn =3D ...;
                                    mutex_unlock(&ictrl->lock)
  nvmet_ctrl_fatal_error(ictrl)   <-- kills the new instance

If the interleaving goes the other way and nvmet_ctrl_fatal_error(ictrl)
runs just before nvmet_start_ctrl(), nvmet_start_ctrl() overwrites
ictrl->csts with the ready state, clearing the fatal status bit while
ictrl->fatal_err_work is already queued.

In addition, when a controller is re-enabled in-place via
nvmet_start_ctrl() rather than freed in nvmet_ctrl_free(),
nvmet_start_ctrl() only cleans up entries on ctrl->ccr_list where ctrl was
the source controller, leaving pending entries on other controllers where
ctrl was the impacted controller active with a non-null ccr->ctrl pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114030454.2836=
543-1-mkhalfella@purestorage.com?part=3D3

