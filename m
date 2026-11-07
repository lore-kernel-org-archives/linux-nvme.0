Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C578606A32E
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Nov 2026 21:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WMm1x/E7;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hSw5Xwu5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=EWlYFnlFkKqc+rHHPIN+VOy/+q1zUN/a2wsNKFALdxk=; b=WMm1x/E7M703bLvkQP/lC0Ldzx
	x88s/L1bPOuXO4GAWOdvbSH1AtP9r7qD43syB0UN4ItkYxyTBUoxGf9m+DGDeDZsA+cTp5opFAOa0
	ufeZxR0z9wKGBi03VQN60HKSFZA/OpS1KTmT2cftO0DjU5Mb0Vg+DfcGo+ftZIOvYEeW/KtuNzBVL
	KaDEr7r9vet56RL2m2PBcUkq6ZxppC35ZXlo+q91simD1lawIsIMqUIrZed6dQDRNzvUek5DiTvLZ
	2RaOgEbJ4d3AwjkQu1WKECIQ2YoFV1TX6FLGkftmiTH9L8WOAKobRECq6X1kSp5plSktikJ4fKep1
	hxUOcALA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPoMD-0000000FRYi-0nqC;
	Sat, 07 Nov 2026 21:53:53 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPoMB-0000000FRYc-3neL
	for linux-nvme@lists.infradead.org;
	Sat, 07 Nov 2026 21:53:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1726D61202;
	Sat,  7 Nov 2026 21:53:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044241F0089F;
	Sat,  7 Nov 2026 21:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794088430;
	bh=EWlYFnlFkKqc+rHHPIN+VOy/+q1zUN/a2wsNKFALdxk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=hSw5Xwu59lAOUUswo1gzzESTvlg/XUg4O/ufTVW63SK9b0/IbYVkoohTPCOM8Y4sD
	 rmINjpCIFox5xazFAzn0qv3Nsk33ab3ItOc8mOSt90HM188VDGtBq9oEuKT5iglTKY
	 o9p3KE+cC1o48cnW9LcQ1007YCOHr2CAWJlRB3J2i3qvP2YkDVyFYKbJKGG3i39e+P
	 pwD31J9NW/pA/jOZhlGSZBegOeFHXJeJ88qXfzZc7bEfnJndayxMmXD/YiDIv9PTbT
	 JjnlcJ0mcH0E+O1asgjhPgzso+AE7BvLjadhaoAoncKenDEinIfsCp91WRkhYarIOw
	 7aZsF/87/nt6w==
From: Thomas Gleixner <tglx@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, bhelgaas@google.com, maz@kernel.org,
 lrizzo@google.com, hch@lst.de, changfengnan@bytedance.com,
 namjain@linux.microsoft.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/2] PCI/MSI: Implement irq_mask_noflush() for MSI-X
In-Reply-To: <au-DcqwAz2wmmOne@kbusch-mbp>
References: <20261106173448.34794-1-kbusch@meta.com>
 <20261106173448.34794-3-kbusch@meta.com> <87wlqpwukt.ffs@fw13>
 <au-DcqwAz2wmmOne@kbusch-mbp>
Date: Sat, 07 Nov 2026 22:53:47 +0100
Message-ID: <87o6c0wbo4.ffs@fw13>
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

On Sat, Nov 07 2026 at 13:00, Keith Busch wrote:
> On Fri, Nov 06, 2026 at 09:53:06PM +0100, Thomas Gleixner wrote:
>> On Fri, Nov 06 2026 at 09:34, Keith Busch wrote:
>> > -static inline void pci_msix_mask(struct msi_desc *desc)
>> > +/* Posted write only: the device may still send an interrupt after return */
>> > +static inline void pci_msix_mask_noflush(struct msi_desc *desc)
>> >  {
>> >  	desc->pci.msix_ctrl |= PCI_MSIX_ENTRY_CTRL_MASKBIT;
>> > +	pci_msix_write_vector_ctrl(desc, desc->pci.msix_ctrl);
>> > +}
>> > +
>> > +static inline void pci_msix_mask(struct msi_desc *desc)
>> > +{
>> > +	pci_msix_mask_noflush(desc);
>> 
>> That's before the offline check now, which looks more than wrong.
>
> This is done on purpose: pci_msix_write_vector_ctrl() already has the
> same offline check, so nothing actually gets written, same as before.
>
> And regardless of whether it's offline or not, we have to set the
> PCI_MSIX_ENTRY_CTRL_MASKBIT in the cached msxi_ctrl. That's common to
> both paths, so it lives in the noflush helper to avoid duplicating it.

Indeed, but that's an unreadable mess TBH.

Can we please change that to have two functions here?

    pci_msix_write_vector_ctrl()
plus    
    pci_msix_write_vector_ctrl_and_flush()

and fixup the related call sites?

Thanks,

        tglx

