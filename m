Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89E0C35FFC
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Mar 2025 12:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kF/4SP83eP8Xbwc4RoYXxSygK8pZn4d3t2Dba+Ka8B8=; b=t8b5FFIGzBM2/Yu0AW6euOSAUc
	pClK88hQHuytEQmQ/PsVBf9mLalwVeNtC2dGYs7BUolJiw9DFLJaPD4zpWAXt52gve3WFEbF0KimQ
	pvQnk0iTgwGzr3plzk1MJRdKQp0jFztiJunoi25nK1kMZhyqKRNHr7dYK8EppZTjNaW5Ad80cqqPo
	VAEM18kfrBwxwCOdU4P9abCfV+PlXH9igw3jcfvw+tlLJ838Xopk+Ruld4nJ3qm5YhHMeHe0yfCkh
	5n+RApHTPK19mej4aOZqX+VbP+Fm6Yx3hOsepiDBoCuiMb5lVanYE4dh4lGARReueJyc4ZMaLS+4I
	E4a7owVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tx3ey-00000005uhP-3X9X;
	Tue, 25 Mar 2025 12:45:36 +0000
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tx3WL-00000005qhT-0Rkf
	for linux-nvme@lists.infradead.org;
	Tue, 25 Mar 2025 12:36:42 +0000
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-47688ae873fso56414221cf.0
        for <linux-nvme@lists.infradead.org>; Tue, 25 Mar 2025 05:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1742906199; x=1743510999; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kF/4SP83eP8Xbwc4RoYXxSygK8pZn4d3t2Dba+Ka8B8=;
        b=XVUpljJrmU1ISmnNE2UXijM4mu+m+kZySn3wBmwrM35U0KFjXRvBeuAYwQiqoxVyvq
         KDWekrCQx8oEN+s4iNVT2CiGyY1xbkVthp9dqS01H3ZxA7eWk170mOLZknIE6Ea0HMpH
         O/n8NZaiN3TY/+nvOWM8LffmuSEozuzR7d8M5qjln+6166tT95UhsCfj5GevoUEPxUMP
         1xtOLmUaOLE7ofanNXEWIrZK9b+ToteAiPuVuvcgJa49XnseEZQfyOM84grsF9gCnLm8
         BsHfqNqrr9Ug8ihy7KeBaRVszO4xNYLluR38b80/h6fvZnvJklrzCajdM6wfi0f0NgSh
         57Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742906199; x=1743510999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kF/4SP83eP8Xbwc4RoYXxSygK8pZn4d3t2Dba+Ka8B8=;
        b=AIWNqDK+96K7b+5NwxLqy1zQen1Rddb9j8moR1yCgCEDUIXL4nXUDw8f82mJvmKRZv
         7myNZ5liEoe1YeZH/I+3hYhSBNXZSB37nrjOzmGfl4ukPZCJ/eC+wo4NcVuY0KWXVAKC
         v9heZUCvSVYC6MBuBpznpLKtW8npmkQB3KnjN/zF+Ch9O6bBuQKc3kBVQtODSyufYRpl
         GvlOjPCveWpvs/P8HBOetXonEYqR2Jy56+pVI/XMuu59wY4McmAoec/BCS1i1MwVeyao
         0lvAzAa8pnvL9PF+TwAb+39MrvBlCmohw3Vu19pqVffQh3ZZxEYGq/ML1Cs3DuVOfoMP
         yNkA==
X-Forwarded-Encrypted: i=1; AJvYcCU4sbMndhS5ycLVEllZ4IEBVFlE5i7phcDnUc5fQC5IWOlacYAPPDnHAAYxYoXsrz6NCrXo+6EXrP1N@lists.infradead.org
X-Gm-Message-State: AOJu0YwoSg+2Mx2EnfakLFkKyOt2qR+HmOUuYCv/fjvoBDpX15VyZM1H
	tsyQwlU/6fbSrd//IyqTBKshyUBKzCh5lz44sRKk+CPoPTUtMR30J+0WOrJNF4g=
