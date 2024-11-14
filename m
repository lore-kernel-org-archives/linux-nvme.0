Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 143E2D68B37
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 16:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pa68lqpT9t03tKJrMbrnOoXYnDn6WYWNbU36odmGo84=; b=t1BFLp+x4A1Gg+AmYMLAkyZOhN
	84QSilx2FYU4E2IwjsyE0jN+kpyqxAO/oXzH3akyw78e6x8YpVrCxMpUhqYi2Cy5bF1ZUsgU74ODd
	ExUbtOc8tkEE000pJAFf+k7AciKiU4DHCSpGhbd8R1nSSX+rxyGYHs5vUYwvhlcd9DCrfz0qlvVZs
	FE8Fe3pmRay20uqRqRLJDZaP2xY/DpoknbWOEV21Fi8gxwGVbmj/npw7fjUuC9pDfRoWDTD6MZH+N
	9iw7Ge1+uyCd23TVLg5VyIonLaTtCiYDyKOUqaHaOI9OuVndNWwqR1QheOqmP1dXWX1tbmht0A2X4
	fCSXg7nA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBcqW-000000009u0-3qmY;
	Thu, 14 Nov 2024 16:37:28 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBcpc-000000009cE-1KIE
	for linux-nvme@bombadil.infradead.org;
	Thu, 14 Nov 2024 16:36:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Pa68lqpT9t03tKJrMbrnOoXYnDn6WYWNbU36odmGo84=; b=eFvAbKEObfT10QeFSue1CaWrc6
	0EHM1LWJNPPEv5jCSpn/kN5FH8VC9BFLCECjfBx/m0q1v9NN5VhNLKFjO11Sjwu9QrG/jz3Ur3mgu
	48Hwlyhw/6TK8W0yHxmXC6VVDWibObt/L7IL8W0RzZoldbqOu+HgUX3GzleQ7IRcbYDEigH1aZrTa
	i2G5f8YLJW8ERVlpUUAK0zBT3M8LllX6gFYXg4EJfHo1tm36EQMR+IXT8ukG/4hNBFqNmaIgBM8gJ
	K08ENS8sHwsOsbCVcjRV2wojRRQGX87sjLiFA+68sWxQ2Yj3NsUwU6bNEjmuqPvjnO81vP0oS92YQ
	a+r1at2w==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBcpY-000000007w5-1Cga
	for linux-nvme@lists.infradead.org;
	Thu, 14 Nov 2024 16:36:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A019B68C7B; Thu, 14 Nov 2024 17:36:22 +0100 (CET)
Date: Thu, 14 Nov 2024 17:36:22 +0100
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@ziepe.ca>,
	Joerg Roedel <joro@8bytes.org>, ill Deacon <will@kernel.org>,
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
	kvm@vger.kernel.org, linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3 00/17] Provide a new two step DMA mapping API
Message-ID: <20241114163622.GA3121@lst.de>
References: <cover.1731244445.git.leon@kernel.org> <20241112072040.GG71181@unreal> <20241114133011.GA606631@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114133011.GA606631@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241114_163628_552227_B4D30158 
X-CRM114-Status: GOOD (  17.72  )
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

On Thu, Nov 14, 2024 at 03:30:11PM +0200, Leon Romanovsky wrote:
> > All technical concerns were handled and this series is ready to be merged.
> > 
> > Robin, can you please Ack the dma-iommu patches?
> 
> I don't see any response, so my assumption is that this series is ready
> to be merged. Let's do it this cycle and save from us the burden of
> having dependencies between subsystems.

Slow down, please.  Nothing of this complexity is going to get merged
half a week before a release.

No changs to dma-iommu.c are going to get merged without an explicit
ACK from Robin, and while there is no 100% for the core dma-mapping
code I will also not merge anything that hasn't been resolved with
my most trusted reviewer first, not even code I wrote myself.


