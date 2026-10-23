Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09516606A31A
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2026 08:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rumvs96d;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n+ruY2FF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=GHHjobLPKXZ2I/flGEFtASHLAgMzDqnTtMW4RKZLWn8=; b=rumvs96d+F5c5Db+hgqJSiffE7
	ut3dPHcPEeWuavJ59Ic6+UoylTVgOYO8jqFbhrK69jYcQ9pDsBaNwjo/FeiCC6BJbr9pjqUknWmx+
	/sPzJfxbyCiySjpbfirIT9X03nZnji/svlUIhh0Z7/539qOZW1R99FjmynMk/kUF4CEt7rkoV4K0I
	8N/c2AtSKA/izcySfnAcHz6zPODUuTkPEy3cexVD3O4rrl4GNPhQO1y7MWTmT++eOBltbDKS/irLE
	b42EAxUtQg/4A6lPM7ds9asuxBPXcHB7MzlImAk9tdiyoFlshlGbpyrNKDXa98NWAdoiXLQjvq4Vw
	5zCxymTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKAmQ-0000000Fwbg-2wAV;
	Fri, 23 Oct 2026 08:37:38 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKAmP-0000000Fwb2-1mmE
	for linux-nvme@lists.infradead.org;
	Fri, 23 Oct 2026 08:37:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EEA23421F2;
	Fri, 23 Oct 2026 08:37:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73751F01825;
	Fri, 23 Oct 2026 08:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792744656;
	bh=GHHjobLPKXZ2I/flGEFtASHLAgMzDqnTtMW4RKZLWn8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n+ruY2FFYnczL+PrxNB4oaJ+4LmDDJldoj+UkhjLQhSSRDWBPoyhqsfEdIkAVsJlz
	 D8Ip00l9soOAaD7aOcdqAYNzgZC61s7ezDSMIaw84QSsf5luCDVMPNwjzaaSgq/V4D
	 14L1IMZ335a0xv+dsOj9M/F7DT6wn8P8SG2kxLL71sMwzALwq6BWhEZOmDLZrAmI2X
	 Z1SevPCuOXjUqSr2m7OF5Ns2G3prfH/zjPdk0XepTmMWj07Uqjxq80z6W2OpM7wOuF
	 Edrk7Ddu9NFQ3gQKckRD420JJ6dJk06umQ5+Te7atK6DtEtnVmmMvT1KDAcFp0L/bq
	 G8H85Imlm2k0w==
Message-ID: <sashiko-outbox-182526@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/11] nvmet: serve the FDP log pages
To: "Guixin Liu" <kanie@linux.alibaba.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261023080251.2606443-10-kanie@linux.alibaba.com>
References: <20261023080251.2606443-1-kanie@linux.alibaba.com>
 <20261023080251.2606443-10-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 08:37:36 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] nvmet: unsanitized cmd and truncated transfer_len in nvmet_fdp=
_log_forward()
- [High] nvmet: broken partial/offset reads and unbounded kzalloc() in FDP =
log handlers
- [High] nvmet: check NVMET_NS_IO_LIVE instead of ns->enabled in nvmet_fdp_=
lookup_ns()
--

commit 6fe9b61853a62f18f9ae3bb5a0ad4dcfebf1822f
Author: Guixin Liu <kanie@linux.alibaba.com>

nvmet: serve the FDP log pages

This commit adds support for serving the FDP Configurations log page
from the target's namespace configuration snapshot and forwarding the
remaining FDP log pages to the backing controller over its admin queue.

> diff --git a/drivers/nvme/target/fdp.c b/drivers/nvme/target/fdp.c
> index 807f54c73c4e1..011f022e857aa 100644
> --- a/drivers/nvme/target/fdp.c
> +++ b/drivers/nvme/target/fdp.c

[ ... ]

