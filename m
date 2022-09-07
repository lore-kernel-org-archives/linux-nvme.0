Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6927BECAAD3
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Sep 2022 05:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GscHZ+e8pgA+INkNqsKseMwI1/dDHoIftH77UD+x8Uc=; b=WsbYYZ5itfdFEQ1zXLtvoZ/Yb6
	CRH2i7rDjMhPTrP4XV19nnDK6I70wL+5A591g4QH/eAvsWSqfJmfm+lObhh6Svnn0K1Anvo9/PO9g
	UQcKqttStPDob4/fVC5N67+bLrM9PjCsqFhJUe6XPZhinavlnSa2QheK1ilc8s4A+99ctYCe5k6qZ
	6e6etxC9HXrvdNI32Q2SfTTkg4Vy+bnhl1Ss5zR9gVHhSaxnJILsUai1YeNxZ5wrTqYOWtHbDI5xI
	+dmdXoIor9TMLTo6VhO3J0sBIY5ttyJD/+wAQ8dJVVaz3SH50xlKyOazkTFqlMVOpRfaxM30gFkeu
	7GBg++cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVo5B-0030Z5-CS; Wed, 07 Sep 2022 05:58:41 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVo56-0030PJ-6E
	for linux-nvme@lists.infradead.org; Wed, 07 Sep 2022 05:58:38 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MMrzF6r1NzZcff;
	Wed,  7 Sep 2022 13:53:45 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 7 Sep 2022 13:58:15 +0800
Subject: Re: [PATCH 1/2] nvme: make NVMe freeze API reliably
To: Ming Lei <ming.lei@redhat.com>
CC: Christoph Hellwig <hch@lst.de>, <linux-nvme@lists.infradead.org>, Yi Zhang
	<yi.zhang@redhat.com>, Sagi Grimberg <sagi@grimberg.me>, Keith Busch
	<kbusch@kernel.org>
References: <20220821084754.340585-1-ming.lei@redhat.com>
 <20220821084754.340585-2-ming.lei@redhat.com>
 <e2568bdd-a3cb-7a94-8018-d1468f3dcdd4@huawei.com> <YxcIkV2slhTR9MHX@T590>
 <5656419a-6271-b387-3e75-4dcb70047545@huawei.com> <YxfmyvCRQiYBGkHI@T590>
 <099899de-5914-c59c-bc2b-1d4d35c68818@huawei.com> <Yxf8kfUKRQxASeb5@T590>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <cb979baa-77e7-bfb8-2f74-3084269ae4f1@huawei.com>
Date: Wed, 7 Sep 2022 13:58:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <Yxf8kfUKRQxASeb5@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220906_225836_825696_F57A972E 
X-CRM114-Status: GOOD (  23.62  )
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



On 2022/9/7 10:06, Ming Lei wrote:
> On Wed, Sep 07, 2022 at 09:18:52AM +0800, Chao Leng wrote:
>>
>>
>> On 2022/9/7 8:33, Ming Lei wrote:
>>> On Tue, Sep 06, 2022 at 05:32:01PM +0800, Chao Leng wrote:
>>>>
>>>>
>>>> On 2022/9/6 16:45, Ming Lei wrote:
>>>>> On Thu, Aug 25, 2022 at 06:02:33PM +0800, Chao Leng wrote:
>>>>>>
>>>>>>
>>>>>> On 2022/8/21 16:47, Ming Lei wrote:
>>>>>>> From: Keith Busch <kbusch@kernel.org>
>>>>>>>
>>>>>>> In some corner cases[1], freeze wait and unfreeze API may be called on
>>>>>>> unfrozen queue, add one per-ns flag of NVME_NS_FREEZE to make these
>>>>>>> freeze APIs more reliably, then this kind of issues can be avoided.
>>>>>>> And similar approach has been applied on stopping/quiescing nvme queues.
>>>>>> This leads to another problem: the process that needs to be
>>>>>> in the frozen state is not actually frozen.
>>>>>> It's not safe.
>>>>>
>>>>> The flag is just to control if queue wait is needed, blk_mq_freeze_queue_wait
>>>>> can be done only the flag is set. Not sure how it isn't safe.
>>>> I thought that the use of NVME_NS_FREEZE was the same as NVME_NS_STOPPED.
>>>> If just set_bit in nvme_start_freeze, it will cause another problem in
>>>> below scenario.
>>>> A: start freeze and set the bit;B:start freeze and set the bit;
>>>> and then
>>>> A:test and clear the bit, and unfreeze;B: test and skip;
>>>> The queue will be frozen for ever.
>>>
>>> One simple approach is to replace down_read(->namespaces_rwsem) with
>>> down_write(->namespaces_rwsem) in nvme_start_freeze() and
>>> nvme_unfreeze().
>>>
>>>>
>>>> In addition, I think patch 2/2 can fix the bug well, patch 1/2 is not necessary.
>>>> No matter how to use NVME_NS_FREEZE , it may cause problems.
>>>> The freeze mechanism is perfect, and no additional protection mechanism is required.
>>>
>>> block layer requires queue freeze and unfreeze APIs to be called in
>>> pair strictly, that is why I add the 1st patch.
>>  From your bug analysis, the reason is that nvme_wait_freeze is called without nvme_start_freeze.
>> patch 2/2 is already delete the nvme_wait_freeze.
>> If there is another bug of unmatched freeze and unfreeze,
>> can you describe the analysis of unmatched freeze and unfreeze?
>> The current patch 1/2 will introduce the unmatched freeze and unfreeze rather than solved it.
>> Maybe another patch is needed to fix the bug.
> 
> Please look at nvme_reset_work():
> 		...
> 		if (dev->online_queues < 2) {
> 			...
>          } else {
>                  nvme_start_queues(&dev->ctrl);
> 				nvme_wait_freeze(&dev->ctrl);
>                  if (!dev->ctrl.tagset)
>                          nvme_pci_alloc_tag_set(dev);
>                  else
>                          nvme_pci_update_nr_queues(dev);
>                  nvme_dbbuf_set(dev);
>                  nvme_unfreeze(&dev->ctrl);
> 		}
> 		...
> 
> nvme_wait_freeze() is called on unfrozen queue, so io hang is caused.
> 
> If nvme_unfreeze() is called on unfrozen queue, WARN_ON_ONCE() in
> __blk_mq_unfreeze_queue() will be triggered.
The bug is specific to the PCI transport layer.
It might be a better option to fix this bug by adding flag for normal connection
and abnormal recovery like other transport layers, and then perform different processing.
Different processes are processed differently to avoid unexpected nvme_unfreeze.
> 
> 
> 
> Thanks,
> Ming
> 
> .
> 

