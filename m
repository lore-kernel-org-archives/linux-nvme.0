Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00547C83F1D
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jul 2025 06:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JFvFr7GAgXBrZAhxchY3O2yMe8TZB5+tUv4D9JwwaQM=; b=N2v0CtKG2o/Qay68Umg9xua+lr
	lf+99N4gYY3Lo5YhZUmVyIwIBAwYcnin03j2TOjBVXHphz++z9v6eRfzw8dPbZ4qYNjIZp3k1h66b
	q/HpVNkPEnPcQvPA9y3h2et8EXv2FXPii07Nfm6gejD1LLEC7ra+6qJpcS6zrutDsMpTMpn4idewq
	qKTVKezempdf/uFwL269tOEHFeE+loYbXzZk9zpJDT0Z0sJmnys3tIY9XK+qBVvY+1txz2hc2rP4U
	xNh6/J4TLIss/6hppctNV8Dcy7ZBNLD7ZHVLqfe4CZpcPX1KSSzYXtlEsKAJU3ko9hh93E0Ju/LHR
	4PosYGGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubYou-00000004Ad5-29QF;
	Tue, 15 Jul 2025 06:07:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubYmx-00000004ANV-0Ntm
	for linux-nvme@lists.infradead.org;
	Tue, 15 Jul 2025 06:05:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 324B6227AAF; Tue, 15 Jul 2025 08:05:10 +0200 (CEST)
Date: Tue, 15 Jul 2025 08:05:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@lst.de>, John Garry <john.g.garry@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: Do we need an opt-in for file systems use of hw atomic writes?
Message-ID: <20250715060509.GD18349@lst.de>
References: <20250714131713.GA8742@lst.de> <aHVuSU3TB4eNRq8V@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHVuSU3TB4eNRq8V@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250714_230515_295716_1C610E89 
X-CRM114-Status: GOOD (  13.50  )
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

On Tue, Jul 15, 2025 at 06:53:29AM +1000, Dave Chinner wrote:
> This isn't a filesystem question - this is a question about what
> features the block device should expose by default to the
> user/filesystem by default.

It's both.  As I said before we've spent a lot of time making the file
systems less reliant on hardware getting everything right by adding
checksums (for metadata everywhere, and non-XFS file systems for data),
lsn verifications, etc.  And now we go all in to trust a new (in case
of nvme very much misdesigned) feature.

I'm perfectly fine offering that use, but I'm a lot less excited by
automatically using using it due to my deep mistrust of hardware.