> @@ -355,3 +354,100 @@ static int nvmet_fdp_init_backend(struct nvmet_ns *=
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
with nvmet_ns_disable() and nvmet_ns_free()?

In drivers/nvme/target/fdp.c, nvmet_fdp_lookup_ns() checks ns->enabled
under rcu_read_lock() instead of test_bit(NVMET_NS_IO_LIVE, &ns->flags):

drivers/nvme/target/fdp.c:nvmet_fdp_lookup_ns() {
	rcu_read_lock();
	ns =3D xa_load(&subsys->namespaces, endgid);
	if (!ns || !ns->enabled || !nvmet_fdp_enabled(ns))
		goto out_unlock;

	if (!percpu_ref_tryget_live(&ns->ref))
		goto out_unlock;
}

However, in drivers/nvme/target/core.c, nvmet_ns_disable() clears
NVMET_NS_IO_LIVE, kills the percpu_ref, and runs synchronize_rcu() and
nvmet_fdp_exit_ns() before setting ns->enabled =3D false:

drivers/nvme/target/core.c:nvmet_ns_disable() {
	if (!test_and_clear_bit(NVMET_NS_IO_LIVE, &ns->flags))
		return;
	...
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

When nvmet_ns_free() calls nvmet_ns_disable(), it immediately erases the
namespace from subsys->namespaces and calls kfree(ns) without another RCU
grace period after ns->enabled is cleared. An RCU reader in
nvmet_fdp_lookup_ns() entering after synchronize_rcu() can still see
ns->enabled =3D=3D true and call percpu_ref_tryget_live(&ns->ref) on freed
memory.

Additionally, if a reader in nvmet_fdp_lookup_ns() passes the ns->enabled
and nvmet_fdp_enabled(ns) checks while the namespace is being disabled, and
the namespace is then reconfigured with FDP disabled and re-enabled via
nvmet_ns_enable() (which re-initializes ns->ref),
percpu_ref_tryget_live(&ns->ref) can succeed after nvmet_fdp_exit_ns() has
set ns->fdp.backend_ctrl =3D NULL, leading to a NULL pointer dereference of
ns->fdp.backend_ctrl->admin_q in nvmet_fdp_log_forward().

Should nvmet_fdp_lookup_ns() check test_bit(NVMET_NS_IO_LIVE, &ns->flags)
just like nvmet_req_find_ns() does?

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

[Severity: High]
What happens here when a host performs a partial read with
sizeof(*log) < req->transfer_len < total (or req->transfer_len < sizeof(*lo=
g)),
or specifies a non-zero Log Page Offset (req->cmd->get_log_page.lpo)?

Because desc is only populated when req->transfer_len >=3D total, any parti=
al
read between sizeof(*log) and total (such as reading the header plus the
fixed portion of struct nvme_fdp_config_desc, or reading the descriptor at
a non-zero lpo with transfer_len =3D=3D dsze) will copy all-zeroes for the
descriptor, even though nvmet_execute_identify_ctrl() advertises LPO support
in id->lpa.

Also, passing the initiator-controlled req->transfer_len directly to
kzalloc(req->transfer_len, GFP_KERNEL) here and in nvmet_fdp_log_forward()
without bounding the length or passing __GFP_NOWARN allows a large SGL
transfer_len (for example on RDMA) to exceed KMALLOC_MAX_SIZE and trigger
WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp) in the page allocator.

Could nvmet_execute_get_log_page_fdp_configs() instead allocate total bytes
(which is bounded because ns->fdp.nruh <=3D U8_MAX), populate the log header
and descriptor unconditionally, and copy the requested slice based on
nvmet_get_log_page_offset(req->cmd) and req->transfer_len (similar to
nvmet_execute_disc_get_log_page() in drivers/nvme/target/discovery.c)?

> +
> +	status =3D nvmet_copy_to_sgl(req, 0, log, req->transfer_len);
> +	kfree(log);
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
Can forwarding a raw copy of *req->cmd with the 32-bit result of
nvmet_get_log_page_len() cause the backing NVMe controller to DMA into
arbitrary host addresses or overflow buf?

In drivers/nvme/target/admin-cmd.c, nvmet_execute_get_log_page() checks
req->transfer_len against nvmet_get_log_page_len(req->cmd), which computes
the byte length in 32-bit u32 arithmetic:

drivers/nvme/target/admin-cmd.c:nvmet_get_log_page_len() {
	u32 len =3D le16_to_cpu(cmd->get_log_page.numdu);

	len <<=3D 16;
	len +=3D le16_to_cpu(cmd->get_log_page.numdl);
	/* NUMD is a 0's based value */
	len +=3D 1;
	len *=3D sizeof(u32);

	return len;
}

When the 32-bit NUMD value ((numdu << 16) | numdl) is >=3D 0x3fffffff,
(NUMD + 1) * sizeof(u32) overflows u32 and wraps modulo 2^32. Meanwhile,
nvmet_fdp_log_forward() copies the raw command (c =3D *req->cmd) without
clearing c.common.dptr or c.get_log_page.rsvd2, and passes the untruncated
numdu/numdl to the backing controller:

1. If NUMD wraps len to 0 (e.g. NUMD =3D=3D 0x3fffffff with a 0-length SGL =
so
req->transfer_len =3D=3D 0), nvmet_check_transfer_len(req, 0) succeeds and
kzalloc(0, GFP_KERNEL) returns ZERO_SIZE_PTR. In __nvme_submit_sync_cmd(),
nvme_init_request() clears NVME_CMD_SGL_ALL from c.common.flags (switching
the command to PRP mode) and skips blk_rq_map_kern() because bufflen is 0:

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

In nvme_prep_rq(), blk_rq_nr_phys_segments(req) is 0, so nvme_map_data() is
skipped and the initiator's raw c.common.dptr (prp1/prp2) remains in the
admin SQE with NUMD >=3D 0x3fffffff, instructing the backing PCIe controller
to DMA the log page into initiator-chosen physical/IOVA addresses.

2. If NUMD wraps len to a small non-zero value (e.g. numdu =3D=3D 0x4000,
numdl =3D=3D 0x0000 so req->transfer_len =3D=3D 4), kzalloc(4, GFP_KERNEL) =
allocates
an 8-byte slab buffer and blk_rq_map_kern() maps 4 bytes, while numdu/numdl
in the forwarded admin SQE requests 4 GiB + 4 bytes. Since PCIe admin
queues use PRPs (which do not encode buffer length), the backing controller
DMAs the full FDP log page past the end of buf.

Should nvmet_fdp_log_forward() construct a clean struct nvme_command (or
zero c.common.dptr and rsvd2 as nvmet_fdp_io_mgmt_forward() does for dptr)
and derive numdl/numdu from a bounded buffer length (or use a host helper
like nvme_get_log_lsi()), and should nvmet_get_log_page_len() avoid 32-bit
overflow?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023080251.2606=
443-1-kanie@linux.alibaba.com?part=3D9

