Return-Path: <SRS0=JRV9=EN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879B2C2D0A3
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Nov 2020 00:15:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2752720867
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Nov 2020 00:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FQET2vv+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aokkElWM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2752720867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=piyLRCAWhXhQazdld1IoI9Yxzo8wMpc+DK1s2Hc/X54=; b=FQET2vv+CCP2aVAAiNFyRGL9/
	evnd9nbgk1kkxRjhdo2ZsOYPFdJk3Px4YyZsONeKK8rzwY+kA/I+ojqR6W3vfrN5uajLKU83wOOWp
	OxWvB4EZCs7nW5D1hT/aVvyhn55qVV9+K2KXaPwrBryehVLEJRE71PdJywdz6Xzlsqt0DCYVAs77r
	zvCqUxyH+5UJFM+x0TZPKWcNA5EfTTKa9AugszlaztFG7GJD/njwujmQZAEgL11ZN0H3oUJ9Oe+P+
	qWIInyttZh0GVmW102HlWeR6ECdxQjkF6pbMmFRFToOsfKDxRnowVWG3YXkH/4OJfs+t0ZpNw5Kvn
	lyXYhnJdg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kbBsm-0008EY-FV; Sat, 07 Nov 2020 00:15:04 +0000
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kbBsi-0008Cj-BA
 for linux-nvme@lists.infradead.org; Sat, 07 Nov 2020 00:15:01 +0000
Received: by mail-qt1-x842.google.com with SMTP id n63so2092421qte.4
 for <linux-nvme@lists.infradead.org>; Fri, 06 Nov 2020 16:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=2xP+5n8avN9R0PMRHtfY/hU7jf10h4hT8Klf4TvQEgQ=;
 b=aokkElWMyWDPsBa6alzqFjXX6Ty/GtCdSx9WukymLV2/BbaYYEQkA6h6NtXkVdapG2
 f4KRlQs9Y+5DAc9+pE/HHKpJIyuCn91sXpwCSZ+08lhM8dAiFiLN7V2xrbpk6hfNSKic
 ieoBgAnzjzjw2iZmefkEtA4fme7kItwUr5LmWc4Urv+NDQjlRSC80EXdjXFB3UnTz0qc
 xUHsKwFfqKXXKxkjKflCvn5HeQw2iywmUCXpbij/QRJ/D8iwlPNvI/Ibqockn0S2v+qQ
 EoTvzw1G3AJLPsWVsVolt0ALyaAOomLE+whBhiXSdjlB8hbwuoItdTWe41htAX37ZvKD
 VHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2xP+5n8avN9R0PMRHtfY/hU7jf10h4hT8Klf4TvQEgQ=;
 b=FGP8yQ3lJ5qC2b0Nz6yu22J4mT8LycONLg6eqkatouMFiDinK71TCxVzsbQgLWdRl+
 GfGFtYg35ec50U7LW9BD6yJCAks42yGsgXmmayz9PcvgkBFq/pWB8YWp0Q6HbJS90iji
 o8y+ZCbAahxX+OnAP3fVY808oZd5pDndq/6q8RfiJWRLzYjCDinkijMTCcEB7zu3/2+Q
 TwTlj7ys4ebZTC8QR+trsO/fu3ghbMWSpYSYZPmgvbHN8Q5kWk2lqCRP7jt0r5t1uPmA
 aGcf2wt1VvVhjCeHm4gJ6Jdan6lk0mqyYwoO0uCFgDnj9rJcI9+x6peVnDrdxszWY013
 TKWw==
X-Gm-Message-State: AOAM5309z3AUqHWbci/fyEGqTpYCi2cnqC+zDRthfCsr8SrS8+ZCE0O1
 +jgf7K6lKBQymm5R2fdeRqWYVA==
X-Google-Smtp-Source: ABdhPJxMxLKgSiQ4x1Of97Fg4BcrbjDaTMOumnt9gw+omdxttGmxoTEsM80CNgLqS0LcZZvrtkPZNw==
X-Received: by 2002:aed:2c02:: with SMTP id f2mr4176029qtd.48.1604708098335;
 Fri, 06 Nov 2020 16:14:58 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [156.34.48.30])
 by smtp.gmail.com with ESMTPSA id u5sm1592838qtg.57.2020.11.06.16.14.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 16:14:57 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1kbBsf-0015Rr-2V; Fri, 06 Nov 2020 20:14:57 -0400
Date: Fri, 6 Nov 2020 20:14:57 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [RFC PATCH 14/15] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
Message-ID: <20201107001457.GB244516@ziepe.ca>
References: <20201106172206.GS36674@ziepe.ca>
 <b1e8dfce-d583-bed8-d04d-b7265a54c99f@deltatee.com>
 <20201106174223.GU36674@ziepe.ca>
 <2c2d2815-165e-2ef9-60d6-3ace7ff3aaa5@deltatee.com>
 <20201106180922.GV36674@ziepe.ca>
 <09885400-36f8-bc1d-27f0-a8adcf6104d4@deltatee.com>
 <20201106193024.GW36674@ziepe.ca>
 <03032637-0826-da76-aec2-121902b1c166@deltatee.com>
 <20201106195341.GA244516@ziepe.ca>
 <e6a99d54-b33a-0df1-ee33-4aa7a70124a6@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e6a99d54-b33a-0df1-ee33-4aa7a70124a6@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201106_191500_472789_1214F0E7 
X-CRM114-Status: GOOD (  13.67  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 linux-pci@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Ira Weiny <iweiny@intel.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-block@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, John Hubbard <jhubbard@nvidia.com>,
 Dan Williams <dan.j.williams@intel.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Nov 06, 2020 at 01:03:26PM -0700, Logan Gunthorpe wrote:
> I don't think a function like that will work for the p2pmem use case. In
> order to implement proper page freeing I expect I'll need a loop around
> the allocator and vm_insert_mixed()... Something roughly like:
> 
> for (addr = vma->vm_start; addr < vma->vm_end; addr += PAGE_SIZE) {
>         vaddr = pci_alloc_p2pmem(pdev, PAGE_SIZE);
> 	ret = vmf_insert_mixed(vma, addr,
>   		       __pfn_to_pfn_t(virt_to_pfn(vaddr), PFN_DEV | PFN_MAP));
> }
> 
> That way we can call pci_free_p2pmem() when a page's ref count goes to
> zero. I suspect your use case will need to do something similar.

Yes, but I would say the pci_alloc_p2pmem() layer should be able to
free pages on a page-by-page basis so you don't have to do stuff like
the above.

There is often a lot of value in having physical contiguous addresses,
so allocating page by page as well seems poor.

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
