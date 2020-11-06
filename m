Return-Path: <SRS0=7aSL=EM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38C6C55178
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 20:03:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 547D72072E
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 20:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QaCXZagx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="dA51HxqS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 547D72072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XHY1oGqKccATMFX2ht4rYys3sxXB/G/3twwbRUhDevA=; b=QaCXZagxDXCHivxKHirCm8Gtt
	4gPQyARwDAZ/KEKH0FxZNchsFdH0x7+dH3FP+abzxce5Dd1Mrsd3KGFZAHeiEWJl67yWHIjdqasLm
	4qfBJZiWW+rYrTrWnrlmXUPT4vJuhp70dR7/HG8ljaxLMIK4IVSZB7vY2sMDoyssTO6iDajkOPrbl
	rX2g42GAb9HYxWNjodH1eKT8OR6AZIoh1JvZ7x3a727Hx1O8S67IoWFEaJ1Jbp8O/gsyYBiUELFPz
	IkX0Xe/yKXvWT/N8XOfqCt1SX0fdLSspglYnLIdPxDDgMGW+Q7XRYeLjUdeFiTWnD7ImFsJXnFnrk
	ACljVq4Sw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kb7xT-0004mo-BW; Fri, 06 Nov 2020 20:03:39 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb7xR-0004mI-3y
 for linux-nvme@lists.infradead.org; Fri, 06 Nov 2020 20:03:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eezeT8sE0c+dvLmjvESICoKhAlzXaqNnjl5jvhsWtf0=; b=dA51HxqSCHR4JuZbkzzSmg3W+t
 yWkoDic2Ka2INSPCZAs/OVNcm6A8oiWD4xs5cZOJI6JCJWoyIEcMFYQuwDXpEP94JRNOq4Jm597IW
 zY9+kL0WMddHMYyhT16mkNx04/hEioF70ZnVXsKAV6asL35LsLIGi/hQcp4flbFRG6VUJKaDSYlQm
 BxfqzK/sL5Uezm0Q9/fKyVYifXoPOzisxNKpvC7XUXwFcrIJEQsQ7vt00oqimgL0c3rksAR1njMyZ
 RHfHxAGvibWkE0XP5Ny8DbZ0h152CMHqRJ4Aq7wirLss+0t12x4iriBT6mcS0XfaFdtJXuwn2twYA
 onotgqBQ==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1kb7xI-0005Wu-TX; Fri, 06 Nov 2020 13:03:30 -0700
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20201106170036.18713-1-logang@deltatee.com>
 <20201106170036.18713-15-logang@deltatee.com>
 <20201106172206.GS36674@ziepe.ca>
 <b1e8dfce-d583-bed8-d04d-b7265a54c99f@deltatee.com>
 <20201106174223.GU36674@ziepe.ca>
 <2c2d2815-165e-2ef9-60d6-3ace7ff3aaa5@deltatee.com>
 <20201106180922.GV36674@ziepe.ca>
 <09885400-36f8-bc1d-27f0-a8adcf6104d4@deltatee.com>
 <20201106193024.GW36674@ziepe.ca>
 <03032637-0826-da76-aec2-121902b1c166@deltatee.com>
 <20201106195341.GA244516@ziepe.ca>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e6a99d54-b33a-0df1-ee33-4aa7a70124a6@deltatee.com>
Date: Fri, 6 Nov 2020 13:03:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201106195341.GA244516@ziepe.ca>
Content-Language: en-US
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: daniel.vetter@ffwll.ch, willy@infradead.org,
 ddutile@redhat.com, jhubbard@nvidia.com, iweiny@intel.com,
 christian.koenig@amd.com, dan.j.williams@intel.com, hch@lst.de,
 sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RFC PATCH 14/15] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201106_150337_197242_4294B097 
X-CRM114-Status: GOOD (  26.24  )
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 linux-pci@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Ira Weiny <iweiny@intel.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-block@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, John Hubbard <jhubbard@nvidia.com>,
 Dan Williams <dan.j.williams@intel.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org




On 2020-11-06 12:53 p.m., Jason Gunthorpe wrote:
> On Fri, Nov 06, 2020 at 12:44:59PM -0700, Logan Gunthorpe wrote:
>>
>>
>> On 2020-11-06 12:30 p.m., Jason Gunthorpe wrote:
>>>> I certainly can't make decisions for code that isn't currently
>>>> upstream.
>>>
>>> The rdma drivers are all upstream, what are you thinking about?
>>
>> Really? I feel like you should know what I mean here...
>>
>> I mean upstream code that actually uses the APIs that I'd have to
>> introduce. I can't say here's an API feature that no code uses but the
>> already upstream rdma driver might use eventually. It's fairly easy to
>> send patches that make the necessary changes when someone adds a use of
>> those changes inside the rdma code.
> 
> Sure, but that doesn't mean you have to actively design things to be
> unusable beyond this narrow case. The RDMA drivers are all there, all
> upstream, if this work is accepted then the changes to insert P2P
> pages into their existing mmap flows is a reasonable usecase to
> consider at this point when building core code APIs.
> 
> You shouldn't add dead code, but at least have a design in mind for
> what it needs to look like and some allowance.

I don't see anything I've done that's at odds with that. You will still
need to make changes to the p2pdma code to implement your use case.

>>>> Ultimately, if you aren't using the genpool you will have to implement
>>>> your own mmap operation that somehow allocates the pages and your own
>>>> page_free hook. 
>>>
>>> Sure, the mlx5 driver already has a specialized alloctor for it's BAR
>>> pages.
>>
>> So it *might* make sense to carve out a common helper to setup a VMA for
>> P2PDMA to do the vm_flags check and set VM_MIXEDMAP... but besides that,
>> there's no code that would be common to the two cases.
> 
> I think the whole insertion of P2PDMA pages into a VMA should be
> similar to io_remap_pfn() so all the VM flags, pgprot_decrypted and
> other subtle details are all in one place. (also it needs a
> pgprot_decrypted before doing vmf_insert, I just learned that this
> month)

I don't think a function like that will work for the p2pmem use case. In
order to implement proper page freeing I expect I'll need a loop around
the allocator and vm_insert_mixed()... Something roughly like:

for (addr = vma->vm_start; addr < vma->vm_end; addr += PAGE_SIZE) {
        vaddr = pci_alloc_p2pmem(pdev, PAGE_SIZE);
	ret = vmf_insert_mixed(vma, addr,
  		       __pfn_to_pfn_t(virt_to_pfn(vaddr), PFN_DEV | PFN_MAP));
}

That way we can call pci_free_p2pmem() when a page's ref count goes to
zero. I suspect your use case will need to do something similar.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
