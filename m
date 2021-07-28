Return-Path: <SRS0=tys/=MU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65000C4338F
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jul 2021 10:39:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E40660FC0
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jul 2021 10:39:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1E40660FC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	CC:To:Subject:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nusPNdIiLHQDmRMgwZsZMYQZ/N+7rRnxdL6xM7xexW8=; b=R8peWNrj1DuKdoa/QIiHilppbF
	BGrL+gyfdRFRHM5JVavXFPaLgirZNx9QPwlRgwx+VT9cyuQJiYoTt9i2DpUK9oHDDwFPJB78T/bkn
	/QOS42Db1lR+fOg+Ibea4p/bxcP8hA1SZWm7iqA7kenuK7m96VMYTx5tPH6h+GJ0rHZb2ZhQvXytT
	W+DiuKP/4j2C61QpQmTxaeHZXA48D84CTok5yfPsT0KwmymzYbnn99JhUoxnHzAfJoKWtTvCxMeiS
	vkLQI9lsWGMOjcn4s1FJeeSanwthz/Ju2IDOw7mfTLdh4qUFj+d087NdvZ6J7ZtQryWIwnmnMHxYO
	rFY2W1lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m8gxt-000QdB-HT; Wed, 28 Jul 2021 10:39:05 +0000
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m8gxb-000QYo-IT; Wed, 28 Jul 2021 10:38:49 +0000
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GZVFj46N2z6L9kY;
 Wed, 28 Jul 2021 18:26:49 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 28 Jul 2021 12:38:41 +0200
Received: from [10.47.27.80] (10.47.27.80) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Wed, 28 Jul
 2021 11:38:41 +0100
From: John Garry <john.garry@huawei.com>
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
To: Ming Lei <ming.lei@redhat.com>
CC: Robin Murphy <robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
 <linux-nvme@lists.infradead.org>, <iommu@lists.linux-foundation.org>, "Will
 Deacon" <will@kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <YPd7IGFZrsTRfUxE@T590>
 <74537f9c-af5f-cd84-60ab-49ca6220310e@huawei.com> <YPfwAN1onpSKoeBj@T590>
 <a2650064-41cf-cb62-7ab4-d14ef1856966@huawei.com> <YPklDMng1hL3bQ+v@T590>
 <9c929985-4fcb-e65d-0265-34c820b770ea@huawei.com> <YPlGOOMSdm6Bcyy/@T590>
 <fc552129-e89d-74ad-9e57-30e3ffe4cf5d@huawei.com> <YPmUoBk9u+tU2rbS@T590>
 <0adbe03b-ce26-e4d3-3425-d967bc436ef5@arm.com> <YPqYDY9/VAhfHNfU@T590>
 <6ceab844-465f-3bf3-1809-5df1f1dbbc5c@huawei.com>
 <CAFj5m9J+9vO=CK3uPP+va5EoWffZj9ruSRe2fDDLXn+AE971CQ@mail.gmail.com>
Message-ID: <ead87bf2-ddfa-eb67-db44-9619c6cdb714@huawei.com>
Date: Wed, 28 Jul 2021 11:38:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CAFj5m9J+9vO=CK3uPP+va5EoWffZj9ruSRe2fDDLXn+AE971CQ@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [10.47.27.80]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210728_033847_828104_B1B9C941 
X-CRM114-Status: GOOD (  16.89  )
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

On 28/07/2021 02:32, Ming Lei wrote:
> On Mon, Jul 26, 2021 at 3:51 PM John Garry<john.garry@huawei.com>  wrote:
>> On 23/07/2021 11:21, Ming Lei wrote:
>>>> Thanks, I was also going to suggest the latter, since it's what
>>>> arm_smmu_cmdq_issue_cmdlist() does with IRQs masked that should be most
>>>> indicative of where the slowness most likely stems from.
>>> The improvement from 'iommu.strict=0' is very small:
>>>
>> Have you tried turning off the IOMMU to ensure that this is really just
>> an IOMMU problem?
>>
>> You can try setting CONFIG_ARM_SMMU_V3=n in the defconfig or passing
>> cmdline param iommu.passthrough=1 to bypass the the SMMU (equivalent to
>> disabling for kernel drivers).
> Bypassing SMMU via iommu.passthrough=1 basically doesn't make a difference
> on this issue.

A ~90% throughput drop still seems to me to be too high to be a software 
issue. More so since I don't see similar on my system. And that 
throughput drop does not lead to a total CPU usage drop, from the fio log.

Do you know if anyone has run memory benchmark tests on this board to 
find out NUMA effect? I think lmbench or stream could be used for this.

Testing network performance in an equivalent fashion to storage could 
also be an idea.

Thanks,
John

> 
> And from fio log, submission latency is good, but completion latency
> is pretty bad,
> and maybe it is something that writing to PCI memory isn't committed to HW in
> time?


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
