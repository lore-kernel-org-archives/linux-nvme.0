Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D89BC25B10
	for <linux-nvme@archiver.kernel.org>; Fri,  3 May 2024 16:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9MCkvEl6vfBsR3xGXbm5ipuSQzsyNXlO2daQS9IANas=; b=0N1E2Ze8qWiaGlzfzL+ATRSQl+
	0OiF2KicJTX4s4+JP61jgFtmzfL44AmMKFgCc3oleHVfuHT5aUA5BO2YJ7iFObDHBJleRq48jau+x
	p10tEH8OECDFCPWo5jYrLvr2gM9NEXrktCR1fDy2cvchpzmvEOrJI4WN/3Xv/gqhxagMdoG3qaVjZ
	/EWN594lz9ot88O72DYyHgDiZfnYr1Y1SHO3R+HWSKzH1Uhu9Gm8HDRdAbWoufqQB70W7kZxekMnz
	qgGjWjqqbYZqYP9j20jIFzoubAq6hy7YtUORYAZD6z3l7S+LCDMQ3YNLhla+0+Gtsr6U+VLfuBaiI
	sD2PaGnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2w1Y-0000000HHBq-1cUS;
	Fri, 03 May 2024 16:44:40 +0000
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2vzf-0000000HGet-3RTA
	for linux-nvme@lists.infradead.org;
	Fri, 03 May 2024 16:42:45 +0000
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6ee575da779so2762992a34.2
        for <linux-nvme@lists.infradead.org>; Fri, 03 May 2024 09:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1714754561; x=1715359361; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9MCkvEl6vfBsR3xGXbm5ipuSQzsyNXlO2daQS9IANas=;
        b=PkTLdhNLHc1ulYv0nnGdsfe4JAIQQMJjGUsL7mMQtqMo6dBlIhADFDBXiKl5h2FJ9b
         0ymI8Z3TUoo4WVkHlK5kwIwEnMEdn7+y2j2Bu5Jjd0hQcy+I4L/M4pM8bKyCYffg1iAv
         z+/S0gSYhpVPryQzqe71dAItBiSybmfjDgABtdouBirh3P+AQVVPSWYqIOg6QjZP6EkH
         /ZXf0lnQNXoxq5woB94AgDo40EZb4OZmi4Mhaqe2qwzmFzg7F4gZxNgqe+3B9e1EC8nZ
         +n7TWFxnKOSm9P/wKMDDq/nsXIcE2gtV71TRepQtDIp7lHOQt9A8+ncXmxYi4Kj4EV1i
         36/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714754561; x=1715359361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9MCkvEl6vfBsR3xGXbm5ipuSQzsyNXlO2daQS9IANas=;
        b=RpP2huCCB2UaNGhoLXHweS1fu+yUI29SDX3IhCR5O7YGUZJcqXowbFdoSf4a6+a3Aj
         BYVbrP8yS+JO2DOxMSR88WXto7J0wY3tE0v9r46XIfdlbzPtLye6AejwuqbX8r1c7n8B
         zUaDJ+mGamaoMoh7l+2Gz3lF8iBoDdsTyQpjyb6PUliaM5yio5OnKQjXzeGMId9SGhZ6
         K2SFJoU45+pnXdzK/tKSu7LhPFy0+GZ6AWdgaplY2ekXG60aQWQUgOVjRJonhK09Qgri
         JY6Jes+mt+dURl18XUbv0rLzbvXW53RdtbMFLKjhPVVkQxm5+9cFMhgBBKSq7SFvSQvW
         StWg==
X-Forwarded-Encrypted: i=1; AJvYcCVUGGGkGcDXF/vFx0iFnmyHN8lOYTBbOS6c3tu1hoZtMn4HM7HQfpj2pl2wxLwB710Jc9xL73nNubljB0i0JxGila8B6WCDlJqH/2rY97o=
X-Gm-Message-State: AOJu0YxhmX1p0bEJH2+tXOrsryfWPkbK0h3CqsAQWIs991XeJTMmgFTE
	vwJGhnhbUGoMIVkMquDY6I0xEfnxbnONRit2MrdEc2dXTGyplNTCFKlXWzW0B+o=
X-Google-Smtp-Source: AGHT+IFVT2rAsXVdMpvr8pAPF1WuNA1CE6Xv9L67MOMLKugSh13tMbQmSyNxDuuJNWHb/QOcrYHVYQ==
X-Received: by 2002:a05:6830:33fb:b0:6ee:1cc5:68c3 with SMTP id i27-20020a05683033fb00b006ee1cc568c3mr3499852otu.12.1714754561211;
        Fri, 03 May 2024 09:42:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id ca14-20020a056830610e00b006ee5b409f23sm701317otb.22.2024.05.03.09.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 09:42:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s2vzb-007ETb-4i;
	Fri, 03 May 2024 13:42:39 -0300
