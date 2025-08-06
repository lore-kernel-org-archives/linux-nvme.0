Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7BE3C87FCB
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Aug 2025 15:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H93/RoL+q1dDsEO2+8xRLt+W2l5SvA7kIAjuP3XmIvw=; b=kDzveZAa0JcPIq+evJg/iFurAu
	+9FrcLIpkG5LTkd7YxuATf3Hm14gFMRwlJ2r8vV6SxXQzWEBd/Aut+J/Q01oD/Ojg1opYUtKxBmiA
	oOvV6DseFS9VhyloIKw1VCePfgYeMK2ptL9ArKV50q/VfUwlexdw/QJPWmPT/jAEBSvoXOI8MY9nD
	JOBFDaS6P4546T+jOQKDMHz5kwayAFAYwEDAhe/Kw2yI/C405Dy6aszjjHpD/MBibdoBKQWp7zGJZ
	HBECbw98dBPP8DGaZ10Ci3m3j+1H5BQg8ujeU4Aa7etaD8dpzmF///SPRKmNqJSvgQ2WTdy23Sore
	KC3r1aPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujfix-0000000FXlT-1b7N;
	Wed, 06 Aug 2025 15:06:39 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujfh7-0000000FXLB-2mvO
	for linux-nvme@lists.infradead.org;
	Wed, 06 Aug 2025 15:04:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 395615C693F;
	Wed,  6 Aug 2025 15:04:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F8FC4CEE7;
	Wed,  6 Aug 2025 15:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754492682;
	bh=UYqCNGyT3EmjFK3mZkAylSZ+X76TSycu9O7yKJ+mh1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iph8x/TOWRyaus5Uiz2WYsGsEI/z2wj2GYEEkcKdS7FmhUa06ENCuHrYm8EKOAmGR
	 UY5mcKrLIZ0gjz3+wex3oapU0/VAdHY1bnohB9Z5VUbehAP6MTj/IBLQws9veijsG2
	 /G+qZKzVx/NDN9cc6d7TYLjN9fovgDG0AFDYvfsF7gZecxUPwgUg/WhlqrNBHAS4Ud
	 UXdJ+/3aExPbrFv++2LYJxW09iTxoizP0M5B6H7Is6QMiROW/BFlWpHPV84SWWstEb
	 DcJAucdFZ5+Dg6aLoUqvzRY7yYWCmxyP0ewb2kYr1/NpeLGmegDyKriw3f8YmeOJTL
	 9oY9SLVgfuMOg==
Date: Wed, 6 Aug 2025 09:04:40 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk
Subject: Re: [PATCH 2/2] nvme: remove virtual boundary for sgl capable devices
Message-ID: <aJNvCOZeiah3jeMR@kbusch-mbp>
References: <20250805195608.2379107-1-kbusch@meta.com>
 <20250805195608.2379107-2-kbusch@meta.com>
 <20250806145514.GB20102@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806145514.GB20102@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250806_080445_740071_78DBAE20 
X-CRM114-Status: GOOD (  17.75  )
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

On Wed, Aug 06, 2025 at 04:55:14PM +0200, Christoph Hellwig wrote:
> On Tue, Aug 05, 2025 at 12:56:08PM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > The nvme virtual boundary is only for the PRP format. Devices that can
> > use the SGL format don't need it for IO queues. Drop reporting it for
> > such PCIe devices; fabrics target will continue to use the limit.
> 
> That's not quite true any more as of 6.17.  We now also rely it for
> efficiently mapping multiple segments into a single IOMMU mapping.
> So by not enforcing it for IOMMU mode.  In many cases we're better
> off splitting I/O rather forcing a non-optimized IOMMU mapping.

Patch 1 removes the reliance on the virt boundary for the IOMMU. This
makes it possible for NVMe to use this optimization on ARM64 SMMU, which
we saw earlier can come in a larger granularity than NVMe's. Without
patch 1, NVMe could never use that optimization on such an architecture,
but now it can applications that choose to subscribe to that alignment.

This patch, though, is more about being able to utilize user space
buffers directly that can not be split into any valid IO's. This is
possible now with patch one not relying on the virt boundary for IOMMU
optimizations. In truth, for my use case, the IOMMU is either set to off
or passthrough, so that optimzation isn't reachable. The use case I'm
going for is taking zero-copy receive buffers from a network device and
directly using them for storage IO. The user data doesn't arrive in
nicely aligned segments from there.

