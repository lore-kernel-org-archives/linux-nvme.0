Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298D5E7717F
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2024 08:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mSqvXnIvaard16c/eLd3u6yesms3ox0NrxpeL5ooiDg=; b=jVR5pRvIyz7bFRNcwrqfM21ss9
	zE3CL9uWR6TNxkamyBVvPnJkz7j3rNapGXnlgLI4Z425FbeNSyBxbb5SYxCn9OXKqN9LaPOUpb7DU
	EsP/d2hpByNptLMAipr1gp5JI/mOpGmCt0KOd+ik0VAzJhd9C9Xme2qnu3svpLAmoHitjJkBvBBrY
	SRNHy8cEyydyHcmjEJZDEe6b69qsD9qklNsd+5TB0QeViiN4oBobUq5hk6qADF2nCp+sGiiuoI6V4
	bMQw77oAwOoYbjAsxq348G7flGqaxUKatycaTmV+isla/X+691lrsgLG5RO5jyN9SI/TVzxQEVhNb
	fjdh/nuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLepJ-0000000HMDg-2VvK;
	Thu, 12 Dec 2024 08:45:41 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLepH-0000000HMCy-3Jvt
	for linux-nvme@lists.infradead.org;
	Thu, 12 Dec 2024 08:45:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 58A805C04FF;
	Thu, 12 Dec 2024 08:44:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD34C4CECE;
	Thu, 12 Dec 2024 08:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733993138;
	bh=SnaoS3XbMfIwMqA358S7ljqTiZShb2tbxNANsv2qtHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jM/fC3SV71OtekQMes8cU//Y2sVccBO5M1Rp1oSOeTfUHhdh/h8Kp0Wvkl5o9Y05t
	 XZUgwUE2R2RdWaGKe67gws/VOMS7zdgNWvMX8LE9oP3EVbdz9mXouuy/FRi5oTmj1h
	 HBkXA4kz2nWgmHfTNOBM+/FQGz9UW4jC5QE+0HuooFXn+AUPVn1GJd7D8dNvWcBu2h
	 38m7i4D9C3LMpjXAIPmM3N0DXbZhPQMfgP30p/Rbp0BTcWwMNAuanAHMhsbK+tTlgp
	 VtDSO8fkHojv+71VgMMV/oewnpYMbcTPln7F9wB0QO2TpBTFnvhRf0FJehQQTrsban
	 tm5f/HMiAk5mQ==
Date: Thu, 12 Dec 2024 10:45:33 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
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
	kvm@vger.kernel.org, linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v4 05/18] dma-mapping: Add check if IOVA can be used
Message-ID: <20241212084533.GG1245331@unreal>
References: <cover.1733398913.git.leon@kernel.org>
 <b23a1e29f00f31f31641479c90f2471aee27fac5.1733398913.git.leon@kernel.org>
 <20241212083459.GB9376@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212083459.GB9376@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241212_004539_866744_128E5973 
X-CRM114-Status: GOOD (  18.20  )
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

On Thu, Dec 12, 2024 at 09:34:59AM +0100, Christoph Hellwig wrote:
> On Thu, Dec 05, 2024 at 03:21:04PM +0200, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > This patch adds a check if IOVA can be used for the specific
> > transaction.
> > 
> > In the new API a DMA mapping transaction is identified by a
> > struct dma_iova_state, which holds some recomputed information
> > for the transaction which does not change for each page being
> > mapped.
> 
> While the content of the patch here looks fine, the super fine
> grained patch split look really odd and makes sensible review
> hard.  Was this a request on one of the earlier versions?

I don't think so. It is combination of two factors:
1. Review cycles, which caused to shrink this patch.
For example, see the amount of content in RFC version of same patch
https://lore.kernel.org/all/cac154df7131984929a1cf73948bc5986af5ef85.1726138681.git.leon@kernel.org/
2. Attempt to localize changes in dma-mapping.h file. The following
patch touches dma-iommu.c, while this doesn't need to do so.

I can squash them.

Thanks

