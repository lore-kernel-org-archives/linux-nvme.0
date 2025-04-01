Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2101AC36014
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Apr 2025 07:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gntbv8PkI3XRCr/Ll5QirjrHZcm9trf1F915DpwNZuk=; b=1lS1CbYRts0FSNGdqSIU/DdAiv
	lJC+OCwWp+i/0ZGbkeHSIoDJbMomGwkJejPkD6kA4cTNrqxVMTatSxCX0KT/djO4MG6iZOtJUIMtF
	9XsPN1WwszbBFNIt5cLu79xamvfXujfsgy1jxEoK5GHzbiQeVvxzXrIcRvSAjN8E4mRMnB+DsOq9g
	zs4b9waikX+uP2FQ3tLQfIhp6Tc5pazgzN6U6LLvBjGR8e5UBMOJo3l9vzVMDG+SB1wDWTPlSHEbq
	c3KWcNzPv+cpCdaNqtqYc20XLOzeB5jMKZfmG+bPljllBL9+jkn7qCt0tuyyrhp0GcwQhIjycAKg9
	1bRg0eaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzWIT-00000002Dv5-1atD;
	Tue, 01 Apr 2025 07:44:33 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzQ8A-00000001hwj-2WBC
	for linux-nvme@lists.infradead.org;
	Tue, 01 Apr 2025 01:09:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A66A45C10B8;
	Tue,  1 Apr 2025 01:07:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978F4C4CEE3;
	Tue,  1 Apr 2025 01:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743469769;
	bh=xnDKz4hdm/kkZqcWSzvYO96l5CqeHbCretys4W9iu2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ce0nhRfsh4foP8kliSiSC0eCyy1P530wNZv1yXlz0fhnntdzc2pHj8ehJ73sKloVM
	 C0cw7cUj+BIc9kmwIU3OVnx2X/5KZolUkXS2nrcBmOD80XEOnwWEu+qaNld4IC1Lbz
	 ktTwM4BKKx5FIv7O9NfsPq2v7mz23KDqI6mFjPh6003pPohStRGfOcfyHzqdAMOVmD
	 1gOusmiwUbvZzBP/fZDRftY7IT+SckUkPyIVGM5JFjlw/2fk+9/Ns880REt1nFz5Or
	 pRuSFvVxXKUnth/AX3auD+qu9VK2N7OyoDzrtCOl5aOlD0WNxZyXTU1dmfK4K2DInq
	 5BLO5MT41pJgw==
Date: Mon, 31 Mar 2025 18:09:27 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Leon Romanovsky <leon@kernel.org>, Daniel Gomez <da.gomez@samsung.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
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
Subject: Re: [PATCH v7 00/17] Provide a new two step DMA mapping API
Message-ID: <Z-s8x_YyGEYTz8BJ@bombadil.infradead.org>
References: <cover.1738765879.git.leonro@nvidia.com>
 <20250220124827.GR53094@unreal>
 <1166a5f5-23cc-4cce-ba40-5e10ad2606de@arm.com>
 <20250302085717.GO53094@unreal>
 <e024fe3d-bddf-4006-8535-656fd0a3fada@arm.com>
 <Z+KjVVpPttE3Ci62@ziepe.ca>
 <20250325144158.GA4558@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325144158.GA4558@unreal>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250331_180930_702386_36DB6523 
X-CRM114-Status: GOOD (  16.94  )
X-Mailman-Approved-At: Tue, 01 Apr 2025 00:44:30 -0700
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

On Tue, Mar 25, 2025 at 04:41:58PM +0200, Leon Romanovsky wrote:
> On Tue, Mar 25, 2025 at 09:36:37AM -0300, Jason Gunthorpe wrote:
> > On Fri, Mar 21, 2025 at 04:05:22PM +0000, Robin Murphy wrote:
> 
> <...>
> 
> > > So what is it now, a layering violation in a hat with still no clear path to
> > > support SWIOTLB?
> > 
> > I was under the impression Leon had been testing SWIOTLB?
> 
> Yes, SWIOTLB works

We will double check too.

> and Christoph said it more than once that he tested
> NVMe conversion patches and they worked.

We've taken this entire series and the NVMe patches and have built on
top of them. The nvme-pci driver does not have scatter list chaining
support, and we don't want to support that because it is backwards.
Instead, the two step DMA API lets us actually remove all that scatter
list cruft and provide a single solution for direct IO and io-uring
command passthrough to support large IOs [0] [1] and logical block sizes
up to 2 MiB.

We continue to plan to work on this and are happy to test this further.

Clearly, we don't want any regressions on NVMe.

[0] https://lore.kernel.org/all/20250320111328.2841690-1-mcgrof@kernel.org/
[1] https://lore.kernel.org/all/Z9v-1xjl7dD7Tr-H@bombadil.infradead.org/

  Luis

