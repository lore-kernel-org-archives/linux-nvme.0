Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078C7606A31C
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 22:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qFSWuHbt;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O+ZKSbCa
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=dvdC5NbK1zZUcoQdKqLTRqEzeTyvf/+lchhkPbCAm4Y=; b=qFSWuHbt+lSqF+oSf2MEX7pITP
	rSQfupXStx/p79EC0rwKc33pdvOew0m1dVm2R0q8LgVhlqgFEzO5eOqxEyV9snNpx3C/aGmIKOYRu
	kyH72wDIKyo5942Y3ByUnfzzI+dLQoswzopmsAnB8RCuy1ritfX6+AN0X0IDakl+/WvWfz/68TtHd
	j1ME2kzgyIHEOwtn4yCqnV+d7JmaGKIKIP0VNYZRWwVo0JVIMlNsRG9gGSOZdbyKwxZ0/mQq82RZT
	vnyy0KDePn5xvuOVAzPD8cof0mXVCmVaOPNqa0IBchgZd1TUbHx5S6K+5Qy1Zv1h/Za+E3lxdw1J7
	D3KJU9aQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQXb8-00000001r7k-1rZu;
	Mon, 09 Nov 2026 22:12:18 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQXb6-00000001r7H-3OBw
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 22:12:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id F0F49611C9;
	Mon,  9 Nov 2026 22:12:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0501F0089F;
	Mon,  9 Nov 2026 22:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794262335;
	bh=dvdC5NbK1zZUcoQdKqLTRqEzeTyvf/+lchhkPbCAm4Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O+ZKSbCaYNfCif0XGqNFovtxYBlp2FWcxkwnvjhnPXwh0rPHEaiwxgvABI0qDKDDF
	 KzRNskFOcrPvmkVcOEWVf7kZWYM9YlrSzfPPBvyaAVdl4CgeVoqHXCrB4ZrqISAnZp
	 v0OQyF3mYITgko3GoKx/4RkGTUxbQ6aBG987ndU9U0WmD+p5I+MbvOAzhlllwjN4/n
	 bKMJJqOMVz+MhoFJ1Oun36h7Mgixw7Xkn8ckvUn+ob9nAddMKRdVF9GeRX6fsC0UL5
	 AnPSnsdI0WRrvqUnsRKsGHe8U+d7o0GMS0HohgJiAFbvsKPmIc1tvBAmML8jbi+c+M
	 HIY5XpJAAXJQw==
Message-ID: <sashiko-outbox-205705@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 20/23] nvmet: fix PCI P2P parameters access using
 nvmet_subsys::lock
To: "Nilay Shroff" <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261109033102.982191-45-nilay@linux.ibm.com>
References: <20261109033102.982191-25-nilay@linux.ibm.com>
 <20261109033102.982191-45-nilay@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 22:12:15 +0000
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

commit bf26a5b394d2fe3a4b6f9ef28cd2b4e1c3857ec6
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
Since nvmet_ns_p2pmem_store() updates ns->use_p2pmem and ns->p2p_dev and
calls pci_dev_put(ns->p2p_dev) under ns->subsys->lock, this fixes a real
unlocked access and concurrent show/store race in nvmet_ns_p2pmem_show().
Should this include:

  Fixes: c6925093d0b2 ("nvmet: Optionally use PCI P2P memory")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109033102.9821=
91-25-nilay@linux.ibm.com?part=3D20

