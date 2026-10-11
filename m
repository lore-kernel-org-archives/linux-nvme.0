Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA742CA9ECC
	for <linux-nvme@archiver.kernel.org>; Sun, 11 Oct 2026 20:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KaWSej0c/fpIBPSkYQUDhE+fWImBwHQOzaac9Gu2R6Q=; b=f+a1H8hsjb2stNcDtjqQEOM8eh
	r9H/C7vgyx/PQYL/2EyePtOvR+CwM/rLIruWpU6zJGsA5NoNlBCMFlOsoUmG6Cz1VQvYuELS2AJWc
	t8nprrGJinvZEdLqlT4+Q7EdqtHgY4m3kJe0PThkU5oz/t7BiOevgN0B1FN5ZqMWxxeMyW0U+0odT
	PJXsAv7RBg/RVSsH9VQcupZYiPu44SN9O9p2Xi1IEaFj8wLF04ZIba6BN2enFESzJ6ottnCNZurlb
	tl6O2bdhCLgqofz03fGLSwaOF1NLuxZlCSAd/U+DvVf59tIeWm4TyyigQrwxX62XjaPascRSxoo35
	XtvNf3oQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xG09g-00000009OHn-41sj;
	Sun, 11 Oct 2026 20:28:24 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xG09Z-00000009OHM-2VWA
	for linux-nvme@lists.infradead.org;
	Sun, 11 Oct 2026 20:28:20 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69BIiU5D2155493;
	Sun, 11 Oct 2026 20:27:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KaWSej
	0c/fpIBPSkYQUDhE+fWImBwHQOzaac9Gu2R6Q=; b=iPDJ/yX8hrfmaq4KUNqd3R
	/SMil3AfnI1wJ7T1QBcCZYBBNhdma8POSFOmbj/AvebD4Kde+XDeXfjxoEU0E+Os
	PIQfjZdZ5hB8EZCQCgZTN1akKG9UX4v1cZuMKbZTPYV219Icmj7CpTcbvewjqA7v
	Fd4LEPfmKz+FN9JO+K0U6J9+uoVG4yfzVLdIO424+jmA/IAJvRhKfIUyK+1vqukX
	Zb5Cwa17cyCXJqXVY2B+ech/fKHPGLcd1rSUKNRdtLLU5J4EP9W6pxPDpiKUQ171
	aeRbPmYglta7f4RYjTS0rAVegtvIGFrKuOcbgQtzxHY/+RaZ2oLcYawjHWkv9JOA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv361dv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 11 Oct 2026 20:27:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69BIK1F7129926;
	Sun, 11 Oct 2026 20:27:53 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h82cyaay1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 11 Oct 2026 20:27:53 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69BKRrtS20447844
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 11 Oct 2026 20:27:53 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3BB45805F;
	Sun, 11 Oct 2026 20:27:52 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 232E258054;
	Sun, 11 Oct 2026 20:27:49 +0000 (GMT)
Received: from [9.61.185.118] (unknown [9.61.185.118])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 11 Oct 2026 20:27:48 +0000 (GMT)
Message-ID: <e3bd727d-869b-470d-84dc-fccae61ca499@linux.ibm.com>
Date: Mon, 12 Oct 2026 01:57:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] nvme-tcp: allow setting per-queue io_cpu through
 sysfs
To: Saravanan D <saravanand@crusoe.ai>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, axboe@kernel.dk, dwagner@suse.de,
        linux-kernel@vger.kernel.org, iyamahata@crusoe.ai, kiyer@crusoe.ai,
        ganbalagane@crusoe.ai, sjpark@crusoe.ai
References: <20260927070925.47209-1-saravanand@crusoe.ai>
 <20260927070925.47209-3-saravanand@crusoe.ai>
 <51a451fe-fdf6-4e8f-afbd-c595f3c6de2c@linux.ibm.com>
 <20261009020145.64651-1-saravanand@crusoe.ai>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261009020145.64651-1-saravanand@crusoe.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kQjN2QIgKXCAJ9EReS73ClyZOoldIxoq
