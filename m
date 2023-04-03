Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07D1C77B60
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Apr 2023 10:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XZ8YCHxy2017XHIVBjMUmgWj0pup92yh//B1kf24Ej8=; b=dOMdlRPJJ0FLIiL0ars5U8WolM
	Ilrxj5wgwjCkQZCUD4exYDOUi2oxU5z25DaHDu1C4KiuM0IH6n8YO2QXYcFZwtrKMuodBjUW5mWM8
	w0UhmfAiGT6hdk6Dliw30D3wSK9uwqqbUw+gOS6FGof09p8luOnYDLBpOHFPWCSt8rCDU57N+3h1/
	lNJZYwKIwQUNWBGpMLthV5bbspLCAR3C8kcKNdaqh2RK2a9xp7cymu7V60gCUXjBcXpj0MzU7gQ7e
	M+8t95aS4kQDzZ55EaUoEd3KcF/cyHMxosIq8vFLo2NcMNiS4B7ZgQHI7CAt1Rk2uMW4cJMzZcFV6
	Z4f3hkpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pjHFj-00EtVz-2h;
	Mon, 03 Apr 2023 10:17:31 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pjHFf-00EtUl-36
	for linux-nvme@lists.infradead.org;
	Mon, 03 Apr 2023 10:17:29 +0000
Received: by mail-wm1-f52.google.com with SMTP id n10-20020a05600c4f8a00b003ee93d2c914so19128714wmq.2
        for <linux-nvme@lists.infradead.org>; Mon, 03 Apr 2023 03:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680517045; x=1683109045;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XZ8YCHxy2017XHIVBjMUmgWj0pup92yh//B1kf24Ej8=;
        b=Fiol15+lJ2pVyBkV2QjYlxqE5Ow4q8WOs22Fhp/BPmOxMGhn84cDjhJJuPq170bdLc
         tHH0TUUTOXJ/T9Rb/sbl3uNypM1wZ+wRWswaj6p+M4ZP9iKkQOltUG6hhQeQ8StEk0XO
         wXxyX1HmDOQUAjAXyNfimSyc1Q+Ss2xhX/LemYGFOuqWfZtSGBkmqquqiURVmQiiT+E4
         aVr3CWvvs+dTwuZU0wCeptQO0VfvW6MH+sxGNqxJ3GqgMSJ2wMX4kuyDrFlF9Yr5sRW7
         rbFdPvZl/E5ow9NF9L+YBJ75ThC11lOlR+XATZh8ApyyO+Ltpj7pq786zDnHyikLau2H
         6Gow==
X-Gm-Message-State: AAQBX9cTd0b4ttZTJDSVWLJazNJE1I5GyFGpZ8cjAmPBHtu7gkOMxTJm
	FaHEwwnnO6vhRtK95jWLW0t21uxcLiQ=
X-Google-Smtp-Source: AKy350bf1tn3wQZn7F1QRdwu6HVRf+9y2EOBo5Weq0MDAz6kHCmvhASwM08O6KMcMucxk5Sv0gL30w==
X-Received: by 2002:a05:600c:4f4e:b0:3f0:330b:d316 with SMTP id m14-20020a05600c4f4e00b003f0330bd316mr12509215wmq.3.1680517044832;
        Mon, 03 Apr 2023 03:17:24 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id r1-20020a5d4941000000b002cfefa50a8esm9369434wrs.98.2023.04.03.03.17.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 03:17:24 -0700 (PDT)
Message-ID: <40dba1f3-8307-ca1a-ad6f-c80df87e0344@grimberg.me>
Date: Mon, 3 Apr 2023 13:17:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC v3 1/1] nvme: add passthrough error logging opt-in
To: Alan Adamson <alan.adamson@oracle.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de
References: <20230331221823.2806192-1-alan.adamson@oracle.com>
 <20230331221823.2806192-2-alan.adamson@oracle.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230331221823.2806192-2-alan.adamson@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230403_031727_997365_E59166D1 
