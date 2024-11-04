Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4DCE6B27E
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2024 08:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tB/LiQ40UoTLjqNyC3Q67BQwJbkIipZmPo+T1Gw2Rdc=; b=QkcRRWHaxo0D6pxzG46o8uPuwD
	tLFsp+3MmezsJyHMrwqapPP9NikF3Lbxoczl4AG0nWTIVSGZZuTuLfR8oBLrhJw/OgWkUs/leNZpw
	JOv0K8Wm5gZX18V97jpWzCuCEGYWtglla5cvCo0gWtrt0gA5N3jb1wt5SGH8Zj0qxPPMNs/gljtOX
	ON4Mv2Xb2PIqSIqntc2SgGiCno2yeBD1IbskKdML1J7rIaxNxmKZRDqMtmu7qQALf7ej/51chZmA4
	0prbrW42wgKRpl6x8rgT1IkADEYFrT0CNVl8XB9f+5tUEF4PY+FPjw0KBqJCgR/9pPnxgz01IvwvR
	OvLSJtNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7ssr-0000000D2ic-1Urk;
	Mon, 04 Nov 2024 08:56:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7ssH-0000000D2Vj-0HaR
	for linux-nvme@lists.infradead.org;
	Mon, 04 Nov 2024 08:55:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8DFB9227AB0; Mon,  4 Nov 2024 09:55:45 +0100 (CET)
Date: Mon, 4 Nov 2024 09:55:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>,
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
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 2/7] block: don't merge different kinds of P2P
 transfers in a single bio
Message-ID: <20241104085545.GB24211@lst.de>
References: <cover.1730037261.git.leon@kernel.org> <34d44537a65aba6ede215a8ad882aeee028b423a.1730037261.git.leon@kernel.org> <d4378502-6bc2-4064-8c35-191738105406@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4378502-6bc2-4064-8c35-191738105406@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_005549_274360_2EB8345C 
X-CRM114-Status: GOOD (  16.86  )
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
>> +		/*
>> +		 * When doing ZONE_DEVICE-based P2P transfers, all pages in a
>> +		 * bio must be P2P pages from the same device.
>> +		 */
>> +		if ((bio->bi_opf & REQ_P2PDMA) &&
>> +		    !zone_device_pages_have_same_pgmap(bv->bv_page, page))
>> +			return 0;
>
> It's probably too late to change the "zone_device_" prefix into
> something that cannot be confused with a reference to zoned block
> devices?

It's too late and also wrong and also entirely out of scope for this
series.


