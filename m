Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 265D9D132B8
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2024 12:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tx1bOostXz+VH0GPtKgcyKswUQOWFhDDl/A9OfJb8HU=; b=0eaaZDf98rzDmCgXCM/y+rxL2l
	BM1MTevvgXq7+rBhv3hh/Kp72gd5Jkf7boRgsSocBy0leRJOeqWIR7motpMEduI2Dqdncz4LYK050
	A0XApP1JXO8Ywp54fEr9XsDR/nSh+oDHMM404F2UWs1aB9GVwEayyEad2vT+9DjVj4VZjrul17kyf
	lUz8QR4lDFEmbBlg4x9KeiX4KW4XJ6vo4GRjGnvT7Z1/LRQ+ynSIrTPtqC5rJhyxlbz8Al5PQ/mZo
	DRVnT24LWj5Kq2+5Rc5EVicVH+G04MCnRwP2npEWUQ6gwgE7BZcaR2gvlW08aZJvV9xJ45y96rmsT
	CFzQtkXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7w6Z-0000000Dgaa-0S7Z;
	Mon, 04 Nov 2024 12:22:47 +0000
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7w3M-0000000Dfq9-3cVF
	for linux-nvme@lists.infradead.org;
	Mon, 04 Nov 2024 12:19:30 +0000
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-6cbf347dc66so27626336d6.3
        for <linux-nvme@lists.infradead.org>; Mon, 04 Nov 2024 04:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1730722767; x=1731327567; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tx1bOostXz+VH0GPtKgcyKswUQOWFhDDl/A9OfJb8HU=;
        b=WZEKalOAk3JwGoA9DZjC8uqDvRmD0o5sSVPPJ5GX0roh8FwyUa+OAWFJmwS8LoMemg
         T3ooXJ9Whyfma1R4Fu3zVHP38DNCscGdwra22L6L6IvybAdqPHf+Y8iVvGSUw8ql/hdP
         UslQ+K81g3nOCAgABpbsRK9UrAdU9DWXPCoiK40K9XRL/VeaGVPqgoQ7dNnHtgt7WLGL
         ZDm64/UKGdl9dbdH8ZHWbDEbB4dRKdTh+AUi8nM9EksEVBfAPfsloFFO8hW0uUH/w/jv
         3otjqoB11d/UKbexU6rqvKI901aF7RnlGvVVQKptteYWD4LSfV+qTnHOAFWeGQ0JBkaq
         Fuvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730722767; x=1731327567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tx1bOostXz+VH0GPtKgcyKswUQOWFhDDl/A9OfJb8HU=;
        b=Xq91Av0jXgqbopHTeo3c26Cv/BQMt3mO4gEjBdfhOsZx/N+9lVJs2/UxjU8dcJWz71
         DqArpcA56C8oLcF6dIf5X0W/IAOTn/hfBpR5mL5dRQWclLvhtBz+BRRby90rgZO/6pvj
         E2mIfuBrI80kTzWS3qc9ZoKm0eVIRLmUivvciL3oKISMRM0hKD6Uh5wVQ2yJxWeC1WuA
         xVywrwCD4po/NT05k1U8TokVsfs5rX0SOqXkQt6+V3fKVT6JQAUImfbeSDVvzBF96mpX
         n3f/9dqzBQXQDkTRL/mQrpGImeS0rX+6pBTFDcfN1nxOddAplx+7yjpSWtYPY+G/9C81
         mRGw==
X-Forwarded-Encrypted: i=1; AJvYcCW1DAeDEPcn9CrkvRxmfWQSMp+fYVRHE/xA1/tjT0TbCwe6ChgXxiwPrBjQ++8IqHPx+D+/CfRjKaRb@lists.infradead.org
X-Gm-Message-State: AOJu0YyrXG5aoh7Z8Awu1f8lTxS1pyw96hyrJ21nd+4BeBw/F6T5viM7
	Kwl/epf01vPqM2cz8iOMryDWSgepmZk33/rCOXiJsnqlBTIV/amnp5SzmygaZVo=
X-Google-Smtp-Source: AGHT+IGGw97HgDqXEc70DPdglFSAiLC2/hvL6iix2sWZheUlrSMhSyN4gGvDNAQMyTZfPVibvICZkw==
X-Received: by 2002:a05:6214:3a8b:b0:6cb:c199:462a with SMTP id 6a1803df08f44-6d35c137657mr208089456d6.27.1730722766648;
        Mon, 04 Nov 2024 04:19:26 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d353fc718csm47611946d6.38.2024.11.04.04.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 04:19:25 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1t7w3I-00000000hJn-3gHO;
	Mon, 04 Nov 2024 08:19:24 -0400
Date: Mon, 4 Nov 2024 08:19:24 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, Leon Romanovsky <leon@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Leon Romanovsky <leonro@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 07/17] dma-mapping: Implement link/unlink ranges API
Message-ID: <20241104121924.GC35848@ziepe.ca>
References: <cover.1730298502.git.leon@kernel.org>
 <f8c7f160c9ae97fef4ccd355f9979727552c7374.1730298502.git.leon@kernel.org>
 <51c5a5d5-6f90-4c42-b0ef-b87791e00f20@arm.com>
 <20241104091048.GA25041@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104091048.GA25041@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_041929_090988_48E07068 
X-CRM114-Status: GOOD (  18.41  )
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

On Mon, Nov 04, 2024 at 10:10:48AM +0100, Christoph Hellwig wrote:
> >> +		arch_sync_dma_for_device(phys, size, dir);
> >
> > Plus if the aim is to pass P2P and whatever arbitrary physical addresses 
> > through here as well, how can we be sure this isn't going to explode?
> 
> That's a good point.  Only mapped through host bridge P2P can even
> end up here, so the address is a perfectly valid physical address
> in the host.  But I'm not sure if all arch_sync_dma_for_device
> implementations handle IOMMU memory fine.

I was told on x86 if you do a cache flush operation on MMIO there is a
chance it will MCE. Recently had some similar discussions about ARM
where it was asserted some platforms may have similar.

It would be safest to only call arch flushing calls on memory that is
mapped cachable. We can assume that a P2P target is never CPU
mapped cachable, regardless of how the DMA is routed.

Jason

