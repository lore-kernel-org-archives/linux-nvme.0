Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 792A1CA6007
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2026 09:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cd4wnW1AV+IxbDxS+t4escsCY1WVNtvZB+DyXiJcGXo=; b=gKAkbybLProMSR6gpyTM5Vw0Sf
	/mtR04PUqdeEezOJEjOIhVgmtZrFldRQnbx2D5rX9HVOYz8GHWrgi1B07xHGlCJEQvKLYo0ezCn9y
	a//Wnyeu409Ei0asfJ4S+xr69Hxx+uXgVHQ8J5ASxuQjjhAIxi67NDL7NBeCxiS+R9tuVm749wH5l
	dycq42UUpg9Z+fyeBeIAzv5c6uT8WuQj7PTG4NqloC/fZuW9A4mIHohBKIjbydEG8r45fil58KXfj
	xh/zpMXrHs00Bswdk+z6d4I4libgKwFK2WT1E+gvGIi8pmXfe65QXOsnbC9XkBIsqRSL4+h58YCtd
	jrHlLuSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEkhc-000000041uR-2v32;
	Thu, 08 Oct 2026 09:46:16 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEkha-000000041tp-2VQV
	for linux-nvme@lists.infradead.org;
	Thu, 08 Oct 2026 09:46:15 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6987ZmDE589447;
	Thu, 8 Oct 2026 09:45:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Cd4wnW
	1AV+IxbDxS+t4escsCY1WVNtvZB+DyXiJcGXo=; b=Nah/hu+RYGVnqQrZSWPd7j
	uk3sVVnIEqN1dkjk0/i4UEwDk0PtVYHeUJzY2BwCLemVHTfhIyd8c6IAtOMNWhm3
	mVnzrfCABM0ERPZLhf2Jvx49LOJEywm+kxZuKqnEgwGdRb7ruLgd2qrwHhkkLfCN
	V7ZFtoYV3wi0VGlAtu3Uwy5R2s7X6UMRy+0DryTgTGuFzaCd2YhneP43Gkljq9GW
	/T0m/awjXjr44fj6jkurv3gK9bxOEdM0NylK+IyFBhZPaeII8+LTYxVaAZnmGOol
	GOAXYagaRxA+uATMo9+ViuFoqvduyuzZUrd6w8qs00k/76FWlRy8RZ7N44bSf1Jg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjw2htm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 09:45:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6987ImWF3107338;
	Thu, 8 Oct 2026 09:45:58 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h58ek6tfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 09:45:58 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6989jwRg27656908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Oct 2026 09:45:58 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8367E58056;
	Thu,  8 Oct 2026 09:45:58 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F13F258052;
	Thu,  8 Oct 2026 09:45:54 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Oct 2026 09:45:54 +0000 (GMT)
Message-ID: <51a451fe-fdf6-4e8f-afbd-c595f3c6de2c@linux.ibm.com>
Date: Thu, 8 Oct 2026 15:15:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] nvme-tcp: allow setting per-queue io_cpu through
 sysfs
To: Saravanan D <saravanand@crusoe.ai>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        dwagner@suse.de, linux-kernel@vger.kernel.org, iyamahata@crusoe.ai,
        kiyer@crusoe.ai, ganbalagane@crusoe.ai, sj@kernel.org
