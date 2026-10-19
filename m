Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F46CCF2D4
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 04:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vl3UTF+uxZrOEQ92cmG6FwKGhtyz2dVw61IzQlf4nSM=; b=lt8Cld6itvtaJvd2lBku4ofxgi
	diEYtzfm6Iuvd01evNJ9JsFDV4TIz6g2VFgfBf1vP99jRAeoWVf28mAxyilsKFq9LlzYG2apKZG31
	lbzKnA1fIrFuSgLm259oAXdulLVPBFatb1BHs3DO53spqHy2xaSovEvkTHz4i6rXWN4DbqntQrz40
	x+rlnPbyVKsb10CrCivmhKCln3Wyn73tMAHXEey5M2ae6aJLWIFPfAX3/T4Av7Z1lHuH2AgFXfhxo
	tPkdobbTXM8O9Zq+v3uXBuhQIGXI1pKAfVf0tr4aN39RwYvEr4qDnWR4Mt1Fg1/inouUEiShv12Wt
	+ICw3nJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIef1-00000006ZzS-2Ye9;
	Mon, 19 Oct 2026 04:07:43 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIeez-00000006ZzM-3vXa
	for linux-nvme@lists.infradead.org;
	Mon, 19 Oct 2026 04:07:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1227F601DB;
	Mon, 19 Oct 2026 04:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97A31F000C4;
	Mon, 19 Oct 2026 04:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792382860;
	bh=Vl3UTF+uxZrOEQ92cmG6FwKGhtyz2dVw61IzQlf4nSM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nEyrwOk+C6pTfU0EADLpDoD5AilefuCs1w7969wrwNWNLephon86mWOHY6K8plIG7
	 SBjbxnGT5V6n/AOTq5+N6yA0ANrXmN295xv12Y+WxdPsuDV4vnsuj0T9OIJu1nYYuQ
	 xTzkbO8FeqF/uVmiEoMyCJSNTREi1lixYmcjgHx3Kk/2BvRd9qfkHDSzMlYpJjbg20
	 qZ3nyg63QGlkGRNRlSN08uAIPitbi0X6rFgzcM0aHwW4VT49dvvwinfGaeBUqHub3V
	 MvL3qFVXYAlqFXShphFTE0OmAkZQO5984DWbCNjZ0CHTusXMya4ZSRar50HmOPhDlW
	 K0oaAGNwGkLIw==
Message-ID: <sashiko-outbox-176612@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/11] nvmet: serve the FDP log pages
To: "Guixin Liu" <kanie@linux.alibaba.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261019033624.402337-10-kanie@linux.alibaba.com>
References: <20261019033624.402337-1-kanie@linux.alibaba.com>
 <20261019033624.402337-10-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 04:07:40 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] nvmet: unvalidated numd and raw cmd copy in nvmet_fdp_log_forw=
ard()
- [High] nvmet: race and UAF in nvmet_fdp_lookup_ns() during log page lookup
- [Medium] nvmet: wrong buffer sizing and missing lpo handling in FDP log h=
andlers
--

commit ed3a3e1b914df9ead808e45ef64cb2a7ed4fbd7a
Author: Guixin Liu <kanie@linux.alibaba.com>

nvmet: serve the FDP log pages

This commit adds support for serving the FDP log pages (20h to 23h) in the
NVMe target by constructing the FDP Configurations log page locally and
forwarding the remaining FDP log pages to the backing controller.

