Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F535D2C54B
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Oct 2024 13:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gXaXEQR71KfHIy6a5Km44M6/58VBVjn8H+aK8pKdT0Y=; b=KwN9sQ818PWcdd//cQg4Y/eGx3
	+GLsO3WTdJ2liribqgzmvIL/yZdm8abuHxOLZJ2MP5/n85s7HhcqbdL0rUXshSt08AFsF0FVw4XEn
	aveSedLZ49ZxpduhjQoV6yQp4x49HQ1StkaIo9MStkisO4JSJzmzppYJUdzOMpJSqBZein3pj+2UU
	lxJLRpMjKYsCEjbupov220Vpv/A6OmCk+d6Q40Q8e1ET5VcRsX9CHXX/qkKq7Lc7NaMbpuW5+VUBK
	8a22WXGdCYQcd3Dfwawg/hqBPatVZXeKmka5RElUwU0jBagTMW9RhhYUFVFbEHUjBFgh6AON+Z3Hk
	Pdimw8yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3Ewg-0000000AxBp-3V9h;
	Tue, 22 Oct 2024 13:29:10 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3Ewd-0000000AxBC-0yPW
	for linux-nvme@lists.infradead.org;
	Tue, 22 Oct 2024 13:29:09 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49M2HIWI009445;
	Tue, 22 Oct 2024 13:28:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gXaXEQ
	R71KfHIy6a5Km44M6/58VBVjn8H+aK8pKdT0Y=; b=k6HIyvUANeIh9buGog7tWz
	fq2blMIU5odbB323Dt1fkCMVwUArVFER9vO7c9urhvRuaqLWbgiOLDYdfTXDwmRF
	yBJKypd0h/fiE56qWZ0DU5DY2xaej1kB5qwVNmti11HOSPRf5y7jo8QDZlFrs1sq
	9qpaE3JaoBUQkqNcg3wx3QqcB3ubr7EkIU5as/dJjFiTq1atw+eeZk8dsjLyZbDA
	rlrtw587yq+i9sGEbBm6rRd7BmmIAB3D+kEobnL25fbzPo6s3INbzlYWDUeKDnoV
	FY3nUNPHczDJz9jlYxTbI1XeiLf0QWLm+/so9ugj1G7NsEY2t7n9Vcxy+q7nJzHA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5hmeu8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 13:28:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49MAbQBW018655;
	Tue, 22 Oct 2024 13:28:52 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42csajb43b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 13:28:52 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49MDSpNc8061690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 13:28:52 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BD935805D;
	Tue, 22 Oct 2024 13:28:51 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C20A858057;
	Tue, 22 Oct 2024 13:28:48 +0000 (GMT)
Received: from [9.171.22.189] (unknown [9.171.22.189])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Oct 2024 13:28:48 +0000 (GMT)
Message-ID: <f584d0da-7329-41e0-9976-b76f244e47fd@linux.ibm.com>
Date: Tue, 22 Oct 2024 18:58:47 +0530
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
 <b03863b2-8816-48cd-aa18-436f1c49ec8c@linux.ibm.com>
 <cf53da15-ed73-4aa9-9f0a-46202529f0a7@grimberg.me>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <cf53da15-ed73-4aa9-9f0a-46202529f0a7@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rDvKr-c9oQn5Ah5qCgXAXCDiZNCJAGOk
X-Proofpoint-GUID: rDvKr-c9oQn5Ah5qCgXAXCDiZNCJAGOk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 phishscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410220085
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241022_062907_523341_D2A2E80E 
X-CRM114-Status: GOOD (  64.27  )
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



