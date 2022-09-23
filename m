Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007A5C07E9D
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Sep 2022 23:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5ASiwm1avkHZc/hoLIIFI/eZ/ZpBbfiIv79qS4VlyJQ=; b=cqeTOhrCZUjaSsnCJ1f77c8XY/
	V6vHunSa1tKRrM51wKm5ji+hd/0H2N7Ufr1nEuWRz+RI6gv2s4BLkU02RCJ/Bg5h87JbW1K0Ihjab
	Rhb7AbZ+n+tsVwS6VJe/RXIYwCwRmB8BuQGcd/nPbv9FuCNbGy3hPe6I00bybetgIx6sTbO7yqDm4
	b6n0f1MIbT/1Vd4jfKsXch64SrQHuxGjWC8jhkjzb3d9OX9LbQmv2AYUj2tXutD4JEJQizF1cuaJI
	u/It1MoY0cOBOuIQM/UlrP0agojwt9JZYWCKotKDc+MiXkaYi9V3/hv8O3JQGpoulVNICxah82bfW
	m39/F8bQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obrzJ-005wi6-8e; Fri, 23 Sep 2022 23:21:41 +0000
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obrzG-005whF-NT
	for linux-nvme@lists.infradead.org; Fri, 23 Sep 2022 23:21:40 +0000
Received: by mail-qt1-x82a.google.com with SMTP id r20so977806qtn.12
        for <linux-nvme@lists.infradead.org>; Fri, 23 Sep 2022 16:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=5ASiwm1avkHZc/hoLIIFI/eZ/ZpBbfiIv79qS4VlyJQ=;
        b=S5exWhlgK2IwN/41jFZWVgtUOIPgOVHZzklRjzN/LhjEdicvHTUHfUAsCYVTnPVnJ2
         pLEkXf8ppCaivB8zKkiV5xHWOxHPCLi3Oh+ndtGqO5/3PUUide2X+tNk9f/o4UzdzyYs
         l723v+ePlu64jTV7J6j32h1l2vV58qu0PGnwnjWq1iAlo8weVGw4X7p2xu80tzvCf8Bc
         ooZJQ9qz1n896baC9VOTDnZDGs1Udgq290N5MKBgwJb9UGx/0yIR9beq7q1pXKyuOrOG
         qyywJClQqtur0GI4MaezATtC6BZH247PjXoZSk168tI57X6i1340gKDYtNSceLs7zRnN
         PqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=5ASiwm1avkHZc/hoLIIFI/eZ/ZpBbfiIv79qS4VlyJQ=;
        b=5m8xp2V2oXq2/+6HLbF5rXSfmGeuGrcCUgh7trgI3GZdWYutAX19MY+v2RgFKFlnhW
         UqsQfZbSZDL7c2Ju6on1QvASSaQlOoYajzNkDZ5p0FswcY6NYKlkdQ9DdjwQj/AvEm4g
         Ixrb0qDt4eThHwkoPNBUC2Gkl4kAcTSsYIgaox0hT4/kClnTlDpbHn/6AnW1i3Yzx/GH
         7Z9G8MWbPd6l7kUTiHYwmLTWKBM8l0nekjNtFm2DQ+S2/WVpTg2EQVd57fELcwhC+NH5
         6IPyLAO6IK4RLOafDmXE0VXfULizEkYSCxSEKc1HRRkssFiUkFv6/hUmhyQ96Zo2sOX1
         WAEw==
X-Gm-Message-State: ACrzQf03HltkSyaLqu8bGFXp/unUtBJsZV5iDDs0T1PirfxUwr2D30xP
	f6npxipmmx0ImPyniFp7gdUWuA==
X-Google-Smtp-Source: AMsMyM6UQR7CtJ4cZm41QVD6wT/F9o4m06KKQo4p97qx0szYOwFcvEevzn63HXF/BrGZl/ZOmXXdrA==
X-Received: by 2002:a05:622a:174b:b0:35d:1be5:c65e with SMTP id l11-20020a05622a174b00b0035d1be5c65emr6445841qtk.422.1663975297167;
        Fri, 23 Sep 2022 16:21:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id t83-20020a374656000000b006ce9d6e51f4sm6650434qka.67.2022.09.23.16.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 16:21:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1obrzD-0035zj-Lo;
	Fri, 23 Sep 2022 20:21:35 -0300
