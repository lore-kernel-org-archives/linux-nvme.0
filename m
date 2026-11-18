Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D6C606A332
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 07:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Qu+SUMtA;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gWmWXWZS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=sMUqCAIfzISXac857+yMQ+M5NJarmES+RUsbl//tTZM=; b=Qu+SUMtAyq+Sr5KeYVVNikQc4K
	knXP4ibERrXyHbNZpUdKaGOTB2uJ2A3HYUKSI90hyeu65Yzs6nxDONErvkhfeUHCN5lv2r+EaKI88
	doW+C7FP5KDpO53DkyJjUrNkrwgecQCRk0I7foPFC/HZ5w9qjrT7llJDaMluh5Ycr1j7G12U9vl61
	PF7sF0Ag5rxFsxOJ4pYtINQAJbNb+uJBpY71P0kk3xH5vvd+JPncxS82mAobvdde84mV97rRVMDjS
	eiKup6PdBonTe7PpFIiRCuAqxPvbjm78CvOG54wQoNf2pIuIrPmwUkToeDbvHdF0ywO691U6XSixV
	g1NPHprQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaWP-000000084gh-3kdV;
	Wed, 18 Nov 2026 07:56:01 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaWP-000000084gS-1Y3f
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 07:56:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 20E20613A9;
	Wed, 18 Nov 2026 07:55:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09801F000C5;
	Wed, 18 Nov 2026 07:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794988558;
	bh=sMUqCAIfzISXac857+yMQ+M5NJarmES+RUsbl//tTZM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gWmWXWZSt2qNJQ1h5NQ85f7nX7UVU+UIyCGUBWijAox/E3IcoD6r/4ZBEjHESSHM8
	 oZ/VXZFwWRIi/cDDG8ltunBaGOUKzXsV+z/ILosoH9ofhwn9XW1frGTGRepNA53b0+
	 Kbztru6B6y1QOcUZWVPk06/EDRvg+vLxfBQeK4VxMQzjnebmFa3vEqs2yYk8gQs2R9
	 s95ZrG2BSk26Qu/a/+3n6woveBsFsLWNrv3V/EPPrcilWLDmsv/mB57r+Im3mHPXF6
	 MtZFSmQxzF6qSxFe9n4bA44Q2dsMoKLYEgTeC9xpP/Y4ZwiVL6lbJkUXiiOLb84Nyw
	 UJVrBrV9DWP7A==
Message-ID: <sashiko-outbox-220380@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 18/22] nvmet: fix PCI P2P parameters access using
 nvmet_subsys::lock
To: "Nilay Shroff" <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261118073505.288910-19-nilay@linux.ibm.com>
References: <20261118073505.288910-1-nilay@linux.ibm.com>
 <20261118073505.288910-19-nilay@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 07:55:58 +0000
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] nvmet: missing Fixes trailer for nvmet_ns_p2pmem_show() lock fix
--

commit 0c0ad9daba7f9b5b285f1b0f44cf7bc001282d91
Author: Nilay Shroff <nilay@linux.ibm.com>

> nvmet: fix PCI P2P parameters access using nvmet_subsys::lock
>
> The nvmet_ns::p2p_dev and nvmet_ns::use_p2pmem fields are protected by
> nvmet_subsys::lock. However, nvmet_ns_p2pmem_show() accesses these
> fields without holding the corresponding lock, triggering Clang context
> analyzer errors:
>
> drivers/nvme/target/configfs.c:587:42: error: reading variable 'p2p_dev' =
requires holding mutex 'to_nvmet_ns(item).subsys->lock'
>       [-Werror,-Wthread-safety-analysis]
>   587 |         return pci_p2pdma_enable_show(page, ns->p2p_dev, ns->use_=
p2pmem);
>       |                                                 ^
> drivers/nvme/target/configfs.c:587:55: error: reading variable 'use_p2pme=
m' requires holding mutex 'to_nvmet_ns(item).subsys->lock'
>       [-Werror,-Wthread-safety-analysis]
>   587 |         return pci_p2pdma_enable_show(page, ns->p2p_dev, ns->use_=
p2pmem);
>       |                                                              ^
>
> Fix the above errors by acquiring ns->subsys->lock before accessing
> PCI P2P parameters in nvmet_ns_p2pmem_show().
>
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

[Severity: Low]
Since nvmet_ns_p2pmem_store() updates ns->p2p_dev and drops the old PCI
device reference via pci_dev_put() under ns->subsys->lock, reading
ns->p2p_dev in nvmet_ns_p2pmem_show() without holding ns->subsys->lock is
a concurrency bug introduced with P2P memory support. Should this include:

  Fixes: c6925093d0b2 ("nvmet: Optionally use PCI P2P memory")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118073505.2889=
10-1-nilay@linux.ibm.com?part=3D18

