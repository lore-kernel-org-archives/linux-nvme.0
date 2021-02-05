Return-Path: <SRS0=OXBW=HH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9167CC433E6
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Feb 2021 09:45:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09C5860241
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Feb 2021 09:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09C5860241
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lOglGnNkOO/pQ1Oo28DRh5dZfnXz6aUTLGwdojfuBhs=; b=kTTis+1B+awCs1lK15aBztvAe
	U1/pxRZKW1VloSZI8dWtvSQvxuvEMq2TvYVUWABoEZLuYkOQwj70+DjxzNOZs3oQ2EOPGZA36gCHg
	0lF5/HC2t4ZsXu2cfMaWcKMcclnJBzZawsj13mzey6WaDn7mzxVpRffA8ZPwIDDksJBltJIBYdeOJ
	7dh8X4odzaVVy62dBjjQqOLWhlFiRf2Wy+UWOHGLPBUqWEJsAx/empF6pxuW6Vr/+uE1hP2Ycks71
	iXGhf52er5Ue/7AEuIO0uYkWa7QRt5Rskd7jGAvQ59oxx2nFpSkdCBxNttwza7Kge/I8aOIgbChI0
	bR5L8m/FQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7xfy-0004Eg-QO; Fri, 05 Feb 2021 09:45:18 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7xfw-0004DD-3C
 for linux-nvme@lists.infradead.org; Fri, 05 Feb 2021 09:45:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9B85068AFE; Fri,  5 Feb 2021 10:45:12 +0100 (CET)
Date: Fri, 5 Feb 2021 10:45:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 3/8] swiotlb: factor out a nr_slots helper
Message-ID: <20210205094511.GA2801@lst.de>
References: <20210204193035.2606838-1-hch@lst.de>
 <20210204193035.2606838-4-hch@lst.de>
 <ae995e9d-4476-cea2-a4d7-9e9cbab5aafd@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ae995e9d-4476-cea2-a4d7-9e9cbab5aafd@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210205_044516_330498_B97838BB 
X-CRM114-Status: GOOD (  11.15  )
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
Cc: saravanak@google.com, konrad.wilk@oracle.com, marcorr@google.com,
 gregkh@linuxfoundation.org, linux-nvme@lists.infradead.org, kbusch@kernel.org,
 iommu@lists.linux-foundation.org, erdemaktas@google.com,
 m.szyprowski@samsung.com, Christoph Hellwig <hch@lst.de>, jxgao@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Feb 04, 2021 at 10:09:02PM +0000, Robin Murphy wrote:
>> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
>> index 838dbad10ab916..0c0b81799edbdb 100644
>> --- a/kernel/dma/swiotlb.c
>> +++ b/kernel/dma/swiotlb.c
>> @@ -194,6 +194,11 @@ static inline unsigned long io_tlb_offset(unsigned long val)
>>   	return val & (IO_TLB_SEGSIZE - 1);
>>   }
>>   +static unsigned long nr_slots(u64 val)
>> +{
>> +	return ALIGN(val, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
>
> Would DIV_ROUND_UP(val, 1 << IOTLB_SHIFT) be even clearer?

Not sure it is all that much cleaner, but it does fit a common pattern,
so I'll switch to that.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
