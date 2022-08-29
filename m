Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B99ECAAD2
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Aug 2022 13:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DNGfEIma1a+f7zdzyqF/ApVufC8MdISGq9I2Zb+TzfY=; b=oTpKIg2LDDKmAGpuiu1mspG+Ho
	qFb2GkX0+pWO0n+/NDXh/1Ilm1HHD2sjCqVRAK1ehFMxZTvGWexw7rbwucIVkC750HfBcgVqS4H4V
	xQ/UIoys6EaFHCtI1FWybarTjxtfiuqfvtT1LEVrncJDIW5ku8uXOhpiFLkDYNHtw8E4JTMbdE07K
	d/y1CGqpXuIHkGv+wZLL68ttwR2qF4VX4IPOibS7+3OhCQ79aLyWCdPNXiGkbElH25+MG13qdiAKF
	oIMG1tBqtAgQ+M+e+ghUB3HUwMNwHwZQzmfKPwVhQfSMr18LfKon2HbBgcf2sqPjbVQUIzMtoqvt3
	w0lkhhWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSf7N-00ApJn-J1; Mon, 29 Aug 2022 13:47:57 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSecP-00AbZR-Dm
	for linux-nvme@lists.infradead.org; Mon, 29 Aug 2022 13:16:02 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MGW7d6xTkzlWWH;
	Mon, 29 Aug 2022 21:12:29 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 29 Aug 2022 21:15:51 +0800
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
 <550d4612-0041-3d84-b1cb-786d0c8e0d11@huawei.com>
 <3030fbb2-5c63-54ea-5be3-b88cf63c6b75@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <c86a6cea-09b5-c04c-aa7b-adc6a457acf6@huawei.com>
Date: Mon, 29 Aug 2022 21:15:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <3030fbb2-5c63-54ea-5be3-b88cf63c6b75@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220829_061557_801513_B8D0C338 
X-CRM114-Status: GOOD (  13.64  )
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



On 2022/8/29 17:06, Sagi Grimberg wrote:
> 
>>>>> If so, which devices did you use ?
>>>> The host HBA is Mellanox Technologies MT27800 Family [ConnectX-5];
>>>> The switch and storage are huawei equipments.
>>>> In principle, switches and storage devices from other vendors
>>>> have the same problem.
>>>> If you think it is necessary, we can test the other vendor switchs
>>>> and linux target.
>>>
>>> Why is the 2s default chosen, what is the downside for a 250ms seconds ack timeout? and why is nvme-rdma different than all other kernel rdma
>> The downside is redundant retransmit if the packets delay more than
>> 250ms in the networks and finally reaches the receiver.
>> Only in extreme scenarios, the packet delay may exceed 250 ms.
> 
> Sounds like the default needs to be changed if it only addresses the
> extreme scenarios...
> 
>>> consumers that it needs to set this explicitly?
>> The real-time transaction services are sensitive to the delay.
>> nvme-rdma will be used in real-time transactions.
>> The real-time transaction services do not allow that the packets
>> delay more than 250ms in the networks.
>> So we need to set the ack timeout to 262ms.
> 
> While I don't disagree with the change itself, I do disagree why this
> needs to be driven by nvme-rdma locally. If all kernel rdma consumers
> need this (and if not, I'd like to understand why), this needs to be set in the rdma core.Changing the default set in the rdma core is another option.
But it will affect all application based on RDMA.
Max, what do you think? Thank you.
> .

