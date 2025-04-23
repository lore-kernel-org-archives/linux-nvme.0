Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3983AC369D8
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 02:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L7oRP2YqJwVB6GeEu4BqvXzZqclhisHpp0fN6LY14JQ=; b=csLe4/FhdTIa0y4WpfyYaFXUQH
	cfMZH4xGyLAsrk0ZTcLXoQSW2bZaKX+LUyRUrlsrepMr9JKaxQx4DyDN6eqh5Fed/9xw0RsNdvPi1
	vrzvEOSrWG6j8DyOihvOWVki/mjbWA50oi6xeSGCKGx3HZ2o9TqYxuYRMGJxND4POiM6V9i44flf4
	efoOwYx6DgPv8dAg3V1AM5K3xNP5TeZAxbiL8rN+LaGB5s/sFxzhV8c+vHvXB8I93iqeLOGQeXPQK
	3R4JCzQUQmswPZ835qO5ryrj4QHt3928fb+t/MffRkHs8K3usYOp61SO44bgq1z2MyJ367HMtLp+m
	Z3sJutmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7mn2-0000000Cf9H-2klr;
	Thu, 24 Apr 2025 02:58:16 +0000
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7jb0-0000000CHP0-0HnW
	for linux-nvme@lists.infradead.org;
	Wed, 23 Apr 2025 23:33:40 +0000
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-477282401b3so4518371cf.1
        for <linux-nvme@lists.infradead.org>; Wed, 23 Apr 2025 16:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745451216; x=1746056016; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L7oRP2YqJwVB6GeEu4BqvXzZqclhisHpp0fN6LY14JQ=;
        b=kxmCpJrZaA51+J5Y8jFFaGEpik2cr2Qfxzn4v5ZHTIqYEkRjVf256PtxQNZsoCXCkz
         2JiYHbbNeSVu0GDEYKwST5UymvGrMQFx372gTgqPfnL1fXBf3+hU6VDMlc/WtFjEfME9
         UZXxv+56ta+5bCIsOD6x0hbu1H2ovmDSeKxepy4FVsFHLQSkuFh4GprIJuuOSzdXCflQ
         miVgAcyJr1TtrP2MmvClfLjMkJxAYQBLmjSSFzH5IwFeV4H4C1e/xHQXRZwdZLboSkTe
         ern9644BrrEsvFG3A5S1FyUomtMPh8INBTs7uS0YOCgJQ+fuyFmUk1SAIe/pf0vvgR4d
         ZXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745451216; x=1746056016;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L7oRP2YqJwVB6GeEu4BqvXzZqclhisHpp0fN6LY14JQ=;
        b=nh2Ubew7Zgnb1VI71kHLzPDBjRTsELRZwY/2bM3+UsAMW705Ttk4G1sXeHT+WE62+8
         ur67A2Ce+U+RKGK1dX4G3fQUI//620fsbNfZju+32Mo7xMMvIjfX3ZZrVjH4JC27hIZv
         x8k0zQidGQw3nbcStYjqSYIiY3+hn5kI4SjvCfcz29Pk2KFHi8q7/Xh3Mvx2DeBFtO/D
         l0u2L6xi6p6clmFFzh4jGUN4H36gS92XUK50YPrjVH7MsXgMscnsMya5vYIo5jPIitFP
         zRH71LDgsIWtd+nsGqtpcxX1uGbT9Ue54jMYyN3fg72r/BRgb8v899cOxemPC3hiIbmp
         jWCw==
X-Forwarded-Encrypted: i=1; AJvYcCXKwk2AEJ55B+h64ZhtOm8Gzqz7ihd39dC2hjU1dHvA0Ao8WMaHeEtqnGQHNRijiBuynDOsI4wCi+5Q@lists.infradead.org
X-Gm-Message-State: AOJu0YxvsOyDkIBRs6pxp4xRfC8z7v0o/cwTS6vjcOZajpp87SudGYC4
	psH4AabzCIb/uFPhmi+sb8o/YPHvH+s2z0FxxH9U0jhR7nLqqTuUZb5VTdAiv2A=
