Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2413DE6B278
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Nov 2024 14:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aCursz3mmtrcUPW/QvYFU4szIN1SR2q2jGdUimroVho=; b=HrzlhoqOIDQA/rk6D+OveQJdB8
	XUbfbvudi1Vc3by/5a0ZnKGfnRl3ZbeGGnwYTRVP0fI/n7UxrOC2gMDXkGuEBUWx4RaOy12pBm8yL
	Weoooz15xDpWTPq/FnsJVFeSGvVzJS6GFMqrpCW0UXC333wK7oitH56/94yPkHj5JsDpFhv6UG3iE
	7gTsGqkw4IHB6rOvLYpLUdp4CiXZb15FUbIK7NcM2RbngL2kQw6Qht1r3hOn0ToyahG0usmcrdjBO
	zet3z+CJmXUwsFU3t5/mMLo8OFoXjpVUg9X1jusGGn8uwYNKJbMftXU2QbZ6cAIbBzMak6j5ohvQy
	wmcrOXZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6sMg-00000007Hi5-0MJb;
	Fri, 01 Nov 2024 14:11:02 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6s6B-00000007EiN-3zmO
	for linux-nvme@lists.infradead.org;
	Fri, 01 Nov 2024 13:54:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id F3B715CB7CF;
	Fri,  1 Nov 2024 06:10:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71BBC4CECD;
	Fri,  1 Nov 2024 06:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730441481;
	bh=xuvDhMPsSnRBldbb9zqlIWoH9RpyHnNr2U6kz9Sckdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GxotyBrgjRANc5p7HrsCLBXgaj4HLa5WC8j/hwfVk4KJAdkHmExC7kSQTYNp89ILA
	 Yx2fbg2gbC1Wjyn01FDcCrk577MzfB5np9DJobJUCMYKqeBjjKbyJl4ye3AMAvF9/M
	 eWLWv6oFnkXuCdVlONIFHy4LNALMfsWKyHZrQE/pe6g5rPZdzyyrOB4cB2hoNjYS79
	 lqHPB1G+uBa5evs4A6a/506EDsJ0Nq/l3fddVEF8YAVmp1SK1vnA6Z0/l70YE3mAJc
	 C3wKq7ppvuxcUZM3NDVqxKZW+swjVBkdxdhk2qeZWESspprkV0FeKW4hemHsE21yeg
	 a8+9J8MNFi77A==
Date: Fri, 1 Nov 2024 08:11:16 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
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
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 2/7] block: don't merge different kinds of P2P
 transfers in a single bio
Message-ID: <20241101061116.GC88858@unreal>
References: <cover.1730037261.git.leon@kernel.org>
 <34d44537a65aba6ede215a8ad882aeee028b423a.1730037261.git.leon@kernel.org>
 <d4378502-6bc2-4064-8c35-191738105406@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4378502-6bc2-4064-8c35-191738105406@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241101_065400_058711_B9ACF4ED 
X-CRM114-Status: GOOD (  18.00  )
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

On Thu, Oct 31, 2024 at 01:58:37PM -0700, Bart Van Assche wrote:
> On 10/27/24 7:21 AM, Leon Romanovsky wrote:
> > +		/*
> > +		 * When doing ZONE_DEVICE-based P2P transfers, all pages in a
> > +		 * bio must be P2P pages from the same device.
> > +		 */
> > +		if ((bio->bi_opf & REQ_P2PDMA) &&
> > +		    !zone_device_pages_have_same_pgmap(bv->bv_page, page))
> > +			return 0;
> 
> It's probably too late to change the "zone_device_" prefix into
> something that cannot be confused with a reference to zoned block
> devices?

It is never too late to send a patch which renames the names, but it needs
to be worth it. However it is hard to see global benefit from zone_device_* rename.
ZONE_DEVICE is a well known term in the kernel and it is used all other places
in the kernel.

Thanks

> 
> Thanks,
> 
> Bart.
> 

