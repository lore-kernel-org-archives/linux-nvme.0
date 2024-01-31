Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9861BC47258
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 03:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q9sxHMD/k/d++VOSp+q8opl+vVcO9ApySG3J4FS+65M=; b=uYabvd3UxKPo95pp1a8yYy1+vY
	9eJXOLSmlVYPx0XXa8/PZeBqd96/69sdMyYty1T2BpLPtO4g3FQV8uWELcj3XKMc5QVMwz37oZkIP
	4hDGaQFnMFdnorV6NeNPXuxTdTXjibwMFizs/xRvHagUYBPoyUnfw1HOc/+BbUh4mcPTLT6rlLAw1
	ALGfBMN2uiejwze2Z6kjuJA8oTBVNYPUxfv9JUFJPjzWffPFbl+8jnL66FTF8u2uI+uE0F4lNdZTr
	Q5BhKshkz7oNTbBTTw1pYxHzdOmw1i7Fs0IMLdT5ZydTe2uc+K+zAkHecoCQCa6E1+Dh2gI+FmCEM
	rIFjcJEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV1lC-00000001Px3-1aWW;
	Wed, 31 Jan 2024 03:59:38 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV1l6-00000001PwI-1EzP
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 03:59:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706673557; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Q9sxHMD/k/d++VOSp+q8opl+vVcO9ApySG3J4FS+65M=;
	b=UFdLa89QfjuTSTvG/pJxjpZqO7BoM8ojDWrhq2Vg5Z57ZFuCeYfZ2TEsahm/8PGTOhQM6XjIFgrjQOnbWzXZ3y6I+jeUe0W+/sDCJ/NCKRhZmp5umTUPTOe2pupgHfuCRw2nYvVGtcRfOEbuzx7er4SSUUr6U3UALfBnwkerc0w=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W.htVYh_1706673554;
Received: from 30.178.83.26(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W.htVYh_1706673554)
          by smtp.aliyun-inc.com;
          Wed, 31 Jan 2024 11:59:15 +0800
Message-ID: <dc9ed34b-6105-450f-bfa7-030cd22ad92b@linux.alibaba.com>
Date: Wed, 31 Jan 2024 11:59:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/1] nvmet: support reservation feature
Content-Language: en-GB
To: Sagi Grimberg <sagi@grimberg.me>, hch@lst.de, kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
References: <20240130112046.113292-1-kanie@linux.alibaba.com>
 <20240130112046.113292-2-kanie@linux.alibaba.com>
 <0ede805d-4020-4425-88dc-2e86990e887c@grimberg.me>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <0ede805d-4020-4425-88dc-2e86990e887c@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_195933_394566_526EA2CF 
X-CRM114-Status: GOOD (  20.75  )
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