X-Proofpoint-ORIG-GUID: kQjN2QIgKXCAJ9EReS73ClyZOoldIxoq
X-Authority-Analysis: v=2.4 cv=aqInmiZV c=1 sm=1 tr=0 ts=6acbf14a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=nEC4cdWnxhRHzP_wYSQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDExMDA4MCBTYWx0ZWRfX95y/qGX2zL1Z
 DhPgi82czAicjAnlv8Yx+pl+7LctAbEXb/vjNfdC3x9E1c/7VJ/aFGI1WI4hufoMsTkOMN3m0q6
 udn0Q/Aevr6Z//n4prRtTEMm5xA4eDg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDExMDA4MCBTYWx0ZWRfX6hX2K52B73b9
 9iES/7ZkG2vHGskeE+m2LziSxnsUntzz81Nmkxma3B7Reuh8lBScK2CCqZpOuW02yJfY7SWBF8U
 pWjoRLvtBb3Xk02SKqIzwHApe/kerOdcdXjO9m4TuUz5QQAeb+2OVbSbfpXPQ7nvzz9eBe0mryZ
 Ds4o62puNKe6hwONQwjyWFYcbj9NORgAsu/yGJCvYunLGToxjrtyNDzweDWUfV+8SgNzu871z8W
 YHmUA7LHFlan5tyGeVjhsED62rpkGCUpIFQAOwWiEMpokJETn+6qwYUtu/mQ7yNIKx2W7/j11iU
 UpgBSuCWb8FOSri3c2/U9LsmYAaLWkHRj31uw4uDpM0/MMDrqEo76EaS3b+ZzGVY/KU4l4PqdFF
 Z1+mMpjD2Jj2lHWtb6HREE5Z7LmjAHSHHkCgmegsG9iA0idrs+7uu8uXUlRDvGF6FMNZn3eB/N7
 esCUkNMi1b9jOY6ATkg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-11_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610110080
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261011_132817_667073_C2F1FF08 
X-CRM114-Status: GOOD (  51.18  )
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

