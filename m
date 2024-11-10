Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E264D5E38F
	for <linux-nvme@archiver.kernel.org>; Sun, 10 Nov 2024 10:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/Gwd2Wu8HDE9PbfNUGcA9BUrviVIn8ooIi4vutwOAE0=; b=grDmXTMlCWdQPgGA5dEyLIBUIW
	uUmuea1KBSiD9QX1pfPbRLq/YFY/S06MwLgGw3w0n9+4pfuPBuTtLiFKJ6s8KymZR8+0GjDXFEqfR
	Xk9NSKZ5B/1Uzl8CsH6vmH1PE4UG6vIScsGqK/FQONI1YD3eX2IT2BEND8g3YXvRyW0JO0HVzw8rw
	4xcO15agQmPJwg6VFLAYter40iNR7AUp9ydcN5x0NixaqaW+BMrNj2j64hIooud8FB8Qe2VapoqeR
	Q7adIc3SAX12ZugbNPFhgxwj+2AkzRIyjCvsSms/C5hAzRclBMCf61k0YYfeU/CxNWc0/kmrV66JU
	rvuE8/Ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tA5O3-0000000Ei15-0oXX;
	Sun, 10 Nov 2024 10:41:43 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tA5Nz-0000000Ei0D-2v8r
	for linux-nvme@lists.infradead.org;
	Sun, 10 Nov 2024 10:41:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6235E5C2982;
	Sun, 10 Nov 2024 10:40:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A12DC4CECD;
	Sun, 10 Nov 2024 10:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731235297;
	bh=KJTVz52sJu2oQj0BOPzh46r/ng+VWSz4cJfy6f2DTow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JW8duPR4zgtshHYsGnyTHtlzUbI9C7VSu6DKWCkFGrApkoWJWSxhGLCw5xgUraK37
	 KyNCPb36UhLBki49PXkqcD2sBnsPb3pSEYoDPi+P4LFHLRa96gSHPosI6C7dqbYMip
	 vIVxA0qXAzTZEbJq1b7ufQuqLIfu45BQHuHyL9EX1PQY+YtgJ833g0BRQjd7iEAg3m
	 WndbNLaXlStjkG2lTw6sbX+1iBBO11XE41go4jd7Z15Ik1RN38Prs+eyzYb42sG812
	 MOTUu7mg3HBNZVbtRKgzK0VBiDj1HOzE5fnpSg4ms0Wa3VJ7O+NYsKsaWDPF/fo35+
	 lxhrXIwkV8nJA==
Date: Sun, 10 Nov 2024 12:41:30 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 09/17] docs: core-api: document the IOVA-based API
Message-ID: <20241110104130.GA19265@unreal>
References: <cover.1730298502.git.leon@kernel.org>
 <881ef0bcf9aa971e995fbdd00776c5140a7b5b3d.1730298502.git.leon@kernel.org>
 <87ttchwmde.fsf@trenco.lwn.net>
 <20241108200355.GC189042@unreal>
 <87h68hwkk8.fsf@trenco.lwn.net>
 <20241108202736.GD189042@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108202736.GD189042@unreal>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241110_024139_803485_447C8DAE 
X-CRM114-Status: GOOD (  20.78  )
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

On Fri, Nov 08, 2024 at 10:27:36PM +0200, Leon Romanovsky wrote:
> On Fri, Nov 08, 2024 at 01:13:27PM -0700, Jonathan Corbet wrote:
> > Leon Romanovsky <leon@kernel.org> writes:
> > 
> > >> So, I see that you have nice kernel-doc comments for these; why not just
> > >> pull them in here with a kernel-doc directive rather than duplicating
> > >> the information?
> > >
> > > Can I you please point me to commit/lore link/documentation with example
> > > of such directive and I will do it?
> > 
> > Documentation/doc-guide/kernel-doc.rst has all the information you need.
> > It could be as simple as replacing your inline descriptions with:
> > 
> >   .. kernel-doc:: drivers/iommu/dma-iommu.c
> >      :export:
> > 
> > That will pull in documentation for other, unrelated functions, though;
> > assuming you don't want those, something like:
> > 
> >   .. kernel-doc:: drivers/iommu/dma-iommu.c
> >      :identifiers: dma_iova_try_alloc dma_iova_free ...
> > 
> > Then do a docs build and see the nice results you get :)
> 
> Thanks for the explanation, will change it.

Jonathan,

I tried this today and the output (HTML) in the new section looks
so different from the rest of dma-api.rst that I lean to leave
the current doc implementation as is.

Thanks

> 
> > 
> > Thanks,
> > 
> > jon
> 

