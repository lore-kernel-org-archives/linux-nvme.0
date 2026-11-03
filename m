Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305A7606A337
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 06:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Eoa+HDjK;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VZxKcb+d
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=acgp/TgnepLaOsiwNIpP2GJLsnVno5H7/oRw91HIB34=; b=Eoa+HDjKOVbxJXkeIPfySCKkHO
	SBC8xRDL5R34f24qiL7w6NtiLzKW62C/LD+lOi8ST6ZQzlr7iEzAWoKIp0wBPMdMdOywAoggTXbC4
	/Tp4oV3GyPpSeo56z7dNnNvxYCNZ5c9LMDm/qay/g1uJ2DH27vCfYj5SEEiz86kCE/Bk24F3T6ck7
	ZlHn1pGV3qVxU1g/NOV0lcVoNWroFWbdYW3Pd2XNLRyUbEz/o4Anf13wwI1OrQTzhB8ItGrFGJ8OZ
	wwzfe6OoKQ+LXmE6w4bPYfVrUsjzMo+iiW1qVIpQN41RbhkuBSPh+FJeKX3LJX4gRITSfbYLnFmXZ
	tmJrvF9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO8AR-00000001GOY-1xAk;
	Tue, 03 Nov 2026 06:38:47 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO8AQ-00000001GO2-1sJl
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 06:38:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DEBF341404;
	Tue,  3 Nov 2026 06:38:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A2981F000C1;
	Tue,  3 Nov 2026 06:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793687925;
	bh=acgp/TgnepLaOsiwNIpP2GJLsnVno5H7/oRw91HIB34=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VZxKcb+dJ8KiEGTt8NIjgyFe+05wK3qrClinOwKJXSJ0Pxcx6P0kgwVE33WvUYEKO
	 cmMf7iYD3XggPepMXyBKyghOUyZwcX4s9lLCMhRiah+A3yv3F+n+uQBdHJO7fBBhQq
	 uYH/tXc0+BpLGny2v2sgg+JfEWHrxALlLqNr+lFVEpDjVz99yxfu2LrYpnZCI3MadY
	 iYJiFBSYb9Pm7SEwETmxDvIXNPSPX8DWDTMjDSjRrUKv3JTzaDu0VTwP8EXZr81ySU
	 QI6f+0HG51qkxA1QWIEtifSob9D11fJyx6u3Z++mFwxufzGMy2LXLNNCAASHVf16i8
	 ENiVCAWxJvMiQ==
Message-ID: <sashiko-outbox-194649@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] nvme-pci: Fix performance regression with completion
 batching for Hygon processors
To: "Liao Xuan" <liaoxuan@open-hieco.net>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261103063249.3212198-1-liaoxuan@open-hieco.net>
References: <20261103063249.3212198-1-liaoxuan@open-hieco.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 06:38:45 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] nvme-pci: write to __ro_after_init use_comp_batch in nvme_probe()
--

commit f5d6be55aa6c877692b8138ca3509c22f309ca86
Author: Liao Xuan <liaoxuan@open-hieco.net>

nvme-pci: Fix performance regression with completion batching for Hygon pro=
cessors

This commit introduces a use_comp_batch flag in drivers/nvme/host/pci.c to
disable IRQ completion batching in nvme_irq() when running on Hygon x86
processors.

> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 019a1e3cc0a2d..635755a886523 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -278,6 +278,15 @@ static bool noacpi;
>  module_param(noacpi, bool, 0444);
>  MODULE_PARM_DESC(noacpi, "disable acpi bios quirks");
> =20
> +static bool use_comp_batch __ro_after_init =3D true;
> +static void nvme_setup_comp_batch(void)
> +{
> +#ifdef CONFIG_X86
> +	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_HYGON)
> +		use_comp_batch =3D false;
> +#endif
> +}
> +
>  struct nvme_dev;
>  struct nvme_queue;
> =20

[ ... ]

> @@ -4014,6 +4026,8 @@ static int nvme_probe(struct pci_dev *pdev, const s=
truct pci_device_id *id)
> =20
>  	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
> =20
> +	nvme_setup_comp_batch();

[Severity: High]
Can calling nvme_setup_comp_batch() from nvme_probe() cause a page fault by
writing to read-only memory?

In drivers/nvme/host/pci.c, use_comp_batch is annotated with __ro_after_ini=
t,
which places it in the .data..ro_after_init section that becomes read-only
after kernel or module init finishes.

However, nvme_probe() can be invoked after init has completed, such as duri=
ng
PCIe hotplug, SR-IOV VF creation, PCI bus rescan, sysfs driver bind, or
asynchronous probing (since nvme_driver sets PROBE_PREFER_ASYNCHRONOUS). Wh=
en
that happens on a Hygon CPU, nvme_probe() -> nvme_setup_comp_batch() writes
to use_comp_batch after .data..ro_after_init has been marked read-only. In
addition, concurrent nvme_probe() calls can write to use_comp_batch while
already active controllers read it in nvme_irq().

Since boot_cpu_data.x86_vendor is a system-wide property, should
nvme_setup_comp_batch() be marked __init and called once from nvme_init()
before pci_register_driver(&nvme_driver) instead of inside nvme_probe()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103063249.3212=
198-1-liaoxuan@open-hieco.net?part=3D1

