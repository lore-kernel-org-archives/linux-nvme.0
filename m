Return-Path: <SRS0=HFDN=OT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30801C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 23:27:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4A9661504
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 23:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E4A9661504
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bLrCR8NjXZK49f2o/6jjGZEHShX/p094OiYzQjqfPuc=; b=tSbGC6SATDXuOI
	9ECSXNGxQlNzXyVwqf64XslPpkkZeC6bRE1f6Nu+9f2zpbRNUXgqtK//9zAQNxrXr3nXQRvkRaTz/
	k8yK3n6hMhKE0P7PFBNyeoo3gXh8fCuyEkIZf5bGtqcWryheIqaYm2PWAY8S8D4MlHNYg2Z135nz5
	ERzksVNakjZwWUzSJNdGbWaiYygKPsfqeq4q+C8XydhaPc3ee4tglWy+VhMQtAdzq8/KIIknQ1L3Q
	oa0F3cfaB9bgVVgedEeOc7oykwcPuahkD897XrkqzN7TP7uFhyfJ0DocBlbcJAW/0GoS/UqaYbkJh
	j0RkSM2gZn/87S9yluNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVizF-00CbNJ-Ie; Wed, 29 Sep 2021 23:27:41 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVizD-00CbMi-2f
 for linux-nvme@lists.infradead.org; Wed, 29 Sep 2021 23:27:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=3N3yWbCA1BRvhNZ5T1BUDhQCEJio0lSzQF1CfQAvAUQ=; b=FBroEG9pUbwP7nRlQb79EAX5Wp
 u2PPJZxMpxIX2WALiV7aZzAjZuxpuGJZ7QRPxSfo8vfyDkiULTkoBOi+vz/qqAHf6/pVcsnsMQn+K
 uuulJ3BevdgH6KKh+DWtfbdN8LgTFDgLk0Nyc7T0MEFUDnGIrUXX1QVessQCpt7MvtI3CUUlABp+L
 YSgDnr67ZeuuwVVORoBt5CCNbvryPi8r6APUwD7wJmrc4F628yRlWwVnD7seJmYTMKIHmFcRREhzI
 wCXESOP6NbuwJiCrOH2a3zB0QZBPZUhxswWS6emCPUo5tlj2jpELb9RvT5tWCninOBF3AaRKP/5OB
 irc2r4Sw==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1mViz1-0008DF-MF; Wed, 29 Sep 2021 17:27:28 -0600
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
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <32ce26d7-86e9-f8d5-f0cf-40497946efe9@deltatee.com>
Date: Wed, 29 Sep 2021 17:27:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210929230543.GB3544071@ziepe.ca>
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
X-CRM114-CacheID: sfid-20210929_162739_134863_79E75825 
X-CRM114-Status: GOOD (  27.25  )
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




On 2021-09-29 5:05 p.m., Jason Gunthorpe wrote:
> On Wed, Sep 29, 2021 at 03:42:00PM -0600, Logan Gunthorpe wrote:
> 
>> The main reason is probably this: if we don't use VM_MIXEDMAP, then we
>> can't set pte_devmap(). 
> 
> I think that is an API limitation in the fault routines..
> 
> finish_fault() should set the pte_devmap - eg by passing the
> PFN_DEV|PFN_MAP somehow through the vma->vm_page_prot to mk_pte() or
> otherwise signaling do_set_pte() that it should set those PTE bits
> when it creates the entry.
> 
> (or there should be a vmf_* helper for this special case, but using
> the vmf->page seems righter to me)

I'm not opposed to this. Though I'm not sure what's best here.

>> If we don't set pte_devmap(), then every single page that GUP
>> processes needs to check if it's a ZONE_DEVICE page and also if it's
>> a P2PDMA page (thus dereferencing pgmap) in order to satisfy the
>> requirements of FOLL_PCI_P2PDMA.
> 
> Definately not suggesting not to set pte_devmap(), only that
> VM_MIXEDMAP should not be set on VMAs that only contain struct
> pages. That is an abuse of what it is intended for.
> 
> At the very least there should be a big comment above the usage
> explaining that this is just working around a limitation in
> finish_fault() where it cannot set the PFN_DEV|PFN_MAP bits today.

Is it? Documentation on vmf_insert_mixed() and VM_MIXEDMAP is not good
and the intention is not clear. I got the impression that mm people
wanted those interfaces used for users of pte_devmap().

device-dax uses these interfaces and as far as I can see it also only
contains struct pages (or at least  dev_dax_huge_fault() calls
pfn_to_page() on every page when VM_FAULT_NOPAGE happens).

So it would be nice to get some direction here from mm developers on
what they'd prefer.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
