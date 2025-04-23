Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C51C369D3
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 02:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jJ8s1tHlAlZHZLBcym34Knli5JlhGSSEZ8s9pr2exho=; b=Nsn+/mhlQwD6Lw0ULT8EY1mUz0
	5nivUjTeHn4EnBlAj+QpSZVdgg3NDacJ9cTv1yprwA6mWkrjtn5XHpmZJxuBqxmE3QSUI8HuHAn1o
	Wv+1/sFRhz1dOH7yErqrBFPF8fP6DM6naiRzHi/TefB0nmxN54WQITjrtfzR1l86o1WIk4MNUvCsT
	GTTPySOYZZODGbR5TpJeLK85tNdHIKF9tcBTjOrjCrsF87AZ3wLdg5D8sK3pXPCNcxoIphSlRo0so
	rG5WTJ17ODeEHAIkvPbRFy91V0dv3XFaH0iYmgqqEJpABHfDPO/cSkywrJeRXJwt3d9b5XLN+vByx
	kxaOPANg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7mn0-0000000Cf6h-13D2;
	Thu, 24 Apr 2025 02:58:14 +0000
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7eei-0000000BWTK-2VyW
	for linux-nvme@lists.infradead.org;
	Wed, 23 Apr 2025 18:17:09 +0000
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-4766631a6a4so1565881cf.2
        for <linux-nvme@lists.infradead.org>; Wed, 23 Apr 2025 11:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745432227; x=1746037027; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jJ8s1tHlAlZHZLBcym34Knli5JlhGSSEZ8s9pr2exho=;
        b=QYE3pTczjBKgvm0SOeCUmpomnId275GslUFz0VIEmh8n3whQ/vSUksuXfqlIdIH8N5
         FG5cnRI0qLhVU5lGn9UvM4I4entrFjqqIqSQIzOfHftCquCd1i7zvnonzgJ7H9z9uHDP
         cObbeoOmr/YF1I2OVr51GV/2SUByNyA5+XZ3vOto4ZjFlCppZc7jo9qG39GBldCrz99O
         voMssEwRnBuMyxj8X2w0akbvrnxBnv++CB0LHE5KnlBzy3fbyqGLEV+wsX1y/cYaSzkC
         OardtV8M3F98BAOZR2V4zNiVSDkPZyuwUzY3Vmx6jvOmoQ7iMHprW5phjNUsEva8YFww
         QH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745432227; x=1746037027;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jJ8s1tHlAlZHZLBcym34Knli5JlhGSSEZ8s9pr2exho=;
        b=ZpwQHdj1pzhCpJ2irOiQHZU8wtqbLL02PHMMxOUWrNh1Ql53QBIKn4/dx6XGhJFzQb
         2xxYjd7cjXhyGyhfVMCrDVRJHPuIGxbeBhxwzIOV5beWFSHydQlX484iRftxIbqV981z
         2iN6n6x2Xb6kd3zLRnhV4EvXsawy/fr3Q11q17fD/VoMHiMAGdBUVIEAxCfIKw5gvcUs
         Kb+xOx81i5wBHTDrR66Qi47tFeheZD1JnlwmFznv53vDXzNu6Z4KPu6BteQNZY++udhQ
         ZvBb0T9CLrvSomAB/hqm0ZQt8sy9U/NvtSwX1vg4BkN3qW9Gi65hQPMkVPsRt9b75BGW
         ElJg==
X-Forwarded-Encrypted: i=1; AJvYcCWfVpmORoccTPRO8DDzzo6HG/5s/eqWzO+qGP6B0etNi6ItBL6ctVUf6+npqNI4qgxSs1ANQ+DRnGq6@lists.infradead.org
X-Gm-Message-State: AOJu0Yyeh1ct0rjl9sprv4wDNOCT7sEAZePG14pW9GsCz+fX5Cm8MBAq
	V1GDmvwMTmT+0D7bznI7+df9/BL6WDe+KW2ZNt9R72bQjdU1NjBxNQHOzJaVgOg=
