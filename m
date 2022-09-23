Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4EF1C04A95
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Sep 2022 23:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EIl/nh29zH96tBjnO04+Za75Ipkt6sGk6uA16GsQuRo=; b=U4gxSqvWsZrxNPj3+5rF41DOjD
	raFkrMI/vNnAg3sG3UKBaszFulyqZhrdxhCo36fBkC6/PDTZXThznoUyb4BkTL4PK1VvR45vxffds
	nh2jK9xdC8x/UeN4RUplF3caoN0X6VhuNOthPHlqO6TyYzO397Uby87lm1vqh/GY3QgP6Jb0kPw8M
	Ua09kErGIPWTDqSik2jBcuYanbTBowox5FsHvWn/19+v7ebTeJmov41su70MIuGzHdb5KiGXopWWt
	uA3EEASoc02g54kxEKnqJFNR3waryNH/RGmpXq/0RdsdQW6T31WAs8brGpwFHIm385j9Ixj2bKd3J
	rXJNw+Ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obrlG-005vkq-Pr; Fri, 23 Sep 2022 23:07:10 +0000
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obrlD-005vjS-UK
	for linux-nvme@lists.infradead.org; Fri, 23 Sep 2022 23:07:09 +0000
Received: by mail-qv1-xf33.google.com with SMTP id mi14so852695qvb.12
        for <linux-nvme@lists.infradead.org>; Fri, 23 Sep 2022 16:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=EIl/nh29zH96tBjnO04+Za75Ipkt6sGk6uA16GsQuRo=;
        b=N+P38VAwzWrwNueTpnqYlcaO4Wwnh/yvGq5CrXQr+MEOIhsLJzkhHRaRGlZLxg+iey
         DYr2P/LNZNK9n8+I1zZMzIFj51vuzJpoC/m6kBz0D1tYPDZ6pEQe8GzyI442cqFVxiHs
         wgixALrJy9vDVOcBb3BWDjBnsAdri1GFyNtMW7PTfPV/gW7darPtzbWpjT5+YijAFkh2
         sYZcC248zBfiR8rnutPUSujZoc23CLex/qcIRD66Y3nxp7dTNL45L/IGXi6TOqDyE6yp
         clE87f/yyT0iJMg+J2x0ANJoOmOZGBzm4thw9YJeTmp1I8o7NCi4TQmNWzW+JQtcekVG
         cktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=EIl/nh29zH96tBjnO04+Za75Ipkt6sGk6uA16GsQuRo=;
        b=js8Rm7UEIb2RkBtRVDCTE4Y5pFzqg+j9nsp0p6pGET2foQLlV6+IwT16juIDHW9yIO
         QTMrii7Ab1zkoXrKkiFBD5db2H5GR+DphyGZvmoSwkVSn6QE4QIcdt98ne2PeILvR8ot
         RC/GFiQD7RvMtSVjry/4RRKjhHsny6ZXP8EVzkAh5J2qQM/FP7o2n7/pWuhziNNLan0Q
         2ZYKpMBNDiQcqWOkLZtV3XJkZqBo89BMInU0J99AySgqkGqiCH9mx4dtBVg4UyJ0ogY7
         1UpGhAM80H99nbbOX4utZn0Zz48LOVccTdx+6vNUIWjjzgnxi+w9ziQt5El8tE9ukPM8
         srfQ==
X-Gm-Message-State: ACrzQf3CnS3x0gRZDGM1ccOEO6nz47DmsJjIiZ22BIazpGyKJoY1StOA
	x8kbRWNjWCl9R5dJ1/Ft812HeA==
X-Google-Smtp-Source: AMsMyM4x5J2YZQ9LKsbzLk51XuSjAC/sL+Lbezcs8blw3lr1IQ0ZrvcYT8N/ZbZG9tkfXdkD76Kbrw==
X-Received: by 2002:a05:6214:2467:b0:4a2:e191:46b7 with SMTP id im7-20020a056214246700b004a2e19146b7mr9012870qvb.112.1663974426313;
        Fri, 23 Sep 2022 16:07:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id b13-20020a05622a020d00b0035a6f14b3cesm6656906qtx.27.2022.09.23.16.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 16:07:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1obrlA-0035kF-QP;
	Fri, 23 Sep 2022 20:07:04 -0300
Date: Fri, 23 Sep 2022 20:07:04 -0300
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
Message-ID: <Yy48GPMdQS/pzNSa@ziepe.ca>
References: <20220922163926.7077-1-logang@deltatee.com>
 <20220922163926.7077-2-logang@deltatee.com>
 <Yy33LUqvDLSOqoKa@ziepe.ca>
 <64f8da81-7803-4db4-73da-a158295cbc9c@deltatee.com>
 <Yy4Ot5MoOhsgYLTQ@ziepe.ca>
 <2327d393-af5c-3f4c-b9b9-6852b9d72f90@deltatee.com>
 <Yy46KbD/PvhaHA6X@ziepe.ca>
 <3840c1c6-3a5c-2286-e577-949f0d4ea7a6@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3840c1c6-3a5c-2286-e577-949f0d4ea7a6@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220923_160707_995779_62902BF8 
X-CRM114-Status: GOOD (  24.59  )
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

On Fri, Sep 23, 2022 at 05:01:26PM -0600, Logan Gunthorpe wrote:
> 
> 
> 
> On 2022-09-23 16:58, Jason Gunthorpe wrote:
> > On Fri, Sep 23, 2022 at 02:11:03PM -0600, Logan Gunthorpe wrote:
> >>
> >>
> >> On 2022-09-23 13:53, Jason Gunthorpe wrote:
> >>> On Fri, Sep 23, 2022 at 01:08:31PM -0600, Logan Gunthorpe wrote:
> >>> I'm encouraging Dan to work on better infrastructure in pgmap core
> >>> because every pgmap implementation has this issue currently.
> >>>
> >>> For that reason it is probably not so relavent to this series.
> >>>
> >>> Perhaps just clarify in the commit message that the FOLL_LONGTERM
> >>> restriction is to copy DAX until the pgmap page refcounts are fixed.
> >>
> >> Ok, I'll add that note.
> >>
> >> Per the fix for the try_grab_page(), to me it doesn't fit well in 
> >> try_grab_page() without doing a bunch of cleanup to change the
> >> error handling, and the same would have to be added to try_grab_folio().
> >> So I think it's better to leave it where it was, but move it below the 
> >> respective grab calls. Does the incremental patch below look correct?
> > 
> > Oh? I was thinking of just a very simple thing:
> 
> Really would like it to return -EREMOTEIO instead of -ENOMEM as that's the
> error used for bad P2PDMA page everywhere.

I'd rather not see GUP made more fragile just for that..

> Plus the concern that some of the callsites of try_grab_page() might not have
> a get or a pin and thus it's not safe which was the whole point of the change
> anyway.

try_grab_page() calls folio_ref_inc(), that is only legal if it knows
the page is already a valid pointer under the PTLs, so it is safe to
check the pgmap as well.

Jason

