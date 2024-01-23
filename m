Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FDBC47258
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 11:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2l7U2xTDcTKqDeX9pmpRkSKEcrqI9lso+NWCU7oHG7k=; b=K+YH66VuRZt7D2VmRswbl+q0wg
	mW0MBXZQbNu8SG+4up2+dyBpgVGv1mXqTeV0LgZJK2GOjR98lxiEORwcxGHgrrEIJ6vybWijgaWTY
	klIww3HDo+f1qX4xCCRmmoli6CVPReu3rEosI3n042+jb10UP4oR5pHGVnr05689Gf1rWcMJN9fz/
	C2l0EUnZfLe3eP1TFLlUbCF9Nzfi68R9iDXsTFXwpuMLQAuEatjwpQVCqockmxzwCDK+q4tvznF72
	mRAanfqc7qFkiaJPXwdi+YacfX1pmNysP3Uo9ne1zAPFMz1pqXmXizkNX8eyHGAnn3YmHwbgb4ad7
	/yI8Pw6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSEW3-00G2qy-2C;
	Tue, 23 Jan 2024 11:00:27 +0000
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSDLf-00FnT8-2p
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 09:45:50 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W.CKjyK_1706003132;
Received: from 30.178.83.152(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W.CKjyK_1706003132)
          by smtp.aliyun-inc.com;
          Tue, 23 Jan 2024 17:45:33 +0800
Message-ID: <dacdc03e-6905-4009-af34-149520de1dc3@linux.alibaba.com>
Date: Tue, 23 Jan 2024 17:45:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/1] nvmet: support reservation feature
Content-Language: en-GB
To: Sagi Grimberg <sagi@grimberg.me>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de, kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
References: <20240118125057.56200-1-kanie@linux.alibaba.com>
 <20240118125057.56200-2-kanie@linux.alibaba.com>
 <d201893b-e2c8-4265-a634-472459f6bda6@grimberg.me>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <d201893b-e2c8-4265-a634-472459f6bda6@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_014540_446895_70D0BCE0 
X-CRM114-Status: GOOD (  18.67  )
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


