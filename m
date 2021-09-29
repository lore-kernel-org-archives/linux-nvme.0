Return-Path: <SRS0=HFDN=OT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44062C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 23:50:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFA8061423
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 23:50:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EFA8061423
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=w2yAofjVharFuzZ3Q2GfYM2ZI0JmKNzELfdVkmk5JuM=; b=y36ECe+25G2JlS
	zm+LHM8qz+KukgYmUF8CxC8z7hmCLXWePQZ5ygYHq0P0tya18ffBru4pqVZMMVt4Nf6BSXGIqj4Wo
	xwQBBSKAZBMnE+a9ch+q7DOnxs0Yo6M1c2WosfUZOOKQIBvlDt9kX7K39RY/M5PHxPuUOsYZxvBbU
	a5u/Q3KLvwS2WH2mN86eU7xQU/lTnYuVOE00+WS18ZJXMsTnsuAi5L+X2kIoN8a2oXdGu06fpyJ63
	Zoz1tn5XtmjM0cwDmX/Wn97stRYa6gtjoo+ZqtNCc8fjUjjMhTw2VXZ0bygpUxWMQ2RDEBWFDcm0q
	nW4soNloiP1llnk+wQgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVjKn-00CdcQ-EH; Wed, 29 Sep 2021 23:49:57 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVjKk-00Cdbf-1E
 for linux-nvme@lists.infradead.org; Wed, 29 Sep 2021 23:49:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=CF1glsl0sDpUoLLLlbcLe5Gc4XdktP0X8AUw9yuV+0g=; b=rvxtjSxpHJKvRAjCfIxwxyzLCo
 dRJ/VOphU+DYr/cLIiwms1Pg/YVQDCtjAHmMCtg4knvS9jKPhUP3W9zeT0sdqnnr19BzDAVDwHcJL
 62apJcXTTKU8FDisFW4B9PimKftGde3SQ3trXz6cjnJ/Evi3tlcLZEqDfaxS6gD5YvgZuTfG7y4pX
 oR1EByfJZsQ+MR2/beWAzNsR3w97B0sy/qeoE6eY3ixGA2UuZc4eGCIy14pEdxW+aVGSSXG81FppK
 Xrz2ZHFGtdpweiT0vhas7k+vEPmBvbSrqdraw89wTlivVK/1sYC95Wf2aWqcT52GNBphDrX7tSAFc
 Jo1/zcsg==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1mVjKW-0008TE-PC; Wed, 29 Sep 2021 17:49:41 -0600
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Stephen Bates <sbates@raithlin.com>,
 Christoph Hellwig <hch@lst.de>, Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Daniel Vetter
 <daniel.vetter@ffwll.ch>, Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Ira Weiny <ira.weiny@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-20-logang@deltatee.com>
 <20210928195518.GV3544071@ziepe.ca>
 <8d386273-c721-c919-9749-fc0a7dc1ed8b@deltatee.com>
 <20210929230543.GB3544071@ziepe.ca>
 <32ce26d7-86e9-f8d5-f0cf-40497946efe9@deltatee.com>
 <20210929233540.GF3544071@ziepe.ca>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <f9a83402-3d66-7437-ca47-77bac4108424@deltatee.com>
Date: Wed, 29 Sep 2021 17:49:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210929233540.GF3544071@ziepe.ca>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: ckulkarnilinux@gmail.com, martin.oliveira@eideticom.com,
 robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org,
 jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net,
 dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch,
 willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com,
 christian.koenig@amd.com, dan.j.williams@intel.com, hch@lst.de,
 sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v3 19/20] PCI/P2PDMA: introduce pci_mmap_p2pmem()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210929_164954_115744_E34BE87B 
X-CRM114-Status: GOOD (  29.45  )
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



On 2021-09-29 5:35 p.m., Jason Gunthorpe wrote:
> On Wed, Sep 29, 2021 at 05:27:22PM -0600, Logan Gunthorpe wrote:
> 
>>> finish_fault() should set the pte_devmap - eg by passing the
>>> PFN_DEV|PFN_MAP somehow through the vma->vm_page_prot to mk_pte() or
>>> otherwise signaling do_set_pte() that it should set those PTE bits
>>> when it creates the entry.
>>>
>>> (or there should be a vmf_* helper for this special case, but using
>>> the vmf->page seems righter to me)
>>
>> I'm not opposed to this. Though I'm not sure what's best here.
>>
>>>> If we don't set pte_devmap(), then every single page that GUP
>>>> processes needs to check if it's a ZONE_DEVICE page and also if it's
>>>> a P2PDMA page (thus dereferencing pgmap) in order to satisfy the
>>>> requirements of FOLL_PCI_P2PDMA.
>>>
>>> Definately not suggesting not to set pte_devmap(), only that
>>> VM_MIXEDMAP should not be set on VMAs that only contain struct
>>> pages. That is an abuse of what it is intended for.
>>>
>>> At the very least there should be a big comment above the usage
>>> explaining that this is just working around a limitation in
>>> finish_fault() where it cannot set the PFN_DEV|PFN_MAP bits today.
>>
>> Is it? Documentation on vmf_insert_mixed() and VM_MIXEDMAP is not good
>> and the intention is not clear. I got the impression that mm people
>> wanted those interfaces used for users of pte_devmap().
> 
> I thought VM_MIXEDMAP was quite clear:
> 
> #define VM_MIXEDMAP	0x10000000	/* Can contain "struct page" and pure PFN pages */
> 
> This VMA does not include PFN pages, so it should not be tagged
> VM_MIXEDMAP.
> 
> Aside from enabling the special vmf_ API, it only controls some
> special behavior in vm_normal_page:
> 
>  * VM_MIXEDMAP mappings can likewise contain memory with or without "struct
>  * page" backing, however the difference is that _all_ pages with a struct
>  * page (that is, those where pfn_valid is true) are refcounted and considered
>  * normal pages by the VM. The disadvantage is that pages are refcounted
>  * (which can be slower and simply not an option for some PFNMAP users). The
>  * advantage is that we don't have to follow the strict linearity rule of
>  * PFNMAP mappings in order to support COWable mappings.
> 
> Which again does not describe this case.

Some of this seems out of date. Pretty sure the pages are not refcounted
with vmf_insert_mixed() and vmf_insert_mixed() is currently the only way
to use VM_MIXEDMAP mappings.

>> device-dax uses these interfaces and as far as I can see it also only
>> contains struct pages (or at least  dev_dax_huge_fault() calls
>> pfn_to_page() on every page when VM_FAULT_NOPAGE happens).
> 
> hacky hacky :)
> 
> I think DAX probably did it that way for the same reason you are
> doing it that way - no other choice without changing something

Sure but if you look at other vmf_insert_mixed() (of which there are
few) you see similar patterns. Seems more like it was documented with
one thing in mind but then used in a completely different manner. Which
is why I suggested the documentation was not so good.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
