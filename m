Return-Path: <SRS0=7aSL=EM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4906C2D0A3
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 17:42:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65DE32151B
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 17:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="zenMvSNB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MOCiBjSN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65DE32151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=e27l9fjeg4WjDwnuzmmU2q+O+fojxsjOYg8DWIBZNuU=; b=zenMvSNBgbrBHbB1G3BfCs0CN
	fr/ZqWh5E7rS8f/NJ0E82o795ARuiCdpMivVWSypvwDQpR6EEmfCqkZmBKk9bot0/IYXVobnLhSk8
	NTEk8aqJnOhMYQsGGRioka0GjiajU0VG8eH5saTw3yNhhsU742fWz5E+D7DA5+dttTCNABduqlyiE
	Mu+AL7/pMiT22TMRnG24J2ywcVftbkvfH/cPhxPNRGcHgXO64LwE15iFN8JoKitUzVQ/w1B1/wrdC
	dYeCLFg11z6JkNk0QHbhqdRQp6SauaWx5CYUwKnaWEdl/yQk4KBb8c7NrvRROZf05WHFGBllhgAW+
	GfxMU/nhQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kb5kr-0001Ia-1H; Fri, 06 Nov 2020 17:42:29 +0000
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb5ko-0001GT-CD
 for linux-nvme@lists.infradead.org; Fri, 06 Nov 2020 17:42:27 +0000
Received: by mail-qk1-x741.google.com with SMTP id k9so1812156qki.6
 for <linux-nvme@lists.infradead.org>; Fri, 06 Nov 2020 09:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=3buLvlWL+9G09nyEaJ7/3CqkDjgWFOdmZgEsg7qS7YA=;
 b=MOCiBjSN2a1hPwUL+FJFYuzQlwO8wmt6NgCt9FaTyLzUmSuNFZ8pJFJjnpYDGgsQ26
 a8j6AjUBHGPJgl1+H9vdmuYPkKU68pFmYfvE9HQawmCY4vIz+ZApkGBVOkd9dWhh0DXa
 q56QEyRr53QyWSixEoTgaJPahFsdyxl3XbdZlglN7e+iI0rw/ar1o9FTO4zJteIHNrs9
 fCSMQ6f2iYfcLKZJGeHkqKVzX2CdNVjmmqzCZDSDIw8FQ5JzVVCMMhMKmUFdxYZt2g0v
 2SDXecJEMacL6cL9Se7kxpJ/LhH+/YR2QfiDFmQPiXf/MhTYpep4QtUSKXYnfiMtIam2
 37AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3buLvlWL+9G09nyEaJ7/3CqkDjgWFOdmZgEsg7qS7YA=;
 b=ATm526DKAN0d+jzdSj25Og9LsXr6Lgd57U9L1l7efrEmDVfJYTMei59d0Rrcfpb9LZ
 e8nUIiJSM8g4j25f6YM8UDf1MOC1PbJtp2YcgXNcF9HLTS2dOO5k9V2QHnLTKznU0ILd
 nNS3rNHLDUwFj+3W1ATfdfNazoKwMRJoP3QDq4kflb3WU5hY5YGRsbaVAE5XDWhBSa04
 C2eGhONfCojrIL4VcPiY+se4hIUrLXAUS88mlYjlUNG7UVv7vzDl+VmT7ZzEI7ApZdTK
 MiLGhE6Q+jhUu9rMLY4VmQEx8oNNL1Ra3uCPWkbgN0vUCsK7SqxdzAqN1ExYrBnqhiel
 KjRQ==
X-Gm-Message-State: AOAM533Zgyj+4+oxnuaMRt1B06E7GZgHI543bFjppOfWkkc5BXVDVWGW
 +Z/spH9lWVcD0UiXIhDOANXy+Q==
X-Google-Smtp-Source: ABdhPJyPUMTPAlvbc5F9DgPZcTHH53XJriCxbWePpFu8+RK+GJP/zdnWVlnoJA0LQqWFmkayCjYz/g==
X-Received: by 2002:a37:9441:: with SMTP id w62mr2652751qkd.474.1604684545012; 
 Fri, 06 Nov 2020 09:42:25 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [156.34.48.30])
 by smtp.gmail.com with ESMTPSA id t65sm1006283qkc.52.2020.11.06.09.42.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 09:42:24 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1kb5kl-000zVc-Ja; Fri, 06 Nov 2020 13:42:23 -0400
Date: Fri, 6 Nov 2020 13:42:23 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [RFC PATCH 14/15] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
Message-ID: <20201106174223.GU36674@ziepe.ca>
References: <20201106170036.18713-1-logang@deltatee.com>
 <20201106170036.18713-15-logang@deltatee.com>
 <20201106172206.GS36674@ziepe.ca>
 <b1e8dfce-d583-bed8-d04d-b7265a54c99f@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b1e8dfce-d583-bed8-d04d-b7265a54c99f@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201106_124226_429539_ADFEF076 
X-CRM114-Status: GOOD (  19.36  )
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

On Fri, Nov 06, 2020 at 10:28:00AM -0700, Logan Gunthorpe wrote:
> 
> 
> On 2020-11-06 10:22 a.m., Jason Gunthorpe wrote:
> > On Fri, Nov 06, 2020 at 10:00:35AM -0700, Logan Gunthorpe wrote:
> >> Introduce pci_mmap_p2pmem() which is a helper to allocate and mmap
> >> a hunk of p2pmem into userspace.
> >>
> >> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> >>  drivers/pci/p2pdma.c       | 104 +++++++++++++++++++++++++++++++++++++
> >>  include/linux/pci-p2pdma.h |   6 +++
> >>  2 files changed, 110 insertions(+)
> >>
> >> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> >> index 9961e779f430..8eab53ac59ae 100644
> >> +++ b/drivers/pci/p2pdma.c
> >> @@ -16,6 +16,7 @@
> >>  #include <linux/genalloc.h>
> >>  #include <linux/memremap.h>
> >>  #include <linux/percpu-refcount.h>
> >> +#include <linux/pfn_t.h>
> >>  #include <linux/random.h>
> >>  #include <linux/seq_buf.h>
> >>  #include <linux/xarray.h>
> >> @@ -1055,3 +1056,106 @@ ssize_t pci_p2pdma_enable_show(char *page, struct pci_dev *p2p_dev,
> >>  	return sprintf(page, "%s\n", pci_name(p2p_dev));
> >>  }
> >>  EXPORT_SYMBOL_GPL(pci_p2pdma_enable_show);
> >> +
> >> +struct pci_p2pdma_map {
> >> +	struct kref ref;
> >> +	struct pci_dev *pdev;
> >> +	void *kaddr;
> >> +	size_t len;
> >> +};
> > 
> > Why have this at all? Nothing uses it and no vm_operations ops are
> > implemented?
> 
> It's necessary to free the allocated p2pmem when the mapping is torn down.

That's suspicious.. Once in a VMA the lifetime of the page must be
controlled by the page refcount, it can't be put back into the genpool
just because the vma was destroed.

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
