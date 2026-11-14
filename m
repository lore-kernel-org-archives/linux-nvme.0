Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBB3606A88B
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 03:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Bl+8Yj0g;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W4Z0Uz3T
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=KEgOXq5qWy+CxR4yHP5CVXSeTt16GpBjJDXyMbq7f+U=; b=Bl+8Yj0gujh9SrM06ehGwY3awk
	KKcmX5onIk7RFavg1kWfbnKDvpojdbC+qC+4edyNaMBMmfzolWCuStc9DBdTVZgQF+I0Fshms7mj9
	XnLdS62jWalzX6YLU1SNlZm5nc5o+sWaky5Ax3HAsVlSZeEgHnwpNqFKp6VMopBlNHu+hnWG3RYa/
	64VC7pYYwlOIg12BkLtX1994cfHsRIIEcVDUSi+k+CxS2xVJQA9MWbzh3z32M/TSMkNfSvkOcgHSN
	mwUdiYly4iJgbc16xRpzKOdONWuvD1a0BAdP3ZkqcWjRViojIAbLm0f5nrFW19kfcxQRBYZFc+Jj1
	Z7Axv1uA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS4Pb-0000000FFZC-2cig;
	Sat, 14 Nov 2026 03:26:43 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS4PZ-0000000FFYO-4BZT
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 03:26:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 164C762522;
	Sat, 14 Nov 2026 03:26:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2EF51F000C4;
	Sat, 14 Nov 2026 03:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794626800;
	bh=KEgOXq5qWy+CxR4yHP5CVXSeTt16GpBjJDXyMbq7f+U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W4Z0Uz3TvU4adgeB9rDVBZ9tJDwGZ+MqHXaSUjs1HtElHfVPitfT9BJ8l74eYQXx0
	 OYEekF4DyCOEMkMorKt5OM25gQt+6KsUWbenO69JjDLXZV10Py1T81fRWFFMpr2+5J
	 pXZCATktrZ/8ZuG4feKNVPyj9MU/XyXeWkfsjrRvJbFkBzcMBzEcp3Fu9tjZVNjq4d
	 CXWlrbCKYTA7ZzpIxIZaDV6dbsxDDy5tCkGDTnyHbkaV/4anAIIkqqrhk+Iu1wZAlM
	 oK55aaPM3kjhvUbAaDEAc89aNqYP4ZexFYNYcgso2DXgkXFuQR7qR8Xobv7+RqLe/j
	 YajxxaToa5rsw==
Message-ID: <sashiko-outbox-214105@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/17] nvme: Implement cross-controller reset
 recovery
To: "Mohamed Khalfella" <mkhalfella@purestorage.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261114030454.2836543-9-mkhalfella@purestorage.com>
References: <20261114030454.2836543-1-mkhalfella@purestorage.com>
 <20261114030454.2836543-9-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 03:26:40 +0000
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
- [Medium] nvme: nvme_find_ctrl_ccr() skips valid controllers on
  unsorted list
--

commit 5d2164548bbd55a6b77ef7780332ce46368dbeb8
Author: Mohamed Khalfella <mkhalfella@purestorage.com>

nvme: Implement cross-controller reset recovery

This commit adds core cross-controller reset (CCR) recovery logic in
nvme_fence_ctrl() and nvme_fence_timeout_ms() to terminate in-flight I/Os
on a failed controller using a healthy controller in the same subsystem.

> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 4be3ce2e72a78..27c33dc49175e 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -576,6 +576,157 @@ void nvme_cancel_admin_tagset(struct nvme_ctrl *ctr=
l)
>  }
>  EXPORT_SYMBOL_GPL(nvme_cancel_admin_tagset);
> =20
> +static struct nvme_ctrl *nvme_find_ctrl_ccr(struct nvme_ctrl *ictrl,
> +					    u32 min_cntlid)
> +{
> +	struct nvme_subsystem *subsys =3D ictrl->subsys;
> +	struct nvme_ctrl *ctrl, *sctrl =3D NULL;
> +	unsigned long flags;
> +	int ccr_used;
> +
> +	mutex_lock(&nvme_subsystems_lock);
> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> +		if (ctrl->cntlid < min_cntlid)
> +			continue;
> +
> +		spin_lock_irqsave(&ctrl->lock, flags);
> +		if (nvme_ctrl_state(ctrl) !=3D NVME_CTRL_LIVE) {
> +			spin_unlock_irqrestore(&ctrl->lock, flags);
> +			continue;
> +		}
> +
> +		ccr_used =3D atomic_inc_return(&ctrl->ccr_used);
> +		if (ccr_used > ctrl->ccrl) {
> +			atomic_dec(&ctrl->ccr_used);
> +			spin_unlock_irqrestore(&ctrl->lock, flags);
> +			continue;
> +		}
> +
> +		/*
> +		 * We got a good candidate source controller that is locked and
> +		 * LIVE. However, no guarantee ctrl will not be deleted after
> +		 * ctrl->lock is released. Get a ref of both ctrl and admin_q
> +		 * so they do not disappear until we are done with them.
> +		 */
> +		WARN_ON_ONCE(!blk_get_queue(ctrl->admin_q));
> +		nvme_get_ctrl(ctrl);
> +		spin_unlock_irqrestore(&ctrl->lock, flags);
> +		sctrl =3D ctrl;
> +		break;
> +	}
> +	mutex_unlock(&nvme_subsystems_lock);
> +	return sctrl;
> +}

[ ... ]

> +unsigned long nvme_fence_ctrl(struct nvme_ctrl *ictrl)
> +{
> +	unsigned long now, deadline, timeout;
> +	struct nvme_ctrl *sctrl;
> +	u32 min_cntlid =3D 0;
> +	int ret;
> +
> +	timeout =3D nvme_fence_timeout_ms(ictrl);
> +	dev_info(ictrl->device, "attempting CCR, timeout %lums\n", timeout);
> +
> +	now =3D jiffies;
> +	deadline =3D jiffies + msecs_to_jiffies(timeout);
> +	while (time_before(now, deadline)) {
> +		sctrl =3D nvme_find_ctrl_ccr(ictrl, min_cntlid);
> +		if (!sctrl) {
> +			dev_dbg(ictrl->device,
> +				"failed to find source controller\n");
> +			return deadline - now;
> +		}
> +
> +		ret =3D nvme_issue_wait_ccr(sctrl, ictrl, deadline);
> +		if (!ret) {
> +			dev_info(ictrl->device, "CCR succeeded using %s\n",
> +				 dev_name(sctrl->device));
> +			nvme_put_ctrl_ccr(sctrl);
> +			return 0;
> +		}
> +
> +		/*
> +		 * CCR command or CCR operation failed on this path.
> +		 * Try another path as long as we have time.
> +		 */
> +		dev_err(ictrl->device, "CCR failed using %s, ret =3D %d\n",
> +			dev_name(sctrl->device), ret);
> +		min_cntlid =3D sctrl->cntlid + 1;
> +		nvme_put_ctrl_ccr(sctrl);
> +		now =3D jiffies;
> +	}

[Severity: Medium]
Can nvme_find_ctrl_ccr() skip valid candidate controllers in subsys->ctrls
when retrying after a failed CCR attempt?

nvme_init_subsystem() appends controllers to subsys->ctrls with
list_add_tail(), while nvmf_connect_admin_queue() assigns a new dynamic
ctrl->cntlid on every connect or reconnect without reordering the list.
Because nvme_find_ctrl_ccr() stops at the first live controller with
ctrl->cntlid >=3D min_cntlid rather than picking the one with the smallest
matching cntlid, failing on an earlier list entry with a higher cntlid and
advancing min_cntlid to sctrl->cntlid + 1 skips any later entries in
subsys->ctrls that have smaller cntlid values, causing nvme_fence_ctrl()
to give up on CCR early and fall back to time-based recovery.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114030454.2836=
543-1-mkhalfella@purestorage.com?part=3D8

