Return-Path: <SRS0=pISK=JY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F8DC433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 19:44:14 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E9A6613C8
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 19:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E9A6613C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sUFloiAkzE7Kz62owiFwqL1LuteaNMQlNNUOdJi8s5E=; b=jCA73acJdPvHQuqVAx+gpGbo/
	fdtZEZQnRmaSADqrqoUW0sHCMm0LlxOLC36oClV6ftoKdZH5CYjHFs3/ta2wUsTNSkKHIQ9XzSETY
	GO8rWXFa2Suzcp3kTKRV3ezEmkg6/uxKnS3sgR9sIQLrS3iMty2f2lItxFqiylA1JRww66N1rm2Kg
	RZE2F8cIjKs/hobk2SyTnV1Zi3zTP6WyoQBzCvTbeMBIMlTUbB1kGoVy3SevZ4+7vkzqyu7BYKQFt
	zVGKSBVaiUZfFls14CD6mUXflMmL3jbDibzw2RPK5weKP6i5N5KXfS+INnZIDNjImC2sdWkQ2rHjI
	IbM81tT1g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbTcW-0028a5-Ud; Tue, 27 Apr 2021 19:43:45 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbTcU-0028Zt-Vp
 for linux-nvme@desiato.infradead.org; Tue, 27 Apr 2021 19:43:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=pMOFBLR9bPrFoZFV8TQo6qdI8xIDUT5QowoTJPAfwoI=; b=i7n2CB6WTCkn2Puqe26OQeqvkL
 FdmsR9/S00hVX5h3kTyhiojSlOty4la/tEmJq3UMMly8MYGAcEbKAQP9QPCPCs12+Fd3KbGsQi3IP
 2kvQc/eFQ3kK9RW5kaYtg3APsMF8OjTCOYZNJ7GS0sup3TozEL13TyORzjbOjvt4rAoC+FNtD2OSz
 EAgh/KbUSu4RqwrWT0r/6MDemkFD9JOX1bxaJ5hqr/EoWf+oH+NbFNtENtXgzracdzpmLusfIod4j
 MBuyTeMeY/FZYMwTLpmY91p+3xWL/hqmqVtLkhiBkDzFFys9ikodKoAoWZd2vfruCTqD+Fc2WdymB
 eFVgaCUA==;
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbTcS-00Gx3w-G5
 for linux-nvme@lists.infradead.org; Tue, 27 Apr 2021 19:43:41 +0000
Received: by mail-qv1-xf2b.google.com with SMTP id l2so11727813qvb.7
 for <linux-nvme@lists.infradead.org>; Tue, 27 Apr 2021 12:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=pMOFBLR9bPrFoZFV8TQo6qdI8xIDUT5QowoTJPAfwoI=;
 b=M20T+1aMae4u0P7fbin4a8R02TMD5t96H2aiOMf8qw2rTRAo2RugFe0ku6l9VPeevP
 xZtgBQRLaSsu9aYFKNdNDSiFe3aolwh10xjABQqThOUIndi0+s4d+Eo1XLPCXC3nfxUm
 lD1alvOMjEL0+ef6cYE7iSz2VLoq5w2e7VmYnhskgoJag9ZejVAXw548Sw3tJzTwQ1LK
 Hq28R0ucjVcFeEwJijDgtLouLoL1kPblKx+vhiQSapRdIiXAHGIAof9xt+quTVbA5Swo
 WJ9Cx6H5u7fywz1Osz6ow6XWlpeS1lNkpzj+0hZhr2dKqs99inl2pJxQ1Z2SVZi0WDJl
 pNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pMOFBLR9bPrFoZFV8TQo6qdI8xIDUT5QowoTJPAfwoI=;
 b=nsXmzcj3W52VCG922ooWOiwPhCkcKXAJZPC0kxsM6KrTH92nVa4qBp3Pp5pL0z+ynZ
 Fr+NbyeGU5tHYVw7VEhP1BnbQzrL1DPbPjhdeK/zlXKCvLwyIASu51zyUoOrnUiMFhQq
 r+hstQSPdRhQPQkf4kvsngkrVm62n8g/hNUY0J7BF5WLETl4l3jTH+apTVf18+vatEY9
 L7MRr1ySFD6AV+xCy+mQ2eP4CQQSZ6MHzOa7yyMqWrjXhUKSwkNfgw6rwll6rooRjtD0
 XFcmKYVVw+7Pnnt6kESSDziwJmXVXzgy0Qi5N5Hn3UrmkbMOCNt0K6YpKwpNi467q4Rv
 SJDw==
X-Gm-Message-State: AOAM5329rG57L/+6P90fHYD1wBUrGZfOkI5c9V16Ir+gIjk3ZIqlIJ4Y
 3K6n3D6ShZN1yJb7bAD8l1NWdA==
X-Google-Smtp-Source: ABdhPJzaHrq9X7iYnbBeG48woUZiUTHE+b/d9aEc9zMuai3hrX463cNK4Akxfstc2Wbz1Cy4s9UnAQ==
X-Received: by 2002:a0c:e8c4:: with SMTP id m4mr2551153qvo.21.1619552619024;
 Tue, 27 Apr 2021 12:43:39 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id y26sm688104qtf.66.2021.04.27.12.43.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Apr 2021 12:43:38 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1lbTcP-00Dh5j-HM; Tue, 27 Apr 2021 16:43:37 -0300
Date: Tue, 27 Apr 2021 16:43:37 -0300
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
 Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 11/16] iommu/dma: Support PCI P2PDMA pages in dma-iommu
 map_sg
Message-ID: <20210427194337.GT2047089@ziepe.ca>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-12-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210408170123.8788-12-logang@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_124340_556251_2D14BE8B 
X-CRM114-Status: GOOD (  12.65  )
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

On Thu, Apr 08, 2021 at 11:01:18AM -0600, Logan Gunthorpe wrote:
> When a PCI P2PDMA page is seen, set the IOVA length of the segment
> to zero so that it is not mapped into the IOVA. Then, in finalise_sg(),
> apply the appropriate bus address to the segment. The IOVA is not
> created if the scatterlist only consists of P2PDMA pages.

I expect P2P to work with systems that use ATS, so we'd want to see
those systems have the IOMMU programmed with the bus address.

Is it OK like this because the other logic prohibits all PCI cases
that would lean on the IOMMU, like ATS, hairpinning through the root
port, or transiting the root complex?

If yes, the code deserves a big comment explaining this is incomplete,
and I'd want to know we can finish this to include ATS at least based
on this series.

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