X-Gm-Gg: ASbGncu1BcFjk7gwtmFBQKXmnIM9dA+PX0QP3Y+uZGw0Lalbsd4iFwkBdmxHMsD+I3f
	U91yQUnauiVC7JfYAPQQmXtY2FbC8q+K3l8yeCMHh2JhS1GSbo2YJqwMbQyrXg7sbp0DzwpS2Bt
	jgBHUkrNIg3X6BRvKXa9+FAp9GU0q6rO0FslmE5oSpaGyblmV8rPX1BOZESZ2GtxTeXzC1oP/BR
	/evq4pQ2mmbRUaJ1eyK0C6OcUhOHiSV3p3WsD2Ydzqv2aka4TZ7N7eXuhQluD0lIIZVXzX8PXXJ
	CJuD0RjIjt6MTm/X5g==
X-Google-Smtp-Source: AGHT+IFaGG2Y6kZs0f1G4EEOh4+V+xY6UlM60nMPDSox/R89SepA61uky3NuOhrbXo7zMnxqikKbBQ==
X-Received: by 2002:a05:622a:4106:b0:477:cc4:cb76 with SMTP id d75a77b69052e-4771dd54452mr310138501cf.3.1742906199124;
        Tue, 25 Mar 2025 05:36:39 -0700 (PDT)
Received: from ziepe.ca ([99.209.85.25])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d63597dsm59500991cf.71.2025.03.25.05.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 05:36:38 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1tx3WH-0003AX-NS;
	Tue, 25 Mar 2025 09:36:37 -0300
Date: Tue, 25 Mar 2025 09:36:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
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
	kvm@vger.kernel.org, linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v7 00/17] Provide a new two step DMA mapping API
Message-ID: <Z+KjVVpPttE3Ci62@ziepe.ca>
References: <cover.1738765879.git.leonro@nvidia.com>
 <20250220124827.GR53094@unreal>
 <1166a5f5-23cc-4cce-ba40-5e10ad2606de@arm.com>
 <20250302085717.GO53094@unreal>
 <e024fe3d-bddf-4006-8535-656fd0a3fada@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e024fe3d-bddf-4006-8535-656fd0a3fada@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250325_053641_282690_1874AF1B 
X-CRM114-Status: GOOD (  24.67  )
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

On Fri, Mar 21, 2025 at 04:05:22PM +0000, Robin Murphy wrote:

> What everyone seems to have missed is that while it is technically true that
> the streaming DMA API doesn't need a literal struct page, it still very much
> depends on something which having a struct page makes it sufficiently safe
> to assume: that what it's being given is valid kernel memory that it can do
> things like phys_to_virt() or kmap_atomic() on.

No one has missed this, we are not yet at the point of implementing a
non-struct page PFN only path. That is going to be a followup series,
and yes there are going to need to be some cases where DMA will get
EOPNOTSUPP. You can't swiotlb something without a kmap, or MMIO for
instance.

> efficiently. And pushing the complexity into every caller to encourage and
> normalise drivers calling virt_to_phys() all over (_so_ many bugs there...)

That is unlikely to be how things end up.

> and pass magic flags to influence internal behaviour of the API
> implementation clearly isn't scalable. Don't think I haven't seen the other
> thread where Christian had the same concern that this "sounds like an
> absolutely horrible design."

Christian's perspective is thinking about DMABUF exporters using CPU
PFNs to mmap them to VMAs. Which is a uniquely DRM API abuse.

I think everyone who has really dug into this stuff understands that
the driver that is going to perform the DMA should be the one to do
the DMA mapping. It makes little sense for the driver providing the
memory to do the DMA mapping on behalf of the driver programming the
HW for DMA.

Regardless it doesn't really change this series as the same DMA API
interface to the driver is required to do the work. It doesn't matter
if the DMABUF API puts the calls on the exporter or importer side of
it's API.

> So what is it now, a layering violation in a hat with still no clear path to
> support SWIOTLB?

I was under the impression Leon had been testing SWIOTLB?

What does "no clear path to support SWIOTLB" mean?

Jason

