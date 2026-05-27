Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25588CD5BD5
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 13:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RHD5j7gB5Xdgd7LW+ZrE6dndSyx+q5rwokvar81A2+c=; b=jTfp0JmjJ/DAtM/Em3AVmWmhqV
	V14pOG2Rb4K0iqNbHl3a7WO2T85EfaB05vsL1+79T2jNuPUuPJmsykn77bUouo1A055EbVnSvPP7m
	rIOwOlNLTp5l7z9XTDnAjs1MY2gVnIb13L3Ygkqw/w0vrHh1tamBalLsZPpBdTGEsftUfIL7B1DwM
	5y/LTBrJkB6PtX+j+ZIaB/A5CzVzLwd5ldRYktN9H7gqYzHZPxFD3KZZyXt1uGr4oqrpg+26lN9Hh
	kNBY9anYBPa7wFft1KLjjIsSch9G96Pv6lWnVFqYrEyLTGY5Bl050JsBpFIIktxE2mW6AzHXLNdIS
	VhBwI16A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSEI1-00000004Bqn-3mWX;
	Wed, 27 May 2026 13:27:17 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSEI0-00000004BqD-097f
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 13:27:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id EB12D60229;
	Wed, 27 May 2026 13:27:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E53E1F000E9;
	Wed, 27 May 2026 13:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779888434;
	bh=RHD5j7gB5Xdgd7LW+ZrE6dndSyx+q5rwokvar81A2+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JPahrZwHShfjyDuQ2aMEjQHzzAu9cGToVWE9W2m3NtAu4FaMFlzZCAWaejtw7LxCv
	 LdQt2SYsGWBWZKdF/1x9dX0KXQKqOvul1bMOQvFIdhTTUXQYRcGYKOGedTGg7imAoA
	 P1D3xLzTyWsId7NR3AFdZteKB0SAk1kZAohlOyYwPe9vHqwFxFMnjidPTCAF53MfOn
	 UzC1sNHhWEi5Ey7y7a43pE47KIhxEDxXEnwo7SFLDRCjInNdqSrdQBmLuNEh8qA9w6
	 bCiOBEHg517GfHqGIAHO6NZzQT5KnKFQO9JOqb5+X3bahIIqNhB1nye7NUxUpjtRGZ
	 bdjx1vmDRNtnA==
Date: Wed, 27 May 2026 07:27:12 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk,
	nilay@linux.ibm.com
Subject: Re: [PATCHv2 2/2] nvme: add support multipath passthrough iostats
Message-ID: <ahbxMLlLH1KlrD1P@kbusch-mbp>
References: <20260526153921.2402015-1-kbusch@meta.com>
 <20260526153921.2402015-3-kbusch@meta.com>
 <20260527131657.GB10351@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527131657.GB10351@lst.de>
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

On Wed, May 27, 2026 at 03:16:57PM +0200, Christoph Hellwig wrote:
> On Tue, May 26, 2026 at 08:39:21AM -0700, Keith Busch wrote:
> > +	struct nvme_ns *ns = q->queuedata;
> >  	struct request *req;
> >  
> > +	if (ns && nvme_ns_head_multipath(ns->head))
> > +		rq_flags |= REQ_NVME_MPATH;
> 
> I just wanted to come with reasons why it this is wrong, but it actually
> seems already - we only have a ns for multipath nodes if multipathing
> is enabled.  Maybe throw a little comment in on that?

Yes. An added subtlety here is that we unconditionally set
REQ_FAILFAST_DRIVER for passthrough requests, so it does not get
failover consideration. You can't steal bio's from a REQ_DRV_IN/OUT
request because all the necessary driver info is attached to the
original request, which doesn't follow the bio.

