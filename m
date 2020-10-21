Return-Path: <SRS0=B+Fz=D4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF82C4363D
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2020 03:14:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EC2222249
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2020 03:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jI1ZAUyF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EC2222249
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5w0P6tE+Cwe+nXj1Z2mAlTH0xMnU5QiQyMg4B+9DoPk=; b=jI1ZAUyFMb/a67FSz9AicD9AO
	PLMG2Ms8m7NqwbScooZ8J0yBz5zymldXACSdmuUeUAgHklhU+d3mY4RLNu+JOuAX+744fmNCzbLFn
	hoed5XSdVTIczTFAd/1oFOUV3K3VatE22FNeDwwZMDy5eDxAGQGQ2gKQeuGxE5uRJYtABE9IQV6L6
	j+OEhOimEQO+WdbZzgx2w+K7XhOHPy+PRJpxAUeI6GcdSu1OH/Y6A8pd2b0FBZK2I4Z3icvZjZmh4
	dJQEiXVqIYcYgt8krLwGoHyMZX2QHMFgl+9x2u3wG/z8d5/811yOuljXa+JPzuIm2GLdzojRQe9zf
	vR4Lcw3+Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kV4aM-0007qm-LF; Wed, 21 Oct 2020 03:14:46 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kV4aJ-0007q0-Dw
 for linux-nvme@lists.infradead.org; Wed, 21 Oct 2020 03:14:44 +0000
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id 2C8EE4DAADA62DD7F785;
 Wed, 21 Oct 2020 11:14:39 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Wed, 21 Oct 2020 11:14:38 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Wed, 21
 Oct 2020 11:14:38 +0800
Subject: Re: [PATCH V2 3/4] nvme: tcp: complete non-IO requests atomically
To: Ming Lei <ming.lei@redhat.com>
References: <20201020085301.1553959-1-ming.lei@redhat.com>
 <20201020085301.1553959-4-ming.lei@redhat.com>
 <e1d53ce3-ea27-439e-5e7a-ba790742908e@huawei.com>
 <20201021012241.GC1571548@T590>
 <7a3cdbdb-8e57-484c-fcb3-e8e72dfe8d13@huawei.com>
 <20201021025534.GD1571548@T590>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <c710fdd5-c433-16a4-4d78-099a880344ba@huawei.com>
Date: Wed, 21 Oct 2020 11:14:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20201021025534.GD1571548@T590>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme709-chm.china.huawei.com (10.1.199.105) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201020_231443_725572_50A2822A 
X-CRM114-Status: GOOD (  26.75  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, Yi Zhang <yi.zhang@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020/10/21 10:55, Ming Lei wrote:
> On Wed, Oct 21, 2020 at 10:20:11AM +0800, Chao Leng wrote:
>>
>>
>> On 2020/10/21 9:22, Ming Lei wrote:
>>> On Tue, Oct 20, 2020 at 05:04:29PM +0800, Chao Leng wrote:
>>>>
>>>>
>>>> On 2020/10/20 16:53, Ming Lei wrote:
>>>>> During controller's CONNECTING state, admin/fabric/connect requests
>>>>> are submitted for recovery controller, and we allow to abort this request
>>>>> directly in time out handler for not blocking setup procedure.
>>>>>
>>>>> So timout vs. normal completion race exists on these requests since
>>>>> admin/fabirc/connect queues won't be shutdown before handling timeout
>>>>> during CONNECTING state.
>>>>>
>>>>> Add atomic completion for requests from connect/fabric/admin queue for
>>>>> avoiding the race.
>>>>>
>>>>> CC: Chao Leng <lengchao@huawei.com>
>>>>> Cc: Sagi Grimberg <sagi@grimberg.me>
>>>>> Reported-by: Yi Zhang <yi.zhang@redhat.com>
>>>>> Tested-by: Yi Zhang <yi.zhang@redhat.com>
>>>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>>>> ---
>>>>>     drivers/nvme/host/tcp.c | 40 +++++++++++++++++++++++++++++++++++++---
>>>>>     1 file changed, 37 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>>>> index d6a3e1487354..7e85bd4a8d1b 100644
>>>>> --- a/drivers/nvme/host/tcp.c
>>>>> +++ b/drivers/nvme/host/tcp.c
>>>>> @@ -30,6 +30,8 @@ static int so_priority;
>>>>>     module_param(so_priority, int, 0644);
>>>>>     MODULE_PARM_DESC(so_priority, "nvme tcp socket optimize priority");
>>>>> +#define REQ_STATE_COMPLETE     0
>>>>> +
>>>>>     enum nvme_tcp_send_state {
>>>>>     	NVME_TCP_SEND_CMD_PDU = 0,
>>>>>     	NVME_TCP_SEND_H2C_PDU,
>>>>> @@ -56,6 +58,8 @@ struct nvme_tcp_request {
>>>>>     	size_t			offset;
>>>>>     	size_t			data_sent;
>>>>>     	enum nvme_tcp_send_state state;
>>>>> +
>>>>> +	unsigned long		comp_state;
>>>> I do not think adding state is a good idea.
>>>> It is similar to rq->state.
>>>> In the teardown process, after quiesced queues delete the timer and
>>>> cancel the timeout work maybe a better option.
>>>> I will send the patch later.
>>>> The patch is already tested with roce more than one week.
>>>
>>> Actually there isn't race between timeout and teardown, and patch 1 and patch
>>> 2 are enough to fix the issue reported by Yi.
>>>
>>> It is just that rq->state is updated to IDLE in its. complete(), so
>>> either one of code paths may think that this rq isn't completed, and
>>> patch 2 has addressed this issue.
>>>
>>> In short, teardown lock is enough to cover the race.
>> The race may cause abnormals:
>> 1. Reported by Yi Zhang <yi.zhang@redhat.com>
>> detail: https://lore.kernel.org/linux-nvme/1934331639.3314730.1602152202454.JavaMail.zimbra@redhat.com/
>> 2. BUG_ON in blk_mq_requeue_request
>> Because error recovery and time out may repeated completion request.
>> First error recovery cancel request in tear down process, the request
>> will be retried in completion, rq->state will be changed to IDEL.
> 
> Right.
> 
>> And then time out will complete the request again, and samely retry
>> the request, BUG_ON will happen in blk_mq_requeue_request.
> 
> With patch2 in this patchset, timeout handler won't complete the request any
> more.
> 
>> 3. abnormal link disconnection
>> Firt error recovery cancel all request, reconnect success, the request
>> will be restarted. And then time out will complete the request again,
>> the queue will be stoped in nvme_rdma(tcp)_complete_timed_out,
>> Abnormal link diconnection will happen. The condition(time out process
>> is delayed long time by some reason such as hardware interrupt) is need.
>> So the probability is low.
> 
> OK, the timeout handler may just get chance to run after recovery is
> done, and it can be fixed by calling nvme_sync_queues() after
> updating to CONNECTING or before updating to LIVE together with patch 1 & 2.
> 
>> teardown_lock just serialize the race. and add checkint the rq->state can avoid
>> the 1 and 2 scenario, but 3 scenario can not be fixed.
> 
> I didn't think of scenario 3, which seems not triggered in Yi's test.
The scenario 3 is unlikely triggered in normal test.
The trigger condition are harsh. It'll only happen in some extreme situations.
If without scenario 3, Sagi's patch can work well.
> 
> 
> thanks,
> Ming
> 
> .
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
