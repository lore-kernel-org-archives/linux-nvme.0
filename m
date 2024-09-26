Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40973CCFA15
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Sep 2024 04:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lH3nN9lLBwMsec6oUBfGPDsHTyUuc/wP+ceeftMMDdo=; b=VVfo9WfKFpq6/B8DXkc8BGt8e1
	rmtumqLpeZtSoa2/1aGusRzdbUymY0F0erEevNot6e81voCcV9hYdjPO91XGZ+TIWf9NMLyoma3yr
	+/iv0Oh0wZt17pnN8XoxICnWhoe4cWlqYXqO/tqYmDtWjEV7nOzUHVkQC5Gec/rPmZXHq0ZURwRKU
	Yuos6FbJRw66T5X+FepXdPfv2FvspFwpceqNblwLfsOvmKgx8nv0Vq14/ETON6EZe5l8QSeFBBOmX
	ZcooZdqdNqFfisY2ZHVtEv+fExakc6deow248GD/jEPjOar7TKzfVGylXabKSgUQsO2utUg1Zn8Tn
	lqYja4pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1stgAb-00000007AYw-43XI;
	Thu, 26 Sep 2024 04:32:01 +0000
Received: from out30-100.freemail.mail.aliyun.com ([115.124.30.100])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1stgAU-00000007AYL-0Jsu
	for linux-nvme@lists.infradead.org;
	Thu, 26 Sep 2024 04:31:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727325109; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=lH3nN9lLBwMsec6oUBfGPDsHTyUuc/wP+ceeftMMDdo=;
	b=k7SaWJ1qyMDBLADa5hBLqHGFHodwb+GCF33inpO4ibrSiMm5yFduAoGB2+chgAA7dYBVZc7EjQXwRjBgLWwnT3epsAyTow1dpdVEgibR+Q4Mx3vJrkCeklNXjVJ1mdftIPGFaHrnrk7bGB/ow9swFzVGUpBu+uBzqRzDy+s5J7I=
Received: from 30.178.81.200(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WFlwbb4_1727325106)
          by smtp.aliyun-inc.com;
          Thu, 26 Sep 2024 12:31:47 +0800
Message-ID: <e16ccce9-f6c2-4074-a8ef-987336d73891@linux.alibaba.com>
Date: Thu, 26 Sep 2024 12:31:45 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH v10 1/1] nvmet: support reservation feature
To: Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
References: <20240925021110.26121-1-kanie@linux.alibaba.com>
 <20240925021110.26121-2-kanie@linux.alibaba.com>
 <20240925142157.GH22571@yadro.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20240925142157.GH22571@yadro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240925_213154_597918_32313A1A 
X-CRM114-Status: GOOD (  25.89  )
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


