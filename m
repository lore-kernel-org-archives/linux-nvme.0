Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F6E606A338
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 20:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=MX+IfInR;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MioSDFDD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=UqZGICjbPKpeigSQ643DTY8AHzN2Hzb/tfF09ufw/Ig=; b=MX+IfInRNevSfB0pXek5kj95Th
	KfDD23nBTLNFMUNy0HgxrsugE2woYHxvX+hzaAzfrkixeNVBcqxDcCG9Q19kZeb9WW3eTCLz77ygq
	GI2qZPUrwZ6bpUEsg20meGRuttv/wWZUeZwshaZ+taurLG4J866Pc6fRCDYpFJG9xiLusWxMXtHLL
	W600MYWHWFra5hjhPNzStTul7/mIkTkxGc+UFNLuQtBThUujFMHCjEmROTLV3uSIiPMY0pyGGoj5Z
	d8C1sKu70Q8lKvVSQIxVJrcILjQ1g6jyHlx/LhljUVMzg8J1RMfrrlVgl0xtPMebOADw+5dVjvu/H
	ug6vL62A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPQvv-0000000DcdT-0Jrd;
	Fri, 06 Nov 2026 20:53:11 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPQvu-0000000DcdM-0jAZ
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 20:53:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8E1FF4015D;
	Fri,  6 Nov 2026 20:53:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C651F0089F;
	Fri,  6 Nov 2026 20:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793998389;
	bh=UqZGICjbPKpeigSQ643DTY8AHzN2Hzb/tfF09ufw/Ig=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=MioSDFDDTpsBojBwRiJdF+2Qdun27Q2pmc7mAF7CrD4Gge5apAeVzSLy/CJwm/+Nn
	 rzDX303z42Ys2XY9XFzBJfMTqLGNxyNO5Y4dzZry+T0ByPdA7Er60Hy1zTyA6PK7j/
	 kN3382uQGW673lq0vA+RH88E5IYfY0QM4ewZc2YfOdfKFukGXoVy9ae67mrz5S0QX8
	 RnW0CxnxnkKdBW6AFuK58sIqxF1ssNuAIIHKfTC/kOfpSkOZet+i7JunQ+jzfDow5n
	 MJHG9tk5tGqFtp8ykLO3e5LOf/Qb3mYOtZXyMKIHaTdZmSbAinGbQHI7HNGgPlRnco
	 pHlkmFE53wzng==
From: Thomas Gleixner <tglx@kernel.org>
To: Keith Busch <kbusch@meta.com>, bhelgaas@google.com
Cc: maz@kernel.org, lrizzo@google.com, hch@lst.de,
 changfengnan@bytedance.com, namjain@linux.microsoft.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v3 2/2] PCI/MSI: Implement irq_mask_noflush() for MSI-X
In-Reply-To: <20261106173448.34794-3-kbusch@meta.com>
References: <20261106173448.34794-1-kbusch@meta.com>
 <20261106173448.34794-3-kbusch@meta.com>
Date: Fri, 06 Nov 2026 21:53:06 +0100
Message-ID: <87wlqpwukt.ffs@fw13>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06 2026 at 09:34, Keith Busch wrote:
> -static inline void pci_msix_mask(struct msi_desc *desc)
> +/* Posted write only: the device may still send an interrupt after return */
> +static inline void pci_msix_mask_noflush(struct msi_desc *desc)
>  {
>  	desc->pci.msix_ctrl |= PCI_MSIX_ENTRY_CTRL_MASKBIT;
> +	pci_msix_write_vector_ctrl(desc, desc->pci.msix_ctrl);
> +}
> +
> +static inline void pci_msix_mask(struct msi_desc *desc)
> +{
> +	pci_msix_mask_noflush(desc);

That's before the offline check now, which looks more than wrong.

>  	if (pci_channel_offline(msi_desc_to_pci_dev(desc)))
>  		return;
>  
> -	pci_msix_write_vector_ctrl(desc, desc->pci.msix_ctrl);
>  	/* Flush write to device */
>  	readl(desc->pci.mask_base);
>  }

