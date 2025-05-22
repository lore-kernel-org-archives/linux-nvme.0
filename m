Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02494C54E65
	for <linux-nvme@archiver.kernel.org>; Thu, 22 May 2025 16:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G8w4SViOgbQ5cPApgBuCcVXahGiXr/dhbGmXH6j7gBg=; b=4Q8Oo+nkgc8JREKjl7C7HF5Vwz
	uJkpYYRvpc4mQzcFXzA3fZayNzZfK+yD8jgc8mUwXxZ0ahUhkESRdJSFq5EBPdR7xydmmJ0hupD1Z
	oXVzI55qE8xZpuoxsvr+1x6yw6CEZFsR3uwXSbYp0jtoFG4/c5r4ebInNMkMo1h6X9NND+/c6vaSq
	8Lig5zFKQPVZ/+PO/XtKihVA4JmtKrueQsT3gJufBwmCetw1sej1wlM/VL8qIQ/AnHjHp4o4n0Dl7
	J5evMP+8IcuqLcMMC6eDSAxETolMrhteD4kUbC1g5Jqqaj+xojzao+LjGiUfnEbUTekjjih5xxL66
	rcjc8FaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uI91c-00000001eGo-3boP;
	Thu, 22 May 2025 16:44:08 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uI916-00000001eCe-07uI
	for linux-nvme@lists.infradead.org;
	Thu, 22 May 2025 16:43:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 595505C63A6;
	Thu, 22 May 2025 16:41:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD801C4CEE4;
	Thu, 22 May 2025 16:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747932215;
	bh=Q/3Q+MOrCjOHubqJCo/KOw2SeyxZyWfokxhGYpVBieg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PQXKds6EEYQ3AjvbWMbUCgZv21WbhJPGRsWAdTSEb6WFHnZ0t5gX6GkV6tGTAUUbU
	 cNp+p0LKHE+m4XjrcFFIiXr6oGjiwAQJ9b7Y0C9KreLOO0doHJDQmUNAtB/NxY2aPF
	 niZGTfu983iJ1iHWEGziGkR3/cyzW22k99mZEyDHb83JfMJ1dahJP8gBkO9YnCP0F9
	 BMAnBhePn5cUYdoYZJNbSCa02C5GVsTiJRtiX9Kw/cxqMCkr+C2G4hfLKzcsn5zkhI
	 OxxIGwB8y4ndteFfDXf9AaKApP1nf0bGUjfBY4qp3+GQluB1LHp44iqiIrrggc1I41
	 v5tjdCtgyBDTg==
Date: Thu, 22 May 2025 10:43:32 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/5] block: new sector copy api
Message-ID: <aC9UNDRpy7KraJCz@kbusch-mbp>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-2-kbusch@meta.com>
 <dc0206b7-1224-409f-960c-11549722482f@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc0206b7-1224-409f-960c-11549722482f@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250522_094336_111348_9076C095 
X-CRM114-Status: GOOD (  13.51  )
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

On Thu, May 22, 2025 at 12:02:07PM +0200, Hannes Reinecke wrote:
> > +/**
> > + * blkdev_copy - copy source sectors to a destination on the same block device
> > + * @dst_sector:	start sector of the destination to copy to
> > + * @src_sector:	start sector of the source to copy from
> > + * @nr_sects:	number of sectors to copy
> > + * @gfp:	allocation flags to use
> > + */
> > +int blkdev_copy(struct block_device *bdev, sector_t dst_sector,
> > +		sector_t src_sector, sector_t nr_sects, gfp_t gfp)
> > +{
> 
> Hmm. This interface is for copies _within_ the same bdev only.
> Shouldn't we rather expand it to have _two_ bdev arguments to
> eventually handle copies between bdevs?
> In the end the function itself wouldn't change...

Sure. To start, I think it could just fallback to the non-offloaded
instrumented "copy" path if you have two different bdevs. Utilizing copy
offload across multiple devices is a bit more complex, so I'm focusing
on simple copy for now, but want to leave it flexible enough for such
future enhancements too.

