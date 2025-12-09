Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B764D3B98A
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Dec 2025 17:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3UhLcVrYJ8kPOTR0OMVPXUitN3SJZ77t/XAYG7KKOIc=; b=gUP1mo65NrRvQdNelBjRB8uJQL
	y463rQExUdtg0muAnFZB3+Md93QiJ+VqZc6OQzAg+rUijaYId9I3mmFDMSRb1o7QLsiItpBcEzfoL
	+QwDKG21+6n1HIamuMQKfYzIia2KoxMD57B9qVK4GtE6mQXm5+ZxDNDubHAa/OKJt4MZlI3r9kpL6
	CXqu/EADDV4OFc7erG7LInY326ZbqnA29HPvYEuvkSwzcU9mgjm3IOSXtQq+J0U0QMIM3LjQzDiSZ
	M39d/t2jwbtgW5yaGJ5vB0nYySG7JGq+MXAVzIKh7R1R0plNLkiHdefBe9dx0nOu1NAJLAFnNGJSg
	76m8NUMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vT1bO-0000000EbH4-3x80;
	Tue, 09 Dec 2025 17:34:18 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vT1bM-0000000EbGZ-2pwW
	for linux-nvme@lists.infradead.org;
	Tue, 09 Dec 2025 17:34:17 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42FDE175D;
	Tue,  9 Dec 2025 09:34:08 -0800 (PST)
Received: from [10.57.46.210] (unknown [10.57.46.210])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9AF1E3F762;
	Tue,  9 Dec 2025 09:34:13 -0800 (PST)
Message-ID: <3451a93a-e4d5-4017-b4e3-e58fae3751f8@arm.com>
Date: Tue, 9 Dec 2025 17:34:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: WARNING: drivers/iommu/io-pgtable-arm.c:639
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Will Deacon <will@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Sebastian Ott <sebott@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <170120f7-dd2c-4d2a-d6fc-ac4c82afefd7@redhat.com>
 <4386e0f7-9e45-41d2-8236-7133d6d00610@arm.com>
 <d1d76dcb-5241-4290-ae69-7d20e4461b9b@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <d1d76dcb-5241-4290-ae69-7d20e4461b9b@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251209_093416_763558_700B2E36 
X-CRM114-Status: GOOD (  18.63  )
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

On 2025-12-09 5:29 pm, Chaitanya Kulkarni wrote:
> On 12/9/25 03:50, Robin Murphy wrote:
>> On 2025-12-09 11:43 am, Sebastian Ott wrote:
>>> Hi,
>>>
>>> got the following warning after a kernel update on Thurstday, leading
>>> to a
>>> panic and fs corruption. I didn't capture the first warning but I'm
>>> pretty
>>> sure it was the same. It's reproducible but I didn't bisect since it
>>> borked my fs. The only hint I can give is that v6.18 worked. Is this a
>>> known issue? Anything I should try?
>>
>> nvme_unmap_data() is attempting to unmap an IOVA that was never
>> mapped, or has already been unmapped by someone else. That's a usage bug.
>>
>> Thanks,
>> Robin.
> 
> Ankit A. also reported this.
> 
> Apart from unmapping, by any chance do we need this ?
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index e6626004b323..05d63fe92e43 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -637,7 +637,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>    	pte = READ_ONCE(*ptep);
>    	if (!pte) {
>    		WARN_ON(!(data->iop.cfg.quirks & IO_PGTABLE_QUIRK_NO_WARN));
> -		return -ENOENT;
> +		return 0;
>    	}
>    
>    	/* If the size matches this level, we're in the right place */

Oh, indeed - I also happened to notice that the other week and was 
intending to write up a fix, but apparently I completely forgot about it 
already :(

If you're happy to write that up and send a proper patch, please do - 
otherwise I'll try to get it done before I forget again...

Thanks,
Robin.

