Return-Path: <SRS0=U7R3=J6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F743C43460
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 17:09:59 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B978061132
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 17:09:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B978061132
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ga1mCPP5GxNR5N9NhtqSxNe4bR8iFxpw3Fhn9igOuXw=; b=cbvIy6uYtQSD9Lcn2p2WmDRGk
	Ucuq1xtMrxwhVENiCjI5jaM0Qt/nh8OYnIIAzEVGcf2mUuy4ykv3ZyaeONWEaRdp7zS+r0b0oDNv9
	lAZG6O6YGuuBLGsM3oRtJ4PHofvJJe0W8noxsfgMhVgnX+ZD+5UN42QBr2/qnmBlvu94yBQi/O7N/
	5Z6Phkpxxly36EbM7gAJvWHShhpS+96wpn0ZL3r629UwTnk/gaClbI03aiktIeIadX5RQX2Nd6qnN
	HrL+U5U+NK8BUs1laL+zPiuS+beEEqLaWkpxNngowwxS0V9Fm64r3NW7pklqBVvgK7ERxVleHR2EI
	PTcm6rlBQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldc4x-00ETwC-FO; Mon, 03 May 2021 17:09:55 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldc4r-00ETvn-NO
 for linux-nvme@desiato.infradead.org; Mon, 03 May 2021 17:09:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Subject:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=sF55GqEiR/vAGKsTB6GxRt38Im6+dLa7cFcSyRRCVPY=; b=kFzOBgxn/ZMQVcSCS+gYVcqT8C
 Tz9+rIrHF1K4PdqfQU0cVrBqqkU3N3RAPzRAG//12RlYw3I/EEq7JufhZ1/ON+f/tgn4z366KrQ7C
 iH5kl8jtbdp+bVYNhdr4AqU3PsbETLjrdG9q2gfNQ4yHThWFLAjahcur/Y4OPisJLppE/RyNrLi3a
 /dRsJ00qKC+94CrfUMcXPgd68EAvpKhbNOpYNzk8akDSCXQ2v6pp89mK7eLabp7MWC2pJBWcMgT4t
 XJUpdAr2jDUCfIOe340TJ+onOrKxo3L0AFm6wZGJ3DeL8L6gkO56lHwsQniulxB3GpGcI/cjoLLCh
 UjLv9ISw==;
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldc4p-003KQo-0d
 for linux-nvme@lists.infradead.org; Mon, 03 May 2021 17:09:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=sF55GqEiR/vAGKsTB6GxRt38Im6+dLa7cFcSyRRCVPY=; b=PPAJStAbdbFioncG1dF75qCU+v
 JphXQ3TasGekmkY28Y2MzFXdxG5QkT47dRXuoZAjv1XmtflJyc0xQSN1SJ0IH/IfpTxhtbEZvkpES
 XoLa55YoDqbSCc+7C3/zJowfmfhUSJPDLBddaVhPplT0a/o7g+Q0UWanpD5P9oDwYAoPlnURNJT/U
 pOznyVDGTomzGZXWTLIwqMDc/sde4eiJclT7mEfqE3z/9d0Wq6vJVrdw1xb+C67SQRgtI12z9UtIW
 x/eaYbEH8LFDHop0JKG/ustGY/6sHhLh307UM0U09MQ5UyR30dmPw58gEAMDgsZK/WY7OTyhZKJv+
 fKlTUBWg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1ldc4e-0004xo-VK; Mon, 03 May 2021 11:09:38 -0600
To: John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Don Dutile <ddutile@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Ira Weiny <ira.weiny@intel.com>, Robin Murphy <robin.murphy@arm.com>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-11-logang@deltatee.com>
 <85bd104b-2816-f803-44d4-d5623d4f81af@nvidia.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <f522351e-e8cf-58e9-620d-f17dcdfbf151@deltatee.com>
Date: Mon, 3 May 2021 11:09:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <85bd104b-2816-f803-44d4-d5623d4f81af@nvidia.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com,
 helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com,
 jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com,
 daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com,
 christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, hch@lst.de,
 sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jhubbard@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 10/16] dma-mapping: Add flags to dma_map_ops to indicate
 PCI P2PDMA support
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210503_100947_071696_3976F876 
X-CRM114-Status: GOOD (  26.84  )
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



