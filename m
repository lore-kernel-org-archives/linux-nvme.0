Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E226FD33A2B
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2024 18:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C194RVyLAfjN0SwVJhWOGUoO0421PCIPswUt8quSHT8=; b=4UYzHEVQOvFfj1zeN1qMoUPwgr
	Lduzy5nazwmUFCXfq0T3q+dqq3tWGYyVtWR/Lly9EIJypAtqe6IaAej9X7yHjg+Dt5oQym46dxOkv
	RAx+Ej0b1x++sgOT0FclJRTZiWUbYhZbd/IrwRKC/EHnqhLwZ1OiTpm9NXLUJDglv3b+5VwrpBmgE
	2yXJpOtDRLhFl4ToUh+tHHNdy5dSGdIKJN6/DsCs5RtDs4XVjuoQNCB3GPRxpHMplUdubSYlMA7mz
	yidCEENUUIOT4ikrVwE5gaGFrcs0oLQR9xYy5/p6HzOH844cxFkf50Ca2/6F2th9e/HbQfbGHAqlj
	zLhUCHqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Oeb-00000000Snj-3pbl;
	Tue, 05 Nov 2024 18:51:49 +0000
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Ods-00000000Sb5-4BXn
	for linux-nvme@lists.infradead.org;
	Tue, 05 Nov 2024 18:51:10 +0000
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-7b15d7b7a32so459376985a.1
        for <linux-nvme@lists.infradead.org>; Tue, 05 Nov 2024 10:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1730832663; x=1731437463; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C194RVyLAfjN0SwVJhWOGUoO0421PCIPswUt8quSHT8=;
        b=P21SRcMXgB+ytu5TMnO40n/83w9XJPRavChRJThMzrzQGhQ2uxqw9bBaRivroxzXNS
         PH0lhvtz/OwayTKDCsqGyonTJzXw+SC8DkBlVTmIJiWnrFPd8pweXdvoToDyPdo/McPQ
         S1gOF/UPvpjxp1VKqlatS0Vbq2oXHgTOiqSZIFQe/F+7rRURqPRy3tjrLMSqhIJPgH8J
         w7fb2XLMOF+S3l8kETsV9QRfZulbVr2SP4JNkxOBDyQk6seFUUuJ/K5Yf3reRV2eKhB2
         +iNgc0JVMfcDmQj8K5S3eoJuOiu1drsrfapBn398wdJdrwTBBuZbpmAPgCFp+8jjoKkK
         lukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730832663; x=1731437463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C194RVyLAfjN0SwVJhWOGUoO0421PCIPswUt8quSHT8=;
        b=d952e52+wB/eiMbZDodtg/dGruNvGGTuFeP7NcPLAwRLJ3Z5CHYc+iALKNcb9iDFCo
         JGOHpmX+2/GOPUC65uAi/C/Gl0g/VeHXgxBYkwp3nzN7UjVY+fU5XD9urDnRm3DJxUPz
         9jnCICJWNdqpwdj8FOEp3bLXyTBPLeugRwSyJ18gJI4LF1jFTVYYR+EgbNE7NJlFuLzT
         wF4UQQDEcaGGtEkJX2CfhQl4SZJMKe2CwN50+gPLuwJK4Zj8qq0d29lLrZK2ipZv09BM
         CNSmr49Bp3IIGUy7vHrMtH+s27x3MZH1rFBkHJzQ7mJndXvrQC60W2EPgGs6eF/GAj0M
         5wtw==
X-Forwarded-Encrypted: i=1; AJvYcCXNo787FdKvps2rvgUXxTQsIoBrLGdihBEPxNuV/PWdMh0jahR1ebyhHckn+CygXx0xJh1Yf/eOR2Ud@lists.infradead.org
X-Gm-Message-State: AOJu0YzBjqZktLDdMlOib7a5OTR35o9f7ObG68QuLge4DuoTX4fwiMaG
	enwSUKYM3OhsiEwg26DzK1bTHIqLJjrm+89d8Qzr+3IewZYdEHW9wGQqRmaR44I=
X-Google-Smtp-Source: AGHT+IGWpBzbxGzBgv9Gx5tLlQAZYsSh7jgfOX8tW5mq4qsvhcUPgq93VZEIR90XeqIlAFYpEQmgSA==
X-Received: by 2002:a05:620a:1908:b0:7b1:481f:b89c with SMTP id af79cd13be357-7b193f0a206mr4853751585a.35.1730832662826;
        Tue, 05 Nov 2024 10:51:02 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f3a70971sm549852785a.77.2024.11.05.10.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 10:51:01 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1t8Odp-000000023WW-0CZJ;
	Tue, 05 Nov 2024 14:51:01 -0400
Date: Tue, 5 Nov 2024 14:51:01 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
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
Subject: Re: [PATCH v1 00/17] Provide a new two step DMA mapping API
Message-ID: <20241105185101.GH35848@ziepe.ca>
References: <cover.1730298502.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730298502.git.leon@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_105105_489219_83D54465 
X-CRM114-Status: GOOD (  13.21  )
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

On Wed, Oct 30, 2024 at 05:12:46PM +0200, Leon Romanovsky wrote:

>  Documentation/core-api/dma-api.rst   |  70 ++++
>  drivers/infiniband/core/umem_odp.c   | 250 +++++----------
>  drivers/infiniband/hw/mlx5/mlx5_ib.h |  12 +-
>  drivers/infiniband/hw/mlx5/odp.c     |  65 ++--
>  drivers/infiniband/hw/mlx5/umr.c     |  12 +-
>  drivers/iommu/dma-iommu.c            | 459 +++++++++++++++++++++++----
>  drivers/iommu/iommu.c                |  65 ++--
>  drivers/pci/p2pdma.c                 |  38 +--
>  drivers/vfio/pci/mlx5/cmd.c          | 373 +++++++++++-----------
>  drivers/vfio/pci/mlx5/cmd.h          |  35 +-
>  drivers/vfio/pci/mlx5/main.c         |  87 +++--
>  include/linux/dma-map-ops.h          |  54 ----
>  include/linux/dma-mapping.h          |  85 +++++
>  include/linux/hmm-dma.h              |  32 ++
>  include/linux/hmm.h                  |  16 +
>  include/linux/iommu.h                |   4 +
>  include/linux/pci-p2pdma.h           |  84 +++++
>  include/rdma/ib_umem_odp.h           |  25 +-
>  kernel/dma/direct.c                  |  44 +--
>  kernel/dma/mapping.c                 |  20 ++
>  mm/hmm.c                             | 231 +++++++++++++-

This is touching alot of subsystems, at least two are mine :)

Who is in the hot seat to merge this? Are we expecting it this merge
window?

I've read through past versions and am happy with the general
concept. Would like to read it again in details.

Thanks,
Jason

