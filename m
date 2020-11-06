Return-Path: <SRS0=7aSL=EM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FE9C55178
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 19:53:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0E5A21D46
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 19:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iyL7ofwU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FudZRGzA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0E5A21D46
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=K59PCIXExrz9gF2UlLc/UscqjyGLWpj9p4+NfQv2uzU=; b=iyL7ofwUIGggTz3OWo2PX8L24
	ELfyaE4cF+z8e78xXmNXuh2FvL8GqgjAXarlTF/YnJTjIWenKN3GhLQz4oHlqbRB8qQlCUvSNWdea
	7Xw/2nb3ZR26/33E4CbqgdmI6y/Qf2vqc9+K83wQvRfb9sUVmGxHt2DbPLZtvrEL2WY902Nt1d3Sg
	lb0MBpJVjnwy/uh4k6hd/V+IVhSDxCkhAtt6aRKZ2LFbLbmGKDSx5zOvmhZWfTakiDJvmxYGGnLWp
	oIA3IcC8K95iehJeFUEelHnV0REcIFKz0B2lFMlvi/Z14LuSUeZLVQaixdANfbdWJQEmxQc2NkPFT
	ErfceBauA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kb7nv-0003uv-TK; Fri, 06 Nov 2020 19:53:47 +0000
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb7nt-0003tA-Ib
 for linux-nvme@lists.infradead.org; Fri, 06 Nov 2020 19:53:46 +0000
Received: by mail-qt1-x843.google.com with SMTP id h12so1634655qtu.1
 for <linux-nvme@lists.infradead.org>; Fri, 06 Nov 2020 11:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=sU45ASLE3qTNEeDnzXy0mWmjw/B5hdl1YB3C1dRGzkI=;
 b=FudZRGzAxEFk9lGKJUSPzsyZKArhHRwyzmRlvf+GFC+ATQPjzcBbVOeDLLB7moiVUf
 ObxxpnS/zZJpTm82iWz+fyi9jGs/I9YeNae0ROJk7xm4ksGu3vErOwXPC3998pjQlR5p
 4czYVsKEbRHoddebJV0noju3HQZREanU58l+vhPFj17Ta8rGMwytFISX8XsKNrHR+BX8
 lRJNDwJeHT2t31rpqbAdGGp0+akczI7HoAc6Ksjc1BT3ksZah6pY+y3OqCayYTmpzL+D
 Vcc6mEGa7A07b9rAWqQo7QjWrLXkk8WsSTWPLKnX0XjNAe7EuqN+sDQBd5I1lutR9Gx3
 kmvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sU45ASLE3qTNEeDnzXy0mWmjw/B5hdl1YB3C1dRGzkI=;
 b=mrAmvFhfo2j7qef0LSzMy8llMz5ytQjUzTZKr0waLZtc/lKpSOKAd2PKbE9/9iMZ+X
 f0AncPiofag8gEyPZlQ21gFsPq07XSb4GRo0CUzBXpyEZEj/d45ImV5y/DNmG2wtetks
 UYSUQeR6xeVQytISVvwJHwQi4n4mq4fbT9a95pmxF+EDJPVgzm2HajNhAn4fbRyBK78W
 V1AmKCBnBhQw7+jO6ZeMimtQL+mXvIEws+era079bZ/W6UhtoszKjI10J97xXz3TWIc2
 1XwlK+JyLWIa9d82O5e8oIn9rRW3VVv85VOGNqHMKJQvrQ5Jd1DZ7+7zFjLjk3EfL7qm
 y6SA==
X-Gm-Message-State: AOAM530MNUuzZ/kIrqiWC5ZaFMGqB4O2l91jUB8o7H61yg9+ufRqcRxM
 0781GmeQVgx8VAP/3D1pMq5+qA==
X-Google-Smtp-Source: ABdhPJwcMytaU5RLKIBqp2abyuS1iVFiLHOqHqGF/QD5vN1zrtKnu5OM6Laul9BgJOP5lCmGBjWjKA==
X-Received: by 2002:aed:32c7:: with SMTP id z65mr3146052qtd.266.1604692422443; 
 Fri, 06 Nov 2020 11:53:42 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [156.34.48.30])
 by smtp.gmail.com with ESMTPSA id r41sm1239041qtj.23.2020.11.06.11.53.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 11:53:41 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1kb7np-0011j7-5m; Fri, 06 Nov 2020 15:53:41 -0400
Date: Fri, 6 Nov 2020 15:53:41 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [RFC PATCH 14/15] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
Message-ID: <20201106195341.GA244516@ziepe.ca>
References: <20201106170036.18713-1-logang@deltatee.com>
 <20201106170036.18713-15-logang@deltatee.com>
 <20201106172206.GS36674@ziepe.ca>
 <b1e8dfce-d583-bed8-d04d-b7265a54c99f@deltatee.com>
 <20201106174223.GU36674@ziepe.ca>
 <2c2d2815-165e-2ef9-60d6-3ace7ff3aaa5@deltatee.com>
 <20201106180922.GV36674@ziepe.ca>
 <09885400-36f8-bc1d-27f0-a8adcf6104d4@deltatee.com>
 <20201106193024.GW36674@ziepe.ca>
 <03032637-0826-da76-aec2-121902b1c166@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <03032637-0826-da76-aec2-121902b1c166@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201106_145345_624982_118BED3F 
X-CRM114-Status: GOOD (  27.71  )
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

On Fri, Nov 06, 2020 at 12:44:59PM -0700, Logan Gunthorpe wrote:
> 
> 
> On 2020-11-06 12:30 p.m., Jason Gunthorpe wrote:
> >> I certainly can't make decisions for code that isn't currently
> >> upstream.
> > 
> > The rdma drivers are all upstream, what are you thinking about?
> 
> Really? I feel like you should know what I mean here...
> 
> I mean upstream code that actually uses the APIs that I'd have to
> introduce. I can't say here's an API feature that no code uses but the
> already upstream rdma driver might use eventually. It's fairly easy to
> send patches that make the necessary changes when someone adds a use of
> those changes inside the rdma code.

Sure, but that doesn't mean you have to actively design things to be
unusable beyond this narrow case. The RDMA drivers are all there, all
upstream, if this work is accepted then the changes to insert P2P
pages into their existing mmap flows is a reasonable usecase to
consider at this point when building core code APIs.

You shouldn't add dead code, but at least have a design in mind for
what it needs to look like and some allowance.

> >> Ultimately, if you aren't using the genpool you will have to implement
> >> your own mmap operation that somehow allocates the pages and your own
> >> page_free hook. 
> > 
> > Sure, the mlx5 driver already has a specialized alloctor for it's BAR
> > pages.
> 
> So it *might* make sense to carve out a common helper to setup a VMA for
> P2PDMA to do the vm_flags check and set VM_MIXEDMAP... but besides that,
> there's no code that would be common to the two cases.

I think the whole insertion of P2PDMA pages into a VMA should be
similar to io_remap_pfn() so all the VM flags, pgprot_decrypted and
other subtle details are all in one place. (also it needs a
pgprot_decrypted before doing vmf_insert, I just learned that this
month)

> >> I also don't expect this to be going upstream in the near term so don't
> >> get too excited about using it.
> > 
> > I don't know, it is actually not that horrible, the GUP and IOMMU
> > related changes are simpler than I expected
> 
> I think the deal breaker is the SGL hack and the fact that there are
> important IOMMU implementations that won't have support.

Yes, that is pretty hacky, maybe someone will have a better idea

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