On 10/9/26 7:31 AM, Saravanan D wrote:
> On 10/8/26 2:45 AM, Nilay Shroff wrote:
> [...]
>>> The queue directories register on the first connect and persist while
>>> the queues cycle across reconnects, so a write can arrive while a
>>> queue is torn down. The io_cpu changes and their accounting therefore
>>> serialize under a controller level lock rather than the queue lock,
>>> which is destroyed with the queue, and the controller teardown waits
>>> for the last kobject release before the queue array is freed.
>>>
>> I understand based on your requirement you may want to persist io_cpu
>> changes (when managed by user) during controller reconnect. However
>> in case num of queues changes after reconnect (assume it's 32 at first
>> connect but after controller reconnects it's reduced to 16) keeping
>> those 32 queues entries under queues/<qid>/ looks bit odd and not
>> correct. I'd expect queues entries under queue/<qid>/ to be also
>> adjusted based on the controller queue count.
> 
> Agreed. In v5 the queue directory follows the queue's connected
> lifetime. nvme_tcp_alloc_queue() adds it and nvme_tcp_free_queue()
> removes it, so queues/<qid>/ matches the queue count after every
> reconnect, as blk-mq does for mq/<n> when nr_hw_queues changes. A user
> assigned io_cpu is kept in the nvme_tcp_queue, which persists across
> reconnects, so it applies again when the queue comes back. A write
> while the controller is reconnecting fails with ENOENT.
> 
> [...]
>>> @@ -171,6 +173,11 @@ struct nvme_tcp_ctrl {
>>>    	struct delayed_work	connect_work;
>>>    	struct nvme_tcp_request async_req;
>>>    	u32			io_queues[HCTX_MAX_TYPES];
>>> +	/* serializes io_cpu changes and their nvme_tcp_cpu_queues accounting */
>>> +	struct mutex		io_cpu_lock;
>>
>> The io_cpu_lock protect updates to queue->io_cpu and as we now support clang
>> context annotations for NVMe host driver, I'd suggest you annotate the
>> queue->io_cpu with __guarded_by(...) so that clang context analyzer can
>> validate each access to queue->io_cpu. Furthermore, I see that queue->io_cpu
>> could be concurrently accessed from both control path and I/O hotpath. So how
>> would we protect it while it's being accessed from I/O path and concurrently
>> updated from sysfs path?
> 
> The I/O path reads io_cpu without the lock by design, and a stale read
> is benign. Each queue_work_on() call reads io_cpu once, so a call that
> races with the store queues io_work on the old cpu one last time and
> later calls use the new one. io_work is a single work item, so it
> never runs on both cpus at once. The inline send in
> nvme_tcp_queue_request() only compares io_cpu with the current cpu and
> is serialized by send_mutex. v5 marks the lockless reads with
> READ_ONCE() and the writes with WRITE_ONCE().
> 
> Annotating io_cpu with __guarded_by(&ctrl->io_cpu_lock) would need
> context_unsafe() around each of those hot path reads, so I'd rather
> document the lockless readers next to the field. Happy to add the
> annotation if you prefer it.

Yes, reading io_cpu locklessly in the I/O hot path is intentional. However,
to avoid KCSAN splat, we should mark read and write access with READ_ONCE()
and WRITE_ONCE() respectively.

Unfortunately, the Clang context analyzer cannot currently model a lock that
serializes writers while allowing readers to access the protected variable
without holding that lock. Annotating io_cpu with __guarded_by() would therefore
require us to annotate lockless reads with context_unsafe() or data_race(),
which I think we'd prefer to avoid.

I suggest introducing two helpers: one to read io_cpu and another to update it:

static inline int nvme_tcp_queue_io_cpu(struct nvme_tcp_queue *queue)
{
	return READ_ONCE(queue->io_cpu);
}

static inline void nvme_tcp_queue_change_io_cpu(struct nvme_tcp_queue *queue,
		int cpu)
	__must_hold(&queue->ctrl->io_cpu_lock)
{
	WRITE_ONCE(queue->io_cpu, cpu);
}

All readers could then access queue->io_cpu through nvme_tcp_queue_io_cpu(),
while all writes would go through nvme_tcp_queue_change_io_cpu(). The __must_hold()
annotation on the update helper would allow the Clang context analyzer to verify
that callers hold io_cpu_lock when modifying io_cpu, without requiring annotations
for the intentional lockless reads.

> 
>>> +	unsigned int		nr_queue_infos;
>>> +	atomic_t		qinfo_refs;
>>> +	struct completion	qinfo_release;
>>>    };
>>
>> I think the qinfo_refs and qinfo_release are added for tracking the
>> lifecycle of nvme_queue_info object. But do we really need to do
>> that ?
>> When a nvme_queue_info->kobj is initialized/added, its parent kobject
>> is referenced by the kobject infrastructure. Therefore, as long as a
>> queue-info kobject exists, its parent queues_kobj remains alive, which
>> in turn keeps ctrl->device->kobj alive. This should already prevent the
>> controller object from being released while a queue-info kobject still
>> exists. Could we therefore avoid maintaining a second qinfo_refs
>> reference count and completion? It seems that entire kobject parent
>> chain already provides the lifetime dependency that qinfo_refs is
>> trying to enforce.
> 
> Agreed. With the directory removed in nvme_tcp_free_queue(), no queue
> directory outlives its queue, and the kobject release only frees its
> own allocation, so the parent chain is enough. v5 drops qinfo_refs,
> the completion and nr_queue_infos. Each connection allocates its own
> kobject, so a reconnect never reuses one.
> 
> [...]
>> This look overly complicated. In a simple scheme can't we get rid off
>> NVME_QUEUE_INFO_IO_CPU_USER and instead use NVME_TCP_Q_IO_CPU_SET as an
>> indicator for differentiating between io_cpu is managed by user or driver?
>> For instance,
>>
>> NVME_TCP_Q_IO_CPU_SET = 1
>>       - driver has selected a specific io_cpu
>>
>> NVME_TCP_Q_IO_CPU_SET = 0 && io_cpu != WORK_CPU_UNBOUND
>>       - user has selected a specific io_cpu
>>
>> NVME_TCP_Q_IO_CPU_SET = 0 && io_cpu == WORK_CPU_UNBOUND
>>       - unbound; workqueue chooses the execution CPU and so it's driver managed
> 
> I drew your scheme as a state diagram to compare it with v4.
> 
>                DRIVER MANAGED          |         USER MANAGED
>     (SET=1, or SET=0 && UNBOUND)       |     (SET=0 && io_cpu=c)
>                                        |
>   connect +--------------------+ store(c)  +--------------------+
>   ------->| A  driver chosen   |-------+-->| C  user pin        |
>           |    io_cpu=c, SET=1 |       |   |    io_cpu=c, SET=0 |
>           |    counted         |       |   |    not counted (1) |
>           +--------------------+       |   +--------------------+
>             | stop, SET=0 and          |     |
>             | io_cpu must be reset (2) |     | store(-1)
>             v                          |     |
>           +--------------------+       |     |
>           | B  unbound         |<------+-----+
>           |    io_cpu=UNBOUND  |       |
>           |    SET=0           |       |   +- - - - - - - - - - +
>           |    also where a    |       |   : D  user unbound    :
>           |    user -1 lands(3)|       |   :    not reachable,  :
>           |                    |       |   :    see (3)         :
>           +--------------------+       |   +- - - - - - - - - - +
>             | next connect, reselect   |
>             +--> A                     |
> 
> (1) A user pin has SET=0, so it drops out of nvme_tcp_cpu_queues.
>      When the driver selects io_cpu for other queues and other
>      controllers in nvme_tcp_set_queue_io_cpu(), it sees that cpu as
>      idle and keeps placing queues on it. v4 counts every bound queue
>      regardless of who assigned it.
> 
> (2) SET clears at stop. Unless the stop path also resets io_cpu to
>      WORK_CPU_UNBOUND once io_work is cancelled, a driver chosen io_cpu
>      reads as a user pin after the reconnect and the driver never
>      selects a cpu for that queue again. In v4 only the sysfs store
>      sets the USER bit, so connect and stop never touch ownership.
> 
> (3) The user managed side has no unbound state. A -1 written by the
>      user is the same state as a queue the driver has not bound yet,
>      so managed reads 1 and the next connect binds it again. Also,
>      nvme_tcp_wq is a per-cpu workqueue, so an unbound io_work runs
>      on the cpu that queued it rather than on a cpu chosen by the
>      workqueue.
> 
May not be true always when nvme_tcp_wq is inited with wq_unbound. We
have a module option using which we could toggle this behavior.

> The USER bit records who owns io_cpu and survives reconnects, while
> SET records whether io_cpu is in the ledger and follows connect and
> stop. I'd like to keep both, with USER moved into nvme_tcp_queue flags
> as you asked on patch 1. The complexity you point at is the extra
> branch in the store, which collapses to a single path with the same
> behavior in v5.
> 
> 	mutex_lock(&ctrl->io_cpu_lock);
> 	old = xchg(&queue->io_cpu, cpu);
> 	set_bit(NVME_TCP_Q_IO_CPU_USER, &queue->flags);
> 	if (test_and_clear_bit(NVME_TCP_Q_IO_CPU_SET, &queue->flags))
> 		atomic_dec(&nvme_tcp_cpu_queues[old]);
> 	if (cpu != WORK_CPU_UNBOUND &&
> 	    test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags)) {
> 		atomic_inc(&nvme_tcp_cpu_queues[cpu]);
> 		set_bit(NVME_TCP_Q_IO_CPU_SET, &queue->flags);
> 	}
> 	mutex_unlock(&ctrl->io_cpu_lock);
> 
> Does that work for you?
> 
This looks good. However, I wonder why we need to check NVME_TCP_Q_ALLOCATED
here? If the user can update io_cpu only while the queue's sysfs directory
exists, and that directory is created and removed along with the queue's
allocation and teardown, shouldn't we be able to drop this check?

>> Other that what sashiko provided in the review feedback, above are my
>> few additional comments.
> 
> Thanks for the review. v5 also fixes the Sashiko findings.
> 

Thanks,
--Nilay


