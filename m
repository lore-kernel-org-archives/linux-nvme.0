Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF907C369D5
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Apr 2025 18:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rNJodNA/CGOE8qYPmCoAIvEyeqrCcwNf4apB4pxSGaA=; b=02rmDuiIenfYO9mwnnzLFm9A/P
	u97BXcB/L9sZTtjyABAyeI7B6qFrram+SR6pZbISVwfXFZT5bFMiXY+gdzXLiUBY4+G2fMdM79sg9
	/OIBF66xthb5+sPQE7iOy2uFp6tLZ7WyZLo96GIOVHi+ILE2WFLA4x1+MT/6ihvk8D8lEdR8r6XVM
	X3TJq+m9hacsKUsdqIZFqDkTOG49VeT9liCcDAcBeGUDZQ0LK05Rq1/MZd1fl8D1b0Mg4oGoZ1H/Z
	a//Bt6e7jFNZZtPNO5eD0P9OcorKUvK3XD6ZZcPvnZGVEYIIpa3PubI6Ws63kWQKd74YH5zOfnbAL
	mN5sfCsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7f7t-0000000Bd84-0Wfv;
	Wed, 23 Apr 2025 18:47:17 +0000
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7e1L-0000000BHji-2uCf
	for linux-nvme@lists.infradead.org;
	Wed, 23 Apr 2025 17:36:28 +0000
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-7c54b651310so14110085a.0
        for <linux-nvme@lists.infradead.org>; Wed, 23 Apr 2025 10:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745429786; x=1746034586; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rNJodNA/CGOE8qYPmCoAIvEyeqrCcwNf4apB4pxSGaA=;
        b=ludoQzRNLHhLF+FCrBmtr+SXmc3Ji66imni+dk9ULbQVnANP2UddKARSmjRBiLOYkc
         KioDb2RlhRSWzGjdMeMG/2i9UPxtB45/+IAtAebm5bqMP+TpjydShShlVAfLX2TC4LkI
         t1XJ/Xeq7soQYgJxOYnq/XxajMqMid0pTrAhXu+4+lBVgzbtBp1R7GLXikjP1noD/9uk
         e0RjSxhy5mYA6Z/xaqMgWOmQADzOS+ZvTxliEmy9pmpkgKdIPLhpJPQeACE/ChvdnC4L
         +HeUTRnIc3KT3g3yYzxEboWXcjKAVua1WcSAcyqAYKYC9Z7t3jI71dgvZIadUglTQRZV
         xMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745429786; x=1746034586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNJodNA/CGOE8qYPmCoAIvEyeqrCcwNf4apB4pxSGaA=;
        b=nXjCzEWoCQwiS1jO9gTy5QeGCKO29jQFCIkvqsejk7H6O6NpOYy48nl74FbF2dAykO
         me/UN/ELHuY2sWN0tWcc/fEd/9KRELzgV9CMgsu/uXCvxX1upI89jRICzrPo3JJeJDJ6
         4FlTBbVQX41kF1mh77ntajNQ+RhDzweIw70EYB8AwAVeZjrK94BO3VotOWNbURHO9Qr9
         Tq04ZDpXzIfBBU7K1jj51BBn22wx/9EZPQLCFTT7cZH0ayVc3IbNCceXHYwwmHkYaD73
         VhQ2eA9PCt38p2qV04aAi0SEoviXowBHz+7I+kkaAlH38J/DWNvTd3S7xt97Jhhv5lsK
         R7ng==
X-Forwarded-Encrypted: i=1; AJvYcCXzUUAH+YermZJevD76B+5zU0AtOwWjZG4EiHX2wZmr8po/20NNn2lyBo3dXiA3MM7spv/EuhMWSgH2@lists.infradead.org
X-Gm-Message-State: AOJu0Yy3TMNg+Ai3r9dXNAsA9qybFWmQSZ/vMhhqjyOAdoWCke7wDjO2
	cRMggheXyuU1jlMXfXjAZyCovs7syP7Q75YS46bc95+JloEN0mzWOkTT0LxTai8=
X-Gm-Gg: ASbGnctoXI/0rFWA5aGEF7mik7aHt1rwspdPusObJJuNC2JO8ggofYkqZpZIbVTlJOM
	Dcag8KNHqhQwks6UjXOydMLsUiuIh9MKw8hEo3JyjD1evHsDUahVsxxgDZjWuoeGNYpg8V524Ia
	NJiiSub9WNYk4PNyJ1lrIZx0a788iQZWZiNkbgZCH6iRXS9dVcVs5mtaKBTnnikvxRQE1EtpMCl
	YTv+FmWOwa3KS+k+hviEJj5S8BbaINsmYwTkp5qkkJ5OWTGC1wWgwL1fMeYDezoig6X2fOCMgHs
	6N5hoFb75nC95EDgSgwtLc/ffzW7veDdymMyFo+FYF7x5IXnuQRr757m5fz3b27GlBoP/qhTMzM
	jgnvFGsfUscHqI8nzuP0=
X-Google-Smtp-Source: AGHT+IFfYFJ3H6MHGXkZxUwtNrKhvKS2i7aEibqmChB9ejFnkuFqgY0c21HHcZ68bh6mda7wa7inKA==
X-Received: by 2002:a05:620a:44d3:b0:7c7:a5ce:aaf1 with SMTP id af79cd13be357-7c928018e95mr2986289985a.35.1745429786563;
        Wed, 23 Apr 2025 10:36:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925a6eb31sm709808085a.3.2025.04.23.10.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:36:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7e1J-00000007Lca-2cT8;
	Wed, 23 Apr 2025 14:36:25 -0300
Date: Wed, 23 Apr 2025 14:36:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
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
Subject: Re: [PATCH v9 13/24] RDMA/core: Convert UMEM ODP DMA mapping to
 caching IOVA and page linkage
Message-ID: <20250423173625.GO1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <7d6f3d50c4e6eb3ab75fd4c5bbaa8efcb1a15b3c.1745394536.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d6f3d50c4e6eb3ab75fd4c5bbaa8efcb1a15b3c.1745394536.git.leon@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_103627_732064_21AF8B6F 
X-CRM114-Status: GOOD (  12.33  )
X-Mailman-Approved-At: Wed, 23 Apr 2025 11:34:49 -0700
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

On Wed, Apr 23, 2025 at 11:13:04AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Reuse newly added DMA API to cache IOVA and only link/unlink pages
> in fast path for UMEM ODP flow.
> 
> Tested-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/umem_odp.c   | 104 ++++++---------------------
>  drivers/infiniband/hw/mlx5/mlx5_ib.h |  11 +--
>  drivers/infiniband/hw/mlx5/odp.c     |  40 +++++++----
>  drivers/infiniband/hw/mlx5/umr.c     |  12 +++-
>  drivers/infiniband/sw/rxe/rxe_odp.c  |   4 +-
>  include/rdma/ib_umem_odp.h           |  13 +---
>  6 files changed, 71 insertions(+), 113 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