> diff --git a/drivers/nvme/target/fdp.c b/drivers/nvme/target/fdp.c
> index 6458efadbcb8e..8c0bc297471ec 100644
> --- a/drivers/nvme/target/fdp.c
> +++ b/drivers/nvme/target/fdp.c
[ ... ]
> @@ -333,3 +332,100 @@ static int nvmet_fdp_init_backend(struct nvmet_ns *=
ns)
>  	return ret;
>  }
> =20
> +void nvmet_execute_get_log_page_fdp_configs(struct nvmet_req *req)
> +{
> +	u32 lsi =3D le16_to_cpu(req->cmd->get_log_page.lsi);
> +	struct nvme_fdp_config_desc *desc;
> +	struct nvme_fdp_config_log *log;
> +	struct nvmet_ns *ns;
> +	size_t dsze, total;
> +	u16 status =3D 0;
> +	int i;
> +
> +	ns =3D nvmet_fdp_lookup_ns(req, lsi);
> +	if (!ns) {
> +		status =3D NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
> +		goto out;
> +	}

[Severity: High]
Can calling nvmet_fdp_lookup_ns() here and in nvmet_fdp_log_forward() race
with nvmet_ns_disable() and nvmet_ns_free(), leading to a use-after-free on
ns or ns->ref.data, or a NULL pointer dereference on
ns->fdp.backend_ctrl->admin_q?

In drivers/nvme/target/fdp.c, nvmet_fdp_lookup_ns() looks up the namespace
without holding rcu_read_lock() or checking NVMET_NS_IO_LIVE:

drivers/nvme/target/fdp.c:nvmet_fdp_lookup_ns() {
	ns =3D xa_load(&subsys->namespaces, endgid);
	if (!ns || !ns->enabled || !nvmet_fdp_enabled(ns))
		return NULL;

	if (!percpu_ref_tryget_live(&ns->ref))
		return NULL;

	return ns;
}

Whereas in drivers/nvme/target/core.c, nvmet_ns_disable() clears
NVMET_NS_IO_LIVE, waits for an RCU grace period, exits ns->ref, and tears
down FDP state before setting ns->enabled to false:

drivers/nvme/target/core.c:nvmet_ns_disable() {
	clear_bit(NVMET_NS_IO_LIVE, &ns->flags);
	mutex_unlock(&subsys->lock);

	percpu_ref_kill(&ns->ref);
	synchronize_rcu();
	wait_for_completion(&ns->disable_done);
	percpu_ref_exit(&ns->ref);
	...
	nvmet_fdp_exit_ns(ns);

	mutex_lock(&subsys->lock);
	nvmet_ns_changed(subsys, ns->nsid);
	nvmet_ns_dev_disable(ns);
	ns->enabled =3D false;
	mutex_unlock(&subsys->lock);
}

Because nvmet_fdp_lookup_ns() does not hold rcu_read_lock() across
xa_load() and percpu_ref_tryget_live_rcu(), synchronize_rcu() in
nvmet_ns_disable() will not wait for a thread inside nvmet_fdp_lookup_ns(),
allowing percpu_ref_exit(&ns->ref) and kfree(ns) in nvmet_ns_free() to run
while nvmet_fdp_lookup_ns() is still accessing ns and ns->ref.

Additionally, because ns->enabled stays true while percpu_ref_exit() and
nvmet_fdp_exit_ns() run, if the namespace is disabled, reconfigured with
FDP disabled, and re-enabled concurrently, percpu_ref_tryget_live(&ns->ref)
can succeed on the re-initialized reference after nvmet_fdp_exit_ns() has
cleared ns->fdp.backend_ctrl to NULL.

Should nvmet_fdp_lookup_ns() wrap the lookup in rcu_read_lock() /
rcu_read_unlock(), test NVMET_NS_IO_LIVE, and use
percpu_ref_tryget_live_rcu() like nvmet_req_find_ns() does, while re-checki=
ng
nvmet_fdp_enabled(ns) after acquiring the reference?

> +
> +	dsze =3D ALIGN(struct_size(desc, ruhs, ns->fdp.nruh), 8);
> +	total =3D sizeof(*log) + dsze;
> +
> +	log =3D kzalloc(req->transfer_len, GFP_KERNEL);
> +	if (!log) {
> +		status =3D NVME_SC_INTERNAL;
> +		goto out_put;
> +	}
> +
> +	if (req->transfer_len >=3D sizeof(*log)) {
> +		/* single configuration, 0's based */
> +		log->numfdpc =3D 0;
> +		log->ver =3D 0;
> +		log->sze =3D cpu_to_le32(total);
> +	}
> +	if (req->transfer_len >=3D total) {
> +		desc =3D (void *)(log + 1);
> +		desc->dsze =3D cpu_to_le16(dsze);
> +		/* FDPCV set, FDPVWC clear, RGIF 0 for the single RG */
> +		desc->fdpa =3D 1 << 7;
> +		desc->nrg =3D cpu_to_le32(1);
> +		desc->nruh =3D cpu_to_le16(ns->fdp.nruh);
> +		desc->maxpids =3D cpu_to_le16(ns->fdp.nruh - 1);
> +		desc->nns =3D cpu_to_le32(1);
> +		desc->runs =3D cpu_to_le64(ns->fdp.runs);
> +		/* all handles Initially Isolated */
> +		for (i =3D 0; i < ns->fdp.nruh; i++)
> +			desc->ruhs[i].ruht =3D 0x1;
> +	}
> +
> +	status =3D nvmet_copy_to_sgl(req, 0, log, req->transfer_len);
> +	kfree(log);

[Severity: Medium]
What happens if a host issues a partial read with req->transfer_len between
sizeof(*log) and total, or uses a non-zero Log Page Offset (lpo), or passes
a very large req->transfer_len?

If a host requests a partial transfer where sizeof(*log) < req->transfer_len
< total (for example, reading the header plus the fixed portion of
nvme_fdp_config_desc), the req->transfer_len >=3D total check is false, so
desc is left completely zeroed in the returned buffer. Similarly, if a host
reads the header at lpo =3D 0 and then reads the descriptor at lpo =3D 16
(since nvmet_execute_identify_ctrl() advertises NVME_CTRL_LPA_LPOS in
id->lpa), nvmet_execute_get_log_page_fdp_configs() ignores
nvmet_get_log_page_offset(req->cmd) and returns the header again at offset =
0.

Also, both nvmet_execute_get_log_page_fdp_configs() and
nvmet_fdp_log_forward() pass the host-controlled req->transfer_len directly
to kzalloc(..., GFP_KERNEL) without size bounds or __GFP_NOWARN, which can
trigger a page allocator warning when req->transfer_len > KMALLOC_MAX_SIZE.

Since total is at most 1104 bytes (given ns->fdp.nruh <=3D U8_MAX), could
nvmet_execute_get_log_page_fdp_configs() allocate and populate the fixed
total-sized buffer unconditionally, and then copy the requested slice taking
nvmet_get_log_page_offset(req->cmd) into account?

> +out_put:
> +	percpu_ref_put(&ns->ref);
> +out:
> +	nvmet_req_complete(req, status);
> +}
> +
> +/*
> + * Forward an FDP log page that the backing controller owns, addressed
> + * by the Endurance Group Identifier of the backing endurance group.
> + */
> +void nvmet_fdp_log_forward(struct nvmet_req *req)
> +{
> +	struct nvme_command c =3D {};
> +	struct nvmet_ns *ns;
> +	u16 status =3D 0;
> +	void *buf;
> +	int ret;
> +
> +	ns =3D nvmet_fdp_lookup_ns(req,
> +				 le16_to_cpu(req->cmd->get_log_page.lsi));
> +	if (!ns) {
> +		status =3D NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
> +		goto out;
> +	}
> +
> +	buf =3D kzalloc(req->transfer_len, GFP_KERNEL);
> +	if (!buf) {
> +		status =3D NVME_SC_INTERNAL;
> +		goto out_put;
> +	}
> +
> +	c =3D *req->cmd;
> +	c.get_log_page.nsid =3D cpu_to_le32(0);
> +	c.get_log_page.lsi =3D cpu_to_le16(ns->fdp.backend_endgid);
> +	ret =3D nvme_submit_sync_cmd(ns->fdp.backend_ctrl->admin_q, &c, buf,
> +				   req->transfer_len);

[Severity: Critical]
Can a host wrap the 32-bit length calculation in nvmet_get_log_page_len()
and cause nvmet_fdp_log_forward() to submit an unsanitized command with a
mismatched buffer size or untrusted dptr to the backing controller's admin
queue?

In drivers/nvme/target/admin-cmd.c, nvmet_execute_get_log_page() checks
req->transfer_len against nvmet_get_log_page_len(req->cmd):

drivers/nvme/target/admin-cmd.c:nvmet_get_log_page_len() {
	u32 len =3D le16_to_cpu(cmd->get_log_page.numdu);

	len <<=3D 16;
	len +=3D le16_to_cpu(cmd->get_log_page.numdl);
	/* NUMD is a 0's based value */
	len +=3D 1;
	len *=3D sizeof(u32);

	return len;
}

When (numdu << 16) + numdl >=3D 0x3fffffff, the 32-bit calculation in
nvmet_get_log_page_len() wraps around:

1. If a host sends NUMD =3D 0x3fffffff (or 0xffffffff) with a 0-byte SGL
(req->transfer_len =3D=3D 0), nvmet_get_log_page_len() wraps to 0 and
nvmet_check_transfer_len() passes. In nvmet_fdp_log_forward(),
kzalloc(0, GFP_KERNEL) returns ZERO_SIZE_PTR, and c =3D *req->cmd copies the
host's raw command including req->cmd->common.dptr and the large
numdu/numdl. In __nvme_submit_sync_cmd():

drivers/nvme/host/core.c:__nvme_submit_sync_cmd() {
	nvme_init_request(req, cmd);
	if (flags & NVME_SUBMIT_RETRY)
		req->cmd_flags &=3D ~REQ_FAILFAST_DRIVER;

	if (buffer && bufflen) {
		ret =3D blk_rq_map_kern(req, buffer, bufflen, GFP_KERNEL);
		if (ret)
			goto out;
	}
}

Because bufflen is 0, blk_rq_map_kern() and subsequent DMA mapping are
skipped after nvme_init_request() has cleared NVME_CMD_SGL_ALL, so the
backing controller receives a Get Log Page command in PRP mode with a
multi-gigabyte NUMD and the host's raw dptr.prp1/prp2 values.

2. If a host sends NUMD =3D 0x40000000 with a 4-byte SGL (req->transfer_len
=3D=3D 4), nvmet_get_log_page_len() wraps to 4. nvmet_fdp_log_forward()
allocates a 4-byte slab buffer, but forwards c with numdu =3D 0x4000 to the
PCIe admin queue (which uses PRPs without a buffer length field), causing
the backing controller to DMA the full log page into the 4-byte slab buffer
and overflow adjacent kernel heap memory.

Instead of copying *req->cmd raw, should nvmet_fdp_log_forward() construct
a clean struct nvme_command from validated fields (or use a helper like
nvme_get_log_ext()) and reject zero or oversized transfer lengths?

> +	if (ret) {
> +		status =3D ret > 0 ? ret : NVME_SC_INTERNAL;
> +		goto free;
> +	}
> +
> +	status =3D nvmet_copy_to_sgl(req, 0, buf, req->transfer_len);
> +free:
> +	kfree(buf);
> +out_put:
> +	percpu_ref_put(&ns->ref);
> +out:
> +	nvmet_req_complete(req, status);
> +}

[ ... ]

> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index c86fb2c19c152..8f48227323fea 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019033624.4023=
37-1-kanie@linux.alibaba.com?part=3D9

