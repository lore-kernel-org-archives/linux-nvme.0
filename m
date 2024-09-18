Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EBF6CCD18E
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Sep 2024 08:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0W/4IvX3Cuh5OSDt2uNccLjVpnRlZAdu6F2UiBJT7qM=; b=1A0hBfBKt9FjE078r5rOu8eaXe
	sParxUbk3XPhi1JFxkBzxRLHJaiKvz2ORpx+Xyi2NXS14pggjPH4mkwVHRyi01hqEp3wDLB9cbpNQ
	oUXjH9171+cxTcVK0Jzsnyi4hXERrfUDv/o+usqsrByRFa9pdHHxhRWECUyYIxEvGD1jmnuXk1Did
	Ll64HOj83VdwDrw/OTYBRTanvS+22YR95szvjDuf80z8xsSaDKwIjf4NMu62mzvenZdhxjZhFYWZP
	Hkz4+j8uQrGE077vJSiRUzSdlhG0gL2Bb0MDNbHXIvjF5jG8GJUGTTHQljDxE7kxFsLyrQwuldaSo
	Cx1eJWTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sqq12-00000007o31-1DrB;
	Wed, 18 Sep 2024 08:26:24 +0000
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sqq0y-00000007o2G-0w60
	for linux-nvme@lists.infradead.org;
	Wed, 18 Sep 2024 08:26:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726647976; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=0W/4IvX3Cuh5OSDt2uNccLjVpnRlZAdu6F2UiBJT7qM=;
	b=DyL+BgRXSeSFWVM7YoiRLukySPTc6toAD7C0hJBkUoQA0G94py1DdR5Y+RYyoggp9xiCkmA/XgRHND3cG8m8g07KWxXXqgpH2ak2i3o4m/eB1rIGMeYL4cZgQh5HcS/+fRHjB9PJU1Hdej6MyZfIOxGoOEVCc7WNvrqsO/T/Leo=
Received: from 30.178.81.111(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WFDb.wM_1726647971)
          by smtp.aliyun-inc.com;
          Wed, 18 Sep 2024 16:26:12 +0800
Message-ID: <ac49575c-006b-4244-8114-c992ba9948cc@linux.alibaba.com>
Date: Wed, 18 Sep 2024 16:26:10 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH v8 1/1] nvmet: support reservation feature
To: Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
 linux-nvme@lists.infradead.org
References: <20240229031241.8692-1-kanie@linux.alibaba.com>
 <20240229031241.8692-2-kanie@linux.alibaba.com>
 <20240917084352.GB22571@yadro.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20240917084352.GB22571@yadro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240918_012620_972566_906F5B22 
X-CRM114-Status: GOOD (  35.70  )
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

Hi Dmitry,

     My thanks for your advice, I will work on this back recently.


