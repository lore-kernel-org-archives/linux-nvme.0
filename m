Return-Path: <SRS0=ToWz=FO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD4AC2BB9A
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 04:04:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32BB723D58
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 04:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32BB723D58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Mcy7M9WTHdkkSZONjz4Hxn2z/YbgosijuD0E6tSKGY8=; b=JqzNuRdDXc1hkWNxtewUymXAa
	mg1uMffOD7I5vtOtMvxdH/hXCV9BPIjAKMFn44G9L/RBHTLVUj2K8tc2bKfWfBY7ykfI6fPko3KzZ
	4s5ngRGiQKJRPoRT36Ss0HAwiXptpGBwww1iZqvFl2e2F48K5KMus8gQUy6R8BLgR5SS4tWz6Gu4g
	Wi0zT5AcGYmFSHHdb+1eKBSq9DJmh+V4N7EAkiAjudbbwfMVjyL+dP27p2ja/HFPP4fiMhhjmu9t0
	nzOmCdpoaRZ1H0g34GcmAvOhwEZAaA4Tx+lewuEQFYOBcMR8++B3ou1yXTELhDsoP87XCclG9Yv4X
	AXSbslGuw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1knDBY-0008SI-Vt; Thu, 10 Dec 2020 04:04:09 +0000
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knDBV-0008R9-1c
 for linux-nvme@lists.infradead.org; Thu, 10 Dec 2020 04:04:06 +0000
Received: by mail-ej1-x644.google.com with SMTP id b9so5413101ejy.0
 for <linux-nvme@lists.infradead.org>; Wed, 09 Dec 2020 20:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aiXzNIBEdezK7LvwdToUmyEveX4RTWL1Q1rKEHzG6GY=;
 b=V12HS7Wn+bctaIkufygbNwtKV1pkBbE9hHZV8Lf9tSE5VPt6nBit0Nb1HWPIB+8XdO
 UwbjHDBYoCvlSOrafC5rCuQbCx1D+/3PDyFehNe398RSQzHQ1rPu9pgXYXyg3wMVKY7l
 FuBEUYEFzcobG0z1knWel86vWiyTyuA3aX6iyNBGyPUSEugrsJ77EmD5w3Zhr4gllpgD
 NDD0P3wO1Rjasg3bPJKXdNNtxJFUZzyODiRBozAcezwWwmKvGT1tnVg88ssqoLYPKQyE
 vxZa8+AdNxohhjfYmcfYxPAKri7o/zxhpGNApPEe/Ugj0ylq5uh8h/HdVnA0K5L3ljWV
 0UiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aiXzNIBEdezK7LvwdToUmyEveX4RTWL1Q1rKEHzG6GY=;
 b=dm2CUoUttRqSK4lrycWCiIjG9FWXdsbuo8tjNdSyWseAA0ZgH5UawL5EoEM5fRyf0J
 G+7JtCld8OHy2t67H6fWzcarQqOtrOnkJMNT2tSMYN1r95bGW2P1F/T0P0AZ/Zso5HQ/
 mNgw/1Fv14qxN+fMTbtoaMUfbrGUPqgWzlmTqhiylZJ3iSiOzD4rOOSwHFkFBW1xCmpw
 JFiFMlp5e9GG9wekz0DOxhPekzCq6YhutjeI4iYGBEIChmMqgKlztA3STIdvr2g1sAic
 4AKqGGDYpIYfHZ5FK3TAvEQZB/JcAnAlafOET0lqrtukLvIya/LKoAGFkMEx5ANm2MXg
 zYvQ==
X-Gm-Message-State: AOAM5329Z4cF9lFpXS7qJftsDC17q/+RleKrI4SGMWUYQa9Mqs5/HnMl
 lTfWwJujH9LexJYxrJDwL83i23Y7KIr294vWQyo6IA==
X-Google-Smtp-Source: ABdhPJz4kqsM2zajOVSAKgswV7LD/u9Of8EB4mcOSELuzl9N3rbE8Zn+Vb136NhMCEF83xMViBOj9nm8pJkMBp6g77Y=
X-Received: by 2002:a17:906:518a:: with SMTP id
 y10mr4811157ejk.323.1607573042542; 
 Wed, 09 Dec 2020 20:04:02 -0800 (PST)
MIME-Version: 1.0
References: <20201106170036.18713-1-logang@deltatee.com>
 <20201106170036.18713-5-logang@deltatee.com>
 <20201109091258.GB28918@lst.de>
 <4e336c7e-207b-31fa-806e-c4e8028524a5@deltatee.com>
 <CAPcyv4ifGcrdOtUt8qr7pmFhmecGHqGVre9G0RorGczCGVECQQ@mail.gmail.com>
 <fba1022b-1425-bb79-9af8-fe68e6f2c56e@deltatee.com>
In-Reply-To: <fba1022b-1425-bb79-9af8-fe68e6f2c56e@deltatee.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 9 Dec 2020 20:04:00 -0800
Message-ID: <CAPcyv4hr=kM6--OUdK+6XAAEVzENJmy-uD78yK-p62bW8vbu9g@mail.gmail.com>
Subject: Re: [RFC PATCH 04/15] lib/scatterlist: Add flag for indicating P2PDMA
 segments in an SGL
To: Logan Gunthorpe <logang@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201209_230405_219405_7FEDA29A 
X-CRM114-Status: GOOD (  19.70  )
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
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Linux PCI <linux-pci@vger.kernel.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Ira Weiny <iweiny@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-block@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
 Don Dutile <ddutile@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 John Hubbard <jhubbard@nvidia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Dec 9, 2020 at 6:07 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2020-12-09 6:22 p.m., Dan Williams wrote:
> > On Mon, Nov 9, 2020 at 8:47 AM Logan Gunthorpe <logang@deltatee.com> wrote:
> >>
> >>
> >>
> >> On 2020-11-09 2:12 a.m., Christoph Hellwig wrote:
> >>> On Fri, Nov 06, 2020 at 10:00:25AM -0700, Logan Gunthorpe wrote:
> >>>> We make use of the top bit of the dma_length to indicate a P2PDMA
> >>>> segment.
> >>>
> >>> I don't think "we" can.  There is nothing limiting the size of a SGL
> >>> segment.
> >>
> >> Yes, I expected this would be the unacceptable part. Any alternative ideas?
> >
> > Why is the SG_P2PDMA_FLAG needed as compared to checking the SGL
> > segment-pages for is_pci_p2pdma_page()?
>
> Because the DMA and page segments in the SGL aren't necessarily aligned...
>
> The IOMMU implementations can coalesce multiple pages into fewer DMA
> address ranges, so the page pointed to by sg->page_link may not be the
> one that corresponds to the address in sg->dma_address for a given segment.
>
> If that makes sense -- it's not the easiest thing to explain.

It does...

Did someone already grab, or did you already consider the 3rd
available bit in page_link? AFAICS only SG_CHAIN and SG_END are
reserved. However, if you have a CONFIG_64BIT dependency for
user-directed p2pdma that would seem to allow SG_P2PDMA_FLAG to be
(0x4) in page_link.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
