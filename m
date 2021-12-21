Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A984C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Dec 2021 17:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6RE2t3Nrh37PIF515dZ3u+BHHExtd6YU1HsGcK2dnu4=; b=DWZBQ+vnkfp+uA
	w57NGo4X4m9svGHb3g8NccKHriS0YYeS37L5u56HRSps0oWrM6eTUP+p4uJSq1MhingZ96mu2k6g+
	Gs1dv/KAdVWywHws5xeTc0eiQwI/gDWlq79HjDF+JplQT5lrK7gP54gSBMj7lpnjcDlBWgKDAFX2F
	dfEZzfd3nKvfH52g86ktq++bvVMCHxZ0tf/hVaMfroTXdaggZeHc69Obgb92iGo0h6U+lwKSULLwZ
	tJCRClwnpLQ87iEHGnFHKQCwHda3Ha99ofC8QPWyaEZlxreaw2Yvg6u811hukLHddBRNWN14fLscN
	II0xq5o92YwTC8lgeheQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mzirs-007p6W-Mr; Tue, 21 Dec 2021 17:24:04 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mzirp-007p5F-26
 for linux-nvme@lists.infradead.org; Tue, 21 Dec 2021 17:24:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=6RE2t3Nrh37PIF515dZ3u+BHHExtd6YU1HsGcK2dnu4=; b=eXXVACeUXdlIB1/KjWu9GhcS1t
 xrekSWq8RR2HCh+ekHLaiG+FIMaBYGfJYe5FGYP48P0GSRb0k+4RcTErCcOt9jBFo1Ig9Sjj3Kmoe
 tYncC6lDUuP1bBmukDNNGvuJU7dzQGVanoWl4myv8s/QCXLVm72hdiY9G793ucRM2CiViDyHuRKK1
 7i04q7Rmc1PbF/nOuxVTO3/I4ww8EecYfZPpNo9Hs1p8QOcgmTzxATUwvQhora8iHePLymjF6XC09
 IIUeWkGtVQTpxCWH7uDR7kLmDT2i93+1oUQMtFpv4hoHCiA3m8EbXPaWgvrA4OrO2Fuj1hJ76ySdm
 ndk5VOCg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <logang@deltatee.com>)
 id 1mzirJ-00AX1V-OI; Tue, 21 Dec 2021 10:23:31 -0700
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Stephen Bates <sbates@raithlin.com>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
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
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <20211117215410.3695-1-logang@deltatee.com>
 <20211117215410.3695-2-logang@deltatee.com> <20211221090003.GA7949@lst.de>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <05095125-464e-4e85-f609-c7bc93d2f479@deltatee.com>
Date: Tue, 21 Dec 2021 10:23:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211221090003.GA7949@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: jgg@nvidia.com, ckulkarnilinux@gmail.com,
 martin.oliveira@eideticom.com, robin.murphy@arm.com, ira.weiny@intel.com,
 helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com,
 jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com,
 daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com,
 jhubbard@nvidia.com, christian.koenig@amd.com, jgg@ziepe.ca,
 dan.j.williams@intel.com, sbates@raithlin.com,
 iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v4 01/23] lib/scatterlist: cleanup macros into static
 inline functions
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211221_092401_142622_05AB924E 
X-CRM114-Status: GOOD (  12.66  )
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



On 2021-12-21 2:00 a.m., Christoph Hellwig wrote:
> On Wed, Nov 17, 2021 at 02:53:48PM -0700, Logan Gunthorpe wrote:
>> Convert the sg_is_chain(), sg_is_last() and sg_chain_ptr() macros
>> into static inline functions. There's no reason for these to be macros
>> and static inline are generally preferred these days.
>>
>> Also introduce the SG_PAGE_LINK_MASK define so the P2PDMA work, which is
>> adding another bit to this mask, can do so more easily.
>>
>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> 
> Looks fine:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> scatterlist.h doesn't have a real maintainer, do you want me to pick
> this up through the DMA tree?

Sure, that would be great!

Thanks,

Logan

