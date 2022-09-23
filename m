Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91772C04A95
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Sep 2022 19:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xu8gZjkVZRWUz/+3Yxaqqu61sLGoB8IQaIP0sQAkChQ=; b=nB1u2S5JE/xyfZ9J/5sh79NMSO
	6fUcE6lOW7/QGXjE00F1zWRJKEjSthfkgT5fZA7TVN+G8Rhz6jlbTzyU9tpn2zGlkGyxj8y6nJxFn
	G1lbFHKVv8CRpP3F+esuR22X0OeEKvSVRWcZ3mjqupyVReEDwEEMDOJtGtkq6osXzjtHX9vXkfnoF
	IIMXeSXouU8Y0ql3cSSMCvIH2SD7ANvejYeuvmS4H/7423WuMzD9fy+oYLyL0nPQjzNtqp39oMQlW
	L3jyNSh/6gImX0HpfBH0oT6SmUUMoE7NQDzQb7lzpaQbkDFbxDWOLPDPRUrnvA8IHxnQGP86vI4k9
	YvRl7Okw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oboju-005ZaX-5I; Fri, 23 Sep 2022 19:53:34 +0000
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obojr-005ZYf-Om
	for linux-nvme@lists.infradead.org; Fri, 23 Sep 2022 19:53:33 +0000
Received: by mail-qk1-x72a.google.com with SMTP id y2so764667qkl.11
        for <linux-nvme@lists.infradead.org>; Fri, 23 Sep 2022 12:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Xu8gZjkVZRWUz/+3Yxaqqu61sLGoB8IQaIP0sQAkChQ=;
        b=Cki3lJod5MEkJT5PN6PT1v5YUMO4lOq8Qgdcx15IKRvBbMdbxNdRgk41r5xfQQ/1HG
         2ASULy9J6ltZ9W3t4wV3uaujA3tMiHfytMnnyRwJ7MTaF+BowtUE0Pkfd7y5ZTm6LRU4
         iL+guWh7lj4qja4HLmTeHePH8D5hMfjQ+ltTRZ7mm/+RJczYgFcvcJpCtbEcZmnsPPWf
         fegxJ8YTeFW3wcgHYmVZhupjegar2Xf7IUWRnxVeo3IyP9whokDd3qJmBEVrcoSU6U9L
         70gBpR7otxqq7USMmzoekqnIsRytd0JMACVCWp7tqC4bTgF0wMjR+GhMk1KK2fvW1DQu
         lumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Xu8gZjkVZRWUz/+3Yxaqqu61sLGoB8IQaIP0sQAkChQ=;
        b=W39ciyJ6ELRX0cslUD9adY/1GBBKMJUBVzkSbxDUWydH3U7+TEqTtIaz3zrlnn5tVy
         6/PqvUpq8etfvUYWw0s9TlY/nyLS/lCL7EHsil1lCiINbv9aPhad3KGPcCwm/aan8kR7
         NZsJz1bucgb2iNJsDgPtevasmfoZ0EjEFnw3DFkYQqOPNLcLQWvRKiZOJSx4SIvyW/J8
         b93GNwFXg4ECrbJbQEbfq7N5QggNKVZJJXs1eKHCmxreThErAa6ea9GwuGEDctBhE0Uw
         A0VjLZ3EB/Bw/8g+nRnkucEP5TM4YAVXMM8ePOX2oP/sj7bCLPVkC9jHgIT1DY1yHECR
         wgBg==
X-Gm-Message-State: ACrzQf2pyOlobSVpd7EkjnuziCyCT/o2LcWHgmiNJSmiHViLzLnHl5c0
	W11mZPXIr3S3sauJXvr7WXrUVQ==
