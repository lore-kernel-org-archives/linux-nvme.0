Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 981FCC3DA45
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jul 2024 23:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sqjQlEH3CKHFjb6SyBS/N/HAG+tY7keJdf7Z8lIqTro=; b=ADzcdq8qRMmzn0oZq1sXeLuV0Z
	9JsjPNjOTpehMQGXLvHLba7rdb9705T9HriozFE1FlnP97axg7qJ5CLAVZiANoBOJ/ubjzGYOCuSb
	N7iEwXXCuSb8ISPRz6/8DdfQ0DwjkduTuy3sUCPegb06g1jd48RuNbBkWI8hTelnBzR1zpCID3/zc
	48/5JH7HqtDvcCu2xjVgsrsm0D7VE0xwEPvdxuueelvU9BgZNu6h1UwrCGmX0zXdcBl5gVq2si6QZ
	+y7oHwF8Ermi5vtmved8nWdhnmvrW1dv2a4Sy48ObOgvaeE5ws/Va35BmBmSdt8BcKyi8uDq/Mvdh
	p2H4gRkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sS3E6-0000000FoUJ-2vHA;
	Thu, 11 Jul 2024 23:29:26 +0000
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sS3E3-0000000FoT5-2zhy
	for linux-nvme@lists.infradead.org;
	Thu, 11 Jul 2024 23:29:25 +0000
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-df4d5d0b8d0so1365490276.2
        for <linux-nvme@lists.infradead.org>; Thu, 11 Jul 2024 16:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720740562; x=1721345362; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sqjQlEH3CKHFjb6SyBS/N/HAG+tY7keJdf7Z8lIqTro=;
        b=fUgfk+ji1UH6PuJJwYsQb7NcHbSF5i923vOKCq12Lu09yxcZNDYuWE+bDzjsh9HlXS
         jJQ/ebwdPCDnsGQKEjXV+2NnQyOhL61nXdblj/TgOOerz1hTvWaJXltUO0GPebNHoMHt
         xu0vPO8qJYVaDY2eOa5wg6dmlvXV0s63EsUDOZXXlajZAes/P20MWQRhnc/5sfegxFQt
         GUm1d3N+VN6q8THuLXvlBm7GJoysfctv8+VTMPCs4E9PqQEtAu/JwtjEru7XkNQ2YAfg
         /13bWv/XaihGLONO5w52V7bGkTBiC/mU7eoDTcvb7gbUdsmnC2d3+xXIMKKjbFuFPjLD
         2o+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720740562; x=1721345362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqjQlEH3CKHFjb6SyBS/N/HAG+tY7keJdf7Z8lIqTro=;
        b=bRi0FVfUUlS5QVpKNfhcdVTki9owseOvZCftjf2bYT4UlaLSuVBnlAyMPhYBNFVXFi
         zWpfd9BhWLgJh+7wpuuww6Iyi4NTEAfWqX72tCkEWuwW8pXzExJTt1UcTWSgPM5fsecg
         neKvzMjH2knTmJSfIcKHL8m1r5NQ1FHFVbeTUUE2RB3SIbELeLugnQeYHcttgf3JzbFC
         MwuXHx+uwSvhH67YPf6d6Ctm8eIBWk+Ok9FigKlZLJb02+36cbrzojP1mXIsoh0v6Z4k
         /e6Db/UmfhvUInxW3MTrrQZCJrkjfDYM5IEZ1YHBQY0rq78A6QF22gFbFwRnIZXfmaCG
         fvUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNf39r5RNFx+wgjO7VUMvR4z0BTB7bWmfi243heiey3DgCDFnqLhWOpo+BeS6kwo+jXieDBiFKgBo/p+G5zfiKcJkIcSuPadti6lSzHkk=
X-Gm-Message-State: AOJu0YxORgCQ/uV/q776n8sytH/YPV74k5Y1H3RphB+t9dXuOGwUL1ij
	GSF9s7YQYhSt0d5CqXcAILO6HLUilEwu5PN4s7GKxflYPwv2kHtEqg7PQBFxxyA=
X-Google-Smtp-Source: AGHT+IGo/R/9vr/JQ8/zyNR81M/Hy4HYANX0IxAKDGShf5hUDU3ZGhkQLcCJ3hGHl6ul2XGkV4cgvA==
X-Received: by 2002:a25:aa66:0:b0:e03:5fee:66a with SMTP id 3f1490d57ef6-e041b123aefmr11985783276.42.1720740560216;
        Thu, 11 Jul 2024 16:29:20 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f190128d0sm341135085a.44.2024.07.11.16.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 16:29:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sS3Dx-00FQzB-7b;
	Thu, 11 Jul 2024 20:29:17 -0300
Date: Thu, 11 Jul 2024 20:29:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Cc: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Keith Busch <kbusch@kernel.org>,
	"Zeng, Oak" <oak.zeng@intel.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 00/18] Provide a new two step DMA API mapping API
Message-ID: <20240711232917.GR14050@ziepe.ca>
References: <cover.1719909395.git.leon@kernel.org>
 <20240705063910.GA12337@lst.de>
 <20240708235721.GF14050@ziepe.ca>
 <20240709062015.GB16180@lst.de>
 <20240709190320.GN14050@ziepe.ca>
 <20240710062212.GA25895@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710062212.GA25895@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240711_162923_776743_2AE40475 
X-CRM114-Status: GOOD (  19.49  )
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

On Wed, Jul 10, 2024 at 08:22:12AM +0200, Christoph Hellwig wrote:
> On Tue, Jul 09, 2024 at 04:03:20PM -0300, Jason Gunthorpe wrote:
> > > Except for the powerpc bypass IOMMU or not is a global decision,
> > > and the bypass is per I/O.  So I'm not sure what else you want there?
> > 
> > For P2P we know if the DMA will go through the IOMMU or not based on
> > the PCIe fabric path between the initiator (the one doing the DMA) and
> > the target (the one providing the MMIO memory).
> 
> Oh, yes.  So effectively you are asking if we can arbitrarily mix
> P2P sources in a single map request.  I think the only sane answer
> from the iommu/dma subsystem perspective is: hell no.

Well, today we can mix them and the dma_map_sg will sort it out. With
this new API we can't anymore.

So this little detail needs to be taken care of somehow as well, and I
didn't see it in this RFC.

> For the block layer just having one kind per BIO is fine right now,
> although I could see use cases where people would want to combine
> them.  We can probably defer that until it is needed, though.

Do you have an application in mind that would want multi-kind per BIO?

Jason

