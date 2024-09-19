Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BDDDCE8D78
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Sep 2024 11:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7rs2c5000mol7C54G6Xq3aXjqPZ/ZOM4P2nxbnytJ9s=; b=NpSBZlPXPZA7WR9p2FiVuC7T1Z
	JUI9PMXmgMmFmdXRmnr+Vs0rzX2aZQTGCYXTcfP8h1T52aF8YfNJNoiPfksrbQn8kc1cToVdo3j2i
	cwoG/HuRCplaoWiPzIGTylO2uqd9QVLoWqo3MEvi/ssxN5VSWexatcfirC6eBBchXXxz953U/DVX+
	OKQgGHj3/E/87Nfj3wGLxCc3yS2nPIfx8ILik0BBkn0TzfSCgeBEmuITSmnjVvCfwaoOoAC+EcwD8
	2KCi3hQnYDtaTDGeIR7w73s1WXZ0Bsi3VJT+0J6EDJFV8okctkdLxxS/ZqJ2YyG5SMN0UPpToqgRt
	NBqa4plQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1srFYT-0000000ABM7-14VT;
	Thu, 19 Sep 2024 11:42:37 +0000
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1srFYP-0000000ABJv-3IOu
	for linux-nvme@lists.infradead.org;
	Thu, 19 Sep 2024 11:42:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726746147; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=7rs2c5000mol7C54G6Xq3aXjqPZ/ZOM4P2nxbnytJ9s=;
	b=K92X7wjU5yWsAZ6PCKzuGDxL8sWTf1l0ULPAKymqsHrLit86DipMRGQKuzLokUx07/2ynFk67L6c65yshc7GLM+D1XqazrrXI4vO1538ylH+LxMNlLQ8rj4vsyiTmsYTEpN9ROi8jYQOCnwM5rUr1n/vC7IBN7jxVAAvHda8ziY=
Received: from 30.178.82.244(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WFHbsCX_1726746143)
          by smtp.aliyun-inc.com;
          Thu, 19 Sep 2024 19:42:24 +0800
Message-ID: <2a522525-b9fd-4f3f-8865-8174989fa11c@linux.alibaba.com>
Date: Thu, 19 Sep 2024 19:42:23 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH v8 1/1] nvmet: support reservation feature
To: Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
 linux-nvme@lists.infradead.org
References: <20240229031241.8692-1-kanie@linux.alibaba.com>
 <20240229031241.8692-2-kanie@linux.alibaba.com>
 <20240917084352.GB22571@yadro.com>
 <ac49575c-006b-4244-8114-c992ba9948cc@linux.alibaba.com>
 <20240918134159.GC22571@yadro.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20240918134159.GC22571@yadro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240919_044234_316968_079791D0 
X-CRM114-Status: GOOD (  28.28  )
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


在 2024/9/18 21:41, Dmitry Bogdanov 写道:
> On Wed, Sep 18, 2024 at 04:26:10PM +0800, Guixin Liu wrote:
>> Hi Dmitry,
>>
>>      My thanks for your advice, I will work on this back recently.
>>
>>
>> 在 2024/9/17 16:43, Dmitry Bogdanov 写道:
>>> Hi,
>>>
>>> Waiting for the final solution half an year we taken this patch as is.
>>> Here is my comments on it. Hope, this will bring the life to the patch.
>>>
>>>> +void nvmet_execute_get_log_page_resv(struct nvmet_req *req)
>>>> +{
>>>> +       struct nvmet_pr_log_mgr *log_mgr = &req->sq->ctrl->pr_log_mgr;
>>>> +       struct nvme_pr_log next_log = {0};
>>>> +       struct nvme_pr_log log = {0};
>>>> +       u16 status = NVME_SC_SUCCESS;
>>>> +       u64 lost_count;
>>>> +       u64 cur_count;
>>>> +       u64 next_count;
>>>> +
>>>> +       mutex_lock(&log_mgr->lock);
>>>> +       if (!kfifo_get(&log_mgr->log_queue, &log))
>>>> +               goto out;
>>>> +
>>>> +       /*
>>>> +        * We can't get the last in kfifo.
>>>> +        * Utilize the current count and the count from the next log to
>>>> +        * calculate the number of lost logs, while also addressing cases
>>>> +        * of overflow. If there is no subsequent log, the number of lost
>>>> +        * logs is equal to the lost_count within the nvmet_pr_log_mgr.
>>>> +        */
>>>> +       cur_count = le64_to_cpu(log.count);
>>>> +       if (kfifo_peek(&log_mgr->log_queue, &next_log)) {
>>>> +               next_count = le64_to_cpu(next_log.count);
>>>> +               if (next_count > cur_count)
>>>> +                       lost_count = next_count - cur_count - 1;
>>>> +               else
>>>> +                       lost_count = U64_MAX - cur_count + next_count - 1;
>>>> +       } else {
>>>> +               lost_count = log_mgr->lost_count;
>>>> +       }
>>>> +
>>>> +       log.count = cpu_to_le64(cur_count + lost_count);
>>> This value should be wrapped by U64_MAX too but in reverse direction
>>> (count is next_count-1). If == 0 then = -1.
>>>
>> The next_count will never be 0, you can see in nvmet_pr_add_resv_log, when
>>
>> the log_mgr->counter == 0, I set the log_mgr->counter to 1.
> I mean that herer tou should add the same logic as in nvmet_pr_add_resv_log.
> I am talking about this case:
> next_count = 2
> cur_count  = 0xffffffff
> lost_count = U64_MAX - cur_count + next_count - 1 =  0xffffffff - 0xffffffff + 2 - 1 = 1
> log.count = cpu_to_le64(cur_count + lost_count) = 0xffffffff + 1 = 0
>
> 0 in this case shall became 1 (not -1 as in my original comment)
>
> if (log.count == 0)
> 	log.count = 1;
>
> would fix that.
Your right, it will be changed in v9.
>>>> +static u16 nvmet_pr_create_new_reservation(struct nvmet_pr *pr, u8 new_rtype,
>>>> +                                          struct nvmet_pr_registrant *reg)
>>>> +{
>>>> +       u16 status;
>>>> +
>>>> +       status = nvmet_pr_validate_rtype(new_rtype);
>>> You shall check the validity of the command in the very beginning of
>>> command handling, not at the very end.
>> In some situations, we dont care the value of rtype, for example
>>
>> using preempt to unregister other host.
>>
>> So I only check it if needed.
> I have two arguemnts for:
> 1. It is more convenient to check a validity of a command in the beginning -
> there will be less changes to rollback. Now you do some unregistrations
> and then may fail the command due to invalid rtype, but Reservation data
> you does not change back.
>
> 2. Yes, the spec does not state that RTYPE shall be valid in Reservation Acquire Action (RACQA) field to 001b (Preempt)
> when reservation is not going to be changed. But it doesnot state that it
> might be ignored too :). In some places I see that such a statement there is.
> Also, there is such general statement for reserved values
> 	1.4.1.6 reserved
> 	Receipt of reserved coded values in defined fields in
> 	commands shall be reported as an error.
I changed rtype check to the beginning of acquire to see maintainer`s 
opinion.
>>>> +       if (!status) {
>>>> +               reg->rtype = new_rtype;
>>>> +               rcu_assign_pointer(pr->holder, reg);
>>>> +       }
>>>> +       return status;
>>>> +}
>>>> +
> BR,
>   Dmitry

Best Regards,

Guixin Liu


