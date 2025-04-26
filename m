Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C4B7C3ABA6
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Apr 2025 13:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9rjDHHnXKIq/IYLRYNz7omC4hZWk80Ktl1m/BymvYWI=; b=r6POStOTdpm0unIfAR4ctywqQE
	+iATIM6vIEnR7Nbf8fRyW5o0ijEcFNRAEskH/SG/3Xa9h0bwvOTvCPehAII+Jug9Gieg05caOE4Pu
	TOpg8epPKAdyScJaBnS76zTGbKbUyYxu+AOnvZBesxPwpgqGkfmxEE/OFEXN+0DS9gsdKqlq7OlKa
	6+bw3TxulPyeG3nFDQf26QX7RqDxr821/qRK/l6PpxPZKlF3PV7NzvXKoBoIEhrLj5MjbkNkjgrzT
	ZRM9W5mNx5kwgZW65ZuJVLV+cQV3vvxPko/odR4Dn8Y+WyK6OFfFS46caYulF2buI1yDM3QXc2LvM
	ytcu0+wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9O9Z-00000006JNK-2Vnp;
	Mon, 28 Apr 2025 13:04:09 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8TpP-00000001DYb-2Vz9
	for linux-nvme@lists.infradead.org;
	Sat, 26 Apr 2025 00:55:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 3B05EA4D392;
	Sat, 26 Apr 2025 00:50:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9371CC4CEE4;
	Sat, 26 Apr 2025 00:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745628933;
	bh=BOXccjPCEJxJiPSX1YxnZeQAyhQmKv1c/BGHYEt+AQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uiSMb7zCbEnm/zWGn7r9DqfOzGFDieaQGHpUN/NLclU8yohOsRJV0b8VlvZ8vHnfZ
	 j629XNFsK92BCIGb/47jnK6G+v1TLnv5qMOk0YCv2pbyxQ5uVV9cUeyWrhVs/54ym1
	 X5kJdXQtjULkoUqi3pPYuKDIbr4YZdscn9yNnLfv4WPbHgpS65N8AtFsS2gsgeeVNY
	 SuX3OHwk8XVamrwdbLNpTKGGWFQ9HIrTpqsC2+ALw2nHooGVf3ZGkVpolFHelMSllb
	 QVl1DmjsAa5DeVaTSawCaZggs4AUOfWX3v/Z/ZMIpMfeyRV0MR0Kb5ebrxolRAKJ/8
	 NXVVDs+pM3rpQ==
Date: Fri, 25 Apr 2025 17:55:31 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@ziepe.ca>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
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
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v9 04/24] iommu: add kernel-doc for iommu_unmap_fast
Message-ID: <aAwvAzZdVigusu8J@bombadil.infradead.org>
References: <cover.1745394536.git.leon@kernel.org>
 <9becc0989ed0a6770e4e320580d1152b716acd0d.1745394536.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9becc0989ed0a6770e4e320580d1152b716acd0d.1745394536.git.leon@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_175535_766340_BFE41A89 
X-CRM114-Status: GOOD (  10.12  )
X-Mailman-Approved-At: Mon, 28 Apr 2025 05:19:58 -0700
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

On Wed, Apr 23, 2025 at 11:12:55AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Add kernel-doc section for iommu_unmap_fast to document existing
> limitation of underlying functions which can't split individual ranges.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Acked-by: Will Deacon <will@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

