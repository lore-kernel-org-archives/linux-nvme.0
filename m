Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF56AC28D13
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Aug 2022 09:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AsZyoX5yeen6RG6iXHAXxTccdz5/f/EDGsQmh63E7kc=; b=tiGuorWSWmrsAf2daE9o/MZAnR
	K33CHYa0tnwQa/hC2q+HIcyPRXNLcRmSnd2WQfRmpWUdjPk/6EjPvSzmZdn2qIK7Oz6nGvAPu6vTb
	o4Nf+xwVli6GNAC3FhGI2pNtx/kieyuhs7oDAm2fe4rCcUpXTpCOm0ToZeZxXH7ZQ4XgwKXsi8WpZ
	5gHKjAkJ/gjvNwbMKKUCwGwayoQ7daU26WXJV71yZRpZiOLN3f4kbk4iKtCpJif1njfPG77zTd4gN
	gRcZKw5CVzrqccvnU0Ntz8mACeTzUS7rPxRyDBKvvqxXmL2aUk2DXG3ee1/3qVXCiv5ESESVlgCPL
	gRD6S2/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQ45T-007C9J-Kp; Mon, 22 Aug 2022 09:51:15 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQ45Q-007C41-9X
	for linux-nvme@lists.infradead.org; Mon, 22 Aug 2022 09:51:13 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MB6wQ4RBKz1N7Vd;
	Mon, 22 Aug 2022 17:47:34 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 22 Aug 2022 17:51:01 +0800
Subject: Re: [PATCH] nvme-rdma: set ack timeout of RoCE to 262ms
To: Christoph Hellwig <hch@lst.de>
CC: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <kbusch@kernel.org>
References: <20220819075825.21231-1-lengchao@huawei.com>
 <20220821062016.GA26553@lst.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <83992e8f-b18a-ccd3-e0ee-a5802043f161@huawei.com>
Date: Mon, 22 Aug 2022 17:50:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20220821062016.GA26553@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220822_025112_573941_607A9A30 
X-CRM114-Status: GOOD (  11.43  )
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



On 2022/8/21 14:20, Christoph Hellwig wrote:
> On Fri, Aug 19, 2022 at 03:58:25PM +0800, Chao Leng wrote:
>> Now the ack timeout of RoCE is 2 second(2^(18+1)*4us=2 second). In the
>> case of low concurrency, if some packets lost due to network abnormal
>> such as network rerouting, Optical fiber signal interference, etc,
>> it will wait 2 second to try retransmitting the lost packets.
>> As a result, the I/O latency is greater than 2 seconds.
>> The I/O latency is so long for real-time transaction service. Indeed we
>> do not have to wait so long time to make sure that packets are lost.
>> Setting the ack timeout to 262ms(2^(15+1)*4us=262ms) is sufficient.
> 
> I'll leave people more familar with RoCE to judge the merits of this
> change, but I really want a comment explaining the choice in the
> source code.
Now the TCP retransmission timeout interval is 250ms, and this setting
has been maintained for many years.
The network quality of rdma is better than that of common Ethernet.
That is the reason to set 262ms as the default ack timeout.
Adding a module parameter may be a better option.
> 
> .
> 

