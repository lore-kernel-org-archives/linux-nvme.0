Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDAF0E6896E
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2024 10:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OMI3w6tnLCObufvpvWUHkSZ7UxlTPW3dYk/wP9zfDpQ=; b=4VFuOZIXCDJIIz+rFZfP90YGNu
	hDgY9Bq7ATfspIz7l72Uky+mgjFg1a6sOnOIWja5CGl75JsVYD8nJx/zQMfriNIweEqPUhtfkAtH0
	HlYXZe25LBYy10KAtSBIsX07ZnumFt08mS4ocs4ZUc224B4nyCaFxK4yAMdRYxh7h0GdUL/ieR/FD
	Fc2IeRAguMNkkjmEYe4tPPsfq+BqhWNd0YRZWrGtxSgHqIb/K7NreDtEZ2LMW/z1KzkoCj0zPgU2+
	MGUIjzWW+YCs3za9zZwBtZVEg5P7A0Nz5fJMXDWkOkQzPNgTL0dSq/HFQ1T8Qs8IDkEOXvh4/vIQu
	2E6aiw2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6SA9-00000003Bzr-1NcG;
	Thu, 31 Oct 2024 10:12:21 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6S92-00000003Btd-17MV
	for linux-nvme@lists.infradead.org;
	Thu, 31 Oct 2024 10:11:13 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49V2iqD4012551;
	Thu, 31 Oct 2024 10:10:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OMI3w6
	tnLCObufvpvWUHkSZ7UxlTPW3dYk/wP9zfDpQ=; b=chEBxVO4y7v6x+M8INMbDC
	cAUo60iT4B9pBYfv+NttIFRDXFdYDNjhJ5nnB8CgaI3J1o/cpylMD81crXiIFt70
	2/Z4cDAf/GhFRnQ14qLi81D7WHfbu/t70evbuyYrUO9iEUy+dlF+tYG65YaUmBKr
	5ghA8SDffRX6PrtzmGDztsDwzRctThrJ73cHDBR/iw/XhHL3Km3q8n/M5wO9EZaj
	vFjE1O32dmPRseEje1+93VHFwFjvKuOSrIODHL4kfiL+LozVctA1QNjgMd4p+4ST
	SDNWYrprKtBrSNqd29gGC5feOO9G5Sz/LJoJ4ZfrUt2K4Ljw9jZhR+Xpbryyea9g
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42j3nt46wn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2024 10:10:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49V9eScK018383;
	Thu, 31 Oct 2024 10:10:56 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42hc8kc9hj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2024 10:10:55 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49VAAtSr58917368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Oct 2024 10:10:55 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2561658059;
	Thu, 31 Oct 2024 10:10:55 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 867C758043;
	Thu, 31 Oct 2024 10:10:52 +0000 (GMT)
Received: from [9.179.8.243] (unknown [9.179.8.243])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 31 Oct 2024 10:10:52 +0000 (GMT)
Message-ID: <1a21f37b-0f2a-4745-8c56-4dc8628d3983@linux.ibm.com>
Date: Thu, 31 Oct 2024 15:40:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nvme-fabrics: fix kernel crash while shutting down
 controller
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, axboe@fb.com, chaitanyak@nvidia.com,
        dlemoal@kernel.org, gjoyce@linux.ibm.com
References: <20241027170209.440776-1-nilay@linux.ibm.com>
 <20241027170209.440776-3-nilay@linux.ibm.com> <ZyCNiuYQw7_7IzJb@fedora>
 <ff8baedc-3aa9-4277-8753-282f3744ae2b@linux.ibm.com>
 <ZyGX8jCZVXwbhI89@fedora>
 <aca10f02-2c64-4ad8-867a-e226d6d61a80@linux.ibm.com>
 <ZyIr47G6PutvB7WW@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <ZyIr47G6PutvB7WW@fedora>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: T1nhkQzrB5mEmRq_idxsuFa-Ei6w40mA
