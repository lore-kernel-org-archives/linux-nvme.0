Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF35FC04A95
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Sep 2022 19:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZQmZb+lXFhX7pnMcsk23AOR4qV5DlMOOudYTRaQuI38=; b=A1k4cCk3uECPWQ
	ePlANWuY95W8fRUUuv0WD6Qc/Xhtkk1QyfH+v740AOceh9iAlLesnbzSnI1+oGkBiLrBYU+k0eKY0
	YoNvfvB3AOYQbxzx4XLgOVNwmYhJnvwjKAziN2cuHTayuMBkVjHgQkHof2+uodmwS/2w+kOJcysHM
	H6kiu4xPkor09928BO/hP2IUq1cMhBunhA7rCi31OWIkTE7F2fD0dKdwc/IlcKGQl1agPSBu6NoSY
	/il9hFcBkzUoLYKn1Zh9C+SYc31tOCet80ExbuDM1WHBb377I2Qt6YYtTZhB2K3itZ/rKE6+JtNyn
	2zp9FAc+87zpiPqBYwaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obo2Y-005UjZ-Bo; Fri, 23 Sep 2022 19:08:46 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obo2V-005UiE-BD
	for linux-nvme@lists.infradead.org; Fri, 23 Sep 2022 19:08:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=ZQmZb+lXFhX7pnMcsk23AOR4qV5DlMOOudYTRaQuI38=; b=iyj5atjf9mY5DRHI6pWs1X4Bi6
	i7VWXXFHJq6mQF3UhKDCt1azxiYmU/3In5EAKRjGznKha0IhkHuKd/7hnByYfIMa0A10xryy3cNSI
	9/HmYFmTyE4XR1neliZtOrRXXnkaJ9R21hyg32c9fhQFArWvSxFVueJNleIU1j2erseIiSoUWDXbG
	tOhWjlXnaPU8ESbjgzqPj71YG3maPzlUvgOVWPqFkAVKrS7NJZv9TfQKrhcACp5dMGStbB6KGjxO+
	eKaMDd7tJjeaipjxYkgs+FEV1joq4uNiT2sAhEOHHWDyXHWLYIghjVmN8Fujqsk6/dLFSMh9Fta85
	HjoSW77g==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <logang@deltatee.com>)
	id 1obo2O-008xXP-NI; Fri, 23 Sep 2022 13:08:37 -0600
Message-ID: <64f8da81-7803-4db4-73da-a158295cbc9c@deltatee.com>
Date: Fri, 23 Sep 2022 13:08:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-CA
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 Christoph Hellwig <hch@lst.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Daniel Vetter
 <daniel.vetter@ffwll.ch>, Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Ira Weiny <ira.weiny@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Ralph Campbell <rcampbell@nvidia.com>, Stephen Bates <sbates@raithlin.com>
References: <20220922163926.7077-1-logang@deltatee.com>
 <20220922163926.7077-2-logang@deltatee.com> <Yy33LUqvDLSOqoKa@ziepe.ca>
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <Yy33LUqvDLSOqoKa@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: jgg@ziepe.ca, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, hch@lst.de, gregkh@linuxfoundation.org, dan.j.williams@intel.com, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, dave.b.minturn@intel.com, jason@jlekstrand.net, dave.hansen@linux.intel.com, jianxin.xiong@intel.com, helgaas@kernel.org, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, rcampbell@nvidia.com, sbates@raithlin.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v10 1/8] mm: introduce FOLL_PCI_P2PDMA to gate getting PCI
 P2PDMA pages
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220923_120843_475025_A72D2470 
X-CRM114-Status: GOOD (  20.79  )
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



On 2022-09-23 12:13, Jason Gunthorpe wrote:
> On Thu, Sep 22, 2022 at 10:39:19AM -0600, Logan Gunthorpe wrote:
>> GUP Callers that expect PCI P2PDMA pages can now set FOLL_PCI_P2PDMA to
>> allow obtaining P2PDMA pages. If GUP is called without the flag and a
>> P2PDMA page is found, it will return an error.
>>
>> FOLL_PCI_P2PDMA cannot be set if FOLL_LONGTERM is set.
> 
> What is causing this? It is really troublesome, I would like to fix
> it. eg I would like to have P2PDMA pages in VFIO iommu page tables and
> in RDMA MR's - both require longterm.

You had said it was required if we were relying on unmap_mapping_range()...

https://lore.kernel.org/all/20210928200506.GX3544071@ziepe.ca/T/#u

> Is it just because ZONE_DEVICE was created for DAX and carried that
> revocable assumption over? Does anything in your series require
> revocable?

We still rely on unmap_mapping_range() indirectly in the unbind path.
So I expect if something takes a LONGERM mapping that would block until
whatever process holds the pin releases it. That's less than ideal and
I'm not sure what can be done about it.

>> @@ -2383,6 +2392,10 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>>  		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
>>  		page = pte_page(pte);
>>  
>> +		if (unlikely(!(flags & FOLL_PCI_P2PDMA) &&
>> +			     is_pci_p2pdma_page(page)))
>> +			goto pte_unmap;
>> +
>>  		folio = try_grab_folio(page, 1, flags);
>>  		if (!folio)
>>  			goto pte_unmap;
> 
> On closer look this is not in the right place, we cannot touch the
> content of *page without holding a ref, and that doesn't happen until
> until try_grab_folio() completes.
> 
> It would be simpler to put this check in try_grab_folio/try_grab_page
> after the ref has been obtained. That will naturally cover all the
> places that need it.

Ok, I can make that change.

Logan



