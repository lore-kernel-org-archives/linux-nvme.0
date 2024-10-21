Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A795D15D86
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Oct 2024 11:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L6e29gag18/Fi8QoVHVW3Mem3AHrZNBS8emciDiw5Wc=; b=JzBGHKsqSxRV5vJCSwPi4BHTBv
	Ehk/JDggKpDUgriQnqPtZNk1j4HRcwSPMoHRtYtfq8w2+qSq3u+m33NGLwx/FVaid3JDqIAHIg4Sm
	dKQnKOYWT5XrrYmn6WN6uqoWx5xDLgzKgfC91gdXyJFwULLMelR+vrHTutt5zNprCdXJW93nsaQ6O
	ZCgLGfWNtPXh2masKk5ji7JKbfGvdqFfU30rfZCPiVqmXxR+4t5JIZ2QSOtlUUBNQIzx/0BmTmZP/
	+jBEcfcKqPnlFgV/J2gZIyR/NP8mbPPUAuahV/QOMWKp/+cZieM/5uwIMabUxLxE7Z19JvENdJHnN
	7z59sa0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2r3u-000000078KZ-1joF;
	Mon, 21 Oct 2024 11:59:02 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2r3P-000000078A6-08za
	for linux-nvme@lists.infradead.org;
	Mon, 21 Oct 2024 11:58:34 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49L2KIeA026094;
	Mon, 21 Oct 2024 11:58:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=L6e29g
	ag18/Fi8QoVHVW3Mem3AHrZNBS8emciDiw5Wc=; b=WimZDE3VojZlUnIErwF05V
	iSsTbtcYpNyA6T0Zu2U28h1lGoy2fpQ/c9199SuqAEwbFCydk89bIMBq9ywcQ4Qh
	RoAQ6e44ZgpMaLu5k5EjCynOfMqBZjY1wGa46vmzmEkvEScwNh06K7pF3UssHYQi
	cK2XkAakINgX4Q/ZYXq2PncuK1F6GAO7C8Z3S8z904I5ZvgusHSRgZO7PizXycUL
	/3xOI00twX5KE/eLcaYXyXVFWYAhoZE1NrPre+JerC/Kf2qltZvYGsgSDXKlRoy9
	zTUgn2qPJuenlBRmP3PJNspWFLC5WXtL3Ihf3Ur6CzyhyJVHTm7oLuwwZ4FEgAyQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5eu8huh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 11:58:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49L9kF4e023836;
	Mon, 21 Oct 2024 11:58:20 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42cst0wuaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 11:58:20 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49LBwJWf46793054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 11:58:19 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6093758065;
	Mon, 21 Oct 2024 11:58:19 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B607458053;
	Mon, 21 Oct 2024 11:58:16 +0000 (GMT)
Received: from [9.171.30.180] (unknown [9.171.30.180])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Oct 2024 11:58:16 +0000 (GMT)
Message-ID: <bd0bfd18-b5bf-485a-9891-20974557d740@linux.ibm.com>
Date: Mon, 21 Oct 2024 17:28:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] nvme: make keep-alive synchronous operation
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, axboe@fb.com, chaitanyak@nvidia.com,
        dlemoal@kernel.org, gjoyce@linux.ibm.com
References: <20241016030339.54029-1-nilay@linux.ibm.com>
 <20241016030339.54029-3-nilay@linux.ibm.com>
 <a5908bbc-4230-460d-b814-a0b41d16a15d@grimberg.me>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <a5908bbc-4230-460d-b814-a0b41d16a15d@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aa9yj3l8lS_EwA-xAYcw9EZB-B7aveWi
X-Proofpoint-ORIG-GUID: aa9yj3l8lS_EwA-xAYcw9EZB-B7aveWi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410210085
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241021_045831_442834_38F24C23 
X-CRM114-Status: GOOD (  44.93  )
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



