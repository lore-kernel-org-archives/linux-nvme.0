Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1CF4CCA46C
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 03:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oo32jgn+L6WerFOxSP9M3w2tLnk2PJOTD4MsCg+MXco=; b=3nRM+u/Xviqxw9cSdZEYHBnFpT
	BJUtM6kFn5O5Y6npCG1ZrCtKbuLf2CIWSHdmmK6gkfm7juBaV42zQ/ZfJG2s+plwpNgqC2QqpnIdw
	owtvInlUJoFL9jy4LkxEdmnrf8aOSvHZ0owDToRLpB5NgxUmeWp502JpJLAlTc0NOi2cxYXZ/0mh9
	JmiU+qtWYV32t9RTqtgcXHVR5M9snvHFXZQ9o4HWDNqjZuMHTnTI2l861XTLRnPvfREuUKLptMAh8
	/xhQ4tgV+JYyTz5lhzfk1uvK9AGXh7r+PGSF/DmUB4NGACJd3rRUrmciPFESmhEQKV6FSWubDc4eq
	XhNOqiIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIeUs-00000006ZjR-2rHC;
	Mon, 19 Oct 2026 03:57:14 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIeUr-00000006ZjK-1EnQ
	for linux-nvme@lists.infradead.org;
	Mon, 19 Oct 2026 03:57:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C6F3E43DF8;
	Mon, 19 Oct 2026 03:57:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D6B1F000C4;
	Mon, 19 Oct 2026 03:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792382232;
	bh=oo32jgn+L6WerFOxSP9M3w2tLnk2PJOTD4MsCg+MXco=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jbFRyWNMN/95quC3DTat7yOQbddWNPBBHAHCgxTWdreOh6c8YDkB9fQdWe9Mm+R9o
	 XhtxbFQpOfwVPYXX9tjW7BwtiDfMMkK25Yvu8HYRCT4taPNwnbxUCBBxK2YYF7DRFq
	 e8zu0QSdVCGabvSo3PavIgyxmUZGmrKFVr4T/Q/+Jpxk2jRfMUjHD4bWKEG/pZbhJL
	 /tSSiaQHMsaxEEKmxALFkLk8ptw4fwbKS2PNkN6lJgU3OJzL2PsIqIblsQdnqaVLMA
	 2QajsB8IRk3nBtK336guKRrjETYakBwFTppBVuXF8coHkR1AGxzn1ynlbtXPRFiCVG
	 t+cbmC/0xG+Fg==
Message-ID: <sashiko-outbox-176607@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/11] nvmet: forward the FDP I/O management commands to
 the backing device
To: "Guixin Liu" <kanie@linux.alibaba.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261019033624.402337-9-kanie@linux.alibaba.com>
References: <20261019033624.402337-1-kanie@linux.alibaba.com>
 <20261019033624.402337-9-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 03:57:12 +0000
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
- [Critical] nvmet: missing transfer_len check and numd overflow in FDP io_=
mgmt
- [High] nvmet: FDP io_mgmt bypasses PR checks and fails recv on readonly ns
- [Medium] nvmet: nvmet_fdp_init_ns() returns positive status and leaks ptrs
--

commit 7240be6ef505919551b3b5eef502431a1b23ca3e
Author: Guixin Liu <kanie@linux.alibaba.com>

nvmet: forward the FDP I/O management commands to the backing device

This commit learns the backing namespace FDP geometry when enabling an
FDP namespace and forwards I/O Management Receive and Send commands to
the backing NVMe device via a linear kernel buffer.

> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 14f55631cf502..cdf5a4c183edd 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -1110,9 +1110,22 @@ static u32 nvmet_io_cmd_transfer_len(struct nvmet_=
req *req)
>  		return nvmet_dsm_len(req);
>  	case nvme_cmd_zone_mgmt_recv:
>  		return (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;
> +	case nvme_cmd_io_mgmt_recv:
> +		if (IS_ENABLED(CONFIG_NVME_TARGET_FDP))
> +			return (le32_to_cpu(req->cmd->imr.numd) + 1) << 2;
> +		break;
> +	case nvme_cmd_io_mgmt_send:
> +		if (IS_ENABLED(CONFIG_NVME_TARGET_FDP)) {
> +			u32 npid =3D le16_to_cpu(req->cmd->ims.mos);
> +
> +			return (npid + 1) * sizeof(__le16);
> +		}
> +		break;

[Severity: Critical]
In nvmet_io_cmd_transfer_len(), can the 32-bit unsigned calculation
(le32_to_cpu(req->cmd->imr.numd) + 1) << 2 overflow and wrap to 0 or a
small truncated value when req->cmd->imr.numd is >=3D 0x3fffffff? Also, for
nvme_cmd_io_mgmt_send, does computing (npid + 1) * sizeof(__le16) assume
req->cmd->ims.mo is NVME_IO_MGMT_SEND_MO_RUH_UPDATE before checking mo?

>  	default:
> -		return 0;
> +		break;
>  	}
> +
> +	return 0;
>  }
> =20
>  static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
> @@ -1154,6 +1167,17 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *re=
q)
>  			return ret;
>  	}
> =20
> +	if (IS_ENABLED(CONFIG_NVME_TARGET_FDP)) {
> +		switch (req->cmd->common.opcode) {
> +		case nvme_cmd_io_mgmt_recv:
> +			req->execute =3D nvmet_execute_io_mgmt_recv;
> +			return 0;
> +		case nvme_cmd_io_mgmt_send:
> +			req->execute =3D nvmet_execute_io_mgmt_send;
> +			return 0;
> +		}
> +	}
> +

[Severity: High]
Does returning 0 early here in nvmet_parse_io_cmd() bypass the persistent
reservation checks at the end of the function:

	if (req->ns->pr.enable) {
		ret =3D nvmet_pr_check_cmd_access(req);
		if (ret)
			return ret;

		ret =3D nvmet_pr_get_ns_pc_ref(req);
	}

In addition, neither nvme_cmd_io_mgmt_recv nor nvme_cmd_io_mgmt_send is
handled in nvmet_is_req_write_cmd_group() or nvmet_is_req_read_cmd_group()
in drivers/nvme/target/pr.c, so unauthorized hosts can issue Reclaim Unit
Handle Updates and reads despite an active reservation, and
nvmet_pr_do_abort() will not wait for in-flight I/O management commands.

Separately, earlier in nvmet_parse_io_cmd(), nvmet_io_cmd_check_access()
only allows nvme_cmd_read and nvme_cmd_flush when req->ns->readonly is
set:

	if (unlikely(req->ns->readonly)) {
		switch (req->cmd->common.opcode) {
		case nvme_cmd_read:
		case nvme_cmd_flush:
			break;
		default:
			return NVME_SC_NS_WRITE_PROTECTED;
		}
	}

Should nvme_cmd_io_mgmt_recv also be permitted on a read-only namespace
instead of failing with NVME_SC_NS_WRITE_PROTECTED?

[ ... ]

> diff --git a/drivers/nvme/target/fdp.c b/drivers/nvme/target/fdp.c
> index 0327970a9cb9d..6458efadbcb8e 100644
> --- a/drivers/nvme/target/fdp.c
> +++ b/drivers/nvme/target/fdp.c
> @@ -34,6 +34,8 @@ bool nvmet_fdp_subsys_configured(struct nvmet_subsys *s=
ubsys)
>  	return ret;
>  }
> =20
> +static int nvmet_fdp_init_backend(struct nvmet_ns *ns);
> +
>  int nvmet_fdp_init_ns(struct nvmet_ns *ns)
>  {
>  	struct block_device *bdev =3D ns->bdev;
> @@ -78,8 +80,9 @@ int nvmet_fdp_init_ns(struct nvmet_ns *ns)
>  	backend_ns =3D bdev->bd_disk->private_data;
>  	ns->fdp.backend_q =3D backend_ns->queue;
>  	ns->fdp.backend_ctrl =3D backend_ns->ctrl;
> +	ns->fdp.backend_nsid =3D backend_ns->head->ns_id;
> =20
> -	return 0;
> +	return nvmet_fdp_init_backend(ns);
>  }

