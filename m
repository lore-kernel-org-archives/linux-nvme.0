Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B31B606A326
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2026 18:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JSSlxgHn;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O/aenWhw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=RBeUlU2wu0DRVykgRa5Pzlfj6dY/EBIODYPVUfaFIUc=; b=JSSlxgHnuSotLF88+f4ddRukrK
	V829uJ0FrgtERFrSJe0ToxYgQ/T2MKD0ljm6fiQlOUUjAS9qaSbgW5GYSeK/IPrVI0hrk+jPxHyQ0
	iJxkcXH70Wn7/uQR0f/xQS/0v+AdysiXnQun9QTMIZ2Va1l0Dewd3mafyqQQZWfxrnU9yDOPGpYUE
	yMzMjhtvzu83KQcn34wkjMdoSWRKUIgHJlJ99DuJu92f3m62J89j/rYWUp2G1w8IuqIXZoWpA3U84
	y3zFK8mDe32GAKWyaYyv/Zz1Hj3AJHEKv9l2KCGUHXVKKZOAHg9jNiuJH22JFdNVcnjSo6tVbl88m
	A81aB8OA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP2Kk-0000000A9k2-2YKh;
	Thu, 05 Nov 2026 18:37:10 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP2KT-0000000A9iE-3GtF
	for linux-nvme@lists.infradead.org;
	Thu, 05 Nov 2026 18:36:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id F0F7760145;
	Thu,  5 Nov 2026 18:36:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931411F000C1;
	Thu,  5 Nov 2026 18:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793903812;
	bh=RBeUlU2wu0DRVykgRa5Pzlfj6dY/EBIODYPVUfaFIUc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O/aenWhwcsoPtn/O2wKfjtgRqFRIwJKkFtOvLn4zFhQ5L42JZ+HfO62KW3edpz3nr
	 4JHHFgTEZE596LMExnBO2hf538P3xNBhWzd/23SGngpvGWTvtCjSU8axnkttypNEpN
	 QXT98tbgYCq3w5Y07up5NlpkoS7Zg7jq4CWaj+AWeNtHsOmWNRj0ZmqoZZi4TzLpoI
	 jZJjkCtSJGajqwdFsWKbMDAwN+BJnsIovF/obgs4fYSf+o/F0gpPXPe1apLLq+KhMI
	 FQqLX0WYRYgg4Lva/SkopANkLMQa53626ETaN3k+0QjCqhkVL7yZ85wMcinUaYxpWq
	 qM/vXQLN6mc3A==
Message-ID: <sashiko-outbox-199778@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] PCI/MSI: Implement irq_mask_noflush() for MSI-x
To: "Keith Busch" <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org
In-Reply-To: <20261105182706.3700908-3-kbusch@meta.com>
References: <20261105182706.3700908-1-kbusch@meta.com>
 <20261105182706.3700908-3-kbusch@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 18:36:52 +0000
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
- [High] PCI/MSI: pci_msix_mask() reads MMIO when pci_channel_offline() is =
true
--

commit b206f920f881524539101689cd7270ceba32c679
Author: Keith Busch <kbusch@kernel.org>

PCI/MSI: Implement irq_mask_noflush() for MSI-x

This commit implements the irq_mask_noflush() callback for PCI MSI-X by
splitting pci_msix_mask_noflush() out of pci_msix_mask() to skip the MMIO
read-back that flushes the mask write. Parent domains that mask on behalf of
PCI/MSI clear irq_mask_noflush so they continue using their own irq_mask().

> diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
> index f987cf897264e..db4dc37888f73 100644
> --- a/drivers/pci/msi/msi.h
> +++ b/drivers/pci/msi/msi.h
> @@ -44,7 +44,8 @@ static inline void pci_msix_write_vector_ctrl(struct ms=
i_desc *desc, u32 ctrl)
>  		writel(ctrl, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
>  }
> =20
> -static inline void pci_msix_mask(struct msi_desc *desc)
> +/* Posted write only: the device may still send an interrupt after retur=
n */
> +static inline void pci_msix_mask_noflush(struct msi_desc *desc)
>  {
>  	desc->pci.msix_ctrl |=3D PCI_MSIX_ENTRY_CTRL_MASKBIT;
> =20
> @@ -52,6 +53,11 @@ static inline void pci_msix_mask(struct msi_desc *desc)
>  		return;
> =20
>  	pci_msix_write_vector_ctrl(desc, desc->pci.msix_ctrl);
> +}
> +
> +static inline void pci_msix_mask(struct msi_desc *desc)
> +{
> +	pci_msix_mask_noflush(desc);
>  	/* Flush write to device */
>  	readl(desc->pci.mask_base);
>  }

[Severity: High]
When pci_channel_offline(msi_desc_to_pci_dev(desc)) is true, doesn't
pci_msix_mask() now unconditionally execute readl(desc->pci.mask_base) after
pci_msix_mask_noflush() returns early?

Prior to this change, commit 2e2f69fc8ae2 ("PCI/MSI: Skip MSI/MSI-X
programming while the channel is offline") added the pci_channel_offline()
check to both pci_msix_write_vector_ctrl() and pci_msix_mask() so that
pci_msix_mask() would return before the flushing readl(desc->pci.mask_base):

drivers/pci/msi/msi.h:pci_msix_write_vector_ctrl() {
	/* The Table is unreachable while the Link is down */
	if (pci_channel_offline(msi_desc_to_pci_dev(desc)))
		return;
	...
}

With the early return moved into pci_msix_mask_noflush(), masking or tearing
down MSI-X vectors during PCIe error recovery, Downstream Port Containment,
or surprise removal (for example via pci_free_irq_vectors() ->
pci_msi_teardown_msi_irqs() -> pci_irq_shutdown_msix() -> pci_msix_mask() or
mask_irq() -> pci_irq_mask_msix() -> pci_msix_mask()) will still issue the
MMIO flush read to the unreachable MSI-X table BAR, which can trigger a
secondary Root Port containment event.

Should the pci_channel_offline() check remain in pci_msix_mask() before
readl(desc->pci.mask_base) instead of in pci_msix_mask_noflush() (since
pci_msix_write_vector_ctrl() already checks pci_channel_offline())?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105182706.3700=
908-1-kbusch@meta.com?part=3D2