X-Google-Smtp-Source: AMsMyM4n7SyKJcwiqURLSex/T5WPj5xfwJObpr4myLNC80+tgwD+8gKZ6p/kJJeI2S3cibPwERKwrw==
X-Received: by 2002:a05:620a:24d6:b0:6cd:f96a:35b with SMTP id m22-20020a05620a24d600b006cdf96a035bmr6784230qkn.471.1663962808669;
        Fri, 23 Sep 2022 12:53:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id d21-20020ac84e35000000b00359961365f1sm6178104qtw.68.2022.09.23.12.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 12:53:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1obojn-002y80-Ez;
	Fri, 23 Sep 2022 16:53:27 -0300
Date: Fri, 23 Sep 2022 16:53:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Minturn Dave B <dave.b.minturn@intel.com>,
	Jason Ekstrand <jason@jlekstrand.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Xiong Jianxin <jianxin.xiong@intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Martin Oliveira <martin.oliveira@eideticom.com>,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	Ralph Campbell <rcampbell@nvidia.com>,
	Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v10 1/8] mm: introduce FOLL_PCI_P2PDMA to gate getting
 PCI P2PDMA pages
Message-ID: <Yy4Ot5MoOhsgYLTQ@ziepe.ca>
References: <20220922163926.7077-1-logang@deltatee.com>
 <20220922163926.7077-2-logang@deltatee.com>
 <Yy33LUqvDLSOqoKa@ziepe.ca>
 <64f8da81-7803-4db4-73da-a158295cbc9c@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64f8da81-7803-4db4-73da-a158295cbc9c@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220923_125332_181270_2531F995 
X-CRM114-Status: GOOD (  26.61  )
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

On Fri, Sep 23, 2022 at 01:08:31PM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2022-09-23 12:13, Jason Gunthorpe wrote:
> > On Thu, Sep 22, 2022 at 10:39:19AM -0600, Logan Gunthorpe wrote:
> >> GUP Callers that expect PCI P2PDMA pages can now set FOLL_PCI_P2PDMA to
> >> allow obtaining P2PDMA pages. If GUP is called without the flag and a
> >> P2PDMA page is found, it will return an error.
> >>
> >> FOLL_PCI_P2PDMA cannot be set if FOLL_LONGTERM is set.
> > 
> > What is causing this? It is really troublesome, I would like to fix
> > it. eg I would like to have P2PDMA pages in VFIO iommu page tables and
> > in RDMA MR's - both require longterm.
> 
> You had said it was required if we were relying on unmap_mapping_range()...

Ah.. Ok.  Dan and I have been talking about this a lot, and it turns
out the DAX approach of unmap_mapping_range() still has problems,
really the same problem as FOLL_LONGTERM:

https://lore.kernel.org/all/Yy2pC%2FupZNEkVmc5@nvidia.com/

ie nothing actually waits for the page refs to go to zero during
memunmap_pages(). (indeed they are not actually zero because currently
they are instantly reset to 1 if they become zero)

The current design requires that the pgmap user hold the pgmap_ref in
a way that it remains elevated until page_free() is called for every
page that was ever used.

I'm encouraging Dan to work on better infrastructure in pgmap core
because every pgmap implementation has this issue currently.

For that reason it is probably not so relavent to this series.

Perhaps just clarify in the commit message that the FOLL_LONGTERM
restriction is to copy DAX until the pgmap page refcounts are fixed.

> > Is it just because ZONE_DEVICE was created for DAX and carried that
> > revocable assumption over? Does anything in your series require
> > revocable?
> 
> We still rely on unmap_mapping_range() indirectly in the unbind
> path. So I expect if something takes a LONGERM mapping that would
> block until whatever process holds the pin releases it. That's less
> than ideal and I'm not sure what can be done about it.

We could improve the blocking with some kind of FOLL_LONGTERM notifier
thingy eg after the unmap_mapping_rage() broadcast that a range of
PFNs is going away and FOLL_LONGTERM users can do a revoke if they
support it. It is a rare enough we don't necessarily need to optimize
this alot, and blocking unbind until some FDs close is annoying not
critical.. (eg you already can't unmount a filesystem to unbind the
device on the nvme while FS FDs are open)

Jason

