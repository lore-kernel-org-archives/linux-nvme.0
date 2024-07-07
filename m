Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DCFEC38150
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Jul 2024 12:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hNHblwrYdAraWq1495VRjKodRiN7gDYZRp6DQia8YVc=; b=zhfrnvunG2X2c79r6qqFDDajqB
	YGssHDHmdy6GjeKWD8RDpqnrY8KoQnMjcPvmEteCjScFXtdV5OV45RHNW/+Bot+76BKH9fligUVuU
	QQR8ONyN4P+BWZPua9crndCuL7PQnq0dxvHtndtK+SaHF30I89sEXjzU4PFsTVcpPtgyqEhF8Iydh
	vUK0GJI22NpmNzS8OXxbdweCt0fsDUvA2p3DHM6vM/I/4wq+TcNdLfJifDLEHZb3MRaAuyG9EMn0b
	S1lplICRM2/wh4fopoh//ohg2M2ReT9G0pzUS0vxMmBdcLLAbQjJBRh9dt+FHqS9/mKYdLv0iohFU
	gquMgsPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQRGh-00000001lCj-19ne;
	Sun, 07 Jul 2024 12:45:27 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQRGe-00000001lCH-1sse
	for linux-nvme@lists.infradead.org;
	Sun, 07 Jul 2024 12:45:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7B5C9601B5;
	Sun,  7 Jul 2024 12:45:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4BFC3277B;
	Sun,  7 Jul 2024 12:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720356323;
	bh=czFFfEBbR8ok8jHwfrliPjw/AEnBBl1bqvsRaPlne1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B5f9eRBl+KGgWT936EUGd6T+cWk+xRkiMuBWJ5KKIla4grwmOiaeeJlF3DZ+c3QZ1
	 tSTM7ND1gap34VnoYGF3pUZy6KttEu3a65c+wDFCySSopNt+JmgXnwEvrTb4r+G2TO
	 lLHSwl+otE7ipDb/K+1cBYw15NLZqlbxcA7JGZ8BdqyX9fOMxjVqh6eczfvqUO6ZFB
	 LsNV5y8I3AOqlFDmbuJQUcvxTH7HQvHKUXwJ9XePUW3qHZs3Y3iB6BMDK09x4Z1vXW
	 5t6O8jgD1hQCw70V39qXX5shMuw4oTYi+YCcq8o2BfTnfZAzxa3MG9D4jIC/OQYcEU
	 LchGoei8yUjUQ==
Date: Sun, 7 Jul 2024 15:45:18 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Keith Busch <kbusch@kernel.org>, "Zeng, Oak" <oak.zeng@intel.com>,
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
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [RFC PATCH v1 00/18] Provide a new two step DMA API mapping API
Message-ID: <20240707124518.GK6695@unreal>
References: <cover.1719909395.git.leon@kernel.org>
 <20240703054238.GA25366@lst.de>
 <20240703105253.GA95824@unreal>
 <20240703143530.GA30857@lst.de>
 <a7f1c69a-bbaf-4263-b2c2-3c92d65522c2@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7f1c69a-bbaf-4263-b2c2-3c92d65522c2@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240707_054524_614726_5FF4F942 
X-CRM114-Status: GOOD (  18.76  )
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

On Fri, Jul 05, 2024 at 10:53:06PM +0000, Chaitanya Kulkarni wrote:
> On 7/3/24 07:35, Christoph Hellwig wrote:
> > On Wed, Jul 03, 2024 at 01:52:53PM +0300, Leon Romanovsky wrote:
> >> On Wed, Jul 03, 2024 at 07:42:38AM +0200, Christoph Hellwig wrote:
> >>> I just tried to boot this on my usual qemu test setup with emulated
> >>> nvme devices, and it dead-loops with messages like this fairly late
> >>> in the boot cycle:
> >>>
> >>> [   43.826627] iommu: unaligned: iova 0xfff7e000 pa 0x000000010be33650 size 0x1000 min_pagesz 0x1000
> >>> [   43.826982] dma_mapping_error -12
> >>>
> >>> passing intel_iommu=off instead of intel_iommu=on (expectedly) makes
> >>> it go away.
> >> Can you please share your kernel command line and qemu?
> >> On my and Chaitanya setups it works fine.
> > qemu-system-x86_64 \
> >          -nographic \
> > 	-enable-kvm \
> > 	-m 6g \
> > 	-smp 4 \
> > 	-cpu host \
> > 	-M q35,kernel-irqchip=split \
> > 	-kernel arch/x86/boot/bzImage \
> > 	-append "root=/dev/vda console=ttyS0,115200n8 intel_iommu=on" \
> >          -device intel-iommu,intremap=on \
> > 	-device ioh3420,multifunction=on,bus=pcie.0,id=port9-0,addr=9.0,chassis=0 \	
> >          -blockdev driver=file,cache.direct=on,node-name=root,filename=/home/hch/images/bookworm.img \
> > 	-blockdev driver=host_device,cache.direct=on,node-name=test,filename=/dev/nvme0n1p4 \
> > 	-device virtio-blk,drive=root \
> > 	-device nvme,drive=test,serial=1234
> >
> 
> I tried to reproduce this issue somehow it is not reproducible.
> 
> I'll try again on Leon's setup on my Saturday night, to fix that
> case.

Chaitanya,

I added "mem_align=120" line to fio configuration file and the issue reproduced.

Thanks

> 
> -ck
> 
> 
> 