On 10/21/24 03:19, Sagi Grimberg wrote:
> Hey Nilay,
> 
> First, can you please phrase the patch title to describe what it
> is addressing, not what it is changing, that can come (as it does)
> in the body.
> 
sure, how about naming it as "nvme-fabrics: fix kernel crash while shutting down controller" ?

> Second, I don't think we want to spend a thread waiting for
> synchronous IO for the purpose of keep alive. Is this the only
> way that this can be done?
> 

> Third, was this observed with non-loop transports?
> 
Yes it could happen even with non-loop fabric transports.

> 
> On 16/10/2024 6:03, Nilay Shroff wrote:
>> The nvme keep-alive operation, which executes at a periodic interval,
>> could potentially sneak in while shutting down a fabric controller.
>> This may lead to a race between the fabric controller admin queue
>> destroy code path (invoked while shutting down controller) and hw/hctx
>> queue dispatcher called from the nvme keep-alive async request queuing
>> operation. This race could lead to the kernel crash shown below:
> 
> What is different about keep-alive than any other command?
The one difference is, of course, keep-alive is async but we may have
other async requests running while shutting down the controller. I found 
that, when compared the keep-alive with other commands, the keep-alive
runs in the worker thread context but other commands (for instance async 
read/write) runs in the user context and that uses the blk plugging. When we 
use plugging, the call path for issuing request to driver is quite different 
from that of issuing request using blk_execute_rq_nowait(). This subtle 
difference is probably the reason not causing the kernel crash issuing 
read/write command while shutting down the fabric controller.

The call path for blk plugging for issuing the request to driver:
__blk_flush_plug()
  -> blk_mq_flush_plug_list()
    ->blk_mq_dispatch_plug_list()

The blk_mq_dispatch_plug_list() first increments ->q_usage_counter before 
dispatching requests. Basically here the queue dispatcher (blk_mq_run_hw_queue 
function) is protected from the queue being destroyed on other cpu thread.
So that means that even after a request (assuming the only request in queue) 
is cancelled or flushed off due to fabric controller is shutting down, the 
blk-mq destroy code path would not be able to forward progress until the 
->q_usage_counter is decremented and becomes zero. And we can see in 
blk_mq_dispatch_plug_list() that it decrements ->q_usage_counter only after 
the blk_mq_run_hw_queue function returns. 
> 
>>
>> Call Trace:
>>      autoremove_wake_function+0x0/0xbc (unreliable)
>>      __blk_mq_sched_dispatch_requests+0x114/0x24c
>>      blk_mq_sched_dispatch_requests+0x44/0x84
>>      blk_mq_run_hw_queue+0x140/0x220
>>      nvme_keep_alive_work+0xc8/0x19c [nvme_core]
>>      process_one_work+0x200/0x4e0
>>      worker_thread+0x340/0x504
>>      kthread+0x138/0x140
>>      start_kernel_thread+0x14/0x18
> 
> What is the "crash" here? use-after-free?
yes it's use-after-free kernel crash.
> 
>>
>> While shutting down fabric controller, if nvme keep-alive request sneaks
>> in then it would be flushed off. The nvme_keep_alive_end_io function is
>> then invoked to handle the end of the keep-alive operation which
>> decrements the admin->q_usage_counter and assuming this is the last/only
>> request in the admin queue then the admin->q_usage_counter becomes zero.
>> If that happens then blk-mq destroy queue operation (blk_mq_destroy_
>> queue()) which could be potentially running simultaneously on another
>> cpu (as this is the controller shutdown code path) would forward
>> progress and deletes the admin queue. So, now from this point onward
>> we are not supposed to access the admin queue resources. However the
>> issue here's that the nvme keep-alive thread running hw/hctx queue
>> dispatch operation hasn't yet finished its work and so it could still
>> potentially access the admin queue resource while the admin queue had
>> been already deleted and that causes the above crash.
> 
> Again, it is unclear to me what justifies the cure here. Every command can
> race with the shutdown, and it can be sync or async.
> 
While I was researching on this issue, I figured that the nvme keep-alive is
probably the only async request running in worker thread context and not well 
synchronized with the fabric controller shutdown code path. Yes we may have other
async request (for instance async read/write) which might get-in the way of the 
fabric controller shutdown code path but those mostly run in the user context and
hence have a different code path than keep-alive command for submitting/queuing 
the request.

