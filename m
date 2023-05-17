Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F07FC77B75
	for <linux-nvme@archiver.kernel.org>; Wed, 17 May 2023 07:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jV8TlHv1O5uR1/R7STgriPutUa3lqfsWCCmCBaSvfBs=; b=pmFqmNG4cejXIA2kNB4flB2hqB
	tU2wBeNlWpVfMbVLM6QJy2RaHi6JRd+HRbPrgDYX9Bl1Y7WRmYcyCqAE2zSMbBQy62gPu5/9mj1fP
	A2isglvlQthOgdyB3XzKdHW3J6N0QNdh4nifBjpMB0bK1Hwo47xm6wEN7SnOd6jiyKNY3TCLQwEV5
	m+16RccvCAguxrUYUqaluJ++lSqbdXTlDwHyhqr9vWMyR3t0nHmaoCdd9DJM+bZmAuwBEbXCyToc/
	NC91VdLiwVL/A11LIMKfU2Y1DJaC9qDearCVl8/VWVnVIjuCRrdRSou9SrohVNMYoFMO8ZE9Lw1LF
	Kfv/togg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzBL1-008csV-2n;
	Wed, 17 May 2023 07:12:43 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzBKy-008crP-2G
	for linux-nvme@lists.infradead.org;
	Wed, 17 May 2023 07:12:42 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3f50020e0f6so320165e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 17 May 2023 00:12:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684307559; x=1686899559;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jV8TlHv1O5uR1/R7STgriPutUa3lqfsWCCmCBaSvfBs=;
        b=MnceOiCvohW/seq/yMdtCJg1M44I61m5VUUGnm6WNJ+OG85y4V9NGLBPJVGI4ZD+WB
         WhydCAfV2r8rUjpXIlSBLHWBtkfwb7mhMg/1XLYkOPi5CYURe+cQ4HrMcNraD6wiM3K5
         yTnUhvxEB9arhVhEN/jRs96csxiI+vGsfTy30PkNs2OTPUefRNwl4bxcBJ8horzAgmSG
         h1CZjHV7A2tZfmLS8gJ5pltS0gCz0MrZl/mLqmSBplTx8QYePf8TZDsRILKr1fO8rHL1
         tdj3z+1ugyINc5BwqZZxXG1LaH8b73qmprx/sSB/QlWG2qoFsbdcD/TZZKKY+x05XJNT
         5yAw==
X-Gm-Message-State: AC+VfDyKPvC/V49exxuEE9gw9zJHSjorSvDuVjE2l+peRmNklBSmcQMD
	OcmBLk9S0yxYk0SD4dE++XU=
X-Google-Smtp-Source: ACHHUZ7qnJfommgbvXoL5ux19UppPk7Xn2xZe3U8V3TvHkPMGzPV3mZiH9nVwi+1hXMRLT1s3fqULQ==
X-Received: by 2002:a05:600c:468e:b0:3f5:c6f:d204 with SMTP id p14-20020a05600c468e00b003f50c6fd204mr1479899wmo.2.1684307558717;
        Wed, 17 May 2023 00:12:38 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id z21-20020a1c4c15000000b003f42d2f4531sm1144709wmf.48.2023.05.17.00.12.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 00:12:38 -0700 (PDT)
Message-ID: <0b182e1b-e267-81da-dbda-95ea04ade338@grimberg.me>
Date: Wed, 17 May 2023 10:12:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH] nvme-core: add helper to get nvme_ctrl from device
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, ch@lst.de
References: <20230512082206.4788-1-kch@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230512082206.4788-1-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230517_001240_735569_22E6109C 
X-CRM114-Status: GOOD (  23.55  )
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


> Just like we have other helpers to_nvmet_port(), to_nvmet_ns(),
> ana_groups_to_port() and to_nvmet_ns(), add a helper to get nvme_ctr
> from struct device.

I don't think this is very useful.

> Note that this removes the bunch of nvme_ctrl declaration code that is
> needed to get the nvme_ctrl from struct device in the host/core.c.
> Followwing is the diff :-

It doesn't make it easier on my eyes...