在 2024/1/30 20:42, Sagi Grimberg 写道:
>
>
> On 1/30/24 13:20, Guixin Liu wrote:
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
>>   drivers/nvme/target/Makefile    |   2 +-
>>   drivers/nvme/target/admin-cmd.c |  14 +-
>>   drivers/nvme/target/configfs.c  |  27 +
>>   drivers/nvme/target/core.c      |  51 +-
>>   drivers/nvme/target/nvmet.h     |  34 ++
>>   drivers/nvme/target/pr.c        | 978 ++++++++++++++++++++++++++++++++
>>   include/linux/nvme.h            |  48 ++
>>   7 files changed, 1147 insertions(+), 7 deletions(-)
>>   create mode 100644 drivers/nvme/target/pr.c
>>
>> diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
>> index c66820102493..f9bfc904a5b3 100644
>> --- a/drivers/nvme/target/Makefile
>> +++ b/drivers/nvme/target/Makefile
>> @@ -10,7 +10,7 @@ obj-$(CONFIG_NVME_TARGET_FCLOOP)    += nvme-fcloop.o
>>   obj-$(CONFIG_NVME_TARGET_TCP)        += nvmet-tcp.o
>>     nvmet-y        += core.o configfs.o admin-cmd.o fabrics-cmd.o \
>> -            discovery.o io-cmd-file.o io-cmd-bdev.o
>> +            discovery.o io-cmd-file.o io-cmd-bdev.o pr.o
>>   nvmet-$(CONFIG_NVME_TARGET_PASSTHRU)    += passthru.o
>>   nvmet-$(CONFIG_BLK_DEV_ZONED)        += zns.o
>>   nvmet-$(CONFIG_NVME_TARGET_AUTH)    += fabrics-cmd-auth.o auth.o
>> diff --git a/drivers/nvme/target/admin-cmd.c 
>> b/drivers/nvme/target/admin-cmd.c
>> index 39cb570f833d..791bc7e740c0 100644
>> --- a/drivers/nvme/target/admin-cmd.c
>> +++ b/drivers/nvme/target/admin-cmd.c
>> @@ -176,6 +176,10 @@ static void nvmet_get_cmd_effects_nvm(struct 
>> nvme_effects_log *log)
>>       log->iocs[nvme_cmd_read] =
>>       log->iocs[nvme_cmd_flush] =
>>       log->iocs[nvme_cmd_dsm]    =
>> +    log->iocs[nvme_cmd_resv_acquire] =
>> +    log->iocs[nvme_cmd_resv_register] =
>> +    log->iocs[nvme_cmd_resv_release] =
>> +    log->iocs[nvme_cmd_resv_report] =
>>           cpu_to_le32(NVME_CMD_EFFECTS_CSUPP);
>>       log->iocs[nvme_cmd_write] =
>>       log->iocs[nvme_cmd_write_zeroes] =
>> @@ -340,6 +344,8 @@ static void nvmet_execute_get_log_page(struct 
>> nvmet_req *req)
>>           return nvmet_execute_get_log_cmd_effects_ns(req);
>>       case NVME_LOG_ANA:
>>           return nvmet_execute_get_log_page_ana(req);
>> +    case NVME_LOG_RESERVATION:
>> +        return nvmet_execute_get_log_page_resv(req);
>>       }
>>       pr_debug("unhandled lid %d on qid %d\n",
>>              req->cmd->get_log_page.lid, req->sq->qid);
>> @@ -550,7 +556,13 @@ static void nvmet_execute_identify_ns(struct 
>> nvmet_req *req)
>>        */
>>       id->nmic = NVME_NS_NMIC_SHARED;
>>       id->anagrpid = cpu_to_le32(req->ns->anagrpid);
>> -
>> +    id->rescap = NVME_PR_SUPPORT_WRITE_EXCLUSIVE |
>> +             NVME_PR_SUPPORT_EXCLUSIVE_ACCESS |
>> +             NVME_PR_SUPPORT_WRITE_EXCLUSIVE_REG_ONLY |
>> +             NVME_PR_SUPPORT_EXCLUSIVE_ACCESS_REG_ONLY |
>> +             NVME_PR_SUPPORT_WRITE_EXCLUSIVE_ALL_REGS |
>> +             NVME_PR_SUPPORT_EXCLUSIVE_ACCESS_ALL_REGS |
>> +             NVME_PR_SUPPORT_IEKEY_VER_1_3_DEF;
>>       memcpy(&id->nguid, &req->ns->nguid, sizeof(id->nguid));
>>         id->lbaf[0].ds = req->ns->blksize_shift;
>> diff --git a/drivers/nvme/target/configfs.c 
>> b/drivers/nvme/target/configfs.c
>> index 2482a0db2504..56aead89d21a 100644
>> --- a/drivers/nvme/target/configfs.c
>> +++ b/drivers/nvme/target/configfs.c
>> @@ -714,6 +714,32 @@ static ssize_t 
>> nvmet_ns_revalidate_size_store(struct config_item *item,
>>     CONFIGFS_ATTR_WO(nvmet_ns_, revalidate_size);
>>   +static ssize_t nvmet_ns_resv_enable_show(struct config_item *item, 
>> char *page)
>> +{
>> +    return sprintf(page, "%d\n", to_nvmet_ns(item)->pr.enable);
>> +}
>> +
>> +static ssize_t nvmet_ns_resv_enable_store(struct config_item *item,
>> +                    const char *page, size_t count)
>> +{
>> +    struct nvmet_ns *ns = to_nvmet_ns(item);
>> +    bool val;
>> +
>> +    if (kstrtobool(page, &val))
>> +        return -EINVAL;
>> +
>> +    mutex_lock(&ns->subsys->lock);
>> +    if (ns->enabled) {
>> +        pr_err("the ns:%d is already enabled.\n", ns->nsid);
>> +        mutex_unlock(&ns->subsys->lock);
>> +        return -EINVAL;
>> +    }
>> +    ns->pr.enable = val;
>> +    mutex_unlock(&ns->subsys->lock);
>> +    return count;
>> +}
>> +CONFIGFS_ATTR(nvmet_ns_, resv_enable);
>> +
>>   static struct configfs_attribute *nvmet_ns_attrs[] = {
>>       &nvmet_ns_attr_device_path,
>>       &nvmet_ns_attr_device_nguid,
>> @@ -722,6 +748,7 @@ static struct configfs_attribute 
>> *nvmet_ns_attrs[] = {
>>       &nvmet_ns_attr_enable,
>>       &nvmet_ns_attr_buffered_io,
>>       &nvmet_ns_attr_revalidate_size,
>> +    &nvmet_ns_attr_resv_enable,
>>   #ifdef CONFIG_PCI_P2PDMA
>>       &nvmet_ns_attr_p2pmem,
>>   #endif
>> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
>> index d26aa30f8702..e98af9e09e4d 100644
>> --- a/drivers/nvme/target/core.c
>> +++ b/drivers/nvme/target/core.c
>> @@ -591,6 +591,8 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
>>       if (ns->nsid > subsys->max_nsid)
>>           subsys->max_nsid = ns->nsid;
>>   +    nvmet_pr_init_ns(ns);
>> +
>>       ret = xa_insert(&subsys->namespaces, ns->nsid, ns, GFP_KERNEL);
>>       if (ret)
>>           goto out_restore_subsys_maxnsid;
>> @@ -646,6 +648,7 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
>>       synchronize_rcu();
>>       wait_for_completion(&ns->disable_done);
>>       percpu_ref_exit(&ns->ref);
>> +    nvmet_pr_exit_ns(ns);
>>         mutex_lock(&subsys->lock);
>>   @@ -904,18 +907,34 @@ static u16 nvmet_parse_io_cmd(struct 
>> nvmet_req *req)
>>           return ret;
>>       }
>>   +    if (req->ns->pr.enable) {
>> +        ret = nvmet_parse_pr_cmd(req);
>> +        if (!ret)
>> +            return ret;
>
> so ret != 0 just continues?
Yes.
>
>> +    }
>> +
>>       switch (req->ns->csi) {
>>       case NVME_CSI_NVM:
>>           if (req->ns->file)
>> -            return nvmet_file_parse_io_cmd(req);
>> -        return nvmet_bdev_parse_io_cmd(req);
>> +            ret = nvmet_file_parse_io_cmd(req);
>> +        else
>> +            ret = nvmet_bdev_parse_io_cmd(req);
>> +        break;
>>       case NVME_CSI_ZNS:
>>           if (IS_ENABLED(CONFIG_BLK_DEV_ZONED))
>> -            return nvmet_bdev_zns_parse_io_cmd(req);
>> -        return NVME_SC_INVALID_IO_CMD_SET;
>> +            ret = nvmet_bdev_zns_parse_io_cmd(req);
>> +        else
>> +            ret = NVME_SC_INVALID_IO_CMD_SET;
>> +        break;
>>       default:
>> -        return NVME_SC_INVALID_IO_CMD_SET;
>> +        ret = NVME_SC_INVALID_IO_CMD_SET;
>>       }
>> +    if (ret)
>> +        return ret;
>> +
>> +    if (req->ns->pr.enable)
>> +        ret = nvmet_pr_check_cmd_access(req);
>> +    return ret;
>>   }
>>     bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
>> @@ -1231,6 +1250,22 @@ static void nvmet_init_cap(struct nvmet_ctrl 
>> *ctrl)
>>           nvmet_passthrough_override_cap(ctrl);
>>   }
>>   +bool nvmet_is_host_still_connected(uuid_t *hostid, struct 
>> nvmet_subsys *subsys)
>
> I'd remove the _still_ from the function name.
>
OK, it will be changed in v7.
>> +{
>> +    struct nvmet_ctrl *ctrl;
>> +    bool ret = false;
>> +
>> +    mutex_lock(&subsys->lock);
>> +    list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
>> +        if (uuid_equal(hostid, &ctrl->hostid)) {
>> +            ret = true;
>> +            break;
>> +        }
>> +    }
>> +    mutex_unlock(&subsys->lock);
>> +    return ret;
>> +}
>> +
>>   struct nvmet_ctrl *nvmet_ctrl_find_get(const char *subsysnqn,
>>                          const char *hostnqn, u16 cntlid,
>>                          struct nvmet_req *req)
>> @@ -1447,6 +1482,11 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, 
>> const char *hostnqn,
>>       ctrl->err_counter = 0;
>>       spin_lock_init(&ctrl->error_lock);
>>   +    ctrl->pr_log_mgr.counter = 0;
>> +    ctrl->pr_log_mgr.lost_count = 0;
>> +    mutex_init(&ctrl->pr_log_mgr.lock);
>> +    INIT_KFIFO(ctrl->pr_log_mgr.log_queue);
>> +
>>       nvmet_start_keep_alive_timer(ctrl);
>>         mutex_lock(&subsys->lock);
>> @@ -1485,6 +1525,7 @@ static void nvmet_ctrl_free(struct kref *ref)
>>       cancel_work_sync(&ctrl->fatal_err_work);
>>         nvmet_destroy_auth(ctrl);
>> +    nvmet_ctrl_destroy_pr(ctrl);
>>         ida_free(&cntlid_ida, ctrl->cntlid);
>>   diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
>> index 6c8acebe1a1a..e656ee0ebd30 100644
>> --- a/drivers/nvme/target/nvmet.h
>> +++ b/drivers/nvme/target/nvmet.h
>> @@ -20,6 +20,7 @@
>>   #include <linux/blkdev.h>
>>   #include <linux/radix-tree.h>
>>   #include <linux/t10-pi.h>
>> +#include <linux/kfifo.h>
>>     #define NVMET_DEFAULT_VS        NVME_VS(1, 3, 0)
>>   @@ -30,6 +31,7 @@
>>   #define NVMET_MN_MAX_SIZE        40
>>   #define NVMET_SN_MAX_SIZE        20
>>   #define NVMET_FR_MAX_SIZE        8
>> +#define NVMET_PR_LOG_QUEUE_SIZE        64
>>     /*
>>    * Supported optional AENs:
>> @@ -56,6 +58,21 @@
>>   #define IPO_IATTR_CONNECT_SQE(x)    \
>>       (cpu_to_le32(offsetof(struct nvmf_connect_command, x)))
>>   +struct nvmet_pr_registrant {
>> +    u64            rkey;
>> +    uuid_t            hostid;
>> +    enum nvme_pr_type    rtype;
>> +    struct list_head    entry;
>> +};
>> +
>> +struct nvmet_pr {
>> +    bool            enable;
>> +    atomic_t        generation;
>> +    struct nvmet_pr_registrant __rcu *holder;
>> +    struct mutex        pr_lock;
>> +    struct list_head    registrant_list;
>> +};
>> +
>>   struct nvmet_ns {
>>       struct percpu_ref    ref;
>>       struct bdev_handle    *bdev_handle;
>> @@ -85,6 +102,7 @@ struct nvmet_ns {
>>       int            pi_type;
>>       int            metadata_size;
>>       u8            csi;
>> +    struct nvmet_pr        pr;
>>   };
>>     static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)
>> @@ -190,6 +208,13 @@ static inline bool 
>> nvmet_port_secure_channel_required(struct nvmet_port *port)
>>       return nvmet_port_disc_addr_treq_secure_channel(port) == 
>> NVMF_TREQ_REQUIRED;
>>   }
>>   +struct nvmet_pr_log_mgr {
>> +    struct mutex        lock;
>> +    u64            lost_count;
>> +    u64            counter;
>> +    DECLARE_KFIFO(log_queue, struct nvme_pr_log, 
>> NVMET_PR_LOG_QUEUE_SIZE);
>> +};
>> +
>>   struct nvmet_ctrl {
>>       struct nvmet_subsys    *subsys;
>>       struct nvmet_sq        **sqs;
>> @@ -243,6 +268,7 @@ struct nvmet_ctrl {
>>       u8            *dh_key;
>>       size_t            dh_keysize;
>>   #endif
>> +    struct nvmet_pr_log_mgr pr_log_mgr;
>>   };
>>     struct nvmet_subsys {
>> @@ -750,4 +776,12 @@ static inline bool nvmet_has_auth(struct 
>> nvmet_ctrl *ctrl)
>>   static inline const char *nvmet_dhchap_dhgroup_name(u8 dhgid) { 
>> return NULL; }
>>   #endif
>>   +void nvmet_pr_init_ns(struct nvmet_ns *ns);
>> +u16 nvmet_parse_pr_cmd(struct nvmet_req *req);
>> +u16 nvmet_pr_check_cmd_access(struct nvmet_req *req);
>> +void nvmet_ctrl_destroy_pr(struct nvmet_ctrl *ctrl);
>> +void nvmet_pr_exit_ns(struct nvmet_ns *ns);
>> +bool nvmet_is_host_still_connected(uuid_t *hostid, struct 
>> nvmet_subsys *subsys);
>> +void nvmet_execute_get_log_page_resv(struct nvmet_req *req);
>> +
>>   #endif /* _NVMET_H */
>> diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
>> new file mode 100644
>> index 000000000000..b1317554a5ec
>> --- /dev/null
>> +++ b/drivers/nvme/target/pr.c
>> @@ -0,0 +1,978 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * NVMe over Fabrics Persist Reservation.
>> + * Copyright (c) 2024 Guixin Liu, Alibaba Group.
>> + * All rights reserved.
>> + */
>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> +#include "nvmet.h"
>> +#include <linux/slab.h>
>> +#include <asm/unaligned.h>
>> +#include <linux/lockdep.h>
>> +
>> +struct nvmet_pr_register_data {
>> +    __le64    crkey;
>> +    __le64    nrkey;
>> +};
>> +
>> +struct nvmet_pr_acquire_data {
>> +    __le64    crkey;
>> +    __le64    prkey;
>> +};
>> +
>> +struct nvmet_pr_release_data {
>> +    __le64    crkey;
>> +};
>> +
>> +static inline struct nvmet_ns *nvmet_pr_to_ns(struct nvmet_pr *pr)
>> +{
>> +    return container_of(pr, struct nvmet_ns, pr);
>> +}
>> +
>> +static u16 nvmet_pr_validate_rtype(u8 rtype)
>> +{
>> +    if (rtype < NVME_PR_WRITE_EXCLUSIVE ||
>> +        rtype > NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS)
>> +        return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
>> +
>> +    return NVME_SC_SUCCESS;
>> +}
>> +
>> +static u16 nvmet_pr_set_rtype_and_holder(struct nvmet_pr *pr, u8 rtype,
>> +                     struct nvmet_pr_registrant *reg)
>> +{
>> +    u16 status;
>> +
>> +    status = nvmet_pr_validate_rtype(rtype);
>
> Looking at the two call-sites, seems that sanity checking the
> reservation type needs to happen much earlier. I don't know if
> it makes sense to check it right before assigning the registrant.
>
In some cases, the acquire preempt command will not carry rtype, such as:

the existing rtype is "all regs", and the host send "nvme resv-acquire 
/dev/nvme0n1 --crkey=4 --prkey=5 --racqa=1"

to unregister the registrants whos rkey == prkey, now the rtype is 0.

If I check the rtype at the begin of nvmet_pr_preempt() this will return 
fail,

so I check it if necessary.

> Also the function in addition to just set (A_and_B) it also validates
> A, which seems a bit awkward.

Yeah, it's very confusing, I will think a readble way.

It will be changed in v7.

>> +    if (!status) {
>> +        reg->rtype = rtype;
>> +        rcu_assign_pointer(pr->holder, reg);
>> +    }
>> +    return status;
>> +}
>> +
>> +static struct nvmet_pr_registrant *
>> +nvmet_pr_find_registrant_by_hostid(struct nvmet_pr *pr, uuid_t *hostid)
>
> Is there a find_registrant that is not by_hostid ? If not, you can just
> call it nvmet_pr_find_registrant and pass it the obvious hostid.
>
OK, it will be changed in v7.
>> +{
>> +    struct nvmet_pr_registrant *reg;
>> +
>> +    WARN_ON_ONCE(!rcu_read_lock_held() &&
>> +             !lockdep_is_held(&pr->pr_lock));
>> +
>> +    list_for_each_entry_rcu(reg, &pr->registrant_list, entry,
>> +                rcu_read_lock_held() ||
>> +                lockdep_is_held(&pr->pr_lock)) {
>> +        if (uuid_equal(&reg->hostid, hostid))
>> +            return reg;
>> +    }
>> +    return NULL;
>> +}
>> +
>> +void nvmet_execute_get_log_page_resv(struct nvmet_req *req)
>> +{
>> +    struct nvmet_pr_log_mgr *log_mgr = &req->sq->ctrl->pr_log_mgr;
>> +    struct nvme_pr_log next_log = {0};
>> +    struct nvme_pr_log log = {0};
>> +    u16 status = NVME_SC_SUCCESS;
>> +    u64 lost_count;
>> +    u64 cur_count;
>> +    u64 next_count;
>> +
>> +    mutex_lock(&log_mgr->lock);
>> +    if (!kfifo_get(&log_mgr->log_queue, &log))
>> +        goto out;
>> +
>> +    /*
>> +     * We can't get the last in kfifo.
>> +     * Utilize the current count and the count from the next log to
>> +     * calculate the number of lost logs, while also addressing cases
>> +     * of overflow. If there is no subsequent log, the number of lost
>> +     * logs is equal to the lost_count within the nvmet_pr_log_mgr.
>> +     */
>> +    cur_count = le64_to_cpu(log.count);
>> +    if (kfifo_peek(&log_mgr->log_queue, &next_log)) {
>> +        next_count = le64_to_cpu(next_log.count);
>> +        if (next_count > cur_count)
>> +            lost_count = next_count - cur_count - 1;
>> +        else
>> +            lost_count = U64_MAX - cur_count + next_count - 1;
>> +    } else {
>> +        lost_count = log_mgr->lost_count;
>> +    }
>> +
>> +    log.count = cpu_to_le64(cur_count + lost_count);
>> +    log_mgr->lost_count -= lost_count;
>> +
>> +    log.nr_pages = kfifo_len(&log_mgr->log_queue);
>> +
>> +    status = nvmet_copy_to_sgl(req, 0, &log, sizeof(log));
>> +
>> +out:
>> +    mutex_unlock(&log_mgr->lock);
>> +    nvmet_req_complete(req, status);
>> +}
>> +
>> +static void nvmet_pr_add_resv_log(struct nvmet_ctrl *ctrl, u8 
>> log_type, u32 nsid)
>> +{
>> +    struct nvmet_pr_log_mgr *log_mgr = &ctrl->pr_log_mgr;
>> +    struct nvme_pr_log log = {0};
>> +
>> +    mutex_lock(&log_mgr->lock);
>> +    log_mgr->counter++;
>> +    if (log_mgr->counter == 0)
>> +        log_mgr->counter = 1;
>> +
>> +    log.count = cpu_to_le64(log_mgr->counter);
>> +    log.type = log_type;
>> +    log.nsid = cpu_to_le32(nsid);
>> +
>> +    if (!kfifo_put(&log_mgr->log_queue, log)) {
>> +        pr_warn("a reservation log lost, cntlid:%d, log_type:%d, 
>> nsid:%d\n",
>> +            ctrl->cntlid, log_type, nsid);
>> +        log_mgr->lost_count++;
>> +    }
>> +
>> +    mutex_unlock(&log_mgr->lock);
>> +}
>> +
>> +static void nvmet_pr_send_resv_released(struct nvmet_pr *pr, uuid_t 
>> *hostid)
>
> The function is adding a resv released log entry and adds reservation 
> aen. Perhaps a more appropriate name would be nvmet_pr_resv_released.
>
OK, it will be changed in v7.
>> +{
>> +    struct nvmet_ns *ns = nvmet_pr_to_ns(pr);
>> +    struct nvmet_subsys *subsys = ns->subsys;
>> +    struct nvmet_ctrl *ctrl;
>> +
>> +    mutex_lock(&subsys->lock);
>> +    list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
>> +        if (!uuid_equal(&ctrl->hostid, hostid) &&
>> +            nvmet_pr_find_registrant_by_hostid(pr, &ctrl->hostid)) {
>> +            nvmet_pr_add_resv_log(ctrl,
>> +                NVME_PR_LOG_RESERVATION_RELEASED, ns->nsid);
>
> Dont you need the nvmet_aen_bit_disabled() check?
>
No, this is controled by "reservation notification mask",

I will handle "reservation notification mask" feature command in v7.

>> +            nvmet_add_async_event(ctrl, NVME_AER_CSS,
>> +                NVME_AEN_RESV_LOG_PAGE_AVALIABLE,
>> +                NVME_LOG_RESERVATION);
>> +        }
>> +    }
>> +    mutex_unlock(&subsys->lock);
>> +}
>> +
>> +static void nvmet_pr_send_event_by_hostid(struct nvmet_pr *pr, 
>> uuid_t *hostid,
>> +                      u8 log_type)
>> +{
>> +    struct nvmet_ns *ns = nvmet_pr_to_ns(pr);
>> +    struct nvmet_subsys *subsys = ns->subsys;
>> +    struct nvmet_ctrl *ctrl;
>> +
>> +    mutex_lock(&subsys->lock);
>> +    list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
>> +        if (uuid_equal(hostid, &ctrl->hostid)) {
>> +            nvmet_pr_add_resv_log(ctrl, log_type, ns->nsid);
>
> Dont you need the nvmet_aen_bit_disabled() check?
>
I will handle "reservation notification mask" feature command in v7.
>> +            nvmet_add_async_event(ctrl, NVME_AER_CSS,
>> +                NVME_AEN_RESV_LOG_PAGE_AVALIABLE,
>> +                NVME_LOG_RESERVATION);
>> +        }
>> +    }
>> +    mutex_unlock(&subsys->lock);
>> +}
>> +
>> +static void nvmet_pr_send_resv_preempted(struct nvmet_pr *pr, uuid_t 
>> *hostid)
>> +{
>> +    nvmet_pr_send_event_by_hostid(pr, hostid,
>> +        NVME_PR_LOG_RESERVATOPM_PREEMPTED);
>> +}
>> +
>> +static void nvmet_pr_send_registration_preempted(struct nvmet_pr *pr,
>> +                         uuid_t *hostid)
>> +{
>> +    nvmet_pr_send_event_by_hostid(pr, hostid,
>> +        NVME_PR_LOG_REGISTRATION_PREEMPTED);
>> +}
>> +
>> +static u16 nvmet_pr_register(struct nvmet_req *req,
>> +                 struct nvmet_pr_register_data *d)
>> +{
>> +    struct nvmet_ctrl *ctrl = req->sq->ctrl;
>> +    struct nvmet_pr_registrant *new, *reg;
>> +    struct nvmet_pr *pr = &req->ns->pr;
>> +    u16 status = NVME_SC_SUCCESS;
>> +
>> +    new = kmalloc(sizeof(*new), GFP_KERNEL);
>> +    if (!new)
>> +        return NVME_SC_INTERNAL;
>> +
>> +    mutex_lock(&pr->pr_lock);
>> +    reg = nvmet_pr_find_registrant_by_hostid(pr, &ctrl->hostid);
>> +    if (reg) {
>> +        if (reg->rkey != le64_to_cpu(d->nrkey))
>> +            status = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
>> +        kfree(new);
>> +        goto out;
>> +    }
>> +
>> +    memset(new, 0, sizeof(*new));
>> +    INIT_LIST_HEAD(&new->entry);
>> +    new->rkey = le64_to_cpu(d->nrkey);
>> +    uuid_copy(&new->hostid, &ctrl->hostid);
>> +    list_add_tail_rcu(&new->entry, &pr->registrant_list);
>
> synchronize_rcu() ?
>
I think it's unecessary, I dont see any synchronize_rcu() after 
list_add_tail_rcu

in other places.

>> +
>> +out:
>> +    mutex_unlock(&pr->pr_lock);
>> +    return status;
>> +}
>> +
>> +static void __nvmet_pr_unregister_one(struct nvmet_pr *pr,
>> +                      struct nvmet_pr_registrant *reg)
>
> Question, why the "__" prefix ?
It will be removed in v7.
>> +{
>> +    struct nvmet_pr_registrant *first_reg;
>> +    struct nvmet_pr_registrant *holder;
>> +    u8 original_rtype;
>> +
>> +    lockdep_assert_held(&pr->pr_lock);
>> +    list_del_rcu(&reg->entry);
>> +
>> +    holder = rcu_dereference_protected(pr->holder,
>> +            lockdep_is_held(&pr->pr_lock));
>> +    if (reg != holder)
>> +        goto out;
>> +
>> +    original_rtype = holder->rtype;
>> +    if (original_rtype == NVME_PR_WRITE_EXCLUSIVE_ALL_REGS ||
>> +        original_rtype == NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS) {
>> +        first_reg = list_first_or_null_rcu(&pr->registrant_list,
>> +                struct nvmet_pr_registrant, entry);
>> +        if (first_reg)
>> +            first_reg->rtype = original_rtype;
>> +        rcu_assign_pointer(pr->holder, first_reg);
>> +    } else {
>> +        rcu_assign_pointer(pr->holder, NULL);
>> +
>> +        if (original_rtype == NVME_PR_WRITE_EXCLUSIVE_REG_ONLY ||
>> +            original_rtype == NVME_PR_WRITE_EXCLUSIVE_REG_ONLY)
>> +            nvmet_pr_send_resv_released(pr, &reg->hostid);
>> +    }
>> +out:
>> +    synchronize_rcu();
>> +    kfree(reg);
>> +}
>> +
>> +static u16 nvmet_pr_unregister(struct nvmet_req *req,
>> +                   struct nvmet_pr_register_data *d,
>> +                   bool ignore_key)
>> +{
>> +    u16 status = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
>> +    struct nvmet_ctrl *ctrl = req->sq->ctrl;
>> +    struct nvmet_pr *pr = &req->ns->pr;
>> +    struct nvmet_pr_registrant *reg;
>> +
>> +    mutex_lock(&pr->pr_lock);
>> +    list_for_each_entry_rcu(reg, &pr->registrant_list, entry,
>> +                lockdep_is_held(&pr->pr_lock)) {
>> +        if (uuid_equal(&reg->hostid, &ctrl->hostid)) {
>> +            if (ignore_key || reg->rkey == le64_to_cpu(d->crkey)) {
>> +                status = NVME_SC_SUCCESS;
>> +                __nvmet_pr_unregister_one(pr, reg);
>> +            }
>> +            break;
>> +        }
>> +    }
>> +    mutex_unlock(&pr->pr_lock);
>> +
>> +    return status;
>> +}
>> +
>> +static u16 nvmet_pr_update_reg_rkey(struct nvmet_pr_registrant *reg,
>> +                    void *attr)
>> +{
>> +    reg->rkey = *(u64 *)attr;
>> +    return NVME_SC_SUCCESS;
>> +}
>> +
>> +static u16 nvmet_pr_update_reg_attr(struct nvmet_pr *pr,
>> +                    struct nvmet_pr_registrant *reg,
>> +                    u16 (*change_attr)(struct nvmet_pr_registrant 
>> *reg, void *attr),
>> +                    void *attr)
>> +{
>> +    struct nvmet_pr_registrant *holder;
>> +    struct nvmet_pr_registrant *new;
>> +    u16 status;
>> +
>> +    lockdep_assert_held(&pr->pr_lock);
>> +    holder = rcu_dereference_protected(pr->holder,
>> +            lockdep_is_held(&pr->pr_lock));
>> +    if (reg != holder)
>> +        return change_attr(reg, attr);
>> +
>> +    new = kmalloc(sizeof(*new), GFP_ATOMIC);
>
> Is it mandatory to resort to a GFP_ATOMIC allocation ?
>
I should hold the pr_lock here, because the reg may be unregistered by 
other hosts

or the holder may be changed if I unlock the pr_lock,

And in order to not sleep in mutex lock, I use GFP_ATOMIC here.

If I alloc the new at the begin of "execute function", it will be propagated

layer upon layer, this is not elegant.

> Why is this allocating a new registrant struct anyways? Why not simply
> update the existing reg?

Because the holder is rcu protected, if I change it simply,

it will break the consistency of the readers.

>
>> +    if (!new)
>> +        return NVME_SC_INTERNAL;
>> +
>> +    new->rkey = holder->rkey;
>> +    new->rtype = holder->rtype;
>> +    uuid_copy(&new->hostid, &holder->hostid);
>> +    INIT_LIST_HEAD(&new->entry);
>> +
>> +    status = change_attr(new, attr);
>> +    if (!status) {
>> +        list_replace_rcu(&holder->entry, &new->entry);
>> +        rcu_assign_pointer(pr->holder, new);
>> +        synchronize_rcu();
>> +        kfree(holder);
>> +    } else {
>> +        kfree(new);
>> +    }
>> +
>> +    return status;
>> +}
>> +
>> +static u16 nvmet_pr_replace(struct nvmet_req *req,
>> +                struct nvmet_pr_register_data *d,
>> +                bool ignore_key)
>> +{
>> +    u16 status = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
>> +    struct nvmet_ctrl *ctrl = req->sq->ctrl;
>> +    struct nvmet_pr *pr = &req->ns->pr;
>> +    struct nvmet_pr_registrant *reg;
>> +    u64 nrkey = le64_to_cpu(d->nrkey);
>> +
>> +    mutex_lock(&pr->pr_lock);
>> +    list_for_each_entry_rcu(reg, &pr->registrant_list, entry,
>> +                lockdep_is_held(&pr->pr_lock)) {
>> +        if (uuid_equal(&reg->hostid, &ctrl->hostid)) {
>> +            if (ignore_key || reg->rkey == le64_to_cpu(d->crkey))
>> +                status = nvmet_pr_update_reg_attr(pr, reg,
>> +                        nvmet_pr_update_reg_rkey,
>> +                        &nrkey);
>> +            break;
>> +        }
>> +    }
>> +    mutex_unlock(&pr->pr_lock);
>> +    return status;
>> +}
>> +
>> +static void nvmet_execute_pr_register(struct nvmet_req *req)
>> +{
>> +    u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
>> +    bool ignore_key = (bool)((cdw10 >> 3) & 1); /* Ignore existing 
>> key, bit 03 */
>> +    struct nvmet_pr_register_data *d;
>> +    u8 reg_act = cdw10 & 0x07; /* Reservation Register Action, bit 
>> 02:00 */
>> +    u16 status;
>> +
>> +    d = kmalloc(sizeof(*d), GFP_KERNEL);
>> +    if (!d) {
>> +        status = NVME_SC_INTERNAL;
>> +        goto out;
>> +    }
>> +
>> +    status = nvmet_copy_from_sgl(req, 0, d, sizeof(*d));
>> +    if (status)
>> +        goto free_data;
>> +
>> +    switch (reg_act) {
>> +    case NVME_PR_REGISTER_ACT_REG:
>> +        status = nvmet_pr_register(req, d);
>> +        break;
>> +    case NVME_PR_REGISTER_ACT_UNREG:
>> +        status = nvmet_pr_unregister(req, d, ignore_key);
>> +        break;
>> +    case NVME_PR_REGISTER_ACT_REPLACE:
>> +        status = nvmet_pr_replace(req, d, ignore_key);
>> +        break;
>> +    default:
>> +        req->error_loc = offsetof(struct nvme_common_command, cdw10);
>> +        status = NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
>> +        break;
>> +    }
>> +free_data:
>> +    kfree(d);
>> +out:
>> +    if (!status)
>> +        atomic_inc(&req->ns->pr.generation);
>> +    nvmet_req_complete(req, status);
>> +}
>> +
>> +static u16 nvmet_pr_acquire(struct nvmet_req *req,
>> +                struct nvmet_pr_registrant *reg,
>> +                u8 rtype)
>> +{
>> +    struct nvmet_pr *pr = &req->ns->pr;
>> +    struct nvmet_pr_registrant *holder;
>> +
>> +    lockdep_assert_held(&pr->pr_lock);
>> +    holder = rcu_dereference_protected(pr->holder,
>> +            lockdep_is_held(&pr->pr_lock));
>> +    if (holder && reg != holder)
>> +        return  NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
>> +    if (holder && reg == holder) {
>> +        if (holder->rtype == rtype)
>> +            return NVME_SC_SUCCESS;
>> +        return NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
>> +    }
>> +
>> +    return nvmet_pr_set_rtype_and_holder(pr, rtype, reg);
>> +}
>> +
>> +static u16 nvmet_pr_unreg_by_prkey(struct nvmet_pr *pr, u64 prkey,
>> +                   uuid_t *send_hostid)
>> +{
>> +    u16 status = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
>> +    struct nvmet_pr_registrant *reg, *tmp;
>> +
>> +    lockdep_assert_held(&pr->pr_lock);
>> +
>> +    list_for_each_entry_safe(reg, tmp, &pr->registrant_list, entry) {
>> +        if (reg->rkey == prkey) {
>> +            status = NVME_SC_SUCCESS;
>> +            if (!uuid_equal(&reg->hostid, send_hostid))
>> +                nvmet_pr_send_registration_preempted(pr,
>> +                    &reg->hostid);
>> +            __nvmet_pr_unregister_one(pr, reg);
>
> I think the order should be reversed? first unregister (preemt) then
> send an event?
>
Yeah, my simple consideration is that I dont need to save

the reg's hostid.

Any way, it will be changed in v7.

>> +        }
>> +    }
>> +    return status;
>> +}
>> +
>> +static u16 nvmet_pr_unreg_by_prkey_except_hostid(struct nvmet_pr 
>> *pr, u64 prkey,
>> +                         uuid_t *send_hostid)
>> +{
>> +    u16 status = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
>> +    struct nvmet_pr_registrant *reg, *tmp;
>> +
>> +    lockdep_assert_held(&pr->pr_lock);
>> +
>> +    list_for_each_entry_safe(reg, tmp, &pr->registrant_list, entry) {
>> +        if (reg->rkey == prkey &&
>> +            !uuid_equal(&reg->hostid, send_hostid)) {
>> +            status = NVME_SC_SUCCESS;
>> +            nvmet_pr_send_registration_preempted(pr, &reg->hostid);
>> +            __nvmet_pr_unregister_one(pr, reg);
>
> Same comment?
>
Same as before.
>> +        }
>> +    }
>> +    return status;
>> +}
>> +
>> +static void nvmet_pr_unreg_except_hostid(struct nvmet_pr *pr,
>> +                     uuid_t *send_hostid)
>> +{
>> +    struct nvmet_pr_registrant *reg, *tmp;
>> +
>> +    lockdep_assert_held(&pr->pr_lock);
>> +
>> +    list_for_each_entry_safe(reg, tmp, &pr->registrant_list, entry) {
>> +        if (!uuid_equal(&reg->hostid, send_hostid)) {
>> +            nvmet_pr_send_registration_preempted(pr, &reg->hostid);
>> +            __nvmet_pr_unregister_one(pr, reg);
Same as before.
>> +        }
>> +    }
>> +}
>> +
>> +static u16 nvmet_pr_create_new_resv(struct nvmet_pr *pr,
>> +                    u8 original_rtype,
>> +                    u8 new_rtype,
>> +                    struct nvmet_pr_registrant *reg)
>> +{
>> +    u16 status;
>> +
>> +    status = nvmet_pr_set_rtype_and_holder(pr, new_rtype, reg);
>> +    if (!status && original_rtype != new_rtype)
>> +        nvmet_pr_send_resv_released(pr, &reg->hostid);
>> +    return status;
>> +}
>> +
>> +static u16 nvmet_pr_update_holder_rtype(struct nvmet_pr_registrant 
>> *reg,
>> +                    void *attr)
>> +{
>> +    u8 new_rtype = *(u8 *)attr;
>> +    u16 status;
>> +
>> +    status = nvmet_pr_validate_rtype(new_rtype);
>
> Again, I'd expect a sanity argument check to be
> at the very beginning (next to where it is being extracted).
>
>> +    if (status)
>> +        return status;
>> +
>> +    reg->rtype = new_rtype;
>> +    return NVME_SC_SUCCESS;
>> +}
>> +
>> +static u16 nvmet_pr_preempt(struct nvmet_req *req,
>> +                struct nvmet_pr_registrant *reg,
>> +                u8 rtype,
>> +                struct nvmet_pr_acquire_data *d)
>> +{
>> +    struct nvmet_ctrl *ctrl = req->sq->ctrl;
>> +    struct nvmet_pr *pr = &req->ns->pr;
>> +    struct nvmet_pr_registrant *holder;
>> +    enum nvme_pr_type original_rtype;
>> +    u16 status;
>> +
>> +    lockdep_assert_held(&pr->pr_lock);
>> +    holder = rcu_dereference_protected(pr->holder,
>> +            lockdep_is_held(&pr->pr_lock));
>> +    if (!holder)
>> +        return nvmet_pr_unreg_by_prkey(pr, le64_to_cpu(d->prkey),
>> +                &ctrl->hostid);
>> +
>> +    original_rtype = holder->rtype;
>> +    if (original_rtype == NVME_PR_WRITE_EXCLUSIVE_ALL_REGS ||
>> +        original_rtype == NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS) {
>> +        if (!le64_to_cpu(d->prkey)) {
>> +            nvmet_pr_unreg_except_hostid(pr, &ctrl->hostid);
>> +            return nvmet_pr_create_new_resv(pr, original_rtype,
>> +                    rtype, reg);
>> +        }
>> +        return nvmet_pr_unreg_by_prkey(pr, le64_to_cpu(d->prkey),
>> +                &ctrl->hostid);
>> +    }
>> +
>> +    if (holder == reg) {
>> +        status = nvmet_pr_update_reg_attr(pr, holder,
>> +                nvmet_pr_update_holder_rtype, &rtype);
>> +        if (status)
>> +            return status;
>> +        if (original_rtype != rtype)
>> +            nvmet_pr_send_resv_released(pr, &reg->hostid);
>> +        return status;
>> +    }
>> +
>> +    if (le64_to_cpu(d->prkey) == holder->rkey) {
>> +        status = nvmet_pr_unreg_by_prkey_except_hostid(pr,
>> +                le64_to_cpu(d->prkey), &ctrl->hostid);
>> +        if (status)
>> +            return status;
>> +        return nvmet_pr_create_new_resv(pr, original_rtype, rtype, 
>> reg);
>> +    }
>> +
>> +    if (le64_to_cpu(d->prkey))
>> +        return nvmet_pr_unreg_by_prkey(pr, le64_to_cpu(d->prkey),
>> +                &ctrl->hostid);
>> +    return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
>> +}
>> +
>> +static u16 __nvmet_execute_pr_acquire(struct nvmet_req *req,
>> +                      struct nvmet_pr_registrant *reg,
>> +                      u8 acquire_act,
>> +                      u8 rtype,
>> +                      struct nvmet_pr_acquire_data *d)
>> +{
>> +    u16 status;
>> +
>> +    switch (acquire_act) {
>> +    case NVME_PR_ACQUIRE_ACT_ACQUIRE:
>> +        status = nvmet_pr_acquire(req, reg, rtype);
>> +        goto out;
>> +    case NVME_PR_ACQUIRE_ACT_PREEMPT:
>> +        status = nvmet_pr_preempt(req, reg, rtype, d);
>> +        goto inc_gen;
>> +    case NVME_PR_ACQUIRE_ACT_PREEMPT_AND_ABORT:
>> +        status = nvmet_pr_preempt(req, reg, rtype, d);
>> +        goto inc_gen;
>> +    default:
>> +        req->error_loc = offsetof(struct nvme_common_command, cdw10);
>> +        status = NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
>> +        goto out;
>> +    }
>> +inc_gen:
>> +    if (!status)
>> +        atomic_inc(&req->ns->pr.generation);
>> +out:
>> +    return status;
>> +}
>> +
>> +static void nvmet_execute_pr_acquire(struct nvmet_req *req)
>> +{
>> +    u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
>> +    bool ignore_key = (bool)((cdw10 >> 3) & 1); /* Ignore existing 
>> key, bit 03 */
>> +    u8 rtype = (u8)((cdw10 >> 8) & 0xff); /* Reservation type, bit 
>> 15:08 */
>> +    u8 acquire_act = cdw10 & 0x07; /* Reservation acquire action, 
>> bit 02:00 */
>> +    struct nvmet_ctrl *ctrl = req->sq->ctrl;
>> +    struct nvmet_pr_acquire_data *d = NULL;
>> +    struct nvmet_pr *pr = &req->ns->pr;
>> +    struct nvmet_pr_registrant *reg;
>> +    u16 status = NVME_SC_SUCCESS;
>> +
>> +    if (ignore_key) {
>> +        status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
>> +        goto out;
>> +    }
>> +
>> +    d = kmalloc(sizeof(*d), GFP_KERNEL);
>> +    if (!d) {
>> +        status = NVME_SC_INTERNAL;
>> +        goto out;
>> +    }
>> +
>> +    status = nvmet_copy_from_sgl(req, 0, d, sizeof(*d));
>> +    if (status)
>> +        goto free_data;
>> +
>> +    status = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
>> +    mutex_lock(&pr->pr_lock);
>> +    list_for_each_entry_rcu(reg, &pr->registrant_list, entry,
>> +                lockdep_is_held(&pr->pr_lock)) {
>> +        if (uuid_equal(&reg->hostid, &ctrl->hostid) &&
>> +            reg->rkey == le64_to_cpu(d->crkey)) {
>> +            status = __nvmet_execute_pr_acquire(req, reg,
>> +                    acquire_act, rtype, d);
>> +            break;
>> +        }
>> +    }
>> +    mutex_unlock(&pr->pr_lock);
>> +
>> +free_data:
>> +    kfree(d);
>> +out:
>> +    nvmet_req_complete(req, status);
>> +}
>> +
>> +static u16 nvmet_pr_release(struct nvmet_req *req,
>> +                struct nvmet_pr_registrant *reg,
>> +                u8 rtype)
>> +{
>> +    struct nvmet_pr *pr = &req->ns->pr;
>> +    struct nvmet_pr_registrant *holder;
>> +    u8 original_rtype;
>> +
>> +    lockdep_assert_held(&pr->pr_lock);
>> +    holder = rcu_dereference_protected(pr->holder,
>> +            lockdep_is_held(&pr->pr_lock));
>> +    if (!holder || reg != holder)
>> +        return NVME_SC_SUCCESS;
>> +
>> +    original_rtype = holder->rtype;
>> +    if (original_rtype != rtype)
>> +        return NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
>> +
>> +    rcu_assign_pointer(pr->holder, NULL);
>> +
>> +    if (original_rtype != NVME_PR_WRITE_EXCLUSIVE &&
>> +        original_rtype != NVME_PR_EXCLUSIVE_ACCESS)
>> +        nvmet_pr_send_resv_released(pr, &reg->hostid);
>> +
>> +    return NVME_SC_SUCCESS;
>> +}
>> +
>> +static void nvmet_pr_clear(struct nvmet_req *req)
>> +{
>> +    struct nvmet_pr_registrant *reg, *tmp;
>> +    struct nvmet_pr *pr = &req->ns->pr;
>> +
>> +    lockdep_assert_held(&pr->pr_lock);
>> +
>> +    rcu_assign_pointer(pr->holder, NULL);
>> +
>> +    list_for_each_entry_safe(reg, tmp, &pr->registrant_list, entry) {
>> +        list_del_rcu(&reg->entry);
>> +        if (!uuid_equal(&req->sq->ctrl->hostid, &reg->hostid))
>> +            nvmet_pr_send_resv_preempted(pr, &reg->hostid);
>> +        synchronize_rcu();
>
> I think that in this case you splice to a local list and safely free
> all elements, waiting rcu grace period in every iteration is
> inefficient.
>
OK, it will be changed in v7.
>> +        kfree(reg);
>> +    }
>> +
>> +    atomic_inc(&pr->generation);
>> +}
>> +
>> +static u16 __nvmet_execute_pr_release(struct nvmet_req *req,
>> +                      struct nvmet_pr_registrant *reg,
>> +                      u8 release_act, u8 rtype)
>> +{
>> +    switch (release_act) {
>> +    case NVME_PR_RELEASE_ACT_RELEASE:
>> +        return nvmet_pr_release(req, reg, rtype);
>> +    case NVME_PR_RELEASE_ACT_CLEAR:
>> +        nvmet_pr_clear(req);
>> +        return NVME_SC_SUCCESS;
>> +    default:
>> +        req->error_loc = offsetof(struct nvme_common_command, cdw10);
>> +        return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
>> +    }
>> +}
>> +
>> +static void nvmet_execute_pr_release(struct nvmet_req *req)
>> +{
>> +    u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
>> +    bool ignore_key = (bool)((cdw10 >> 3) & 1); /* Ignore existing 
>> key, bit 03 */
>> +    u8 rtype = (u8)((cdw10 >> 8) & 0xff); /* Reservation type, bit 
>> 15:08 */
>> +    u8 release_act = cdw10 & 0x07; /* Reservation release action, 
>> bit 02:00 */
>> +    struct nvmet_ctrl *ctrl = req->sq->ctrl;
>> +    struct nvmet_pr *pr = &req->ns->pr;
>> +    struct nvmet_pr_release_data *d;
>> +    struct nvmet_pr_registrant *reg;
>> +    u16 status;
>> +
>> +    if (ignore_key) {
>> +        status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
>> +        goto out;
>> +    }
>> +
>> +    d = kmalloc(sizeof(*d), GFP_KERNEL);
>> +    if (!d) {
>> +        status = NVME_SC_INTERNAL;
>> +        goto out;
>> +    }
>> +
>> +    status = nvmet_copy_from_sgl(req, 0, d, sizeof(*d));
>> +    if (status)
>> +        goto free_data;
>> +
>> +    status = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
>> +    mutex_lock(&pr->pr_lock);
>> +    list_for_each_entry_rcu(reg, &pr->registrant_list, entry,
>> +                lockdep_is_held(&pr->pr_lock)) {
>> +        if (uuid_equal(&reg->hostid, &ctrl->hostid) &&
>> +            reg->rkey == le64_to_cpu(d->crkey)) {
>> +            status = __nvmet_execute_pr_release(req, reg,
>> +                    release_act, rtype);
>> +            break;
>> +        }
>> +    }
>> +    mutex_unlock(&pr->pr_lock);
>> +free_data:
>> +    kfree(d);
>> +out:
>> +    nvmet_req_complete(req, status);
>> +}
>> +
>> +static void nvmet_execute_pr_report(struct nvmet_req *req)
>> +{
>> +    u32 cdw11 = le32_to_cpu(req->cmd->common.cdw11);
>> +    u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
>> +    u32 num_bytes = 4 * (cdw10 + 1); /* cdw10 is number of dwords */
>> +    u8 eds = cdw11 & 1; /* Extended data structure, bit 00 */
>> +    struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
>> +    struct nvme_registered_ctrl_ext *ctrl_eds;
>> +    struct nvme_reservation_status_ext *data;
>> +    struct nvmet_pr *pr = &req->ns->pr;
>> +    struct nvmet_pr_registrant *holder;
>> +    struct nvmet_pr_registrant *reg;
>> +    struct nvmet_ctrl *ctrl;
>> +    u16 num_ctrls = 0;
>> +    u16 status;
>> +    u8 rtype;
>> +
>> +    /* nvmet hostid(uuid_t) is 128 bit. */
>> +    if (!eds) {
>> +        req->error_loc = offsetof(struct nvme_common_command, cdw11);
>> +        status = NVME_SC_HOST_ID_INCONSIST | NVME_SC_DNR;
>> +        goto out;
>> +    }
>> +
>> +    if (num_bytes < sizeof(struct nvme_reservation_status_ext)) {
>> +        req->error_loc = offsetof(struct nvme_common_command, cdw10);
>> +        status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
>> +        goto out;
>> +    }
>> +
>> +    mutex_lock(&subsys->lock);
>> +    num_ctrls = list_count_nodes(&subsys->ctrls);
>> +    mutex_unlock(&subsys->lock);
>> +
>> +    num_bytes = min(num_bytes,
>> +            sizeof(struct nvme_reservation_status_ext) +
>> +            sizeof(struct nvme_registered_ctrl_ext) * num_ctrls);
>> +
>> +    data = kmalloc(num_bytes, GFP_KERNEL);
>> +    if (!data) {
>> +        status = NVME_SC_INTERNAL;
>> +        goto out;
>> +    }
>> +    memset(data, 0, num_bytes);
>> +    data->gen = cpu_to_le32(atomic_read(&pr->generation));
>> +    data->ptpls = 0;
>> +    ctrl_eds = data->regctl_eds;
>> +
>> +    mutex_lock(&subsys->lock);
>> +    rcu_read_lock();
>> +    holder = rcu_dereference(pr->holder);
>> +    rtype = holder ? holder->rtype : 0;
>> +    data->rtype = rtype;
>> +    num_ctrls = 0;
>> +    list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
>> +        if ((void *)ctrl_eds >= (void *)(data + num_bytes))
>> +            break;
>> +        reg = nvmet_pr_find_registrant_by_hostid(pr, &ctrl->hostid);
>> +        if (!reg)
>> +            continue;
>> +        ctrl_eds->cntlid = cpu_to_le16(ctrl->cntlid);
>> +        if (rtype == NVME_PR_WRITE_EXCLUSIVE_ALL_REGS ||
>> +            rtype == NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS)
>> +            ctrl_eds->rcsts = 1;
>> +        if (holder && uuid_equal(&ctrl->hostid, &holder->hostid))
>> +            ctrl_eds->rcsts = 1;
>> +        uuid_copy((uuid_t *)&ctrl_eds->hostid, &ctrl->hostid);
>> +        ctrl_eds->rkey = cpu_to_le64(reg->rkey);
>> +        ctrl_eds++;
>> +        num_ctrls++;
>> +    }
>> +    rcu_read_unlock();
>> +    mutex_unlock(&subsys->lock);
>> +
>> +    put_unaligned_le16(num_ctrls, data->regctl);
>> +    num_bytes = sizeof(struct nvme_reservation_status_ext) +
>> +            sizeof(struct nvme_registered_ctrl_ext) * num_ctrls;
>> +    status = nvmet_copy_to_sgl(req, 0, data, num_bytes);
>> +    kfree(data);
>> +out:
>> +    nvmet_req_complete(req, status);
>> +}
>> +
>> +u16 nvmet_parse_pr_cmd(struct nvmet_req *req)
>> +{
>> +    struct nvme_command *cmd = req->cmd;
>> +
>> +    switch (cmd->common.opcode) {
>> +    case nvme_cmd_resv_register:
>> +        req->execute = nvmet_execute_pr_register;
>> +        break;
>> +    case nvme_cmd_resv_acquire:
>> +        req->execute = nvmet_execute_pr_acquire;
>> +        break;
>> +    case nvme_cmd_resv_release:
>> +        req->execute = nvmet_execute_pr_release;
>> +        break;
>> +    case nvme_cmd_resv_report:
>> +        req->execute = nvmet_execute_pr_report;
>> +        break;
>> +    default:
>> +        return 1;
>> +    }
>> +    return NVME_SC_SUCCESS;
>> +}
>> +
>> +static bool nvmet_is_req_write_cmd_group(struct nvmet_req *req)
>> +{
>> +    u8 opcode = req->cmd->common.opcode;
>> +
>> +    if (req->sq->qid) {
>> +        switch (opcode) {
>> +        case nvme_cmd_flush:
>> +        case nvme_cmd_write:
>> +        case nvme_cmd_write_zeroes:
>> +        case nvme_cmd_dsm:
>> +        case nvme_cmd_zone_append:
>> +        case nvme_cmd_zone_mgmt_send:
>> +            return true;
>> +        default:
>> +            return false;
>> +        }
>> +    }
>> +    return false;
>> +}
>> +
>> +static bool nvmet_is_req_read_cmd_group(struct nvmet_req *req)
>> +{
>> +    u8 opcode = req->cmd->common.opcode;
>> +
>> +    if (req->sq->qid) {
>> +        switch (opcode) {
>> +        case nvme_cmd_read:
>> +        case nvme_cmd_zone_mgmt_recv:
>> +            return true;
>> +        default:
>> +            return false;
>> +        }
>> +    }
>> +    return false;
>> +}
>> +
>> +u16 nvmet_pr_check_cmd_access(struct nvmet_req *req)
>> +{
>> +    struct nvmet_ctrl *ctrl = req->sq->ctrl;
>> +    struct nvmet_pr_registrant *holder;
>> +    struct nvmet_ns *ns = req->ns;
>> +    struct nvmet_pr *pr = &ns->pr;
>> +    u16 status = NVME_SC_SUCCESS;
>> +
>> +    rcu_read_lock();
>> +    holder = rcu_dereference(pr->holder);
>> +    if (!holder)
>> +        goto unlock;
>> +    if (uuid_equal(&ctrl->hostid, &holder->hostid))
>> +        goto unlock;
>> +
>> +    /*
>> +     * The Reservation command group is checked in executing,
>> +     * allow it here.
>> +     */
>> +    switch (holder->rtype) {
>> +    case NVME_PR_WRITE_EXCLUSIVE:
>> +        if (nvmet_is_req_write_cmd_group(req))
>> +            status = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
>> +        break;
>> +    case NVME_PR_EXCLUSIVE_ACCESS:
>> +        if (nvmet_is_req_read_cmd_group(req) ||
>> +            nvmet_is_req_write_cmd_group(req))
>> +            status = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
>> +        break;
>> +    case NVME_PR_WRITE_EXCLUSIVE_REG_ONLY:
>> +    case NVME_PR_WRITE_EXCLUSIVE_ALL_REGS:
>> +        if ((nvmet_is_req_write_cmd_group(req)) &&
>> +            !nvmet_pr_find_registrant_by_hostid(pr, &ctrl->hostid))
>> +            status = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
>> +        break;
>> +    case NVME_PR_EXCLUSIVE_ACCESS_REG_ONLY:
>> +    case NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS:
>> +        if ((nvmet_is_req_read_cmd_group(req) ||
>> +            nvmet_is_req_write_cmd_group(req)) &&
>> +            !nvmet_pr_find_registrant_by_hostid(pr, &ctrl->hostid))
>> +            status = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
>> +        break;
>> +    default:
>> +        pr_warn("the reservation type is set wrong, type:%d\n",
>> +            holder->rtype);
>> +        break;
>> +    }
>> +
>> +unlock:
>> +    rcu_read_unlock();
>> +    if (status)
>> +        req->error_loc = offsetof(struct nvme_common_command, opcode);
>> +    return status;
>> +}
>> +
>> +void nvmet_ctrl_destroy_pr(struct nvmet_ctrl *ctrl)
>> +{
>> +    struct nvmet_pr_registrant *reg;
>> +    struct nvmet_ns *ns;
>> +    unsigned long idx;
>> +
>> +    kfifo_free(&ctrl->pr_log_mgr.log_queue);
>> +    mutex_destroy(&ctrl->pr_log_mgr.lock);
>> +
>> +    if (nvmet_is_host_still_connected(&ctrl->hostid, ctrl->subsys))
>> +        return;
>> +
>> +    xa_for_each(&ctrl->subsys->namespaces, idx, ns) {
>> +        mutex_lock(&ns->pr.pr_lock);
>> +        list_for_each_entry_rcu(reg, &ns->pr.registrant_list, entry,
>> +                    lockdep_is_held(&ns->pr.pr_lock)) {
>> +            if (uuid_equal(&reg->hostid, &ctrl->hostid)) {
>> +                __nvmet_pr_unregister_one(&ns->pr, reg);
>> +                break;
>> +            }
>> +        }
>> +        mutex_unlock(&ns->pr.pr_lock);
>> +    }
>> +}
>> +
>> +void nvmet_pr_exit_ns(struct nvmet_ns *ns)
>> +{
>> +    struct nvmet_pr_registrant *reg;
>> +    struct nvmet_pr_registrant *tmp;
>> +    struct nvmet_pr *pr = &ns->pr;
>> +
>> +    mutex_lock(&pr->pr_lock);
>> +    rcu_assign_pointer(pr->holder, NULL);
>> +    list_for_each_entry_safe(reg, tmp, &pr->registrant_list, entry) {
>> +        list_del_rcu(&reg->entry);
>> +        synchronize_rcu();
>> +        kfree(reg);
>> +    }
>> +    mutex_unlock(&pr->pr_lock);
>> +
>> +    mutex_destroy(&pr->pr_lock);
>> +}
>> +
>> +void nvmet_pr_init_ns(struct nvmet_ns *ns)
>> +{
>> +    ns->pr.holder = NULL;
>> +    atomic_set(&ns->pr.generation, 0);
>> +    mutex_init(&ns->pr.pr_lock);
>> +    INIT_LIST_HEAD(&ns->pr.registrant_list);
>> +}
>> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
>> index 462c21e0e417..5140889ea04f 100644
>> --- a/include/linux/nvme.h
>> +++ b/include/linux/nvme.h
>> @@ -745,6 +745,26 @@ enum {
>>       NVME_AEN_CFG_DISC_CHANGE    = 1 << NVME_AEN_BIT_DISC_CHANGE,
>>   };
>>   +enum {
>> +    NVME_AEN_RESV_LOG_PAGE_AVALIABLE    = 0x00,
>> +};
>> +
>> +enum {
>> +    NVME_PR_LOG_EMPTY_LOG_PAGE            = 0x00,
>> +    NVME_PR_LOG_REGISTRATION_PREEMPTED        = 0x01,
>> +    NVME_PR_LOG_RESERVATION_RELEASED        = 0x02,
>> +    NVME_PR_LOG_RESERVATOPM_PREEMPTED        = 0x03,
>> +};
>> +
>> +struct nvme_pr_log {
>> +    __le64            count;
>> +    __u8            type;
>> +    __u8            nr_pages;
>> +    __u8            rsvd1[2];
>> +    __le32            nsid;
>> +    __u8            rsvd2[48];
>> +};
>> +
>>   struct nvme_lba_range_type {
>>       __u8            type;
>>       __u8            attributes;
>> @@ -765,6 +785,17 @@ enum {
>>       NVME_LBART_ATTRIB_HIDE    = 1 << 1,
>>   };
>>   +enum nvme_pr_capabilities {
>> +    NVME_PR_SUPPORT_PTPL                = 1,
>> +    NVME_PR_SUPPORT_WRITE_EXCLUSIVE            = 1 << 1,
>> +    NVME_PR_SUPPORT_EXCLUSIVE_ACCESS        = 1 << 2,
>> +    NVME_PR_SUPPORT_WRITE_EXCLUSIVE_REG_ONLY    = 1 << 3,
>> +    NVME_PR_SUPPORT_EXCLUSIVE_ACCESS_REG_ONLY    = 1 << 4,
>> +    NVME_PR_SUPPORT_WRITE_EXCLUSIVE_ALL_REGS    = 1 << 5,
>> +    NVME_PR_SUPPORT_EXCLUSIVE_ACCESS_ALL_REGS    = 1 << 6,
>> +    NVME_PR_SUPPORT_IEKEY_VER_1_3_DEF        = 1 << 7,
>> +};
>> +
>>   enum nvme_pr_type {
>>       NVME_PR_WRITE_EXCLUSIVE            = 1,
>>       NVME_PR_EXCLUSIVE_ACCESS        = 2,
>> @@ -774,6 +805,23 @@ enum nvme_pr_type {
>>       NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS    = 6,
>>   };
>>   +enum nvme_pr_register_action {
>> +    NVME_PR_REGISTER_ACT_REG        = 0,
>> +    NVME_PR_REGISTER_ACT_UNREG        = 1,
>> +    NVME_PR_REGISTER_ACT_REPLACE        = 1 << 1,
>> +};
>> +
>> +enum nvme_pr_acquire_action {
>> +    NVME_PR_ACQUIRE_ACT_ACQUIRE        = 0,
>> +    NVME_PR_ACQUIRE_ACT_PREEMPT        = 1,
>> +    NVME_PR_ACQUIRE_ACT_PREEMPT_AND_ABORT    = 1 << 1,
>> +};
>> +
>> +enum nvme_pr_release_action {
>> +    NVME_PR_RELEASE_ACT_RELEASE        = 0,
>> +    NVME_PR_RELEASE_ACT_CLEAR        = 1,
>> +};
>> +
>>   enum nvme_eds {
>>       NVME_EXTENDED_DATA_STRUCT    = 0x1,
>>   };

