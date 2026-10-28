Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09704606A323
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=cjW5uO6a;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CiABkuui
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ga8rqL+109v/fKuZ5mT99In7aNIISKXhgfrPd0PyXs8=; b=cjW5uO6a7xXh7qHPrNaOTjEGw/
	4fh0T0BMCzG3x57m+zggp2Bm+g14b4YlFa3VJaO+HvIf1ZfelQXDTEK8gylqEEf4eS3H6s8h4RwDl
	5wlJ0mL/PGmCjOC/miDhMrZThl9p+cLkpxdj5e+KbQi2xFDiMw5+MvyxrBLahIH5vHp406k5rgOYS
	LQ7bTENljXgXqU0u5oE42dzISSJbkhyF0XK4cwA5xFdcFVt5HzsxmRl6QSr/Oa+ACdMVwanoLPo47
	2wZQvdbwwC0enPfYm6VJgapV96JsTBNS4DHG2aDmmnMbDEE066R8M+wezkuajyaaWYDut8glhQ7de
	PBqMz5zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM6CD-00000007VCQ-1Jjl;
	Wed, 28 Oct 2026 16:08:13 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM6C7-00000007VBr-41AF
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 16:08:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1BEBA40A76;
	Wed, 28 Oct 2026 16:08:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB7A1F01300;
	Wed, 28 Oct 2026 16:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793203687;
	bh=ga8rqL+109v/fKuZ5mT99In7aNIISKXhgfrPd0PyXs8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CiABkuuisImSPE+Plcx5yKvUaz+gcoONNaIqr4xnxWbfIeq8JY5+r/8x/FopicgZS
	 LE1M/OGJ/y0MN6DSoH1OEHyKW5oXZDC0I8TFZbcGaNFz5QhTbQTyvsn/P0d0RsFyyI
	 PFkrjmX8G69uuCWLXMiJV8F+s1pT1jDx08uaom+IJ20b6/SD/f3DJWwbv/nF7CABOI
	 cfzEEfy3v46l7P1jedpnib8AjmuvANS64bEGvJLZqIbZSxnvTs+0DyQv1yzPQ1QZ8z
	 in62Deb3QCVii2VxzMucEDFl+osdi9qAkgUaPdnEufmBXNnXkV5DkztL44+A873apa
	 npNufunsN0tVg==
Date: Wed, 28 Oct 2026 10:08:05 -0600
From: Keith Busch <kbusch@kernel.org>
To: Erwan Velu <e.velu@criteo.com>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, linux-kernel@vger.kernel.org,
	Erwan Velu <erwanaliasr1@gmail.com>
Subject: Re: [PATCH] nvme: honor the volatile write cache enable state
Message-ID: <auId5RuBhMFGirJ1@kbusch-mbp>
References: <20261016141208.2641974-1-e.velu@criteo.com>
 <atJXYHJa4jkUWJmP@kbusch-mbp>
 <CAL2Jzuz1qFwLSA=iivp5qLCTL6-4rvKmvFzJbOQzjPu6j_7Y2A@mail.gmail.com>
 <atJeazM_rJ0uj3vt@kbusch-mbp>
 <CAL2Jzux8v6zCxfcdd=MY5n0zQMVSa-_8Lki9z-fz7bFShNf7vw@mail.gmail.com>
 <atJk_2FmzjUZYO_Z@kbusch-mbp>
 <f665dc3e-fc5c-4352-8e41-a46b7ae97946@criteo.com>
 <CAL2JzuwuZp0gg1D7wSn7cdgpnhotnuLP6YpPd-SrdVyqhkeiJw@mail.gmail.com>
 <atqZmctbU0siYmVX@kbusch-mbp>
 <7fec6534-9e57-4041-8699-72c5950c7e2a@criteo.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fec6534-9e57-4041-8699-72c5950c7e2a@criteo.com>
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

On Fri, Oct 23, 2026 at 04:53:54PM +0200, Erwan Velu wrote:
> > I just wanted to see if there was any difference in the controller's
> > Flush behavior when the volatile cache was enabled vs disabled, and this
> > looks like it's the same either way. The Flush should have been a no-op
> > to the device with WCE cleared, so something seems off here.
> > 
> > I'm wondering if the device is actually really respecting WCE set to 0
> > now. That might be tricky to prove, but it wouldn't be the first time a
> > device lied  about durability. Not saying that's happening here, but the
> > behavior you're reporting is suspicious: 15usec writes are not
> > physically possible with TLC NAND (your model says BiCS TLC) without a
> > cache, and your controller says your cache is volatile.
> > 
> > Anyway, the principle of what you're proposing looks fine to me from a
> > spec standpoint. I'll get this queued up if I don't see any other review
> > feedback or concerns that it's going to corrupt something...
> 
> Thanks for your feedback.
> 
> I'll discuss this firmware question with the vendor in private and will keep
> you aware.
> 
> Considering the performance impact for these type of device,s would you be
> open to a backport to stable once merged ?

Not sure when a performance improvement is stable worthy. I'm more
concerned that doing this is going to expose corruption, but it's what
the device is asking for, so fine to introduce it, but stable is
questionable.
 
> This patch is really about matching the spec and it would be probably a
> great positive impact for many stable users to benefit from this patch.

There's just a gap with the multipath head: if you start up with WCE
cleared, then turn it on, the head isn't updated to indicate flush
limits. Let's get that fixed, then I'll queue this up.