在 2024/1/22 21:03, Sagi Grimberg 写道:
>
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
>>   drivers/nvme/target/core.c      |  50 +-
>>   drivers/nvme/target/nvmet.h     |  35 ++
>>   drivers/nvme/target/pr.c        | 956 ++++++++++++++++++++++++++++++++
>>   include/linux/nvme.h            |  48 ++
>>   7 files changed, 1125 insertions(+), 7 deletions(-)
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
>> index d937fe05129e..1ac4802ec818 100644
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
>> index 3935165048e7..5bacffc59848 100644
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
>> @@ -651,6 +653,7 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
>>         subsys->nr_namespaces--;
>>       nvmet_ns_changed(subsys, ns->nsid);
>> +    nvmet_pr_exit_ns(ns);
>>       nvmet_ns_dev_disable(ns);
>>   out_unlock:
>>       mutex_unlock(&subsys->lock);
>> @@ -904,18 +907,34 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req 
>> *req)
>>           return ret;
>>       }
>>   +    if (req->ns->pr.enable) {
>> +        ret = nvmet_parse_pr_cmd(req);
>> +        if (!ret)
>> +            return ret;
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
>> @@ -1231,6 +1250,21 @@ static void nvmet_init_cap(struct nvmet_ctrl 
>> *ctrl)
>>           nvmet_passthrough_override_cap(ctrl);
>>   }
>>   +bool nvmet_is_host_still_connected(uuid_t *hostid, struct 
>> nvmet_subsys *subsys)
>> +{
>> +    struct nvmet_ctrl *ctrl;
>> +
>> +    mutex_lock(&subsys->lock);
>> +    list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
>> +        if (uuid_equal(hostid, &ctrl->hostid)) {
>> +            mutex_unlock(&subsys->lock);
>> +            return true;
>
> Perhaps its cleaner to do:
>             ret = true;
>             break;
>
OK, changed in v5.
>> +        }
>> +    }
>> +    mutex_unlock(&subsys->lock);
>> +    return false;
>> +}
>> +
>>   struct nvmet_ctrl *nvmet_ctrl_find_get(const char *subsysnqn,
>>                          const char *hostnqn, u16 cntlid,
>>                          struct nvmet_req *req)
>> @@ -1450,6 +1484,11 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, 
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
>> @@ -1488,6 +1527,7 @@ static void nvmet_ctrl_free(struct kref *ref)
>>       cancel_work_sync(&ctrl->fatal_err_work);
>>         nvmet_destroy_auth(ctrl);
>> +    nvmet_ctrl_destroy_pr(ctrl);
>>         ida_free(&cntlid_ida, ctrl->cntlid);
>>   diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
>> index 6c8acebe1a1a..b6facb243977 100644
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
>> @@ -56,6 +58,22 @@
>>   #define IPO_IATTR_CONNECT_SQE(x)    \
>>       (cpu_to_le32(offsetof(struct nvmf_connect_command, x)))
>>   +struct nvmet_pr_registrant {
>> +    u64            rkey;
>> +    uuid_t            hostid;
>> +    enum nvme_pr_type    rtype;
>> +    struct list_head    entry;
>> +    struct rcu_head        rcu;
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
>> @@ -85,6 +103,7 @@ struct nvmet_ns {
>>       int            pi_type;
>>       int            metadata_size;
>>       u8            csi;
>> +    struct nvmet_pr        pr;
>>   };
>>     static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)
>> @@ -190,6 +209,13 @@ static inline bool 
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
>> @@ -243,6 +269,7 @@ struct nvmet_ctrl {
>>       u8            *dh_key;
>>       size_t            dh_keysize;
>>   #endif
>> +    struct nvmet_pr_log_mgr pr_log_mgr;
>>   };
>>     struct nvmet_subsys {
>> @@ -750,4 +777,12 @@ static inline bool nvmet_has_auth(struct 
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
>> index 000000000000..df71fd23ee47
>> --- /dev/null
>> +++ b/drivers/nvme/target/pr.c
>> @@ -0,0 +1,956 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * NVMe over Fabrics Persist Reservation.
>> + * Copyright (c) 2024 Guixin Liu, Alibaba Group.
>> + * All rights reserved.
>> + */
>> +#include "nvmet.h"
>> +#include <linux/slab.h>
>> +#include <asm/unaligned.h>
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
>> +    if (!status) {
>> +        reg->rtype = rtype;
>> +        rcu_assign_pointer(pr->holder, reg);
>
> synchronize_rcu to have rcu grace period elapse?
>
rcu_assign_pointer ensures that all reads after it will see the new value,

we only need to ensure that there are no reads before the old value 
free, the

kfree_rcu can make sure that.

>> +    }
>> +    return status;
>> +}
>> +
>> +static struct nvmet_pr_registrant *
>> +nvmet_pr_find_registrant_by_hostid(struct nvmet_pr *pr, uuid_t *hostid)
>> +{
>> +    struct nvmet_pr_registrant *reg;
>
> Perhaps lockdep_assert_held annotation here?
>
OK, it will be added in v5.
>> +
>> +    list_for_each_entry_rcu(reg, &pr->registrant_list, entry) {
>
> is registrant_list protected by rcu?
Yes.
>
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
>
> We need some code comments to say how the count/lost_count are managed
> because it looks slightly convoluted here.
>
Sure, it will be added in v5.
>> +
>> +    log.nr_pages = min(kfifo_len(&log_mgr->log_queue) /
>> +            sizeof(struct nvme_pr_log), 255);
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
>
> It'd be good to have a blktest for lost events.
>
I have write a script to test this, but when I use v2.0 nvme-cli to 
establish two

connections to a same target with different hostnqn and hostid, the v1.6 
nvme-cli

still work, I found that the 07d6b911e in nvme-cli limited this.

And I should close the nvme-multipath also.

>> +
>> +    mutex_unlock(&log_mgr->lock);
>> +}
>> +
>> +static void nvmet_pr_send_resv_released(struct nvmet_pr *pr, uuid_t 
>> *hostid)
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
>> +            nvmet_add_async_event(ctrl, NVME_AER_CSS,
>> +                NVME_AEN_RESV_LOG_PAGE_AVALIABLE,
>> +                NVME_LOG_RESERVATION);
>> +        }
>> +    }
>> +    mutex_unlock(&subsys->lock);
>
> Wondering if this can consolidate also to nvmet_pr_send_event_by_hostid
> but with a filter? Not a must though (don't want to make the interface
> too complicated).
>
>
Yes, this will make function too complicated, so I didn't do that.
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
>> +static u16 nvmet_pr_register_check_rkey(struct nvmet_req *req,
>> +                    struct nvmet_pr_register_data *d)
>> +{
>> +    struct nvmet_ctrl *ctrl = req->sq->ctrl;
>> +    struct nvmet_pr *pr = &req->ns->pr;
>> +    struct nvmet_pr_registrant *reg;
>> +
>> +    reg = nvmet_pr_find_registrant_by_hostid(pr, &ctrl->hostid);
>> +    if (!reg || reg->rkey == le64_to_cpu(d->nrkey))
>> +        return NVME_SC_SUCCESS;
>> +
>> +    return NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
>> +}
>> +
>> +static u16 nvmet_pr_register(struct nvmet_req *req,
>> +                 struct nvmet_pr_register_data *d)
>> +{
>> +    struct nvmet_ctrl *ctrl = req->sq->ctrl;
>> +    struct nvmet_pr *pr = &req->ns->pr;
>> +    struct nvmet_pr_registrant *reg;
>> +    u16 status;
>> +
>> +    status = nvmet_pr_register_check_rkey(req, d);
>> +    if (status)
>> +        return status;
>> +
>> +    reg = kmalloc(sizeof(*reg), GFP_KERNEL);
>> +    if (!reg)
>> +        return NVME_SC_INTERNAL;
>> +
>> +    memset(reg, 0, sizeof(*reg));
>> +    INIT_LIST_HEAD(&reg->entry);
>> +    reg->rkey = le64_to_cpu(d->nrkey);
>> +    uuid_copy(&reg->hostid, &ctrl->hostid);
>> +
>> +    mutex_lock(&pr->pr_lock);
>> +    list_add_tail_rcu(&reg->entry, &pr->registrant_list);
>
> Can you explain why this is rculist operation?
>
I will explain this in bottom.
>> +    mutex_unlock(&pr->pr_lock);
>> +    return NVME_SC_SUCCESS;
>> +}
>> +
>> +static void __nvmet_pr_unregister_one(struct nvmet_pr *pr,
>> +                      struct nvmet_pr_registrant *reg)
>> +{
>> +    struct nvmet_pr_registrant *first_reg;
>> +    struct nvmet_pr_registrant *holder;
>> +    u8 original_rtype;
>> +
>> +    list_del_rcu(&reg->entry);
>> +
>> +    holder = rcu_dereference_protected(pr->holder,
>> +            lockdep_is_held(&pr->pr_lock));
>> +    if (reg != holder) {
>> +        kfree_rcu(reg, rcu);
>> +        return;
>
> goto [out] label instead?
>
OK.
>> +    }
>> +
>> +    original_rtype = holder->rtype;
>> +    if (original_rtype == NVME_PR_WRITE_EXCLUSIVE_ALL_REGS ||
>> +        original_rtype == NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS) {
>> +        first_reg = list_first_entry_or_null(&pr->registrant_list,
>> +                struct nvmet_pr_registrant, entry);
>> +        if (first_reg)
>> +            first_reg->rtype = original_rtype;
>> +        rcu_assign_pointer(pr->holder, first_reg);
>
> synchronize_rcu() ?
>
>> +    } else {
>> +        rcu_assign_pointer(pr->holder, NULL);
>
> synchronize_rcu() ?
>
>> +
>> +        if (original_rtype == NVME_PR_WRITE_EXCLUSIVE_REG_ONLY ||
>> +            original_rtype == NVME_PR_WRITE_EXCLUSIVE_REG_ONLY)
>> +            nvmet_pr_send_resv_released(pr, &reg->hostid);
>> +    }
>
> out:
>
>> +    kfree_rcu(reg, rcu);
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
>> +    struct nvmet_pr_registrant *tmp;
>> +
>> +    mutex_lock(&pr->pr_lock);
>> +    list_for_each_entry_safe(reg, tmp, &pr->registrant_list, entry) {
>
> You are mixing list/rculist traversals, it can't be correct.

You are right, I should use rculist whether hold the pr_lock or not.

>
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
>> +static u16 __nvmet_pr_do_replace(struct nvmet_pr *pr,
>> +                 struct nvmet_pr_registrant *reg,
>> +                 u64 nrkey)
>> +{
>> +    struct nvmet_pr_registrant *holder;
>> +    struct nvmet_pr_registrant *new;
>> +
>> +    holder = rcu_dereference_protected(pr->holder,
>> +            lockdep_is_held(&pr->pr_lock));
>> +    if (reg != holder) {
>> +        reg->rkey = nrkey;
>> +        return NVME_SC_SUCCESS;
>> +    }
>> +
>> +    new = kmalloc(sizeof(*new), GFP_ATOMIC);
>> +    if (!new)
>> +        return NVME_SC_INTERNAL;
>> +    memcpy(new, reg, sizeof(*new));
>> +    new->rkey = nrkey;
>> +    list_del_rcu(&reg->entry);
>> +    list_add_rcu(&new->entry, &pr->registrant_list);
>> +    rcu_assign_pointer(pr->holder, new);
>> +    kfree_rcu(reg, rcu);
>
> I still think that the correct ordering is:
>     rcu_assign_pointer(pr->holder, new);
>     synchronize_rcu();
>     kfree(reg);
>
> Because what you want is rcu grace period to elapse is after you
> (re)assign pr->holder. Then you can safely use a normal kfree for
> reg.
>
The kfree_rcu can achieve the same effect,

Could you plz tell me why should change to like this?

>> +    return NVME_SC_SUCCESS;
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
>> +
>> +    mutex_lock(&pr->pr_lock);
>> +    list_for_each_entry_rcu(reg, &pr->registrant_list, entry) {
>> +        if (uuid_equal(&reg->hostid, &ctrl->hostid)) {
>> +            if (ignore_key || reg->rkey == le64_to_cpu(d->crkey)) {
>> +                reg->rkey = le64_to_cpu(d->nrkey);
>> +                status = __nvmet_pr_do_replace(pr, reg,
>> +                        le64_to_cpu(d->nrkey));
>
> So you assign reg->rkey here and then assign it again in _do_replace() ?
> I don't understand the logic here.
>
My bad, this is an oversight, it will be changed in v5.
>> +            }
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
>> +    struct nvmet_pr_registrant *reg;
>> +    struct nvmet_pr_registrant *tmp;
>> +
>
> lockdep_assert_held ?
OK
>
>> +    list_for_each_entry_safe(reg, tmp,
>> +                 &pr->registrant_list, entry) {
>> +        if (reg->rkey == prkey) {
>> +            status = NVME_SC_SUCCESS;
>> +            if (!uuid_equal(&reg->hostid, send_hostid))
>> +                nvmet_pr_send_registration_preempted(pr,
>> +                    &reg->hostid);
>> +            __nvmet_pr_unregister_one(pr, reg);
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
>> +    struct nvmet_pr_registrant *reg;
>> +    struct nvmet_pr_registrant *tmp;
>> +
>
> lockdep_assert_held ?
OK
>
>> +    list_for_each_entry_safe(reg, tmp,
>> +                 &pr->registrant_list, entry) {
>> +        if (reg->rkey == prkey &&
>> +            !uuid_equal(&reg->hostid, send_hostid)) {
>> +            status = NVME_SC_SUCCESS;
>> +            nvmet_pr_send_registration_preempted(pr, &reg->hostid);
>> +            __nvmet_pr_unregister_one(pr, reg);
>> +        }
>> +    }
>> +    return status;
>> +}
>> +
>> +static void nvmet_pr_unreg_except_hostid(struct nvmet_pr *pr,
>> +                     uuid_t *send_hostid)
>> +{
>> +    struct nvmet_pr_registrant *reg;
>> +    struct nvmet_pr_registrant *tmp;
>> +
>
> lockdep_assert_held ?
OK
>
>> +    list_for_each_entry_safe(reg, tmp,
>> +                 &pr->registrant_list, entry) {
>> +        if (!uuid_equal(&reg->hostid, send_hostid)) {
>> +            nvmet_pr_send_registration_preempted(pr, &reg->hostid);
>> +            __nvmet_pr_unregister_one(pr, reg);
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
>> +static u16 nvmet_pr_update_holder_rtype(struct nvmet_pr *pr,
>> +                    struct nvmet_pr_registrant *holder,
>> +                    u8 rtype)
>> +{
>> +    u16 status;
>> +    struct nvmet_pr_registrant *new;
>> +
>> +    status = nvmet_pr_validate_rtype(rtype);
>> +    if (status)
>> +        return status;
>> +
>> +    new = kmalloc(sizeof(*new), GFP_ATOMIC);
>> +    if (!new)
>> +        return NVME_SC_INTERNAL;
>> +
>> +    list_del_rcu(&holder->entry);
>> +    memcpy(new, holder, sizeof(*new));
>> +    new->rtype = rtype;
>> +    list_add_tail_rcu(&new->entry, &pr->registrant_list);
>> +    rcu_assign_pointer(pr->holder, new);
>> +    kfree_rcu(holder, rcu);
>
> Same comment as before.
>
>> +    return NVME_SC_SUCCESS;
>> +}
>
> Why do you need this btw? shouldn't this one call
> __nvmet_pr_do_replace ?
>
OK, it will be changed in v5.
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
>> +        status = nvmet_pr_update_holder_rtype(pr, holder, rtype);
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
>> +    list_for_each_entry_rcu(reg, &pr->registrant_list, entry) {
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
>
> synchronize_rcu ?
>
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
>> +    struct nvmet_pr *pr = &req->ns->pr;
>> +    struct nvmet_pr_registrant *reg;
>> +    struct nvmet_pr_registrant *tmp;
>> +
>
> lockdep_assert_held ?
OK
>
>> +    list_for_each_entry_safe(reg, tmp, &pr->registrant_list, entry) {
>> +        list_del_rcu(&reg->entry);
>
> Now registrant_list is an rculist ? I'm not following the logic here.
>
Yes
>> +        if (!uuid_equal(&req->sq->ctrl->hostid, &reg->hostid))
>> +            nvmet_pr_send_resv_preempted(pr, &reg->hostid);
>> +        kfree_rcu(reg, rcu);
>
> Why are you calling kfree_rcu ?
>
>> +    }
>> +    rcu_assign_pointer(pr->holder, NULL);
>
> synchronize_rcu() ?
>
>> +
>> +    atomic_inc(&pr->generation);
>> +}
>
> ...
>
> I'm stopping here, I think you want to either sort out or explain how
> you are managing pr, pr->holder, pr->registrant_list etc. It is
> difficult for me to follow and make sense of it.

Hi Sagi,

     Thank you for the careful review.  My bad, I'm not very familiar 
with RCU, I wasn't aware

of the many restrictions involved.I will do a deep research on RCU to 
see what is correct to do.

     I use pr->pr_lock to protect pr->registrant_list and pr->holder 
writing, and both of holder

and registrant_list are rcu protected, so they can be read lightly in 
nvmet_pr_check_cmd_access.

     I was misled by the __dev_exception_clean() into thinking that if I 
added a mutex lock, I

wouldn't have to use the rculist marcros anymore, I will change this in 
v5, sorry for the trouble...

     And I still dont know why we should call synchronize_rcu after 
rcu_assign_pointer, if it is for

safely kfree(reg), the kfree_rcu can ensure that. Could you plz expain 
that Sagi? Thanks.

Best regards,

Guixin Liu


