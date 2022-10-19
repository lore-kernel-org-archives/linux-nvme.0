Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB7DC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Oct 2022 02:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V6PpygCAYpzSeswmplTRn6b7KgEEwrhEoy3VrtQCuqQ=; b=a7y2UGaNK2UYPm0EdmNDdAGhEZ
	3lDo59sc+g8IUpKvtrntM4wfKxUbTwkMDCYmUwB/xxl/0hji/7jQU5eMzaHHfoQK+15MVtyMRaItm
	2MUKFqT7TKfMe82ZgaJhUSI9XMguFdeAg29/lUb4sZGmqGoVr0xCfUqVVR5cedgt2pbeW91aQEGBr
	Wbg42JMIikzcn794qT4vYIoHEp7leQWjEp1HW4Y0N+gSoAONfNgUGYkeLNbk5J8Qdnj9dNE+afoOb
	IvBiBljkj8nZE5itIbcWZ6VsgubRSbvS0p38N6ZVw7vJDimKEQ1+GW60/PLlGqlpgfzTlwMYdFmwM
	QNLLl4pA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okyzq-00DhNR-QW; Wed, 19 Oct 2022 02:39:54 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okyzl-00Dh6n-1a
	for linux-nvme@lists.infradead.org; Wed, 19 Oct 2022 02:39:53 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MsZgr3btnzHv4q;
	Wed, 19 Oct 2022 10:39:36 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 10:39:42 +0800
Subject: Re: [PATCH v2 1/2] blk-mq: add tagset quiesce interface
To: <paulmck@kernel.org>
CC: Christoph Hellwig <hch@lst.de>, <linux-nvme@lists.infradead.org>,
	<linux-block@vger.kernel.org>, <sagi@grimberg.me>, <kbusch@kernel.org>,
	<ming.lei@redhat.com>, <axboe@kernel.dk>
References: <20221013094450.5947-1-lengchao@huawei.com>
 <20221013094450.5947-2-lengchao@huawei.com> <20221017133906.GA24492@lst.de>
 <20221017152136.GI5600@paulmck-ThinkPad-P17-Gen-1>
 <3bb8a547-b2e2-7654-55dc-e943ac9aa06d@huawei.com>
 <20221018150406.GO5600@paulmck-ThinkPad-P17-Gen-1>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <dc24947f-9017-0399-606d-f9562a381485@huawei.com>
Date: Wed, 19 Oct 2022 10:39:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20221018150406.GO5600@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221018_193951_803837_2FE48961 
X-CRM114-Status: GOOD (  22.30  )
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



On 2022/10/18 23:04, Paul E. McKenney wrote:
> On Tue, Oct 18, 2022 at 05:52:06PM +0800, Chao Leng wrote:
>> On 2022/10/17 23:21, Paul E. McKenney wrote:
>>> On Mon, Oct 17, 2022 at 03:39:06PM +0200, Christoph Hellwig wrote:
>>>> On Thu, Oct 13, 2022 at 05:44:49PM +0800, Chao Leng wrote:
>>>>> +	rcu = kvmalloc(count * sizeof(*rcu), GFP_KERNEL);
>>>>> +	if (rcu) {
>>>>> +		list_for_each_entry(q, &set->tag_list, tag_set_list) {
>>>>> +			if (blk_queue_noquiesced(q))
>>>>> +				continue;
>>>>> +
>>>>> +			init_rcu_head(&rcu[i].head);
>>>>> +			init_completion(&rcu[i].completion);
>>>>> +			call_srcu(q->srcu, &rcu[i].head, wakeme_after_rcu);
>>>>> +			i++;
>>>>> +		}
>>>>> +
>>>>> +		for (i = 0; i < count; i++) {
>>>>> +			wait_for_completion(&rcu[i].completion);
>>>>> +			destroy_rcu_head(&rcu[i].head);
>>>>> +		}
>>>>> +		kvfree(rcu);
>>>>> +	} else {
>>>>> +		list_for_each_entry(q, &set->tag_list, tag_set_list)
>>>>> +			synchronize_srcu(q->srcu);
>>>>> +	}
>>>>
>>>> Having to allocate a struct rcu_synchronize for each of the potentially
>>>> many queues here is a bit sad.
>>>>
>>>> Pull just explained the start_poll_synchronize_rcu interfaces at ALPSS
>>>> last week, so I wonder if something like that would also be feasible
>>>> for SRCU, as that would come in really handy here.
>>>
>>> There is start_poll_synchronize_srcu() and poll_state_synchronize_srcu(),
>>> but there would need to be an unsigned long for each srcu_struct from
>>> which an SRCU grace period was required.  This would be half the size
>>> of the "rcu" array above, but still maybe larger than you would like.
>>>
>>> The resulting code might look something like this, with "rcu" now being
>>> a pointer to unsigned long:
>>>
>>> 	rcu = kvmalloc(count * sizeof(*rcu), GFP_KERNEL);
>>> 	if (rcu) {
>>> 		list_for_each_entry(q, &set->tag_list, tag_set_list) {
>>> 			if (blk_queue_noquiesced(q))
>>> 				continue;
>>> 			rcu[i] = start_poll_synchronize_srcu(q->srcu);
>>> 			i++;
>>> 		}
>>>
>>> 		for (i = 0; i < count; i++)
>>> 			if (!poll_state_synchronize_srcu(q->srcu))
>>> 				synchronize_srcu(q->srcu);
>> synchronize_srcu will restart a new period of grace.
> 
> True, but SRCU grace periods normally complete reasonably quickly, so
> the synchronize_srcu() might well be faster than the loop, depending on
> what the corresponding SRCU readers are doing.
Yes, Different runtimes have different wait times, and it's hard to say
which is better or worse.
> 
>> Maybe it would be better like this:
>> 			while (!poll_state_synchronize_srcu(q->srcu, rcu[i]))
>> 				schedule_timeout_uninterruptible(1);
> 
> Why not try it both ways and see what happens?  Assuming that is, that
> the differences matter in this code.
> 
> 							Thanx, Paul
> 
>>> 		kvfree(rcu);
>>> 	} else {
>>> 		list_for_each_entry(q, &set->tag_list, tag_set_list)
>>> 			synchronize_srcu(q->srcu);
>>> 	}
>>>
>>> Or as Christoph suggested, just have a single srcu_struct for the
>>> whole group.
>>>
>>> The main reason for having multiple srcu_struct structures is to
>>> prevent the readers from one from holding up the updaters from another.
>>> Except that by waiting for the multiple grace periods, you are losing
>>> that property anyway, correct?  Or is this code waiting on only a small
>>> fraction of the srcu_struct structures associated with blk_queue?
>>>
>>> 							Thanx, Paul
>>> .
>>>
> .
> 