[ ... ]

> +/*
> + * The backend submission path takes a linear kernel buffer, so the
> + * request data is staged through one.
> + */
> +static u16 nvmet_fdp_io_mgmt_forward(struct nvmet_req *req, bool recv)
> +{
> +	struct nvme_command c =3D {};
> +	u16 status =3D 0;
> +	void *buf;
> +	int ret;
> +
> +	buf =3D kzalloc(req->transfer_len, GFP_KERNEL);
> +	if (!buf)
> +		return NVME_SC_INTERNAL;
> +
> +	if (!recv) {
> +		status =3D nvmet_copy_from_sgl(req, 0, buf, req->transfer_len);
> +		if (status)
> +			goto free;
> +	}
> +
> +	c.common =3D req->cmd->common;
> +	c.common.nsid =3D cpu_to_le32(req->ns->fdp.backend_nsid);
> +	ret =3D nvme_submit_sync_cmd(req->ns->fdp.backend_q, &c, buf,
> +				   req->transfer_len);
> +	if (ret) {
> +		status =3D ret > 0 ? ret : NVME_SC_INTERNAL;
> +		goto free;
> +	}
> +
> +	if (recv)
> +		status =3D nvmet_copy_to_sgl(req, 0, buf, req->transfer_len);
> +free:
> +	kfree(buf);
> +	return status;
> +}
> +
> +void nvmet_execute_io_mgmt_recv(struct nvmet_req *req)
> +{
> +	u16 status;
> +
> +	status =3D nvmet_fdp_io_mgmt_check(req);
> +	if (status)
> +		goto out;
> +
> +	if (req->cmd->imr.mo !=3D NVME_IO_MGMT_RECV_MO_RUHS) {
> +		status =3D NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
> +		goto out;
> +	}
> +
> +	status =3D nvmet_fdp_io_mgmt_forward(req, true);
> +out:
> +	nvmet_req_complete(req, status);
> +}
> +
> +void nvmet_execute_io_mgmt_send(struct nvmet_req *req)
> +{
> +	u16 status;
> +
> +	status =3D nvmet_fdp_io_mgmt_check(req);
> +	if (status)
> +		goto out;
> +
> +	if (req->cmd->ims.mo !=3D NVME_IO_MGMT_SEND_MO_RUH_UPDATE) {
> +		status =3D NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
> +		goto out;
> +	}
> +
> +	status =3D nvmet_fdp_io_mgmt_forward(req, false);
> +out:
> +	nvmet_req_complete(req, status);
> +}

[Severity: Critical]
Should nvmet_execute_io_mgmt_recv() and nvmet_execute_io_mgmt_send()
validate req->transfer_len with nvmet_check_transfer_len() before calling
nvmet_fdp_io_mgmt_forward(), and construct the forwarded command explicitly
rather than copying req->cmd->common?

On Fabrics transports (nvmet-tcp, nvmet-rdma, nvmet-fc, nvme-loop),
req->transfer_len comes from the transport SGL descriptor or FCP data_len,
while nvmet_req_transfer_len() -> nvmet_io_cmd_transfer_len() is only used
by nvmet-pci-epf.

Without nvmet_check_transfer_len(), nvmet_fdp_io_mgmt_forward() allocates
buf with req->transfer_len bytes, copies the raw 64-byte SQE via
c.common =3D req->cmd->common (including dptr, metadata, imr.numd, and
ims.mos), and passes both to nvme_submit_sync_cmd():

1. If a Fabrics host sends req->transfer_len =3D=3D 0 with a non-zero imr.n=
umd
or ims.mos, kzalloc(0, GFP_KERNEL) returns ZERO_SIZE_PTR, which passes
if (!buf). In __nvme_submit_sync_cmd(), nvme_init_request() clears
NVME_CMD_SGL_ALL in c.common.flags (selecting PRP mode) and skips
blk_rq_map_kern() because bufflen =3D=3D 0. In nvme_prep_rq(),
blk_rq_nr_phys_segments(req) is 0, so nvme_map_data() is skipped and
iod->cmd.common.dptr.prp1/prp2 retain the raw host-supplied dptr bytes,
causing the backing PCIe NVMe controller to DMA directly to or from the
host-specified physical/IOVA address.

