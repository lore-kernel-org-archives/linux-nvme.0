Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F0BC54F30
	for <linux-nvme@archiver.kernel.org>; Fri, 23 May 2025 13:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hyf5JRLKqIav9cUOYory0W+34rSaiywHM8eIA3xqmmA=; b=niiEJEQZz3oRdxYeOc0oQuQM/j
	zd46Dn+sPd2Zaxc6gD6YqY5t13QdnZyCgBw1lSZJWaZiR2iHiEEjdecH19dk5QNw78ujUqQar7Dvr
	OFn4DL+tnAwEUYjZzF8+IijiFjGapi8H4ehnQXE1+l6GWHyC3o248aFfkp4o+iA7i0HdiwTnkdhLn
	vu4gN1pOK42FbMvWTZrLPjgJbetOHA6ybbR+9wKbHpddnGSo8plupo29C9qezFAjoxEgAshQNBoba
	viA+PcO06/k9IMrszEtwDsovvsrf7mX6zdHwUX85oC+7ty0DrtCpp38M2ELWDTk0+Lh9yMWXcKXaJ
	tz7IMjEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIS1o-00000003slK-1oZi;
	Fri, 23 May 2025 13:01:36 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIRpW-00000003qmw-0c09;
	Fri, 23 May 2025 12:48:54 +0000
Date: Fri, 23 May 2025 05:48:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/5] nvme: add support for copy offload
Message-ID: <aDButoJC0WHWxSoP@infradead.org>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-4-kbusch@meta.com>
 <CADUfDZqVeaR=15drRFvdrgGyFhyQ=FtscaZycVrQ0pd-PGei=A@mail.gmail.com>
 <CADUfDZqC0kiLTDFv3kXNaDr25rb+6RGG3cW3r=mox2vdihpsow@mail.gmail.com>
 <aC6Ymfrn1cZablbE@kbusch-mbp>
 <CADUfDZr8DJUPhLvVFK9OPSv015VDSBGNv7z_rrioHFAqOALUOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZr8DJUPhLvVFK9OPSv015VDSBGNv7z_rrioHFAqOALUOg@mail.gmail.com>
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

On Wed, May 21, 2025 at 08:41:40PM -0700, Caleb Sander Mateos wrote:
> On Wed, May 21, 2025 at 8:23 PM Keith Busch <kbusch@kernel.org> wrote:
> >
> > On Wed, May 21, 2025 at 05:51:03PM -0700, Caleb Sander Mateos wrote:
> > > On Wed, May 21, 2025 at 5:47 PM Caleb Sander Mateos
> > > >
> > > > alloc_size should be sizeof(*range) * i? Otherwise this exceeds the
> > > > amount of data used by the Copy command, which not all controllers
> > > > support (see bit LLDTS of SGLS in the Identify Controller data
> > > > structure). We have seen the same behavior with Dataset Management
> > > > (always specifying 4 KB of data), which also passes the maximum size
> > > > of the allocation to bvec_set_virt().
> > >
> > > I see that was added in commit 530436c45ef2e ("nvme: Discard
> > > workaround for non-conformant devices"). I would rather wait for
> > > evidence of non-conformant devices supporting Copy before implementing
> > > the same spec-noncompliant workaround. It could be a quirk if
> > > necessary.
> >
> > Right, that's exactly why I didn't bother allocating tighter to what the
> > command actually needs. The number of devices that would have needed a
> > DSM quirk for the full 4k was untenable, so making the quirk behavior
> > the default was a sane compromise. I suppose Copy is a more enterprisey
> > feature in comparison, so maybe we can count on devices doing dma
> > correctly?
> 
> For the record, that change broke Linux hosts sending DSM commands to
> our NVMe controller, which was validating that the SGL length exactly
> matches the number of data bytes implied by the command.

Next time please send a bug report and/or fix ASAP when you see
such changes.


