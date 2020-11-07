Return-Path: <SRS0=JRV9=EN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A17C2D0A3
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Nov 2020 02:51:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAF5D20728
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Nov 2020 02:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JTZYz666";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="ExYwdc+D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF5D20728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6S1zmBVk082E/0grgXve9eCNv3lTgYP1e2znQ6ZxFOI=; b=JTZYz666jrMM1N67x92jMrhjC
	YyLk5JOo+bt61+NcPjsBIyQbxmSQCZWs+OiZ0L6VHpb13kXP3HEURFVN1vG2sb7lLIP6vZITHE8ct
	sVzXqhdP4ggMx4nXK3mqfh6vDUCqMy1kW/sG2oUxaQOu7qXhjohEnM5ZQPBarInB9fOt6oDsj5kuo
	WerS0DokLNrHOks8RrhfsGzBKyjnVwJVIqYafe3qxbr0AAIn4IDmGTItx8LnkIjhGZgn+cGocqQjY
	D+kgO1KPHgsrWV8DUkNPyeJC6evsg8N/UH73EAZOhEu4fzNK246JjD0rsFJDnlQm7zh1Sb8nQkgyv
	8MqnC9RnQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kbEJZ-0004qp-97; Sat, 07 Nov 2020 02:50:53 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kbEJU-0004qF-M0
 for linux-nvme@lists.infradead.org; Sat, 07 Nov 2020 02:50:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=60km6xH0HSvahM5c30+DJ4g8BodPX7+0LmwNaM0K8BI=; b=ExYwdc+DkS+fkDeydObiKNmENV
 tHOCg7o9tz01AsRah8P/Sr/9fh7XNjnnO8jUpwDGiiOtI4fzZuc6CUz0kowPjTXWC6ng/SIFsgqYN
 EJHOk3xQTOWZhterUYWYUuqnSOJrTgIRuwbsS0EX7HcK+HPf6oJYHWV5Bct4py7lGeNLo3+V3BDQD
 y5yp6ooOKpOsyzsFqaAIcs+xYoIbgqvVKxiXPkS/46cCAeQ19J2mBvZiqs9XbCzRkYaVcg210o8Hy
 kosgowf22Fkc7d716zpVdUVQa11HzeqnKB3bS3yoy0lNdGfuHQmF/UGjLKyQSo4URkuNgC0n1iHYd
 T4gVkX0w==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1kbEJI-00029J-SL; Fri, 06 Nov 2020 19:50:37 -0700
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20201106172206.GS36674@ziepe.ca>
 <b1e8dfce-d583-bed8-d04d-b7265a54c99f@deltatee.com>
 <20201106174223.GU36674@ziepe.ca>
 <2c2d2815-165e-2ef9-60d6-3ace7ff3aaa5@deltatee.com>
 <20201106180922.GV36674@ziepe.ca>
 <09885400-36f8-bc1d-27f0-a8adcf6104d4@deltatee.com>
 <20201106193024.GW36674@ziepe.ca>
 <03032637-0826-da76-aec2-121902b1c166@deltatee.com>
 <20201106195341.GA244516@ziepe.ca>
 <e6a99d54-b33a-0df1-ee33-4aa7a70124a6@deltatee.com>
 <20201107001457.GB244516@ziepe.ca>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <6f202b79-fa90-7cda-9ac9-457aa451530f@deltatee.com>
Date: Fri, 6 Nov 2020 19:50:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201107001457.GB244516@ziepe.ca>
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
X-CRM114-CacheID: sfid-20201106_215048_733043_9DCF6501 
X-CRM114-Status: GOOD (  16.60  )
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



On 2020-11-06 5:14 p.m., Jason Gunthorpe wrote:
> On Fri, Nov 06, 2020 at 01:03:26PM -0700, Logan Gunthorpe wrote:
>> I don't think a function like that will work for the p2pmem use case. In
>> order to implement proper page freeing I expect I'll need a loop around
>> the allocator and vm_insert_mixed()... Something roughly like:
>>
>> for (addr = vma->vm_start; addr < vma->vm_end; addr += PAGE_SIZE) {
>>         vaddr = pci_alloc_p2pmem(pdev, PAGE_SIZE);
>> 	ret = vmf_insert_mixed(vma, addr,
>>   		       __pfn_to_pfn_t(virt_to_pfn(vaddr), PFN_DEV | PFN_MAP));
>> }
>>
>> That way we can call pci_free_p2pmem() when a page's ref count goes to
>> zero. I suspect your use case will need to do something similar.
> 
> Yes, but I would say the pci_alloc_p2pmem() layer should be able to
> free pages on a page-by-page basis so you don't have to do stuff like
> the above.
> 
> There is often a lot of value in having physical contiguous addresses,
> so allocating page by page as well seems poor.

Agreed. But I'll have to dig to see if genalloc supports freeing blocks
in different sizes than the allocations.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
