Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 105F2C25B10
	for <linux-nvme@archiver.kernel.org>; Fri, 10 May 2024 16:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AXhE8Z4r56FLxSoR0TnD4DsXP0A+Ch4RHuNCYA34EcU=; b=aYPOy3aqmC5mcfMdBiqcovr8Xo
	pYZwLA8/OKGTLfHOGemsfTqpIDlyYt7rG3ZfLSEFxkHjDdp1T03NifxL2lFOqnye+tRsZVYIucEj5
	OVw5y0krwb9LwlAGXsjYp1DpoCxf2ld4Ebhg/x1//SfobRla8xOOuwlMMxbPWsUj7NOgbT/zcExSg
	/eKhbthIgbjgAK34GHdXJEBHzVi04j2CRAmg3YjyTasQ/GEtFtTQi5iUcIYO/rIiwg2VLuHH21/zI
	DM83Cj2HyAHYXjwgFGDWiW2sqdHIGWRXGi1FNpXUdetsU3D641TAnVX5kegfOSQLmwb3x9QzsOfpM
	8pt50svA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5TPZ-00000005vbq-2HO8;
	Fri, 10 May 2024 16:47:57 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5TPW-00000005vb2-2bdT
	for linux-nvme@lists.infradead.org;
	Fri, 10 May 2024 16:47:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C46CB61F15;
	Fri, 10 May 2024 16:47:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296F3C113CC;
	Fri, 10 May 2024 16:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715359673;
	bh=AXvy8iePiTOupLl+xIgUoqVuOZkGTeicUhCyXcPDZvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WY/crXVN7AYFzKzJa0xILepwhVwlZt+UG7mUNyhm1z69vKhAukhsbMzIhESPUEGCi
	 EynVeviFFA+ua3hcDOIxZcnBjObuhmdgWuYUX8lPHchn8UnTYTWV96DPSZT1jZhJuB
	 /PcB00x+G6GEUs6uBkt/wXayQ/qBg93ZCY/lH88yhCzSHH+x56WwygcSzoobhXsxgR
	 iNBhIdozZpH1K4/tNEjbSj5AfzWYXYhlSzVwxTlsq6pEgOC7fVgW3eq0ApPmbii/df
	 SwrW+TpR2ErPEVNLft+9c/+ag3fAxJS+QbYz+LHDQu378sPb8rooTdb+ABZfJBx3us
	 XYIINZ3CB+h0A==
Date: Fri, 10 May 2024 10:47:50 -0600
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, hch@lst.de, tglx@linutronix.de
Subject: Re: [PATCH 1/2] genirq/affinity: remove rsvd check against minvec
Message-ID: <Zj5PtvnSMoLPjg0o@kbusch-mbp.dhcp.thefacebook.com>
References: <20240510141459.3207725-1-kbusch@meta.com>
 <Zj46KiMO5trL09RA@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zj46KiMO5trL09RA@fedora>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240510_094754_747956_187C1B1E 
X-CRM114-Status: GOOD (  19.70  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, May 10, 2024 at 11:15:54PM +0800, Ming Lei wrote:
> On Fri, May 10, 2024 at 07:14:58AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > The reserved vectors are just the desired vectors that don't need to be
> > managed.
> > 
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > ---
> >  kernel/irq/affinity.c | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> > index 44a4eba80315c..74b7cccb51a16 100644
> > --- a/kernel/irq/affinity.c
> > +++ b/kernel/irq/affinity.c
> > @@ -113,9 +113,6 @@ unsigned int irq_calc_affinity_vectors(unsigned int minvec, unsigned int maxvec,
> >  	unsigned int resv = affd->pre_vectors + affd->post_vectors;
> >  	unsigned int set_vecs;
> >  
> > -	if (resv > minvec)
> > -		return 0;
> > -
> 
> This behavior is introduced in 6f9a22bc5775 ("PCI/MSI: Ignore affinity if pre/post
> vector count is more than min_vecs"), which is one bug fix.

Thanks for the pointer. Probably best I avoid messing with irq code just
for this use case, so I can have the driver disable the PCI_IRQ_AFFINTY
flag instead ... assuming hch doesn't "nak" it.  :)

