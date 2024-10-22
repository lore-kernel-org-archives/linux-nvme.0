Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F1ED1CDAC
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Oct 2024 08:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V+VAjwc5KAbA8QfGBsQvF3iNwu8+fE/+RDH99nl8cgg=; b=jzkXn/jS4dkeDMu2aKBUKKaVa4
	1lMszEvhLcQw15sFgWE6urB2va/IBCOP5+mQQzoZJ92kJIbq5EKkQ5UiBUeMUYGRQ8bHZJdFsouOy
	eQqvQHQFVbSkgg1VGyLBzqsNjJlJQHKVdjMYXeITkOOl3MJ5DGKvEbAnXVR95lUsMMEhnuRoZ1rUY
	de0o2mHfCDN2Z2Zrs7T+Mzn4TnQolC194lhcR7Fm10XZOnLriqBbpdLCoNA4l2EeuFxWCRMTgPD0M
	uUYpA5L0+MXh5ZkW5P7o9A+h2MciaWsK6NfmLiyU/nLbk0G3++ItsN8jvJipc6EvY5Rala58b6TDL
	w0KleZCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t39oj-0000000A5YX-0nkw;
	Tue, 22 Oct 2024 08:00:37 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t38nS-00000009tHk-02X2
	for linux-nvme@lists.infradead.org;
	Tue, 22 Oct 2024 06:55:15 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49M2HAfK009252;
	Tue, 22 Oct 2024 06:55:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=V+VAjw
	c5KAbA8QfGBsQvF3iNwu8+fE/+RDH99nl8cgg=; b=YkxDLv6eD1hnGeraqmA+Vr
	2YPtktdcNuMJOy28bZzC6PtyFaR18lFakb5YL4qXM0IfdIHjoKKAUufRnsW0g41/
	EZZSHQc9c+Ot0OKFJIPho+wwP2BpLlOu5pM+p4fF2HcX2V6cDlXgzFYZwpMo99CM
	mmkoMg9pewknshhV7ve87y3W2CuxAld642n+NfL3yfF1fjVLqNaWGw2BwOeEoh3j
	qoHTn8IdZIA4k2F8cQKlq2faM+VwdUCS7HILEdldk1R0/aa5EgimiXPAtTwcC3N+
	IoUtYEEE5F5h4irzNRXu4sBqSbZA/ylk1jhjQ9Kh/ofyyKWYiE0TQ34bFXoOmXQQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5hmd8d9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 06:55:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49M5KR5a029439;
	Tue, 22 Oct 2024 06:55:03 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42crkk1wtv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 06:55:03 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49M6t2p845809980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 06:55:03 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF29C5805A;
	Tue, 22 Oct 2024 06:55:02 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C237E58054;
	Tue, 22 Oct 2024 06:54:59 +0000 (GMT)
Received: from [9.109.198.143] (unknown [9.109.198.143])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Oct 2024 06:54:59 +0000 (GMT)
Message-ID: <b03863b2-8816-48cd-aa18-436f1c49ec8c@linux.ibm.com>
Date: Tue, 22 Oct 2024 12:24:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] nvme: make keep-alive synchronous operation
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, axboe@fb.com, chaitanyak@nvidia.com,
        dlemoal@kernel.org, gjoyce@linux.ibm.com
References: <20241016030339.54029-1-nilay@linux.ibm.com>
 <20241016030339.54029-3-nilay@linux.ibm.com>
 <a5908bbc-4230-460d-b814-a0b41d16a15d@grimberg.me>
 <bd0bfd18-b5bf-485a-9891-20974557d740@linux.ibm.com>
 <f8b03260-9792-4612-aebd-52db4458b949@grimberg.me>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <f8b03260-9792-4612-aebd-52db4458b949@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bCl8bxpOdS6zYaK0oqCrxP7Wp76eBIyT
X-Proofpoint-GUID: bCl8bxpOdS6zYaK0oqCrxP7Wp76eBIyT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 phishscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410220043
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241021_235514_305232_C82F06BA 
X-CRM114-Status: GOOD (  38.98  )
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



