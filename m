Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2066ECAAA1
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Sep 2022 01:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ql2ZsS6C9DqCAZwEgVHYcw2ylOiwRsU5/zNSH0mMTcw=; b=RP4JJyG3ktM+wL9lxyy9xvTFEU
	g+9RZhsD23SVQZR7uRbdjGaBNQkqKwYXcV3QTOL+2hRCf2TYHhywqmRbZwUYDwlJ7W7enk21FJUfo
	qoKAT2CWNpJ6l3+9oVVlnoM1prhURGLWeCXVV0SzJCHgKv7d+J8d0bCU70lHLjFpijvbn+vZpYeg7
	QCbc/5nwWvpF2PKK1HMwMo86kd85j9tnDp6Ol/UZISYwaEEhRvbt+dTt5fLCfOrftJ6Y/kPBln0Cf
	So/rBbrRdR0jmvT2lpobTKwk/db8H7LP6DC7vbM9z66JTqHJgGijqz6omBGSCUZg3czJ7uyK8EVq5
	wX2/T3eA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVjia-001FDF-RR; Wed, 07 Sep 2022 01:19:04 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVjiX-001F9G-0C
	for linux-nvme@lists.infradead.org; Wed, 07 Sep 2022 01:19:03 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MMkmv6vt3zZfDR;
	Wed,  7 Sep 2022 09:14:23 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 7 Sep 2022 09:18:53 +0800
Subject: Re: [PATCH 1/2] nvme: make NVMe freeze API reliably
To: Ming Lei <ming.lei@redhat.com>
CC: Christoph Hellwig <hch@lst.de>, <linux-nvme@lists.infradead.org>, Yi Zhang
	<yi.zhang@redhat.com>, Sagi Grimberg <sagi@grimberg.me>, Keith Busch
	<kbusch@kernel.org>
References: <20220821084754.340585-1-ming.lei@redhat.com>
 <20220821084754.340585-2-ming.lei@redhat.com>
 <e2568bdd-a3cb-7a94-8018-d1468f3dcdd4@huawei.com> <YxcIkV2slhTR9MHX@T590>
 <5656419a-6271-b387-3e75-4dcb70047545@huawei.com> <YxfmyvCRQiYBGkHI@T590>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <099899de-5914-c59c-bc2b-1d4d35c68818@huawei.com>
Date: Wed, 7 Sep 2022 09:18:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YxfmyvCRQiYBGkHI@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220906_181901_289580_A41CD1DF 
X-CRM114-Status: GOOD (  20.81  )
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



On 2022/9/7 8:33, Ming Lei wrote:
> On Tue, Sep 06, 2022 at 05:32:01PM +0800, Chao Leng wrote:
>>
>>
>> On 2022/9/6 16:45, Ming Lei wrote:
>>> On Thu, Aug 25, 2022 at 06:02:33PM +0800, Chao Leng wrote:
>>>>
>>>>
>>>> On 2022/8/21 16:47, Ming Lei wrote:
>>>>> From: Keith Busch <kbusch@kernel.org>
>>>>>
>>>>> In some corner cases[1], freeze wait and unfreeze API may be called on
>>>>> unfrozen queue, add one per-ns flag of NVME_NS_FREEZE to make these
>>>>> freeze APIs more reliably, then this kind of issues can be avoided.
>>>>> And similar approach has been applied on stopping/quiescing nvme queues.
>>>> This leads to another problem: the process that needs to be
>>>> in the frozen state is not actually frozen.
>>>> It's not safe.
>>>
>>> The flag is just to control if queue wait is needed, blk_mq_freeze_queue_wait
>>> can be done only the flag is set. Not sure how it isn't safe.
>> I thought that the use of NVME_NS_FREEZE was the same as NVME_NS_STOPPED.
>> If just set_bit in nvme_start_freeze, it will cause another problem in
>> below scenario.
>> A: start freeze and set the bit;B:start freeze and set the bit;
>> and then
>> A:test and clear the bit, and unfreeze;B: test and skip;
>> The queue will be frozen for ever.
> 
> One simple approach is to replace down_read(->namespaces_rwsem) with
> down_write(->namespaces_rwsem) in nvme_start_freeze() and
> nvme_unfreeze().
> 
>>
>> In addition, I think patch 2/2 can fix the bug well, patch 1/2 is not necessary.
>> No matter how to use NVME_NS_FREEZE , it may cause problems.
>> The freeze mechanism is perfect, and no additional protection mechanism is required.
> 
> block layer requires queue freeze and unfreeze APIs to be called in
> pair strictly, that is why I add the 1st patch.
 From your bug analysis, the reason is that nvme_wait_freeze is called without nvme_start_freeze.
patch 2/2 is already delete the nvme_wait_freeze.
If there is another bug of unmatched freeze and unfreeze,
can you describe the analysis of unmatched freeze and unfreeze?
The current patch 1/2 will introduce the unmatched freeze and unfreeze rather than solved it.
Maybe another patch is needed to fix the bug.
> 
> 
> 
> Thanks,
> Ming
> 
> .
> 

