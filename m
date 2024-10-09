Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DFBCEE330
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2024 16:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DEnT+3K8YaehT0AUxPYhWleZFPMiI4C4HSSPl/IqgMk=; b=EVFKmLcKZhlHxS7L5XINkl7hd4
	wyCrNhXTLDBe9To3t8IkkjukVGeiyABxAQf7WFJ5xpFssoaq2Hy8l0zoM6bByCXACq78xSSCgbgGj
	a7vsI8xhSyOGeRLfGMrrKlGNhxQgZKcXJ/tZAgyir9Xu5yuS1kqm+GErqIgzzplUfbeoM5YCeN2Ct
	Oq/vieogTVukSttrc5gB3t7roZlfYd1PAwwoWJiH7HJgxCylXKDNGA+Au6fPNK1RC8TgwjIABNjol
	DzDNbxVODypHfq3WUB68nlvC6c6+Y/jBmQiVWdYlwIrDc3vK8J3OanQkDwoD9ugY6bqTzjAq4sA/z
	1O54G22A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syZsX-0000000A3nP-3ZZk;
	Wed, 09 Oct 2024 16:49:37 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syZcy-00000009yrd-1vXk
	for linux-nvme@bombadil.infradead.org;
	Wed, 09 Oct 2024 16:33:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DEnT+3K8YaehT0AUxPYhWleZFPMiI4C4HSSPl/IqgMk=; b=oeG+0F5awBSa0fh32loUrbd5SL
	vC9NtcRTNQRaGS+d9M027imX6F5xKKZnKOpqN9KNZRZxmYYiNau82AMWS8Z1vFyMdrNmbP9gbgQ99
	aLURxqcPD9EplIqkaccNq7c5MP6oww+qqgePeZjsSegLglcEX+sokJEt5fjiIHjdXyOmTRkJYCDiZ
	EIqezPpW0XxpGXtBj98RrTXqal9Dxz8llz06zLi75tUkwbJMWUERAKF1Q5AZaeb/q51YhAVli7har
	2GslQWoPN1SGmedB5gj5VVdQ0ZSlNVeLDvp8FCYP2Uo2nka8aBQVbRSQkPEw/BvmPLzwSjPC53oNE
	zs3zxV0w==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syZcv-000000052Id-1XRd
	for linux-nvme@lists.infradead.org;
	Wed, 09 Oct 2024 16:33:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9C8CE5C5C43;
	Wed,  9 Oct 2024 16:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB4AC4CECE;
	Wed,  9 Oct 2024 16:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728491604;
	bh=M6btTolh76HVzmN7RLg0DZyDN91b2PVf3tga8qZPrco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pYAt3AG/sBLUx5TIMXqf97+30L+fljnL1X04fJt5bKz9runNAfYu2qas9cAA7VVMQ
	 9h3G2rTaUiAHJT8kJguce3JKnF5Y8lBHlEyOaFyxtdNRYr0bFTNQffncV9LxCH759D
	 Hdk3BK1XnWwQ5L9OlodT69gGxMlwdr2mftUXWnkJg+vpx+gWK1sZo+1LkgRB+y8MBB
	 FguOUnn38Nxk7zddQ45fNViYUpz9SDqYVJGrhZbr2F+xJhGp9VJswbw8RJddoq2Ndv
	 oMTU73fuNBcCcWwOKDOnAc4b1pBVcKxGeU7tkfwIQpfK0i7ACES/2Cy1qJgltw02IC
	 59y43n43aBr/w==
Date: Wed, 9 Oct 2024 10:33:21 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/3] nvme-multipath: cannot disconnect controller on
 stuck partition scan
Message-ID: <ZwawUWskOwSRVoRB@kbusch-mbp>
References: <20241007100134.21104-1-hare@kernel.org>
 <20241007100134.21104-3-hare@kernel.org>
 <ZwQmK6dZ_goSQ4Cg@kbusch-mbp>
 <47968bf9-2b98-4e5e-9040-2db6f15d86a6@suse.de>
 <ZwWY8d3vOLUaYaJ6@kbusch-mbp>
 <3b8ff898-9529-4506-8c5d-0fcf3423730f@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b8ff898-9529-4506-8c5d-0fcf3423730f@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241009_173329_754551_B4E28A0E 
X-CRM114-Status: GOOD (  16.24  )
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

On Wed, Oct 09, 2024 at 08:23:45AM +0200, Hannes Reinecke wrote:
> On 10/8/24 22:41, Keith Busch wrote:
> > On Tue, Oct 08, 2024 at 09:17:47AM +0200, Hannes Reinecke wrote:
> > > Hmm. Sadly, not really. Still stuck in partition scanning.
> > > 
> > > Guess we'll need to check if we have paths available before triggering
> > > partition scan; let me check ...
> > 
> > I think you must have two paths, and the 2nd path cleared the suppress
> > bit before the 1st one finished its called to device_add_disk(). How
> > about this one?
> > 
> Nope. Still stuck, this time in bdev_disc_changed().
> With my testcase _all_ paths return NS_NOT_READY during partition scan, so
> I/O is constantly bounced between paths, and partition scan never returns.
> Doesn't matter where you call it, it's stuck.

Oh right... We need the requeue_work to end the bio's when the disk is
dead, but the work can't proceed because it's waiting on its own bio's.
Darn, I guess this scheme would need yet another work_queue to do it.
 
> The only chance we have is to modify I/O handling during scanning
> (cf my new patchset).

I hoped we could avoid special error handling paths, but I'll take
another look at that approach.

