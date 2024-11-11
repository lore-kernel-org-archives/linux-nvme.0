Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6C9D12D78
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2024 06:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cOb277arSCKCjUv25YUtltHFeCBKt9wBpzLvkC59Bac=; b=R4aOeQsaS8h/9PfjvvOeM/AIJt
	6xG6uy/M3YtIRGIHiXVCU2dILDKZmg+rQmM9XJf0NmJNccPSuRjF1CRXfAPG0W/mvozoQnmK+J+1l
	SaB0RUO2CTOk9F5fxLhepS6gfISGYutJDTrX+Y0QzyKXg4zco+QgFlwkLrKq/Tw/RU2lA26t2nzeb
	0H013kHAQ8ifKHRlSjXAK8evUWCP8wGo65/J2qIogMXrPXBq7SlcoQa0u1Jd10W5mM+qEmVtwp3yi
	bbj+MuWKPtZq6vwylV7/mbuHMyLe0iRPcrtmqKpU99q/84SLyyxSWIQX/lKseghfA30HEaMQYn+EO
	Dr5VvchA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAO4f-0000000GVX4-0WSx;
	Mon, 11 Nov 2024 06:38:57 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAO4b-0000000GVWf-3PJH
	for linux-nvme@lists.infradead.org;
	Mon, 11 Nov 2024 06:38:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 93F2A68C7B; Mon, 11 Nov 2024 07:38:47 +0100 (CET)
Date: Mon, 11 Nov 2024 07:38:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
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
Message-ID: <20241111063847.GB23992@lst.de>
References: <cover.1730298502.git.leon@kernel.org> <881ef0bcf9aa971e995fbdd00776c5140a7b5b3d.1730298502.git.leon@kernel.org> <87ttchwmde.fsf@trenco.lwn.net> <20241108200355.GC189042@unreal> <87h68hwkk8.fsf@trenco.lwn.net> <20241108202736.GD189042@unreal> <20241110104130.GA19265@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241110104130.GA19265@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241110_223854_018528_2E4A477C 
X-CRM114-Status: GOOD (  14.10  )
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

On Sun, Nov 10, 2024 at 12:41:30PM +0200, Leon Romanovsky wrote:
> I tried this today and the output (HTML) in the new section looks
> so different from the rest of dma-api.rst that I lean to leave
> the current doc implementation as is.

Yeah.  The whole DMA API documentation shows it's age and could use
a major revamp, but for now I'd prefer to stick to the way it is done.

If we have any volunteers for bringing it up to standards I'd be glad
to help with input and review.


