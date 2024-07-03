Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D75C2BD09
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jul 2024 14:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MjGjVMn9WF3xLky3I9fG5D10KjXc7Z54E9jILWGvrLc=; b=YKCzpQxeIREK8Uk7R2vEM4f1jM
	kTBmcC4pAFvAD/k2/iGbooT+UVGSSlW3KbpJhqYIRjqxA1yhLbHQrqM0GSGQ/uO8N2VaAlrckhmce
	AzGY4+/lcLyaGgmwtnMuA8JGbRcFMnMM9ClZZwv46fc+/UPwZFrtusihBoXdzW9U/lMoQAS+LWadL
	YndBVqBr8UplUNi/GFo3zHqpItRNH0c9u5xsmF/4Kc5BzDuF71CMHV2xElicgwkRwcN+eabT6yGOR
	lgRquxsL0029g7bjR44sfZcVQn1cjkAMTXdFRckYs9l+BwOWFh/OQjVIt+Z/DyWWNrXFCS/xRJemn
	+ilD75yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP15D-0000000AUNe-15IQ;
	Wed, 03 Jul 2024 14:35:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP159-0000000AULw-2lkZ
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jul 2024 14:35:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D1D0E68AFE; Wed,  3 Jul 2024 16:35:30 +0200 (CEST)
Date: Wed, 3 Jul 2024 16:35:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Keith Busch <kbusch@kernel.org>, "Zeng, Oak" <oak.zeng@intel.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 00/18] Provide a new two step DMA API mapping API
Message-ID: <20240703143530.GA30857@lst.de>
References: <cover.1719909395.git.leon@kernel.org> <20240703054238.GA25366@lst.de> <20240703105253.GA95824@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703105253.GA95824@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_073539_870189_F5953018 
X-CRM114-Status: GOOD (  18.27  )
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

On Wed, Jul 03, 2024 at 01:52:53PM +0300, Leon Romanovsky wrote:
> On Wed, Jul 03, 2024 at 07:42:38AM +0200, Christoph Hellwig wrote:
> > I just tried to boot this on my usual qemu test setup with emulated
> > nvme devices, and it dead-loops with messages like this fairly late
> > in the boot cycle:
> > 
> > [   43.826627] iommu: unaligned: iova 0xfff7e000 pa 0x000000010be33650 size 0x1000 min_pagesz 0x1000
> > [   43.826982] dma_mapping_error -12
> > 
> > passing intel_iommu=off instead of intel_iommu=on (expectedly) makes
> > it go away.
> 
> Can you please share your kernel command line and qemu?
> On my and Chaitanya setups it works fine.

qemu-system-x86_64 \
        -nographic \
	-enable-kvm \
	-m 6g \
	-smp 4 \
	-cpu host \
	-M q35,kernel-irqchip=split \
	-kernel arch/x86/boot/bzImage \
	-append "root=/dev/vda console=ttyS0,115200n8 intel_iommu=on" \
        -device intel-iommu,intremap=on \
	-device ioh3420,multifunction=on,bus=pcie.0,id=port9-0,addr=9.0,chassis=0 \	
        -blockdev driver=file,cache.direct=on,node-name=root,filename=/home/hch/images/bookworm.img \
	-blockdev driver=host_device,cache.direct=on,node-name=test,filename=/dev/nvme0n1p4 \
	-device virtio-blk,drive=root \
	-device nvme,drive=test,serial=1234