On 10/21/24 20:44, Sagi Grimberg wrote:
> 
> 
> 
> On 21/10/2024 14:58, Nilay Shroff wrote:
>>
>> On 10/21/24 03:19, Sagi Grimberg wrote:
>>> Hey Nilay,
>>>
>>> First, can you please phrase the patch title to describe what it
>>> is addressing, not what it is changing, that can come (as it does)
>>> in the body.
>>>
>> sure, how about naming it as "nvme-fabrics: fix kernel crash while shutting down controller" ?
>>
>>> Second, I don't think we want to spend a thread waiting for
>>> synchronous IO for the purpose of keep alive. Is this the only
>>> way that this can be done?
>>>
>>> Third, was this observed with non-loop transports?
>>>
>> Yes it could happen even with non-loop fabric transports.
>>
>>> On 16/10/2024 6:03, Nilay Shroff wrote:
>>>> The nvme keep-alive operation, which executes at a periodic interval,
>>>> could potentially sneak in while shutting down a fabric controller.
>>>> This may lead to a race between the fabric controller admin queue
>>>> destroy code path (invoked while shutting down controller) and hw/hctx
>>>> queue dispatcher called from the nvme keep-alive async request queuing
>>>> operation. This race could lead to the kernel crash shown below:
>>> What is different about keep-alive than any other command?
>> The one difference is, of course, keep-alive is async but we may have
>> other async requests running while shutting down the controller. I found
>> that, when compared the keep-alive with other commands, the keep-alive
>> runs in the worker thread context but other commands (for instance async
>> read/write) runs in the user context and that uses the blk plugging. When we
>> use plugging, the call path for issuing request to driver is quite different
>> from that of issuing request using blk_execute_rq_nowait(). This subtle
>> difference is probably the reason not causing the kernel crash issuing
>> read/write command while shutting down the fabric controller.
>>
>> The call path for blk plugging for issuing the request to driver:
>> __blk_flush_plug()
>>    -> blk_mq_flush_plug_list()
>>      ->blk_mq_dispatch_plug_list()
>>
>> The blk_mq_dispatch_plug_list() first increments ->q_usage_counter before
>> dispatching requests. Basically here the queue dispatcher (blk_mq_run_hw_queue
>> function) is protected from the queue being destroyed on other cpu thread.
>> So that means that even after a request (assuming the only request in queue)
>> is cancelled or flushed off due to fabric controller is shutting down, the
>> blk-mq destroy code path would not be able to forward progress until the
>> ->q_usage_counter is decremented and becomes zero. And we can see in
>> blk_mq_dispatch_plug_list() that it decrements ->q_usage_counter only after
>> the blk_mq_run_hw_queue function returns.
> 
> Sounds like an issue that is not related to keep-alive at all.
> 
>>>> Call Trace:
>>>>       autoremove_wake_function+0x0/0xbc (unreliable)
>>>>       __blk_mq_sched_dispatch_requests+0x114/0x24c
>>>>       blk_mq_sched_dispatch_requests+0x44/0x84
>>>>       blk_mq_run_hw_queue+0x140/0x220
>>>>       nvme_keep_alive_work+0xc8/0x19c [nvme_core]
>>>>       process_one_work+0x200/0x4e0
>>>>       worker_thread+0x340/0x504
>>>>       kthread+0x138/0x140
>>>>       start_kernel_thread+0x14/0x18
>>> What is the "crash" here? use-after-free?
>> yes it's use-after-free kernel crash.
>>>> While shutting down fabric controller, if nvme keep-alive request sneaks
>>>> in then it would be flushed off. The nvme_keep_alive_end_io function is
>>>> then invoked to handle the end of the keep-alive operation which
>>>> decrements the admin->q_usage_counter and assuming this is the last/only
>>>> request in the admin queue then the admin->q_usage_counter becomes zero.
>>>> If that happens then blk-mq destroy queue operation (blk_mq_destroy_
>>>> queue()) which could be potentially running simultaneously on another
>>>> cpu (as this is the controller shutdown code path) would forward
>>>> progress and deletes the admin queue. So, now from this point onward
>>>> we are not supposed to access the admin queue resources. However the
>>>> issue here's that the nvme keep-alive thread running hw/hctx queue
>>>> dispatch operation hasn't yet finished its work and so it could still
>>>> potentially access the admin queue resource while the admin queue had
>>>> been already deleted and that causes the above crash.
>>> Again, it is unclear to me what justifies the cure here. Every command can
>>> race with the shutdown, and it can be sync or async.
>>>
>> While I was researching on this issue, I figured that the nvme keep-alive is
>> probably the only async request running in worker thread context and not well
>> synchronized with the fabric controller shutdown code path. Yes we may have other
>> async request (for instance async read/write) which might get-in the way of the
>> fabric controller shutdown code path but those mostly run in the user context and
>> hence have a different code path than keep-alive command for submitting/queuing
>> the request.
> 
> This sounds like we papered around the problem. is it not allowed to call blk_execute_rq_nowait
> from a kthread?
I didn't meant calling blk_execute_rq_nowait is not allowed from kthread. It's allowed 
but the side effect it causes is what I just wanted to highlight. 
> 
>>
>>>> This fix helps avoid the observed crash by implementing keep-alive as a
>>>> synchronous operation so that we decrement admin->q_usage_counter only
>>>> after keep-alive command finished its execution and returns the command
>>>> status back up to its caller (blk_execute_rq()). This would ensure that
>>>> fabric shutdown code path doesn't destroy the fabric admin queue until
>>>> keep-alive request finished execution and also keep-alive thread is not
>>>> running hw/hctx queue dispatch operation.
>>> I'd want to see exactly what is causing this race because we already flush
>>> the keep alive work when starting the shutdown... so it only means it is
>>> incorrectly firing again?
>>>
>>> What I think we should do instead, is given that we already cancel_sync the keep
>>> alive work before making progress with the teardown, we should just make sure
>>> that it doesn't triggered afterwards again if it does.
>> No, keep-alive doesn't incorrectly fired, however once a keep-alive request is
>> allocated but before it's queued,
> 
> The queue teardown quiesce the admin queue first, which should prevent the dispatch.
> You probably mean that it runs a little later, after the dispatch passes the quiesced test...
> 
> The question is, why did blk_mq_quiesce_queue did not wait for rcu grace? which should
> have ensured that there is no dispatch going on? at least that is what it's supposed to do...
> something doesn't add up
> 
This issue manifests when the keep-alive command sneaks in after the admin queue is 
unquiesced but before its freezed.

nvme_unquiesce_admin_queue() <<< we unquiesce admin queue   

<<< here keep-alive sneaks in and it starts running dispatcher

nvme_remove_admin_tag_set()  <<< we freeze queue and wait for ->q_usage_counter to become zero 

So as mentioned above, we have time window between queue unquiesce and freeze 
operations where async keep-alive could potentially sneaks in and causing the 
observed symptom.

Thanks,
--Nilay
  

