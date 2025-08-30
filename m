Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCACBCA0FF0
	for <linux-nvme@archiver.kernel.org>; Sat, 30 Aug 2025 01:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zm4RmUO/x89FQHfVhcNLdCkGIv5pfLWFwl35/Z6sK8A=; b=Rk6SE3Zquu+OHk2vK2BdC28RT8
	5YO0Py6UO7j8Ph3YOrUd4b8UNjw0IwQ9IYGIY5qEfNvXE4XSRq8L08vpZke9GAK8PgZBiEhsWDbt9
	IcAWgXAYrajD8b5oACh28O3kGcmzgBumnXb6XU9tbmvJUilNZD+/b6xjzwU1TP8vRqLU5S/scSs0t
	oTw0+YgJKlK2T/8YoTtPOTFG6N45/sNFPxGFu5ZEWSmIQ0AOq0B4A3K0AApF1g/jOejWxavwr8apJ
	DNYOkk7sSjbH6KgKLWV27FDx2bX1c2Jh/WJXDkhDp6HxA7zBQBuwtfSqFWTKYd0W0IBiIF04R3VM+
	yoA6omXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1usAh1-00000007IZe-0uek;
	Sat, 30 Aug 2025 01:47:47 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1usAgy-00000007IYt-1LK7
	for linux-nvme@lists.infradead.org;
	Sat, 30 Aug 2025 01:47:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3ACFD43802;
	Sat, 30 Aug 2025 01:47:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6222C4CEF0;
	Sat, 30 Aug 2025 01:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756518463;
	bh=zDvl+0mYl7B1IhYYLGnaqnKHVG/ZkuRi7oUHiicRwf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nqsj8dN+DUEsg1mJ2QeNwyZCNjjtY5olN8/7yi6jMQs7E7ITe97a/OXNae7SguaO/
	 19om4q+mKKxoah75XzkrDdOXZFVAZeLHUrjozV+8HTkBvG97J6D20AcXld6ZPz+sCB
	 zezMEVYQqc1kJJboQlvTTMreLozgtSwiXjv6c0gE35LM3Y0eSHZJa3zllemdD5ocL5
	 If5ey2NVeII7UYUyDJHelS7yw4uik/YTVmT+CXBCr6P93WVze2HUbyMkgKDVSSYDp0
	 Lh3BWmbjmIEIrZKrV88flYV7VY++9zwL3yvFjC/JJYWIlsYf0SEgEZDR2m1MUMiCPS
	 5PVbvITmfZkkg==
Date: Fri, 29 Aug 2025 19:47:40 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, iommu@lists.linux.dev
Subject: Re: [PATCHv3 1/2] block: accumulate segment page gaps per bio
Message-ID: <aLJYPGKE4Y_6QzY2@kbusch-mbp>
References: <20250821204420.2267923-1-kbusch@meta.com>
 <20250821204420.2267923-2-kbusch@meta.com>
 <aKxpSorluMXgOFEI@infradead.org>
 <aKxu83upEBhf5gT7@kbusch-mbp>
 <20250826130344.GA32739@lst.de>
 <aK27AhpcQOWADLO8@kbusch-mbp>
 <20250826135734.GA4532@lst.de>
 <aK42K_-gHrOQsNyv@kbusch-mbp>
 <20250827073709.GA25032@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827073709.GA25032@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250829_184744_372888_AA2EC8FA 
X-CRM114-Status: GOOD (  12.06  )
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

On Wed, Aug 27, 2025 at 09:37:09AM +0200, Christoph Hellwig wrote:
> On Tue, Aug 26, 2025 at 04:33:15PM -0600, Keith Busch wrote:
> > virt boundary check. It's looking like replace bvec's "page + offset"
> > with phys addrs, yeah?!
> 
> Basically everything should be using physical address.  The page + offset
> is just a weird and inefficient way to represent that and we really
> need to get rid of it.

I was plowing ahead with converting to phys addrs only to discover
skb_frag_t overlays a bvec with tightly coupled expectations on its
layout. I'm not comfortable right now messing with that type. I think it
may need to be decoupled to proceed on this path. :(

