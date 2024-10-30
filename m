Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 800A2D5CCB9
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 15:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MhgUH/mzKRTEQFzH1Clwp6Y7bEhmOHwgLH7szBdwTUM=; b=Mhv4+uh5VQjzpi3VsDEzBWs7aQ
	ddgpV9TI2bk3A/2dkNnPWNq3Ti37Wp9e5bh0SgYoy7HDA/IkFRkNKEyhjisjyAwFsvHUNEizco6vA
	mIs53Q8ZTXZoNZ/lUK0/DDCOcSOKQUynn4l+v4TST3fgOFDcgdiyVAnbQnMmdO1PXfiQi16N1nrpF
	pHIctbUZVMWEyGerDNmPSWkYcRu7P+/fElQvqAptpU6nspQf3f16uddy/OIHn9BiSBMblUalwkq1k
	ZTIqzp8EiO5rtQhkW+xtvh3jUvriHtWStg1JSoPGoZ6DEutDlrDlXGlonC3alMU8sK47Ft6D5cfeC
	pv/WLBoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6B6p-00000000zG1-2ekF;
	Wed, 30 Oct 2024 15:59:47 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6Aw7-00000000wPU-1F9b
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 15:48:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id C4B23A42A6A;
	Wed, 30 Oct 2024 15:46:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7077BC4CECE;
	Wed, 30 Oct 2024 15:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730303322;
	bh=Z7lajVfLj1duP+n0l9P3p1bDBmdmQ/uGrXYyAs1awrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZkL3EWvpb8K5NgMoHoQdSjnWhqgeT/ifVHYWMEqBAt72nkBJAWTSZrxYBsSNOL4VM
	 GA/qVnQvLSv1GxERFJ4glw/zCmJEAzDhCEtlmdWnhHR36G7fkEzkkaaX4dXmRzFXL3
	 z7tcnucMKack9hNoyWyPPAFhzeRWkEpaARoyW7KaPKkPYHXoNVPVmBenL5Euz1prh6
	 SfPZTMxJyhUwbjaRBL/L3vkgj8VR591C2m1kHKhCBQDWuL3DKek/v8PtdnvYJRXJTR
	 91WgiFFQVFeD1AachWwzHX2B2oOyqK42AxCdrALeTr119K3LVqry2xIHMKmpWs3uaH
	 YOLGgmFvJZmug==
Date: Wed, 30 Oct 2024 09:48:39 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com, javier.gonz@samsung.com, bvanassche@acm.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv10 9/9] scsi: set permanent stream count in block limits
Message-ID: <ZyJVV6R5Ei0UEiVJ@kbusch-mbp.dhcp.thefacebook.com>
References: <20241029151922.459139-10-kbusch@meta.com>
 <20241029152654.GC26431@lst.de>
 <ZyEAb-zgvBlzZiaQ@kbusch-mbp>
 <20241029153702.GA27545@lst.de>
 <ZyEBhOoDHKJs4EEY@kbusch-mbp>
 <20241029155330.GA27856@lst.de>
 <ZyEL4FOBMr4H8DGM@kbusch-mbp>
 <20241030045526.GA32385@lst.de>
 <ZyJTsyDjn6ABVbV0@kbusch-mbp.dhcp.thefacebook.com>
 <20241030154556.GA4449@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030154556.GA4449@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_084843_421607_BDD10A5C 
X-CRM114-Status: GOOD (  23.36  )
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

On Wed, Oct 30, 2024 at 04:45:56PM +0100, Christoph Hellwig wrote:
> On Wed, Oct 30, 2024 at 09:41:39AM -0600, Keith Busch wrote:
> > On Wed, Oct 30, 2024 at 05:55:26AM +0100, Christoph Hellwig wrote:
> > > On Tue, Oct 29, 2024 at 10:22:56AM -0600, Keith Busch wrote:
> > > 
> > > > No need to create a new fcntl. The people already testing this are
> > > > successfully using FDP with the existing fcntl hints. Their applications
> > > > leverage FDP as way to separate files based on expected lifetime. It is
> > > > how they want to use it and it is working above expectations. 
> > > 
> > > FYI, I think it's always fine and easy to map the temperature hits to
> > > write streams if that's all the driver offers.  It loses a lot of the
> > > capapilities, but as long as it doesn't enforce a lower level interface
> > > that never exposes more that's fine.
> > 
> > But that's just the v2 from this sequence:
> > 
> > https://lore.kernel.org/linux-nvme/20240528150233.55562-1-joshi.k@samsung.com/
> > 
> > If you're okay with it now, then let's just go with that and I'm happy
> > continue iterating on the rest separately. 
> 
> That's exactly what I do not want - it takes the temperature hints
> and force them into the write streams down in the driver 

What??? You said to map the temperature hints to a write stream. The
driver offers that here. But you specifically don't want that? I'm so
confused.

> with no way to make actually useful use of the stream separation.

Have you tried it? The people who actually do easily demonstrate it is
in fact very useful.

