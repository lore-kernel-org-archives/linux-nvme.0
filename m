Return-Path: <SRS0=U7R3=J6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9473AC433B4
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 17:06:58 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E27C36023C
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 17:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E27C36023C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EDNHgN5JDp6qq5Tc9+aHJKw8nhleAaeAGZdHwbUe0+c=; b=cJYriymR3keWNGyRz0TJ5lpAh
	TZdlo72gBifjYGgNmaqMAUldGS+9YHXqnqHYc4j9slHEa8VpithI0ndfxJE9HY1H3dv/JtLiwdTsk
	k4Qr2UdQRT0nY8pz6KQ+WOcsOsIEder3A4Z0pHUxFwZTaErChVCrcw1MbETyS3UY+e1Iv2wLVKNOU
	aShyHbqtR5oANSVly78I48ltBK1wqcmGeThdJ9pox8liDm49f7ZMFEviceGkqvP68CvbxFnWngv/M
	TbqgbYZzg21wLtdYlfa9gvv/HQzBV4+49iLyBBKnf+sv6j9pDNbD5/x25iPlDXbX8xa9LkDCH0c4q
	BxwCEYo7g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldc22-00EThy-C4; Mon, 03 May 2021 17:06:54 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldc1x-00EThN-Rb
 for linux-nvme@desiato.infradead.org; Mon, 03 May 2021 17:06:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Subject:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=WB2BFEGNYO0DIiKQ7JhTxvJPDMwGp3muQhOssHP9UL0=; b=ktOKkrqtvABHYFcYoSRZ5na69x
 6hXkiwtgQGJg4GyXQ+E5LiAHF46SlxoqKawcQlPbldh/svPpQ/DzwlNoRHqe+pR9rsloYaY3+h5s0
 u7SqVmkAhvyrpRXtJcOvtLxt26QR7VLIBiZe9QPK3Mpm05fMIS5NuQTGztBYuvnw4G40aQ6k3GLVI
 fDq0ZRQ2uo9n835RlD93ruGaSrAM2hl86z8qgLdrQ0+ykBHELAEzL0pLzWY4L4xF5LPh7E/rmLHhz
 QkQvfYWPPPQeNzb6MLMBEUkcPB3tIS1tdMac2LLIoqiKIaEqIfStXybc8l20zBIZ/L+lLOwGMsfdj
 SAvQhe+w==;
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldc1v-003K30-73
 for linux-nvme@lists.infradead.org; Mon, 03 May 2021 17:06:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=WB2BFEGNYO0DIiKQ7JhTxvJPDMwGp3muQhOssHP9UL0=; b=dDTy/SRhXjKaPCQWTjtyGkzIXz
 L+5aXPYOXJFX/vzhqTUEvlHVk3nFr8UGmdqpKSDkYliw+ysfyGSOqaGrtbPwyRjFwob8n3y9wigi9
 Zl8BxPlH0yJ+PzbWpgvKPKQS98GCRTyXpn+eVtfXwsrPjQBPAPntrbhx6T5W+Kpxf5bZhnwUaPkAG
 ++hsd/+nGCa9jsMKPQjpg0vJf9dFGZPO2LJgKzlZ6TDWnRf4ACzVugXtJj31oEDdJPDVXsne85+3t
 NGcnOfrWi9lffb/ksw/nsFJghwSzqipzDuI1Q1PBz31x+/96qT0qbm4RHxKGSCMaEVx5Fu4d5LH/4
 SdHnJy+A==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1ldc1m-0004sS-74; Mon, 03 May 2021 11:06:39 -0600
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
 <20210408170123.8788-10-logang@deltatee.com>
 <37fa46c7-2c24-1808-16e9-e543f4601279@nvidia.com>
 <f2ac9584-6133-cd3d-e9a0-bff20adfb23e@nvidia.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <f4c4d197-a0b8-2238-d6ea-af4c67e43da3@deltatee.com>
Date: Mon, 3 May 2021 11:06:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <f2ac9584-6133-cd3d-e9a0-bff20adfb23e@nvidia.com>
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
Subject: Re: [PATCH 09/16] dma-direct: Support PCI P2PDMA pages in dma-direct
 map_sg
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210503_100647_265387_C8DF5F4A 
X-CRM114-Status: GOOD (  15.64  )
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



On 2021-05-02 5:32 p.m., John Hubbard wrote:
> On 5/2/21 4:28 PM, John Hubbard wrote:
>> On 4/8/21 10:01 AM, Logan Gunthorpe wrote:
> ...
>>> @@ -387,19 +388,37 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
>>
>> This routine now deserves a little bit of commenting, now that it is
>> doing less obvious things. How about something like this:
>>
>> /*
>> * Unmaps pages, except for PCI_P2PDMA pages, which were never mapped in the
>> * first place. Instead of unmapping PCI_P2PDMA entries, simply remove the
>> * SG_PCI_P2PDMA mark
>> */
> 
> I got that kind of wrong. They *were* mapped, but need to be left mostly
> alone...maybe you can word it better. Here's my second draft:
> 
> /*
>   * Unmaps pages, except for PCI_P2PDMA pages, which should not be unmapped at
>   * this point. Instead of unmapping PCI_P2PDMA entries, simply remove the
>   * SG_PCI_P2PDMA mark.
>   */
> 
> ...am I getting close? :)

I don't think your original comment was wrong per se. But I guess it
depends on your definition of "mapped". In dma-direct the physical
address is added to the SGL and, on some arches, the address has to be
synced on unmap. With P2PDMA, the PCI bus address is sometimes added to
the SGL and no sync is necessary at the end.

Logan


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
