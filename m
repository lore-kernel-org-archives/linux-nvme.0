Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A53EC47258
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jan 2024 14:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rtg9NHThOVVKFbkqCd+swczcUCgKnli5n3XPtlecY00=; b=BupD3BJiK3NbZztOle2qeADdmo
	GFCmOSUfM9PDrcAaybMhOrd0qTwMZy6Wgc1gmo+kT+lYV8qFrM4jaUdq26+AF7LYD4u/BeVkGCrEP
	qSqQ3LeuJZ+AGmhCH+kroF35C5SulgVQDxLeLYfcERRuafehbBngpiWJcG0eO9xng7P3SAEt4rzGu
	xxKk+orrijTUFhs/Fz1HJkiJc1ArWsQIVmi22UeGSO3juApY8UE4LdwWa/KbI24mUnFLFPzBNNB8Y
	bUZwxjkSBMW+7MoATzEFkAYMA4RYWxqbJeEfOaTPoYJJTuWOcvVjacMty7Gjx07NVArFvOnbHPKHA
	iHgSFfUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ6gK-00GxOV-0E;
	Wed, 17 Jan 2024 14:14:16 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ6gE-00GxIH-0D
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jan 2024 14:14:12 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40e412c1c58so12948235e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jan 2024 06:14:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705500846; x=1706105646;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rtg9NHThOVVKFbkqCd+swczcUCgKnli5n3XPtlecY00=;
        b=udQON+pSyZt9pgCeczL9M2Yl/k15BN+y+2rh7VbuDp4AwutLMP0/evKlo+0ReClh+D
         0mzMWrXDKKxpIjHCUXDgBj1bsQvDtjZLy54CHQpgs+AyAVBNTfZie44pfwKG8KPzYkW4
         KzdZuF7LLsRJHiBdjdHPYUvVKsD0uZjfQFhGmOgxtDFXG5Takg9qTjqHi9zLX1qgAx3l
         WykT0M/o6Huo1yfxeSL7RT4sySFQyul7Nuy9o16jfPEB03YtGlZscU/H/t6kWgF5asPo
         vfbw0PANgY1cPjOwolvr6zUUTc3Mo1B4ee7fOkkLnHu1jWgqk7R07/nyQhX4i+vj8iCO
         T7gQ==
X-Gm-Message-State: AOJu0YyjlpKp8uJ2kw/HocCHrsZfmJeMcm67O7G8oDUFbISGIBrXlo3u
	PIhJVJrBIHe26TA+sfusUwE=
X-Google-Smtp-Source: AGHT+IGjunZaMhbrgORe+lPTjb5IxRImrQpQHuwiWROBxF2mKKqgZXY12/9Q9VCFYjwXzzO4imOQRg==
X-Received: by 2002:a05:600c:3c99:b0:40e:4023:4da0 with SMTP id bg25-20020a05600c3c9900b0040e40234da0mr10754952wmb.2.1705500845998;
        Wed, 17 Jan 2024 06:14:05 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id w4-20020a05600c474400b0040d5ae2906esm26688627wmo.30.2024.01.17.06.14.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 06:14:05 -0800 (PST)
Message-ID: <07b397bb-574e-4f7b-b754-085b348e1510@grimberg.me>
Date: Wed, 17 Jan 2024 16:14:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 1/1] nvme: allow passthru cmd error logging
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Christoph Hellwig
 <hch@lst.de>, Alan Adamson <alan.adamson@oracle.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20240111000855.1800481-1-alan.adamson@oracle.com>
 <20240111000855.1800481-2-alan.adamson@oracle.com>
 <20240111070441.GA7889@lst.de>
 <c44ad0e2-8f08-4b46-8be2-29b69a8d88b6@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <c44ad0e2-8f08-4b46-8be2-29b69a8d88b6@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_061410_108306_1B906B43 
X-CRM114-Status: GOOD (  28.81  )
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



On 1/17/24 05:46, Chaitanya Kulkarni wrote:
> Hi all,
> 
> On 1/10/24 23:04, Christoph Hellwig wrote:
>> On Wed, Jan 10, 2024 at 04:08:55PM -0800, Alan Adamson wrote:
>>> +int nvme_sysfs_add_passthru_err_log(struct device *dev)
>>> +{
>>> +	return sysfs_create_group(&dev->kobj, &nvme_log_attr_group);
>>> +}
>>> +
>>> +void nvme_sysfs_remove_passthru_err_log(struct device *dev)
>>> +{
>>> +	sysfs_remove_group(&dev->kobj, &nvme_log_attr_group);
>>> +}
>> Isn't the normal sysfs convention to have an is_visible method
>> instead of dynamically adding/removing groups?
>>
>> Otherwise this looks good to me.
>>
> 
> This patch adds a new member to struct device: logging_enabled.
> There are no other users for that member as of now so I think
> we should avoid that.

We definitely should.