References: <20260927070925.47209-1-saravanand@crusoe.ai>
 <20260927070925.47209-3-saravanand@crusoe.ai>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260927070925.47209-3-saravanand@crusoe.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAzOCBTYWx0ZWRfX2APgpKpG/6aL
 UzALq48TWkFD2SofKZHA8bNZJ8SLdwO2pgjWtjPF3wZWR8uc01yHPVlkMv0yqyl/6oR9EVkbfes
 goBMF565lVX/Koa2XH+aa1fU+4tw9pA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAzOCBTYWx0ZWRfX5bH4CyLU57rV
 OtMjNwAnx/6o/G0OM+pPRHfSp6Cyl0PnC94YNPYHBoWaS8dOvjQypf0IDdV0NNo1bOtGcbfAESG
 g/o4bpFhTvkmoxfiypSgOgnPa3zGoC6qT0RudGlSOjlOpbJtsFk/jtgJIFPcdEkWb4IDk2yShwf
 tnus9Un+9nbDCUEr3Q5+NfIxyluN9HHwgnPLsXr/haOUBamokhf9y1vXBspChv2WQGQYozzl8Dt
 7ckeCvmBHoYlf0md+ErKIcYeM73E9pKrOSiA8FbI7xY77pI3BEha/fSOEapUHn7fP8dPeoUuU7y
 1QtuPNIHQD6/8ikfryDEwLigRtrdCXenfqImoOJKDpFkQXed9NJvcSd/9UdS9rKA1s3ogrGiyo4
 yNNwhK/14w40PxmMiTVXOOgVDmP5+LiG4NSA+7xWwxVFXvJ4TWeyCwgm2dmZVm0jrlnP+dRFJAo
 llfRLMKOpPesiRju0GQ==
X-Proofpoint-GUID: __LjFZlCCrVDICWDlWIb7sTNj_s24yZc
X-Proofpoint-ORIG-GUID: __LjFZlCCrVDICWDlWIb7sTNj_s24yZc
X-Authority-Analysis: v=2.4 cv=XcwcX455 c=1 sm=1 tr=0 ts=6ac76657 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=ukM8rYxtvgWVYNmfLEQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610080038
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261008_024614_763635_F9D381FA 
X-CRM114-Status: GOOD (  34.73  )
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

