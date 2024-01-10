Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCBBC3DA6E
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jan 2024 05:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dO22F1pAhgLenrqip/HO4G88R4ZsTtxawy/XHPEXjmU=; b=zXucab4e32ktXrcL1hbaorcbOF
	SdoBXKzdQmN3rIP6c91PZ6otd/ocDZdCe59wEBJ+0Lih4sjVjSlfCo6sRBOPi2MuHuQtWloxLgg6X
	jUbtAk4QWrGHfubWZsHotMRg2AvTkUzVAtiq1czW5OqMPo9hZj+oCqORuuAq7WbM57djApRAnVXoK
	mRGlKZZclApsIsu6tj1PGWmFYfYT1y4m1mwTgvbtQY4/7/Xb+qkVzgvz32d5qWjYCePoV5i7H5dBy
	dNuZQ2JxlYzrSasHA1vcnC0SZi8fuBpvZUzc9oRlUifhXrC5V4i4st2OTFUac3m+p2uceI1lUmcot
	wFUbJW4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNRcM-00AQri-0a;
	Wed, 10 Jan 2024 05:59:10 +0000
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNRcG-00AQr0-2h
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jan 2024 05:59:08 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W-Kyl.e_1704866336;
Received: from 30.178.83.60(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W-Kyl.e_1704866336)
          by smtp.aliyun-inc.com;
          Wed, 10 Jan 2024 13:58:57 +0800
Message-ID: <e6427481-73f3-478b-aadb-e59b096805c8@linux.alibaba.com>
Date: Wed, 10 Jan 2024 13:58:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: support reservation feature
Content-Language: en-GB
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
References: <20240109121008.15925-1-kanie@linux.alibaba.com>
 <3a2055ff-6e5c-4afc-a0e1-36255d569e5e@nvidia.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <3a2055ff-6e5c-4afc-a0e1-36255d569e5e@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240109_215905_218122_FEAE11CA 
X-CRM114-Status: GOOD (  29.42  )
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


