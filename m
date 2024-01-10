Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5885C3DA6E
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jan 2024 08:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OjlBCoBK6iMOTMMUY76L+BDaJyUeyx5z2HoMd2zl2Bg=; b=eBQmwWg/FNxS8/GzHVUK0xi6n8
	GF9RfTW+Bf5n2Qo37/8sutNNSmnb/O3Kl+RqoHGkiVNlv2GDyAA6itKGMSFLE8wsgP0mouoy65iQb
	pdRloHgZqb1DmyIfzG4a85VeCecUHvPY/NcuGVplWxHiI1h3P3BTX5Im//EhAVcAIQ7NPYrhz30OL
	fIOo6oYmB50sqXRwt0RDY9X7bVVxXxXAVVcRUuz+CaxWYk91uIgivgQ+HHMW0UDlNK048fm4pJHPj
	Dh5L3wFr5O8yIxbfbeSCg7/AYeD7MDoSjVHacpDtDH4C2tzxKfZyFHjc+ADYE+QysU0zm2beqINb0
	rvBvu4+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNUDr-00AmnS-31;
	Wed, 10 Jan 2024 08:46:03 +0000
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNUDo-00Ammi-23
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jan 2024 08:46:02 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W-LMsY8_1704876351;
Received: from 30.178.83.60(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W-LMsY8_1704876351)
          by smtp.aliyun-inc.com;
          Wed, 10 Jan 2024 16:45:52 +0800
Message-ID: <54de4b6d-e5e6-4caf-85f3-a1ea6ddbfe6a@linux.alibaba.com>
Date: Wed, 10 Jan 2024 16:45:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: support reservation feature
Content-Language: en-GB
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
References: <20240109121008.15925-1-kanie@linux.alibaba.com>
 <3a2055ff-6e5c-4afc-a0e1-36255d569e5e@nvidia.com>
 <e6427481-73f3-478b-aadb-e59b096805c8@linux.alibaba.com>
 <0652d478-9b46-400b-85ec-b3a2bb54ff67@nvidia.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <0652d478-9b46-400b-85ec-b3a2bb54ff67@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240110_004600_821661_501A568F 
X-CRM114-Status: GOOD (  18.14  )
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


