Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB59AC28D13
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Aug 2022 09:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YN7zDgYQzUYvE7rgHJd2929tn5FLN4XkSUU6t2aZzUE=; b=5FTDz4CJweCnQOCGYF8ngXlQ8y
	bgcyBCSXOCPiUCOZUo8cShh23ukvW5BudfneBJRNlY5uhMIspgVrgwU0mgcdcju/+RMtugMwJGaGr
	EmD/1Wj8uLsV3MFl53HtRyZIzn6R0aqb+BdUPAg52EUNaoKmqC/p2GOjmVWLz8qf2P+EtgKAiWB35
	YFEc658Dd6ehmqzP/6GyDUpzd+1V7Cs/TRDCUK6obR5S50TA0p3U+27BU3+U18jgJ4/8BdVZw0AL+
	fTdTilM2uhmqtNhR+gmqtdDVyIoTM0iEhtckD7LrHk+CDL/2mPFYsQ+HqCNd31DSGcsNGhmAmOe9V
	uJDgTvnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oR9dk-00Bcvp-LH; Thu, 25 Aug 2022 09:59:08 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oR9dh-00Bcgj-5z
	for linux-nvme@lists.infradead.org; Thu, 25 Aug 2022 09:59:07 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MCyyH0sqHzlW6Q;
	Thu, 25 Aug 2022 17:55:35 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 25 Aug 2022 17:58:50 +0800
Subject: Re: [PATCH] nvme-rdma: set ack timeout of RoCE to 262ms
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Christoph Hellwig <hch@lst.de>
CC: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <kbusch@kernel.org>
References: <20220819075825.21231-1-lengchao@huawei.com>
 <20220821062016.GA26553@lst.de>
 <83992e8f-b18a-ccd3-e0ee-a5802043f161@huawei.com>
 <86e9fc3b-aded-220d-1ee0-4d5928097104@nvidia.com>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <f7254cc2-88e0-e91f-e4f1-788c5889fcf1@huawei.com>
Date: Thu, 25 Aug 2022 17:58:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <86e9fc3b-aded-220d-1ee0-4d5928097104@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220825_025905_463994_0290A61F 
X-CRM114-Status: GOOD (  14.50  )
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



On 2022/8/22 23:30, Max Gurtovoy wrote:
> 
> On 8/22/2022 12:50 PM, Chao Leng wrote:
>>
>>
>> On 2022/8/21 14:20, Christoph Hellwig wrote:
>>> On Fri, Aug 19, 2022 at 03:58:25PM +0800, Chao Leng wrote:
>>>> Now the ack timeout of RoCE is 2 second(2^(18+1)*4us=2 second). In the
>>>> case of low concurrency, if some packets lost due to network abnormal
>>>> such as network rerouting, Optical fiber signal interference, etc,
>>>> it will wait 2 second to try retransmitting the lost packets.
>>>> As a result, the I/O latency is greater than 2 seconds.
>>>> The I/O latency is so long for real-time transaction service. Indeed we
>>>> do not have to wait so long time to make sure that packets are lost.
>>>> Setting the ack timeout to 262ms(2^(15+1)*4us=262ms) is sufficient.
>>>
>>> I'll leave people more familar with RoCE to judge the merits of this
>>> change, but I really want a comment explaining the choice in the
>>> source code.
>> Now the TCP retransmission timeout interval is 250ms, and this setting
>> has been maintained for many years.
>> The network quality of rdma is better than that of common Ethernet.
>> That is the reason to set 262ms as the default ack timeout.
>> Adding a module parameter may be a better option.
> 
> Are you solving a real issue you encountered ?
There is a low probability that this occurs in real scenarios.
The issue occurs in fault simulation test.
In the core-leaf fabrics,simulate a fiber fault between the core switch
and the leaf switch.
In the case of low concurrency, There is a high probability that the
I/O latency is greater than 2 seconds.
This patch can reduce the I/O latency to less than 1 second.
> 
> If so, which devices did you use ?
The host HBA is Mellanox Technologies MT27800 Family [ConnectX-5];
The switch and storage are huawei equipments.
In principle, switches and storage devices from other vendors
have the same problem.
If you think it is necessary, we can test the other vendor switchs
and linux target.
> 
>>>
>>> .
>>>
>>
> .

