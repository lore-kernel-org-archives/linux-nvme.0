Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D76EAC3ABD8
	for <linux-nvme@archiver.kernel.org>; Wed, 14 May 2025 16:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9vSyuz2hSZ27DtuQJM+Nc6E/7gYQxt9c7959hdD1ZDU=; b=e7E8/orhVa3BRsL4gIpDaBDK6e
	4n7Ogqoo7vA+NG0xPUyd9+8N4NyrGeNcH9icF19HEi2aVH/P0ZNSc+e30a6vUsJT/OmUN2HxlOluI
	5HJoRbB5nDBL47xZM4Zbi166EvaGp3rk8u/+F01KLPFH7UDu0YxUFsq67o3pEEzbpdjKaXMAx9SrS
	xXgdy3ivfoFRFy6AmZuQdp7p5aIQItA5a4AesWsr78NmqE6zgR28dDG9nLVi8lxxdCA2ohL0jNMsb
	OGKnd0D8sjFm4Mx1LOAy1zYiG8N1+oNWY9hAjCqm8JX36b+uzrBwu5UgCDj0DXifgLHC7/0ZNsr01
	6I01uVHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFF9b-0000000Fmee-47eh;
	Wed, 14 May 2025 16:40:23 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEQ4X-000000093jx-3xon
	for linux-nvme@lists.infradead.org;
	Mon, 12 May 2025 10:07:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1FE1B5C5E06;
	Mon, 12 May 2025 10:05:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8BFC4CEE7;
	Mon, 12 May 2025 10:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747044463;
	bh=XALDZKGpGWCIJWhewU5QYMsRfS47+UV8sY1D37V1fag=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BeyENDX1we8D7zgGY2YFHTUWMiCzVu93YRbpelQHdSlaheD+E4xFo6XlsqdFYu1rO
	 OMUWFCIMYeOEhF2Ftyv4XUS1LDLbcA4j0JvDm6EA4JEImJAttTKP06IJLp9A9u8CcM
	 uxHLrn5uu2FDZi4XcTsRIeS+I3RpwrtIoaOTAJOTLAoAe2x2x7Ef8nX7qtsKut4UPg
	 qDKP6aXKb5r2IAdBjjX9qriiZB5CWNeYA1nNkpKxYMGnIpwSPLaeliNgTHIZMNYimK
	 3RmL7XRyHrqgqC6XnDz3TtwoBF9SKm0u/B0OaEK3EK7c3aduRxwL5VSsLJ1/v4a8x6
	 2MRGp9GSeJgrA==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Keith Busch <kbusch@kernel.org>, Leon Romanovsky <leon@kernel.org>
Cc: Jake Edge <jake@lwn.net>, Jonathan Corbet <corbet@lwn.net>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Zhu Yanjun <zyjzyj2000@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, 
 Yishai Hadas <yishaih@nvidia.com>, 
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, 
 Kevin Tian <kevin.tian@intel.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_Glisse?= <jglisse@redhat.com>, 
 Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-rdma@vger.kernel.org, iommu@lists.linux.dev, 
 linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, 
 kvm@vger.kernel.org, linux-mm@kvack.org, 
 Niklas Schnelle <schnelle@linux.ibm.com>, 
 Chuck Lever <chuck.lever@oracle.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Matthew Wilcox <willy@infradead.org>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Kanchan Joshi <joshi.k@samsung.com>, Chaitanya Kulkarni <kch@nvidia.com>
In-Reply-To: <cover.1745831017.git.leon@kernel.org>
References: <cover.1745831017.git.leon@kernel.org>
Subject: Re: (subset) [PATCH v10 00/24] Provide a new two step DMA mapping
 API
Message-Id: <174704445979.583981.12854692160586160920.b4-ty@kernel.org>
Date: Mon, 12 May 2025 06:07:39 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250512_030746_088982_3F3112C3 
X-CRM114-Status: UNSURE (   9.93  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Wed, 14 May 2025 09:09:42 -0700
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


On Mon, 28 Apr 2025 12:22:06 +0300, Leon Romanovsky wrote:
> Following recent on site LSF/MM 2025 [1] discussion, the overall
> response was extremely positive with many people expressed their
> desire to see this series merged, so they can base their work on it.
> 
> It includes, but not limited:
>  * Luis's "nvme-pci: breaking the 512 KiB max IO boundary":
>    https://lore.kernel.org/all/20250320111328.2841690-1-mcgrof@kernel.org/
>  * Chuck's NFS conversion to use one structure (bio_vec) for all types
>    of RPC transports:
>    https://lore.kernel.org/all/913df4b4-fc4a-409d-9007-088a3e2c8291@oracle.com
>  * Matthew's vision for the world without struct page:
>    https://lore.kernel.org/all/20250320111328.2841690-1-mcgrof@kernel.org/
>  * Confidential computing roadmap from Dan:
>    https://lore.kernel.org/all/6801a8e3968da_71fe29411@dwillia2-xfh.jf.intel.com.notmuch
> 
> [...]

Applied, thanks!

[10/24] mm/hmm: let users to tag specific PFN with DMA mapped bit
        https://git.kernel.org/rdma/rdma/c/285e871884ff3d
[11/24] mm/hmm: provide generic DMA managing logic
        https://git.kernel.org/rdma/rdma/c/8cad4713056612
[12/24] RDMA/umem: Store ODP access mask information in PFN
        https://git.kernel.org/rdma/rdma/c/eedd5b1276e76d
[13/24] RDMA/core: Convert UMEM ODP DMA mapping to caching IOVA and page linkage
        https://git.kernel.org/rdma/rdma/c/1efe8c0670d6a6
[14/24] RDMA/umem: Separate implicit ODP initialization from explicit ODP
        https://git.kernel.org/rdma/rdma/c/15a9f67e286b37

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


