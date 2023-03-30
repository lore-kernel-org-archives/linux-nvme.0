Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B2DC6FD1D
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Mar 2023 13:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p67QewFsKWBBB0QPJuOxkGZ+XbAl0C9D9ZWjGOXPYmc=; b=02cNVYjute3F+VdG0mUT3Y3v4U
	jnueIA8y8oGLUsWq9gJRujrVtzoONtGleYAAZ5wEmK9f423TWQHeaBzoBEiliAAwnRcHD2aKl7hTm
	eWap3Hk7+mZr4Holy6+1HVxJ3xktfFa+IQ/XCtnOkI/Wqf10Ayj/SOUqWSaQPwx+pgcmBSY96Qs1o
	j48cP7rbxmvirl47SI/r6JnjCabs4tMRU9wLIhUJef3VIPaSJn0hyeQWbw3d8apssaPWoFvB0GFqO
	MG73l8ETWEB3l7dW9OCtiPDYqtXgJrA6ZBofQa10U3Ps60SPBgDFm7bAnK+tzkKpNBiKkUYhawzwo
	307tCFEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phsUG-003uBb-1C;
	Thu, 30 Mar 2023 13:38:44 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phsUC-003uB3-0E
	for linux-nvme@lists.infradead.org;
	Thu, 30 Mar 2023 13:38:41 +0000
Received: by mail-wr1-f51.google.com with SMTP id d17so19099601wrb.11
        for <linux-nvme@lists.infradead.org>; Thu, 30 Mar 2023 06:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680183517; x=1682775517;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p67QewFsKWBBB0QPJuOxkGZ+XbAl0C9D9ZWjGOXPYmc=;
        b=w2cUg9O/1rXykRZodxIvJs6M8kRGDLw+QKnvYubmf3A1cWVYrlITCHSos24oMnKVbE
         QEJu9WUlClsRsmQ/DepgqIlBmFf8TCqc3BRg8e3q7Ne6Byfwd0bUuPxjj+LA8giSXacM
         MJAFSMtdzeYCuiVCL9SFta8n5rZvGOxCnTcV1YEiZ4SoNfgDS6Ze8rbCH78dClVqkSuk
         HcOUtCilKS9yn7n1rX9kEQPBoYe1ddWkaDbrkdFv877q/uDoy/EQpfKz62QTVrUFSBH8
         XhusQc2rdDEGZcjn9/Ah297BfqguULepU9f+SJWJ3mgoH864B6M5K0kuW4lXyI77PDf9
         CNDQ==
X-Gm-Message-State: AAQBX9dVne1yLjCR37172gqhP9/s2e90eV+S+28yW51miHbgpx3u3uRY
	qH0QMXUhrd7iIAubrkw3tcc=
X-Google-Smtp-Source: AKy350ZxHyrl+Z1WvORY8n+T2qmvUxV+r6jL/H1BxkjvarIl23Y3mE5xfCLFd8sKEJSAchKI3D7Avw==
X-Received: by 2002:adf:ee8a:0:b0:2e4:c9ac:c491 with SMTP id b10-20020adfee8a000000b002e4c9acc491mr1269321wro.1.1680183517252;
        Thu, 30 Mar 2023 06:38:37 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.11.dynamic.barak-online.net. [85.65.206.11])
        by smtp.gmail.com with ESMTPSA id s13-20020a5d510d000000b002c794495f6fsm29841782wrt.117.2023.03.30.06.38.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 06:38:36 -0700 (PDT)
Message-ID: <efc01aad-737b-b50c-b4f6-fb928fbecbab@grimberg.me>
Date: Thu, 30 Mar 2023 16:38:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC v2 2/3] nvme: add error logging opt-in
Content-Language: en-US
To: alan.adamson@oracle.com, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, p.raghav@samsung.com, kbusch@kernel.org
References: <20230323230316.2914077-1-alan.adamson@oracle.com>
 <20230323230316.2914077-3-alan.adamson@oracle.com>
 <20230328005735.GC21497@lst.de>
 <89ee30c7-7c7d-b0c6-3234-07e698d211ed@oracle.com>
 <27a9d788-869c-93fc-9a24-48c163621098@grimberg.me>
 <6c9fe658-42f0-a006-b8fa-1a8d87d681a2@oracle.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <6c9fe658-42f0-a006-b8fa-1a8d87d681a2@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230330_063840_131764_348BB41E 
