Return-Path: <SRS0=15CP=IN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5A1C433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 16:28:01 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2CD764F23
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 16:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2CD764F23
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Zq9iV9lH3GS0h3kFDW+Lb2BbaxypWBf02HiVddh6bPg=; b=VJ1Xfn3rIqI+Mu8lcfo/0kjhB
	9Pd8RUo4uytI1rKgmrXJQnFXvMWI/azRT0aED2lu4k0cE2YpAg0dqv5OZn16n10TlvZ/hgfVcX5WO
	ij3RzlA+Fvu4A6SNcejR52fx43i1FZMdknCEOkqnKlHCcyjW4IC1pECoXLdpQ4dQr5p/ORxEHw/wa
	l+McymPTBIYwt+kvCwjQ/eiBlVItLVIcdG86WaqRIdvlIHL5GbRcUF+O0KYnTvaAeskH/6Sdy0lWr
	ix+fcTCv219P6TjDm4S4OP7+RepUfBA+SwETcgG+qjs/0Go5XSmi3T50h/tri5dC7ZAcnIVRNzMrL
	q9+f9g5aw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLq4C-00GLhm-IM; Mon, 15 Mar 2021 16:27:40 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLq42-00GLgj-7o
 for linux-nvme@lists.infradead.org; Mon, 15 Mar 2021 16:27:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=m8eFPt4Ky/TIsfccDRiBKAA6Im8fSHoSL1rWmfMykMo=; b=litugTKON8LXh2E4fNWf+tdFsh
 q2CsD9IDYGKKVIawn8gamhxRH644MuufqFWDCKKprPoZHtnAsUpBhIfbDLYsRIwcTEv0TojuuQngh
 9J3WiaV60JpGFYmjOv2GNCbeGl6swiX0xF3BgMcQ26cgzBguK1z1MH20QdPZRSQUkmZ+cHM0b8weO
 nMw1zNo5ZDzrtWTjylir56GRiIHipKmvmqBkHqMQTaNXL2ccxzXkV9uRTIH6IoeArfVAH59w8/LqW
 lQKk+yTetQfXb8ka5Hd5m4l/qqdvdrI67gA7aRHbkH+i+GOkWx0VzhB9jVE/dO+eFCXLyB281bkpf
 Y9mF4fFg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1lLq3k-0000KL-25; Mon, 15 Mar 2021 10:27:13 -0600
To: Ira Weiny <ira.weiny@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Stephen Bates <sbates@raithlin.com>,
 Christoph Hellwig <hch@lst.de>, Dan Williams <dan.j.williams@intel.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, =?UTF-8?Q?Christian_K=c3=b6nig?=
 <christian.koenig@amd.com>, Ira Weiny <iweiny@intel.com>,
 John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Daniel Vetter
 <daniel.vetter@ffwll.ch>, Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>
References: <20210311233142.7900-1-logang@deltatee.com>
 <20210311233142.7900-5-logang@deltatee.com>
 <20210313013856.GA3402637@iweiny-DESK2.sc.intel.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <7509243d-b605-953b-6941-72876a60d527@deltatee.com>
Date: Mon, 15 Mar 2021 10:27:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210313013856.GA3402637@iweiny-DESK2.sc.intel.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: jianxin.xiong@intel.com, dave.hansen@linux.intel.com,
 jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com,
 daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com,
 jhubbard@nvidia.com, iweiny@intel.com, christian.koenig@amd.com, jgg@ziepe.ca,
 dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com,
 iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 ira.weiny@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RFC PATCH v2 04/11] PCI/P2PDMA: Introduce
 pci_p2pdma_should_map_bus() and pci_p2pdma_bus_offset()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210315_162730_494934_A695A1B8 
X-CRM114-Status: GOOD (  21.46  )
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



On 2021-03-12 6:38 p.m., Ira Weiny wrote:
> On Thu, Mar 11, 2021 at 04:31:34PM -0700, Logan Gunthorpe wrote:
>> Introduce pci_p2pdma_should_map_bus() which is meant to be called by
>> DMA map functions to determine how to map a given p2pdma page.
>>
>> pci_p2pdma_bus_offset() is also added to allow callers to get the bus
>> offset if they need to map the bus address.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
>>  drivers/pci/p2pdma.c       | 50 ++++++++++++++++++++++++++++++++++++++
>>  include/linux/pci-p2pdma.h | 11 +++++++++
>>  2 files changed, 61 insertions(+)
>>
>> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
>> index 7f6836732bce..66d16b7eb668 100644
>> --- a/drivers/pci/p2pdma.c
>> +++ b/drivers/pci/p2pdma.c
>> @@ -912,6 +912,56 @@ void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>>  }
>>  EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg_attrs);
>>  
>> +/**
>> + * pci_p2pdma_bus_offset - returns the bus offset for a given page
>> + * @page: page to get the offset for
>> + *
>> + * Must be passed a PCI p2pdma page.
>> + */
>> +u64 pci_p2pdma_bus_offset(struct page *page)
>> +{
>> +	struct pci_p2pdma_pagemap *p2p_pgmap = to_p2p_pgmap(page->pgmap);
>> +
>> +	WARN_ON(!is_pci_p2pdma_page(page));
> 
> Shouldn't this check be before the to_p2p_pgmap() call?  

The to_p2p_pgmap() call is just doing pointer arithmetic, so strictly
speaking it doesn't need to be before. We just can't access p2p_pgmap
until it has been checked.

> And I've been told not
> to introduce WARN_ON's.  Should this be?
> 
> 	if (!is_pci_p2pdma_page(page))
> 		return -1;

In this case the WARN_ON is just to guard against misuse of the
function. It should never happen unless a developer changes the code in
a way that is incorrect. So I think that's the correct use of WARN_ON.
Though I might change it to WARN and return, that seems safer.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