在 2024/9/17 16:43, Dmitry Bogdanov 写道:
> Hi,
>
> Waiting for the final solution half an year we taken this patch as is.
> Here is my comments on it. Hope, this will bring the life to the patch.
>
> On Thu, Feb 29, 2024 at 11:12:41AM +0800, Guixin Liu wrote:
>> This patch implements the reservation feature, includes:
>> 1. reservation register(register, unregister and replace).
>> 2. reservation acquire(acquire, preempt, preempt and abort).
>> 3. reservation release(release and clear).
>> 4. reservation report.
>>
>> And also make reservation configurable, one can set ns to support
>> reservation before enable ns. The default of resv_enable is false.
>>
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> ---
>> @@ -550,7 +556,13 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
>>           */
>>          id->nmic = NVME_NS_NMIC_SHARED;
>>          id->anagrpid = cpu_to_le32(req->ns->anagrpid);
>> -
>> +       id->rescap = NVME_PR_SUPPORT_WRITE_EXCLUSIVE |
>> +                    NVME_PR_SUPPORT_EXCLUSIVE_ACCESS |
>> +                    NVME_PR_SUPPORT_WRITE_EXCLUSIVE_REG_ONLY |
>> +                    NVME_PR_SUPPORT_EXCLUSIVE_ACCESS_REG_ONLY |
>> +                    NVME_PR_SUPPORT_WRITE_EXCLUSIVE_ALL_REGS |
>> +                    NVME_PR_SUPPORT_EXCLUSIVE_ACCESS_ALL_REGS |
>> +                    NVME_PR_SUPPORT_IEKEY_VER_1_3_DEF;
> You have a flag enabling PR on a namespace, so report rescap only if it
> is enabled.
Sure, I will add a "if" statement.
>
> Also I didnot find ONCS, is it not necessarily?
Oh, I missed this, thanks, I will change oncs.
>> +void nvmet_execute_get_log_page_resv(struct nvmet_req *req)
>> +{
>> +       struct nvmet_pr_log_mgr *log_mgr = &req->sq->ctrl->pr_log_mgr;
>> +       struct nvme_pr_log next_log = {0};
>> +       struct nvme_pr_log log = {0};
>> +       u16 status = NVME_SC_SUCCESS;
>> +       u64 lost_count;
>> +       u64 cur_count;
>> +       u64 next_count;
>> +
>> +       mutex_lock(&log_mgr->lock);
>> +       if (!kfifo_get(&log_mgr->log_queue, &log))
>> +               goto out;
>> +
>> +       /*
>> +        * We can't get the last in kfifo.
>> +        * Utilize the current count and the count from the next log to
>> +        * calculate the number of lost logs, while also addressing cases
>> +        * of overflow. If there is no subsequent log, the number of lost
>> +        * logs is equal to the lost_count within the nvmet_pr_log_mgr.
>> +        */
>> +       cur_count = le64_to_cpu(log.count);
>> +       if (kfifo_peek(&log_mgr->log_queue, &next_log)) {
>> +               next_count = le64_to_cpu(next_log.count);
>> +               if (next_count > cur_count)
>> +                       lost_count = next_count - cur_count - 1;
>> +               else
>> +                       lost_count = U64_MAX - cur_count + next_count - 1;
>> +       } else {
>> +               lost_count = log_mgr->lost_count;
>> +       }
>> +
>> +       log.count = cpu_to_le64(cur_count + lost_count);
> This value should be wrapped by U64_MAX too but in reverse direction
> (count is next_count-1). If == 0 then = -1.
>
The next_count will never be 0, you can see in nvmet_pr_add_resv_log, when

the log_mgr->counter == 0, I set the log_mgr->counter to 1.

>> +static void nvmet_pr_add_resv_log(struct nvmet_ctrl *ctrl, u8 log_type, u32 nsid)
>> +{
>> +       struct nvmet_pr_log_mgr *log_mgr = &ctrl->pr_log_mgr;
>> +       struct nvme_pr_log log = {0};
>> +
>> +       mutex_lock(&log_mgr->lock);
>> +       log_mgr->counter++;
>> +       if (log_mgr->counter == 0)
>> +               log_mgr->counter = 1;
>> +
>> +       log.count = cpu_to_le64(log_mgr->counter);
>> +       log.type = log_type;
>> +       log.nsid = cpu_to_le32(nsid);
>> +
>> +       if (!kfifo_put(&log_mgr->log_queue, log)) {
>> +               pr_warn("a reservation log lost, cntlid:%d, log_type:%d, nsid:%d\n",
>> +                       ctrl->cntlid, log_type, nsid);
> I think this log should be Info level, because it is not an error
> situation. Size of this queue is fixed and it is obvious that it can be
> overflowed.
Agree.
>> +static u16 nvmet_pr_create_new_reservation(struct nvmet_pr *pr, u8 new_rtype,
>> +                                          struct nvmet_pr_registrant *reg)
>> +{
>> +       u16 status;
>> +
>> +       status = nvmet_pr_validate_rtype(new_rtype);
> You shall check the validity of the command in the very beginning of
> command handling, not at the very end.

In some situations, we dont care the value of rtype, for example

using preempt to unregister other host.

So I only check it if needed.

>> +       if (!status) {
>> +               reg->rtype = new_rtype;
>> +               rcu_assign_pointer(pr->holder, reg);
>> +       }
>> +       return status;
>> +}
>> +
> ...
>
>> +static u16 nvmet_pr_unreg_by_prkey(struct nvmet_pr *pr, u64 prkey,
>> +                                  uuid_t *send_hostid)
>> +{
>> +       u16 status = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
>> +       struct nvmet_pr_registrant *reg, *tmp;
>> +       uuid_t hostid;
>> +
>> +       lockdep_assert_held(&pr->pr_lock);
>> +
>> +       list_for_each_entry_safe(reg, tmp, &pr->registrant_list, entry) {
>> +               if (reg->rkey == prkey) {
>> +                       status = NVME_SC_SUCCESS;
>> +                       uuid_copy(&hostid, &reg->hostid);
>> +                       nvmet_pr_unregister_one(pr, reg);
>> +                       if (!uuid_equal(&reg->hostid, send_hostid))
> reg is free already, use just hostid as line below:
Yeah sure, thanks a lot.
>> +                               nvmet_pr_registration_preempted(pr, &hostid);
>> +               }
>> +       }
>> +       return status;
>> +}
>> +
> ...
>
>> +static u16 nvmet_pr_preempt(struct nvmet_req *req,
>> +                           struct nvmet_pr_registrant *reg,
>> +                           u8 rtype,
>> +                           struct nvmet_pr_acquire_data *d)
>> +{
>> +       struct nvmet_ctrl *ctrl = req->sq->ctrl;
>> +       struct nvmet_pr *pr = &req->ns->pr;
>> +       struct nvmet_pr_registrant *holder;
>> +       enum nvme_pr_type original_rtype;
>> +       u16 status;
>> +
>> +       lockdep_assert_held(&pr->pr_lock);
>> +       holder = rcu_dereference_protected(pr->holder,
>> +                       lockdep_is_held(&pr->pr_lock));
>> +       if (!holder)
>> +               return nvmet_pr_unreg_by_prkey(pr, le64_to_cpu(d->prkey),
>> +                               &ctrl->hostid);
>> +
>> +       original_rtype = holder->rtype;
>> +       if (original_rtype == NVME_PR_WRITE_EXCLUSIVE_ALL_REGS ||
>> +           original_rtype == NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS) {
>> +               if (!le64_to_cpu(d->prkey)) {
>> +                       nvmet_pr_unreg_except_hostid(pr, &ctrl->hostid);
>> +                       return nvmet_pr_create_new_reservation(pr,
>> +                                       rtype, reg);
> There is not an atomic change of the reservation here. Probably if you swap
> these lines with each other, it will fix that.
>
You are right, we need create new reservation first.
>> +               }
>> +               return nvmet_pr_unreg_by_prkey(pr, le64_to_cpu(d->prkey),
>> +                               &ctrl->hostid);
>> +       }
>> +
>> +       if (holder == reg) {
>> +               status = nvmet_pr_update_reg_attr(pr, holder,
>> +                               nvmet_pr_update_holder_rtype, &rtype);
>> +               if (!status && original_rtype != rtype)
>> +                       nvmet_pr_resv_released(pr, &reg->hostid);
>> +               return status;
>> +       }
>> +
>> +       if (le64_to_cpu(d->prkey) == holder->rkey) {
>> +               status = nvmet_pr_unreg_by_prkey_except_hostid(pr,
>> +                               le64_to_cpu(d->prkey), &ctrl->hostid);
>> +               if (status)
>> +                       return status;
>> +               status = nvmet_pr_create_new_reservation(pr, rtype, reg);
> Here that time gap too.
Changed too.
>
>> +               if (!status && original_rtype != rtype)
>> +                       nvmet_pr_resv_released(pr, &reg->hostid);
>> +               return status;
>> +       }
>> +
>> +       if (le64_to_cpu(d->prkey))
>> +               return nvmet_pr_unreg_by_prkey(pr, le64_to_cpu(d->prkey),
>> +                               &ctrl->hostid);
>> +       return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
>> +}
>> +
> ...
>
>> +void nvmet_ctrl_destroy_pr(struct nvmet_ctrl *ctrl)
>> +{
>> +       struct nvmet_pr_registrant *reg;
>> +       struct nvmet_ns *ns;
>> +       unsigned long idx;
>> +
>> +       kfifo_free(&ctrl->pr_log_mgr.log_queue);
>> +       mutex_destroy(&ctrl->pr_log_mgr.lock);
>> +
>  From here and until the end of the function it is against the standard.
>
>> +       if (nvmet_is_host_connected(&ctrl->hostid, ctrl->subsys))
>> +               return;
>> +
>> +       xa_for_each(&ctrl->subsys->namespaces, idx, ns) {
>> +               mutex_lock(&ns->pr.pr_lock);
>> +               list_for_each_entry_rcu(reg, &ns->pr.registrant_list, entry,
>> +                                       lockdep_is_held(&ns->pr.pr_lock)) {
>> +                       if (uuid_equal(&reg->hostid, &ctrl->hostid)) {
>> +                               nvmet_pr_unregister_one(&ns->pr, reg);
>> +                               break;
>> +                       }
>> +               }
>> +               mutex_unlock(&ns->pr.pr_lock);
>> +       }
> You shall not modify Reservation due to host connectivity.

You are right, we should not unregister the host when disconnect, we

should keep it.

>
>> +}
>> +
>> +void nvmet_pr_exit_ns(struct nvmet_ns *ns)
>> +{
>> +       struct nvmet_pr_registrant *reg, *tmp;
>> +       struct nvmet_pr *pr = &ns->pr;
>> +       LIST_HEAD(free_list);
>> +
>> +       mutex_lock(&pr->pr_lock);
>> +       rcu_assign_pointer(pr->holder, NULL);
>> +       list_for_each_entry_safe(reg, tmp, &pr->registrant_list, entry) {
>> +               list_del_rcu(&reg->entry);
>> +               list_add(&reg->entry, &free_list);
>> +       }
>> +       mutex_unlock(&pr->pr_lock);
>> +       synchronize_rcu();
> IMHO, there is no need in two lists and synchronize_rcu here. At this
> moment there shall be no other users of ns.
Yeah, we can just free all regs simply here.
>
>> +       list_for_each_entry_safe(reg, tmp, &free_list, entry) {
>> +               kfree(reg);
>> +       }
>> +
>> +       mutex_destroy(&pr->pr_lock);
>> +}
>
> BR,
>   Dmitry
>   

Best Regards,

Guixin Liu


