Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB6ACCA46C
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 03:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Iwgag5qCw7SWeWeF6g86QA8VBve275/LgvlLgWHJ5Jc=; b=T8IRHdX/4DpXfbZR2FwafrUmMc
	ct+6JdayM5kSYZOQDEsd2NZJOL80GMSXvyMs248Rwz+mhHX2OCLD81AVgJ9Ok53uQg3YdGgVELhXN
	SLkDKQwP+iuzlH2Q8QVpd18TIMXAT3XwQBTSiot2EgGzB3OwtC2x1auvqP4rSEdaynNmnbU2QjK72
	zOTbnQC+RumvrWctLN2gxsjXOm8xe1IQ7yQKZ2A4CfZJq0M0qWmdfwaN/FlcbQHggKH1Jxq2ljJZf
	01yEIv9O1mIFX2GnWEUbqdPEfrXjQk3lkVA90yTdxDHzU6KTE5fLGHMaa8e6kzt54mviZB9nq1We+
	w13BKt4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIeJN-00000006Z7j-42ww;
	Mon, 19 Oct 2026 03:45:21 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIeJM-00000006Z7K-2LGn
	for linux-nvme@lists.infradead.org;
	Mon, 19 Oct 2026 03:45:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id F090F43453;
	Mon, 19 Oct 2026 03:45:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99481F000C5;
	Mon, 19 Oct 2026 03:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792381519;
	bh=Iwgag5qCw7SWeWeF6g86QA8VBve275/LgvlLgWHJ5Jc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YcE52ryxuL79mfZedXgcEG5og8QCsnvwyNo9FQSV2tFAGdExPVr2rmlFSAb4HCiLh
	 998+8G1z7mMstg5ub+y16hkCL50hHHXog1Ujx0t63gLujzUVCfrkaembRFhmLGJ5TL
	 Duv1zh28I4ktdO9BkxRCEVaqwylqsVu+BWhL755qK2haPujpg/nox82P7mL8veOraj
	 SB60T2a2HyfNs5tq/nzmf+OWjyia2c5xcDK+9y1gNV+NSwfTKGuXBlWBCBkTOZB+P0
	 j/3KUJ/M+aMHj7Uz4ZCg5EJ99SLhgQKF8uE9aP0viryURGzvMF35XRKuGfSkhpy7d2
	 QdaXG2RvUeUmA==
Message-ID: <sashiko-outbox-176587@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/11] nvmet: implement the FDP feature
To: "Guixin Liu" <kanie@linux.alibaba.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261019033624.402337-8-kanie@linux.alibaba.com>
References: <20261019033624.402337-1-kanie@linux.alibaba.com>
 <20261019033624.402337-8-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 03:45:19 +0000
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] nvmet: missing RCU protection and live check in nvmet_fdp_look=
up_ns()
- [Medium] nvmet: unconditional NVME_FEAT_FDP in nvmet_execute_get_log_page=
_features()
--

commit 121b81584ccf85602ba9ff94dfc9a38064c55462
Author: Guixin Liu <kanie@linux.alibaba.com>

nvmet: implement the FDP feature

This commit implements Set Features and Get Features for the Flexible Data
Placement feature (FID 1Dh) in nvmet, using the Endurance Group Identifier
to look up the corresponding namespace. It also advertises NVME_FEAT_FDP in
the Supported Features log page.

> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-=
cmd.c
> index b293ce418e2c3..93fb9c3d500a3 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -600,6 +600,9 @@ static void nvmet_execute_get_log_page_features(struc=
t nvmet_req *req)
>  		cpu_to_le32(NVME_FIS_FSUPP | NVME_FIS_NSCPE);
>  	features->fis[NVME_FEAT_RESV_MASK] =3D
>  		cpu_to_le32(NVME_FIS_FSUPP | NVME_FIS_NSCPE);
> +	if (IS_ENABLED(CONFIG_NVME_TARGET_FDP))
> +		features->fis[NVME_FEAT_FDP] =3D
> +			cpu_to_le32(NVME_FIS_FSUPP | NVME_FIS_EGSCPE);

[Severity: Medium]
Should nvmet_execute_get_log_page_features() check
nvmet_fdp_subsys_configured(nvmet_req_subsys(req)) here instead of
IS_ENABLED(CONFIG_NVME_TARGET_FDP)?

