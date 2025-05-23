Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4296C54ED0
	for <linux-nvme@archiver.kernel.org>; Fri, 23 May 2025 13:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9nYC3wBL3fo9qESYFoc4fk+hhNxUQzhzP4sEjHOvoDY=; b=Pg9a/n8ubx5jU/TDKBxlAgXxBV
	vz2troQovw9fFa+sSoELuF5+ZFzBnLWOu2zaVw7yRoibhBTGFuUV3gFamxFCVvKBjX+eWzBzwfQny
	4/fVI92hSz1fgD3oPznxo5XykfrfKHjoN5/KjFYJeRrczLxfHko43An9InUxVRwJ7xiBiT4nPGI1J
	VVyf+xhbwg0kUXSd3xaLl/8p3s4gOCEzo9RO9BPQoqPVmQkHCZVFRUJDsRhHoyewWQ1b6fLrpMOrW
	mYeDYLafPC+uMJ2UXPWqklvKuKYr3vra7VRb8/0gDyovu0vFTbbjC+OWiMGkMgr+R3J/EXNo0oDoL
	oecogdaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uISYV-00000003yPG-06p0;
	Fri, 23 May 2025 13:35:23 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uISQD-00000003x2I-0zzy
	for linux-nvme@lists.infradead.org;
	Fri, 23 May 2025 13:26:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4A9D85C4D69;
	Fri, 23 May 2025 13:24:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEFFC4CEE9;
	Fri, 23 May 2025 13:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748006808;
	bh=sqRkjVZ3F3dEMt2KHGeZ7+4b/Gt0fBHflzBf81991rY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KgZHhKUc+ge2ysksf5L206+wa9025iWCyWieHRK8uiHNPYyy6GRP2RJQjLHZTQzPF
	 tWABZQc8UxgKfiHXTQP4oHqJ17jE++1DnPMVEUqJujkDbSHMu7s4I1GdDOTn0cQyy4
	 6h6CHpQyWLsv6n7CiXy3RZC9jy2b2z/GfTiFVCo5k1vU3C224i3GRpp8YPOYQmhClc
	 Er4HDmiqpDeLOvFLvxKcn0OANzLzdejQf9ZrEymBf/ZFvHakf9GDCfeF17b02gVmNB
	 8ADbhb6vFYkurAx4oGWjxoO6c7hIfByjXRMxhkp1BIeIkHuMVWVUT0vI03xYwA4HkH
	 SvDN/Hbfe1iTg==
Date: Fri, 23 May 2025 07:26:45 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/5] block: add support for copy offload
Message-ID: <aDB3lSQRLxjDHTSE@kbusch-mbp>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-3-kbusch@meta.com>
 <aDBuQbsBRVjOc5wU@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDBuQbsBRVjOc5wU@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250523_062649_314097_70540FDE 
X-CRM114-Status: GOOD (  18.88  )
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

On Fri, May 23, 2025 at 05:46:57AM -0700, Christoph Hellwig wrote:
> On Wed, May 21, 2025 at 03:31:04PM -0700, Keith Busch wrote:
> >  struct bio_vec {
> > -	struct page	*bv_page;
> > -	unsigned int	bv_len;
> > -	unsigned int	bv_offset;
> > +	union {
> > +		struct {
> > +			struct page	*bv_page;
> > +			unsigned int	bv_len;
> > +			unsigned int	bv_offset;
> > +		};
> > +		struct {
> > +			sector_t	bv_sector;
> > +			sector_t	bv_sectors;
> > +		};
> > +	};
> 
> Urrgg.  Please don't overload the bio_vec. We've been working hard to
> generalize it and share the data structures with more users in the
> block layer. 

Darn, this part of the proposal is really the core concept of this patch
set that everything builds around. It's what allows submitting
arbitrarily large sized copy requests and letting the block layer
efficiently split a bio to the queue limits later.

> If having a bio for each source range is too much overhead
> for your user case (but I'd like to numbers for that), we'll need to
> find a way to do that without overloading the actual bio_vec structure.

Getting good numbers might be a problem in the near term. The current
generation of devices I have access to that can do copy offload don't
have asic support for it, so it is instrumented entirely in firmware.
The performance is currently underwhelming, but I expect next generation
to be much better.

