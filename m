Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B194C3DA4A
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 14:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r+FwOLpkfRRdP7sahhwbAXUb6SK7eA2OSUN+DrdC9T0=; b=l5ZYqLsW/KigBZufgMlz3ve5if
	U9ZRM8yBh2piHMfcL2NgpELnotsISVxNWfAqW0flB703GrtOQWn5KV++knF2UrS6qcqYhjUfMVLwF
	R22m5inO0CavVYrUmQaUcK9m2TsByxcYhUvOtW0Xs/oB/UHDuxYukEdSF7ooFC38uNx/Pwf++xlIN
	TAIkfEkjH0KpjyOk4f9GMRes9uVGvk5tOYMC6cTKr1Wms/JK54StUn4vhf2YPqrrmICznrVEDc7DF
	2nUczw8PzyI9prgT8NuMB6IxOx6HDHEStiZH2uyrcOEN6YZgzK7G+kxJlRf49gIXIN+kxBVxWl7if
	Gq0Lq/Ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7EjB-00000007Wbu-2T98;
	Tue, 22 Apr 2025 14:36:01 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u776s-00000005xDS-2mS9
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 06:28:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id AA1105C5967;
	Tue, 22 Apr 2025 06:25:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B52C4CEED;
	Tue, 22 Apr 2025 06:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745303277;
	bh=K/UAYNGW+EGbI1H04eX8UxOvRa4n5wUxixuO/0uoGJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QW0rpbcaMDKlHGvmZFs7EWfVYZTF2SFlCR50sPjI+BZbZ+rHRKg33QAuRqAlmeKwl
	 hw7/8EB+Yc0MAW3Qcc2No4o//tS1EIta9xnfM9gwive45sVzdc1MfufZEM0Je7cU3m
	 aXN/RYcmHmsTtDrU6rhjAoII86M7gR1jEbLMKaR9rTZKG93G7wFS8Bjt72MK3PgKrb
	 X182oDyajkgEYMC5steH0iQSzN8PjLNC22mBrm580ovmf0wwFTcBd93ktJ5YL0a7IO
	 bXn39Vspt4zw+2SnWqR9Y2E16qv8ASf3RlJw/1bovKeC3C1ijPotmMOhEnBsDMenV+
	 mMzYy0qavmPEA==
Date: Tue, 22 Apr 2025 09:27:52 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Jake Edge <jake@lwn.net>, Jonathan Corbet <corbet@lwn.net>,
	Jason Gunthorpe <jgg@ziepe.ca>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v8 04/24] iommu: add kernel-doc for iommu_unmap and
 iommu_unmap_fast
Message-ID: <20250422062752.GA48485@unreal>
References: <cover.1744825142.git.leon@kernel.org>
 <d3ad1e84d896aea97ebbd01c414fb1f07dc791d3.1744825142.git.leon@kernel.org>
 <20250422042330.GA27723@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422042330.GA27723@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250421_232758_753421_E6021382 
X-CRM114-Status: GOOD (  12.93  )
X-Mailman-Approved-At: Tue, 22 Apr 2025 07:26:59 -0700
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

On Tue, Apr 22, 2025 at 06:23:30AM +0200, Christoph Hellwig wrote:
> On Fri, Apr 18, 2025 at 09:47:34AM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Add kernel-doc section for iommu_unmap and iommu_unmap_fast to document
> > existing limitation of underlying functions which can't split individual
> > ranges.
> 
> This actually only adds kerneldoc to iommu_unmap_fast.

Thanks, Jason documented iommu_unmap in this patch.
https://lore.kernel.org/r/3-v3-b3a5b5937f56+7bb-arm_no_split_jgg@nvidia.com

I'll update the commit message.

