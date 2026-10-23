Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD8D606A31E
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2026 08:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=eTCmnbKE;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nrR6ZhC6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=1J1R9RYLiIhPR7R7frRF4TK/KYY5NAh916wUVh/iV1U=; b=eTCmnbKEviDawHmAUAsUQnWu/i
	mnZMEWR+n0Lm8Yw2jJfsMe8xnSjspehhfVEmNzcJrfjFSYbxP62KiKgiRUWGuuFJea3pPxBeodZMV
	bCMt/+p3RWmcAYlh2rzLATN3lrZ87iaKwYOXtllBmZnoazEVJD0YxKB1TsiSv0vurcpoSfipGVa1J
	Yzj9iXt8liK/OFz1fbDrRPsfYoNFBX9/SojWNHyCkk1nnSYJm6H8om41wRkdZUGA3abzGr4WF00Ki
	H7RpHZFhQTyv770EjL1baaxW85XWS+050bXg7Lq/Z8Bi/2q5Ul0u7zMSGvNUN5AHCJgLsCCFk3qO6
	pGcTBbLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKAbT-0000000FvVu-2TmU;
	Fri, 23 Oct 2026 08:26:19 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKAbS-0000000FvVm-3ZHW
	for linux-nvme@lists.infradead.org;
	Fri, 23 Oct 2026 08:26:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4FA17602C5;
	Fri, 23 Oct 2026 08:26:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6F71F01825;
	Fri, 23 Oct 2026 08:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792743976;
	bh=1J1R9RYLiIhPR7R7frRF4TK/KYY5NAh916wUVh/iV1U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nrR6ZhC6MMEzbOkA+iFlOurtHyEaJvk//EY8Pn5g5CoL7nAqLVakEXl3Tc4OxHRaN
	 VPVEp7SPj9zHUDA2rkd6n8GjnUQpFtdUTpZb7/p6gt1p2uJ5qsbnhXxbGBeyFapibk
	 RaLD4ozW/oa+EsRrsqf9NiirtT1l0YxkADI5Ao1sxa7AIRPSfVK68xKVYxRrlhhRLw
	 luKUc3lH2jDd9SRTl2GytZGrFObX/X0tFL+temwaRhQoW5OyJazVKMnbn8Ln87OsVb
	 rc+MMGguBQuiiEgYlTLxMcAMGGp/d9YOLZeIK8O5/M0akAfDUT9pE3EopoN+eB8BoQ
	 NgdUtYlFF1iaA==
Message-ID: <sashiko-outbox-182513@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/11] nvmet: implement the FDP feature
To: "Guixin Liu" <kanie@linux.alibaba.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261023080251.2606443-8-kanie@linux.alibaba.com>
References: <20261023080251.2606443-1-kanie@linux.alibaba.com>
 <20261023080251.2606443-8-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 08:26:15 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] nvmet: fdp: nvmet_fdp_lookup_ns() checks ns->enabled instead of NV=
MET_NS_IO_LIVE
- [Medium] nvmet: nvmet_get_feat_fdp() fails on non-FDP namespaces in mixed=
 subsystems
--

commit 306dfd499967efa07a30c35673d8c81562928443
Author: Guixin Liu <kanie@linux.alibaba.com>

nvmet: implement the FDP feature

This commit implements Set Features and Get Features for the Flexible Data
Placement feature (FID 1Dh) and advertises it in the Supported Features log
page when FDP is configured on the subsystem.

> diff --git a/drivers/nvme/target/fdp.c b/drivers/nvme/target/fdp.c
> index 17949e3665293..5008294984885 100644
> --- a/drivers/nvme/target/fdp.c
> +++ b/drivers/nvme/target/fdp.c

[ ... ]

> @@ -83,3 +87,82 @@ void nvmet_fdp_exit_ns(struct nvmet_ns *ns)
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
> +	rcu_read_lock();
> +	ns =3D xa_load(&subsys->namespaces, endgid);
> +	if (!ns || !ns->enabled || !nvmet_fdp_enabled(ns))
> +		goto out_unlock;
> +
> +	if (!percpu_ref_tryget_live(&ns->ref))
> +		goto out_unlock;

[Severity: High]
Can checking ns->enabled instead of test_bit(NVMET_NS_IO_LIVE, &ns->flags)
here race with nvmet_ns_disable() and nvmet_ns_enable()?

