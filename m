Return-Path: <SRS0=15CP=IN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C77BC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 16:31:20 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 239F664F34
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 16:31:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 239F664F34
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LRK73sHAO7o8H1KjMWEoNXkVkIhwQ76kQcQWuH5bQFk=; b=rY4F+Y7kKmQ8yVmJ0wdc8+2uC
	6JJaJKU3sQh7oKFL4DcLT2HlGwhol3UfnaJR4kAcNG2IsNOM7W5/PzA697itAeO93ZLt6soThhtN/
	1JsrsaqbC2OcDP7eNupvlGX8SDRyBz2Ns5nAezNMxM2j1o8I/B7AnaX9r+3A4Crh6CAdvMGBBIwlj
	CCZXEfBFgdRCuc81O5WflO58CmlPgEGZtAMPQ+tgFjWk/hV4H2i4pbiD7BAk4fciw/AK49q+Wt6oh
	Y2ThCTzb3Fygb81xyFoOszsHBjkB+BLHpA8SGLgTdmSc9FJAzvkdlPZLpMZO3gTSMZPVAWHYI72Zf
	D5bPpMkBA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLq7Q-00GM6h-WF; Mon, 15 Mar 2021 16:31:01 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLq7N-00GM5r-1U
 for linux-nvme@lists.infradead.org; Mon, 15 Mar 2021 16:30:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=TLEEbGguoFgREmZB/3d8+m/o/rHO6SzO5QZnLNcOSh0=; b=LMeid5maXhumpDhtUuT0T2tgJt
 ol9/bEh8ONmQIjUErwM7mTPXZ1CariYnc5Iw/Ra321VFnAuXOc7cZyrF/Oh3deuXUDml8vg4X+V3F
 dm6yEWcub7AMbQD1WI1UonXf5DW+ICkxZ1h5xdC7Ffwv1G0x9MtX7QA2tm/M9hFJ88vXUo1Nzf5SB
 P9kkd0JYhI5ah/y1eBjMZckyn6x/RLEV5sBgyhTRxDlRjDfZtUo+Nai4KkED0ZA0WOzqD0D2RtvCY
 S73e1NapCyNIPKDTwXar4Oz8rXKqzNZzn5eBvlCnYkJL+tXFA0w2raNvLWazJGM9RhSj7JUIcCIZd
 r2qI+iiw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1lLq7B-0000Mv-Jy; Mon, 15 Mar 2021 10:30:46 -0600
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
 <20210313023220.GB3402637@iweiny-DESK2.sc.intel.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d34a2035-6077-8070-ea2c-b62a4a65422c@deltatee.com>
Date: Mon, 15 Mar 2021 10:30:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210313023220.GB3402637@iweiny-DESK2.sc.intel.com>
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
X-CRM114-CacheID: sfid-20210315_163057_179433_F54BB4C0 
X-CRM114-Status: GOOD (  19.50  )
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



On 2021-03-12 7:32 p.m., Ira Weiny wrote:
> On Thu, Mar 11, 2021 at 04:31:34PM -0700, Logan Gunthorpe wrote:
>> Introduce pci_p2pdma_should_map_bus() which is meant to be called by
>             ^^^^^^^^^^^^^^^^^^^^^^^^^
> 	    pci_p2pdma_dma_map_type() ???
> 
> FWIW I find this name confusing with pci_p2pdma_map_type() and looking at the
> implementation I'm not clear why pci_p2pdma_dma_map_type() needs to exist?

Yeah, there are subtle differences in prototype. But yes, they can
probably be combined. Will do for future postings.

>> + * pci_p2pdma_dma_map_type - determine if a DMA mapping should use the
>> + *	bus address, be mapped normally or fail
>> + * @dev: device doing the DMA request
>> + * @pgmap: dev_pagemap structure for the mapping
>> + *
>> + * Returns:
>> + *    1 - if the page should be mapped with a bus address,
>> + *    0 - if the page should be mapped normally through an IOMMU mapping or
>> + *        physical address; or
>> + *   -1 - if the device should not map the pages and an error should be
>> + *        returned
>> + */
>> +int pci_p2pdma_dma_map_type(struct device *dev, struct dev_pagemap *pgmap)
>> +{
>> +	struct pci_p2pdma_pagemap *p2p_pgmap = to_p2p_pgmap(pgmap);
>> +	struct pci_dev *client;
>> +
>> +	if (!dev_is_pci(dev))
>> +		return -1;
>> +
>> +	client = to_pci_dev(dev);
>> +
>> +	switch (pci_p2pdma_map_type(p2p_pgmap->provider, client)) {
>> +	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
>> +		return 0;
>> +	case PCI_P2PDMA_MAP_BUS_ADDR:
>> +		return 1;
>> +	default:
>> +		return -1;
>> +	}
>> +}
>> +EXPORT_SYMBOL_GPL(pci_p2pdma_dma_map_type);
> 
> I guess the main point here is to export this to the DMA layer?

Yes, that's correct.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
