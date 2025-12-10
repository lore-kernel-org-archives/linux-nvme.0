Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9993D3C52A
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Dec 2025 11:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ErKLI5Jg7IXUgWVfhNQQNs0mgrgy9aPnv0Wg8I3UlEs=; b=EsQEwddNFyzcksiSaSxy+SikZn
	gabdUUB++65Lw6fEO6aOCJ2zlRPH6NLs8yOmCTrNHFlEPQ/Awd9hWohYDjGGjnZuEbgv4iFR18jm6
	S8kCVDf4Y/nnqhPZcBFOK485/M/gt/K+ZKDPJ9Mh/R6m24ubhWsiCGytC2Xa19OKxfUyvbpZw4oma
	JmdcJ+TyG4c06vuMS/OZvLHhYZEH0Q1XQrfLp7sqS8WO9u6wORzsELKjxXJSgYprV8nXesBmk6G5b
	Mb0c/Ak8qTBlOJRrizL46oRLVPLN1MVivOSczLyvq3MtAR1LYxhs5luHv6LN4GZPNx8ISpgRkZtfw
	S/WV+uew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTIGJ-0000000FN9F-0U6T;
	Wed, 10 Dec 2025 11:21:39 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTIGH-0000000FN95-0HPN
	for linux-nvme@lists.infradead.org;
	Wed, 10 Dec 2025 11:21:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9A849600AC;
	Wed, 10 Dec 2025 11:21:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538DBC4CEF1;
	Wed, 10 Dec 2025 11:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765365695;
	bh=02TJf16fnJk3ighp6vgdi/0FMeoZ8SlIQNCacUajNgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qVwGVVZpPeY58SfN5rAE+y4vep7KmrLCjyhECcDA/28CraNn3LqLDFaAtH5r2cPhV
	 VY8i0KcS02ZfXJGzmXCxFKclwNhiZbedhrtb7GeLcF8KmNAbbIL7Z+tsTfNs2xF/hm
	 gcTOb4e85Q7y6gl7wJjXOrd2QLggNdZ670UirSSgeBNfkMfbYWmkxTJV4/BuP4upOp
	 drToIyNGT4CAiuR3mGqXiSsvqESoeHtNNeTD8DiuTUEwJgBGfKfuKiOAqxwE7wK9Q/
	 nzNrN9kg2CoFgi4OFX5nwkkyJwdVd3CxxC66L9dxKsDKAPuialzI83fK7Lkh8M8L3d
	 xgGkj+6BO8qWQ==
Date: Wed, 10 Dec 2025 20:21:30 +0900
From: Keith Busch <kbusch@kernel.org>
To: Sebastian Ott <sebott@redhat.com>
Cc: linux-nvme@lists.infradead.org, iommu@lists.linux.dev,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Carlos Maiolino <cem@kernel.org>
Subject: Re: WARNING: drivers/iommu/io-pgtable-arm.c:639
Message-ID: <aTlXuhmsil7YFKTR@kbusch-mbp>
References: <170120f7-dd2c-4d2a-d6fc-ac4c82afefd7@redhat.com>
 <aTj-8-_tHHY7q5C0@kbusch-mbp>
 <acb053b0-fc08-91c6-c166-eebf26b5987e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acb053b0-fc08-91c6-c166-eebf26b5987e@redhat.com>
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

On Wed, Dec 10, 2025 at 12:08:36PM +0100, Sebastian Ott wrote:
> On Wed, 10 Dec 2025, Keith Busch wrote:
> > On Tue, Dec 09, 2025 at 12:43:31PM +0100, Sebastian Ott wrote:
> > > got the following warning after a kernel update on Thurstday, leading to a
> > > panic and fs corruption. I didn't capture the first warning but I'm pretty
> > > sure it was the same. It's reproducible but I didn't bisect since it
> > > borked my fs. The only hint I can give is that v6.18 worked. Is this a
> > > known issue? Anything I should try?
> > 
> > Could you check if your nvme device supports SGLs? There are some new
> > features in 6.19 that would allow merging IO that wouldn't have happened
> > before. You can check from command line:
> > 
> >  # nvme id-ctrl /dev/nvme0 | grep sgl
> 
> # nvme id-ctrl /dev/nvme0n1 | grep sgl
> sgls      : 0xf0002

Oh neat, so you *do* support SGL. Not that it was required as arm64
can support iommu granularities larger than the NVMe PRP unit, so the
bug was possible to hit in either case for you (assuming the smmu was
configured with 64k io page size).

Anyway, thanks for the report, and sorry for the fs trouble the bug
caused you. I'm working on a blktest to specifically target this
condition so we don't regress again. I just need to make sure to run it
on a system with iommu enabled (usually it's off on my test machine).

