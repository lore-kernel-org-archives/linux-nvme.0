Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B91606A31A
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 17:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ass2c27h;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IECpJTyt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Khepq3HVmXfGIh7NMXvkdrEul/x4xyGA8jwlNAtrA0I=; b=ass2c27hk1uK0W6jQ2qwNuEk6N
	iWzRrgsTeJ7PHPbBdUf5LCbcqqOL3T4+E8kSNKrqgxXcWy8tKcLxfv8tUHP78qQeKEMAoNlQ3SOhH
	27dJSXlr98IKaYXupq10gbVzuRXIs2C+uGwPjIKDSUeuRK6GpUz4/RscCNIasIJpYYyPFZ5O9/JBt
	qPOezTKrozkN/JeDFVsQAe7M/ecV0kCufj3MQCadphYyGAdDP5I96304CRW/LxNlfFvJNdVES6a+k
	OEW7ef/rh5GVT0Vi6GjT333dobhpsoReCfqMwOuQwnV56PNg1KHPNlCQ0qP6jsRKLNfatJ2Wt0dCp
	MRqgupeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM7kI-00000007hR5-1BTx;
	Wed, 28 Oct 2026 17:47:30 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM7kG-00000007hQ9-1xFE
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 17:47:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D09F641411;
	Wed, 28 Oct 2026 17:47:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E011F01829;
	Wed, 28 Oct 2026 17:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793209646;
	bh=Khepq3HVmXfGIh7NMXvkdrEul/x4xyGA8jwlNAtrA0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IECpJTyt2Oz6ZKLCukTSn7AEY5ufZtSzT4CO7RdGh5QIXY+SFHJS4urIF2K7LwVyl
	 I6brUJaboY+FwvTGyiMIUaTLUf8Ja/AhhrYyop0XQWJINBZ4ZuNaoXlDshIXReHdIu
	 CCw5C7HYvJehb4n7xlCgRc8ZZHzjdtS7J47mELeoTqF1IZKt9RgYMCzmTO2wjeShaH
	 Z0buq46H/qzSrgMVfKeLwWonva5yGNxhLybUdlf1TlNWDWDYdxalXdywzOPOmIGbI4
	 steAtoXXMmsGUamrMBwJWGWOSW8G4Pq2DygAxT8DpqfkUttMw6YiXr3UKYXj1fMn3H
	 FRVnJs7m8L2iA==
Date: Wed, 28 Oct 2026 11:47:25 -0600
From: Keith Busch <kbusch@kernel.org>
To: Erwan Velu <erwanaliasr1@gmail.com>
Cc: Erwan Velu <e.velu@criteo.com>, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: honor the volatile write cache enable state
Message-ID: <auI1LR6Ql397Kl2b@kbusch-mbp>
References: <CAL2Jzuz1qFwLSA=iivp5qLCTL6-4rvKmvFzJbOQzjPu6j_7Y2A@mail.gmail.com>
 <atJeazM_rJ0uj3vt@kbusch-mbp>
 <CAL2Jzux8v6zCxfcdd=MY5n0zQMVSa-_8Lki9z-fz7bFShNf7vw@mail.gmail.com>
 <atJk_2FmzjUZYO_Z@kbusch-mbp>
 <f665dc3e-fc5c-4352-8e41-a46b7ae97946@criteo.com>
 <CAL2JzuwuZp0gg1D7wSn7cdgpnhotnuLP6YpPd-SrdVyqhkeiJw@mail.gmail.com>
 <atqZmctbU0siYmVX@kbusch-mbp>
 <7fec6534-9e57-4041-8699-72c5950c7e2a@criteo.com>
 <auId5RuBhMFGirJ1@kbusch-mbp>
 <CAL2JzuzMo3xTMbF6LK97yf6-CB0_NGhr7sGpf69Gv3ONvZQ1KQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL2JzuzMo3xTMbF6LK97yf6-CB0_NGhr7sGpf69Gv3ONvZQ1KQ@mail.gmail.com>
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

On Wed, Oct 28, 2026 at 06:08:17PM +0100, Erwan Velu wrote:
> Le mer. 28 oct. 2026 à 17:08, Keith Busch <kbusch@kernel.org> a écrit :
> [...]
> > > Considering the performance impact for these type of device,s would you be
> > > open to a backport to stable once merged ?
> >
> > Not sure when a performance improvement is stable worthy. I'm more
> > concerned that doing this is going to expose corruption, but it's what
> > the device is asking for, so fine to introduce it, but stable is
> > questionable.
> If we consider this dangerous for this device, should we add a quirk
> for some devices that could be seen as lying?

Let's just assume spec complaince for now until proven otherwise.
When/if a device is discovered to be quirky on this feature, we can
introduce handling to ignore WCE.