On 2021-05-02 6:32 p.m., John Hubbard wrote:
> On 4/8/21 10:01 AM, Logan Gunthorpe wrote:
>> Add a flags member to the dma_map_ops structure with one flag to
>> indicate support for PCI P2PDMA.
>>
>> Also, add a helper to check if a device supports PCI P2PDMA.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
>>   include/linux/dma-map-ops.h |  3 +++
>>   include/linux/dma-mapping.h |  5 +++++
>>   kernel/dma/mapping.c        | 18 ++++++++++++++++++
>>   3 files changed, 26 insertions(+)
>>
>> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
>> index 51872e736e7b..481892822104 100644
>> --- a/include/linux/dma-map-ops.h
>> +++ b/include/linux/dma-map-ops.h
>> @@ -12,6 +12,9 @@
>>   struct cma;
>>   
>>   struct dma_map_ops {
>> +	unsigned int flags;
>> +#define DMA_F_PCI_P2PDMA_SUPPORTED     (1 << 0)
>> +
> 
> Can we move this up and out of the struct member area, so that it looks
> more like this:
> 
> /*
>   * Values for struct dma_map_ops.flags:
>   *
>   * DMA_F_PCI_P2PDMA_SUPPORTED: <documentation here...this is a good place to
>   * explain exactly what this flag is for.>
>   */
> #define DMA_F_PCI_P2PDMA_SUPPORTED     (1 << 0)
> 
> struct dma_map_ops {
> 	unsigned int flags;
> 

Sure, I don't care that much. I was just following the style in nvme.h.

>>   	void *(*alloc)(struct device *dev, size_t size,
>>   			dma_addr_t *dma_handle, gfp_t gfp,
>>   			unsigned long attrs);
>> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
>> index 50b8f586cf59..c31980ecca62 100644
>> --- a/include/linux/dma-mapping.h
>> +++ b/include/linux/dma-mapping.h
>> @@ -146,6 +146,7 @@ int dma_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
>>   		unsigned long attrs);
>>   bool dma_can_mmap(struct device *dev);
>>   int dma_supported(struct device *dev, u64 mask);
>> +bool dma_pci_p2pdma_supported(struct device *dev);
>>   int dma_set_mask(struct device *dev, u64 mask);
>>   int dma_set_coherent_mask(struct device *dev, u64 mask);
>>   u64 dma_get_required_mask(struct device *dev);
>> @@ -247,6 +248,10 @@ static inline int dma_supported(struct device *dev, u64 mask)
>>   {
>>   	return 0;
>>   }
>> +static inline bool dma_pci_p2pdma_supported(struct device *dev)
>> +{
>> +	return 0;
> 
> Should be:
> 	
> 	return false;

Yup, will fix.

>> +}
>>   static inline int dma_set_mask(struct device *dev, u64 mask)
>>   {
>>   	return -EIO;
>> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
>> index 923089c4267b..ce44a0fcc4e5 100644
>> --- a/kernel/dma/mapping.c
>> +++ b/kernel/dma/mapping.c
>> @@ -573,6 +573,24 @@ int dma_supported(struct device *dev, u64 mask)
>>   }
>>   EXPORT_SYMBOL(dma_supported);
>>   
>> +bool dma_pci_p2pdma_supported(struct device *dev)
>> +{
>> +	const struct dma_map_ops *ops = get_dma_ops(dev);
>> +
>> +	/* if ops is not set, dma direct will be used which supports P2PDMA */
>> +	if (!ops)
>> +		return true;
>> +
>> +	/*
>> +	 * Note: dma_ops_bypass is not checked here because P2PDMA should
>> +	 * not be used with dma mapping ops that do not have support even
>> +	 * if the specific device is bypassing them.
>> +	 */
>> +
>> +	return ops->flags & DMA_F_PCI_P2PDMA_SUPPORTED;
> 
> Wow, rather unusual combination of things in order decide this. It feels
> a bit over-complicated to have flags and ops and a bool function all
> dealing with the same 1-bit answer, but there is no caller shown here,
> so I'll have to come back to this after reviewing subsequent patches.

Yeah, I originally had it much simpler, but it confused Ira and it was
clear it had to be written more explicitly and commented better.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
