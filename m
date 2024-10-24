Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62ECFD0BB4E
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Oct 2024 02:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P7AFfQdOViVKVxWlv5kQ3yXAm5fGtAHQh1N4dVOEn4A=; b=Z7R3ToSI2Q5sfopsnsX0LoDRqe
	wBgdU2ON1s8J0zNQB8jUfgUL3LMNBgSaaE/HnZa9cXJKdxWoYs23tiZ7o+JF8dAdiNDJnQ1vurzgf
	ikCy4ixbahN6c0Ux8TjC91S7BQxhI3fuAgJeEqCRj0c94uTYdW8VFgwtpCX+2UjYI1SY4i2lgjBzz
	+5r3TG7S83mXmKGALxkay+ewq8EDysV+ox9VgrQ28XJsrGcAoHKeXmCcNdXCTuiZoxpG9h30A3cWm
	awNCO66JsXJSpRIzbfx5toaFq4NWm2kNPpxG/pnfOjotKvmuvY1ulaAsaiGshggvD+CJrZjPDHyhA
	6LntS0gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3nDK-0000000GTsa-3onY;
	Thu, 24 Oct 2024 02:04:38 +0000
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3nDG-0000000GTs8-3Y7e
	for linux-nvme@lists.infradead.org;
	Thu, 24 Oct 2024 02:04:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729735470; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=P7AFfQdOViVKVxWlv5kQ3yXAm5fGtAHQh1N4dVOEn4A=;
	b=I0oCuodLp0VqNxy+7X+ejhdBgsKWnYUidKYSyB59SBlOiu+gcG2ks2MDI4UtRp2gNh0LPhOsHWr/QshDry1pfXHSTdauhJbFl09TMqDud+9btq/uJskvQjJwVhKMOR8ZGDDT29AeKwlEIi2QLPCNORklK/d4ySK4dtSH+19DdE4=
Received: from 30.178.82.24(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WHnCJOX_1729735468 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 24 Oct 2024 10:04:29 +0800
Message-ID: <788ee2c1-0621-485c-9e50-fe7cecf7ab6e@linux.alibaba.com>
Date: Thu, 24 Oct 2024 10:04:27 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH v17 2/2] nvmet: support reservation feature
To: Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, hch@lst.de, kch@nvidia.com,
 shinichiro.kawasaki@wdc.com, linux-nvme@lists.infradead.org
References: <20241021110331.125962-1-kanie@linux.alibaba.com>
 <20241021110331.125962-3-kanie@linux.alibaba.com>
 <8dccff09-2eab-40a1-abd3-b3759ecdc1ed@grimberg.me>
 <ac5147d1-59ae-4bdc-abba-f57d85972b4d@linux.alibaba.com>
 <20241023133033.GN22571@yadro.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20241023133033.GN22571@yadro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_190436_353222_2B79464E 
X-CRM114-Status: GOOD (  13.09  )
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


在 2024/10/23 21:30, Dmitry Bogdanov 写道:
> On Wed, Oct 23, 2024 at 03:06:10PM +0800, Guixin Liu wrote:
>> 在 2024/10/22 21:18, Sagi Grimberg 写道:
>>>> +static void nvmet_execute_pr_acquire(struct nvmet_req *req)
>>>> +{
>>>> +    u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
>>>> +    bool ignore_key = nvmet_pr_parse_ignore_key(cdw10);
>>>> +    /* Reservation type, bit 15:08 */
>>>> +    u8 rtype = (u8)((cdw10 >> 8) & 0xff);
>>>> +    /* Reservation acquire action, bit 02:00 */
>>>> +    u8 acquire_act = cdw10 & 0x07;
>>>> +    struct nvmet_ctrl *ctrl = req->sq->ctrl;
>>>> +    struct nvmet_pr_acquire_data *d = NULL;
>>>> +    struct nvmet_pr *pr = &req->ns->pr;
>>>> +    struct nvmet_pr_registrant *reg;
>>>> +    u16 status = NVME_SC_SUCCESS;
>>>> +
>>>> +    if (ignore_key ||
>>>> +        rtype < NVME_PR_WRITE_EXCLUSIVE ||
>>>> +        rtype > NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS) {
>>>> +        status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
>>>> +        goto out;
>>>> +    }
>>>> +
>>>> +    d = kmalloc(sizeof(*d), GFP_KERNEL);
>>>> +    if (!d) {
>>>> +        status = NVME_SC_INTERNAL;
>>>> +        goto out;
>>>> +    }
>>>> +
>>>> +    status = nvmet_copy_from_sgl(req, 0, d, sizeof(*d));
>>>> +    if (status)
>>>> +        goto free_data;
>>>> +
>>>> +    status = NVME_SC_RESERVATION_CONFLICT | NVME_STATUS_DNR;
>>>> +    mutex_lock(&pr->pr_lock);
>>>> +    list_for_each_entry_rcu(reg, &pr->registrant_list, entry,
>>>> +                lockdep_is_held(&pr->pr_lock)) {
>>>> +        if (uuid_equal(&reg->hostid, &ctrl->hostid) &&
>>>> +            reg->rkey == le64_to_cpu(d->crkey)) {
>>>> +            status = __nvmet_execute_pr_acquire(req, reg,
>>>> +                    acquire_act, rtype, d);
>>>> +            break;
>>>> +        }
>>>> +    }
>>>> +
>>>> +    if (!status && acquire_act ==
>>>> NVME_PR_ACQUIRE_ACT_PREEMPT_AND_ABORT) {
>>>> +        kfree(d);
>>>> +        INIT_WORK(&req->r.abort_work, nvmet_pr_do_abort);
>>>> +        queue_work(nvmet_wq, &req->r.abort_work);
>>>> +        return;
>>>> +    }
>>> Is there a reason why you queue this here and not inside
>>> __nvmet_execute_pr_acquire
>>> like before?
>>>
>> Because I should add a "if" branch here to prevent unlock the pr_lock
>> and complete
>>
>> the request. Instead of twice "if", I merge them to one, just let
>> __nvmet_execute_pr_acquire()
>>
>> return status.
>>
>>>> +
>>>> +    mutex_unlock(&pr->pr_lock);
>>> Hmm... you keep this mutex taken and release it from the work element
>>> async... Not a
>>> great practice...
>>>
>>> Any easy way you see to avoid this?
>> Sure, this is not a greate practice, I will think deeply and find
>> another way.
>>
> Guixin, please, take a look whether keeping that mutex locked during
> aborting is actually needed or not. Probably there is no such need -
> pr_lock protects ns.pr.registrants_list which is not touched in abort
> procedure.
>
> BR,
>   Dmitry

Well, I should prevent there is no reinit_completion() between complete()

and wait_for_completion(), this may happen if there is another "registion"

and "preempt and abort" when doing abort, although this is a host's bug.

Best Regards,

Guixin Liu


