Return-Path: <SRS0=1Q2H=NB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F835C4338F
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Aug 2021 09:40:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC4286108C
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Aug 2021 09:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EC4286108C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kMrCsHc6qXT+P7JWmWOAHtrTTL7vNAHnPQVVjJw0vC0=; b=m+KaNTD3HQJ4D3wnQT8/W7TYs6
	TWLkBdGnJC/gXk5Fclm/68R6ZPEwo29XtK01Lrgu7WkfL+9yoJSG6+XGIZu+dDqGcOjvlLhiU0K0a
	ENoWBiMujjJw5J9KX7J1NJUTi6N4Zp2dhKj8gWitaaW+kR3DlDbPCwwHZsyszg18+db53scYfu43p
	KC8dAVVqfWpJDVbPvAVHAxX5U+Pd+meWBFI+nNbnlBH7YqE+9ZCR7+GBxmZLSZHgj/zWpt5oVHvbr
	LV80CzKjzvQdbl6nDrcwTGRItM6Z/a61lb+OlY9XKRVwxbP2IhXdpaZ8m/vo8YFUb3bDj75sYMQ6P
	UE4bK/3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mDOEq-003KrO-H0; Tue, 10 Aug 2021 09:40:00 +0000
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDOCO-003K1T-6p; Tue, 10 Aug 2021 09:37:30 +0000
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GkSX12Jrkz6C9JD;
 Tue, 10 Aug 2021 17:36:49 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 10 Aug 2021 11:37:22 +0200
Received: from [10.47.80.4] (10.47.80.4) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 10 Aug
 2021 10:37:21 +0100
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
To: Ming Lei <ming.lei@redhat.com>
CC: Robin Murphy <robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
 <linux-nvme@lists.infradead.org>, <iommu@lists.linux-foundation.org>, "Will
 Deacon" <will@kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <YPklDMng1hL3bQ+v@T590>
 <9c929985-4fcb-e65d-0265-34c820b770ea@huawei.com> <YPlGOOMSdm6Bcyy/@T590>
 <fc552129-e89d-74ad-9e57-30e3ffe4cf5d@huawei.com> <YPmUoBk9u+tU2rbS@T590>
 <0adbe03b-ce26-e4d3-3425-d967bc436ef5@arm.com> <YPqYDY9/VAhfHNfU@T590>
 <6ceab844-465f-3bf3-1809-5df1f1dbbc5c@huawei.com>
 <CAFj5m9J+9vO=CK3uPP+va5EoWffZj9ruSRe2fDDLXn+AE971CQ@mail.gmail.com>
 <ead87bf2-ddfa-eb67-db44-9619c6cdb714@huawei.com> <YQF1AKS6Y14dLU/A@T590>
From: John Garry <john.garry@huawei.com>
Message-ID: <dfdd16e8-278f-3bc9-da97-a91264aec909@huawei.com>
Date: Tue, 10 Aug 2021 10:36:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YQF1AKS6Y14dLU/A@T590>
Content-Language: en-US
X-Originating-IP: [10.47.80.4]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210810_023728_497284_8FBA3828 
X-CRM114-Status: GOOD (  15.57  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 28/07/2021 16:17, Ming Lei wrote:
>>>> Have you tried turning off the IOMMU to ensure that this is really just
>>>> an IOMMU problem?
>>>>
>>>> You can try setting CONFIG_ARM_SMMU_V3=n in the defconfig or passing
>>>> cmdline param iommu.passthrough=1 to bypass the the SMMU (equivalent to
>>>> disabling for kernel drivers).
>>> Bypassing SMMU via iommu.passthrough=1 basically doesn't make a difference
>>> on this issue.
>> A ~90% throughput drop still seems to me to be too high to be a software
>> issue. More so since I don't see similar on my system. And that throughput
>> drop does not lead to a total CPU usage drop, from the fio log.
>>
>> Do you know if anyone has run memory benchmark tests on this board to find
>> out NUMA effect? I think lmbench or stream could be used for this.
> https://lore.kernel.org/lkml/YOhbc5C47IzC893B@T590/

Hi Ming,

Out of curiosity, did you investigate this topic any further?

And you also asked about my results earlier:

On 22/07/2021 16:54, Ming Lei wrote:
 >> [   52.035895] nvme 0000:81:00.0: Adding to iommu group 5
 >> [   52.047732] nvme nvme0: pci function 0000:81:00.0
 >> [   52.067216] nvme nvme0: 22/0/2 default/read/poll queues
 >> [   52.087318]  nvme0n1: p1
 >>
 >> So I get these results:
 >> cpu0 335K
 >> cpu32 346K
 >> cpu64 300K
 >> cpu96 300K
 >>
 >> So still not massive changes.
 > In your last email, the results are the following with irq mode io_uring:
 >
 >   cpu0  497K
 >   cpu4  307K
 >   cpu32 566K
 >   cpu64 488K
 >   cpu96 508K
 >
 > So looks you get much worse result with real io_polling?
 >

Would the expectation be that at least I get the same performance with 
io_polling here? Anything else to try which you can suggest to 
investigate this lower performance?

Thanks,
John

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