X-Proofpoint-GUID: T1nhkQzrB5mEmRq_idxsuFa-Ei6w40mA
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410310074
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241031_031112_360402_62AD645E 
X-CRM114-Status: GOOD (  36.11  )
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



On 10/30/24 18:21, Ming Lei wrote:
> On Wed, Oct 30, 2024 at 04:08:16PM +0530, Nilay Shroff wrote:
>>
>>
>> On 10/30/24 07:50, Ming Lei wrote:
>>> On Tue, Oct 29, 2024 at 06:10:00PM +0530, Nilay Shroff wrote:
>>>>
>>>>
>>>> On 10/29/24 12:53, Ming Lei wrote:
>>>>> On Sun, Oct 27, 2024 at 10:32:05PM +0530, Nilay Shroff wrote:
>>>>>> The nvme keep-alive operation, which executes at a periodic interval,
>>>>>> could potentially sneak in while shutting down a fabric controller.
>>>>>> This may lead to a race between the fabric controller admin queue
>>>>>> destroy code path (invoked while shutting down controller) and hw/hctx
>>>>>> queue dispatcher called from the nvme keep-alive async request queuing
>>>>>> operation. This race could lead to the kernel crash shown below:
>>>>>>
>>>>>> Call Trace:
>>>>>>     autoremove_wake_function+0x0/0xbc (unreliable)
>>>>>>     __blk_mq_sched_dispatch_requests+0x114/0x24c
>>>>>>     blk_mq_sched_dispatch_requests+0x44/0x84
>>>>>>     blk_mq_run_hw_queue+0x140/0x220
>>>>>>     nvme_keep_alive_work+0xc8/0x19c [nvme_core]
>>>>>>     process_one_work+0x200/0x4e0
>>>>>>     worker_thread+0x340/0x504
>>>>>>     kthread+0x138/0x140
>>>>>>     start_kernel_thread+0x14/0x18
>>>>>>
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
>>>>>>
>>>>>> The above kernel crash is regression caused due to changes implemented
>>>>>> in commit a54a93d0e359 ("nvme: move stopping keep-alive into
>>>>>> nvme_uninit_ctrl()"). Ideally we should stop keep-alive at the very
>>>>>> beggining of the controller shutdown code path so that it wouldn't
>>>>>> sneak in during the shutdown operation. However we removed the keep
>>>>>> alive stop operation from the beginning of the controller shutdown
>>>>>> code path in commit a54a93d0e359 ("nvme: move stopping keep-alive into
>>>>>> nvme_uninit_ctrl()") and that now created the possibility of keep-alive
>>>>>> sneaking in and interfering with the shutdown operation and causing
>>>>>> observed kernel crash. So to fix this crash, now we're adding back the
>>>>>> keep-alive stop operation at very beginning of the fabric controller
>>>>>> shutdown code path so that the actual controller shutdown opeation only
>>>>>> begins after it's ensured that keep-alive operation is not in-flight and
>>>>>> also it can't be scheduled in future.
>>>>>>
>>>>>> Fixes: a54a93d0e359 ("nvme: move stopping keep-alive into nvme_uninit_ctrl()")
>>>>>> Link: https://lore.kernel.org/all/196f4013-3bbf-43ff-98b4-9cb2a96c20c2@grimberg.me/#t
>>>>>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>>>>>> ---
>>>>>>  drivers/nvme/host/core.c | 5 +++++
>>>>>>  1 file changed, 5 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>>>>> index 5016f69e9a15..865c00ea19e3 100644
>>>>>> --- a/drivers/nvme/host/core.c
>>>>>> +++ b/drivers/nvme/host/core.c
>>>>>> @@ -4648,6 +4648,11 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
>>>>>>  {
>>>>>>  	nvme_mpath_stop(ctrl);
>>>>>>  	nvme_auth_stop(ctrl);
>>>>>> +	/*
>>>>>> +	 * the transport driver may be terminating the admin tagset a little
>>>>>> +	 * later on, so we cannot have the keep-alive work running
>>>>>> +	 */
>>>>>> +	nvme_stop_keep_alive(ctrl);
>>>>>>  	nvme_stop_failfast_work(ctrl);
>>>>>>  	flush_work(&ctrl->async_event_work);
>>>>>>  	cancel_work_sync(&ctrl->fw_act_work);
>>>>>
>>>>> The change looks fine.
>>>>>
>>>>> IMO the `nvme_stop_keep_alive` in nvme_uninit_ctrl() may be moved to
>>>>> entry of nvme_remove_admin_tag_set(), then this one in nvme_stop_ctrl()
>>>>> can be saved?
>>>>>
>>>> Yes that should work however IMO, stopping keep-alive at very beginning of
>>>> shutdown operation would make sense because delaying the stopping of keep-alive 
>>>> would not be useful anyways once we start the controller shutdown. It may
>>>> sneak in unnecessarily while we shutdown controller and later we will have to 
>>>> flush it off.
>>>>
>>>> And yes, as you mentioned, in this case we would save one call site but 
>>>> looking at the code we have few other call sites already present where we
>>>> call nvme_stop_keep_alive().
>>>
>>> If it works, I'd suggest to move nvme_stop_keep_alive() from
>>> nvme_uninit_ctrl() into nvme_remove_admin_tag_set() because:
>>>
>>> 1) it isn't correct to do it in nvme_uninit_ctrl()
>>>
>>> 2) stop keep alive in nvme_remove_admin_tag_set() covers everything
>>>
>>> 3) most of nvme_stop_keep_alive() can be removed in failure path
>>>
>>
>> Moving nvme_stop_keep_alive() from nvme_uninit_ctrl() to nvme_remove_admin_
>> tag_set() works, I tested it with blktest nvme/037. However, I am afraid 
>> that we may not be able to remove most of nvme_stop_keep_alive() from the
>> failure/recovery code path. The reason being, in most of the failure/recovery
>> code path we don't invoke nvme_remove_admin_tag_set(). 
>>
>> For instance, in case of nvme_tcp_error_recovery_work(), the nvme_remove_
>> admin_tag_set() is not invoked and we explicitly call nvme_stop_keep_alive(). 
>> The same is true for error recovery case of nvme rdma.
>>
>> Another example when nvme_tcp_setup_ctrl fails, we don't call nvme_remove_
>> admin_tag_set() but we explicitly call the nvme_stop_keep_alive(). 
>>
>> Third example while resetting tcp/rdam ctrl, we don't call nvme_remove_admin_
>> tag_set() but we explicitly call the nvme_stop_keep_alive().
> 
> If nvme_remove_admin_tag_set() isn't called, do we really need to call
> nvme_stop_keep_alive() in the failure path?
> 
During tcp/rdma error recovery we first stop keep-alive and later keep-alive is 
restarted when connection to the fabric controller is restored.
IMO that makes sense as if the connection to the fabric controller is down then 
do we really need keep-alive to be running? I think we don't need to let keep-alive 
running in this case. So in error recovery path we first stop keep-alive and then 
later when the connection to fabric controller is restored we again restart the 
keep-alive. 
>>
>> In your first point above, you mentioned that calling nvme_stop_keep_alive()
>> from nvme_uninit_ctrl() isn't correct, would you please explain why is it so, 
>> considering fact that we call nvme_start_keep_alive() from nvme_init_ctrl_
>> finish()?
> 
> nvme_uninit_ctrl() is usually run after nvme_remove_admin_tag_set(), when the
> admin queue is destroyed and tagset is freed.
> 
OK understood. I will update the current patch and move nvme_stop_keep_alive()
from nvme_uninit_ctrl() to nvme_remove_admin_tag_set(). So with this change 
we could save at-least one call site of nvme_stop_keep_alive(). 

Thanks,
--Nilay