After commits 42b0f5196dc2 ("nvmet: defer setting ns->enabled to false in
nvmet_ns_disable()") and 3fdd281e0a04 ("nvmet: don't allow I/O admission
after percpu ns reference is killed"), nvmet_ns_disable() clears
NVMET_NS_IO_LIVE and tears down ns->ref before setting ns->enabled to false:

drivers/nvme/target/core.c:nvmet_ns_disable() {
	if (!test_and_clear_bit(NVMET_NS_IO_LIVE, &ns->flags))
		return;
	...
	percpu_ref_kill(&ns->ref);
	synchronize_rcu();
	wait_for_completion(&ns->disable_done);
	percpu_ref_exit(&ns->ref);
	...
	mutex_lock(&subsys->lock);
	nvmet_ns_changed(subsys, ns->nsid);
	nvmet_ns_dev_disable(ns);
	ns->enabled =3D false;
	mutex_unlock(&subsys->lock);
}

Because ns->enabled remains true across percpu_ref_kill(&ns->ref),
synchronize_rcu(), and percpu_ref_exit(&ns->ref), a concurrent
nvmet_set_feat_fdp() or nvmet_get_feat_fdp() calling nvmet_fdp_lookup_ns()
can still observe ns->enabled =3D=3D true and call percpu_ref_tryget_live(&=
ns->ref)
while or after percpu_ref_exit(&ns->ref) frees the per-CPU counter.

Similarly, in nvmet_ns_enable(), ns->enabled =3D true is a plain store with=
 no
release barrier after percpu_ref_init(&ns->ref, ...), whereas NVMET_NS_IO_L=
IVE
is set after xa_set_mark():

drivers/nvme/target/core.c:nvmet_ns_enable() {
	ret =3D percpu_ref_init(&ns->ref, nvmet_destroy_namespace, 0, GFP_KERNEL);
	if (ret)
		goto out_fdp_exit;

	nvmet_ns_changed(subsys, ns->nsid);
	ns->enabled =3D true;
	xa_set_mark(&subsys->namespaces, ns->nsid, NVMET_NS_ENABLED);
	nvmet_debugfs_ns_setup(ns);
	set_bit(NVMET_NS_IO_LIVE, &ns->flags);
}

Should nvmet_fdp_lookup_ns() check test_bit(NVMET_NS_IO_LIVE, &ns->flags) a=
nd
use percpu_ref_tryget_live_rcu(&ns->ref), matching nvmet_req_find_ns()?

> +
> +	rcu_read_unlock();
> +	return ns;
> +
> +out_unlock:
> +	rcu_read_unlock();
> +	return NULL;
> +}

[ ... ]

> +u16 nvmet_get_feat_fdp(struct nvmet_req *req)
> +{
> +	struct nvmet_ns *ns;
> +
> +	ns =3D nvmet_fdp_lookup_ns(req,
> +				 le32_to_cpu(req->cmd->features.dword11));
> +	if (!ns)
> +		return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;

[Severity: Medium]
What happens in a subsystem that contains both FDP-enabled and non-FDP
namespaces?

When at least one namespace in the subsystem has FDP enabled,
nvmet_fdp_subsys_configured() returns true, so the controller advertises
NVME_CTRL_ATTR_FDPS in ctratt and NVME_FEAT_FDP in the Supported Features l=
og
page. Every enabled namespace is exposed as its own endurance group
(endgid =3D nsid).

When the Linux NVMe host scans namespaces on a controller with
NVME_CTRL_ATTR_FDPS set, nvme_alloc_ns_head() -> nvme_query_fdp_info() issu=
es
Get Features (NVME_FEAT_FDP) for each namespace's endgid and checks whether
FDPCFG_FDPE is set in the result:

drivers/nvme/host/core.c:nvme_query_fdp_info() {
	ret =3D nvme_get_features(ctrl, NVME_FEAT_FDP, info->endgid, NULL, 0,
				&fdp);
	if (ret) {
		dev_warn(ctrl->device, "FDP get feature status:0x%x\n", ret);
		return ret;
	}

	if (!(fdp.flags & FDPCFG_FDPE))
		return 0;
}

Because nvmet_get_feat_fdp() uses nvmet_fdp_lookup_ns(), which rejects
namespaces where !nvmet_fdp_enabled(ns), won't Get Features fail with
NVME_SC_INVALID_FIELD | NVME_STATUS_DNR on valid non-FDP namespaces instead
of succeeding with result 0 (FDPE cleared) when nvmet_fdp_subsys_configured=
()
is true?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023080251.2606=
443-1-kanie@linux.alibaba.com?part=3D7

