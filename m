Return-Path: <SRS0=7aSL=EM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24608C2D0A3
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 17:22:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 887E72078B
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 17:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y7s9JSRj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Z5hliPe4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 887E72078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BMlCXVI3vq2Mt3px5pDbGTwTMoYL4Lce/Hnd+sQjkSg=; b=Y7s9JSRjmRHmt2ZWhgunc/j8T
	RbOJ/D3C69pP5YwUbi5Z0f9qJr+cyBOSzB/4bLVXwEG6kWTkdjdbGx5U+Ipg/Amv6Qcy/nARlDtJv
	7Oo/Z4ZLPwEdzPH9IsF+ZaX2cBSGMTIvddFwRgMrj2/kGORE7k0jE2M3QsY4sjW7DbFlbZt2e1Ofx
	qq7bsYjtVrH6jrYWgTdNx8s+1ZgaJb5TVZ3U1htW9wlivH7cDuNisLTcvnmSfJKM6BQLDLjh9g11L
	ZOcO5zwQnkHQrgHS9gjyoozUZi0oMZZGgawNU6YVq0NUjKBiV1di6JQH0A+FKJLxoI9JBPLXQxFHb
	yet7Gup8A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kb5RF-0007NO-8m; Fri, 06 Nov 2020 17:22:13 +0000
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb5RB-0007LQ-TI
 for linux-nvme@lists.infradead.org; Fri, 06 Nov 2020 17:22:10 +0000
Received: by mail-qt1-x842.google.com with SMTP id p12so1273585qtp.7
 for <linux-nvme@lists.infradead.org>; Fri, 06 Nov 2020 09:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Y11rYbDMlG4Jq6y1mMF8XHIQBRgQTi4LgEIfp1+Fy2I=;
 b=Z5hliPe42ZhsJgIpO8yM/A/BmnWabQMZyxH3x1SujgBdxmpQeo1iLC7dJllfTWrgs+
 ckOwCsKncKsZUSkDwm+CRG+PtHOhk6vGyhb3vaWmExO06uZRfYDDy4x0lNtyZAxfIGSF
 TzNe/ATxzOTxeiv/h6NniXGC8bMAeaQsSamd0SJaMbdJqgcKE7FX8hgittLCSxWN+Hk0
 aEVb3jWNuQ84GZTQ7t0z2P0KnBO9475+HL13KJpZeDMWi657ip/5nImwsscD/jRB/6+1
 tzYyPHfeLOmV9kq1MtWUFMAFC/4Mt9DF6Qfy0pjFFXFFgIEb7ZfC/ufepIEP0MSbyLqW
 1mng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Y11rYbDMlG4Jq6y1mMF8XHIQBRgQTi4LgEIfp1+Fy2I=;
 b=sQKN6v6XXUBIxbiQS8Lx3hWpr49L9osBHJGpL0mnlvPos8Ht2bWr7mGo87i2NcwmZO
 oP3iXXHP7WDh4tXV1mVLcfpQHpR7+0D1mpd2B/1KDke0mxiDMabYDgVh7mU2GyEUfFgX
 aZJBA3RR+1d4Exnbw44cQ/x8Apvm5Fd8RbcTlDjMgf1OumRBFEbZH2DtJbmVxb0NqU/F
 yx2/Dif2ePG35ZlpbWNWFj52vCRT0Dzr51P/Z0xTt5orySl/ZdO5Vn6FnXoqbfeRdYzv
 6FfLcQNRBZvh5kY9wx2bVHQPQ8c7ZB+32w10EtnXdTLJFeuPP+lHIePl8lufxcxmr9aj
 zVFg==
X-Gm-Message-State: AOAM531dJ3SU8JHNpZsOwcQIUFbIu5l87D5b8pqjNm+z383/mxUZU5cl
 z+slEH8O0SC2A+5J04uIR7U+uw==
X-Google-Smtp-Source: ABdhPJyiYapImJ+Y336x/nMMBsQzuXDQ9V5MrPZLPGSARv/D7dBPhFBvVcl8QNPKfF7/i3znPagsCA==
X-Received: by 2002:ac8:4d4d:: with SMTP id x13mr2465811qtv.72.1604683328177; 
 Fri, 06 Nov 2020 09:22:08 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [156.34.48.30])
 by smtp.gmail.com with ESMTPSA id w45sm942700qtw.96.2020.11.06.09.22.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 09:22:07 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1kb5R8-000z7J-TY; Fri, 06 Nov 2020 13:22:06 -0400
Date: Fri, 6 Nov 2020 13:22:06 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [RFC PATCH 14/15] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
Message-ID: <20201106172206.GS36674@ziepe.ca>
References: <20201106170036.18713-1-logang@deltatee.com>
 <20201106170036.18713-15-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201106170036.18713-15-logang@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201106_122209_991789_0F181EFA 
X-CRM114-Status: GOOD (  16.81  )
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

On Fri, Nov 06, 2020 at 10:00:35AM -0700, Logan Gunthorpe wrote:
> Introduce pci_mmap_p2pmem() which is a helper to allocate and mmap
> a hunk of p2pmem into userspace.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>  drivers/pci/p2pdma.c       | 104 +++++++++++++++++++++++++++++++++++++
>  include/linux/pci-p2pdma.h |   6 +++
>  2 files changed, 110 insertions(+)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 9961e779f430..8eab53ac59ae 100644
> +++ b/drivers/pci/p2pdma.c
> @@ -16,6 +16,7 @@
>  #include <linux/genalloc.h>
>  #include <linux/memremap.h>
>  #include <linux/percpu-refcount.h>
> +#include <linux/pfn_t.h>
>  #include <linux/random.h>
>  #include <linux/seq_buf.h>
>  #include <linux/xarray.h>
> @@ -1055,3 +1056,106 @@ ssize_t pci_p2pdma_enable_show(char *page, struct pci_dev *p2p_dev,
>  	return sprintf(page, "%s\n", pci_name(p2p_dev));
>  }
>  EXPORT_SYMBOL_GPL(pci_p2pdma_enable_show);
> +
> +struct pci_p2pdma_map {
> +	struct kref ref;
> +	struct pci_dev *pdev;
> +	void *kaddr;
> +	size_t len;
> +};

Why have this at all? Nothing uses it and no vm_operations ops are
implemented?

This is very inflexable, it would be better if this is designed like
io_remap_pfn where it just preps and fills the VMA, doesn't take
ownership of the entire VMA

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
