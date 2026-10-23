Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED29606A31A
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2026 08:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JOMcBpfm;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jiDcga9Y
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=5E67gknyLqRVnkhcUABQx2uGDeh0q3fDX2V6waYhVxw=; b=JOMcBpfmEDZ/zTwXou5oG0PWen
	RmJ43JVA8+/e2eUfO+ltXHXLixsCpHNkMMMQc5ImO+JFKNZg4YFTsSQQo2+krrXX8T3mlUXyHtDgf
	M9QillazzTdEwn3fw1wiAHMa2Fd01hbS5hUmu3nUorJJvrUn2ApGnL0jWKQhDnVfJTVf+XLatpxyL
	9OEC9xXRJrVZCpXxJFBGeGWkAUhT07anvRKZDxUgUD5U7anPm/Sc1oSiNY7FOq/yR2lguMLmUAaT7
	7GYQsMC9chMDLOXNFWXYms33Afj98bmxyJGqTutThttL8Af4YwstMTjNdjPQQ6uBQG1kRyNYlBapN
	83+YbaRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKAQ6-0000000FuBp-1hT4;
	Fri, 23 Oct 2026 08:14:34 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKAQ5-0000000FuBh-37S3
	for linux-nvme@lists.infradead.org;
	Fri, 23 Oct 2026 08:14:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7EFD24142F;
	Fri, 23 Oct 2026 08:14:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B671F01825;
	Fri, 23 Oct 2026 08:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792743273;
	bh=5E67gknyLqRVnkhcUABQx2uGDeh0q3fDX2V6waYhVxw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jiDcga9YnF6MkxqUh1MbNlV+mJbV4vPIG4SzjkQqLK7gJHz/zrzhL2QDR5COU2jHt
	 lOx4SGn5YMwJfouFkW+gBVPNy3jnylhM6auajGn2vmscAkARL5xfWRo/UtmRymF1th
	 3+PRqGTrxS8WANwD1Y8DQ3R2YkdtCW9xXx4G9wWoMNTjDZ9eUXu0CH5vqSS28bgQl0
	 jICKZITAcYqMq5UiSBgJNlD8WKOqdS4lhSpFgnnxXxL1cZYs3ZGhvclysmo+0Y1HF4
	 TS+4czDABzmP5hYCINh5qml3CnuhRZYIx0abCFZgPxF0YFYazNaQwrHd12/AsYXlcX
	 yvqQLaza7927A==
Message-ID: <sashiko-outbox-182494@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/11] nvme: export nvme_bdev_ops
To: "Guixin Liu" <kanie@linux.alibaba.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261023080251.2606443-4-kanie@linux.alibaba.com>
References: <20261023080251.2606443-1-kanie@linux.alibaba.com>
 <20261023080251.2606443-4-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 08:14:32 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] nvme: exporting only nvme_bdev_ops misses multipathed NVMe names=
paces
--

commit 764e628e097c80c3a597aca0fdc4893155c2715b
Author: Guixin Liu <kanie@linux.alibaba.com>

nvme: export nvme_bdev_ops

This commit exports nvme_bdev_ops so that external subsystems such as the
NVMe target FDP bridge can identify an NVMe namespace block device by its
block_device_operations pointer and access its underlying NVMe structures.

> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 7eb0f9fe6b18d..0099ce5730b20 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2719,6 +2719,7 @@ const struct block_device_operations nvme_bdev_ops =
=3D {
>  	.report_zones	=3D nvme_report_zones,
>  	.pr_ops		=3D &nvme_pr_ops,
>  };
> +EXPORT_SYMBOL_GPL(nvme_bdev_ops);

[Severity: Medium]
Does exporting only nvme_bdev_ops work when NVMe multipathing is active for
the backing namespace?

When multipathing is enabled for a namespace, nvme_mpath_alloc_disk() in
drivers/nvme/host/multipath.c sets up the user-visible /dev/nvmeXnY gendisk
with nvme_ns_head_ops and stores struct nvme_ns_head * in private_data:

	head->disk->fops =3D &nvme_ns_head_ops;
	head->disk->private_data =3D head;

Meanwhile, nvme_alloc_ns() in drivers/nvme/host/core.c marks the
per-controller disk (which uses nvme_bdev_ops and stores struct nvme_ns * in
disk->private_data) as hidden so it cannot be opened as a backing block
device:

	if (nvme_ns_head_multipath(ns->head)) {
		sprintf(disk->disk_name, "nvme%dc%dn%d", ctrl->subsys->instance,
			ctrl->instance, ns->head->instance);
		disk->flags |=3D GENHD_FL_HIDDEN;
	}

When the NVMe target FDP bridge in nvmet_fdp_init_ns() checks
bdev->bd_disk->fops !=3D &nvme_bdev_ops on an opened /dev/nvmeXnY device,
won't it reject valid multipathed NVMe namespaces with -EINVAL because
bdev->bd_disk->fops is &nvme_ns_head_ops?

Instead of exporting nvme_bdev_ops and having callers inspect
bdev->bd_disk->fops and bdev->bd_disk->private_data directly, would it make
sense to provide a helper in drivers/nvme/host/core.c (similar to
nvme_ctrl_from_file()) that handles both nvme_bdev_ops and nvme_ns_head_ops?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023080251.2606=
443-1-kanie@linux.alibaba.com?part=3D3