Date: Fri, 3 May 2024 13:42:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Zeng, Oak" <oak.zeng@intel.com>
Cc: "leon@kernel.org" <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"Brost, Matthew" <matthew.brost@intel.com>,
	"Hellstrom, Thomas" <thomas.hellstrom@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Amir Goldstein <amir73il@gmail.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"jack@suse.com" <jack@suse.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [RFC RESEND 00/16] Split IOMMU DMA mapping operation to two steps
Message-ID: <20240503164239.GB901876@ziepe.ca>
References: <cover.1709635535.git.leon@kernel.org>
 <SA1PR11MB6991CB2B1398948F4241E51992182@SA1PR11MB6991.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR11MB6991CB2B1398948F4241E51992182@SA1PR11MB6991.namprd11.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240503_094243_995328_7B51905F 
X-CRM114-Status: GOOD (  37.26  )
X-Mailman-Approved-At: Fri, 03 May 2024 09:44:38 -0700
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

On Thu, May 02, 2024 at 11:32:55PM +0000, Zeng, Oak wrote:

> > Instead of teaching DMA to know these specific datatypes, let's separate
> > existing DMA mapping routine to two steps and give an option to advanced
> > callers (subsystems) perform all calculations internally in advance and
> > map pages later when it is needed.
> 
> I looked into how this scheme can be applied to DRM subsystem and GPU drivers. 
> 
> I figured RDMA can apply this scheme because RDMA can calculate the
> iova size. Per my limited knowledge of rdma, user can register a
> memory region (the reg_user_mr vfunc) and memory region's sized is
> used to pre-allocate iova space. And in the RDMA use case, it seems
> the user registered region can be very big, e.g., 512MiB or even GiB

In RDMA the iova would be linked to the SVA granual we discussed
previously.

> In GPU driver, we have a few use cases where we need dma-mapping. Just name two:
> 
> 1) userptr: it is user malloc'ed/mmap'ed memory and registers to gpu
> (in Intel's driver it is through a vm_bind api, similar to mmap). A
> userptr can be of any random size, depending on user malloc
> size. Today we use dma-map-sg for this use case. The down side of
> our approach is, during userptr invalidation, even if user only
> munmap partially of an userptr, we invalidate the whole userptr from
> gpu page table, because there is no way for us to partially
> dma-unmap the whole sg list. I think we can try your new API in this
> case. The main benefit of the new approach is the partial munmap
> case.

Yes, this is one of the main things it will improve.
 
> We will have to pre-allocate iova for each userptr, and we have many
> userptrs of random size... So we might be not as efficient as RDMA
> case where I assume user register a few big memory regions.

You are already doing this. dma_map_sg() does exactly the same IOVA
allocation under the covers.
 
> 2) system allocator: it is malloc'ed/mmap'ed memory be used for GPU
> program directly, without any other extra driver API call. We call
> this use case system allocator.
 
> For system allocator, driver have no knowledge of which virtual
> address range is valid in advance. So when GPU access a
> malloc'ed/mmap'ed address, we have a page fault. We then look up a
> CPU vma which contains the fault address. I guess we can use the CPU
> vma size to allocate the iova space of the same size?

No. You'd follow what we discussed in the other thread.

If you do a full SVA then you'd split your MM space into granuals and
when a fault hits a granual you'd allocate the IOVA for the whole
granual. RDMA ODP is using a 512M granual currently.

If you are doing sub ranges then you'd probably allocate the IOVA for
the well defined sub range (assuming the typical use case isn't huge)

> But there will be a true difficulty to apply your scheme to this use
> case. It is related to the STICKY flag. As I understand it, the
> sticky flag is designed for driver to mark "this page/pfn has been
> populated, no need to re-populate again", roughly...Unlike userptr
> and RDMA use cases where the backing store of a buffer is always in
> system memory, in the system allocator use case, the backing store
> can be changing b/t system memory and GPU's device private
> memory. Even worse, we have to assume the data migration b/t system
> and GPU is dynamic. When data is migrated to GPU, we don't need
> dma-map. And when migration happens to a pfn with STICKY flag, we
> still need to repopulate this pfn. So you can see, it is not easy to
> apply this scheme to this use case. At least I can't see an obvious
> way.

You are already doing this today, you are keeping the sg list around
until you unmap it.

Instead of keeping the sg list you'd keep a much smaller datastructure
per-granual. The sticky bit is simply a convient way for ODP to manage
the smaller data structure, you don't have to use it.

But you do need to keep track of what pages in the granual have been
DMA mapped - sg list was doing this before. This could be a simple
bitmap array matching the granual size.

Looking (far) forward we may be able to have a "replace" API that
allows installing a new page unconditionally regardless of what is
already there.

Jason