X-Gm-Gg: ASbGncvC7tIJel7w3v2P3GATaWJOGM/BeWK6TeWCk2AGMiVyFmLccRDrHjl+pwGu8wt
	5Z8moJAwXFApP88YP28OFsbo1vBJ0e4bmSTKCUDR3sDL+k/TWDw7yIO5VUZQK43XMaZnNSj1dnd
	su525yFq/XZEevYH3G7QiBvTLDiE7X2cjWLZy31MTpHXGdvUNI+/RbuqWPZMiB/ZaPSrN1V6LZ2
	mjkl2OUgYa1Up3hdO6t81wdSmHorz37J9aMzq92/9ccWEb1q2pAJbmRWvHBBLPbR2Id20uVGrhX
	cYXFkfARwqdtk8uMd/N1BebRJ1MI4YffEv+fhfhdsmIYeCyoy5KSe/5N/Fv/4ba9sCTN/kSoJrw
	D/2MG3U02XlCL+JRKjQk=
X-Google-Smtp-Source: AGHT+IECPlcFTYHnkwAKKk3B5MzEp2J+Q23qmmOis8VDE/Xdu9ZIh9LzQbjBc0+xoVESECxntDW6lg==
X-Received: by 2002:a05:622a:d4:b0:476:95a2:64a1 with SMTP id d75a77b69052e-47e76175c16mr4073601cf.17.1745432227237;
        Wed, 23 Apr 2025 11:17:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9c16dd2sm70921841cf.14.2025.04.23.11.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 11:17:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7eeg-00000007Lzi-1CSb;
	Wed, 23 Apr 2025 15:17:06 -0300
Date: Wed, 23 Apr 2025 15:17:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mika =?utf-8?B?UGVudHRpbMOk?= <mpenttil@redhat.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v9 10/24] mm/hmm: let users to tag specific PFN with DMA
 mapped bit
Message-ID: <20250423181706.GT1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <0a7c1e06269eee12ff8912fe0da4b7692081fcde.1745394536.git.leon@kernel.org>
 <7185c055-fc9e-4510-a9bf-6245673f2f92@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7185c055-fc9e-4510-a9bf-6245673f2f92@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_111708_640137_6AD2CE4C 
X-CRM114-Status: GOOD (  18.55  )
X-Mailman-Approved-At: Wed, 23 Apr 2025 19:58:12 -0700
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

On Wed, Apr 23, 2025 at 08:54:05PM +0300, Mika Penttilä wrote:
> > @@ -36,6 +38,13 @@ enum hmm_pfn_flags {
> >  	HMM_PFN_VALID = 1UL << (BITS_PER_LONG - 1),
> >  	HMM_PFN_WRITE = 1UL << (BITS_PER_LONG - 2),
> >  	HMM_PFN_ERROR = 1UL << (BITS_PER_LONG - 3),
> > +
> > +	/*
> > +	 * Sticky flags, carried from input to output,
> > +	 * don't forget to update HMM_PFN_INOUT_FLAGS
> > +	 */
> > +	HMM_PFN_DMA_MAPPED = 1UL << (BITS_PER_LONG - 7),
> > +
> 
> How is this playing together with the mapped order usage?

Order shift starts at bit 8, DMA_MAPPED is at bit 7

The pfn array is linear and simply indexed. The order is intended for
page table like HW to be able to build larger entries from the hmm
data without having to scan for contiguity.

Even if order is present the entry is still replicated across all the
pfns that are inside the order.

At least this series should replicate the dma_mapped flag as well as
it doesn't pay attention to order.

I suspect a page table implementation may need to make some small
changes. Indeed with guarenteed contiguous IOVA there may be a
significant optimization available to have the HW page table cover all
the contiguous present pages in the iommu, which would be a higher
order than the pages themselves. However this would require being able
to punch non-present holes into contiguous mappings...

Jason

