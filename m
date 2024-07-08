Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57D5C3271E
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jul 2024 23:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w81yhK/4eC4FICM5BdCB5730Wjijfv+GUBmbab3qDKE=; b=xxILW4tQmPQSrCXsnRDP9bibdV
	NbNEn9z2WzwxOASfn0M62gOm6b7zogYuLNSW7B905SfNj0EKaEftQ813Kas8yMASFBOAU0q9wtLwI
	bAtGSilrTFxQGHqqz/yDY34CyjWyhr5bSi2QhLqT2E33kmlmmphUT+UUHGB4qTaaGTP7rzoumwgDH
	NCR5qSw7zV86IRV2wwAHk5+X7VF002aIF7k+BJ6ye0Lu5sA42xj03xWgyWOnbg81E8r8gQrxsoXWF
	Ujnieb3s/7ylYqCQbbiGXtsgUxdj7jvYPzU1vsW9tg/wjEAXG1+lUt8D3fS13eccUnLX6wXUqVcXq
	VLxXLj1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQyEY-00000005NBe-3kXM;
	Mon, 08 Jul 2024 23:57:26 +0000
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQyEW-00000005NB6-0uc8
	for linux-nvme@lists.infradead.org;
	Mon, 08 Jul 2024 23:57:25 +0000
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-e02748b2402so4937775276.0
        for <linux-nvme@lists.infradead.org>; Mon, 08 Jul 2024 16:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720483042; x=1721087842; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w81yhK/4eC4FICM5BdCB5730Wjijfv+GUBmbab3qDKE=;
        b=a6qDCWi4pNbkFYf5qw8fKW7X5e8UZpqJjIWQx0B10ONq16zpXhDpFa1d9TgnexZCW4
         IQkZm46zeRe+kSbkzP1gDTtbSplsGuv6cjSQVJpMBnl95a1omAYoyicM+3lH9qFkytKP
         2PhXIt7TpNdf3oh/jKNL3fdND5HpoW6eHHDF3VWF+jrO3yA96AB1IhaPLBYy1S/VF9bW
         ItbkN0dC+eC8GwiSKB4zJ1oJ+Ij6G5oyddDVv6DwVFl6vT7wgs48Cq8lLIEegH+WP9J/
         skIWJy0sPrYsNDGsIva8WsejTTt4WeQHLAUyK+q0rA+G9W/dMtAPDK3FW3aKjq27GQaF
         QGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720483042; x=1721087842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w81yhK/4eC4FICM5BdCB5730Wjijfv+GUBmbab3qDKE=;
        b=qW+l/8cvJT79XmkyojcNBOwnoZD2tmRGags1DBVZJ2m90ilt6i2K8SOY0J+47fJmJM
         RL60Co5a1ZSeykV+Rq1nXcuU0Ib/wMyQTu3dN7Akx+HCJ0X5T+vvNotNe0vTX4ZVmt4J
         5AB01IAqn4DS35K6OYWOOuHQzQOHyAPMqLwZPho2lFfLkBg0Ynp3YMN3SpRLRbjL1RRu
         651aKUDqQLTHcq1QozikcIsZSi2FxtWxdpekWM29wcYNTMRo33yWi+whdnTzYDaV/RgW
         4yQIHJP4KE36cIcnGENba4iAAsQW1SblRqcnF8vJgs9J/vrp452qrNi/YkqWnTSdrTXa
         vygw==
X-Forwarded-Encrypted: i=1; AJvYcCVMTD3BRYkn8+WhWWdkAXicWh4HAS861z5fxOXfsNVwJIkm3sTYFmWzX8MtxQeMnfU8mk07kEHaPj5NE6WP9X1kU4UTljyTpgL4egdpl4s=
X-Gm-Message-State: AOJu0Yzr5jUHtSlvAv+QopwPIwyQnA04pStkLYiTb3W8dsmelftieH44
	G3CFkw9Us3zEOlN5ctwwpMDTa62Rg7MpcVI0QSWZX2JN3jU12bnS0SF0qaVKw/A=
X-Google-Smtp-Source: AGHT+IFVd0YPFm+CFj+OFAbn4VlgzR0c7GB9Ja/EMJb3su7krIj2ap0s4sP+8C7C1jj96rzmX8e+3g==
X-Received: by 2002:a25:d694:0:b0:e03:b14e:350f with SMTP id 3f1490d57ef6-e041b125e84mr1427037276.50.1720483042570;
        Mon, 08 Jul 2024 16:57:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61ba8ad1esm3902106d6.105.2024.07.08.16.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 16:57:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sQyET-0014tP-5Q;
	Mon, 08 Jul 2024 20:57:21 -0300
Date: Mon, 8 Jul 2024 20:57:21 -0300
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
Message-ID: <20240708235721.GF14050@ziepe.ca>
References: <cover.1719909395.git.leon@kernel.org>
 <20240705063910.GA12337@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705063910.GA12337@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240708_165724_390357_F60D83D4 
X-CRM114-Status: GOOD (  18.16  )
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

On Fri, Jul 05, 2024 at 08:39:10AM +0200, Christoph Hellwig wrote:
> Review from the NVMe driver consumer perspective.  I think if all these
> were implement we'd probably end up with less code than before the
> conversion.

One of the topics that came up with at LSF is what to do with the
dma_memory_type data?

The concept here was that the new DMA API would work on same-type
memory only, meaning the caller would have to split up by type.

I understand the block stack already does this using P2P and !P2P, but
that isn't quite enough here as we want to split principally based on
IOMMU or !IOMMU.

Today that boils down to splitting based on a few things, like
grouping encrypted memory, and grouping by P2P provider.

So the idea was the "struct dma_memory_type" would encapsulate
whatever grouping was needed and the block layer would drive its
splitting on this, same structs can be merged.

I didn't notice this got included in this RFC..

The trivial option is to store the dma_memory_type per-BIO and drive
the de-duplication like that. The other could be to derive it from
first entry in the bio_vect every time a new page is added.

This same-type design is one of the key elements of this API
arrangement - for RDMA I expect we will need a data structure storing
a list of types with a list of pages, and we will DMA map type by
type.

Jason

