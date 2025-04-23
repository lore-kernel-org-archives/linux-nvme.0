Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D1AC369D9
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Apr 2025 18:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sAA3ahIS+2Nb+9ARKVTXCSjk2uwR/TOFzjA5DEQnqxg=; b=CnFueW6j3SwGTVOWx9Suiv0p1x
	X5ZsvBxHlsPtV0VHVlA7c47m2EfCPjZDHhCudYuXvLZxQI1lvLFW9NHM5ZGOBUVs/u7SklBnTmeZY
	AGd4p8esKPRJ+ULy8iTzd1DUqxQ+Ele66zF2Txfldc/1fXlKT6iMMwIHQasrF1ShOk1K/RfNXlHlA
	XOGnGP7xLU+hWc2qq25m54m4RhOLo7L8/iDZXCUhxLLpBYP3apBszmtPuQKwKSP+eOwnA4lKum86f
	MfDWe836D8zrBYYPu/PjbXKjyaDMgj+LS6Nbuc/GQRR525yebNiJjB1hb4Hq7gc1clGA6FXjzEkT+
	U5MeDm4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7eze-0000000BbVz-1SnV;
	Wed, 23 Apr 2025 18:38:46 +0000
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7dhE-0000000BEUT-43Uy
	for linux-nvme@lists.infradead.org;
	Wed, 23 Apr 2025 17:15:42 +0000
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-86b9d9b02cbso65650241.1
        for <linux-nvme@lists.infradead.org>; Wed, 23 Apr 2025 10:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745428539; x=1746033339; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sAA3ahIS+2Nb+9ARKVTXCSjk2uwR/TOFzjA5DEQnqxg=;
        b=ClEkfranxwIjzVBEQh32d/+7twQAsAY3UK4YiOlSCrSRqL64e/dawJuv94n3Y89RpF
         DB5kJRqw9CjRVBNabgYA/0VSYD77Fz1ugKeVxwPm94b4mtpvqjqWlTVYKz4Ph5wcncY9
         /HFogC/NNHuUsRFGGUBlaMAHnmkc0MnrFOXxVzUrg2NbNZz9YZMpmK/k/BozclQMlrzx
         t5OmAVX4GeiwLAoM/qiSPmNmBRfgoYdxvJEEttlpttqwi5MsLYP5zR+HFSNml7fggp/z
         Feg39+YPKEpjHYSRg7nB0E6GJ4waHsPy3ObHEkTYoy52bClv+9KqSH3GrShFxzxvnOnW
         jcAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745428539; x=1746033339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAA3ahIS+2Nb+9ARKVTXCSjk2uwR/TOFzjA5DEQnqxg=;
        b=glhsDEcrVg7nvzuidj+f3Axr5gANhYr/NkpW+lU5r9789Bj9tKQmRwm5a8fasLCP6X
         ak7hPJow6MThHnUSZg2uf1frVNljzCO/7V1RXwTj3ykUwjFrYnawJIQDEIxY7cPCWZHx
         1jDbVEEEOE3Sh8FgfunEHwh3snVFBQuiXJjMPw4xDREDk++BTCJGUTUekd8g0wftGOUL
         XbzYqgiwKYhgrPM03y1mCAilky8HK+jsRiy+BBorADoB6vxN/bSYsZxaMuJBIL3lvXmw
         SRV46pbvt6Gi2L2YHoGHeDGA4dy+znONIgfIcMHUzy/d7aIZiHowfgq93xzjvNetWutk
         nlwg==
X-Forwarded-Encrypted: i=1; AJvYcCXoYwk07cfSPyW1FuGSBbjBWQsoT2d/AkZynZ+NWC7mXV760H2i2wH9rHZKViwciaNs2rhUxnAJR2ml@lists.infradead.org
X-Gm-Message-State: AOJu0YwfyI4DwhMtr3+C6rP1CVJi1n0pkEXoSNVMPgD4rxmYwcv6UpNv
	NwcIEKcDK107L+7ASfviKTVqJ3V50tZD1dzJ5TuRD2JCVqJxR4Bnx+AERFX/9lg=
X-Gm-Gg: ASbGncs9aVNzjXVR3i1sBkVLTWCRp2QSE7RIc1TfXCGSHIlczFZjPAis2tHva1eo4X0
	Ay2YO16lg3KJf7sNvUXuz08v4DZmZuPQAENZ6Fs3ZEcmdo32JkkIqEmn79CfAFXZbU23ty5brCy
	wqnBRMOC/8CwVMSXX1g8MwLHlw3Dc/kh/KUsR6oMMrzY8hNzy26yW+0p6QVQ1NQTvtDMzdhMG1k
	URmifNtQ9g1zJ7Z55Uqeof5+qNX/HYT3Ynra9mfTVphsL71ZtAEVpp1wS/thdtZE5ESCOzSI8rW
	UEHyJh/DIcfrI+Msj1771tuyfXPatddf9/keT3FzWsyd6lSaLGinFoCgV8o7tgi5tvnKbz4nv3r
	fXGvU3K6KJa18zS4eJxFW/WpYxMcu/Q==
X-Google-Smtp-Source: AGHT+IG91ka296h4XrJ4QPDo73jdYlZoOj1Zkc9PInMILwbVuqXEZMd5w4C/WgEttaatAxBubBvu3Q==
X-Received: by 2002:a05:6122:3c54:b0:529:24f8:dbdd with SMTP id 71dfb90a1353d-529253da601mr17813854e0c.4.1745428538734;
        Wed, 23 Apr 2025 10:15:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52a74d3a2d0sm79186e0c.40.2025.04.23.10.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:15:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7dhB-00000007LQW-2UhV;
	Wed, 23 Apr 2025 14:15:37 -0300
Date: Wed, 23 Apr 2025 14:15:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Jake Edge <jake@lwn.net>,
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
	Chaitanya Kulkarni <kch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH v9 03/24] iommu: generalize the batched sync after map
 interface
Message-ID: <20250423171537.GJ1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <2ce6a74ddf5e13a7fdb731984aa781a15f17749d.1745394536.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ce6a74ddf5e13a7fdb731984aa781a15f17749d.1745394536.git.leon@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_101541_007926_613B6293 
X-CRM114-Status: GOOD (  16.71  )
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

On Wed, Apr 23, 2025 at 11:12:54AM +0300, Leon Romanovsky wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> For the upcoming IOVA-based DMA API we want to use the interface batch the
> sync after mapping multiple entries from dma-iommu without having a
> scatterlist.

Grammer:

 For the upcoming IOVA-based DMA API we want to batch the
 ops->iotlb_sync_map() call after mapping multiple IOVAs from
 dma-iommu without having a scatterlist. Improve the API.

 Add a wrapper for the map_sync as iommu_sync_map() so that callers don't
 need to poke into the methods directly.

 Formalize __iommu_map() into iommu_map_nosync() which requires the
 caller to call iommu_sync_map() after all maps are completed.

 Refactor the existing sanity checks from all the different layers
 into iommu_map_nosync().

>  drivers/iommu/iommu.c | 65 +++++++++++++++++++------------------------
>  include/linux/iommu.h |  4 +++
>  2 files changed, 33 insertions(+), 36 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> +	/* Discourage passing strange GFP flags */
> +	if (WARN_ON_ONCE(gfp & (__GFP_COMP | __GFP_DMA | __GFP_DMA32 |
> +				__GFP_HIGHMEM)))
> +		return -EINVAL;

There is some kind of overlap with the new iommu_alloc_pages_node()
here that does a similar check, nothing that can be addressed in this
series but maybe a TBD for later..

Jason

