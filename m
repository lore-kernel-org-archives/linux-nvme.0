Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98FEAC021AD
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Feb 2025 17:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rFMRQ3wm4kA2iwB2Aoi7k6mSyoggxB0bwv7xkFBlUPw=; b=2KTQWqjvXA5/yWzMxb1jz/TXn4
	UzrMb1kVKFGGEKITYb15rSwmIzUqHd+AA83197bPWK5hz76lShJmhtZI5e2dnYXYp4f0/dWd3Cjs3
	0EbDnzDtgl0PdcO2EZmT0VSwUhFE2CNOB+xjmUeVWbDMCz7eB3jlIJ6Lrxs8sv5YPk8BdhQ7otc64
	Vqj48AOQR36idB+VY/ATRLajBChdQzLhkQOovR2o9vZy/18nIt++VmlTE1GhEY6kYCghePZVmjYQ/
	7D3Pi9RTkm5P2vmxuNHHvDsH3zyVDoaeCq9Jk8I0Q5Z0qkCLbL1at0o0ZkdyUMdjkSRRZfg8hLWMW
	vw+t9ZPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkRHn-000000098lD-0KFk;
	Tue, 18 Feb 2025 17:21:31 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkRCM-000000097kR-0K9K
	for linux-nvme@lists.infradead.org;
	Tue, 18 Feb 2025 17:15:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 6267EA40515;
	Tue, 18 Feb 2025 17:14:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D962C4CEE4;
	Tue, 18 Feb 2025 17:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739898952;
	bh=3eIlP34WlArqtRnTtHJu9+tJUSkFehNJh8dOsjgkprA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S3kEZTp0Q0acAP9W4x+FC77xKmIL6vEnhmPYSEWhPZp5SLaP1w5j8tyK7bM8pH8h1
	 LxCsCB5Cb8lS8iy7OI/y0wJ+JW0Smuz9fEejIWv/EGqY6JVnElNra8s81f4PB8eMVf
	 ixqf+UvWEtTpGSLDfVVfiZSt69IACSOr3f6qsyFnbZG3KOjGHZJ9qya0YxK7gsac2s
	 DQxzGXE3tuJDKsRo1ayRGsKuWyqFKvMp1Pfl6yEEMZF5snhKOX44OWajed8Bd+yGyd
	 GdDZnCB40Wk7XH9QvL6mlTzW+/YYT2ixsi5QHsrYUPEF44GCCnl4rvGoTwUnzvJiAu
	 z7Di/Y0Jd9HPw==
Date: Tue, 18 Feb 2025 10:15:49 -0700
From: Keith Busch <kbusch@kernel.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: hch@lst.de, sagi@grimberg.me, bmarzins@redhat.com,
	Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
	axboe@kernel.dk
Subject: Re: [PATCH] nvme: remove multipath module parameter
Message-ID: <Z7TARX-tFY3mnuU7@kbusch-mbp>
References: <20250204211158.43126-1-bgurney@redhat.com>
 <7c588344-f019-4939-8a93-0a450481d4bc@redhat.com>
 <Z7Sh-3yHbXVmRbNL@kbusch-mbp>
 <8a1730a1-1faf-4722-99e1-c3a85257b6f4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a1730a1-1faf-4722-99e1-c3a85257b6f4@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_091554_239286_8DCF61B9 
X-CRM114-Status: GOOD (  29.96  )
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

On Tue, Feb 18, 2025 at 11:31:58AM -0500, John Meneghini wrote:
> On 2/18/25 10:06 AM, Keith Busch wrote:
> > On Thu, Feb 13, 2025 at 03:37:28PM -0500, John Meneghini wrote:
> > > Keith, Christoph and Sagi,
> > > 
> > > This patch has been fully tested and analyzed by Red Hat's QA group and no
> > > unexpected side effects or regressions have been found. Both NVMe/FC and NVMe/TCP
> > > have been tested. Our QE engineer has asked me to report this upstream.
> > 
> > What's the harm in leaving the parameter? *I* use it so I can test both
> > ways without needing to compile multiple kernels.
> 
> LOL.  We've been talking about this since 2017. The goal has always been to remove support for DMMP with NVMe.

I understand that disabling nvme native mp it is required for device
mapper, and I get you want to prevent the possibility of anyone using
dm-mp with nvme, but that isn't the only user that wants to see all
namespace paths.
 
> We want to remove this parameter because it is causing confusion with users and customers who keep trying to use
> DMMP with their multipath NVMe devices.
> 
> We want to remove this parameter because:
> 
> 1) the upstream kernel does not support multipath nvme devices without CONFIG_NVME_MULTIPATH enabled

What do you mean by "support"? I assume you mean no one upstream will
help you debug your problems if you've set yourself up that way, and
that's probably true. The kernel currently doesn't stop you from doing
this though, so it's supported in that sense. Some people are fine doing
this on their own, they're not seeking upstream help. Changing this
would break userspace because it makes the driver fail to create device
nodes that used to show up.

> 2) the upstream kernel does not support multipath nvme devices when core.nvme_multipath is set to N
> 3) Non-multipath nvme devies are supported just fine with core.nvme_multipath is set to Y
> 
> You don't need set core.nvme_multipath to N to test your devices both ways w/o recompiling the kernel.
> All of the code paths involved here are controlled by NVME_CTRL_CMIC_MULTI_CTRL and setting core.nvme_multipath
> to N doesn't do anything to help your single path NVMe devices. It doesn't remove multipath.c, reduce the code
> path length or do anything else to optimize your non-NVME_CTRL_CMIC_MULTI_CTRL devices.  All it does is provide
> an escape hatch to disable the incore multipath scheduler start creating multiple /dev/nvme%d/n%d entries so
> that DMMP can be used with multipath capable NVMe devices.
> 
> Personally, I'd like to remove CONFIG_NVME_MULTIPATH as well. It's just another source of confusion. Most users
> are running Linux with the the default settings for NVME_MULTIPATH. This is what Red Hat customers use and that's
> what's used upstream.  So what's the point?

There are devices that report CMIC and NMIC despite being single path,
perhaps as some vestigial sr-iov feature. That adds an unnecessary layer
for all IO to go through. Having the param makes it easy to test both
possible driver paths. In production though, I'd expect to just disable
the CONFIG option if that's the behavior someoone wants, so I think the
config option ought to stay.