On 9/27/26 12:39 PM, Saravanan D wrote:
> nvme_tcp_set_queue_io_cpu() picks each queue's io_cpu at connect time
> as the least loaded CPU in the queue's blk-mq map group, and all socket
> work runs there for the connection's lifetime. This decision falls
> short when the host partitions its CPUs after connect time. On a 384
> cpu multi tenant host with 128 queue controllers, blk-mq folds three
> CPUs into every map group, some groups straddle two tenants' cpusets,
> and 9% of nvme_tcp_io_work executions ran outside the submitting VM's
> cpuset, seen by the neighbor as steal time.
> 
> Embed the nvme_queue_info in the tcp queue and expose the io_cpu
> through the controller's queues directory
> 
>    /sys/class/nvme/nvmeX/queues/<qid>/io_cpu
> 
> so a control plane that owns CPU placement can set it directly instead
> of relying on the driver's heuristic. The attribute accepts a cpu
> number, -1 or "unbound", where -1 and "unbound" leave the socket work
> unbound, running each invocation on the cpu that queued it. A user
> assignment is marked in the queue info flags, persists across
> reconnects and is never re-picked by the driver. The read-only
> managed attribute reports 1 while io_cpu is driver managed and 0 once
> the user assigned it. The accounting of nvme_tcp_cpu_queues applies
> regardless of who set the io_cpu.
> 
> The queue directories register on the first connect and persist while
> the queues cycle across reconnects, so a write can arrive while a
> queue is torn down. The io_cpu changes and their accounting therefore
> serialize under a controller level lock rather than the queue lock,
> which is destroyed with the queue, and the controller teardown waits
> for the last kobject release before the queue array is freed.
> 
I understand based on your requirement you may want to persist io_cpu
changes (when managed by user) during controller reconnect. However
in case num of queues changes after reconnect (assume it's 32 at first
connect but after controller reconnects it's reduced to 16) keeping
those 32 queues entries under queues/<qid>/ looks bit odd and not
correct. I'd expect queues entries under queue/<qid>/ to be also
adjusted based on the controller queue count.

[...]

> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 921934028e0b..567c839e92a4 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -141,6 +141,8 @@ struct nvme_tcp_queue {
>   	int                     tls_err;
>   	struct page_frag_cache	pf_cache;
>   
> +	struct nvme_queue_info	q_info;
> +
>   	void (*state_change)(struct sock *);
>   	void (*data_ready)(struct sock *);
>   	void (*write_space)(struct sock *);
> @@ -171,6 +173,11 @@ struct nvme_tcp_ctrl {
>   	struct delayed_work	connect_work;
>   	struct nvme_tcp_request async_req;
>   	u32			io_queues[HCTX_MAX_TYPES];
> +	/* serializes io_cpu changes and their nvme_tcp_cpu_queues accounting */
> +	struct mutex		io_cpu_lock;

The io_cpu_lock protect updates to queue->io_cpu and as we now support clang
context annotations for NVMe host driver, I'd suggest you annotate the
queue->io_cpu with __guarded_by(...) so that clang context analyzer can
validate each access to queue->io_cpu. Furthermore, I see that queue->io_cpu
could be concurrently accessed from both control path and I/O hotpath. So how
would we protect it while it's being accessed from I/O path and concurrently
updated from sysfs path?
> +	unsigned int		nr_queue_infos;
> +	atomic_t		qinfo_refs;
> +	struct completion	qinfo_release;
>   };

I think the qinfo_refs and qinfo_release are added for tracking the
lifecycle of nvme_queue_info object. But do we really need to do
that ?
When a nvme_queue_info->kobj is initialized/added, its parent kobject
is referenced by the kobject infrastructure. Therefore, as long as a
queue-info kobject exists, its parent queues_kobj remains alive, which
in turn keeps ctrl->device->kobj alive. This should already prevent the
controller object from being released while a queue-info kobject still
exists. Could we therefore avoid maintaining a second qinfo_refs
reference count and completion? It seems that entire kobject parent
chain already provides the lifetime dependency that qinfo_refs is
trying to enforce.

[...]

> +static ssize_t io_cpu_store(struct kobject *kobj, struct kobj_attribute *attr,
> +			    const char *buf, size_t count)
> +{
> +	struct nvme_tcp_queue *queue = nvme_tcp_kobj_to_queue(kobj);
> +	struct nvme_tcp_ctrl *ctrl = queue->ctrl;
> +	int cpu, old;
> +	int ret;
> +
> +	if (sysfs_streq(buf, "unbound")) {
> +		cpu = WORK_CPU_UNBOUND;
> +	} else {
> +		ret = kstrtoint(buf, 0, &cpu);
> +		if (ret)
> +			return ret;
> +		if (cpu == -1)
> +			cpu = WORK_CPU_UNBOUND;
> +		else if ((unsigned int)cpu >= nr_cpu_ids || !cpu_online(cpu))
> +			return -EINVAL;
> +	}
> +
> +	mutex_lock(&ctrl->io_cpu_lock);
> +	old = xchg(&queue->io_cpu, cpu);
> +	set_bit(NVME_QUEUE_INFO_IO_CPU_USER, &queue->q_info.flags);
> +	if (test_bit(NVME_TCP_Q_IO_CPU_SET, &queue->flags)) {
> +		atomic_dec(&nvme_tcp_cpu_queues[old]);
> +		if (cpu != WORK_CPU_UNBOUND)
> +			atomic_inc(&nvme_tcp_cpu_queues[cpu]);
> +		else
> +			clear_bit(NVME_TCP_Q_IO_CPU_SET, &queue->flags);
> +	} else if (cpu != WORK_CPU_UNBOUND &&
> +		   test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags)) {
> +		/* account a pin to a connected queue the pick left unbound */
> +		atomic_inc(&nvme_tcp_cpu_queues[cpu]);
> +		set_bit(NVME_TCP_Q_IO_CPU_SET, &queue->flags);
> +	}
> +	mutex_unlock(&ctrl->io_cpu_lock);
> +
This look overly complicated. In a simple scheme can't we get rid off
NVME_QUEUE_INFO_IO_CPU_USER and instead use NVME_TCP_Q_IO_CPU_SET as an
indicator for differentiating between io_cpu is managed by user or driver?
For instance,

NVME_TCP_Q_IO_CPU_SET = 1
     - driver has selected a specific io_cpu

NVME_TCP_Q_IO_CPU_SET = 0 && io_cpu != WORK_CPU_UNBOUND
     - user has selected a specific io_cpu

NVME_TCP_Q_IO_CPU_SET = 0 && io_cpu == WORK_CPU_UNBOUND
     - unbound; workqueue chooses the execution CPU and so it's driver managed

[...]

Other that what sashiko provided in the review feedback, above are my
few additional comments.

Thanks,
--Nilay



