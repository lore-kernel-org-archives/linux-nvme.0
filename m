Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B70606A89C
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 03:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rFU+E9H1;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZeUg7N2o
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=60qLoJTHNWpBLf3JG+FihZ1dksT8r1ykR0M7gKBoRBI=; b=rFU+E9H18ASAY8hGoOWzoGOFFd
	Rg/tZEM3eATfZ4X2c8o2BFwJkynuadckFrxucDSnJ8902Uk45oa+tdgUN4MMnGBRvptrCm49pwUzW
	p4grWbx3gJ0Ouvq1j+JHE9TOr0UxBy72Vnr+tKe3rjwTvcOMqQ/rC3+S1jfEgL1TfXmvSTJiKBW+9
	Pce2CJn6duVD/5dxWR6jcMoVDBYWHJaf4YE9YbDwGwsTcIOpxL3NBPMBOejIrxxWnDq+dG2wCJ/KL
	N+89RL5jGzJ+DhvfPfB8r7ImIloO4ByUmfBkiEmMYFig/97MRu86BfZIg40fwI4J6MdjLpT1IpH4z
	lLidXpFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS4Jv-0000000FEac-0BSt;
	Sat, 14 Nov 2026 03:20:51 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS4Ju-0000000FEaR-0Fov
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 03:20:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 41A1761355;
	Sat, 14 Nov 2026 03:20:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C540E1F000C5;
	Sat, 14 Nov 2026 03:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794626449;
	bh=60qLoJTHNWpBLf3JG+FihZ1dksT8r1ykR0M7gKBoRBI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZeUg7N2o3lDxwZ1MnKXxGNLeabw/QndMtBYHIYOjMeFrGwDZNkWn8xDsagOkUCTme
	 SbzMVOAPdv9tlj8no6R1Perk0guxzxkRBfXSJ3vR6z6jAKgsfV9vfJBLyiRXuBfAHt
	 5si/zAt7LczaaG+w16ONeJ2yj0QZvLkqu1FcOIIHPpvUXA0H6Px7TfYjGxBPI0gRNY
	 imQ4kYlNYZa1LBQa0qtBSQLXHgCIoeGFejmUGwvkYqOIvh9YXweuWCmVn5zoRc1xyU
	 wBr0PU2ltYVl7rLt1YXUllaaG8is2CawOdj2mR9+GEGEhVCl6GlCS7f/pLfvCJM6Rc
	 mNmtSEfhLYk7Q==
Message-ID: <sashiko-outbox-214097@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 04/17] nvmet: Implement CCR logpage
To: "Mohamed Khalfella" <mkhalfella@purestorage.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261114030454.2836543-5-mkhalfella@purestorage.com>
References: <20261114030454.2836543-1-mkhalfella@purestorage.com>
 <20261114030454.2836543-5-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 03:20:48 +0000
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
- [High] nvmet: uninitialized SGL tail leak in
  nvmet_execute_get_log_page_ccr()
- [Medium] nvmet: premature CCR cleanup before SGL copy in
  nvmet_execute_get_log_page_ccr()
--

commit bd4c242dbfa9b91e0bb3eb6e57be8d11c6a19d19
Author: Mohamed Khalfella <mkhalfella@purestorage.com>

nvmet: Implement CCR logpage

This commit implements the Cross-Controller Reset (CCR) log page (LID 0x1e)
for the NVMe target and advertises it in the Supported Log Pages log.

> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-=
cmd.c
> index 3df9db454db9c..25c320752d2a7 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c

[ ... ]

> @@ -617,6 +618,46 @@ static void nvmet_execute_get_log_page_features(stru=
ct nvmet_req *req)
>  	nvmet_req_complete(req, status);
>  }
> =20
> +static void nvmet_execute_get_log_page_ccr(struct nvmet_req *req)
> +{
> +	struct nvmet_ctrl *ctrl =3D req->sq->ctrl;
> +	struct nvmet_ccr *ccr;
> +	struct nvme_ccr_log *log;
> +	int index =3D 0;
> +	u16 status;
> +
> +	log =3D kzalloc_obj(*log);
> +	if (!log) {
> +		status =3D NVME_SC_INTERNAL;
> +		goto out;
> +	}
> +
> +	mutex_lock(&ctrl->lock);
> +	list_for_each_entry(ccr, &ctrl->ccr_list, entry) {
> +		u8 flags =3D NVME_CCR_FLAGS_VALIDATED | NVME_CCR_FLAGS_INITIATED;
> +		u8 ccr_status =3D ccr->ctrl ? NVME_CCR_STATUS_IN_PROGRESS :
> +					NVME_CCR_STATUS_SUCCESS;
> +
> +		log->entries[index].icid =3D cpu_to_le16(ccr->icid);
> +		log->entries[index].ciu =3D ccr->ciu;
> +		log->entries[index].acid =3D cpu_to_le16(0xffff);
> +		log->entries[index].ccrs =3D ccr_status;
> +		log->entries[index].ccrf =3D flags;
> +		index++;
> +	}
> +
> +	/* Cleanup completed CCRs if requested */
> +	if (req->cmd->get_log_page.lsp & 0x1)
> +		nvmet_ctrl_cleanup_ccrs(ctrl, false);
> +	mutex_unlock(&ctrl->lock);

[Severity: Medium]
Can nvmet_ctrl_cleanup_ccrs() discard completed CCR entries when the log
page fails to copy to the host?

nvmet_execute_get_log_page() only checks that req->transfer_len matches the
command's NUMDL/NUMDU length.  If a host requests fewer than sizeof(*log)
bytes (for example, reading the 8-byte header) with LSP bit 0 set,
nvmet_ctrl_cleanup_ccrs() frees all completed entries from ctrl->ccr_list
before nvmet_copy_to_sgl() fails with NVME_SC_SGL_INVALID_DATA, so the host
permanently loses those completion records.

> +
> +	log->ne =3D cpu_to_le16(index);
> +	status =3D nvmet_copy_to_sgl(req, 0, log, sizeof(*log));

[Severity: High]
Does this leak uninitialized target kernel memory when the host requests
more than sizeof(*log) bytes?

Transports allocate req->sg for req->transfer_len bytes via sgl_alloc()
with GFP_KERNEL (without __GFP_ZERO).  Because nvmet_execute_get_log_page()
only checks that req->transfer_len matches NUMDL/NUMDU and
nvmet_execute_get_log_page_ccr() neither rejects req->transfer_len !=3D
sizeof(*log) (like nvmet_execute_get_log_page_rmi() and
nvmet_execute_get_log_page_smart()) nor zeroes trailing SGL bytes,
requesting more than 4096 bytes copies sizeof(*log) at offset 0 and returns
the remaining uninitialized scatterlist pages to the host.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114030454.2836=
543-1-mkhalfella@purestorage.com?part=3D4

