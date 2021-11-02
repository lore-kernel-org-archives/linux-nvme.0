Return-Path: <SRS0=i2V4=PV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EE4C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Nov 2021 12:10:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CD0860F5A
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Nov 2021 12:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2CD0860F5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=66eoSQCrjFh+iS1R6NIuWzOZxxhPkWmM7aMDJ6Wbhmg=; b=CmNSk2tYInJa8WDR9SbtSQDIXi
	jO6vLPygqopnrrQ68y4yJl/DxJNP2z2F6LH1MAKfmLwU9PwkA/aTgWyxREmy3/2i+wNjtlYlLSo0A
	xrShzccnUZ9rRy5jbgB3bjHrifdeOOPo3+/zPtNz4obHmrK82pqXYY3b+rXAaFeDefRiSbpqOgeuv
	SCeHBZGPezEmy0xXD2CydrQhhkoaXCMWpCLVEK7wfU1uvMH/9WOLaL1oD7NP2EW3RYxqxEiUB5c9f
	YWpXFAUgr1Ylx27EHcCmv9nII/uZWfTcp1oq7XiBF7GaU8zTJf28BZpL79peHmhUbcPvvEdJ4N09Y
	0Rf8SGvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mhsc6-001auk-Hl; Tue, 02 Nov 2021 12:10:02 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mhsc1-001arR-Eu
 for linux-nvme@lists.infradead.org; Tue, 02 Nov 2021 12:09:59 +0000
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Hk7vK1sHZzZchQ;
 Tue,  2 Nov 2021 20:07:41 +0800 (CST)
Received: from kwepemm600011.china.huawei.com (7.193.23.229) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 2 Nov 2021 20:09:44 +0800
Received: from [10.169.46.19] (10.169.46.19) by kwepemm600011.china.huawei.com
 (7.193.23.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 2 Nov
 2021 20:09:44 +0800
Subject: Re: consultation about NVME_SGL_FMT_INVALIDATE not set when using
 nvme-rdma t10-pi
To: Max Gurtovoy <mgurtovoy@nvidia.com>
CC: <linux-nvme@lists.infradead.org>
References: <ff7c0b84-e0e4-e22d-1ab8-1b31a0aeaf3b@huawei.com>
 <41ba9a7a-f4f9-4ee7-3cae-21700f086dd5@nvidia.com>
From: liruozhu <liruozhu@huawei.com>
Message-ID: <7a692bda-423b-84d7-dce4-e37f196c7e9f@huawei.com>
Date: Tue, 2 Nov 2021 20:09:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <41ba9a7a-f4f9-4ee7-3cae-21700f086dd5@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.169.46.19]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600011.china.huawei.com (7.193.23.229)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211102_050958_207144_7295D973 
X-CRM114-Status: GOOD (  21.05  )
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

Hi Max,

On 2021/10/27 18:49, Max Gurtovoy wrote:
> Hi Ruozhu,
>
> The performance tests we did for all the IO sizes showed better 
> performance with local invalidation in most of the cases (mainly for 
> large IOs, the remote invalidation task is harder for the HW).
>
> Maybe there is 1 or 2 cases, such as small IO latency, that improves 
> with remote-invalidation but for now we decided to disable it.
>
> I guess we can add a capability for the device that will indicate it 
> in the future.
>
> What is the difference you see ? and what is the scenario ?

Sorry for the late reply, it is not  very convenient for me to use the 
test environment recently. I tested various IO models last week.

In the low-stress model, such as 8k single-threaded writing, using 
remote-invalidation can increase latency and IOPS by about 20%.

In high pressure scenarios, such as 8k 32 threads and 256k 2 threads, 
the performance of whether to use remote-invalidation is almost the same.

In various scenarios, I have not measured that remote invalidation is worse.

The network card I use is BlueField(TM) SmartNIC 25GbE dual-port SFP28, 
PN: MBF1M332A-ASNAT. And I use vdbench for testing.

I would like to know what IO model you have measured that the 
remote-invalidation is worse?

Thanks,

Ruozhu

>
> Thanks,
>
> -Max.
>
> On 10/27/2021 11:50 AM, liruozhu wrote:
>> Hi Max,
>>
>> I was testing T10-PI feature of nvme-rdma recently, and found that 
>> when using T10-PI, nvme-rdma driver did not set 
>> NVME_SGL_FMT_INVALIDATE flag in the sgl type field, so the host 
>> software needs to do invalid rkey by itself. I tried to add the flag 
>> to test it. Turns out T10-PI feature is still working, and I get 
>> better IO latency with it enable.
>> I read the original patches in the mailing list, and found that patch 
>> v1 set this flag. But it was silent dropped on patch v5 without any 
>> comments. Is it for any special considerations to delete it?
>>
>> Thanks,
>> Ruozhu
>>
> .

