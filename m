Return-Path: <SRS0=3Qb0=PQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2446C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Oct 2021 09:43:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FF3360F9B
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Oct 2021 09:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6FF3360F9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8aVMGq1Z1qFkK5ckC/dSNDX6KpGG8q9uY1xLC5i9xxA=; b=oyGnNR2dfsLz2AviJkKQoPMn6u
	kWXZfv6GW9GRKc/GHCOLruRyFxYZOWoE9zrTmwfMghER2PVDvHuzfvLyZ/x3R6BKEnHGsiNamZU5T
	QmLTxCUscdoceai9SmQYeXSkzZtoZWoPzw66yo4dzW14FwlEgWZwLyMWSysPsCQ4sRxiRnrU51DG+
	3mp7yvz1X4EY5Dz94ez3+tn7Obss+0Vfut2MstGPex/vf0SHqd1xUn9tLd6AAkD5+QR+Zr9iFCErf
	yhm1P06WGN2J/xPGTiopZfLnh/4mtur31wqKVp7EXDwJU3C/POiMf8F87FPuB/gFnKVorSX+p58xl
	u20JqJfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mg1wj-007Qfk-OE; Thu, 28 Oct 2021 09:43:41 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mg1wf-007Qec-1k
 for linux-nvme@lists.infradead.org; Thu, 28 Oct 2021 09:43:39 +0000
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Hg0tt6jGFz1DHws;
 Thu, 28 Oct 2021 17:41:26 +0800 (CST)
Received: from kwepemm600011.china.huawei.com (7.193.23.229) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 28 Oct 2021 17:43:23 +0800
Received: from [10.169.46.19] (10.169.46.19) by kwepemm600011.china.huawei.com
 (7.193.23.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 17:43:23 +0800
Subject: Re: consultation about NVME_SGL_FMT_INVALIDATE not set when using
 nvme-rdma t10-pi
To: Max Gurtovoy <mgurtovoy@nvidia.com>
CC: <linux-nvme@lists.infradead.org>
References: <ff7c0b84-e0e4-e22d-1ab8-1b31a0aeaf3b@huawei.com>
 <41ba9a7a-f4f9-4ee7-3cae-21700f086dd5@nvidia.com>
From: liruozhu <liruozhu@huawei.com>
Message-ID: <7c1771c3-431d-f3fc-d400-492a53f46772@huawei.com>
Date: Thu, 28 Oct 2021 17:43:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <41ba9a7a-f4f9-4ee7-3cae-21700f086dd5@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.169.46.19]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600011.china.huawei.com (7.193.23.229)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211028_024338_017417_1D9EB2A5 
X-CRM114-Status: GOOD (  18.39  )
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

I test it with single thread 4K write IO, maybe this is why I get better 
latency data.

I will test various IO models when I have the opportunity, and then give 
you feedback.

In addition, I would like to know if the remote invalidation task is 
harder for the HW, Why do we need to enable it in the general(no t10-pi) 
scene?

Thanks,
Ruozhu

>
> I guess we can add a capability for the device that will indicate it 
> in the future.
>
> What is the difference you see ? and what is the scenario ?
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

