Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 412DCCDB470
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2026 07:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L6P13Pyq+qGOSHE08HJSZ1x8R4y3fLQlQPFdW/Szo5g=; b=3Hi6uyQ6C6+GEYQjI+PV/0XgBc
	EwwvFwk6MTK8dOIp21FO6f7xZPn5p1bdrM0f+oO2ycV6I5Z5hVrQfB6eyk0T0rCJHBfChMFtEmliw
	kGmwz7J9DQkZ/d50WLx6+bG5kf4r8D+QeTG8I/j3ae1p4Tqm98qwMW22LFYpH9XLPKC+Ylpy12xl3
	Y+hZt13CcH2N3KhrKYNqkzewDH/qLT/rBltP4GKa03aeFeIZ9jUiqodqJ5qcpiBo34OkKjC/cGcwr
	5TBc7erqgp6LJDS1Los6ATX6xJYDbnLjvjCvZVpLXKGsT48IW+U+Edx0NGtaqyEtjdnCVDMeipwFO
	RloL+WWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcIEB-00000007KnN-3ojt;
	Wed, 24 Jun 2026 07:40:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcIE8-00000007KmB-3AYS
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jun 2026 07:40:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 70BE368BEB; Wed, 24 Jun 2026 09:40:45 +0200 (CEST)
Date: Wed, 24 Jun 2026 09:40:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: David Epping <david.epping@missinglinkelectronics.com>,
	linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Leon Romanovsky <leon@kernel.org>,
	Joachim Foerster <joachim.foerster@missinglinkelectronics.com>
Subject: Re: [PATCH RFC] nvme-ioctl: propagate PRP1 from ioctl to admin cmd
Message-ID: <20260624074045.GB12649@lst.de>
References: <ajlDjpjK_clMrnwx@ubuntu-server> <ajlIPlEv_zBfTMVG@kbusch-mbp> <ajlNFpz5977PzLvb@ubuntu-server> <ajlRnLI8OdaUVOZp@kbusch-mbp> <ajphNQIpfIRYZg_H@ubuntu-server> <ajp5vFaVB4wOHjpf@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajp5vFaVB4wOHjpf@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260624_004053_010851_499B76DA 
X-CRM114-Status: GOOD (  19.87  )
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

On Tue, Jun 23, 2026 at 06:19:08AM -0600, Keith Busch wrote:
> On Tue, Jun 23, 2026 at 12:34:29PM +0200, David Epping wrote:
> > My question is, and maybe I should have put this in my initial email
> > explicitely, is there interest in having such functionality in the upstream
> > Linux in-Kernel NVMe driver? An interface and mechanism to request and
> > manage IO queues that are not used by the Linux NVMe driver to perform IO,
> > but handed to a separate entity for this purpose.
> 
> Partitioning device resources to assign to special purposes should be
> under a well defined framework. Unfortunately the only thing I know of
> approaching this is SIOV. :) Not sure how other maintainers and
> developers feel about it, but that's the route I would go for this. It
> at least provides memory access on a queue granularity and neatly
> separates the control plane.

Yeah, we can't just hand out queues.  I/O to all namespaces can be done
on queue, and any queue can address any IOVA, so this is fundamentally
unsafe.  Add to that fun like abort handling and it's just not going
to work at all.  We had at least to previous public attempts at such
schemes (Damiens' libvnme back in the day, and the Mellanox nvmet
offloading) that were rejected for the same reason.

