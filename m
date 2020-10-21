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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E287CC4363D
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2020 02:20:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2EBD22251
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2020 02:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="zfnliuTZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2EBD22251
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Peqf/vlgaaZN11BHcxn+dxXw3yWGlGUizzoLkTehUcA=; b=zfnliuTZ0XzxIgS/GsmRhBF/0
	XOdL5HgMtwQNhwdSuDzVbalDArzJwylgULfUQsnDt66kM1Ky2CShm36QohaP6/+s5bGDG6G/859ub
	PpToLWlHAqLvBOw9mZQUGihERPiQ3uC/4cAKmnyj7TOcT6Yn66wn5o/dhhTxgOFmaZdzyo+niLYEf
	7PhmZXWUFlck+4jsHmzwosgLEzJhTOrJDrDwvRCXU2kuWmDbdo6G6Ml1YlsfS7dXJDYawCcA9bNmK
	Ud22lbfkXcMDRWOJtyCQhfV0AybMcGaoEOdaj3T/KAcO1GILUtPhKpOcQS8AOZVn8y0rgpvF7DRfD
	P7Md3z0rw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kV3jg-0003D6-B1; Wed, 21 Oct 2020 02:20:20 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kV3jd-0003CM-Id
 for linux-nvme@lists.infradead.org; Wed, 21 Oct 2020 02:20:18 +0000
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.54])
 by Forcepoint Email with ESMTP id B37FE93A2F2A815C363A;
 Wed, 21 Oct 2020 10:20:12 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Wed, 21 Oct 2020 10:20:12 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Wed, 21
 Oct 2020 10:20:11 +0800
Subject: Re: [PATCH V2 3/4] nvme: tcp: complete non-IO requests atomically
To: Ming Lei <ming.lei@redhat.com>
References: <20201020085301.1553959-1-ming.lei@redhat.com>
 <20201020085301.1553959-4-ming.lei@redhat.com>
 <e1d53ce3-ea27-439e-5e7a-ba790742908e@huawei.com>
 <20201021012241.GC1571548@T590>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <7a3cdbdb-8e57-484c-fcb3-e8e72dfe8d13@huawei.com>
Date: Wed, 21 Oct 2020 10:20:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20201021012241.GC1571548@T590>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme701-chm.china.huawei.com (10.1.199.97) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201020_222017_912260_0BB4287A 
X-CRM114-Status: GOOD (  24.74  )
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



On 2020/10/21 9:22, Ming Lei wrote:
> On Tue, Oct 20, 2020 at 05:04:29PM +0800, Chao Leng wrote:
>>
>>
>> On 2020/10/20 16:53, Ming Lei wrote:
>>> During controller's CONNECTING state, admin/fabric/connect requests
>>> are submitted for recovery controller, and we allow to abort this request
>>> directly in time out handler for not blocking setup procedure.
>>>
>>> So timout vs. normal completion race exists on these requests since
>>> admin/fabirc/connect queues won't be shutdown before handling timeout
>>> during CONNECTING state.
>>>
>>> Add atomic completion for requests from connect/fabric/admin queue for
>>> avoiding the race.
>>>
>>> CC: Chao Leng <lengchao@huawei.com>
>>> Cc: Sagi Grimberg <sagi@grimberg.me>
>>> Reported-by: Yi Zhang <yi.zhang@redhat.com>
>>> Tested-by: Yi Zhang <yi.zhang@redhat.com>
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>> ---
>>>    drivers/nvme/host/tcp.c | 40 +++++++++++++++++++++++++++++++++++++---
>>>    1 file changed, 37 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>> index d6a3e1487354..7e85bd4a8d1b 100644
>>> --- a/drivers/nvme/host/tcp.c
>>> +++ b/drivers/nvme/host/tcp.c
>>> @@ -30,6 +30,8 @@ static int so_priority;
>>>    module_param(so_priority, int, 0644);
>>>    MODULE_PARM_DESC(so_priority, "nvme tcp socket optimize priority");
>>> +#define REQ_STATE_COMPLETE     0
>>> +
>>>    enum nvme_tcp_send_state {
>>>    	NVME_TCP_SEND_CMD_PDU = 0,
>>>    	NVME_TCP_SEND_H2C_PDU,
>>> @@ -56,6 +58,8 @@ struct nvme_tcp_request {
>>>    	size_t			offset;
>>>    	size_t			data_sent;
>>>    	enum nvme_tcp_send_state state;
>>> +
>>> +	unsigned long		comp_state;
>> I do not think adding state is a good idea.
>> It is similar to rq->state.
>> In the teardown process, after quiesced queues delete the timer and
>> cancel the timeout work maybe a better option.
>> I will send the patch later.
>> The patch is already tested with roce more than one week.
> 
> Actually there isn't race between timeout and teardown, and patch 1 and patch
> 2 are enough to fix the issue reported by Yi.
> 
> It is just that rq->state is updated to IDLE in its. complete(), so
> either one of code paths may think that this rq isn't completed, and
> patch 2 has addressed this issue.
> 
> In short, teardown lock is enough to cover the race.
The race may cause abnormals:
1. Reported by Yi Zhang <yi.zhang@redhat.com>
detail: https://lore.kernel.org/linux-nvme/1934331639.3314730.1602152202454.JavaMail.zimbra@redhat.com/
2. BUG_ON in blk_mq_requeue_request
Because error recovery and time out may repeated completion request.
First error recovery cancel request in tear down process, the request
will be retried in completion, rq->state will be changed to IDEL.
And then time out will complete the request again, and samely retry
the request, BUG_ON will happen in blk_mq_requeue_request.
3. abnormal link disconnection
Firt error recovery cancel all request, reconnect success, the request
will be restarted. And then time out will complete the request again,
the queue will be stoped in nvme_rdma(tcp)_complete_timed_out,
Abnormal link diconnection will happen. The condition(time out process
is delayed long time by some reason such as hardware interrupt) is need.
So the probability is low.

teardown_lock just serialize the race. and add checkint the rq->state can avoid
the 1 and 2 scenario, but 3 scenario can not be fixed.
> 
> 
> Thanks,
> Ming
> 
> .
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
