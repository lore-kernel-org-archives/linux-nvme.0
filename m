Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2BAED64084
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2024 20:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SuBwPflD5x1FjpVUqJMUPA8ij7fI5LEtqf+PEDxGKHw=; b=zb5PPSkcTinTHcNlRkuwsEY6Kq
	H7Rybf4WH3hvu/NA9COjfDS/efYw2XF0zAHP4F+v1losBq0Lp9Mk0eKxC3I8Kl3clga9GY5+JmE8D
	Q3c3ziVsHM1YqqyTFQS4R7TH+VGC2r98/6egtx8UvdEq7TIp9pSQIUZvifDFG4ZlW1bnx9vxxeG+8
	ZcEMC/Hyq6pGzuq94JP9AAmcju3lNRR9UaWN8uSxPStdyS7WwfjtAOo/uofjzDjY3fmFEqUcVgNnW
	vHN0t7cz1t9mJ/13cmFUNwLpWgU70Sod0bfulJNn4zkJeELJ9DTwn6EsZODfvuvXrXJ+CahWtDXBs
	0ov2gntw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9Va8-0000000BtFT-0SwG;
	Fri, 08 Nov 2024 20:27:48 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9Va4-0000000BtEh-2DiB
	for linux-nvme@lists.infradead.org;
	Fri, 08 Nov 2024 20:27:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C15AB5C5E1C;
	Fri,  8 Nov 2024 20:26:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34E3C4CEEF;
	Fri,  8 Nov 2024 20:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731097662;
	bh=fEkKlC8Hg48yKdWPTMBAlRN6pz1/ghsdZabweHXbhzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kQxdbUUkl22MhYJ7DwatoeDKWjNx/F1CJZOuLcFdp7LQvaPdVdHti+/hn/sheWd1+
	 CgCPfKci9ZZtTsEivm1eh8hhse4OzQu82g9Eo+eLUOy0LlG3gmIHJFv6Czp1bMK3OQ
	 67ei1ypM2zP7JkXKKaBNvFhdvLTvyEXfpc2fQrzlvSNPP8INjRX4G++0yeANG1bnXI
	 vaDXlNFUIih+7l1wn1ZT8Zma+fi2I1SHUMIr3fOWOVKVI9GXzLI4dcX1J17510r/kq
	 Ynakuwz3YuW6CL+ZtvWHtcGl1MD/ZSDtjDLhq8q6xZLi9xuaOGnDyb6OWJu4ygrF/P
	 Z/t2NqXY6f9Pw==
Date: Fri, 8 Nov 2024 22:27:36 +0200
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
Message-ID: <20241108202736.GD189042@unreal>
References: <cover.1730298502.git.leon@kernel.org>
 <881ef0bcf9aa971e995fbdd00776c5140a7b5b3d.1730298502.git.leon@kernel.org>
 <87ttchwmde.fsf@trenco.lwn.net>
 <20241108200355.GC189042@unreal>
 <87h68hwkk8.fsf@trenco.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h68hwkk8.fsf@trenco.lwn.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241108_122744_629418_2907CFB6 
X-CRM114-Status: GOOD (  16.23  )
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

On Fri, Nov 08, 2024 at 01:13:27PM -0700, Jonathan Corbet wrote:
> Leon Romanovsky <leon@kernel.org> writes:
> 
> >> So, I see that you have nice kernel-doc comments for these; why not just
> >> pull them in here with a kernel-doc directive rather than duplicating
> >> the information?
> >
> > Can I you please point me to commit/lore link/documentation with example
> > of such directive and I will do it?
> 
> Documentation/doc-guide/kernel-doc.rst has all the information you need.
> It could be as simple as replacing your inline descriptions with:
> 
>   .. kernel-doc:: drivers/iommu/dma-iommu.c
>      :export:
> 
> That will pull in documentation for other, unrelated functions, though;
> assuming you don't want those, something like:
> 
>   .. kernel-doc:: drivers/iommu/dma-iommu.c
>      :identifiers: dma_iova_try_alloc dma_iova_free ...
> 
> Then do a docs build and see the nice results you get :)

Thanks for the explanation, will change it.

> 
> Thanks,
> 
> jon

