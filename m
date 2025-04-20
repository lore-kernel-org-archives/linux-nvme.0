Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F401C369D7
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Apr 2025 15:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9oM2xuiHgX/Hc2JcA++WxF5r0xivQaQE/dUFh+n1Hbk=; b=fIBlZF4a/y3MbyaM2HarszCPPx
	txG4JLWfBtqwsEe7fz7XM+rlMy4yTam5UZzjp9F/2X1tB9iL7ttXVNz+lLuTEG06snLDCObvBt34a
	+kvmfK7jq69MewWtYOYnOqD2XyksteCTYdXvX2Drad9xf2aBptRDsC/YQ7R+C0lIxRks9TZZVd2Wi
	dpdJ+j797RdBgbBwyk89+RXFC/RDobakHTKP8AWqVnRgTOTCkwqcLp702SN1K7m1bnh8o9YUjG4Nc
	YHDyFldH9CMw6FWPanUY+fG8QDSjnrmyoB8XzeDXYdeGYON+KUPDG/HfToNKbCEUhTBQBnSYNJszv
	2Kxv5vRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6shY-00000004WvP-0nA9;
	Mon, 21 Apr 2025 15:04:52 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6OtA-00000002JXg-45c8
	for linux-nvme@lists.infradead.org;
	Sun, 20 Apr 2025 07:14:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E4F6E5C53A7;
	Sun, 20 Apr 2025 07:12:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E37C4CEE2;
	Sun, 20 Apr 2025 07:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745133290;
	bh=SpNXshGC4uEadiZ9mic8rX/qeMHOKG3enirsdDCvXf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N9hnRRtmNHfnuM6gp/E+KrJvokqSb71oYMhBqMYRZgnnOGfewaBmv+VxsqSvw2mx7
	 2fUdjbY/H46G3VKGRBnVwSy+Gjl4Z6RSMWeY14FJU6YmfQyL7kYGD5MBt7GIedAPYf
	 WshWPr5dJTN9Wmr96QKS9Qodv+qsrhzEMuJXAU6Bd5tnDEQoGrprjYI9sbQ8XZCPzs
	 8+caVRnyAL4BM9TX5W2rx5tKmtonDo4tGbYQ3BgJlrPC3GoZ4wZDsnfOB4NIgP2BY7
	 tY3+8mvVofskwTyS6lS/IiWKwTGTcxkr24eh0/y5LbaD9SKuEGZVJwz5YEwht/9f63
	 yZpV0FW9cb2BA==
Date: Sun, 20 Apr 2025 10:14:46 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
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
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v8 00/24] Provide a new two step DMA mapping API
Message-ID: <20250420071446.GB10635@unreal>
References: <cover.1744825142.git.leon@kernel.org>
 <93ef8629-4040-4773-beac-03c62f848727@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93ef8629-4040-4773-beac-03c62f848727@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250420_001453_048351_A8B37DF2 
X-CRM114-Status: GOOD (  17.08  )
X-Mailman-Approved-At: Mon, 21 Apr 2025 08:03:40 -0700
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

On Fri, Apr 18, 2025 at 06:18:00AM -0600, Jens Axboe wrote:
> On 4/18/25 12:47 AM, Leon Romanovsky wrote:
> > Following recent on site LSF/MM 2025 [1] discussion, the overall
> > response was extremely positive with many people expressed their
> > desire to see this series merged, so they can base their work on it.
> > 
> > It includes, but not limited:
> >  * Luis's "nvme-pci: breaking the 512 KiB max IO boundary":
> >    https://lore.kernel.org/all/20250320111328.2841690-1-mcgrof@kernel.org/
> >  * Chuck's NFS conversion to use one structure (bio_vec) for all types
> >    of RPC transports:
> >    https://lore.kernel.org/all/913df4b4-fc4a-409d-9007-088a3e2c8291@oracle.com
> >  * Matthew's vision for the world without struct page:
> >    https://lore.kernel.org/all/20250320111328.2841690-1-mcgrof@kernel.org/
> >  * Confidential computing roadmap from Dan:
> >    https://lore.kernel.org/all/6801a8e3968da_71fe29411@dwillia2-xfh.jf.intel.com.notmuch
> > 
> > This series is combination of effort of many people who contributed ideas,
> > code and testing and I'm gratefully thankful for them.
> 
> Since I previously complained about performance regressions from this
> series, I re-tested the current code. I no longer see a performance
> regression on a AMD EPYC 9754 256 core box, nor on AMD EPYC 7763 128
> core box.
> 
> Tested-by: Jens Axboe <axboe@kernel.dk>

Thanks a lot.

> 
> -- 
> Jens Axboe
> 