On 10/22/24 15:13, Sagi Grimberg wrote:
> 
> 
> 
> On 22/10/2024 9:54, Nilay Shroff wrote:
>>
>> On 10/21/24 20:44, Sagi Grimberg wrote:
>>>
>>>
>>> On 21/10/2024 14:58, Nilay Shroff wrote:
>>>> On 10/21/24 03:19, Sagi Grimberg wrote:
>>>>> Hey Nilay,
>>>>>
>>>>> First, can you please phrase the patch title to describe what it
>>>>> is addressing, not what it is changing, that can come (as it does)
>>>>> in the body.
>>>>>
>>>> sure, how about naming it as "nvme-fabrics: fix kernel crash while shutting down controller" ?
>>>>
>>>>> Second, I don't think we want to spend a thread waiting for
>>>>> synchronous IO for the purpose of keep alive. Is this the only
>>>>> way that this can be done?
>>>>>
>>>>> Third, was this observed with non-loop transports?
>>>>>
>>>> Yes it could happen even with non-loop fabric transports.
>>>>
>>>>> On 16/10/2024 6:03, Nilay Shroff wrote:
>>>>>> The nvme keep-alive operation, which executes at a periodic interval,
>>>>>> could potentially sneak in while shutting down a fabric controller.
>>>>>> This may lead to a race between the fabric controller admin queue
>>>>>> destroy code path (invoked while shutting down controller) and hw/hctx
>>>>>> queue dispatcher called from the nvme keep-alive async request queuing
>>>>>> operation. This race could lead to the kernel crash shown below:
>>>>> What is different about keep-alive than any other command?
>>>> The one difference is, of course, keep-alive is async but we may have
>>>> other async requests running while shutting down the controller. I found
>>>> that, when compared the keep-alive with other commands, the keep-alive
>>>> runs in the worker thread context but other commands (for instance async
>>>> read/write) runs in the user context and that uses the blk plugging. When we
>>>> use plugging, the call path for issuing request to driver is quite different
>>>> from that of issuing request using blk_execute_rq_nowait(). This subtle
>>>> difference is probably the reason not causing the kernel crash issuing
>>>> read/write command while shutting down the fabric controller.
>>>>
>>>> The call path for blk plugging for issuing the request to driver:
>>>> __blk_flush_plug()
>>>>     -> blk_mq_flush_plug_list()
>>>>       ->blk_mq_dispatch_plug_list()
>>>>
>>>> The blk_mq_dispatch_plug_list() first increments ->q_usage_counter before
>>>> dispatching requests. Basically here the queue dispatcher (blk_mq_run_hw_queue
>>>> function) is protected from the queue being destroyed on other cpu thread.
>>>> So that means that even after a request (assuming the only request in queue)
>>>> is cancelled or flushed off due to fabric controller is shutting down, the
>>>> blk-mq destroy code path would not be able to forward progress until the
>>>> ->q_usage_counter is decremented and becomes zero. And we can see in
>>>> blk_mq_dispatch_plug_list() that it decrements ->q_usage_counter only after
>>>> the blk_mq_run_hw_queue function returns.
>>> Sounds like an issue that is not related to keep-alive at all.
>>>
>>>>>> Call Trace:
>>>>>>        autoremove_wake_function+0x0/0xbc (unreliable)
>>>>>>        __blk_mq_sched_dispatch_requests+0x114/0x24c
>>>>>>        blk_mq_sched_dispatch_requests+0x44/0x84
>>>>>>        blk_mq_run_hw_queue+0x140/0x220
>>>>>>        nvme_keep_alive_work+0xc8/0x19c [nvme_core]
>>>>>>        process_one_work+0x200/0x4e0
>>>>>>        worker_thread+0x340/0x504
>>>>>>        kthread+0x138/0x140
>>>>>>        start_kernel_thread+0x14/0x18
>>>>> What is the "crash" here? use-after-free?
>>>> yes it's use-after-free kernel crash.
>>>>>> While shutting down fabric controller, if nvme keep-alive request sneaks
>>>>>> in then it would be flushed off. The nvme_keep_alive_end_io function is
>>>>>> then invoked to handle the end of the keep-alive operation which
>>>>>> decrements the admin->q_usage_counter and assuming this is the last/only
>>>>>> request in the admin queue then the admin->q_usage_counter becomes zero.
>>>>>> If that happens then blk-mq destroy queue operation (blk_mq_destroy_
>>>>>> queue()) which could be potentially running simultaneously on another
>>>>>> cpu (as this is the controller shutdown code path) would forward
>>>>>> progress and deletes the admin queue. So, now from this point onward
>>>>>> we are not supposed to access the admin queue resources. However the
>>>>>> issue here's that the nvme keep-alive thread running hw/hctx queue
>>>>>> dispatch operation hasn't yet finished its work and so it could still
>>>>>> potentially access the admin queue resource while the admin queue had
>>>>>> been already deleted and that causes the above crash.
>>>>> Again, it is unclear to me what justifies the cure here. Every command can
>>>>> race with the shutdown, and it can be sync or async.
>>>>>
>>>> While I was researching on this issue, I figured that the nvme keep-alive is
>>>> probably the only async request running in worker thread context and not well
>>>> synchronized with the fabric controller shutdown code path. Yes we may have other
>>>> async request (for instance async read/write) which might get-in the way of the
>>>> fabric controller shutdown code path but those mostly run in the user context and
>>>> hence have a different code path than keep-alive command for submitting/queuing
>>>> the request.
>>> This sounds like we papered around the problem. is it not allowed to call blk_execute_rq_nowait
>>> from a kthread?
>> I didn't meant calling blk_execute_rq_nowait is not allowed from kthread. It's allowed
>> but the side effect it causes is what I just wanted to highlight.
> 
> The point is that any kthread using it would potentially trigger this bug. Hence we should
> treat the disease and not the symptom.
> 
>>>>>> This fix helps avoid the observed crash by implementing keep-alive as a
>>>>>> synchronous operation so that we decrement admin->q_usage_counter only
>>>>>> after keep-alive command finished its execution and returns the command
>>>>>> status back up to its caller (blk_execute_rq()). This would ensure that
>>>>>> fabric shutdown code path doesn't destroy the fabric admin queue until
>>>>>> keep-alive request finished execution and also keep-alive thread is not
>>>>>> running hw/hctx queue dispatch operation.
>>>>> I'd want to see exactly what is causing this race because we already flush
>>>>> the keep alive work when starting the shutdown... so it only means it is
>>>>> incorrectly firing again?
>>>>>
>>>>> What I think we should do instead, is given that we already cancel_sync the keep
>>>>> alive work before making progress with the teardown, we should just make sure
>>>>> that it doesn't triggered afterwards again if it does.
>>>> No, keep-alive doesn't incorrectly fired, however once a keep-alive request is
>>>> allocated but before it's queued,
>>> The queue teardown quiesce the admin queue first, which should prevent the dispatch.
>>> You probably mean that it runs a little later, after the dispatch passes the quiesced test...
>>>
>>> The question is, why did blk_mq_quiesce_queue did not wait for rcu grace? which should
>>> have ensured that there is no dispatch going on? at least that is what it's supposed to do...
>>> something doesn't add up
>>>
>> This issue manifests when the keep-alive command sneaks in after the admin queue is
>> unquiesced but before its freezed.
>>
>> nvme_unquiesce_admin_queue() <<< we unquiesce admin queue
>>
>> <<< here keep-alive sneaks in and it starts running dispatcher
>>
>> nvme_remove_admin_tag_set()  <<< we freeze queue and wait for ->q_usage_counter to become zero
>>
>> So as mentioned above, we have time window between queue unquiesce and freeze
>> operations where async keep-alive could potentially sneaks in and causing the
>> observed symptom.
> 
> The problem here is that keep-alive should not be able to sneak in after we unquiescence
> the admin queue.
> 
> What I'm seeing in the code is that the teardown flow does not call nvme_stop_keep_alive()
> in the teardown path.
> 
> This seems to be caused by [1], so it makes sense that we can even trigger this race.
> If nvme_stop_keep_alive would have been called from nvme_stop_ctrl() which is called
> way before we quiesce/unquiesce the queue, then this issue would not have been encountered.
> 
> I think we could make an argument that both call-sites to nvme_stop_keep_alive() should co-exist
> with a little documentation to why.
> Can you try and reproduce with [2]?
> 
> 
> [1]:
> -- 
> commit a54a93d0e3599b05856971734e15418ac551a14c
> Author: Ming Lei <ming.lei@redhat.com>
> Date:   Tue Aug 13 09:35:27 2024 +0800
> 
>     nvme: move stopping keep-alive into nvme_uninit_ctrl()
> 
>     Commit 4733b65d82bd ("nvme: start keep-alive after admin queue setup")
>     moves starting keep-alive from nvme_start_ctrl() into
>     nvme_init_ctrl_finish(), but don't move stopping keep-alive into
>     nvme_uninit_ctrl(), so keep-alive work can be started and keep pending
>     after failing to start controller, finally use-after-free is triggered if
>     nvme host driver is unloaded.
> 
>     This patch fixes kernel panic when running nvme/004 in case that connection
>     failure is triggered, by moving stopping keep-alive into nvme_uninit_ctrl().
> 
>     This way is reasonable because keep-alive is now started in
>     nvme_init_ctrl_finish().
> 
>     Fixes: 3af755a46881 ("nvme: move nvme_stop_keep_alive() back to original position")
>     Cc: Hannes Reinecke <hare@suse.de>
>     Cc: Mark O'Donovan <shiftee@posteo.net>
>     Reported-by: Changhui Zhong <czhong@redhat.com>
>     Reviewed-by: Christoph Hellwig <hch@lst.de>
>     Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>     Reviewed-by: Hannes Reinecke <hare@suse.de>
>     Signed-off-by: Ming Lei <ming.lei@redhat.com>
>     Signed-off-by: Keith Busch <kbusch@kernel.org>
> -- 
> 
> This patch was introduced as a fix for:
> 3af755a46881 ("nvme: move nvme_stop_keep_alive() back to original position")
> 
> [2]:
> -- 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 0dc8bcc664f2..275af23dda6d 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4612,6 +4612,11 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
>  {
>         nvme_mpath_stop(ctrl);
>         nvme_auth_stop(ctrl);
> +       /*
> +        * the transport driver may be terminating the admin tagset a little
> +        * later on, so we cannot have the keep-alive work running
> +        */
> +       nvme_stop_keep_alive(ctrl);
>         nvme_stop_failfast_work(ctrl);
>         flush_work(&ctrl->async_event_work);
>         cancel_work_sync(&ctrl->fw_act_work);
> -- 
> 
I tried the above patch[2] and ran nvme/037 in a loop for quite a long time and 
confirmed that with this change I don't see the kernel crash. So I think we shall 
restore the above change. 

Also please note that the earlier changes where we made keep-alive synchronous 
operation has been already merged to the mainline/Linus' kernel tree. So should we 
create a new patch reverting the changes merged in commit d06923670b5a ("nvme: 
make keep-alive synchronous operation") and then on top of it add the above 
patch[2]? 

Moreover, I would adjust the new patch so that we can keep this change 599d9f3a10ee 
("nvme: use helper nvme_ctrl_state in nvme_keep_alive_finish function"). I think 
changes implemented in commit 599d9f3a10ee is a logical step forward to avoid using 
ctrl->lock and instead use helper nvme_ctrl_state for retrieving the controller state. 

What do you suggest? 

Thanks,
--Nilay