The commit message notes that this feature is reported in the Features log
page under the same per-subsystem condition as the FDPS bit. In
nvmet_execute_identify_ctrl(), NVME_CTRL_ATTR_FDPS is gated on:

	if (nvmet_fdp_subsys_configured(ctrl->subsys))
		ctratt |=3D NVME_CTRL_ATTR_FDPS;

Checking only IS_ENABLED(CONFIG_NVME_TARGET_FDP) causes the log page to
advertise NVME_FEAT_FDP on subsystems that have no FDP-enabled namespaces
and report FDPS as 0.

>  	status =3D nvmet_copy_to_sgl(req, 0, features, sizeof(*features));
>  	kfree(features);

[ ... ]

> diff --git a/drivers/nvme/target/fdp.c b/drivers/nvme/target/fdp.c
> index 17949e3665293..0327970a9cb9d 100644
> --- a/drivers/nvme/target/fdp.c
> +++ b/drivers/nvme/target/fdp.c

[ ... ]

> @@ -83,3 +87,76 @@ void nvmet_fdp_exit_ns(struct nvmet_ns *ns)
>  	ns->fdp.backend_q =3D NULL;
>  	ns->fdp.backend_ctrl =3D NULL;
>  }
> +
> +
> +/*
> + * Each namespace is its own endurance group, so the Endurance Group
> + * Identifier in Command Dword 11, and in the Log Specific Identifier
> + * of the FDP log pages, directly names the namespace.  Returns the
> + * namespace with a reference held.
> + */
> +static struct nvmet_ns *nvmet_fdp_lookup_ns(struct nvmet_req *req, u32 e=
ndgid)
> +{
> +	struct nvmet_subsys *subsys =3D nvmet_req_subsys(req);
> +	struct nvmet_ns *ns;
> +
> +	ns =3D xa_load(&subsys->namespaces, endgid);
> +	if (!ns || !ns->enabled || !nvmet_fdp_enabled(ns))
> +		return NULL;
> +
> +	if (!percpu_ref_tryget_live(&ns->ref))
> +		return NULL;
> +
> +	return ns;
> +}

[Severity: Critical]
Can nvmet_fdp_lookup_ns() cause a use-after-free on struct nvmet_ns or
ns->ref when a Set Features or Get Features command for NVME_FEAT_FDP races
with namespace disable or removal via nvmet_ns_disable() or
nvmet_ns_free()?

In drivers/nvme/target/core.c, nvmet_ns_disable() tears down the namespace
before clearing ns->enabled:

	if (!test_and_clear_bit(NVMET_NS_IO_LIVE, &ns->flags))
		return;
	...
	percpu_ref_kill(&ns->ref);
	synchronize_rcu();
	wait_for_completion(&ns->disable_done);
	percpu_ref_exit(&ns->ref);

	if (ns->pr.enable)
		nvmet_pr_exit_ns(ns);

	nvmet_fdp_exit_ns(ns);

	mutex_lock(&subsys->lock);
	nvmet_ns_changed(subsys, ns->nsid);
	nvmet_ns_dev_disable(ns);
	ns->enabled =3D false;
	mutex_unlock(&subsys->lock);

And nvmet_ns_free() then erases and frees ns without an additional RCU
grace period:

	nvmet_ns_disable(ns);

	mutex_lock(&subsys->lock);

	xa_erase(&subsys->namespaces, ns->nsid);
	...
	kfree(ns->device_path);
	kfree(ns);

Because xa_load() releases its internal RCU read lock before returning,
nvmet_fdp_lookup_ns() holds an unpinned pointer to ns outside of an
rcu_read_lock() critical section. A concurrent nvmet_ns_free() is not
blocked by synchronize_rcu() in nvmet_ns_disable() and can free ns before
nvmet_fdp_lookup_ns() dereferences ns->enabled, ns->fdp.enable, or
&ns->ref.

Additionally, because ns->enabled remains true until after
percpu_ref_exit(&ns->ref) has freed the per-CPU counter data, checking
ns->enabled instead of test_bit(NVMET_NS_IO_LIVE, &ns->flags) allows
nvmet_fdp_lookup_ns() to call percpu_ref_tryget_live(&ns->ref) concurrently
with or after percpu_ref_exit(&ns->ref).

Should nvmet_fdp_lookup_ns() wrap the lookup and reference acquisition in
rcu_read_lock() / rcu_read_unlock(), check test_bit(NVMET_NS_IO_LIVE,
&ns->flags), and use percpu_ref_tryget_live_rcu(&ns->ref) in the same way
as nvmet_req_find_ns()?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019033624.4023=
37-1-kanie@linux.alibaba.com?part=3D7

