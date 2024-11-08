Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8230ED12D74
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2024 04:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hubkZwx3K6QSYt4MPDN5HJUCdcIscdXdSF4J6blze28=; b=x6ABmWge8gZI0Su6XOJv5KhquC
	kQkAVkAlU1eR4sU11IinYFa3SY/GStBBTLquabNCOKq3EYufvzQIguB0OAMlwTGxY26OSYgrvliAt
	CtU6xaNsa+Lsl228fyNthrB6Y+2pjTBQ+vkQbeNDf96RDqApVgIQ1naCN1Omzvo7MfVUlP7KiP7ef
	7GoKoykCaDkGlubods/l3YoI61Ij8oSZxYpRP/3kesRGufotjdVReu9cmhhTs8ZM2IgsmL8cVM0UB
	JIKu2kNGYt0GSnOPQQZPpb783+VCp5nMuHTFtQCqR3CDmbn1xbMKS9JLpANPaYz7HUrs+Gyk5/wB7
	4HGNGNeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAMCM-0000000GKZk-39vT;
	Mon, 11 Nov 2024 04:38:46 +0000
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9QVL-0000000Awhv-3fg1
	for linux-nvme@lists.infradead.org;
	Fri, 08 Nov 2024 15:02:35 +0000
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-4608e389407so25214821cf.2
        for <linux-nvme@lists.infradead.org>; Fri, 08 Nov 2024 07:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1731078150; x=1731682950; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hubkZwx3K6QSYt4MPDN5HJUCdcIscdXdSF4J6blze28=;
        b=O9y41eW0KHnO2lEAPw6/nJLTU2tgg9dD3CahSlJPeaawjEND/H/3OZoQDhA/0d63Hq
         u/cvs1TSNHwPgRtBTZGHocYJK9R9Gw/pBoMblFN4laf0l9SVBOOv4AqfTJXH1x7lYncv
         L6UJ0i8KrXGGjUm0FkParMVVSoq7Et0ecczHWP6Ma6SZomQUKkWZ7fT1t4gbQ44rJzJl
         WIEu+KmQ3+vLkk3h6zOGnoI/BfZ0L/4OYQriE4CF/r7UFKG9fRSviLMl1Wm26LXNU79R
         2J2qFhSWIoCA+lCaEh0oHjk6eEcXS3Awp71XY16fHZML1Mmp7Z4A1uu/bmHKlt5BIp7V
         TMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731078150; x=1731682950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hubkZwx3K6QSYt4MPDN5HJUCdcIscdXdSF4J6blze28=;
        b=mYNRdHB2gz0LGBaF53EGLkhrkP0IgMSp+oFe/d8lokEYTkGmW1kpG00aFM5mPfyXOA
         dK9YFstYbWt/C7zqaA/YVAIhnSDRdRQgyoX4ffcHkbFzNsl2Miwfdoyi/UfPIcYHZ+rD
         MNMNpv+pRjzGYU9fiJKv9YGqTBiwE3X5tjnIKoLirGHW7r4OUzlq4NdF6+K99paT9bB1
         phYJgxe6xTO5VCPgvRWlf8VrVOpFMUBxYUK1fkyNuScyglyxRdPV8h8sbm/ky/XdYZqH
         dgLMzH6bgnqim9phUJXOCsKuRF0Iwc93PVSnk79nwII9724N0LfcXWwpUI0JBMqCE0xm
         DPWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKnEjNic3C3VE+ANiWGmNAPOox/ZQGYjo9BNzLDha9txsgHqHCQKO+pzxv828ryKgb4+ploFGU4wmT@lists.infradead.org
X-Gm-Message-State: AOJu0Ywa3lTcDYDUsiVa4/kRRm+wStCk6IqBJ28PhISq3r98Nm2biFlT
	DsM7joA89XT6BlcOrhhLJ6TJ9A+mkRQznQhkl/wgrHxzwQgf0gPSflZZZ6N9w+E=
X-Google-Smtp-Source: AGHT+IHrKrTFhKn6qkYBk/Mpkl+n+kU6F5VUVqIGxdFUtkBdvXhYcgcHiG/stLr7VzGEyxS593kC3g==
X-Received: by 2002:a05:622a:1a92:b0:461:17e6:27af with SMTP id d75a77b69052e-463093698f2mr35032151cf.28.1731078149644;
        Fri, 08 Nov 2024 07:02:29 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff3df53fsm21177001cf.8.2024.11.08.07.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 07:02:28 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1t9QVG-00000002ZlF-2kIP;
	Fri, 08 Nov 2024 11:02:26 -0400
Date: Fri, 8 Nov 2024 11:02:26 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, Leon Romanovsky <leon@kernel.org>,
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
	kvm@vger.kernel.org, linux-mm@kvack.org, matthew.brost@intel.com,
	Thomas.Hellstrom@linux.intel.com, brian.welty@intel.com,
	himal.prasad.ghimiray@intel.com, krishnaiah.bommu@intel.com,
	niranjana.vishwanathapura@intel.com
Subject: Re: [PATCH v1 00/17] Provide a new two step DMA mapping API
Message-ID: <20241108150226.GM35848@ziepe.ca>
References: <cover.1730298502.git.leon@kernel.org>
 <3567312e-5942-4037-93dc-587f25f0778c@arm.com>
 <20241104095831.GA28751@lst.de>
 <20241105195357.GI35848@ziepe.ca>
 <20241107083256.GA9071@lst.de>
 <20241107132808.GK35848@ziepe.ca>
 <20241107135025.GA14996@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107135025.GA14996@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241108_070231_972341_F583511C 
X-CRM114-Status: GOOD (  18.67  )
X-Mailman-Approved-At: Sun, 10 Nov 2024 20:38:44 -0800
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

On Thu, Nov 07, 2024 at 02:50:25PM +0100, Christoph Hellwig wrote:
> On Thu, Nov 07, 2024 at 09:28:08AM -0400, Jason Gunthorpe wrote:
> > Once we are freed from scatterlist we can explore a design that would
> > pass the P2P routing information directly. For instance imagine
> > something like:
> > 
> >    dma_map_p2p(dev, phys, p2p_provider);
> > 
> > Then dma_map_page(dev, page) could be something like
> > 
> >    if (is_pci_p2pdma_page(page))
> >       dev_map_p2p(dev, page_to_phys(page), page->pgmap->p2p_provider)
> 
> One thing that this series does is to move the P2P mapping decisions out
> of the low-level dma mapping helpers and into the caller (again) for
> the non-sg callers and moves the special switch based bus mapping into
> a routine that can be called directly.
> 
> Take a look at blk_rq_dma_map_iter_start, which now literally uses
> dma_map_page for the no-iommu, no-switch P2P case.  It also is a good
> use case for the proposed dma_map_phys.

It is fully OK? Can't dma_map_page() trigger swiotlb? It must not do
that for P2P. How does it know the difference if it just gets a phys?

Jason

