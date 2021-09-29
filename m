Return-Path: <SRS0=HFDN=OT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AFEC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 23:36:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E6FB61555
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 23:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2E6FB61555
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CR/rtYLsCm50uzshZw7MyO7GaJ86nYrNht6FNmmJbb8=; b=N8jYhXKtjn74uI
	u2S+P6BUFb6zV4RJDH6l/WC/4iVgF6FoOBfG1SmfFvyASNkXdriUqr48TthXw3KcnNVVAw7cGKzx0
	eWVKsPakE9iU6uFiDpCf8jnbwL8YoGHjA+RwncQi83r9W4jNsPwg7wLN9ZBi6rBM3vJWaLWug4y+g
	zM8N9VqvGzh6WtGQF5yQxosLR1osVUff4p2pA5fECTz7Ur2gVmKuoGOCw8XIuk2zBBD33KH5KW5BQ
	dYX7hX9DaxGr82gyo3/6I8fdElfihfEbi8D7fC+APlk0/6NeMFhTC1CSxfNN9+JrVU9D3LqGBKKYP
	o0j3Vj4vW9AmnKy2ATtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVj75-00CcJB-GB; Wed, 29 Sep 2021 23:35:47 +0000
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVj71-00CcI4-T6
 for linux-nvme@lists.infradead.org; Wed, 29 Sep 2021 23:35:46 +0000
Received: by mail-qk1-x72b.google.com with SMTP id q81so4076520qke.5
 for <linux-nvme@lists.infradead.org>; Wed, 29 Sep 2021 16:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Wzv2Y27ogc32S6oHMWAfyL0EMJPS0sYiDo6umdEuZ90=;
 b=S4PKYlTphsjTeGSO6MfruYx4DLjFDyu6ZBDQXU7sgBQUZglbnWFts2iTn8upvshkwO
 /dxY5MJJ3K9bbBOWdcCpUDQryqEQ6B6xsCI4XTkHAaouYDnzj48xV27k94PZY12XJM5q
 EV90TNvBvPJrxWONr5qi4YLqPbT6TkJpX2ov+sLJirRsIUAvrOi36HyZfvihTjc8VRvy
 y9qkzSc3lHxRJ2joe2EKnBI4kW39e2li3GiaMVt6OA83/KD9UTxgkGPf5QdOygqePR/u
 RbANXP74mA2FQxLulY5GQdT3oKcIiqhjOBThg85Hi5BfdV/hy7RpkZ8VNDP3qSTgV52G
 3oKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Wzv2Y27ogc32S6oHMWAfyL0EMJPS0sYiDo6umdEuZ90=;
 b=gkVuUXkLDFmXmriIiuxuoVaizCEZhhNEGlOINFb4Lqq/DleoZNoH4OW7UuAWbqOPCC
 1cGDZWDcAM3X/twLmX6wcE7sO4IacP1q+kLrcSmoqLCD++USPFk5bZFN+6pG1aYQCOON
 YGt3q+LUNyZsmU07FedPk8JvzEAuHmsDMkVQ7b3QEmrSj+7uZZpXYAZJxzlC1UutD+eO
 32snM1gUllgh0C3WqCsDpOvT8qPjuT89llgElG/0VHYfnApLZGiQiWDJe/GZ04etShpk
 i3dN12cb6ceZcwDyg3vGTayq2D+2246ZJ++kEFatiWthXnOCjSaTM8FlxHz2x15DRbJN
 /P9w==
X-Gm-Message-State: AOAM531eMfRZDQG86O9SIhfYKg00+1ImRKGVfYhSQVOdS6XuBAWoL1WM
 z8ynlo7WNRho6G+GiN/5HC6NsA==
X-Google-Smtp-Source: ABdhPJxG17Iq4sMkmS8x7eqi3cbKInix861xKtGJRezs+18cQeCiP6r35EC+3tlGMr1TedfVtU4v5g==
X-Received: by 2002:a37:afc4:: with SMTP id y187mr2254066qke.520.1632958541600; 
 Wed, 29 Sep 2021 16:35:41 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129])
 by smtp.gmail.com with ESMTPSA id j184sm705904qkd.74.2021.09.29.16.35.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Sep 2021 16:35:41 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mVj6y-007ivO-CU; Wed, 29 Sep 2021 20:35:40 -0300
Date: Wed, 29 Sep 2021 20:35:40 -0300
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
Subject: Re: [PATCH v3 19/20] PCI/P2PDMA: introduce pci_mmap_p2pmem()
Message-ID: <20210929233540.GF3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-20-logang@deltatee.com>
 <20210928195518.GV3544071@ziepe.ca>
 <8d386273-c721-c919-9749-fc0a7dc1ed8b@deltatee.com>
 <20210929230543.GB3544071@ziepe.ca>
 <32ce26d7-86e9-f8d5-f0cf-40497946efe9@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <32ce26d7-86e9-f8d5-f0cf-40497946efe9@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210929_163543_968405_EE7E8DCF 
X-CRM114-Status: GOOD (  28.25  )
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

On Wed, Sep 29, 2021 at 05:27:22PM -0600, Logan Gunthorpe wrote:

> > finish_fault() should set the pte_devmap - eg by passing the
> > PFN_DEV|PFN_MAP somehow through the vma->vm_page_prot to mk_pte() or
> > otherwise signaling do_set_pte() that it should set those PTE bits
> > when it creates the entry.
> > 
> > (or there should be a vmf_* helper for this special case, but using
> > the vmf->page seems righter to me)
> 
> I'm not opposed to this. Though I'm not sure what's best here.
> 
> >> If we don't set pte_devmap(), then every single page that GUP
> >> processes needs to check if it's a ZONE_DEVICE page and also if it's
> >> a P2PDMA page (thus dereferencing pgmap) in order to satisfy the
> >> requirements of FOLL_PCI_P2PDMA.
> > 
> > Definately not suggesting not to set pte_devmap(), only that
> > VM_MIXEDMAP should not be set on VMAs that only contain struct
> > pages. That is an abuse of what it is intended for.
> > 
> > At the very least there should be a big comment above the usage
> > explaining that this is just working around a limitation in
> > finish_fault() where it cannot set the PFN_DEV|PFN_MAP bits today.
> 
> Is it? Documentation on vmf_insert_mixed() and VM_MIXEDMAP is not good
> and the intention is not clear. I got the impression that mm people
> wanted those interfaces used for users of pte_devmap().

I thought VM_MIXEDMAP was quite clear:

#define VM_MIXEDMAP	0x10000000	/* Can contain "struct page" and pure PFN pages */

This VMA does not include PFN pages, so it should not be tagged
VM_MIXEDMAP.

Aside from enabling the special vmf_ API, it only controls some
special behavior in vm_normal_page:

 * VM_MIXEDMAP mappings can likewise contain memory with or without "struct
 * page" backing, however the difference is that _all_ pages with a struct
 * page (that is, those where pfn_valid is true) are refcounted and considered
 * normal pages by the VM. The disadvantage is that pages are refcounted
 * (which can be slower and simply not an option for some PFNMAP users). The
 * advantage is that we don't have to follow the strict linearity rule of
 * PFNMAP mappings in order to support COWable mappings.

Which again does not describe this case.

> device-dax uses these interfaces and as far as I can see it also only
> contains struct pages (or at least  dev_dax_huge_fault() calls
> pfn_to_page() on every page when VM_FAULT_NOPAGE happens).

hacky hacky :)

I think DAX probably did it that way for the same reason you are
doing it that way - no other choice without changing something

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