> 
> How about following on the top of this patch that adds
> logging_enabled to struct nvme_ctrl and struct nvme_ns so we can
> remove struct device:logging_enabled ?
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 8971af7fcb2b..925d36ce8931 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -127,6 +127,11 @@ static void nvme_remove_invalid_namespaces(struct
> nvme_ctrl *ctrl,
>    static void nvme_update_keep_alive(struct nvme_ctrl *ctrl,
>                                      struct nvme_command *cmd);
> 
> +bool is_nvme_class(const struct class *class)
> +{
> +       return nvme_class == class;
> +}
> +
>    void nvme_queue_scan(struct nvme_ctrl *ctrl)
>    {
>           /*
> @@ -708,17 +713,19 @@ static inline void nvme_clear_nvme_request(struct
> request *req)
>    void nvme_init_request(struct request *req, struct nvme_command *cmd)
>    {
>           struct nvme_request *nr = nvme_req(req);
> -       struct device *device;
> +       bool logging_enabled;
> 
>           if (req->q->queuedata) {
> +               struct nvme_ns *ns = req->q->disk->private_data;
> +
> +               logging_enabled = ns->logging_enabled;
>                   req->timeout = NVME_IO_TIMEOUT;
> -               device = disk_to_dev(req->q->disk);
>           } else { /* no queuedata implies admin queue */
>                   req->timeout = NVME_ADMIN_TIMEOUT;
> -               device = nr->ctrl->device;
> +               logging_enabled = nr->ctrl->logging_enabled;
>           }
> 
> -       if (!device->logging_enabled)
> +       if (!logging_enabled)
>                   req->rq_flags |= RQF_QUIET;
> 
>           /* passthru commands should let the driver set the SGL flags */
> @@ -3718,6 +3725,13 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl,
> struct nvme_ns_info *info)
> 
>           nvme_mpath_add_disk(ns, info->anagrpid);
>           nvme_fault_inject_init(&ns->fault_inject, ns->disk->disk_name);
> +
> +       /*
> +        * Set ns->disk->device->driver_data to ns so we can access
> +        * ns->logging_enabled in nvme_passthru_err_log_enabled_store() and
> +        * nvme_passthru_err_log_enabled_show().
> +        */
> +       dev_set_drvdata(disk_to_dev(ns->disk), ns);

Is this needed?

>           nvme_sysfs_add_passthru_err_log(disk_to_dev(ns->disk));
> 
>           return;
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index df0e90d3e4b5..33f9d636a576 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -20,6 +20,8 @@
> 
>    #include <trace/events/block.h>
> 
> +extern bool is_nvme_class(const struct class *class);
> +
>    extern const struct pr_ops nvme_pr_ops;
> 
>    extern unsigned int nvme_io_timeout;
> @@ -385,6 +387,7 @@ struct nvme_ctrl {
> 
>           enum nvme_ctrl_type cntrltype;
>           enum nvme_dctype dctype;
> +       bool logging_enabled;
>    };
> 
>    enum nvme_iopolicy {
> @@ -511,7 +514,7 @@ struct nvme_ns {
>           struct device           cdev_device;
> 
>           struct nvme_fault_inject fault_inject;
> -
> +       bool logging_enabled;
>    };
> 
>    /* NVMe ns supports metadata actions by the controller (generate/strip) */
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index 8215abaa68e5..db6d4a3d7c4a 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -38,20 +38,36 @@ static DEVICE_ATTR(rescan_controller, S_IWUSR, NULL,
> nvme_sysfs_rescan);
>    static ssize_t nvme_passthru_err_log_enabled_show(struct device *dev,
>                   struct device_attribute *attr, char *buf)
>    {
> -       return sysfs_emit(buf, dev->logging_enabled ? "on" : "off");
> +       if (is_nvme_class(dev->class)) {
> +               struct nvme_ctrl *c = dev_get_drvdata(dev);
> +
> +               return sysfs_emit(buf, c->logging_enabled ? "on\n" :
> "off\n");
> +       } else {
> +               struct nvme_ns *n = dev_get_drvdata(dev);
> +
> +               return sysfs_emit(buf, n->logging_enabled ? "on\n" :
> "off\n");
> +       }
>    }
> 
>    static ssize_t nvme_passthru_err_log_enabled_store(struct device *dev,
>                   struct device_attribute *attr, const char *buf, size_t
> count)
>    {
> -       int err;
>           bool passthru_err_log_enabled;
> +       int err;
> 
>           err = kstrtobool(buf, &passthru_err_log_enabled);
>           if (err)
>                   return -EINVAL;
> 
> -       dev->logging_enabled = passthru_err_log_enabled;
> +       if (is_nvme_class(dev->class)) {
> +               struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +
> +               ctrl->logging_enabled = passthru_err_log_enabled;
> +       } else {
> +               struct nvme_ns *ns = dev_get_drvdata(dev);
> +
> +               ns->logging_enabled = passthru_err_log_enabled;
> +       }

Why mix ctrl with ns sysfs handlers?

> 
>           return count;
>    }
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 3fedff698349..d7a72a8749ea 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -805,7 +805,6 @@ struct device {
>    #ifdef CONFIG_DMA_OPS_BYPASS
>           bool                    dma_ops_bypass : 1;
>    #endif
> -       bool                    logging_enabled:1;
>    };
> 
>    /**
> 
> 
> -ck
> 
> 

