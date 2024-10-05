Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3992ECF887F
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Oct 2024 14:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=doYzhCflV4Qt97WfKewTJBlKTJNzqiqeLiHO4CO2IJ0=; b=evI21itMq4LVQ25jJdoUdJ/ZlS
	7dwrpDeX/0UgwlrWrKs3FpgN+JczRWip1aLhTvZt6WU1RLx9PRBhQw/4HYszy9h5qgteOmYMq73dx
	9cIFOiNCs33ticDRsP49DblsZzEjj+qDMAGPNkedWrWmjaOdMCXlA6fche0LE99b6m6bhdHs/atjk
	K1LfHGDja5C5ryjuyHe+Z7XLNQYcz1IeGzeGP1a+Tc7PHt5NpNk8Y90V+AKHu30SOQ/E1cuBnaaD3
	29Ss8tvJ1mcO2Iwf77IoTpmcNZqd4avZZMdIoKkVDMQODfaVh1PkFAvZ9YYpXjqlMEst2Q6QSsckX
	xv0eWANg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sx5lK-0000000FSqP-2mbG;
	Sat, 05 Oct 2024 14:28:02 +0000
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sx5kS-0000000FSnW-0g3X
	for linux-nvme@lists.infradead.org;
	Sat, 05 Oct 2024 14:27:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728138423; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=doYzhCflV4Qt97WfKewTJBlKTJNzqiqeLiHO4CO2IJ0=;
	b=h3EETjwlygOmCsmDv99Ke4LapBRHHzmI5GP+Y5zafn5p1UKuWfubgFIMdYGPJUIelnoq/kUpZbOXYRmoKZl/+SbUU/IpZIyGu9SDoOnJOLjnTUVfpr33EX+O0UmtVoKGnmR4oPXvmgDhKOm3FPSuGHMf09fO9liOjWQjBs/x7ac=
Received: from 30.170.72.251(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WGHfFxS_1728138418)
          by smtp.aliyun-inc.com;
          Sat, 05 Oct 2024 22:26:59 +0800
Message-ID: <b5059469-d908-41e2-811d-8e4565d0b1dd@linux.alibaba.com>
Date: Sat, 5 Oct 2024 22:26:58 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH v11 1/1] nvmet: support reservation feature
To: Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
 linux-nvme@lists.infradead.org
References: <20240929031410.31281-1-kanie@linux.alibaba.com>
 <20240929031410.31281-2-kanie@linux.alibaba.com>
 <20240930125329.GI22571@yadro.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20240930125329.GI22571@yadro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241005_072708_396028_74D7613B 
X-CRM114-Status: GOOD (  21.42  )
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


在 2024/9/30 20:53, Dmitry Bogdanov 写道:
> On Sun, Sep 29, 2024 at 11:14:10AM +0800, Guixin Liu wrote:
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
>>   drivers/nvme/target/Makefile      |    2 +-
>>   drivers/nvme/target/admin-cmd.c   |   24 +-
>>   drivers/nvme/target/configfs.c    |   27 +
>>   drivers/nvme/target/core.c        |   56 +-
>>   drivers/nvme/target/fabrics-cmd.c |    4 +-
>>   drivers/nvme/target/nvmet.h       |   50 +-
>>   drivers/nvme/target/pr.c          | 1177 +++++++++++++++++++++++++++++
>>   include/linux/nvme.h              |   54 ++
>>   8 files changed, 1382 insertions(+), 12 deletions(-)
>>   create mode 100644 drivers/nvme/target/pr.c
>>
>> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
>> index bd87dfd173a4..9a56269cefd0 100644
>> --- a/drivers/nvme/target/configfs.c
>> +++ b/drivers/nvme/target/configfs.c
>> @@ -748,6 +748,32 @@ static ssize_t nvmet_ns_revalidate_size_store(struct config_item *item,
>>
>>   CONFIGFS_ATTR_WO(nvmet_ns_, revalidate_size);
>>
>> +static ssize_t nvmet_ns_resv_enable_show(struct config_item *item, char *page)
>> +{
>> +       return sprintf(page, "%d\n", to_nvmet_ns(item)->pr.enable);
> sysfs_emit is to be used in show()
OK
>> +}
>> +
>
>> +
>> +static void nvmet_execute_pr_report(struct nvmet_req *req)
>> +{
>> +       u32 cdw11 = le32_to_cpu(req->cmd->common.cdw11);
>> +       u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
>> +       u32 num_bytes = 4 * (cdw10 + 1); /* cdw10 is number of dwords */
>> +       u8 eds = cdw11 & 1; /* Extended data structure, bit 00 */
>> +       struct nvme_registered_ctrl_ext *ctrl_eds;
>> +       struct nvme_reservation_status_ext *data;
>> +       struct nvmet_pr *pr = &req->ns->pr;
>> +       struct nvmet_pr_registrant *holder;
>> +       struct nvmet_pr_registrant *reg;
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
>> +       rcu_read_lock();
>> +       holder = rcu_dereference(pr->holder);
>> +       rtype = holder ? holder->rtype : 0;
>> +       data->rtype = rtype;
>> +
>> +       list_for_each_entry_rcu(reg, &pr->registrant_list, entry) {
>> +               if ((void *)ctrl_eds >= (void *)(data + num_bytes))
>> +                       break;
>> +               /*
>> +                * Dynamic controller, set cntlid to 0xffff.
>> +                */
>> +               ctrl_eds->cntlid = 0xffff;
>> +               if (rtype == NVME_PR_WRITE_EXCLUSIVE_ALL_REGS ||
>> +                   rtype == NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS)
>> +                       ctrl_eds->rcsts = 1;
>> +               if (holder && uuid_equal(&reg->hostid, &holder->hostid))
> is just (reg == holder) not enough here?
Yes.
>> +                       ctrl_eds->rcsts = 1;
>> +               uuid_copy((uuid_t *)&ctrl_eds->hostid, &reg->hostid);
>> +               ctrl_eds->rkey = cpu_to_le64(reg->rkey);
>> +               ctrl_eds++;
>> +               num_ctrls++;
>> +       }
>> +       rcu_read_unlock();
>> +
>> +       put_unaligned_le16(num_ctrls, data->regctl);
> Here you should report the number of all registered registrants in ns,
> not the only reported. It is used by the host to understand that it got
> not a full response.
> NUMD field (cdw11) is about transfering the response. But the structure itsef in
> the reposnse has to be complete.

The NVMe spec says that:

     "This indicates the number of Registered Controller data structures 
and/or Registered Controller extended data structures contained in this 
data structure."

It means that host use this filed to obtain the reported registrants number.

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