>>
>> This fix helps avoid the observed crash by implementing keep-alive as a
>> synchronous operation so that we decrement admin->q_usage_counter only
>> after keep-alive command finished its execution and returns the command
>> status back up to its caller (blk_execute_rq()). This would ensure that
>> fabric shutdown code path doesn't destroy the fabric admin queue until
>> keep-alive request finished execution and also keep-alive thread is not
>> running hw/hctx queue dispatch operation.
> 
> I'd want to see exactly what is causing this race because we already flush
> the keep alive work when starting the shutdown... so it only means it is
> incorrectly firing again?
> 
> What I think we should do instead, is given that we already cancel_sync the keep
> alive work before making progress with the teardown, we should just make sure
> that it doesn't triggered afterwards again if it does.

No, keep-alive doesn't incorrectly fired, however once a keep-alive request is 
allocated but before it's queued, if the shutdown code path come in its way and 
hence mark the queue as dying (i.e. setting QUEUE_FLAG_DYING on request-queue as 
well as clearing NVME_TCP_Q_LIVE in case of tcp transport or clearing NVME_LOOP_Q_LIVE
in case of loop transport) then this issue manifests. Let me briefly now show the 
place in the queue dispatcher code where we see this crash.

block layer code path (cpu 0):
blk_execute_rq_nowait()
  -> blk_mq_run_hw_queue()
    -> blk_mq_sched_dispatch_requests()
      -> __blk_mq_sched_dispatch_requests()
        -> blk_mq_do_dispatch_ctx()
          -> blk_mq_dispatch_rq_list()
            -> q->mq_ops->queue_rq()

As we see in the above trace, the function which is called to submit req to 
the driver is ->queue_rq(). Assuming we've async keep-alive request queued 
just after the request-queue has been marked as dying, the driver would not 
process this request but instead fails that request: 

loop driver call path for failed request(cpu 0):
nvme_loop_queue_rq()
  -> nvme_fail_nonready_command()
    -> nvme_host_path_error()
      -> nvme_complete_rq() 
        -> nvme_end_req()
          -> blk_mq_end_request()
            -> __blk_mq_end_request()
              -> nvme_keep_alive_end_io() 
                -> blk_mq_free_request() <<< here we decrement the ->q_usage_counter

Assuming the keep-alive is the only command in the queue, nvme_keep_alive_end_io()
decrements ->q_usage_counter in the above code path and hence now ->q_usage_counter
reaches to zero. At this time the shutdown code path, which could be potentially running 
on another cpu thread and is waiting for ->q_usage_counter to become zero, would now 
forward progress and deletes the queue. Please see below:

fabric controller shutdown code path (cpu 1):
nvme_remove_admin_tag_set()
  -> blk_mq_destroy_queue() 
    -> blk_mq_freeze_queue_wait() <<< here we wait for ->q_usage_counter to become zero

If the ->q_usage_counter becomes zero, the above code forward progress. So now the 
blk_mq_destroy_queue function next invokes blk_put_queue() which would delete the 
admin queue. 

Referring back to the loop diver call path, running on cpu 0, would now return back 
to the block layer. The block layer hasn't yet finished the dispatcher work and it
returns back to blk_mq_dispatch_rq_list(). The blk_mq_dispatch_rq_list() as well as 
its caller blk_mq_do_dispatch_ctx() running dispatcher code could still access the 
@hctx, however this @hctx had been already deleted on another cpu (under the controller 
shutdown code path as described above) and that cause the kernel crash. 

I hope that above description shall help with understanding the root cause. But please 
let me know if still have any further question.

Thanks,
--Nilay

