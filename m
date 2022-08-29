Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A489ECAAD4
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Aug 2022 08:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KMbnu/k5gVMZSr+xx3GBf9hDeYm2byjVeGXjexJDOeQ=; b=WOzzrk0BOVIrMXFW9veKJjOJ2v
	ZCrLEocQXVx4sKjwspx313ZtmdgWKDyFoLNu2aKSFfcpEjivO2unJa9CXVk0+SPPf5xdzSFv13kw1
	8kGEWzmD8DVhdQQEKM8Ivy/HBnJBeU/joZ7Dd/TEGlMbQF2mVqvWRhc7ATvctrTeuulty8bAp+p6/
	AOglESvec7sCMUgr11DVVSTQaiMQm/0h6AlTATvg6fWka6aL67nXYHq+xy9LIXzh1sRUMFU+uP9rU
	AFjf/nomBmSdpdbF4i0nloeOK1XErQS4RDLNa4MYDq5D/CVgxB8zxaOCLi1MDZTgqMVGosIYAUUlI
	UEUBOnjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSZmb-005ymR-Ee; Mon, 29 Aug 2022 08:06:09 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSZmU-005ygk-Bk
	for linux-nvme@lists.infradead.org; Mon, 29 Aug 2022 08:06:04 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MGNFk646hzkWl6;
	Mon, 29 Aug 2022 16:02:18 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 29 Aug 2022 16:05:55 +0800
Subject: Re: [PATCH] nvme-rdma: set ack timeout of RoCE to 262ms
To: Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <mgurtovoy@nvidia.com>,
	Christoph Hellwig <hch@lst.de>
CC: <linux-nvme@lists.infradead.org>, <kbusch@kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20220819075825.21231-1-lengchao@huawei.com>
 <20220821062016.GA26553@lst.de>
 <83992e8f-b18a-ccd3-e0ee-a5802043f161@huawei.com>
 <86e9fc3b-aded-220d-1ee0-4d5928097104@nvidia.com>
 <f7254cc2-88e0-e91f-e4f1-788c5889fcf1@huawei.com>
 <fbee7c67-fd7b-12c8-5685-066b1974aadb@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <550d4612-0041-3d84-b1cb-786d0c8e0d11@huawei.com>
Date: Mon, 29 Aug 2022 16:05:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <fbee7c67-fd7b-12c8-5685-066b1974aadb@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220829_010602_789471_E04911DC 
X-CRM114-Status: GOOD (  16.59  )
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



On 2022/8/28 22:57, Sagi Grimberg wrote:
> 
>>>> On 2022/8/21 14:20, Christoph Hellwig wrote:
>>>>> On Fri, Aug 19, 2022 at 03:58:25PM +0800, Chao Leng wrote:
>>>>>> Now the ack timeout of RoCE is 2 second(2^(18+1)*4us=2 second). In the
>>>>>> case of low concurrency, if some packets lost due to network abnormal
>>>>>> such as network rerouting, Optical fiber signal interference, etc,
>>>>>> it will wait 2 second to try retransmitting the lost packets.
>>>>>> As a result, the I/O latency is greater than 2 seconds.
>>>>>> The I/O latency is so long for real-time transaction service. Indeed we
>>>>>> do not have to wait so long time to make sure that packets are lost.
>>>>>> Setting the ack timeout to 262ms(2^(15+1)*4us=262ms) is sufficient.
>>>>>
>>>>> I'll leave people more familar with RoCE to judge the merits of this
>>>>> change, but I really want a comment explaining the choice in the
>>>>> source code.
>>>> Now the TCP retransmission timeout interval is 250ms, and this setting
>>>> has been maintained for many years.
>>>> The network quality of rdma is better than that of common Ethernet.
>>>> That is the reason to set 262ms as the default ack timeout.
>>>> Adding a module parameter may be a better option.
>>>
>>> Are you solving a real issue you encountered ?
>> There is a low probability that this occurs in real scenarios.
>> The issue occurs in fault simulation test.
>> In the core-leaf fabrics,simulate a fiber fault between the core switch
>> and the leaf switch.
>> In the case of low concurrency, There is a high probability that the
>> I/O latency is greater than 2 seconds.
>> This patch can reduce the I/O latency to less than 1 second.
>>>
>>> If so, which devices did you use ?
>> The host HBA is Mellanox Technologies MT27800 Family [ConnectX-5];
>> The switch and storage are huawei equipments.
>> In principle, switches and storage devices from other vendors
>> have the same problem.
>> If you think it is necessary, we can test the other vendor switchs
>> and linux target.
> 
> Why is the 2s default chosen, what is the downside for a 250ms seconds ack timeout? and why is nvme-rdma different than all other kernel rdma
The downside is redundant retransmit if the packets delay more than
250ms in the networks and finally reaches the receiver.
Only in extreme scenarios, the packet delay may exceed 250 ms.
> consumers that it needs to set this explicitly?
The real-time transaction services are sensitive to the delay.
nvme-rdma will be used in real-time transactions.
The real-time transaction services do not allow that the packets
delay more than 250ms in the networks.
So we need to set the ack timeout to 262ms.
> 
> Adding linux-rdma folks.
> .