在 2024/9/25 22:21, Dmitry Bogdanov 写道:
> On Wed, Sep 25, 2024 at 10:11:10AM +0800, Guixin Liu wrote:
>> This patch implements the reservation feature, includes:
>> 1. reservation register(register, unregister and replace).
>> 2. reservation acquire(acquire, preempt, preempt and abort).
>> 3. reservation release(release and clear).
>> 4. reservation report.
>> 5. set feature and get feature of reservation notify mask.
>> 6. get log page of reservation event.
>>
>> And also make reservation configurable, one can set ns to support
>> reservation before enable ns. The default of resv_enable is false.
>>
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> ---
>>   drivers/nvme/target/Makefile    |    2 +-
>>   drivers/nvme/target/admin-cmd.c |   24 +-
>>   drivers/nvme/target/configfs.c  |   27 +
>>   drivers/nvme/target/core.c      |   58 +-
>>   drivers/nvme/target/nvmet.h     |   48 ++
>>   drivers/nvme/target/pr.c        | 1197 +++++++++++++++++++++++++++++++
>>   include/linux/nvme.h            |   54 ++
>>   7 files changed, 1401 insertions(+), 9 deletions(-)
>>   create mode 100644 drivers/nvme/target/pr.c
>>
>> +static void nvmet_execute_pr_report(struct nvmet_req *req)
>> +{
>> +       u32 cdw11 = le32_to_cpu(req->cmd->common.cdw11);
>> +       u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
>> +       u32 num_bytes = 4 * (cdw10 + 1); /* cdw10 is number of dwords */
>> +       u8 eds = cdw11 & 1; /* Extended data structure, bit 00 */
>> +       struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
>> +       struct nvme_registered_ctrl_ext *ctrl_eds;
>> +       struct nvme_reservation_status_ext *data;
>> +       struct nvmet_pr *pr = &req->ns->pr;
>> +       struct nvmet_pr_registrant *holder;
>> +       struct nvmet_pr_registrant *reg;
>> +       struct nvmet_ctrl *ctrl;
>> +       u16 num_ctrls = 0;
>> +       u16 status;
>> +       u8 rtype;
>> +
>> +       /* nvmet hostid(uuid_t) is 128 bit. */
>> +       if (!eds) {
>> +               req->error_loc = offsetof(struct nvme_common_command, cdw11);
>> +               status = NVME_SC_HOST_ID_INCONSIST | NVME_SC_DNR;
>> +               goto out;
>> +       }
>> +
>> +       if (num_bytes < sizeof(struct nvme_reservation_status_ext)) {
>> +               req->error_loc = offsetof(struct nvme_common_command, cdw10);
>> +               status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
>> +               goto out;
>> +       }
>> +
>> +       mutex_lock(&subsys->lock);
>> +       num_ctrls = list_count_nodes(&subsys->ctrls);
>> +       mutex_unlock(&subsys->lock);
>> +
>> +       num_bytes = min(num_bytes,
>> +                       sizeof(struct nvme_reservation_status_ext) +
>> +                       sizeof(struct nvme_registered_ctrl_ext) * num_ctrls);
>> +
>> +       data = kmalloc(num_bytes, GFP_KERNEL);
>> +       if (!data) {
>> +               status = NVME_SC_INTERNAL;
>> +               goto out;
>> +       }
>> +       memset(data, 0, num_bytes);
>> +       data->gen = cpu_to_le32(atomic_read(&pr->generation));
>> +       data->ptpls = 0;
>> +       ctrl_eds = data->regctl_eds;
>> +
>> +       mutex_lock(&subsys->lock);
>> +       rcu_read_lock();
>> +       holder = rcu_dereference(pr->holder);
>> +       rtype = holder ? holder->rtype : 0;
>> +       data->rtype = rtype;
>> +       num_ctrls = 0;
>> +       list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
>> +               if ((void *)ctrl_eds >= (void *)(data + num_bytes))
>> +                       break;
>> +               reg = nvmet_pr_find_registrant(pr, &ctrl->hostid);
>> +               if (!reg)
>> +                       continue;
>> +               ctrl_eds->cntlid = cpu_to_le16(ctrl->cntlid);
>> +               if (rtype == NVME_PR_WRITE_EXCLUSIVE_ALL_REGS ||
>> +                   rtype == NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS)
>> +                       ctrl_eds->rcsts = 1;
>> +               if (holder && uuid_equal(&ctrl->hostid, &holder->hostid))
>> +                       ctrl_eds->rcsts = 1;
>> +               uuid_copy((uuid_t *)&ctrl_eds->hostid, &ctrl->hostid);
>> +               ctrl_eds->rkey = cpu_to_le64(reg->rkey);
>> +               ctrl_eds++;
>> +               num_ctrls++;
>> +       }
>> +       rcu_read_unlock();
>> +       mutex_unlock(&subsys->lock);
> That code fully confroms NVMe Base Spec 2.0c but it is completely wrong
> from the logic point of view.
> ControllerId is a dynamic thing - it's allocated for the each
> fabric session(Connect command). It has no meaning for an initiator.
> The association between Registrant (uniq key HostId) and Controller
> (uniq key CtrlId) is not 1..1, it is 1..N.
>
> NVMe Base Spec 2.1 addressed this issue and it states, that here target
> shall report just list if the registrants:
>
> 	Number of Registrants (REGSTRNT): This field indicates the number of registrants of the
> 	namespace. This indicates the number of Registrant data structures or Registrant Extended data
> 	structures contained in this data structure.
> 	Note: This field was formerly named Number of Registered Controllers (REGCTL).
>
>
> Though, v2.1 still does not clearly states what exact CNTLID is to be
> reported from 1..N association.
>
> I suggest you to update your patch to conform the Spec v2.1 - remove cntlid
> from nvmet_pr_registrant and report here just ns->pr.registrant_list.
> And not to track the connectivity of registrants - report always CNTLID=0xFFFF
> as a some compromise value that is allowed by the Spec.
>
I dont notice that another host can connect with already exist same hostid,

I remove the cntlid in nvmet_pr_registrant and add hostid to 
nvmet_pr_per_ctrl_ref to

find unregisted controller to kill the per-controlelr percpu ref.

And also report cntlid to 0xffff.

>> +
>> +       put_unaligned_le16(num_ctrls, data->regctl);
>> +       num_bytes = sizeof(struct nvme_reservation_status_ext) +
>> +                       sizeof(struct nvme_registered_ctrl_ext) * num_ctrls;
> num_bytes was a size of requested buffer (cdw10), you even allocate that
> size. You shall not extend it here. Instead you should allocate maximum
> possible size and copy here only cdw10 dwords from your buffer to sgl.

OK, I will adjust code here.

Best Regards,

Guixin Liu

>> +       status = nvmet_copy_to_sgl(req, 0, data, num_bytes);
>> +       kfree(data);
>> +out:
>> +       nvmet_req_complete(req, status);
>> +}
>> +
> BR,
>   Dmitry

