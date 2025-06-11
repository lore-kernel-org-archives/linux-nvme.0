Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9612EC71136
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jun 2025 19:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u7+UpXu/0UFZE/KEqrA6/hNwCVSWr1UNw4PH8/oK7iE=; b=vZ7YJK/U/vJRiIja/9CaqmzY1N
	6AVN5m1z7ZJfA7L9pwUTpvpqMlAprgU84uVvWUMD6GDqVM0grJKMT9KDDt//wlkF3hTs5jCFp04MK
	72EmBehzZ/gKcEs6UaZJpYgfGKPxYcmx4Nrxyq5BPYxIvreYSwBxsM/Rbv05fMr9Jm9Lb1GKSmvw/
	t7tnz8AiKBxMOrowWrTca+h4tPOeZshLS5O3kO5DYel62yHfMMBdJMGDFmQ/ccDEoWeN6EhbonBZt
	onvqcR5nym6sg5MlZhPmjmNmNF1RGarbQ4pRxzOKgC1+OPSlf/hUY6vCkDqvRwpD3EGzmrYxPRjkn
	BKSsMegQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPRZ2-0000000B5DR-2Opa;
	Wed, 11 Jun 2025 19:56:48 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPOVh-0000000AdsE-1t63
	for linux-nvme@lists.infradead.org;
	Wed, 11 Jun 2025 16:41:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id AFA126154F;
	Wed, 11 Jun 2025 16:41:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A548BC4CEE3;
	Wed, 11 Jun 2025 16:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749660066;
	bh=jt3O5IPQHNammy3/MrnhUEdQ/0Oy5mhawihvpVMuoyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P6ci2n/CZ2HGKJ+ktuqs22I3wHoDuPwE4Uuv1oF86ldfKSPpkZIIN42DWBIqHUWZ3
	 v4jm68qNpnLzq2fNKdcQvlQ/V4lARwMPAPXoqNVkY9TUNgSSYDmLSR1QM2zXsSc9Go
	 ax/NNTTrqTny0QKqRYiijnpk8NO4v8SVlntffrzy7J6kiliclqL2H2vAYCzyXaL8pq
	 Tw2hfaJb7yXml5ff2MK7n8887f+FzS8Nq7pFFg6NHrZS4qvbUzJy00EC1ZvmhnoLz1
	 Nsr24m7oh1IJHfmGJoRmC83bZdtbMq4CVxwuEcSBfhKhWY0uHF3rROVyXXbKoKISxL
	 b7iF2y8yMFkRw==
Date: Wed, 11 Jun 2025 10:41:03 -0600
From: Keith Busch <kbusch@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/9] block: don't merge different kinds of P2P transfers
 in a single bio
Message-ID: <aEmxn0K6m34HsZeN@kbusch-mbp>
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-2-hch@lst.de>
 <aEhROl2D89kFX8C7@kbusch-mbp>
 <20250611034316.GA2869@lst.de>
 <aEmuG1dUDGuci7VW@kbusch-mbp>
 <5cddbda3-02bd-4dc1-9f7f-197279da6279@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cddbda3-02bd-4dc1-9f7f-197279da6279@deltatee.com>
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

On Wed, Jun 11, 2025 at 10:39:17AM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2025-06-11 10:26, Keith Busch wrote:
> > If I recall correctly, the PCIe ACS features will default redirect
> > everything up to the root-complex when you have the IOMMU on. A device
> > can set its memory request TLP's Address Type field to have the switch
> > direct the transaction directly to a peer device instead, but how does
> > the nvme device know how to set the it memory request's AT field?
> > There's nothing that says a command's addresses are untranslated IOVAs
> > vs translated peer addresses, right?  Lacking some mechanism to specify
> > what kind of address the nvme controller is dealing with, wouldn't you
> > be forced to map peer addresses with the IOMMU, having P2P transactions
> > make a round trip through it only using mapped IOVAs?
> 
> That is all correct. In order to use P2P on a switch, with the IOMMU
> enabled, it is currently required to disable ACS for the devices in
> question. This is done with the command line parameter disable_acs_redir
> or config_acs.

Is there some other mechansim that ensures a host memory mapped IOVA
doesn't collide with a PCI bus address then?

