Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E5FC32771
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Sep 2022 22:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0oTmPF8OXz/CvwH1nuIdtQazTpalf2fsvzakYLiefMI=; b=OqaWYlfZKdfB6lg0v6OuD34I3w
	JwJLHtiP5uXXwZXz1LpgBFQdQNQck0tlbV6KiyEPbh+jbG+gcwBH+1i8a6ZwA++9+BTlRXcduyM+5
	AXOUtXGfpNqgrXYK9X7Cb1aNweCI/vaSBKjrLPlR+hVv+Oqk6n4Hf7nj4UNDrFB4jQLEgPI6vRonE
	yXxQgzq1WUmC53/hunJ2PFVTqVwceMBH/g5b9Ejx17ksLMAcTJSzq8lTZHbJ43zJaHdzr8DKf5ICu
	f2N//xOo5KvITLduf6SzMkU3VYZHPp1j5b/6hhohq0uxX83n0PtMln+Pi3YUsQww+kJEsKev61pi6
	Lswim8rQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocx2Q-007Hdu-Fw; Mon, 26 Sep 2022 22:57:22 +0000
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocx2N-007HbA-9y
	for linux-nvme@lists.infradead.org; Mon, 26 Sep 2022 22:57:21 +0000
Received: by mail-qv1-xf2c.google.com with SMTP id l14so5243223qvq.8
        for <linux-nvme@lists.infradead.org>; Mon, 26 Sep 2022 15:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=0oTmPF8OXz/CvwH1nuIdtQazTpalf2fsvzakYLiefMI=;
        b=AAuidSESOdluh22iHoNdq1ialZQHJi8DlKeQnNqP8tWtqZ0iWgOxeNjSwkyHl3UQlo
         EaRAzbnIRBWMdo4nhZwbRFS3a20sJ7mYxHKh7Vc0kXen7QbCUiBzmJEMG/gKmdGxQQt9
         TcfjCa/9U+Ha5Bc3h5TKe+CKna/iYXcCMoCb91DUARCakDg6wnUiVm7MGAuLY0BDZYCN
         J3kDV6FsQud562i1x9eaKHSC/ucw6t+++AJcg8A+pKvW/vp+3q1yUpu1sszuNx3oK8VA
         mZZiklHsIKm1548z2J486iqmDSDhDgGH+oWZ8C1MmRSEkFMnzH98qm2RbCK7u9yUeYB7
         6hrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=0oTmPF8OXz/CvwH1nuIdtQazTpalf2fsvzakYLiefMI=;
        b=AHT3B9aSpoZkGx5FeFrVjIHPjhjCa/XkW2bnJsbTbIJLL7W1MxVfVKg463kqqkoOp3
         LYNRq/d572F6bBNoWGdixmsenhJd3fi1Vu4TzQKSYT4ufNleTENYIQaA4bf/GN78ETQQ
         liMEm+i4s3IekD+gABPHWC6PScqTd3hyoA82bq7T2BYcgOpyv8YKBwzNvnRBFhZ2PyEg
         UU5519Dj/BPKSKIguygtBc5NGGBMVbvri70gVvCizs2SKk+VA4+nYmd2r97KiEvqV+sK
         Uok8dVdbIy5ggZVnTfWiMFJHpLSjrepgYEMv73+jM9zt+xoNcPigGAiFmOV++ILZ1Uaf
         xdcg==
X-Gm-Message-State: ACrzQf1B7HFbu9depbbgrUy1gzoC1VcxuzaeqOooaTqxI9sxYL+8vOsJ
	WfLL8QiJuU57wzzmzXiLmX8qJg==
X-Google-Smtp-Source: AMsMyM7Fh0JEmgnwt37ZJHit80EZ1xpj8o5VJC2kJp3X5teg4vJeS+eiVLIo84JzglXvNOHGcfPCZQ==
X-Received: by 2002:a05:6214:2686:b0:4af:630c:78f2 with SMTP id gm6-20020a056214268600b004af630c78f2mr9100014qvb.52.1664233035861;
        Mon, 26 Sep 2022 15:57:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id az35-20020a05620a172300b0069fe1dfbeffsm12946809qkb.92.2022.09.26.15.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 15:57:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1ocx2I-000O97-1t;
	Mon, 26 Sep 2022 19:57:14 -0300
Date: Mon, 26 Sep 2022 19:57:14 -0300
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
Message-ID: <YzIuSsFpOC+VN1/P@ziepe.ca>
References: <Yy33LUqvDLSOqoKa@ziepe.ca>
 <64f8da81-7803-4db4-73da-a158295cbc9c@deltatee.com>
 <Yy4Ot5MoOhsgYLTQ@ziepe.ca>
 <2327d393-af5c-3f4c-b9b9-6852b9d72f90@deltatee.com>
 <Yy46KbD/PvhaHA6X@ziepe.ca>
 <3840c1c6-3a5c-2286-e577-949f0d4ea7a6@deltatee.com>
 <Yy48GPMdQS/pzNSa@ziepe.ca>
 <aa5d51dd-0b40-29c0-69af-e83043541d3e@deltatee.com>
 <Yy4/f+s1jOCm7dFo@ziepe.ca>
 <980899e1-532a-772b-2f6d-6fb017def50b@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <980899e1-532a-772b-2f6d-6fb017def50b@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220926_155719_727036_3B7F4FC8 
X-CRM114-Status: GOOD (  21.25  )
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

On Fri, Sep 23, 2022 at 05:51:49PM -0600, Logan Gunthorpe wrote:

> And on further consideration I really think the correct error return is 
> important here. This will be a user facing error that'll be easy enough
> to hit: think code that might be run on any file and if the file is 
> hosted on a block device that doesn't support P2PDMA then the user
> will see the very uninformative "Cannot allocate memory" error.
> 
> Userspace code that's written for purpose can look at the EREMOTEIO error
> and tell the user something useful, if we return the correct error.
> If we return ENOMEM in this case, that is not possible because
> lots of things might have caused that error.

That is reasonable, but I'd still prefer to see it done more
centrally.

>> If we know PIN/GET is not set then we don't even need to call the
>> function because it is a NOP.

> That's not what the documentation for the function says:

> "Either FOLL_PIN or FOLL_GET (or neither) may be set... Return: true for success,
>  or if no action was required (if neither FOLL_PIN nor FOLL_GET was set, nothing
>  is done)."

I mean the way the code is structured is at the top of the call chain
the PIN/GET/0 is decided and then the callchain is run. All the
callsites of try_grab_page() must be safe to call under FOLL_PIN
because their caller is making the decision what flag to use.

Jason