在 2024/1/10 16:31, Chaitanya Kulkarni 写道:
> On 1/9/24 21:58, Guixin Liu wrote:
>> 在 2024/1/10 12:34, Chaitanya Kulkarni 写道:
>>> On 1/9/24 04:10, Guixin Liu wrote:
>>>> This patch implements the reservation feature, includes:
>>>> 1. reservation register(register, unregister and replace).
>>>> 2. reservation acquire(acquire, preempt, preempt and abort).
>>>> 3. reservation release(release and clear).
>>>> 4. reservation report.
>>>>
>>>> And also make reservation configurable, one can set ns to support
>>>> reservation before enable ns. The default of resv_enable is false.
>>>>
>>>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>>>> ---
>>>> Hi guys,
>>>>        I've implemented the NVMe reservation feature. Please review
>>>> it, all
>>>> comments are welcome.
>>>>        In addtion, I didn't implement event reporting because I
>>>> didn't see
>>>> any handling of these events on the host side. If these events are
>>>> mandatory
>>>> to report, please let me know so that I can implement them.
>>>>
>>>>     drivers/nvme/target/Makefile    |   2 +-
>>>>     drivers/nvme/target/admin-cmd.c |  14 +-
>>>>     drivers/nvme/target/configfs.c  |  27 ++
>>>>     drivers/nvme/target/core.c      |  37 +-
>>>>     drivers/nvme/target/nvmet.h     |  26 ++
>>>>     drivers/nvme/target/pr.c        | 806
>>>> ++++++++++++++++++++++++++++++++
>>>>     include/linux/nvme.h            |  30 ++
>>>>     7 files changed, 939 insertions(+), 3 deletions(-)
>>>>     create mode 100644 drivers/nvme/target/pr.c
>>>>
>>>> diff --git a/drivers/nvme/target/Makefile
>>>> b/drivers/nvme/target/Makefile
>>>> index c66820102493..f9bfc904a5b3 100644
>>>> --- a/drivers/nvme/target/Makefile
>>>> +++ b/drivers/nvme/target/Makefile
>>>> @@ -10,7 +10,7 @@ obj-$(CONFIG_NVME_TARGET_FCLOOP)    += nvme-fcloop.o
>>>>     obj-$(CONFIG_NVME_TARGET_TCP)        += nvmet-tcp.o
>>>>        nvmet-y        += core.o configfs.o admin-cmd.o fabrics-cmd.o \
>>>> -            discovery.o io-cmd-file.o io-cmd-bdev.o
>>>> +            discovery.o io-cmd-file.o io-cmd-bdev.o pr.o
>>>>     nvmet-$(CONFIG_NVME_TARGET_PASSTHRU)    += passthru.o
>>>>     nvmet-$(CONFIG_BLK_DEV_ZONED)        += zns.o
>>>>     nvmet-$(CONFIG_NVME_TARGET_AUTH)    += fabrics-cmd-auth.o auth.o
>>>> diff --git a/drivers/nvme/target/admin-cmd.c
>>>> b/drivers/nvme/target/admin-cmd.c
>>>> index 39cb570f833d..7da6f3085a4c 100644
>>>> --- a/drivers/nvme/target/admin-cmd.c
>>>> +++ b/drivers/nvme/target/admin-cmd.c
>>>> @@ -550,7 +550,13 @@ static void nvmet_execute_identify_ns(struct
>>>> nvmet_req *req)
>>>>          */
>>>>         id->nmic = NVME_NS_NMIC_SHARED;
>>>>         id->anagrpid = cpu_to_le32(req->ns->anagrpid);
>>>> -
>>>> +    id->rescap = NVME_PR_SUPPORT_WRITE_EXCLUSIVE |
>>>> +             NVME_PR_SUPPORT_EXCLUSIVE_ACCESS |
>>>> +             NVME_PR_SUPPORT_WRITE_EXCLUSIVE_REG_ONLY |
>>>> +             NVME_PR_SUPPORT_EXCLUSIVE_ACCESS_REG_ONLY |
>>>> +             NVME_PR_SUPPORT_WRITE_EXCLUSIVE_ALL_REGS |
>>>> +             NVME_PR_SUPPORT_EXCLUSIVE_ACCESS_ALL_REGS |
>>>> +             NVME_PR_SUPPORT_IEKEY_DEF_LATER_VER_1_3;
>>>>         memcpy(&id->nguid, &req->ns->nguid, sizeof(id->nguid));
>>>>            id->lbaf[0].ds = req->ns->blksize_shift;
>>>> @@ -1017,6 +1023,12 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
>>>>         if (nvmet_is_passthru_req(req))
>>>>             return nvmet_parse_passthru_admin_cmd(req);
>>>>     +    ret = nvmet_pr_check_cmd_access(req);
>>>> +    if (unlikely(ret)) {
>>>> +        req->error_loc = offsetof(struct nvme_common_command, opcode);
>>>> +        return ret;
>>>> +    }
>>>> +
>>>>         switch (cmd->common.opcode) {
>>>>         case nvme_admin_get_log_page:
>>>>             req->execute = nvmet_execute_get_log_page;
>>>> diff --git a/drivers/nvme/target/configfs.c
>>>> b/drivers/nvme/target/configfs.c
>>>> index d937fe05129e..1ac4802ec818 100644
>>>> --- a/drivers/nvme/target/configfs.c
>>>> +++ b/drivers/nvme/target/configfs.c
>>>> @@ -714,6 +714,32 @@ static ssize_t
>>>> nvmet_ns_revalidate_size_store(struct config_item *item,
>>>>        CONFIGFS_ATTR_WO(nvmet_ns_, revalidate_size);
>>>>     +static ssize_t nvmet_ns_resv_enable_show(struct config_item
>>>> *item, char *page)
>>>> +{
>>>> +    return sprintf(page, "%d\n", to_nvmet_ns(item)->pr.enable);
>>>> +}
>>>> +
>>>> +static ssize_t nvmet_ns_resv_enable_store(struct config_item *item,
>>>> +                    const char *page, size_t count)
>>>> +{
>>>> +    struct nvmet_ns *ns = to_nvmet_ns(item);
>>>> +    bool val;
>>>> +
>>>> +    if (kstrtobool(page, &val))
>>>> +        return -EINVAL;
>>>> +
>>>> +    mutex_lock(&ns->subsys->lock);
>>>> +    if (ns->enabled) {
>>>> +        pr_err("the ns:%d is already enabled.\n", ns->nsid);
>>>> +        mutex_unlock(&ns->subsys->lock);
>>>> +        return -EINVAL;
>>>> +    }
>>>> +    ns->pr.enable = val;
>>>> +    mutex_unlock(&ns->subsys->lock);
>>>> +    return count;
>>>> +}
>>>> +CONFIGFS_ATTR(nvmet_ns_, resv_enable);
>>>> +
>>>>     static struct configfs_attribute *nvmet_ns_attrs[] = {
>>>>         &nvmet_ns_attr_device_path,
>>>>         &nvmet_ns_attr_device_nguid,
>>>> @@ -722,6 +748,7 @@ static struct configfs_attribute
>>>> *nvmet_ns_attrs[] = {
>>>>         &nvmet_ns_attr_enable,
>>>>         &nvmet_ns_attr_buffered_io,
>>>>         &nvmet_ns_attr_revalidate_size,
>>>> +    &nvmet_ns_attr_resv_enable,
>>>>     #ifdef CONFIG_PCI_P2PDMA
>>>>         &nvmet_ns_attr_p2pmem,
>>>>     #endif
>>>> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
>>>> index 3935165048e7..8eab81804b14 100644
>>>> --- a/drivers/nvme/target/core.c
>>>> +++ b/drivers/nvme/target/core.c
>>>> @@ -598,6 +598,7 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
>>>>         subsys->nr_namespaces++;
>>>>            nvmet_ns_changed(subsys, ns->nsid);
>>>> +    nvmet_pr_init_ns(ns);
>>>>         ns->enabled = true;
>>>>         ret = 0;
>>>>     out_unlock:
>>>> @@ -651,6 +652,7 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
>>>>            subsys->nr_namespaces--;
>>>>         nvmet_ns_changed(subsys, ns->nsid);
>>>> +    nvmet_pr_clean_all_registrants(&ns->pr);
>>>>         nvmet_ns_dev_disable(ns);
>>>>     out_unlock:
>>>>         mutex_unlock(&subsys->lock);
>>>> @@ -904,6 +906,16 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req
>>>> *req)
>>>>             return ret;
>>>>         }
>>>>     +    ret = nvmet_pr_check_cmd_access(req);
>>>> +    if (unlikely(ret)) {
>>>> +        req->error_loc = offsetof(struct nvme_common_command, opcode);
>>>> +        return ret;
>>>> +    }
>>>> +
>>>> +    ret = nvmet_parse_pr_cmd(req);
>>>> +    if (!ret)
>>>> +        return ret;
>>>> +
>>> Can we make this feature configurable via Kconfig? If someone doesn't
>>> want to
>>> use PR, they will have to bear the cost of these checks in the fast
>>> path.
>> Yeah, I have added a resv_enable in configfs, the default is false,
>> one can
>>
>> make reservation enable before enable namespace.
> Why can't we make it KConfig option ? Is there any particular reason for
> not doing that ? That will also allow user to avoid kernel compilation
> of code if they want to turn it off.
>
> -ck
>
OK, I will add a Kconfig option.

