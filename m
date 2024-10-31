Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5695E68946
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2024 02:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=szREClDLpVm5qTBNXO3iLcRETSfAMCntianuNnJ0n/g=; b=ojfJ8z2aGj49IWGn0mibakY2mO
	vghF+sylEW+57QBF5L97Wp0C2qY1VE/pfimX8iR1hpfe6ji0LGLE7QYMXXetlJJh3voPu1Cd4shvo
	JnsqGrwmuPudDj72glRfqTWdjLZFGe5m1lDNg3H5vypao81Nm74BBZQLYufcf5+QZdEJuD/+B2hrr
	QVYoF9CAK/R3MC0uDLC7HPQtT+AxEuIkSAm/dwkoGuKLi1/Dw/+pzPuM8zFpFIu0adx6+gCM4B9Y5
	vyAceZEdAuA8xteEwo0PMBs5OKV4KYApi5OUi1COc1FqcUPdDy8F6cfzGPyODXAopem3tKukJBtPY
	C+sTab+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6KVE-00000002Jfb-3Zjs;
	Thu, 31 Oct 2024 02:01:36 +0000
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6KVB-00000002Jev-0NDa
	for linux-nvme@lists.infradead.org;
	Thu, 31 Oct 2024 02:01:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730340090; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=szREClDLpVm5qTBNXO3iLcRETSfAMCntianuNnJ0n/g=;
	b=vjobOnh/x45SlYPCjCz3nGZ4WVPs2jbsKWAUeA1uq/g8UEqD8gYXvTK0Zh7vlFR0SVopguiroQpNAjo2nxs95JRsloVnZAt4ahQOZZpj0HwlQYVcbjawdJFbvGkGUlu4z1eH24Dk3x9T+3am1kze4eYG8FtdOVhdJbBf0RPMsYU=
Received: from 30.178.82.44(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WIGUwRJ_1730340087 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 31 Oct 2024 10:01:28 +0800
Message-ID: <ff0840eb-5b41-48df-9887-3539275761a1@linux.alibaba.com>
Date: Thu, 31 Oct 2024 10:01:25 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] nvmet: make nvmet_wq visible in sysfs
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
References: <20241029014915.16646-1-kanie@linux.alibaba.com>
 <8b4591d7-f0bd-4e4c-b1b3-1b375f25bda0@nvidia.com>
 <0e90730a-74c0-401a-82bd-92fdbcd2cbe0@linux.alibaba.com>
 <1c6e0bfe-f476-4c07-a67c-b526b325b405@nvidia.com>
 <a6718c68-6b0e-4a5e-af3a-c8ee98911ce3@linux.alibaba.com>
 <e666ea1d-2b6b-45dd-8903-2269e2143c95@nvidia.com>
 <d34e59db-66b1-42bc-93da-fa1ddcf658ed@linux.alibaba.com>
 <1996168e-be7b-4811-91dd-c7782e955b30@nvidia.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <1996168e-be7b-4811-91dd-c7782e955b30@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_190134_234979_0F5C048B 
X-CRM114-Status: GOOD (  14.30  )
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


在 2024/10/31 02:38, Chaitanya Kulkarni 写道:
> On 10/30/24 04:20, Guixin Liu wrote:
>> Sorry for the unclear explanation.
>>
>> The transport is tcp and the backend is block.
>>
>> This is just a solution level thing, in some complicated scenarios, we
>> deploy multiple
>>
>> missions on one machine(hybrid deployment), such as:
>>
>> 1. Dockers for function computation.
>>
>> 2. Real-time tasks.
>>
>> 3. Monitoring, and handling events and managemets.
>>
>> 4. And also nvme target server.
>>
>> All of them are retrict to their own cpu cores to prevent mutual
>> influence.
>>
>> There is no problem if nvmet_wq running on all cpus of course, but for
>> strict isolation,
>>
>> we need to do this retriction.
>>
>> I dont know if I've given enough detail.
>>
>> Best Regards,
>>
>> Guixin Liu
> can you please send a patch with detailed usecase ?
>
> Also, it will be nice (not a blocker to merge this patch) if you can
> provide
> steps similar to listed above so we can get this scenario tested, even
> better
> if you can submit a block test, but if not I'll send one once I get steps.
>
> -ck

I will send the v2 with our usecase to expain why we should restrict the 
cpumask,

I'm concerned whether blktests can handle such complex tests, as it 
relies on deploying

many Docker containers and services. Should it only test the case of 
setting the cpumask

with fio?

Best Regards,

Guixin Liu

>

