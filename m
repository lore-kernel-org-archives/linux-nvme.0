Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4133E606A326
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Nov 2026 20:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TAdifvFT;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZMTYZM/W
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=D+WPfo+qbidntoQuZIdORED59/5TVu8lZ6NuximfsFo=; b=TAdifvFTeKUzvPj390bYsMbA2f
	MS9fycI5ndhE/C6ZDZeoadXBmKSPftymviI8A6gwaxwz+NZPBsMpRmUQzFEJkK8PV59mu32fPN3Zq
	co/6E+Oe0qkpVuUFfTlMdgHPMlgkHrC1h+qzRgA7kVVtJp2zxu8u0CQ7I8ndSAxMesgxmOQN+9y7C
	OtCCqdIvOcsmYLZ5w/V9d0OoYJ6orzxM00a2TPFhDUVueBgGdF8j5k5UeqQ4s561TtGGdjFpiXlHA
	VO4dmYiy0AhwSjcEQGFdyY34wLq4Ua5+YwsOwNAmwok5Y5ANhzELGrDi+95dNTqLORhVC4GabaoPK
	F9OsMtCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPmb2-0000000FFy6-1rZR;
	Sat, 07 Nov 2026 20:01:04 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPmar-0000000FFxA-3zdj
	for linux-nvme@lists.infradead.org;
	Sat, 07 Nov 2026 20:00:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BCC0261168;
	Sat,  7 Nov 2026 20:00:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093661F0089F;
	Sat,  7 Nov 2026 20:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794081652;
	bh=D+WPfo+qbidntoQuZIdORED59/5TVu8lZ6NuximfsFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZMTYZM/WiGXKAkuSlDGYEyhe7HivsVF65PfVuSKDaaymBqvobsjmMnxldaRkPAhCD
	 Y615a72iYrZPyIfl+0p6l2U5sGf48S5L0BvK9Av1FYnidsxDHkcf2mbwKMoC/7iTwh
	 yJupr+o4/6IlXdQllbSDW77abxnB6tk2Z5HjpxldS1pvHdl4yIx3889uj0ZWgom801
	 C1DVS/NHDVNBkNymqt3X57oyAJjX9viUQdWnqcHncB+kJy3rZI+bW/aviM//BtJRmH
	 XDT+nwCixxHeyVZjd5Ouw855cEyrr4DeDvBVb4Ph854WnN86THjn2SEqoPocKw4QSl
	 iha0oIDDftSLg==
Date: Sat, 7 Nov 2026 13:00:50 -0700
From: Keith Busch <kbusch@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, bhelgaas@google.com, maz@kernel.org,
	lrizzo@google.com, hch@lst.de, changfengnan@bytedance.com,
	namjain@linux.microsoft.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/2] PCI/MSI: Implement irq_mask_noflush() for MSI-X
Message-ID: <au-DcqwAz2wmmOne@kbusch-mbp>
References: <20261106173448.34794-1-kbusch@meta.com>
 <20261106173448.34794-3-kbusch@meta.com>
 <87wlqpwukt.ffs@fw13>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wlqpwukt.ffs@fw13>
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

On Fri, Nov 06, 2026 at 09:53:06PM +0100, Thomas Gleixner wrote:
> On Fri, Nov 06 2026 at 09:34, Keith Busch wrote:
> > -static inline void pci_msix_mask(struct msi_desc *desc)
> > +/* Posted write only: the device may still send an interrupt after return */
> > +static inline void pci_msix_mask_noflush(struct msi_desc *desc)
> >  {
> >  	desc->pci.msix_ctrl |= PCI_MSIX_ENTRY_CTRL_MASKBIT;
> > +	pci_msix_write_vector_ctrl(desc, desc->pci.msix_ctrl);
> > +}
> > +
> > +static inline void pci_msix_mask(struct msi_desc *desc)
> > +{
> > +	pci_msix_mask_noflush(desc);
> 
> That's before the offline check now, which looks more than wrong.

This is done on purpose: pci_msix_write_vector_ctrl() already has the
same offline check, so nothing actually gets written, same as before.

And regardless of whether it's offline or not, we have to set the
PCI_MSIX_ENTRY_CTRL_MASKBIT in the cached msxi_ctrl. That's common to
both paths, so it lives in the noflush helper to avoid duplicating it.

