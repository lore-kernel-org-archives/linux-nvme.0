Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9785C3DA79
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jan 2024 02:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HywiPO+8i47MTl8IQ0YDbuTH2jnXBMYczGBdRp3cii4=; b=N1IV01v1i8N7vWUaTJaDDfuFaI
	xLbx7b/kmCkkcM6Y3XfWHUt1Sexfyt6hIuoZk2S1w56LlI9dch/NLQZipMo0tjev5J8O1JQtMi8fI
	+y4iwQDLVliKhiwlcOyNFMYpImPkP7Rjz6e63Ds6l8+BrBCsVCpRf4neE0pN8uupYYU/gtbLKves4
	5EHBi9VYOMPuMb3yHQ51wxk4wELEWu1BXk6jfdeQc+uk24GkGNNt7rtx40SwT2oTDR6m+PEbPr91z
	Ilfu0aEZd7ZGfvKznLGvvWwtK0czxc9xb2GHTAFxGJZarFNf3oZqFaMSg9InlXYJEIhcYup3vF8Px
	nt+U4VSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPYmM-00Alzx-0L;
	Tue, 16 Jan 2024 02:02:14 +0000
Received: from out30-97.freemail.mail.aliyun.com ([115.124.30.97])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPYmJ-00AlyL-0C
	for linux-nvme@lists.infradead.org;
	Tue, 16 Jan 2024 02:02:12 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W-kA3C-_1705370522;
Received: from 30.178.82.220(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W-kA3C-_1705370522)
          by smtp.aliyun-inc.com;
          Tue, 16 Jan 2024 10:02:03 +0800
Message-ID: <11bdf630-66b4-433a-a7c2-ff5d6d4f1b76@linux.alibaba.com>
Date: Tue, 16 Jan 2024 10:02:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/3] nvme: introduce pr_work to handle resv event
Content-Language: en-GB
To: Sagi Grimberg <sagi@grimberg.me>, hch@lst.de, kch@nvidia.com,
 chaitanyak@nvidia.com
Cc: linux-nvme@lists.infradead.org
References: <20240114092314.63694-1-kanie@linux.alibaba.com>
 <20240114092314.63694-4-kanie@linux.alibaba.com>
 <dcfe1277-bb99-4245-9f28-ae14e8ed8954@grimberg.me>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <dcfe1277-bb99-4245-9f28-ae14e8ed8954@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240115_180211_266117_93957367 
X-CRM114-Status: GOOD (  18.44  )
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


在 2024/1/15 16:59, Sagi Grimberg 写道:
>
>> When a reservation event is reported, the corresponding log page is
>> already on the target side, and the host side needs to send a get
>> log command to clear these log pages.
>
> AENs are already sent to userspace, I don't see why the kernel
> should read the log page unless it has something meaningful to
> do with it.
>
Is it tolerable if we dont clear the log page?

Maybe I should check the max count of resv_log_list in nvmet.

>>
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> ---
>>   drivers/nvme/host/core.c | 47 +++++++++++++++++++++++++++++++++++++++-
>>   drivers/nvme/host/nvme.h |  1 +
>>   2 files changed, 47 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 60f14019f981..a906aea2f4a8 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -4220,6 +4220,47 @@ static void 
>> nvme_handle_aer_persistent_error(struct nvme_ctrl *ctrl)
>>       nvme_reset_ctrl(ctrl);
>>   }
>>   +static void nvme_queue_pr(struct nvme_ctrl *ctrl)
>> +{
>> +    if (nvme_ctrl_state(ctrl) == NVME_CTRL_LIVE)
>> +        queue_work(nvme_wq, &ctrl->pr_work);
>> +}
>> +
>> +static void nvme_pr_work(struct work_struct *work)
>> +{
>> +    struct nvme_ctrl *ctrl = container_of(work, struct nvme_ctrl, 
>> pr_work);
>> +    struct nvme_pr_log log = { 0 };
>> +    int error;
>> +
>> +    if (nvme_ctrl_state(ctrl) != NVME_CTRL_LIVE)
>> +        return;
>> +
>> +    error = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_RESERVATION, 0,
>> +            NVME_CSI_NVM, &log, sizeof(log), 0);
>> +    if (error) {
>> +        dev_warn(ctrl->device,
>> +             "reading reservation log failed: %d\n", error);
>> +        return;
>> +    }
>> +
>> +    if (log.nr_avl_pages)
>> +        nvme_queue_pr(ctrl);
>> +}
>> +
>> +static void nvme_handle_aen_css(struct nvme_ctrl *ctrl, u32 result)
>> +{
>> +    u32 aer_css_type = nvme_aer_subtype(result);
>> +
>> +    switch (aer_css_type) {
>> +    case NVME_AEN_RESV_LOG_PAGE_AVALIABLE:
>> +        nvme_queue_pr(ctrl);
>> +        break;
>> +    default:
>> +        ctrl->aen_result = result;
>> +        dev_warn(ctrl->device, "async event result %08x\n", result);
>> +    }
>> +}
>> +
>>   void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
>>           volatile union nvme_result *res)
>>   {
>> @@ -4236,6 +4277,9 @@ void nvme_complete_async_event(struct nvme_ctrl 
>> *ctrl, __le16 status,
>>       case NVME_AER_NOTICE:
>>           requeue = nvme_handle_aen_notice(ctrl, result);
>>           break;
>> +    case NVME_AER_CSS:
>> +        nvme_handle_aen_css(ctrl, result);
>> +        break;
>>       case NVME_AER_ERROR:
>>           /*
>>            * For a persistent internal error, don't run async_event_work
>> @@ -4247,7 +4291,6 @@ void nvme_complete_async_event(struct nvme_ctrl 
>> *ctrl, __le16 status,
>>           }
>>           fallthrough;
>>       case NVME_AER_SMART:
>> -    case NVME_AER_CSS:
>>       case NVME_AER_VS:
>>           ctrl->aen_result = result;
>>           break;
>> @@ -4389,6 +4432,7 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
>>       nvme_stop_keep_alive(ctrl);
>>       nvme_stop_failfast_work(ctrl);
>>       flush_work(&ctrl->async_event_work);
>> +    flush_work(&ctrl->pr_work);
>>       cancel_work_sync(&ctrl->fw_act_work);
>>       if (ctrl->ops->stop_ctrl)
>>           ctrl->ops->stop_ctrl(ctrl);
>> @@ -4494,6 +4538,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, 
>> struct device *dev,
>>       ctrl->quirks = quirks;
>>       ctrl->numa_node = NUMA_NO_NODE;
>>       INIT_WORK(&ctrl->scan_work, nvme_scan_work);
>> +    INIT_WORK(&ctrl->pr_work, nvme_pr_work);
>>       INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
>>       INIT_WORK(&ctrl->fw_act_work, nvme_fw_act_work);
>>       INIT_WORK(&ctrl->delete_work, nvme_delete_ctrl_work);
>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>> index e7411dac00f7..6ea4552c4de3 100644
>> --- a/drivers/nvme/host/nvme.h
>> +++ b/drivers/nvme/host/nvme.h
>> @@ -334,6 +334,7 @@ struct nvme_ctrl {
>>       struct nvme_effects_log *effects;
>>       struct xarray cels;
>>       struct work_struct scan_work;
>> +    struct work_struct pr_work;
>>       struct work_struct async_event_work;
>>       struct delayed_work ka_work;
>>       struct delayed_work failfast_work;

