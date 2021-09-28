Return-Path: <SRS0=nS76=OS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3952C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 19:11:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 733FE61209
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 19:11:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 733FE61209
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v6UyHCveSDQDL3kKEMfUsbPll8iLPtgIWu0XTZ9FJxA=; b=4Vy32DMI7ZdUMw
	ntWhyLW8cShhd/Iw4Dg+VopP0PXCdzP4l3uPsUGADkl7sXlpC8nuU9VCjhw8Zaws/aLPRnE8V2R7p
	dkKNS7nqWj6xmkPpdJTt5bLGmhY4s4L92nwYd/CQK7lF6k1gj7ahc5Z4ncEVKkinVEPUUENG/JcxZ
	3yJLmzg7pV/H2ebrsBgDaXBm0cfqfu4WzrgMdzi0wb0UPX9tN3lVdCgAlbyghp1KC4fVlKOgdY1Pq
	b55avM6UsIqgee8IZbVPwZ9MRA/2J58ati94VIOR+WuWKxPHYlTgY1aHOY9DsMVbZA++Eauh8HoCe
	Jh8qrkpfrAEwnRSqb7BQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVIVW-008bpr-8s; Tue, 28 Sep 2021 19:11:14 +0000
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVIVT-008boG-P8
 for linux-nvme@lists.infradead.org; Tue, 28 Sep 2021 19:11:13 +0000
Received: by mail-io1-xd31.google.com with SMTP id y197so28717600iof.11
 for <linux-nvme@lists.infradead.org>; Tue, 28 Sep 2021 12:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=dAXGT1q19wzeDZuDAAKylN0FjSdSatuZU8qbovqANdw=;
 b=NIsddmzY0SYPds0DsYkmoKZofq4uefBOl/rEvHgX2wf4Sq0Q/kPfCr88FedGCk72x4
 M85CSii4YgqgeM0qNeZZf3HW2JP2y18v42D5jWWJxvBa620My0qz75JLiIxzKFePaec2
 fhlmmNtBIFu07KD16S0Ue2uzNiDFkv4tUm/ROVOWgsufiRUPYkqXwQJynXHEpPzfeWNl
 lT9KnR8RE94I6VBQwgECcNJi86FzLxVTZHjBXlz92yIisi+ep1Kytv6n7liUaJT+LBIn
 HQ3MgYljZM9zacpI6dVo9OhsLwET/JAbBNrnWr1DQI5h4ySl49sjVWB2ztyrVHrLwEzy
 Inxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dAXGT1q19wzeDZuDAAKylN0FjSdSatuZU8qbovqANdw=;
 b=m/NtrdQKFzoIlI8LrNQTAfbSLyfXSMkCmJqs65kn1sICn/gq5gzxYwJVww4I+UQyJF
 v0X/cWZxOap4XqjYX/Ox2OBtE22Y2QZQsqqj7xzLWj20zQtjhuFctI6Lif3lpQiEqFmF
 kz8gpISwdTp87kW3DgpximF7J3bi0bFitkPRTL4qaqriG4M/lCNt8g6Z1D0eXHT7RYTe
 K13HiLWaPhVYs7AMugEt0A4zwAYUGe6FZYMiU42+T26uHfovCTZnUsiBlI3rIOCHqs7C
 BkRZ1lIgHo7GDJtr7BmQIGSgJ6iM7Y1kfUoYcdOejj15C2mjOYTf+MhmdMo7lDCgfent
 nzGw==
X-Gm-Message-State: AOAM5339ka4MKsl0elbAycwjMpU/PrZ2Hn2LHnfikD+qrC9PVsq+pUvB
 hPLILgR0Wyly8CyXC+lCBmcm0Q==
X-Google-Smtp-Source: ABdhPJyf8mt18AlEnK05TMnL1sFZAfxIPVyMiQRw0bFkerbSvSvkBso11/Xmw8q6+HkK6ya/0EoZuA==
X-Received: by 2002:a6b:5b14:: with SMTP id v20mr5202033ioh.142.1632856270563; 
 Tue, 28 Sep 2021 12:11:10 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id b14sm1785849ilc.63.2021.09.28.12.11.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Sep 2021 12:11:10 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mVIVR-007Fxh-2M; Tue, 28 Sep 2021 16:11:09 -0300
Date: Tue, 28 Sep 2021 16:11:09 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: Re: [PATCH v3 07/20] dma-mapping: add flags to dma_map_ops to
 indicate PCI P2PDMA support
Message-ID: <20210928191109.GO3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-8-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-8-logang@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210928_121111_855369_A7C2889C 
X-CRM114-Status: GOOD (  11.87  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Sep 16, 2021 at 05:40:47PM -0600, Logan Gunthorpe wrote:
> Add a flags member to the dma_map_ops structure with one flag to
> indicate support for PCI P2PDMA.
> 
> Also, add a helper to check if a device supports PCI P2PDMA.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  include/linux/dma-map-ops.h | 10 ++++++++++
>  include/linux/dma-mapping.h |  5 +++++
>  kernel/dma/mapping.c        | 18 ++++++++++++++++++
>  3 files changed, 33 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
