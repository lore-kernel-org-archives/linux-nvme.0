Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E34C43334
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jun 2022 17:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GuOinXdzP0oJ6BfwGVGRF9opnqUN4LYO3Y/RmknOScs=; b=ksuPSZhNwhFdvGBn2SnJVy+KxH
	+QEvKvJc63UoMPfiryKCkaivRORQmyDCMT/4Z8xbhTSHt/+tiZs6de9epqxWgSu0/9OSWIpRsc2uF
	YjQEEgNKxqXGWMKuehMEnsL5RTJvPmlX55PO0liqBpT6A2A4nBdD6kHSPhtg3oL+pAoDIBZfvG5Ob
	9ztje41ehuZN05gjslF530ARyvIKXwArlMifxgSzkLLN0srnbQzBjeznoIGJqigYjby8h+n25t0BI
	sa6WxpDrZICrDUndNQBRgZBu3KbH4m8TzwRoWnCX2WVps1mt8zZu2oQLO3G3Mx0XSx+mrHKPXr+hs
	+b6547dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwocK-003rB7-Of; Thu, 02 Jun 2022 17:28:16 +0000
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwocI-003rA6-5b
	for linux-nvme@lists.infradead.org; Thu, 02 Jun 2022 17:28:15 +0000
Received: by mail-qk1-x72b.google.com with SMTP id m68so4144957qkb.9
        for <linux-nvme@lists.infradead.org>; Thu, 02 Jun 2022 10:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GuOinXdzP0oJ6BfwGVGRF9opnqUN4LYO3Y/RmknOScs=;
        b=nERzx0gJZv2PpNEuSU7ZGuwa6QR4KAFkZQcX+7G15YcgRySvW6qb9+1khratoVExRd
         E2cV1E+y5eNUdrv7iEhYvw6adm9tR0J0w0Y5RG/qlzn3N/ExPpw5VFSVcBiyiAfseShj
         RtXbQnx/36eWCdWlBGeV1GIY74fg8syx0d0tBb6JCdM+OFqTrueuf3t4tmn+ivjrfwFi
         G+YqxQ/XoZIxp/zm5ZUgHxZvv3ENrre3J5G2iipdg5D6ioSBpapAVxA8rxNBc3hfH6JN
         xgR8Rb7bKKjuhDjx6rhbKloVBy4fbfQj9wlUkZziCVhgTTnOfjGMKfLsZNNy+YXFPJkc
         II8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GuOinXdzP0oJ6BfwGVGRF9opnqUN4LYO3Y/RmknOScs=;
        b=La2XMgW79L6NBeci1r3jaJ+SUkbmd+SXK4Dc85t/RJg11w65b94o4izgck2ysyjiIN
         RScxmA5zc78DyVqN5FMWwf4Co3sakAdZPg/4k2dcCwlJf4z+EhVejfh1Lfsc3ZOmkwno
         /MQg4EomKLJ4EH3cf7hFLQWri/ow2ZBm4g7nTz4qU5eehyo6UV9tzEU7qf3mu6J0XNCX
         Bkhp1cZDTN/CXRqy2MWXjI9SGs3cKposlfPU0MiBDd4sotH9bwvEXiisM367gUN3IXAT
         YfSte/eCqvdC4RZXOD+GAcU8QiKI46ExTMzphIREZ3IRdQWSTrUHA6/nrYD8NAnDtR86
         xzjA==
X-Gm-Message-State: AOAM533B4xN2A1EP5XsvVIzXvxDx90bS+RsJ2hdUVDuYZPJTeeLbjJR9
	ihQLAGfChnhCI7vOv6JhcsGf/g==
X-Google-Smtp-Source: ABdhPJxtqXs49dqqYwrrFL2D/sBWEpVH5naaCbeJ3Pryu+awdiRfY3cTorJuf9ghsWhGGy5AkAoh5A==
X-Received: by 2002:a05:620a:f0d:b0:67e:1c14:bc5e with SMTP id v13-20020a05620a0f0d00b0067e1c14bc5emr3899163qkl.502.1654190892765;
        Thu, 02 Jun 2022 10:28:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id q188-20020ae9dcc5000000b0069fc13ce1f2sm3649937qkf.35.2022.06.02.10.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 10:28:12 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
	(envelope-from <jgg@ziepe.ca>)
	id 1nwocF-00GUaJ-Fg; Thu, 02 Jun 2022 14:28:11 -0300
Date: Thu, 2 Jun 2022 14:28:11 -0300
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
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	Ralph Campbell <rcampbell@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v6 20/21] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
Message-ID: <20220602172811.GN2960187@ziepe.ca>
References: <20220407154717.7695-1-logang@deltatee.com>
 <20220407154717.7695-21-logang@deltatee.com>
 <20220527125501.GD2960187@ziepe.ca>
 <a2590e27-41e8-59dc-3576-b5b8d716a198@deltatee.com>
 <20220527190307.GG2960187@ziepe.ca>
 <d336cfe8-2451-04c3-a2ce-0e8e47afd1e3@deltatee.com>
 <20220602000038.GK2960187@ziepe.ca>
 <400baba7-1cd6-09d4-4de9-2a73f08afc79@deltatee.com>
 <20220602163059.GL2960187@ziepe.ca>
 <51cc6645-2504-6d01-5626-238ed6ffff04@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51cc6645-2504-6d01-5626-238ed6ffff04@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220602_102814_236977_1FA086C8 
X-CRM114-Status: GOOD (  22.40  )
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

On Thu, Jun 02, 2022 at 10:49:15AM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2022-06-02 10:30, Jason Gunthorpe wrote:
> > On Thu, Jun 02, 2022 at 10:16:10AM -0600, Logan Gunthorpe wrote:
> > 
> >>> Just stuff the pages into the mmap, and your driver unprobe will
> >>> automatically block until all the mmaps are closed - no different than
> >>> having an open file descriptor or something.
> >>
> >> Oh is that what we want?
> > 
> > Yes, it is the typical case - eg if you have a sysfs file open unbind
> > hangs indefinitely. Many drivers can't unbind while they have open file
> > descriptors/etc.
> > 
> > A couple drivers go out of their way to allow unbinding while a live
> > userspace exists but this can get complicated. Usually there should be
> > a good reason.
> > 
> > The module will already be refcounted anyhow because the mmap points
> > to a char file which holds a module reference - meaning a simple rmmod
> > of the driver shouldn't work already..
> 
> Also, I just tried it... If I open a sysfs file for an nvme device (ie.
> /sys/class/nvme/nvme4/cntlid) and unbind the device, it does not block.
> A subsequent read on that file descriptor returns ENODEV. Which is what
> I would have expected.

Oh interesting, this has been changed since years ago when I last
looked, the kernfs_get_active() is now more narrowed than it once
was. So manybe sysfs isn't the same concern it used to be!

Thanks,
Jason