Date: Fri, 23 Sep 2022 20:21:35 -0300
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
Message-ID: <Yy4/f+s1jOCm7dFo@ziepe.ca>
References: <20220922163926.7077-1-logang@deltatee.com>
 <20220922163926.7077-2-logang@deltatee.com>
 <Yy33LUqvDLSOqoKa@ziepe.ca>
 <64f8da81-7803-4db4-73da-a158295cbc9c@deltatee.com>
 <Yy4Ot5MoOhsgYLTQ@ziepe.ca>
 <2327d393-af5c-3f4c-b9b9-6852b9d72f90@deltatee.com>
 <Yy46KbD/PvhaHA6X@ziepe.ca>
 <3840c1c6-3a5c-2286-e577-949f0d4ea7a6@deltatee.com>
 <Yy48GPMdQS/pzNSa@ziepe.ca>
 <aa5d51dd-0b40-29c0-69af-e83043541d3e@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa5d51dd-0b40-29c0-69af-e83043541d3e@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220923_162138_828691_3C492151 
X-CRM114-Status: GOOD (  30.68  )
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

On Fri, Sep 23, 2022 at 05:14:11PM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2022-09-23 17:07, Jason Gunthorpe wrote:
> > On Fri, Sep 23, 2022 at 05:01:26PM -0600, Logan Gunthorpe wrote:
> >>
> >>
> >>
> >> On 2022-09-23 16:58, Jason Gunthorpe wrote:
> >>> On Fri, Sep 23, 2022 at 02:11:03PM -0600, Logan Gunthorpe wrote:
> >>>>
> >>>>
> >>>> On 2022-09-23 13:53, Jason Gunthorpe wrote:
> >>>>> On Fri, Sep 23, 2022 at 01:08:31PM -0600, Logan Gunthorpe wrote:
> >>>>> I'm encouraging Dan to work on better infrastructure in pgmap core
> >>>>> because every pgmap implementation has this issue currently.
> >>>>>
> >>>>> For that reason it is probably not so relavent to this series.
> >>>>>
> >>>>> Perhaps just clarify in the commit message that the FOLL_LONGTERM
> >>>>> restriction is to copy DAX until the pgmap page refcounts are fixed.
> >>>>
> >>>> Ok, I'll add that note.
> >>>>
> >>>> Per the fix for the try_grab_page(), to me it doesn't fit well in 
> >>>> try_grab_page() without doing a bunch of cleanup to change the
> >>>> error handling, and the same would have to be added to try_grab_folio().
> >>>> So I think it's better to leave it where it was, but move it below the 
> >>>> respective grab calls. Does the incremental patch below look correct?
> >>>
> >>> Oh? I was thinking of just a very simple thing:
> >>
> >> Really would like it to return -EREMOTEIO instead of -ENOMEM as that's the
> >> error used for bad P2PDMA page everywhere.
> > 
> > I'd rather not see GUP made more fragile just for that..
> 
> Not sure how that's more fragile... You're way seems more dangerous given
> the large number of call sites we are adding it to when it might not
> apply.

No, that is the point, it *always* applies. A devmap struct page of
the wrong type should never exit gup, from any path, no matter what.

We have two central functions that validate a page is OK to return,
that *everyone* must call.

If you don't put it there then we will probably miss copying it into a
call site eventually.

> > try_grab_page() calls folio_ref_inc(), that is only legal if it knows
> > the page is already a valid pointer under the PTLs, so it is safe to
> > check the pgmap as well.
> 
> My point is it doesn't get a reference or a pin unless FOLL_PIN or FOLL_GET is
> set and the documentation states that neither might be set, in which case 
> folio_ref_inc() will not be called...

That isn't how GUP is structured, all the calls to try_grab_page() are
in places where PIN/GET might be set and are safe for that usage.

If we know PIN/GET is not set then we don't even need to call the
function because it is a NOP.

Jason

