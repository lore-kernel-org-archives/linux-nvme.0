Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C78C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Oct 2022 08:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W4IYivkvLrpuaKldPXdmoHXEFkO0cLMDI//JD0AKKsA=; b=DcU/KA5WhJgbx2FKUTVHB0yB1i
	AW+qEryxy9aMk4BDK/7kA3psyEVSDxvcllQVKQkHmtyYUF2zliAtXGJfscjKDqPaOrkXxSlLIrSC/
	LavkRQYRUc9LtF/d7Y0/5T/z4WtAUA1t0ZWwFv8xWTvuGJzd65gDZgN1L+zSSyTmaH8xVeeS8VLJR
	xT7EL2iuHq+LoNloSPtdNapSaUPHawWbFLRCmZ2bSfd01rStDW8JOV4bBZNaw6SecC4z4EJlo95vW
	4kFahbNM8Ce6u4eAtaS7/qy+ZLuqQZ20dYGKRWIoE6kj8wDI4tkX8K9IxJ8uyMzZebHAmSk/HoDV1
	EwGvI2RQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiXKf-007OGu-86; Wed, 12 Oct 2022 08:43:17 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiXKa-007OCt-Mt
	for linux-nvme@lists.infradead.org; Wed, 12 Oct 2022 08:43:15 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MnQzK2J7PzVhvQ;
	Wed, 12 Oct 2022 16:38:37 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 12 Oct 2022 16:43:03 +0800
Subject: Re: [PATCH 0/3] improve nvme quiesce time for large amount of
 namespaces
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>, Ming Lei
	<ming.lei@redhat.com>
CC: <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
	<kbusch@kernel.org>, <axboe@kernel.dk>
References: <20220729073948.32696-1-lengchao@huawei.com>
 <20220729142605.GA395@lst.de>
 <1b3d753a-6ff5-bdf1-8c91-4b4760ea1736@huawei.com>
 <fc7a303f-0921-f784-a559-f03511f2e4be@grimberg.me>
 <20220802133815.GA380@lst.de>
 <537c24ba-e984-811e-9e51-ecbc2af9895d@huawei.com>
 <5fc61f6c-3d3e-ce0e-a090-aa5bcdb7721c@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <f9fce880-4714-3cdb-dfd1-f1d77d033d7a@huawei.com>
Date: Wed, 12 Oct 2022 16:43:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <5fc61f6c-3d3e-ce0e-a090-aa5bcdb7721c@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221012_014313_129657_EFD04FA0 
X-CRM114-Status: GOOD (  19.45  )
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

Add Ming Lei.

On 2022/10/12 14:37, Sagi Grimberg wrote:
> 
>>> On Sun, Jul 31, 2022 at 01:23:36PM +0300, Sagi Grimberg wrote:
>>>> But maybe we can avoid that, and because we allocate
>>>> the connect_q ourselves, and fully know that it should
>>>> not be apart of the tagset quiesce, perhaps we can introduce
>>>> a new interface like:
>>>> -- 
>>>> static inline int nvme_ctrl_init_connect_q(struct nvme_ctrl *ctrl)
>>>> {
>>>>     ctrl->connect_q = blk_mq_init_queue_self_quiesce(ctrl->tagset);
>>>>     if (IS_ERR(ctrl->connect_q))
>>>>         return PTR_ERR(ctrl->connect_q);
>>>>     return 0;
>>>> }
>>>> -- 
>>>>
>>>> And then blk_mq_quiesce_tagset can simply look into a per request-queue
>>>> self_quiesce flag and skip as needed.
>>>
>>> I'd just make that a queue flag set after allocation to keep the
>>> interface simple, but otherwise this seems like the right thing
>>> to do.
>> Now the code used NVME_NS_STOPPED to avoid unpaired stop/start.
>> If we use blk_mq_quiesce_tagset, It will cause the above mechanism to fail.
>> I review the code, only pci can not ensure secure stop/start pairing.
>> So there is a choice, We only use blk_mq_quiesce_tagset on fabrics, not PCI.
>> Do you think that's acceptable?
>> If that's acceptable, I will try to send a patch set.
> 
> I don't think that this is acceptable. But I don't understand how
> NVME_NS_STOPPED would change anything in the behavior of tagset-wide
> quiesce?
If use blk_mq_quiesce_tagset, it will quiesce all queues of all ns,
but can not set NVME_NS_STOPPED of all ns. The mechanism of NVME_NS_STOPPED
will be invalidated.
NVMe-pci has very complicated quiesce/unquiesce use pattern, quiesce/unquiesce
may be called unpaired.
It will cause some backward. There may be some bugs in this scenario:
A thread: quiesce the queue
B thread: quiesce the queue
A thread end, and does not unquiesce the queue.
B thread: unquiesce the queue, and do something which need the queue must be unquiesed.

Of course, I don't think it is a good choice to guarantee paired access through NVME_NS_STOPPED,
there exist unexpected unquiesce and start queue too early.
But now that the code has done so, the backward should be unacceptable.
such as this scenario:
A thread: quiesce the queue
B thread: want to quiesce the queue but do nothing because NVME_NS_STOPPED is already set.
A thread: unquiesce the queue
Now the queue is unquiesced too early for B thread.
B thread: do something which need the queue must be quiesced.

Introduce NVME_NS_STOPPED link:
https://lore.kernel.org/all/20211014081710.1871747-5-ming.lei@redhat.com/
> 
> .