X-CRM114-Status: GOOD (  16.95  )
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


>>>>> Commit d7ac8dca938c ("nvme: quiet user passthrough command errors") 
>>>>> disabled error
>>>>> logging for user passthrough commands.  This commit adds the 
>>>>> ability to opt-in
>>>>> to passthrough error logging.
>>>>>
>>>>> To enable passthrough error logging:
>>>>>          echo 1 > /sys/kernel/debug/nvme0/error-logging
>>>>>
>>>>> To disable passthrough error logging:
>>>>>          echo 0 > /sys/kernel/debug/nvme0/error-logging
>>>>>
>>>>> By default, passthrough error logging will remain disabled.
>>>>>
>>>>> CONFIG_NVME_ERROR_LOGGING_DEBUG_FS needs to be enabled to
>>>>> to enable passthrough error logging.
>>>> Any reason to do this in debugfs vs sysfs which is someting
>>>> that we can a handle too much more easily?
>>>>
>>>> Also why do we need a config option for a trivial mount of code?
>>>>
>>> Putting it in sysfs may make more sense and not require debugfs to be 
>>> configured.  See below.
>>>
>>> Alan
>>>
>>>
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index 53ef028596c6..24b4dcbfe819 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -337,6 +337,49 @@ static void nvme_log_error(struct request *req)
>>>                  nr->status & NVME_SC_DNR  ? "DNR "  : "");
>>>   }
>>>
>>> +static void nvme_log_error_passthrough(struct request *req)
>>> +{
>>> +    struct nvme_ns *ns = req->q->queuedata;
>>> +    struct nvme_request *nr = nvme_req(req);
>>> +
>>> +    if (ns) {
>>> +        pr_err_ratelimited("%s: %s(0x%x), %s (sct 0x%x / sc 0x%x) 
>>> %s%s: "
>>> +               "cdw10=0x%x cdw11=0x%x cdw12=0x%x cdw13=0x%x 
>>> cdw14=0x%x cdw15=0x%x\n",
>>> +               ns->disk ? ns->disk->disk_name : "?",
>>> + nvme_get_opcode_str(nr->cmd->common.opcode),
>>> +               nr->cmd->common.opcode,
>>> +               nvme_get_error_status_str(nr->status),
>>> +               nr->status >> 8 & 7,    /* Status Code Type */
>>> +               nr->status & 0xff,    /* Status Code */
>>> +               nr->status & NVME_SC_MORE ? "MORE " : "",
>>> +               nr->status & NVME_SC_DNR  ? "DNR "  : "",
>>> +               nr->cmd->common.cdw10,
>>> +               nr->cmd->common.cdw11,
>>> +               nr->cmd->common.cdw12,
>>> +               nr->cmd->common.cdw13,
>>> +               nr->cmd->common.cdw14,
>>> +               nr->cmd->common.cdw15);
>>> +        return;
>>> +    }
>>> +
>>> +    pr_err_ratelimited("%s: %s(0x%x), %s (sct 0x%x / sc 0x%x) %s%s: "
>>> +               "cdw10=0x%x cdw11=0x%x cdw12=0x%x cdw13=0x%x 
>>> cdw14=0x%x cdw15=0x%x\n",
>>> +               dev_name(nr->ctrl->device),
>>> + nvme_get_admin_opcode_str(nr->cmd->common.opcode),
>>> +               nr->cmd->common.opcode,
>>> +               nvme_get_error_status_str(nr->status),
>>> +               nr->status >> 8 & 7,    /* Status Code Type */
>>> +               nr->status & 0xff,    /* Status Code */
>>> +               nr->status & NVME_SC_MORE ? "MORE " : "",
>>> +               nr->status & NVME_SC_DNR  ? "DNR "  : "",
>>> +                   nr->cmd->common.cdw10,
>>> +                   nr->cmd->common.cdw11,
>>> +                   nr->cmd->common.cdw12,
>>> +                   nr->cmd->common.cdw13,
>>> +                   nr->cmd->common.cdw14,
>>> +                   nr->cmd->common.cdw15);
>>> +}
>>> +
>>>   enum nvme_disposition {
>>>       COMPLETE,
>>>       RETRY,
>>> @@ -381,8 +424,12 @@ static inline void nvme_end_req(struct request 
>>> *req)
>>>   {
>>>       blk_status_t status = nvme_error_status(nvme_req(req)->status);
>>>
>>> -    if (unlikely(nvme_req(req)->status && !(req->rq_flags & 
>>> RQF_QUIET)))
>>> -        nvme_log_error(req);
>>> +    if (unlikely(nvme_req(req)->status && !(req->rq_flags & 
>>> RQF_QUIET))) {
>>> +        if (blk_rq_is_passthrough(req))
>>> +            nvme_log_error_passthrough(req);
>>> +        else
>>> +            nvme_log_error(req);
>>> +    }
>>>       nvme_end_req_zoned(req);
>>>       nvme_trace_bio_complete(req);
>>>       if (req->cmd_flags & REQ_NVME_MPATH)
>>> @@ -666,6 +713,8 @@ static inline void nvme_clear_nvme_request(struct 
>>> request *req)
>>>   /* initialize a passthrough request */
>>>   void nvme_init_request(struct request *req, struct nvme_command *cmd)
>>>   {
>>> +    struct nvme_request *nr = nvme_req(req);
>>> +
>>>       if (req->q->queuedata)
>>>           req->timeout = NVME_IO_TIMEOUT;
>>>       else /* no queuedata implies admin queue */
>>> @@ -678,8 +727,10 @@ void nvme_init_request(struct request *req, 
>>> struct nvme_command *cmd)
>>>       if (req->mq_hctx->type == HCTX_TYPE_POLL)
>>>           req->cmd_flags |= REQ_POLLED;
>>>       nvme_clear_nvme_request(req);
>>> -    req->rq_flags |= RQF_QUIET;
>>> -    memcpy(nvme_req(req)->cmd, cmd, sizeof(*cmd));
>>> +    if (!nr->ctrl->error_logging)
>>> +        req->rq_flags |= RQF_QUIET;
>>> +
>>> +    memcpy(nr->cmd, cmd, sizeof(*cmd));
>>>   }
>>>   EXPORT_SYMBOL_GPL(nvme_init_request);
>>>
>>> @@ -3418,6 +3469,37 @@ static ssize_t nvme_sysfs_rescan(struct device 
>>> *dev,
>>>   }
>>>   static DEVICE_ATTR(rescan_controller, S_IWUSR, NULL, 
>>> nvme_sysfs_rescan);
>>>
>>> +static ssize_t nvme_passthrough_show(struct device *dev,
>>> +        struct device_attribute *attr, char *buf)
>>> +{
>>> +    struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>>> +
>>> +    if (ctrl->error_logging)
>>> +        return sysfs_emit(buf, "on\n");
>>> +    else
>>> +        return sysfs_emit(buf, "off\n");
>>> +}
>>> +
>>> +static ssize_t nvme_passthrough_store(struct device *dev,
>>> +        struct device_attribute *attr, const char *buf, size_t count)
>>> +{
>>> +    struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>>> +    int passthrough_enable, err;
>>> +
>>> +    err = kstrtoint(buf, 10, &passthrough_enable);
>>> +    if (err)
>>> +        return -EINVAL;
>>> +
>>> +    if (passthrough_enable)
>>> +        ctrl->error_logging = true;
>>> +    else
>>> +        ctrl->error_logging = false;
>>> +
>>> +    return count;
>>> +}
>>> +
>>> +static DEVICE_ATTR(passthrough_logging, S_IRUGO | S_IWUSR, 
>>> nvme_passthrough_show, nvme_passthrough_store);
>>
>> Is this something that we need per ctrl? My assumption is that
>> if someone wants this, one would enable it for all controllers.
>> Maybe this should be a modparam instead?
> 
> Maybe both?  Have the ability to set the system-wide default value via 
> modparam and sysfs to change it per ctrl?

Definitely not both. If per controller setting is needed then lets do
that, and if not, lets do a global modparam.