在 2024/1/10 12:34, Chaitanya Kulkarni 写道:
> On 1/9/24 04:10, Guixin Liu wrote:
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
>> Hi guys,
>>       I've implemented the NVMe reservation feature. Please review it, all
>> comments are welcome.
>>       In addtion, I didn't implement event reporting because I didn't see
>> any handling of these events on the host side. If these events are mandatory
>> to report, please let me know so that I can implement them.
>>
>>    drivers/nvme/target/Makefile    |   2 +-
>>    drivers/nvme/target/admin-cmd.c |  14 +-
>>    drivers/nvme/target/configfs.c  |  27 ++
>>    drivers/nvme/target/core.c      |  37 +-
>>    drivers/nvme/target/nvmet.h     |  26 ++
>>    drivers/nvme/target/pr.c        | 806 ++++++++++++++++++++++++++++++++
>>    include/linux/nvme.h            |  30 ++
>>    7 files changed, 939 insertions(+), 3 deletions(-)
>>    create mode 100644 drivers/nvme/target/pr.c
>>
>> diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
>> index c66820102493..f9bfc904a5b3 100644
>> --- a/drivers/nvme/target/Makefile
>> +++ b/drivers/nvme/target/Makefile
>> @@ -10,7 +10,7 @@ obj-$(CONFIG_NVME_TARGET_FCLOOP)	+= nvme-fcloop.o
>>    obj-$(CONFIG_NVME_TARGET_TCP)		+= nvmet-tcp.o
>>    
>>    nvmet-y		+= core.o configfs.o admin-cmd.o fabrics-cmd.o \
>> -			discovery.o io-cmd-file.o io-cmd-bdev.o
>> +			discovery.o io-cmd-file.o io-cmd-bdev.o pr.o
>>    nvmet-$(CONFIG_NVME_TARGET_PASSTHRU)	+= passthru.o
>>    nvmet-$(CONFIG_BLK_DEV_ZONED)		+= zns.o
>>    nvmet-$(CONFIG_NVME_TARGET_AUTH)	+= fabrics-cmd-auth.o auth.o
>> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
>> index 39cb570f833d..7da6f3085a4c 100644
>> --- a/drivers/nvme/target/admin-cmd.c
>> +++ b/drivers/nvme/target/admin-cmd.c
>> @@ -550,7 +550,13 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
>>    	 */
>>    	id->nmic = NVME_NS_NMIC_SHARED;
>>    	id->anagrpid = cpu_to_le32(req->ns->anagrpid);
>> -
>> +	id->rescap = NVME_PR_SUPPORT_WRITE_EXCLUSIVE |
>> +		     NVME_PR_SUPPORT_EXCLUSIVE_ACCESS |
>> +		     NVME_PR_SUPPORT_WRITE_EXCLUSIVE_REG_ONLY |
>> +		     NVME_PR_SUPPORT_EXCLUSIVE_ACCESS_REG_ONLY |
>> +		     NVME_PR_SUPPORT_WRITE_EXCLUSIVE_ALL_REGS |
>> +		     NVME_PR_SUPPORT_EXCLUSIVE_ACCESS_ALL_REGS |
>> +		     NVME_PR_SUPPORT_IEKEY_DEF_LATER_VER_1_3;
>>    	memcpy(&id->nguid, &req->ns->nguid, sizeof(id->nguid));
>>    
>>    	id->lbaf[0].ds = req->ns->blksize_shift;
>> @@ -1017,6 +1023,12 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
>>    	if (nvmet_is_passthru_req(req))
>>    		return nvmet_parse_passthru_admin_cmd(req);
>>    
>> +	ret = nvmet_pr_check_cmd_access(req);
>> +	if (unlikely(ret)) {
>> +		req->error_loc = offsetof(struct nvme_common_command, opcode);
>> +		return ret;
>> +	}
>> +
>>    	switch (cmd->common.opcode) {
>>    	case nvme_admin_get_log_page:
>>    		req->execute = nvmet_execute_get_log_page;
>> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
>> index d937fe05129e..1ac4802ec818 100644
>> --- a/drivers/nvme/target/configfs.c
>> +++ b/drivers/nvme/target/configfs.c
>> @@ -714,6 +714,32 @@ static ssize_t nvmet_ns_revalidate_size_store(struct config_item *item,
>>    
>>    CONFIGFS_ATTR_WO(nvmet_ns_, revalidate_size);
>>    
>> +static ssize_t nvmet_ns_resv_enable_show(struct config_item *item, char *page)
>> +{
>> +	return sprintf(page, "%d\n", to_nvmet_ns(item)->pr.enable);
>> +}
>> +
>> +static ssize_t nvmet_ns_resv_enable_store(struct config_item *item,
>> +					const char *page, size_t count)
>> +{
>> +	struct nvmet_ns *ns = to_nvmet_ns(item);
>> +	bool val;
>> +
>> +	if (kstrtobool(page, &val))
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&ns->subsys->lock);
>> +	if (ns->enabled) {
>> +		pr_err("the ns:%d is already enabled.\n", ns->nsid);
>> +		mutex_unlock(&ns->subsys->lock);
>> +		return -EINVAL;
>> +	}
>> +	ns->pr.enable = val;
>> +	mutex_unlock(&ns->subsys->lock);
>> +	return count;
>> +}
>> +CONFIGFS_ATTR(nvmet_ns_, resv_enable);
>> +
>>    static struct configfs_attribute *nvmet_ns_attrs[] = {
>>    	&nvmet_ns_attr_device_path,
>>    	&nvmet_ns_attr_device_nguid,
>> @@ -722,6 +748,7 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
>>    	&nvmet_ns_attr_enable,
>>    	&nvmet_ns_attr_buffered_io,
>>    	&nvmet_ns_attr_revalidate_size,
>> +	&nvmet_ns_attr_resv_enable,
>>    #ifdef CONFIG_PCI_P2PDMA
>>    	&nvmet_ns_attr_p2pmem,
>>    #endif
>> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
>> index 3935165048e7..8eab81804b14 100644
>> --- a/drivers/nvme/target/core.c
>> +++ b/drivers/nvme/target/core.c
>> @@ -598,6 +598,7 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
>>    	subsys->nr_namespaces++;
>>    
>>    	nvmet_ns_changed(subsys, ns->nsid);
>> +	nvmet_pr_init_ns(ns);
>>    	ns->enabled = true;
>>    	ret = 0;
>>    out_unlock:
>> @@ -651,6 +652,7 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
>>    
>>    	subsys->nr_namespaces--;
>>    	nvmet_ns_changed(subsys, ns->nsid);
>> +	nvmet_pr_clean_all_registrants(&ns->pr);
>>    	nvmet_ns_dev_disable(ns);
>>    out_unlock:
>>    	mutex_unlock(&subsys->lock);
>> @@ -904,6 +906,16 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
>>    		return ret;
>>    	}
>>    
>> +	ret = nvmet_pr_check_cmd_access(req);
>> +	if (unlikely(ret)) {
>> +		req->error_loc = offsetof(struct nvme_common_command, opcode);
>> +		return ret;
>> +	}
>> +
>> +	ret = nvmet_parse_pr_cmd(req);
>> +	if (!ret)
>> +		return ret;
>> +
> Can we make this feature configurable via Kconfig? If someone doesn't
> want to
> use PR, they will have to bear the cost of these checks in the fast path.

Yeah, I have added a resv_enable in configfs, the default is false, one can

make reservation enable before enable namespace.

>>    	switch (req->ns->csi) {
>>    	case NVME_CSI_NVM:
>>    		if (req->ns->file)
>> @@ -1231,6 +1243,21 @@ static void nvmet_init_cap(struct nvmet_ctrl *ctrl)
>>    		nvmet_passthrough_override_cap(ctrl);
>>    }
>>    
>> +bool nvmet_is_host_still_connected(uuid_t *hostid, struct nvmet_subsys *subsys)
>> +{
>> +	struct nvmet_ctrl *ctrl;
>> +
>> +	mutex_lock(&subsys->lock);
>> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
>> +		if (uuid_equal(hostid, &ctrl->hostid)) {
>> +			mutex_unlock(&subsys->lock);
>> +			return true;
>> +		}
>> +	}
>> +	mutex_unlock(&subsys->lock);
>> +	return false;
>> +}
>> +
>>    struct nvmet_ctrl *nvmet_ctrl_find_get(const char *subsysnqn,
>>    				       const char *hostnqn, u16 cntlid,
>>    				       struct nvmet_req *req)
>> @@ -1488,6 +1515,7 @@ static void nvmet_ctrl_free(struct kref *ref)
>>    	cancel_work_sync(&ctrl->fatal_err_work);
>>    
>>    	nvmet_destroy_auth(ctrl);
>> +	nvmet_pr_unregister_ctrl_host(ctrl);
>>    
>>    	ida_free(&cntlid_ida, ctrl->cntlid);
>>    
>> @@ -1673,11 +1701,17 @@ static int __init nvmet_init(void)
>>    	if (error)
>>    		goto out_free_nvmet_work_queue;
>>    
>> -	error = nvmet_init_configfs();
>> +	error = nvmet_pr_init();
>>    	if (error)
>>    		goto out_exit_discovery;
>> +
>> +	error = nvmet_init_configfs();
>> +	if (error)
>> +		goto out_exit_pr;
>>    	return 0;
>>    
>> +out_exit_pr:
>> +	nvmet_pr_exit();
>>    out_exit_discovery:
>>    	nvmet_exit_discovery();
>>    out_free_nvmet_work_queue:
>> @@ -1700,6 +1734,7 @@ static void __exit nvmet_exit(void)
>>    	destroy_workqueue(buffered_io_wq);
>>    	destroy_workqueue(zbd_wq);
>>    	kmem_cache_destroy(nvmet_bvec_cache);
>> +	nvmet_pr_exit();
>>    
>>    	BUILD_BUG_ON(sizeof(struct nvmf_disc_rsp_page_entry) != 1024);
>>    	BUILD_BUG_ON(sizeof(struct nvmf_disc_rsp_page_hdr) != 1024);
>> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
>> index 6c8acebe1a1a..7670bdc13f9c 100644
>> --- a/drivers/nvme/target/nvmet.h
>> +++ b/drivers/nvme/target/nvmet.h
>> @@ -56,6 +56,22 @@
>>    #define IPO_IATTR_CONNECT_SQE(x)	\
>>    	(cpu_to_le32(offsetof(struct nvmf_connect_command, x)))
>>    
>> +struct nvmet_pr_registrant {
>> +	bool			is_holder;
>> +	u64			rkey;
>> +	uuid_t			hostid;
>> +	struct list_head	entry;
>> +};
>> +
>> +struct nvmet_pr {
>> +	bool			enable;
>> +	enum nvme_pr_type	rtype;
>> +	u32			generation;
>> +	struct nvmet_pr_registrant *holder;
>> +	rwlock_t		pr_lock;
>> +	struct list_head	registrant_list;
>> +};
>> +
>>    struct nvmet_ns {
>>    	struct percpu_ref	ref;
>>    	struct bdev_handle	*bdev_handle;
>> @@ -85,6 +101,7 @@ struct nvmet_ns {
>>    	int			pi_type;
>>    	int			metadata_size;
>>    	u8			csi;
>> +	struct nvmet_pr		pr;
>>    };
>>    
>>    static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)
>> @@ -750,4 +767,13 @@ static inline bool nvmet_has_auth(struct nvmet_ctrl *ctrl)
>>    static inline const char *nvmet_dhchap_dhgroup_name(u8 dhgid) { return NULL; }
>>    #endif
>>    
>> +int nvmet_pr_init(void);
>> +void nvmet_pr_exit(void);
>> +void nvmet_pr_init_ns(struct nvmet_ns *ns);
>> +u16 nvmet_parse_pr_cmd(struct nvmet_req *req);
>> +u16 nvmet_pr_check_cmd_access(struct nvmet_req *req);
>> +void nvmet_pr_unregister_ctrl_host(struct nvmet_ctrl *ctrl);
>> +void nvmet_pr_clean_all_registrants(struct nvmet_pr *pr);
>> +bool nvmet_is_host_still_connected(uuid_t *hostid, struct nvmet_subsys *subsys);
>> +
>>    #endif /* _NVMET_H */
>> diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
>> new file mode 100644
>> index 000000000000..e58e295820cf
>> --- /dev/null
>> +++ b/drivers/nvme/target/pr.c
>> @@ -0,0 +1,806 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * NVMe over Fabrics Persist Reservation.
>> + * Copyright (c) 2024 Guixin Liu, Alibaba Cloud.
>> + * All rights reserved.
>> + */
>> +#include "nvmet.h"
>> +#include <linux/slab.h>
>> +#include <asm/unaligned.h>
>> +
>> +struct nvmet_pr_register_data {
>> +	__le64	crkey;
>> +	__le64	nrkey;
>> +};
>> +
>> +struct nvmet_pr_acquire_data {
>> +	__le64	crkey;
>> +	__le64	prkey;
>> +};
>> +
>> +struct nvmet_pr_release_data {
>> +	__le64	crkey;
>> +};
>> +
>> +static struct kmem_cache *registrant_cache;
>> +
>> +static inline void nvmet_pr_clean_holder(struct nvmet_pr *pr)
>> +{
>> +	pr->holder = NULL;
>> +	pr->rtype = 0;
>> +}
>> +
>> +static u16 nvmet_pr_validate_and_set_rtype(struct nvmet_pr *pr, u8 rtype)
>> +{
>> +	if (rtype < NVME_PR_WRITE_EXCLUSIVE ||
>> +	    rtype > NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS)
>> +		return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
>> +
>> +	pr->rtype = rtype;
>> +	return 0;
>> +}
>> +
>> +static u16 nvmet_pr_set_rtype_and_holder(struct nvmet_pr *pr, u8 rtype,
>> +					 struct nvmet_pr_registrant *reg)
>> +{
>> +	u16 ret;
>> +
>> +	ret = nvmet_pr_validate_and_set_rtype(pr, rtype);
>> +	if (!ret)
>> +		pr->holder = reg;
>> +	return ret;
>> +}
>> +
>> +static void nvmet_pr_inc_generation(struct nvmet_pr *pr)
>> +{
>> +	u32 gen = pr->generation;
>> +
>> +	gen++;
>> +	if (gen == U32_MAX)
>> +		gen = 0;
>> +	pr->generation = gen;
>> +}
>> +
>> +static u16 nvmet_pr_register(struct nvmet_req *req,
>> +			     struct nvmet_pr_register_data *d)
>> +{
>> +	struct nvmet_ctrl *ctrl = req->sq->ctrl;
>> +	struct nvmet_pr_registrant *reg;
>> +	struct nvmet_pr *pr = &req->ns->pr;
>> +	u16 ret = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
>> +
> nit:- rename of ret use status, makes it easier to search ..
>
>> +	read_lock(&pr->pr_lock);
>> +	list_for_each_entry(reg, &pr->registrant_list, entry) {
>> +		if (uuid_equal(&reg->hostid, &ctrl->hostid)) {
>> +			if (reg->rkey == le64_to_cpu(d->nrkey))
>> +				ret = 0;
>> +			read_unlock(&pr->pr_lock);
>> +			goto out;
>> +		}
>> +	}
>> +	read_unlock(&pr->pr_lock);
>> +
>> +	reg = kmem_cache_alloc(registrant_cache, GFP_KERNEL);
>> +	if (!reg) {
>> +		ret = NVME_SC_INTERNAL;
>> +		goto out;
>> +	}
>> +
>> +	reg->rkey = le64_to_cpu(d->nrkey);
>> +	uuid_copy(&reg->hostid, &ctrl->hostid);
>> +	reg->is_holder = false;
>> +
>> +	write_lock(&pr->pr_lock);
>> +	list_add_tail(&reg->entry, &pr->registrant_list);
>> +	write_unlock(&pr->pr_lock);
>> +	ret = 0;
>> +out:
>> +	return ret;
>> +}
>> +
>> +static void __nvmet_pr_unregister_one(struct nvmet_pr *pr,
>> +				      struct nvmet_pr_registrant *reg)
>> +{
>> +	list_del(&reg->entry);
>> +	kmem_cache_free(registrant_cache, reg);
>> +
>> +	/*
>> +	 * Temporarily, don't send notification, because host does not
>> +	 * handle this event.
>> +	 */
> if host doesn't handle this event then maybe we need to add support
> in the host or just don't keep the code ? sorry it sounds confusing to have
> the code but not to send the event ? or maybe I didn't understand
>
>> +	if (pr->holder && pr->holder == reg) {
>> +		if (pr->rtype == NVME_PR_WRITE_EXCLUSIVE_ALL_REGS ||
>> +		    pr->rtype == NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS) {
>> +			reg = list_first_entry(&pr->registrant_list,
>> +					struct nvmet_pr_registrant, entry);
>> +			pr->holder = reg;
>> +			if (!reg)
>> +				pr->rtype = 0;
>> +		} else {
>> +			nvmet_pr_clean_holder(pr);
>> +		}
>> +	}
>> +}
>> +
>> +static u16 nvmet_pr_unregister(struct nvmet_req *req,
>> +			       struct nvmet_pr_register_data *d,
>> +			       bool ignore_key)
>> +{
>> +	struct nvmet_pr *pr = &req->ns->pr;
>> +	struct nvmet_ctrl *ctrl = req->sq->ctrl;
>> +	struct nvmet_pr_registrant *reg;
>> +	struct nvmet_pr_registrant *tmp;
>> +	u16 ret = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
>> +
> nit:- rename of ret use status, also reverse tree style plz
>
>       u16 ret = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
>       struct nvmet_ctrl *ctrl = req->sq->ctrl;
>       struct nvmet_pr *pr = &req->ns->pr;
>       struct nvmet_pr_registrant *reg;
>       struct nvmet_pr_registrant *tmp;
>
>> +	write_lock(&pr->pr_lock);
>> +	list_for_each_entry_safe(reg, tmp, &pr->registrant_list, entry) {
>> +		if (uuid_equal(&reg->hostid, &ctrl->hostid)) {
>> +			if (ignore_key || reg->rkey == le64_to_cpu(d->crkey)) {
>> +				ret = 0;
>> +				__nvmet_pr_unregister_one(pr, reg);
>> +			}
>> +			break;
>> +		}
>> +	}
>> +	write_unlock(&pr->pr_lock);
>> +	return ret;
>> +}
>> +
>> +static u16 nvmet_pr_replace(struct nvmet_req *req,
>> +			    struct nvmet_pr_register_data *d,
>> +			    bool ignore_key)
>> +{
>> +	struct nvmet_ctrl *ctrl = req->sq->ctrl;
>> +	struct nvmet_pr_registrant *reg;
>> +	struct nvmet_pr *pr = &req->ns->pr;
>> +	u16 ret = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
>> +
> nit: same as above comment ..
>
>> +	write_lock(&pr->pr_lock);
>> +	list_for_each_entry(reg, &pr->registrant_list, entry) {
>> +		if (uuid_equal(&reg->hostid, &ctrl->hostid)) {
>> +			if (ignore_key || reg->rkey == le64_to_cpu(d->crkey)) {
>> +				reg->rkey = le64_to_cpu(d->nrkey);
>> +				ret = 0;
>> +			}
>> +			break;
>> +		}
>> +	}
>> +	write_unlock(&pr->pr_lock);
>> +	return ret;
>> +}
>> +
>> +static void nvmet_execute_pr_register(struct nvmet_req *req)
>> +{
>> +	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
>> +	u8 reg_act = cdw10 & 0x07;
>> +	bool ignore_key = (bool)((cdw10 >> 3) & 1);
>> +	u16 status = 0;
> do we really need to initialize the status to 0 here ?
>
>> +	struct nvmet_pr_register_data *d;
>> +
> nit:- same as above comment ...
>
>> +	d = kmalloc(sizeof(*d), GFP_KERNEL);
>> +	if (!d) {
>> +		status = NVME_SC_INTERNAL;
>> +		goto out;
>> +	}
>> +
>> +	status = nvmet_copy_from_sgl(req, 0, d, sizeof(*d));
>> +	if (status)
>> +		goto free_data;
>> +
>> +	switch (reg_act) {
>> +	case NVME_PR_REGISTER_ACT_REG:
>> +		status = nvmet_pr_register(req, d);
>> +		break;
>> +	case NVME_PR_REGISTER_ACT_UNREG:
>> +		status = nvmet_pr_unregister(req, d, ignore_key);
>> +		break;
>> +	case NVME_PR_REGISTER_ACT_REPLACE:
>> +		status = nvmet_pr_replace(req, d, ignore_key);
>> +		break;
>> +	default:
>> +		req->error_loc = offsetof(struct nvme_common_command,
>> +						cdw10);
>> +		status = NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
>> +		break;
>> +	}
>> +free_data:
>> +	kfree(d);
>> +out:
>> +	if (!status)
>> +		nvmet_pr_inc_generation(&req->ns->pr);
>> +	nvmet_req_complete(req, status);
>> +}
>> +
>> +static u16 nvmet_pr_acquire(struct nvmet_req *req,
>> +			    struct nvmet_pr_registrant *reg,
>> +			    u8 rtype)
>> +{
>> +	struct nvmet_pr *pr = &req->ns->pr;
>> +	u16 ret = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
>> +
>> +	if (pr->holder && reg != pr->holder)
>> +		goto out;
> nit :- you can safely return from here instead of using goto
>
>> +	if (pr->holder && reg == pr->holder) {
>> +		if (pr->rtype == rtype)
>> +			ret = 0;
>> +		goto out;
> you can safely return from here instead of using goto, that way
> maybe we can remove the label goto ?
>
>> +	}
>> +
>> +	ret = nvmet_pr_set_rtype_and_holder(pr, rtype, reg);
> if we remove goto label here we just get away with   ?
>
> 	return nvmet_pr_set_rtype_and_holder(pr, rtype, reg);
>
>> +out:
>> +	return ret;
>> +}
>> +
>> +static u16 nvmet_pr_unregister_by_prkey(struct nvmet_pr *pr, u64 prkey)
>> +{
>> +	struct nvmet_pr_registrant *reg;
>> +	struct nvmet_pr_registrant *tmp;
>> +	u16 ret = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
>> +
>> +	list_for_each_entry_safe(reg, tmp,
>> +				 &pr->registrant_list, entry) {
>> +		if (reg->rkey == prkey) {
>> +			ret = 0;
>> +			__nvmet_pr_unregister_one(pr, reg);
>> +		}
>> +	}
>> +	return ret;
>> +}
>> +
>> +static void nvmet_pr_unregister_except_hostid(struct nvmet_pr *pr,
>> +					      uuid_t *hostid)
>> +{
>> +	struct nvmet_pr_registrant *reg;
>> +	struct nvmet_pr_registrant *tmp;
>> +
>> +	list_for_each_entry_safe(reg, tmp,
>> +				 &pr->registrant_list, entry) {
>> +		if (!uuid_equal(&reg->hostid, hostid))
>> +			__nvmet_pr_unregister_one(pr, reg);
>> +	}
>> +}
>> +
>> +static u16 nvmet_pr_preempt(struct nvmet_req *req,
>> +			    struct nvmet_pr_registrant *reg,
>> +			    u8 rtype,
>> +			    struct nvmet_pr_acquire_data *d)
>> +{
>> +	struct nvmet_ctrl *ctrl = req->sq->ctrl;
>> +	struct nvmet_pr *pr = &req->ns->pr;
>> +	u16 ret = 0;
>> +
>> +	if (!pr->holder)
>> +		goto unregister_by_prkey;
>> +
>> +	if (pr->rtype == NVME_PR_WRITE_EXCLUSIVE_ALL_REGS ||
>> +	    pr->rtype == NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS) {
>> +		if (!le64_to_cpu(d->prkey)) {
>> +			nvmet_pr_unregister_except_hostid(pr, &ctrl->hostid);
>> +			ret = nvmet_pr_set_rtype_and_holder(pr, rtype, reg);
>> +			goto out;
>> +		}
>> +		goto unregister_by_prkey;
>> +	}
>> +
>> +	if (pr->holder == reg) {
>> +		nvmet_pr_validate_and_set_rtype(pr, rtype);
>> +		goto out;
>> +	}
>> +
>> +	if (le64_to_cpu(d->prkey) == pr->holder->rkey)
>> +		goto new_reserve;
>> +
>> +	if (le64_to_cpu(d->prkey))
>> +		goto unregister_by_prkey;
>> +	ret = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
>> +	goto out;
>> +
>> +new_reserve:
>> +	ret = nvmet_pr_set_rtype_and_holder(pr, rtype, reg);
>> +	if (ret)
>> +		return ret;
>> +unregister_by_prkey:
>> +	ret = nvmet_pr_unregister_by_prkey(pr, le64_to_cpu(d->prkey));
>> +out:
>> +	return ret;
>> +}
>> +
>> +static u16 nvmet_pr_preempt_and_abort(struct nvmet_req *req,
>> +				      struct nvmet_pr_registrant *reg,
>> +				      u8 rtype,
>> +				      struct nvmet_pr_acquire_data *d)
>> +{
>> +	return nvmet_pr_preempt(req, reg, rtype, d);
>> +}
>> +
>> +static u16 __nvmet_execute_pr_acquire(struct nvmet_req *req,
>> +				      struct nvmet_pr_registrant *reg,
>> +				      u8 acquire_act,
>> +				      u8 rtype,
>> +				      struct nvmet_pr_acquire_data *d)
>> +{
>> +	u16 status;
>> +
>> +	switch (acquire_act) {
>> +	case NVME_PR_ACQUIRE_ACT_ACQUIRE:
>> +		status = nvmet_pr_acquire(req, reg, rtype);
>> +		goto out;
>> +	case NVME_PR_ACQUIRE_ACT_PREEMPT:
>> +		status = nvmet_pr_preempt(req, reg, rtype, d);
>> +		goto inc_gen;
>> +	case NVME_PR_ACQUIRE_ACT_PREEMPT_AND_ABORT:
>> +		status = nvmet_pr_preempt_and_abort(req, reg, rtype, d);
>> +		goto inc_gen;
>> +	default:
>> +		req->error_loc = offsetof(struct nvme_common_command,
>> +						cdw10);
>> +		status = NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
>> +		goto out;
>> +	}
>> +inc_gen:
>> +	nvmet_pr_inc_generation(&req->ns->pr);
>> +out:
>> +	return status;
>> +}
>> +
>> +static void nvmet_execute_pr_acquire(struct nvmet_req *req)
>> +{
>> +	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
>> +	u8 acquire_act = cdw10 & 0x07;
>> +	bool ignore_key = (bool)((cdw10 >> 3) & 1);
>> +	u8 rtype = (u8)((cdw10 >> 8) & 0xff);
> it'll be nice to add some comments above that saves a trip to spec ...
>
>> +	u16 status = 0;
>> +	struct nvmet_pr_acquire_data *d = NULL;
>> +	struct nvmet_pr *pr = &req->ns->pr;
>> +	struct nvmet_pr_registrant *reg;
>> +	struct nvmet_ctrl *ctrl = req->sq->ctrl;
>> +
> nit:- reverse tree style  plz
>
>> +	if (ignore_key) {
>> +		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
>> +		goto out;
>> +	}
>> +
>> +	d = kmalloc(sizeof(*d), GFP_KERNEL);
>> +	if (!d) {
>> +		status = NVME_SC_INTERNAL;
>> +		goto out;
>> +	}
>> +
>> +	status = nvmet_copy_from_sgl(req, 0, d, sizeof(*d));
>> +	if (status)
>> +		goto free_data;
>> +
>> +	status = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
>> +	write_lock(&pr->pr_lock);
>> +	list_for_each_entry(reg, &pr->registrant_list, entry) {
>> +		if (uuid_equal(&reg->hostid, &ctrl->hostid) &&
>> +		    reg->rkey == le64_to_cpu(d->crkey)) {
>> +			status = __nvmet_execute_pr_acquire(req, reg,
>> +							    acquire_act,
>> +							    rtype, d);
>> +			break;
>> +		}
>> +	}
>> +	write_unlock(&pr->pr_lock);
>> +
>> +free_data:
>> +	kfree(d);
>> +out:
>> +	nvmet_req_complete(req, status);
>> +}
>> +
>> +static u16 nvmet_pr_release(struct nvmet_req *req,
>> +			    struct nvmet_pr_registrant *reg,
>> +			    u8 rtype)
>> +{
>> +	struct nvmet_pr *pr = &req->ns->pr;
>> +
>> +	if (reg != pr->holder || !pr->holder)
>> +		return 0;
>> +	if (pr->rtype != rtype)
>> +		return NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
>> +
>> +	nvmet_pr_clean_holder(pr);
>> +
>> +	/*
>> +	 * Temporarily, don't send notification, because host does not
>> +	 * handle this event.
>> +	 */
> can we add support to host to handle the event ? this comment
> seems a bit unusual ...
>
>> +	return 0;
>> +}
>> +
>> +static void __nvmet_pr_clean_all_registrants(struct nvmet_pr *pr)
>> +{
>> +	struct nvmet_pr_registrant *tmp_reg;
>> +	struct nvmet_pr_registrant *tmp;
>> +
>> +	list_for_each_entry_safe(tmp_reg, tmp, &pr->registrant_list, entry)
>> +		__nvmet_pr_unregister_one(pr, tmp_reg);
>> +}
>> +
>> +static void nvmet_pr_clear(struct nvmet_req *req,
>> +			   struct nvmet_pr_registrant *reg)
>> +{
>> +	struct nvmet_pr *pr = &req->ns->pr;
>> +
>> +	__nvmet_pr_clean_all_registrants(pr);
>> +
>> +	nvmet_pr_inc_generation(&req->ns->pr);
>> +
>> +	/*
>> +	 * Temporarily, don't send notification, because host does not
>> +	 * handle this event.
>> +	 */
> same here
>
>> +}
>> +
>> +static u16 __nvmet_execute_pr_release(struct nvmet_req *req,
>> +				      struct nvmet_pr_registrant *reg,
>> +				      u8 release_act, u8 rtype)
>> +{
>> +	switch (release_act) {
>> +	case NVME_PR_RELEASE_ACT_RELEASE:
>> +		return nvmet_pr_release(req, reg, rtype);
>> +	case NVME_PR_RELEASE_ACT_CLEAR:
>> +		nvmet_pr_clear(req, reg);
>> +		return 0;
>> +	default:
>> +		req->error_loc = offsetof(struct nvme_common_command,
>> +					  cdw10);
>> +		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
>> +	}
>> +}
>> +
>> +static void nvmet_execute_pr_release(struct nvmet_req *req)
>> +{
>> +	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
>> +	u8 release_act = cdw10 & 0x07;
>> +	bool ignore_key = (bool)((cdw10 >> 3) & 1);
>> +	u8 rtype = (u8)((cdw10 >> 8) & 0xff);
>> +	struct nvmet_pr_release_data *d;
>> +	struct nvmet_pr *pr = &req->ns->pr;
>> +	struct nvmet_pr_registrant *reg;
>> +	struct nvmet_pr_registrant *tmp;
>> +	struct nvmet_ctrl *ctrl = req->sq->ctrl;
>> +	u16 status;
>> +
>> +	if (ignore_key) {
>> +		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
>> +		goto out;
>> +	}
>> +
>> +	d = kmalloc(sizeof(*d), GFP_KERNEL);
>> +	if (!d) {
>> +		status = NVME_SC_INTERNAL;
>> +		goto out;
>> +	}
>> +
>> +	status = nvmet_copy_from_sgl(req, 0, d, sizeof(*d));
>> +	if (status)
>> +		goto free_data;
>> +
>> +	status = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
>> +	write_lock(&pr->pr_lock);
>> +	list_for_each_entry_safe(reg, tmp,
>> +				 &pr->registrant_list, entry) {
>> +		if (uuid_equal(&reg->hostid, &ctrl->hostid) &&
>> +		    reg->rkey == le64_to_cpu(d->crkey)) {
>> +			status = __nvmet_execute_pr_release(req, reg,
>> +							    release_act, rtype);
>> +			break;
>> +		}
>> +	}
>> +	write_unlock(&pr->pr_lock);
>> +free_data:
>> +	kfree(d);
>> +out:
>> +	nvmet_req_complete(req, status);
>> +}
>> +
>> +static struct nvmet_pr_registrant *nvmet_pr_find_registrant_by_hostid(
>> +						struct nvmet_pr *pr,
>> +						uuid_t *hostid)
>> +{
>> +	struct nvmet_pr_registrant *reg;
>> +
>> +	list_for_each_entry(reg, &pr->registrant_list, entry) {
>> +		if (uuid_equal(&reg->hostid, hostid))
>> +			return reg;
>> +	}
>> +	return NULL;
>> +}
>> +
>> +static void nvmet_execute_pr_report(struct nvmet_req *req)
>> +{
>> +	u32 cdw11 = le32_to_cpu(req->cmd->common.cdw11);
>> +	u8 eds = cdw11 & 1;
>> +	u16 status = 0;
>> +	u32 num_bytes = 4 * (le32_to_cpu(req->cmd->common.cdw10) + 1);
>> +	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
>> +	struct nvmet_ctrl *ctrl;
>> +	struct nvmet_pr *pr = &req->ns->pr;
>> +	struct nvme_reservation_status_ext *data;
>> +	struct nvme_registered_ctrl_ext *ctrl_data;
>> +	struct nvmet_pr_registrant *reg;
>> +	u16 num_ctrls = 0;
>> +
>> +	/* nvmet hostid(uuid_t) is 128 bit. */
>> +	if (!eds) {
>> +		req->error_loc = offsetof(struct nvme_common_command,
>> +					  cdw11);
>> +		status = NVME_SC_HOST_ID_INCONSIST | NVME_SC_DNR;
>> +		goto out;
>> +	}
>> +
>> +	if (num_bytes < sizeof(struct nvme_reservation_status_ext)) {
>> +		req->error_loc = offsetof(struct nvme_common_command,
>> +					  cdw10);
>> +		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
>> +		goto out;
>> +	}
>> +
>> +	mutex_lock(&subsys->lock);
>> +	read_lock(&pr->pr_lock);
>> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
>> +		if (nvmet_pr_find_registrant_by_hostid(pr, &ctrl->hostid))
>> +			num_ctrls++;
>> +	}
>> +
>> +	num_bytes = min(num_bytes,
>> +			sizeof(struct nvme_reservation_status_ext) +
>> +			sizeof(struct nvme_registered_ctrl_ext) * num_ctrls);
>> +
>> +	data = kmalloc(num_bytes, GFP_KERNEL);
>> +	if (!data) {
>> +		status = NVME_SC_INTERNAL;
>> +		goto out;
>> +	}
>> +	memset(data, 0, num_bytes);
>> +	data->gen = cpu_to_le32(pr->generation);
>> +	data->rtype = pr->rtype;
>> +	put_unaligned_le16(num_ctrls, data->regctl);
>> +	data->ptpls = 0;
>> +	ctrl_data = data->regctl_eds;
>> +
>> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
>> +		if ((void *)ctrl_data >= (void *)(data + num_bytes))
>> +			break;
>> +		reg = nvmet_pr_find_registrant_by_hostid(pr, &ctrl->hostid);
>> +		if (!reg)
>> +			continue;
>> +		ctrl_data->cntlid = cpu_to_le16(ctrl->cntlid);
>> +		if (pr->rtype == NVME_PR_WRITE_EXCLUSIVE_ALL_REGS ||
>> +		    pr->rtype == NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS)
>> +			ctrl_data->rcsts = 1;
>> +		if (pr->holder &&
>> +		    uuid_equal(&ctrl->hostid, &pr->holder->hostid))
>> +			ctrl_data->rcsts = 1;
>> +		uuid_copy((uuid_t *)&ctrl_data->hostid, &ctrl->hostid);
>> +		ctrl_data->rkey = cpu_to_le64(reg->rkey);
>> +		ctrl_data++;
>> +	}
>> +	status = nvmet_copy_to_sgl(req, 0, data, num_bytes);
>> +out:
>> +	read_unlock(&pr->pr_lock);
>> +	mutex_unlock(&subsys->lock);
>> +	nvmet_req_complete(req, status);
>> +}
>> +
>> +u16 nvmet_parse_pr_cmd(struct nvmet_req *req)
>> +{
>> +	struct nvme_command *cmd = req->cmd;
>> +
>> +	if (!req->ns->pr.enable)
>> +		return 1;
>> +
>> +	switch (cmd->common.opcode) {
>> +	case nvme_cmd_resv_register:
>> +		req->execute = nvmet_execute_pr_register;
>> +		break;
>> +	case nvme_cmd_resv_acquire:
>> +		req->execute = nvmet_execute_pr_acquire;
>> +		break;
>> +	case nvme_cmd_resv_release:
>> +		req->execute = nvmet_execute_pr_release;
>> +		break;
>> +	case nvme_cmd_resv_report:
>> +		req->execute = nvmet_execute_pr_report;
>> +		break;
>> +	default:
>> +		return 1;
>> +	}
>> +	return 0;
>> +}
>> +
>> +static bool nvmet_is_req_copy_cmd_group(struct nvmet_req *req)
>> +{
>> +	struct nvme_command *cmd = req->cmd;
>> +	u8 opcode = cmd->common.opcode;
> I think we really don't need the cmd va above code is clear without it.
>
>> +	return req->sq->qid && opcode == nvme_cmd_copy;
>> +}
>> +
>> +static bool nvmet_is_req_write_cmd_group(struct nvmet_req *req)
>> +{
>> +	struct nvme_command *cmd = req->cmd;
>> +	u8 opcode = cmd->common.opcode;
>> +
> we can safely remove cmd above ...
>
> looking forward to see v2 ...
>
> -ck

For all comments, thanks a lot,

These will be changes in v2.

Best regards,

Guixin Liu

>

