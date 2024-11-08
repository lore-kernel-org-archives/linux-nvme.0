Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F5D7D12D73
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2024 04:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7sMW5Kuv5sIzIjhBbBygI9fJdJpSk6eqM7+xgs0I9dY=; b=qxwf5glZ7HckjpafnirKAkdX85
	GSNuNu6vKYrElHkCOtG5aR5Eh3ZB6WiADauERfLc+HP9ohWyGjB2oNS/39620mc6C/G/UwXMKXgr3
	auAQC6BqLObQOkg8qZo9NZGbaG/Z+6H4xJpD0zKlI+O0p+sIKVT20AlQL+l6zYYMvqDqi74X/jBpw
	arzH4W4D2i5SPWp8Git8moxvZvBE6oOpsR8MuHrzwWAwITq3lsluu0YDnz8dbRG2KtwmshYlEfMge
	6YCtbezSlAAQaPV85pONGCJOmYmeBtiyY2QfxZ9BjV+XQbaqR20g/V/U2svUE3NSQxZT2xSl6Ec6T
	kbwR31rQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAMCP-0000000GKaK-1VMn;
	Mon, 11 Nov 2024 04:38:49 +0000
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9R4T-0000000B3nO-0EuN
	for linux-nvme@lists.infradead.org;
	Fri, 08 Nov 2024 15:38:50 +0000
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-7b152a923a3so126768285a.3
        for <linux-nvme@lists.infradead.org>; Fri, 08 Nov 2024 07:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1731080328; x=1731685128; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7sMW5Kuv5sIzIjhBbBygI9fJdJpSk6eqM7+xgs0I9dY=;
        b=PTeckq/mFHWEM++jjZNqs9RsyQ8jf3EGSvfwJrxS86UMgHH8J+OnElxmkCCbRtXayc
         oCkEdgutmnUJxqIgRXD2xaqeHsrAY4b69/BiMR+oG7wpXincGqIp1S5ZLnYjPuPEiU9T
         +fXP2thWDnGQfEO5scumlRWCT8uPTh+MCIzVFNhfW357olRuPMCnXUTSTtTzFzn0yqVX
         dIGm+FhJB4QWHE9yg/yZMoNzd4ssUUJjSe2sdLXk3z1Ob8I6pg+08rMPM0Jn35yA+t4b
         fQ6dteFUmOD493kb3eWuna2JEk6PA1mYie6xoRscOIoFEvyVPqYg3QUwrqk0wCp96OLy
         uPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731080328; x=1731685128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7sMW5Kuv5sIzIjhBbBygI9fJdJpSk6eqM7+xgs0I9dY=;
        b=Ne/wYEfVibtyo9FsH2VXk0qlTXYOBhxDNyYZg2gP4HnJM2Iq5OmbAJX2itX95rZqsz
         noHqF1+vDqGfTDmyc/YVvZrnBvGQh1/dA3aE4tAynDQczBJRthoysR8L0KMFWTRxsNDV
         h+TExlyu+XRbKmg6vas32fLhcJmfPV6lu3UZYVOU/0ziyxnNxzYzSWoGm3arjUU+6zRM
         Fww/5xAJvYKTZVCjZIAw6WFrN6MqgHiJi5uPdgylM92rzlWpm3o2nJj2q7WRsbz6giZ7
         u0a3RuljWkyWLCsvwnAHw8EqHNusm/4EefhTcbRni0fLn+LfTNaHCG3elf+SCIJosiUo
         CHyw==
X-Forwarded-Encrypted: i=1; AJvYcCWlRel9aINhVjR9NIKfds76cigv8Z3rk2/K5Fz4AH3NWkUpaK3c9+ldfTz8cG/DO9n4AZkKZjVemvv2@lists.infradead.org
X-Gm-Message-State: AOJu0YyNkIOAVhXERlhbj3Gcfzvr42k9DBlZHQOPrYilYyH1CciwCR+0
	/hn9/UTjNo49XSq2MuTjJ270KN571R9sqW3ErKXjRz5pkC3kIAzcqIyICUVMjZE=
X-Google-Smtp-Source: AGHT+IHfTg/iLCK5GxrqZ9aoCzAZ7JH1FinF3HAR4KRwwnugOPp1CtA3KrYQyOs3W/lc98NgBjpBFQ==
X-Received: by 2002:a05:620a:1a21:b0:7ac:bb00:cd42 with SMTP id af79cd13be357-7b331dd2d55mr406755285a.27.1731080327649;
        Fri, 08 Nov 2024 07:38:47 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32ac2dd1fsm170869085a.15.2024.11.08.07.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 07:38:47 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1t9R4Q-00000002a9N-29Xq;
	Fri, 08 Nov 2024 11:38:46 -0400
Date: Fri, 8 Nov 2024 11:38:46 -0400
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
Message-ID: <20241108153846.GO35848@ziepe.ca>
References: <3567312e-5942-4037-93dc-587f25f0778c@arm.com>
 <20241104095831.GA28751@lst.de>
 <20241105195357.GI35848@ziepe.ca>
 <20241107083256.GA9071@lst.de>
 <20241107132808.GK35848@ziepe.ca>
 <20241107135025.GA14996@lst.de>
 <20241108150226.GM35848@ziepe.ca>
 <20241108150500.GA10102@lst.de>
 <20241108152537.GN35848@ziepe.ca>
 <20241108152956.GA12130@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108152956.GA12130@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241108_073849_149404_C2929DAC 
X-CRM114-Status: GOOD (  25.33  )
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

On Fri, Nov 08, 2024 at 04:29:56PM +0100, Christoph Hellwig wrote:
> On Fri, Nov 08, 2024 at 11:25:37AM -0400, Jason Gunthorpe wrote:
> > I'm asking how it will work if you change the struct page argument to
> > physical, because today dma_direct_map_page() has:
> > 
> > 		if (is_pci_p2pdma_page(page))
> > 			return DMA_MAPPING_ERROR;
> > 
> > Which is exactly the sorts of things I'm looking at when when I say to
> > get rid of struct page.
> 
> It will have to look up the page from the physical address obviously.
> But at least only in the error path.

I'm thinking we can largely avoid searching on physical, or at least
we can optimize this so there is only one search on physical at the
start of the DMA mapping. (since we are now saying all pages are the
same type)

> > What I'm thinking about is replacing code like the above with something like:
> > 
> > 		if (p2p_provider)
> > 			return DMA_MAPPING_ERROR;
> > 
> > And the caller is the one that would have done is_pci_p2pdma_page()
> > and either passes p2p_provider=NULL or page->pgmap->p2p_provider.
> 
> And where do you get that one from?

Which one?

The caller must know the p2p properties of what it is doing because it
is driving all the P2P logic around what APIs to call.

Either because it is already working with struct page and gets it out
of the pgmap.

Or it is working with non-struct page memory and has a (MMIO address,
p2p_provider) tuple that it got from the original driver that gave it
the MMIO address.

Or it really does have a naked phys_addr_t and it did the search on
physical, but only once.

Jason

