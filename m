Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D779ECAAA3
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Aug 2022 01:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8wsYiA3KGcMnesr4k5Wh4wg/GXDncppq+KkaqmHmLgk=; b=Ve82CT+x0fjgagBGH63lXi52TQ
	Zax5Spb6oCcyBw1vFt2PARgWXc3/EM7a4NUPId03kz3yncoWef13sdse1p5Jt6NS/LZm1J6f/oKop
	9l0ES9rQ7nKiIkvyxvndux4LFKPSwpfSnfLEz1jRaV0UTtSVKZO94/fL/UOJxZnaZxqt7VgXqlK2M
	dM/uTA00mTuP5prHKnZ+2OXvDCgkvR9vuVyNIaPR4RYckdKJTbawywcduSAPLW7EFlLkFRswKaZhF
	kBOJ4goR2HfNkEGBDG0Col8Ckvrs4vJY/NY43fbZEHmYRecwMJ91d9KBJ1AS9co4opU5uiTOPFYkz
	RtPihuHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRO8k-004rjb-Qj; Fri, 26 Aug 2022 01:28:06 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRO8g-004rfW-Bw
	for linux-nvme@lists.infradead.org; Fri, 26 Aug 2022 01:28:04 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MDMc55VHdzGpkW;
	Fri, 26 Aug 2022 09:26:13 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 09:27:54 +0800
Subject: Re: [PATCH 2/2] nvme-pci: don't wait freeze during resetting
To: Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
CC: Christoph Hellwig <hch@lst.de>, <linux-nvme@lists.infradead.org>, Yi Zhang
	<yi.zhang@redhat.com>, Sagi Grimberg <sagi@grimberg.me>
References: <20220821084754.340585-1-ming.lei@redhat.com>
 <20220821084754.340585-3-ming.lei@redhat.com>
 <fcd5d4c6-b803-db9f-a00c-abfe7365f364@huawei.com> <YwdeRgU4YsZEGz8J@T590>
 <Ywd8VLKPmDS7QmBu@kbusch-mbp.dhcp.thefacebook.com> <YweD7HkrNeiivHZO@T590>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <e127c191-450c-52b6-b268-60cee2091f36@huawei.com>
Date: Fri, 26 Aug 2022 09:27:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YweD7HkrNeiivHZO@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220825_182802_606251_325851A8 
X-CRM114-Status: GOOD (  16.98  )
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



On 2022/8/25 22:15, Ming Lei wrote:
> On Thu, Aug 25, 2022 at 07:42:44AM -0600, Keith Busch wrote:
>> On Thu, Aug 25, 2022 at 07:34:30PM +0800, Ming Lei wrote:
>>> On Thu, Aug 25, 2022 at 06:05:30PM +0800, Chao Leng wrote:
>>>>
>>>>
>>>> On 2022/8/21 16:47, Ming Lei wrote:
>>>>> First it isn't necessary to call nvme_wait_freeze in nvme_reset_work().
>>>>> If tagset isn't allocated, there can't be any inflight IOs; otherwise
>>>>> blk_mq_update_nr_hw_queues can freeze & wait queues.
>>>>>
>>>>> Second, since commit bdd6316094e0 ("block: Allow unfreezing of a queue
>>>>> while requests are in progress"), it is fine to unfreeze queue without
>>>>> draining inflight IOs.
>>>>>
>>>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>>>> ---
>>>>>    drivers/nvme/host/pci.c | 1 -
>>>>>    1 file changed, 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>>>>> index 3a1c37f32f30..91b2903fcc24 100644
>>>>> --- a/drivers/nvme/host/pci.c
>>>>> +++ b/drivers/nvme/host/pci.c
>>>>> @@ -2910,7 +2910,6 @@ static void nvme_reset_work(struct work_struct *work)
>>>>>    		nvme_free_tagset(dev);
>>>>>    	} else {
>>>>>    		nvme_start_queues(&dev->ctrl);
>>>>> -		nvme_wait_freeze(&dev->ctrl);
>>>> It is not safe.
>>>> nvme_dev_add may call blk_mq_update_nr_hw_queues, blk_mq_update_nr_hw_queues
>>>> require the state is frozen.
>>>
>>> blk_mq_update_nr_hw_queues() calls blk_freeze_queue() for every queue in
>>> this tagset, so it needn't nvme's freeze wait.
>>
>> Right, the blk-mq realloc should be fine, and it's really a very uncommon event
>> that nvme needs to realloc the tag set.
>>
>> I'm trying to remember why I added the wait freeze here in the first place, and
>> I don't recall a good reason for it. I think I had a controller that always
>> timed out IO, and the resets would just continue indefinitely. Waiting for
>> freeze within a reset causes the next IO timeout to trigger a driver detach.
>> That doesn't sound like a good idea, though, since it tears down the admin
>> queue too.
> 
> The wait becomes not necessary since commit bdd6316094e0 ("block: Allow unfreezing
> of a queue while requests are in progress").
Yes, I didn't notice this before. The wait freeze in nvme is redundant.

Reviewed-by: Chao Leng <lengchao@huawei.com>
> 
> 
> Thanks,
> Ming
> 
> 
> .
> 