X-CRM114-Status: GOOD (  24.22  )
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



On 4/1/23 01:18, Alan Adamson wrote:
> Commit d7ac8dca938c ("nvme: quiet user passthrough command errors") disabled error
> logging for user passthrough commands.  This commit adds the ability to opt-in
> to passthrough error logging.
> 
> To enable passthrough error logging:
>          echo 1 > /sys/class/nvme/nvme0/passthrough_logging
> 
> To disable passthrough error logging:
>          echo 0 > /sys/class/nvme/nvme0/passthrough_logging
> 
> By default, passthrough error logging will remain disabled.
> 
> Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
> ---
>   drivers/nvme/host/core.c | 93 ++++++++++++++++++++++++++++++++++++++--
>   drivers/nvme/host/nvme.h |  1 +
>   2 files changed, 90 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 53ef028596c6..82d4f8235a8f 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -337,6 +337,49 @@ static void nvme_log_error(struct request *req)
>   			   nr->status & NVME_SC_DNR  ? "DNR "  : "");
>   }
>   
> +static void nvme_log_error_passthrough(struct request *req)
> +{
> +	struct nvme_ns *ns = req->q->queuedata;
> +	struct nvme_request *nr = nvme_req(req);
> +
> +	if (ns) {
> +		pr_err_ratelimited("%s: %s(0x%x), %s (sct 0x%x / sc 0x%x) %s%s"
> +			"cdw10=0x%x cdw11=0x%x cdw12=0x%x cdw13=0x%x cdw14=0x%x cdw15=0x%x\n",
> +			ns->disk ? ns->disk->disk_name : "?",
> +			nvme_get_opcode_str(nr->cmd->common.opcode),
> +			nr->cmd->common.opcode,
> +			nvme_get_error_status_str(nr->status),
> +			nr->status >> 8 & 7,	/* Status Code Type */
> +			nr->status & 0xff,	/* Status Code */
> +			nr->status & NVME_SC_MORE ? "MORE " : "",
> +			nr->status & NVME_SC_DNR  ? "DNR "  : "",
> +			nr->cmd->common.cdw10,
> +			nr->cmd->common.cdw11,
> +			nr->cmd->common.cdw12,
> +			nr->cmd->common.cdw13,
> +			nr->cmd->common.cdw14,
> +			nr->cmd->common.cdw14);
> +		return;
> +	}
> +
> +	pr_err_ratelimited("%s: %s(0x%x), %s (sct 0x%x / sc 0x%x) %s%s"
> +			"cdw10=0x%x cdw11=0x%x cdw12=0x%x cdw13=0x%x cdw14=0x%x cdw15=0x%x\n",
> +			dev_name(nr->ctrl->device),
> +			nvme_get_admin_opcode_str(nr->cmd->common.opcode),
> +			nr->cmd->common.opcode,
> +			nvme_get_error_status_str(nr->status),
> +			nr->status >> 8 & 7,	/* Status Code Type */
> +			nr->status & 0xff,	/* Status Code */
> +			nr->status & NVME_SC_MORE ? "MORE " : "",
> +			nr->status & NVME_SC_DNR  ? "DNR "  : "",
> +			nr->cmd->common.cdw10,
> +			nr->cmd->common.cdw11,
> +			nr->cmd->common.cdw12,
> +			nr->cmd->common.cdw13,
> +			nr->cmd->common.cdw14,
> +			nr->cmd->common.cdw14);
> +}
> +
>   enum nvme_disposition {
>   	COMPLETE,
>   	RETRY,
> @@ -381,8 +424,12 @@ static inline void nvme_end_req(struct request *req)
>   {
>   	blk_status_t status = nvme_error_status(nvme_req(req)->status);
>   
> -	if (unlikely(nvme_req(req)->status && !(req->rq_flags & RQF_QUIET)))
> -		nvme_log_error(req);
> +	if (unlikely(nvme_req(req)->status && !(req->rq_flags & RQF_QUIET))) {
> +		if (blk_rq_is_passthrough(req))
> +			nvme_log_error_passthrough(req);
> +		else
> +			nvme_log_error(req);
> +	}
>   	nvme_end_req_zoned(req);
>   	nvme_trace_bio_complete(req);
>   	if (req->cmd_flags & REQ_NVME_MPATH)
> @@ -666,6 +713,8 @@ static inline void nvme_clear_nvme_request(struct request *req)
>   /* initialize a passthrough request */
>   void nvme_init_request(struct request *req, struct nvme_command *cmd)
>   {
> +	struct nvme_request *nr = nvme_req(req);
> +
>   	if (req->q->queuedata)
>   		req->timeout = NVME_IO_TIMEOUT;
>   	else /* no queuedata implies admin queue */
> @@ -678,8 +727,10 @@ void nvme_init_request(struct request *req, struct nvme_command *cmd)
>   	if (req->mq_hctx->type == HCTX_TYPE_POLL)
>   		req->cmd_flags |= REQ_POLLED;
>   	nvme_clear_nvme_request(req);
> -	req->rq_flags |= RQF_QUIET;
> -	memcpy(nvme_req(req)->cmd, cmd, sizeof(*cmd));
> +	if (!nr->ctrl->error_logging)
> +		req->rq_flags |= RQF_QUIET;
> +
> +	memcpy(nr->cmd, cmd, sizeof(*cmd));

Question, if we already introduce granularity to this setting, why
not per-ns? why only per controller? I'd think it makes more
sense to do this per ns. Will also remove access to ctrl in the hot
path...

>   }
>   EXPORT_SYMBOL_GPL(nvme_init_request);
>   
> @@ -3418,6 +3469,38 @@ static ssize_t nvme_sysfs_rescan(struct device *dev,
>   }
>   static DEVICE_ATTR(rescan_controller, S_IWUSR, NULL, nvme_sysfs_rescan);
>   
> +static ssize_t nvme_passthrough_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +
> +	if (ctrl->error_logging)
> +		return sysfs_emit(buf, "on\n");
> +	else
> +		return sysfs_emit(buf, "off\n");
> +}
> +
> +static ssize_t nvme_passthrough_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +	int passthrough_enable, err;
> +
> +	err = kstrtoint(buf, 10, &passthrough_enable);
> +	if (err)
> +		return -EINVAL;
> +
> +	if (passthrough_enable)
> +		ctrl->error_logging = true;
> +	else
> +		ctrl->error_logging = false;
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR(passthrough_logging, S_IRUGO | S_IWUSR,
> +	nvme_passthrough_show, nvme_passthrough_store);
> +
>   static inline struct nvme_ns_head *dev_to_ns_head(struct device *dev)
>   {
>   	struct gendisk *disk = dev_to_disk(dev);
> @@ -3926,6 +4009,7 @@ static struct attribute *nvme_dev_attrs[] = {
>   	&dev_attr_dhchap_secret.attr,
>   	&dev_attr_dhchap_ctrl_secret.attr,
>   #endif
> +	&dev_attr_passthrough_logging.attr,
>   	NULL
>   };
>   
> @@ -5125,6 +5209,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>   	int ret;
>   
>   	ctrl->state = NVME_CTRL_NEW;
> +	ctrl->error_logging = false;
>   	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
>   	spin_lock_init(&ctrl->lock);
>   	mutex_init(&ctrl->scan_lock);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index bf46f122e9e1..dce5e6f7260c 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -248,6 +248,7 @@ struct nvme_ctrl {
>   	bool comp_seen;
>   	enum nvme_ctrl_state state;
>   	bool identified;
> +	bool error_logging;
>   	spinlock_t lock;
>   	struct mutex scan_lock;
>   	const struct nvme_ctrl_ops *ops;