> 
> drivers/nvme/host/core.c | 69 +++++++++++++++-------------------------
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/host/core.c | 69 +++++++++++++++-------------------------
>   1 file changed, 26 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 518c759346f0..a957da110ee1 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -126,6 +126,11 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
>   static void nvme_update_keep_alive(struct nvme_ctrl *ctrl,
>   				   struct nvme_command *cmd);
>   
> +static struct nvme_ctrl *dev_to_nvme_ctrl(struct device *dev)
> +{
> +	return dev_get_drvdata(dev);
> +}
> +
>   void nvme_queue_scan(struct nvme_ctrl *ctrl)
>   {
>   	/*
> @@ -3386,10 +3391,9 @@ static ssize_t nvme_sysfs_reset(struct device *dev,
>   				struct device_attribute *attr, const char *buf,
>   				size_t count)
>   {
> -	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>   	int ret;
>   
> -	ret = nvme_reset_ctrl_sync(ctrl);
> +	ret = nvme_reset_ctrl_sync(dev_to_nvme_ctrl(dev));
>   	if (ret < 0)
>   		return ret;
>   	return count;
> @@ -3400,9 +3404,7 @@ static ssize_t nvme_sysfs_rescan(struct device *dev,
>   				struct device_attribute *attr, const char *buf,
>   				size_t count)
>   {
> -	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> -
> -	nvme_queue_scan(ctrl);
> +	nvme_queue_scan(dev_to_nvme_ctrl(dev));
>   	return count;
>   }
>   static DEVICE_ATTR(rescan_controller, S_IWUSR, NULL, nvme_sysfs_rescan);
> @@ -3557,8 +3559,7 @@ nvme_show_str_function(firmware_rev);
>   static ssize_t  field##_show(struct device *dev,				\
>   			    struct device_attribute *attr, char *buf)		\
>   {										\
> -        struct nvme_ctrl *ctrl = dev_get_drvdata(dev);				\
> -        return sysfs_emit(buf, "%d\n", ctrl->field);				\
> +        return sysfs_emit(buf, "%d\n", dev_to_nvme_ctrl(dev)->field);		\
>   }										\
>   static DEVICE_ATTR(field, S_IRUGO, field##_show, NULL);
>   
> @@ -3572,10 +3573,8 @@ static ssize_t nvme_sysfs_delete(struct device *dev,
>   				struct device_attribute *attr, const char *buf,
>   				size_t count)
>   {
> -	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> -
>   	if (device_remove_file_self(dev, attr))
> -		nvme_delete_ctrl_sync(ctrl);
> +		nvme_delete_ctrl_sync(dev_to_nvme_ctrl(dev));
>   	return count;
>   }
>   static DEVICE_ATTR(delete_controller, S_IWUSR, NULL, nvme_sysfs_delete);
> @@ -3584,9 +3583,7 @@ static ssize_t nvme_sysfs_show_transport(struct device *dev,
>   					 struct device_attribute *attr,
>   					 char *buf)
>   {
> -	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> -
> -	return sysfs_emit(buf, "%s\n", ctrl->ops->name);
> +	return sysfs_emit(buf, "%s\n", dev_to_nvme_ctrl(dev)->ops->name);
>   }
>   static DEVICE_ATTR(transport, S_IRUGO, nvme_sysfs_show_transport, NULL);
>   
> @@ -3618,9 +3615,7 @@ static ssize_t nvme_sysfs_show_subsysnqn(struct device *dev,
>   					 struct device_attribute *attr,
>   					 char *buf)
>   {
> -	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> -
> -	return sysfs_emit(buf, "%s\n", ctrl->subsys->subnqn);
> +	return sysfs_emit(buf, "%s\n", dev_to_nvme_ctrl(dev)->subsys->subnqn);
>   }
>   static DEVICE_ATTR(subsysnqn, S_IRUGO, nvme_sysfs_show_subsysnqn, NULL);
>   
> @@ -3628,9 +3623,7 @@ static ssize_t nvme_sysfs_show_hostnqn(struct device *dev,
>   					struct device_attribute *attr,
>   					char *buf)
>   {
> -	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> -
> -	return sysfs_emit(buf, "%s\n", ctrl->opts->host->nqn);
> +	return sysfs_emit(buf, "%s\n", dev_to_nvme_ctrl(dev)->opts->host->nqn);
>   }
>   static DEVICE_ATTR(hostnqn, S_IRUGO, nvme_sysfs_show_hostnqn, NULL);
>   
> @@ -3638,9 +3631,7 @@ static ssize_t nvme_sysfs_show_hostid(struct device *dev,
>   					struct device_attribute *attr,
>   					char *buf)
>   {
> -	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> -
> -	return sysfs_emit(buf, "%pU\n", &ctrl->opts->host->id);
> +	return sysfs_emit(buf, "%pU\n", &dev_to_nvme_ctrl(dev)->opts->host->id);
>   }
>   static DEVICE_ATTR(hostid, S_IRUGO, nvme_sysfs_show_hostid, NULL);
>   
> @@ -3657,10 +3648,9 @@ static DEVICE_ATTR(address, S_IRUGO, nvme_sysfs_show_address, NULL);
>   static ssize_t nvme_ctrl_loss_tmo_show(struct device *dev,
>   		struct device_attribute *attr, char *buf)
>   {
> -	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> -	struct nvmf_ctrl_options *opts = ctrl->opts;
> +	struct nvmf_ctrl_options *opts = dev_to_nvme_ctrl(dev)->opts;
>   
> -	if (ctrl->opts->max_reconnects == -1)
> +	if (dev_to_nvme_ctrl(dev)->opts->max_reconnects == -1)
>   		return sysfs_emit(buf, "off\n");
>   	return sysfs_emit(buf, "%d\n",
>   			  opts->max_reconnects * opts->reconnect_delay);
> @@ -3669,8 +3659,7 @@ static ssize_t nvme_ctrl_loss_tmo_show(struct device *dev,
>   static ssize_t nvme_ctrl_loss_tmo_store(struct device *dev,
>   		struct device_attribute *attr, const char *buf, size_t count)
>   {
> -	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> -	struct nvmf_ctrl_options *opts = ctrl->opts;
> +	struct nvmf_ctrl_options *opts = dev_to_nvme_ctrl(dev)->opts;
>   	int ctrl_loss_tmo, err;
>   
>   	err = kstrtoint(buf, 10, &ctrl_loss_tmo);
> @@ -3690,17 +3679,15 @@ static DEVICE_ATTR(ctrl_loss_tmo, S_IRUGO | S_IWUSR,
>   static ssize_t nvme_ctrl_reconnect_delay_show(struct device *dev,
>   		struct device_attribute *attr, char *buf)
>   {
> -	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> -
> -	if (ctrl->opts->reconnect_delay == -1)
> +	if (dev_to_nvme_ctrl(dev)->opts->reconnect_delay == -1)
>   		return sysfs_emit(buf, "off\n");
> -	return sysfs_emit(buf, "%d\n", ctrl->opts->reconnect_delay);
> +	return sysfs_emit(buf, "%d\n",
> +			  dev_to_nvme_ctrl(dev)->opts->reconnect_delay);
>   }
>   
>   static ssize_t nvme_ctrl_reconnect_delay_store(struct device *dev,
>   		struct device_attribute *attr, const char *buf, size_t count)
>   {
> -	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>   	unsigned int v;
>   	int err;
>   
> @@ -3708,7 +3695,7 @@ static ssize_t nvme_ctrl_reconnect_delay_store(struct device *dev,
>   	if (err)
>   		return err;
>   
> -	ctrl->opts->reconnect_delay = v;
> +	dev_to_nvme_ctrl(dev)->opts->reconnect_delay = v;
>   	return count;
>   }
>   static DEVICE_ATTR(reconnect_delay, S_IRUGO | S_IWUSR,
> @@ -3717,18 +3704,16 @@ static DEVICE_ATTR(reconnect_delay, S_IRUGO | S_IWUSR,
>   static ssize_t nvme_ctrl_fast_io_fail_tmo_show(struct device *dev,
>   		struct device_attribute *attr, char *buf)
>   {
> -	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> -
> -	if (ctrl->opts->fast_io_fail_tmo == -1)
> +	if (dev_to_nvme_ctrl(dev)->opts->fast_io_fail_tmo == -1)
>   		return sysfs_emit(buf, "off\n");
> -	return sysfs_emit(buf, "%d\n", ctrl->opts->fast_io_fail_tmo);
> +	return sysfs_emit(buf, "%d\n",
> +			  dev_to_nvme_ctrl(dev)->opts->fast_io_fail_tmo);
>   }
>   
>   static ssize_t nvme_ctrl_fast_io_fail_tmo_store(struct device *dev,
>   		struct device_attribute *attr, const char *buf, size_t count)
>   {
> -	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> -	struct nvmf_ctrl_options *opts = ctrl->opts;
> +	struct nvmf_ctrl_options *opts = dev_to_nvme_ctrl(dev)->opts;
>   	int fast_io_fail_tmo, err;
>   
>   	err = kstrtoint(buf, 10, &fast_io_fail_tmo);
> @@ -3782,8 +3767,7 @@ static DEVICE_ATTR_RO(dctype);
>   static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
>   		struct device_attribute *attr, char *buf)
>   {
> -	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> -	struct nvmf_ctrl_options *opts = ctrl->opts;
> +	struct nvmf_ctrl_options *opts = dev_to_nvme_ctrl(dev)->opts;
>   
>   	if (!opts->dhchap_secret)
>   		return sysfs_emit(buf, "none\n");
> @@ -3836,8 +3820,7 @@ static DEVICE_ATTR(dhchap_secret, S_IRUGO | S_IWUSR,
>   static ssize_t nvme_ctrl_dhchap_ctrl_secret_show(struct device *dev,
>   		struct device_attribute *attr, char *buf)
>   {
> -	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> -	struct nvmf_ctrl_options *opts = ctrl->opts;
> +	struct nvmf_ctrl_options *opts = dev_to_nvme_ctrl(dev)->opts;
>   
>   	if (!opts->dhchap_ctrl_secret)
>   		return sysfs_emit(buf, "none\n");

