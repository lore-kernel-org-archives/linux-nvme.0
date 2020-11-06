Return-Path: <SRS0=7aSL=EM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6257CC2D0A3
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 17:54:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8007217A0
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 17:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hTBX2G9U";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="oUbweNGx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8007217A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qXQIhr5NQk7V/1NtW37aldYp9E/fBn2OP0z/ut9fiWg=; b=hTBX2G9U/I5JwQHLdxa55BsZO
	7KWNuAay+PHVNk7TyM9Aoo4N+mQW4S/IhSovzhPdN+WYAGkR7C8dbnhOetIVlFcg5Tc1e5+3ejEcP
	FIhNvmsx5Pi7tuaJxzRqtvgRiURN35XU+OjOGXeGct+OSqCZTpqgdZMnvbyvUJKZbxH3zmTj6B3vg
	Oi2J/2gjrXnN9WtB6gKC5xgRb102ZUv3iaJqJ1S+Gu5wNL4zmCtiVHU2a+e7icvRI/m//nwsWnGBa
	7xNgnbhyrdZQSXBDiuH3Oy2fIwKCipuPG/X8p8+UwrcyPhRKResJd8fsZb69DnW1DZ/c502nzOw1x
	Kfsc1YDbw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kb5vw-0002hf-UF; Fri, 06 Nov 2020 17:53:57 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb5vu-0002gm-1q
 for linux-nvme@lists.infradead.org; Fri, 06 Nov 2020 17:53:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oqvtFGaVjszB5PFtWzeKmwJF6MYA6lw1F4gIUPtEKvE=; b=oUbweNGxfS2FaKore4Y7MKiNQ4
 fg7zh2TgR0y03Add5nUBDQD4stjB1NKFFrVlgpzQC5fznCUfIGpE/akffcd0NrmPkS/77o3bGqNOw
 Ei1cBrxMlXYTIEwe8u8J3/T0r8arqe8w4l390vQ3orocVyTIzf6z7CZrtej7nyQkhxp3EiA2y+pCs
 ec5qyhMR/l/1TdiqL43zWSiILj0SMtpz8z8LbEIROwb7rpQwVQgIR2tT0Q6FH1Y0AE1K2D+k180Ro
 sQw0YqkiFV6aAHs9Txi/B9Y7KeLuEZiAfw0VfHJZlQOxTnS2f2YIkOWlG9kr2vD0uu72FDyO+wSXj
 C94axUyQ==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1kb5vm-0003Mq-D0; Fri, 06 Nov 2020 10:53:47 -0700
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20201106170036.18713-1-logang@deltatee.com>
 <20201106170036.18713-15-logang@deltatee.com>
 <20201106172206.GS36674@ziepe.ca>
 <b1e8dfce-d583-bed8-d04d-b7265a54c99f@deltatee.com>
 <20201106174223.GU36674@ziepe.ca>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <2c2d2815-165e-2ef9-60d6-3ace7ff3aaa5@deltatee.com>
Date: Fri, 6 Nov 2020 10:53:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201106174223.GU36674@ziepe.ca>
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
X-CRM114-CacheID: sfid-20201106_125354_145867_DEBE7B29 
X-CRM114-Status: GOOD (  16.39  )
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



On 2020-11-06 10:42 a.m., Jason Gunthorpe wrote:
> On Fri, Nov 06, 2020 at 10:28:00AM -0700, Logan Gunthorpe wrote:
>>
>>
>> On 2020-11-06 10:22 a.m., Jason Gunthorpe wrote:
>>> On Fri, Nov 06, 2020 at 10:00:35AM -0700, Logan Gunthorpe wrote:
>>>> Introduce pci_mmap_p2pmem() which is a helper to allocate and mmap
>>>> a hunk of p2pmem into userspace.
>>>>
>>>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>>>>  drivers/pci/p2pdma.c       | 104 +++++++++++++++++++++++++++++++++++++
>>>>  include/linux/pci-p2pdma.h |   6 +++
>>>>  2 files changed, 110 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
>>>> index 9961e779f430..8eab53ac59ae 100644
>>>> +++ b/drivers/pci/p2pdma.c
>>>> @@ -16,6 +16,7 @@
>>>>  #include <linux/genalloc.h>
>>>>  #include <linux/memremap.h>
>>>>  #include <linux/percpu-refcount.h>
>>>> +#include <linux/pfn_t.h>
>>>>  #include <linux/random.h>
>>>>  #include <linux/seq_buf.h>
>>>>  #include <linux/xarray.h>
>>>> @@ -1055,3 +1056,106 @@ ssize_t pci_p2pdma_enable_show(char *page, struct pci_dev *p2p_dev,
>>>>  	return sprintf(page, "%s\n", pci_name(p2p_dev));
>>>>  }
>>>>  EXPORT_SYMBOL_GPL(pci_p2pdma_enable_show);
>>>> +
>>>> +struct pci_p2pdma_map {
>>>> +	struct kref ref;
>>>> +	struct pci_dev *pdev;
>>>> +	void *kaddr;
>>>> +	size_t len;
>>>> +};
>>>
>>> Why have this at all? Nothing uses it and no vm_operations ops are
>>> implemented?
>>
>> It's necessary to free the allocated p2pmem when the mapping is torn down.
> 
> That's suspicious.. Once in a VMA the lifetime of the page must be
> controlled by the page refcount, it can't be put back into the genpool
> just because the vma was destroed.

Ah, hmm, yes. I guess the pages have to be hooked and returned to the
genalloc through free_devmap_managed_page(). Seems like it might be
doable... but it will complicate things for users that don't want to use
the genpool (though no such users exist upstream).

Logan


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