2. If a Fabrics host sends a non-zero req->transfer_len that is smaller
than the byte length encoded in c.imr.numd or c.ims.mos, kzalloc()
allocates the smaller slab buffer and blk_rq_map_kern() maps
req->transfer_len bytes. Because PRP1/PRP2 do not encode the buffer
length, the backing PCIe NVMe controller DMAs the full byte count from
c.imr.numd or c.ims.mos into or out of the smaller slab object,
overflowing the kernel heap buffer on Receive or reading out-of-bounds
kernel memory on Send.

[ ... ]

> +static int nvmet_fdp_init_backend(struct nvmet_ns *ns)
> +{
> +	struct nvme_fdp_ruh_status *st;
> +	struct nvme_id_ns *id;
> +	int ret, i;
> +
> +	id =3D kzalloc_obj(*id, GFP_KERNEL);
> +	if (!id)
> +		return -ENOMEM;
> +
> +	ret =3D nvmet_fdp_backend_identify(ns, id);
> +	if (ret) {
> +		pr_err("the ns:%u backing identify failed: %d\n",
> +		       ns->nsid, ret);
> +		goto free_id;
> +	}
> +
> +	ns->fdp.backend_endgid =3D le16_to_cpu(id->endgid);
> +
> +	st =3D kzalloc(struct_size(st, ruhsd, ns->fdp.nruh), GFP_KERNEL);
> +	if (!st) {
> +		ret =3D -ENOMEM;
> +		goto free_id;
> +	}
> +
> +	ret =3D nvmet_fdp_backend_ruhs(ns, st);
> +	if (ret) {
> +		pr_err("the ns:%u backing reclaim unit handle status failed: %d\n",
> +		       ns->nsid, ret);
> +		goto free_st;
> +	}

[Severity: Medium]
What happens if nvmet_fdp_backend_identify() or nvmet_fdp_backend_ruhs()
returns a positive NVMe status code from nvme_submit_sync_cmd(), or if
nvmet_fdp_init_backend() fails after nvmet_fdp_init_ns() has already set
ns->fdp.backend_q and ns->fdp.backend_ctrl?

nvme_submit_sync_cmd() returns a positive NVMe status code when the
backing controller completes the command with an error. Propagating that
positive value through nvmet_fdp_init_ns() -> nvmet_ns_enable() ->
nvmet_ns_enable_store() causes configfs to treat the positive return value
as the number of bytes written rather than a failure.

Also, when nvmet_fdp_init_ns() fails in nvmet_ns_enable():

	ret =3D nvmet_fdp_init_ns(ns);
	if (ret)
		goto out_pr_exit;

error recovery jumps to out_pr_exit (skipping nvmet_fdp_exit_ns()) and
closes the block device in nvmet_ns_dev_disable(ns), leaving dangling
pointers in ns->fdp.backend_q and ns->fdp.backend_ctrl.

> +
> +	if (le16_to_cpu(st->nruhsd) < ns->fdp.nruh) {
> +		pr_err("the ns:%u backing reports fewer handles than write streams\n",
> +		       ns->nsid);
> +		ret =3D -EINVAL;
> +		goto free_st;
> +	}
> +
> +	for (i =3D 0; i < ns->fdp.nruh; i++) {
> +		if (le16_to_cpu(st->ruhsd[i].pid) !=3D i) {
> +			pr_err("the ns:%u backing placement identifiers are not identity mapp=
ed\n",
> +			       ns->nsid);
> +			ret =3D -EINVAL;
> +			goto free_st;
> +		}
> +	}
> +
> +free_st:
> +	kfree(st);
> +free_id:
> +	kfree(id);
> +	return ret;
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019033624.4023=
37-1-kanie@linux.alibaba.com?part=3D8

