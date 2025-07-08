Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06631C83030
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jul 2025 02:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/onpeu2MG7MtdjnZu7np73lg9upRhc6KDFMp+rUUTGo=; b=EeURMB5atdyxocpqVL+pYf1QT8
	pVqQ/HQy4jHMs/vq3ewKFa4C8DZbz+a94LJqLlw5qLwD4a2A5xptHc/kHkX7ItHsCUOhQvKG86MJJ
	WaWjGDa7YcRVi5r+4cG0PVSM2Fp4JJ7J5MKwR2K88R4N3BkNHdcAZNJ1fpBfCYm6POhEaSJBL/O0S
	4xnl6R0xmEGL4b7vI44uVdJniPobj1qQ1xMYUwuak62RCLxyClC0YH3NB4++EDeEc4Xu5GhYYzYaK
	9zHaLTaorb8/XxeK1v8de1ZbisLxMUZsiLAUS/JAPjcUE366ktKuK8tnLrUYzj3DciYZjHBiFhwZs
	U/YKF+fQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYyW0-000000047u4-21f3;
	Tue, 08 Jul 2025 02:57:04 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYyVx-000000047t0-3nV5
	for linux-nvme@lists.infradead.org;
	Tue, 08 Jul 2025 02:57:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2886544F02;
	Tue,  8 Jul 2025 02:57:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBA0C4CEF4;
	Tue,  8 Jul 2025 02:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751943421;
	bh=GF2p/3SsYrU7VfaSh41ZXuJEuxpj16pbcMv4p6eATNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kt883RtIgUw94xyrj9dmcHljyXWVvR6rRJFX8JuKZNp6O3TZcQEDlqhrv49T/uA22
	 g+XqVaPLB/pTXszyxEKMGTmLRon4Fu+6w+YlX4nYrViASoVD0TVI3zT+ORrkx46BB1
	 nQ+1L0w9+isZphgaoGrZVDZsjksMJLwTQNS8IgniCJpghqKm4sEKOKCrniNc1mLfis
	 fPHKJizlgXWi/Hj9ziVq1cCh8BfZPcVQnx2Aoq6Zit2nHIqXAo0dlSid/rQ2beTaY9
	 mrlChqz+jkeOGTF1kYCUkVQarOrJswJqIDWK9DlXq1xVg+mY8O3g+Sx7kVxbtl0InP
	 YtnbCDZ7eVDBg==
Date: Mon, 7 Jul 2025 20:56:58 -0600
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Alan Adamson <alan.adamson@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: What should we do about the nvme atomics mess?
Message-ID: <aGyI-sl68Y0klsJn@kbusch-mbp>
References: <20250707141834.GA30198@lst.de>
 <aGxz6s9oUp2FkbyX@fedora>
 <aGyCH8TOQgVY3AP9@kbusch-mbp>
 <aGyGboLwcn2cXoRo@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGyGboLwcn2cXoRo@fedora>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250707_195701_980998_EE2A57C2 
X-CRM114-Status: GOOD (  27.53  )
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

On Tue, Jul 08, 2025 at 10:46:06AM +0800, Ming Lei wrote:
> On Mon, Jul 07, 2025 at 08:27:43PM -0600, Keith Busch wrote:
> > On Tue, Jul 08, 2025 at 09:27:06AM +0800, Ming Lei wrote:
> > > On Mon, Jul 07, 2025 at 04:18:34PM +0200, Christoph Hellwig wrote:
> > > > Hi all,
> > > > 
> > > > I'm a bit lost on what to do about the sad state of NVMe atomic writes.
> > > > 
> > > > As a short reminder the main issues are:
> > > > 
> > > >  1) there is no flag on a command to request atomic (aka non-torn)
> > > >     behavior, instead writes adhering to the atomicy requirements will
> > > >     never be torn, and writes not adhering them can be torn any time.
> > > >     This differs from SCSI where atomic writes have to be be explicitly
> > > >     requested and fail when they can't be satisfied
> > > >  2) the original way to indicate the main atomicy limit is the AWUPF
> > > >     field, which is in Identify Controller, but specified in logical
> > > >     blocks which only exist at a namespace layer.  This a) lead to
> > > 
> > > If controller-wide AWUPF is a must property, the length has to be aligned
> > > with block size.
> > 
> > What block size? The controller doesn't have one. Block sizes are
> 
> It should be any NS format's block size.

That requires an artificial reduction to a meaningless value.

> > properties of namespaces, not controllers or subsystems. If you have 10
> > namespaces with 10 different block formats, what does AUWPF mean? If the
> > controller must report something, the only rational thing it could
> > declare is reduced to the greatest common denominator, which is out of
> > sync with the true value reported in the appropriately scoped NAUWPF
> > value.
> 
> Yes, please see the words I quoted from NVMe spec, also `6.4 Atomic Operations`
> mentioned: `NAWUPF >= AWUPF`.

The problem is when Namespace X changes its format that then alters
Namesace Y's reported atomic size. That's unacceptable for any
filesystem utilizing this feature.

