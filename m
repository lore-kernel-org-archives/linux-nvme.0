Return-Path: <SRS0=7aSL=EM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD5CC2D0A3
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 19:30:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 839C220715
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 19:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YAY6ueLM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iJjd0Fsg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 839C220715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=TuBGFwizuj31gW+0KeSOqXtQ3xTEJXJxCVAMBcPJFjo=; b=YAY6ueLMzvtRbtVDj53oiJosi
	VqIx3dhy6yWjcFzerNzX14TR52B7FikspEFnfyFv/4FGxpKBfz9/zssJtyKdCJVOBdx7YdwE6D0Ev
	VxcZ2hxJglW/whNyTeqVEgSPEGhgxZwADE3uZtXiJUlYxxCZUjHm6Zp/zIlGE5tp+9N2mBTlMTwCe
	oLfJqCmWZZrlCoUjB6xDhVaolmbT9G7vFwwLEO9IeT7mHCCPGiMSeStS4LIQoalqsd1t+mFaeBAoo
	HxPaNngFxHj0ezAN1kq/HeUJdQF1Ud5t1jvf453xTmLf9nKcjqHOBYjAPhhA62EWhBmbpt7+51FpI
	lmZ0ssw9A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kb7RP-0000bD-1H; Fri, 06 Nov 2020 19:30:31 +0000
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb7RM-0000a5-9B
 for linux-nvme@lists.infradead.org; Fri, 06 Nov 2020 19:30:29 +0000
Received: by mail-qk1-x743.google.com with SMTP id 140so2157395qko.2
 for <linux-nvme@lists.infradead.org>; Fri, 06 Nov 2020 11:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=vFAruLUORQHUqfhAcqrK3kHFrju7FmZIpz+3LtddQik=;
 b=iJjd0FsgKSz4UMVJ0yEYuTXP+TTkCpe11X1VygTFEfMhBu4zVCI1R/v6juANR2qB4Q
 5Bels1w2oZzLmDsNDoThRLoK7kc/zdpwPO4UT6x6EAkceI8g/JOjAG91xGYl7kSFCQ/W
 ZbgarmDUY3PKv06eSLmj2WHCkLP1NnOHCZkgrx7CXQDuCJ/z7qt+/GjYjmsDayhhFmyK
 CViF4N4YOhwIP8BSr0EwEqNCdu9hb5mbPEEbp3iUTLeV3XnYywXW188JOM3kSYxEOLV5
 mfupyKsZCd/zGG/BUy47UXOrZMvD0veRq8OcWLdma8c/DrK5Km76/lwmXa36HDCDsiN4
 sXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vFAruLUORQHUqfhAcqrK3kHFrju7FmZIpz+3LtddQik=;
 b=UMDVuTUPhSBx7jM9DNmKl+356HHHr/EBVjueLr70af36x6U6ZY/TnNvoFGwzfpdQW2
 OjJXoEsdSmDniHUVyHiDhPaxDTmEv6jNXXbK6/g1n6IgRMLUMf9B0b91uW6nHBp714AU
 GixHPUJn44hO6IC9TB2Iw17y+LSUXjKNJhmz1x7aPu3OhcQFhaOv98GvXq83TY8DmNjD
 8kvzBno7TS9V+K2rgPzwEA8gyqa/+2WB/uAKNhlexx0EgfKKPL4b3XGYOwYbpg059DJt
 PJmypKMS/0qRje8s1zyLkfCBuV2G+QqwnS8gxJdfzQkftxs3/+v4dNBWC5MGk8j8IjSX
 9KUw==
X-Gm-Message-State: AOAM532VZ+QB63S+kx2/vpKUL2LVMi8VZr0piyv5kegjoneOpgj+kwEH
 zevVsoMGa9aolVC6dAJ9JIrk+Q==
X-Google-Smtp-Source: ABdhPJze2F/Rq9sRVVe7Xk43RUxz3sel2lY1t652tRL/srA9lFIVY1sT0rqjvYUmBSCT+htfHCsU0Q==
X-Received: by 2002:a37:e40b:: with SMTP id y11mr3193612qkf.29.1604691026426; 
 Fri, 06 Nov 2020 11:30:26 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [156.34.48.30])
 by smtp.gmail.com with ESMTPSA id s2sm1115967qtw.44.2020.11.06.11.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 11:30:25 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1kb7RI-0011Hr-SE; Fri, 06 Nov 2020 15:30:24 -0400
Date: Fri, 6 Nov 2020 15:30:24 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [RFC PATCH 14/15] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
Message-ID: <20201106193024.GW36674@ziepe.ca>
References: <20201106170036.18713-1-logang@deltatee.com>
 <20201106170036.18713-15-logang@deltatee.com>
 <20201106172206.GS36674@ziepe.ca>
 <b1e8dfce-d583-bed8-d04d-b7265a54c99f@deltatee.com>
 <20201106174223.GU36674@ziepe.ca>
 <2c2d2815-165e-2ef9-60d6-3ace7ff3aaa5@deltatee.com>
 <20201106180922.GV36674@ziepe.ca>
 <09885400-36f8-bc1d-27f0-a8adcf6104d4@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <09885400-36f8-bc1d-27f0-a8adcf6104d4@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201106_143028_701860_8523C40F 
X-CRM114-Status: GOOD (  20.52  )
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

On Fri, Nov 06, 2020 at 11:20:05AM -0700, Logan Gunthorpe wrote:
> 
> 
> On 2020-11-06 11:09 a.m., Jason Gunthorpe wrote:
> >> Ah, hmm, yes. I guess the pages have to be hooked and returned to the
> >> genalloc through free_devmap_managed_page(). 
> > 
> > That sounds about right, but in this case it doesn't need the VMA
> > operations.
> > 
> >> Seems like it might be doable... but it will complicate things for
> >> users that don't want to use the genpool (though no such users exist
> >> upstream).
> > 
> > I would like to use this stuff in RDMA pretty much immediately and the
> > genpool is harmful for those cases, so please don't make decisions
> > that are tying thing to genpool
> 
> I certainly can't make decisions for code that isn't currently
> upstream.

The rdma drivers are all upstream, what are you thinking about?

> Ultimately, if you aren't using the genpool you will have to implement
> your own mmap operation that somehow allocates the pages and your own
> page_free hook. 

Sure, the mlx5 driver already has a specialized alloctor for it's BAR
pages.

> I also don't expect this to be going upstream in the near term so don't
> get too excited about using it.

I don't know, it is actually not that horrible, the GUP and IOMMU
related changes are simpler than I expected

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
