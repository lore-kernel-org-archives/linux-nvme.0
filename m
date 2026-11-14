Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992C6606A331
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 03:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ybswPTsy;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XR9uyMZC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=JhO0o9+qJXcDi9QA09oLwtN77FOs7uAuWc6VOLnTD9I=; b=ybswPTsyZgk9E8zSgRv1NQhYY2
	suZIoJws/P0jl2iQO0eQaXOC6E+Vraiyiic34i4mPn+kP1D66MwDJKR0pwppjhijYGofE9C9U+cSC
	FLU689QGsJ5C4bF8b7Snl7OiAwSjpUBcA0tochmeSqWB7x5ORnKyZePE6GI+4ZBO1u9mmSrmtNBUG
	lMIrimgRxW3EoJ9DJYlllRahJ0aqM9b5+pLPyga5bUG/PsRH8jmqsyf+qlpuWK3lRq28PZmhHPKjk
	nVHnVvTE0GuaYL3O7zPd1cmkGzeLJk+Bx4pTbAt74osNI7oU08MW3UY236hAIG6eybH7WIR57NVuw
	8idRN7MA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS4BQ-0000000FDLO-1fN2;
	Sat, 14 Nov 2026 03:12:04 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS4BP-0000000FDL6-1B6h
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 03:12:03 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6CA6761292;
	Sat, 14 Nov 2026 03:12:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A851F000C4;
	Sat, 14 Nov 2026 03:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794625922;
	bh=JhO0o9+qJXcDi9QA09oLwtN77FOs7uAuWc6VOLnTD9I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XR9uyMZChTqaiKhXPn1YNOfQmyeX15PSKcKaT7igB2f9NCowB6KgkMjNljAB4iPJU
	 uoG3bdJtCIppPXIjYTlPPx1EqDwOin/UbzddMU8BIXxnFqo+0qtxU4xudhaKWcwSsV
	 tp+gK/NIVZLAUnMW0nmI9fTLV/YJZZAEdy508qQtTeHI6eBzhgZwtsD3TDxJWY5ozD
	 23hfS3oGp4TpbL4VJJiz8RRyTEjtplCmaQnS/HhB7acdBs+zvr8qC66BKpV3Pff2VZ
	 Gj061bYIAhGd1c7ytY2XeIssskYbOlDi+V7WA4Nz3nhpOggyez7FLgdjKUa/VkCN1f
	 ZpdfT4pZb045Q==
Message-ID: <sashiko-outbox-214069@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/17] nvmet/debugfs: Export controller CIU and CIRN
 via debugfs
To: "Mohamed Khalfella" <mkhalfella@purestorage.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261114030454.2836543-3-mkhalfella@purestorage.com>
References: <20261114030454.2836543-1-mkhalfella@purestorage.com>
 <20261114030454.2836543-3-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 03:12:01 +0000
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
- [Low] nvmet: torn 64-bit read of ctrl->cirn in
  nvmet_ctrl_instance_cirn_show()
--

commit 70231338c7dc52cc534009767cd7997ab988025e
Author: Mohamed Khalfella <mkhalfella@purestorage.com>

nvmet/debugfs: Export controller CIU and CIRN via debugfs

This commit exports a target controller's CIU and CIRN fields as debugfs
attributes under the controller's debugfs directory.

> diff --git a/drivers/nvme/target/debugfs.c b/drivers/nvme/target/debugfs.c
> index e85fe1d4c9f8d..221fa81e124fe 100644
> --- a/drivers/nvme/target/debugfs.c
> +++ b/drivers/nvme/target/debugfs.c
> @@ -153,6 +153,24 @@ static int nvmet_ctrl_tls_concat_show(struct seq_fil=
e *m, void *p)
>  NVMET_DEBUGFS_ATTR(nvmet_ctrl_tls_concat);
>  #endif
> =20
> +static int nvmet_ctrl_instance_ciu_show(struct seq_file *m, void *p)
> +{
> +	struct nvmet_ctrl *ctrl =3D m->private;
> +
> +	seq_printf(m, "%02x\n", ctrl->ciu);
> +	return 0;
> +}
> +NVMET_DEBUGFS_ATTR(nvmet_ctrl_instance_ciu);
> +
> +static int nvmet_ctrl_instance_cirn_show(struct seq_file *m, void *p)
> +{
> +	struct nvmet_ctrl *ctrl =3D m->private;
> +
> +	seq_printf(m, "%016llx\n", ctrl->cirn);
> +	return 0;
> +}
> +NVMET_DEBUGFS_ATTR(nvmet_ctrl_instance_cirn);

[Severity: Low]
Can nvmet_ctrl_instance_cirn_show() observe a torn 64-bit read of
ctrl->cirn on 32-bit architectures?

nvmet_alloc_ctrl() calls nvmet_debugfs_ctrl_setup() before the host
enables the controller, and nvmet_update_cc() -> nvmet_start_ctrl() later
writes a new 64-bit value to ctrl->cirn under ctrl->lock whenever the
controller is enabled or re-enabled.  Reading ctrl->cirn without holding
ctrl->lock races with that update and can report a corrupted mix of the
old and new values to userspace.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114030454.2836=
543-1-mkhalfella@purestorage.com?part=3D2

