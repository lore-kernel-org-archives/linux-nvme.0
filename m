Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A067C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 07:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BpS60wEc4ZLku1K3DC2yeSWX8GPj9//tB/fjOARAZv0=; b=IwXskg892d39Jf0CAwwRmV0F7e
	ByyW7SzcvJDrsS/hYq9hLP+lgUekVWe0JPVEgBfn85OSfGYSOBjTEee4wsyTC+ApGjTzqxhjgQe6U
	oVjEU2OpFG/VUiw448JXQpfyCs3dO7jKR4bimaK32uxODcYSEL3dmP0SecMvRNkP852WvbrggYn54
	SLNXxRvPejdloJ1dqJ0eehpvM5B3S7qDjr6OhJg5ZMb3XrxculaloYjxtIyiN04aiUQLiC++uajeg
	mFYgJ8WsJOk8st29zvWs4Q+05RkXTSQi/cMFpLk90lC0Rwt6Caoe7ewQr8fOstisubvSncOY7OBuP
	HpxJwhYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osfiF-00BeMR-4m; Wed, 09 Nov 2022 07:41:31 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osfi4-00BeHT-Fz
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 07:41:23 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N6cMr1cSmz15MVP;
	Wed,  9 Nov 2022 15:40:56 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 15:41:08 +0800
Subject: Re: nvme-pci: NULL pointer dereference in nvme_dev_disable() on
 linux-next
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>, Gerd
 Bayer <gbayer@linux.ibm.com>
CC: Jens Axboe <axboe@fb.com>, Niklas Schnelle <schnelle@linux.ibm.com>,
	<linux-kernel@vger.kernel.org>, <linux-next@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>
References: <fad4d2d5e24eabe1a4fcab75c5d080a6229dc88b.camel@linux.ibm.com>
 <20221108074846.GA22674@lst.de>
 <65f5d26b-b0af-f9c6-e77c-e82ac969e9f9@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <d6845b29-dcce-4aaf-0093-b658bf6cdf32@huawei.com>
Date: Wed, 9 Nov 2022 15:41:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <65f5d26b-b0af-f9c6-e77c-e82ac969e9f9@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_234120_736423_238F63D1 
X-CRM114-Status: GOOD (  14.10  )
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

The check "if (!ctrl->tagset)" is just reduce the probability.

The real reason is the race of probe and remove.
It is similar with TCP and RDMA transport.
Israel has tried to fix it.
The detail:
https://github.com/torvalds/linux/commit/ce1518139e6976cf19c133b555083354fdb629b8
Unfortunately, this patch was reverted.

If it is in the process of "probe", remove should not be called.
Maybe we can move pci_set_drvdata to the end of nvme_probe.
Of course, the removal may not take effect if it is in the process of "probe".
This is why the patch of Israel is reverted.

Perhaps the better option would be that "remove" wait for the "probe" to complete,
and then do the real remove.
This requires additional mechanism to implement this.

On 2022/11/9 10:54, Sagi Grimberg wrote:
> 
>> Below is the minimal fix.  I'll see if I sort out the mess that is
>> probe/reset failure vs ->remove a bit better, though.
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index f94b05c585cbc..577bacdcfee08 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -5160,6 +5160,8 @@ EXPORT_SYMBOL_GPL(nvme_start_freeze);
>>   void nvme_stop_queues(struct nvme_ctrl *ctrl)
>>   {
>> +    if (!ctrl->tagset)
>> +        return;
>>       if (!test_and_set_bit(NVME_CTRL_STOPPED, &ctrl->flags))
>>           blk_mq_quiesce_tagset(ctrl->tagset);
>>       else
>> @@ -5169,6 +5171,8 @@ EXPORT_SYMBOL_GPL(nvme_stop_queues);
>>   void nvme_start_queues(struct nvme_ctrl *ctrl)
>>   {
>> +    if (!ctrl->tagset)
>> +        return;
>>       if (test_and_clear_bit(NVME_CTRL_STOPPED, &ctrl->flags))
>>           blk_mq_unquiesce_tagset(ctrl->tagset);
>>   }
> 
> Can we do that in the pci driver and not here?
> 
> .