X-Gm-Gg: ASbGncuax8vWa73duPn2zf/+iUy3GTn1xTV5kkAb1xJSjmCAvR+eKjnd2vtmCf2hPHo
	oZsfvjBpnsY38mIC71AVsLo7IXt8PlZjGBMb7j21F39bih7wzKhVvzN49mDoTxNigQTMSPZCsPc
	vaOI75O6OYE01EmUV/oMWoiYqBoFfRLwyb01wx1hHEUrjQP5hfLctAjYezl4nUf3pFZK7KGr28c
	CPEMmDuMK5quPkgpaSsVCIDwRKHlvzBXrOA3MGz/VEytn/yQanMwV3axGU4aU25KqBST1wmcJn2
	zCZX4uhKG8STLj6eSlzJdSdU1YpO5N8RAM7Eg4YF4ebc2Zgg70lxCPKzgHM2vYZaSr/bWxgqZzF
	mnpIV34VoXMoZHm0QIKM=
X-Google-Smtp-Source: AGHT+IHp4LWhqR/rJc6pqFU95w2BqdqjYtJ4SAe1Mvc/v+Ufccgyj7hWc7Mm96oBr3hzP4lBlnfnCQ==
X-Received: by 2002:a05:622a:388:b0:476:b783:c94d with SMTP id d75a77b69052e-47eb4fbb928mr6490361cf.35.1745451216599;
        Wed, 23 Apr 2025 16:33:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ea1ba154asm2538601cf.67.2025.04.23.16.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 16:33:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7jax-00000007PKl-19Zx;
	Wed, 23 Apr 2025 20:33:35 -0300
Date: Wed, 23 Apr 2025 20:33:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mika =?utf-8?B?UGVudHRpbMOk?= <mpenttil@redhat.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
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
Subject: Re: [PATCH v9 10/24] mm/hmm: let users to tag specific PFN with DMA
 mapped bit
Message-ID: <20250423233335.GW1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <0a7c1e06269eee12ff8912fe0da4b7692081fcde.1745394536.git.leon@kernel.org>
 <7185c055-fc9e-4510-a9bf-6245673f2f92@redhat.com>
 <20250423181706.GT1213339@ziepe.ca>
 <36891b0e-d5fa-4cf8-a181-599a20af1da3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36891b0e-d5fa-4cf8-a181-599a20af1da3@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_163338_112192_ECD66272 
X-CRM114-Status: GOOD (  16.54  )
X-Mailman-Approved-At: Wed, 23 Apr 2025 19:58:12 -0700
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

On Wed, Apr 23, 2025 at 09:37:24PM +0300, Mika Penttilä wrote:
> 
> On 4/23/25 21:17, Jason Gunthorpe wrote:
> > On Wed, Apr 23, 2025 at 08:54:05PM +0300, Mika Penttilä wrote:
> >>> @@ -36,6 +38,13 @@ enum hmm_pfn_flags {
> >>>  	HMM_PFN_VALID = 1UL << (BITS_PER_LONG - 1),
> >>>  	HMM_PFN_WRITE = 1UL << (BITS_PER_LONG - 2),
> >>>  	HMM_PFN_ERROR = 1UL << (BITS_PER_LONG - 3),
> >>> +
> >>> +	/*
> >>> +	 * Sticky flags, carried from input to output,
> >>> +	 * don't forget to update HMM_PFN_INOUT_FLAGS
> >>> +	 */
> >>> +	HMM_PFN_DMA_MAPPED = 1UL << (BITS_PER_LONG - 7),
> >>> +
> >> How is this playing together with the mapped order usage?
> > Order shift starts at bit 8, DMA_MAPPED is at bit 7
> 
> hmm bits are the high bits, and order is 5 bits starting from
> (BITS_PER_LONG - 8)

I see, so yes order occupies 5 bits [-4,-5,-6,-7,-8] and the
DMA_MAPPED overlaps, it should be 9 not 7 because of the backwardness.

Probably testing didn't hit this because the usual 2M order of 9 only
sets bits -4 and -8 .. The way the order works it doesn't clear the
0 bits, which I wonder if is a little bug..

Jason

