Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F88CC6B1D
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2026 13:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mnUdaOYTtIq1JhNfc/1a/6ioMMOx5xxkQoPirQVP2ig=; b=sQjGUlTo+ngtoR+/pprBD6spSx
	yPYMY0zV309inD0r+0ZoYmAGCxOvT+Ud3vMJHOabGvI5wd++R9Ox0ady+639eFMhOZgfRGY4Wte3B
	xLz2qBZONZ/B0R8/+DPfWXL3hdWLO9En2PwyscBWlrLBs8ODdiY1ugUkmCE3Bro3M7FZ1Nd9pBwk8
	ztiE9VApx4Xzskg8NgSE8GUV1gO/vtkw6PkaOdCsy1jWhegp9oU92yWBHI/5bTomjRU72vDqunsK5
	NoUq6e6zTjwtnA0hRqDcg60qCYecMBpVOERVeKSZnOB++39J34Ch+vEzZGSG7D0AFNNPgKgimUdtM
	M8LWR1hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGyev-0000000FWvh-32JO;
	Wed, 14 Oct 2026 13:04:41 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGyeu-0000000FWuj-1vU5
	for linux-nvme@bombadil.infradead.org;
	Wed, 14 Oct 2026 13:04:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mnUdaOYTtIq1JhNfc/1a/6ioMMOx5xxkQoPirQVP2ig=; b=msjyHyiK3dLuf6fihnIw2u6Yg3
	9g3RHcWc6ef4GsmZ3CxR74v/Ur1J4Chr2L3/lgKjGUmtJ8xrS2wfXWzSJgIYb88Ueq5qedeycDo0R
	yrQ0Ch6UDi6Wo3sV9dV1zcBkYfbHJeu3oHxHpW4pgYfKuUYtInh9nU6luWWT04twaYyd9Z9H6Y7M1
	GS9rXEpwb40WICnwluO7IxkhQFS0jowMX9IgoDTFrRVO8AnyIyOgWurXMzBB7iS1oxIBh4fa+TZOP
	ElfBwi8cEjzOmIxj2irB01cWDRSE/8yW8Uy0SIcLjefLXCbQJz0p9vBYwYXfapZ5r5PhHe8LSxzIq
	+AFUyOyA==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGyep-0000000Gn4F-2yTq
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 13:04:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 28EE868C4E; Wed, 14 Oct 2026 15:04:32 +0200 (CEST)
Date: Wed, 14 Oct 2026 15:04:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/5] nvmet: zns: don't leak stale memory in zone
 management receive
Message-ID: <20261014130431.GA15622@lst.de>
References: <20261012141239.156408-1-parri.andrea@gmail.com> <20261012141239.156408-3-parri.andrea@gmail.com> <20261013142554.GC14759@lst.de> <20261014110001.95212-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014110001.95212-1-parri.andrea@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261014_140435_830950_57E7C6C4 
X-CRM114-Status: GOOD (  18.62  )
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

On Wed, Oct 14, 2026 at 01:00:00PM +0200, Andrea Parri wrote:
> On Tue, Oct 13, 2026 at 04:25:54PM +0200, Christoph Hellwig wrote:
> > On Mon, Oct 12, 2026 at 04:12:29PM +0200, Andrea Parri wrote:
> > > Tested over the loop, tcp, rdma and fc transports with a zoned
> > > null_blk namespace: before this patch, zone reports carried stale bytes
> > > and a data length larger than NUMD was accepted; with it, reports are
> > > fully initialized and such a length fails with Data SGL Length Invalid.
> > 
> > Can you wire up the reproduce in blktests?
> 
> Sure.  Following Documentation/process/security-bugs.rst I had only
> offered the reproducers on request; since you'd like them in blktests,
> I'll post them to linux-block shortly, unless you'd rather have them
> off-list until the fixes are merged.  One test covers this patch, and
> two more cover the fc and NUMD patches of this series.

I would not consider anything relating nvme except for userspace API
a security issue.  The protocols are clearly not designed for and/or
advertised for untrusted networks.

Just to make it clear, that's not to say we don't want these fixed,
but they are considered robustness fixes and not security issues.


