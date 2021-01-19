Return-Path: <SRS0=ulAu=GW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAF9C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jan 2021 14:56:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 542FF22241
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jan 2021 14:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 542FF22241
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xFf/pfPCS6HpXXg5Ep6Mzhnrca1wcrbkEyfOocOr064=; b=x1rJiy4HLWDwEayrPHTfmg4rC
	rBzkBu79BmAtYFDiDxcPd4lxDWoXvR+ti81ghb30vBljqW8LCpfNdlqnwEy0uhtbuWNhN+534ig4Y
	tZ4QNRZOxvfZJhggrGC/42c4yKiCdTsUnBM7kBmsbi5o4pyzx32lnJ+RnLm3fL2y5xHA/srbrje+d
	zhbksTlFkdK8CSJmxLn6ZshioMjNDQmhdz6isv1wwFB019WAEFAw4YBybYrCw+Jm5S+xDq38FtFSG
	TGISDr2+qr+fC7XZ0Gx/a61fAh9ObTXdUr9n0VRmebMoyFoVIYwptmZ+aHiq6jnZjWiw/V4CzLbtW
	93IuqT37g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l1sQz-0007Ay-T4; Tue, 19 Jan 2021 14:56:41 +0000
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l1sQw-0007A9-H3
 for linux-nvme@lists.infradead.org; Tue, 19 Jan 2021 14:56:39 +0000
Received: by mail-ot1-x32b.google.com with SMTP id e70so4583519ote.11
 for <linux-nvme@lists.infradead.org>; Tue, 19 Jan 2021 06:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=4i3Rll4bQzwaYc7jqahBOCWHr4xjlROp3I2HYYJ4CnM=;
 b=KGBiR5eN0piVSzud74WxxtNthFcVS7akLF4V0P083UrZTFpupb2KjH8e9ZWXkRU/ny
 ElJ8Z0UVUYLW8zx9KQF4PHlBaO793+x8ae8pLR6O2fUar3atq+tjhzZwJpJoQzLtsZka
 nZZqd47UzidWTE3UVOChTLe5icHs48R0RBMMKk79PHJqpPDAs871bSAhSi5+l+jjh1Sq
 7JUuyhswjF+KvP1KZMwsBlnS3R5ao7J2ZujTPHpwlOgaovpJm8TmiBY0L9uEkrDVqj/k
 sKSjt4TakNGiJGM1W4/2GJG+vYaForZz8DeWPPnrj1RrMN6le8vXTI889Usn5sDnktLm
 wlWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=4i3Rll4bQzwaYc7jqahBOCWHr4xjlROp3I2HYYJ4CnM=;
 b=USHqs25gBxVqI+NTBtA/pcUWCn05Hqc0MalNcY1+mRvknQ/9whvBqXEtsmueO1nZwP
 FtzxJM/EgOfVtQcqnVSYr8a7lIIEHxcIwfUrzQsWD6K0zV+rg42yLxUfjTzzGMKYyGx6
 KM9duAnQkkwYZuyfOLnPMiMOZ4Og+jn5qRb2TT3J+BFwJ7e+VTHud04h+Eztm7dQ63Yy
 /Gyrc3LjamIo9ovSd0HLNmJhsBkrMRlxTVnuDEKhNwchDUQs+ety8IsGhC2FexuMDgF9
 1C8qqrRLI4VEgJOjpxCM71Sozqiw25uivGDqjYd9Nqw2tCeMHegfHz2EWbDb7xl4skFV
 +DyQ==
X-Gm-Message-State: AOAM530kZtlJFotm3ie7h/jjprOh3QMCwimbhn1pc+Y/OhgiSBL/iWo0
 U4L3iSG9Pm8w2j01GtjINCQ=
X-Google-Smtp-Source: ABdhPJy0SvL5wkyy011ZOu36ILkATNIWQgi3GyDPOPsoWsa33SdDvbpi7STrCns7PFqsZZtp51VttA==
X-Received: by 2002:a05:6830:572:: with SMTP id
 f18mr3771274otc.109.1611068194818; 
 Tue, 19 Jan 2021 06:56:34 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id v17sm4241573oou.41.2021.01.19.06.56.33
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 19 Jan 2021 06:56:34 -0800 (PST)
Date: Tue, 19 Jan 2021 06:56:32 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv2] nvme/hwmon: rework to avoid devm allocation
Message-ID: <20210119145632.GD54031@roeck-us.net>
References: <20210119064318.124415-1-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210119064318.124415-1-hare@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210119_095638_579097_32A65F38 
X-CRM114-Status: GOOD (  27.11  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jan 19, 2021 at 07:43:18AM +0100, Hannes Reinecke wrote:
> The original design to use device-managed resource allocation
> doesn't really work as the NVMe controller has a vastly different
> lifetime than the hwmon sysfs attributes, causing warning about
> duplicate sysfs entries upon reconnection.
> This patch reworks the hwmon allocation to avoid device-managed
> resource allocation, and uses the NVMe controller as parent for
> the sysfs attributes.

I don't really know enough about the nvme infrastructure to understand
this part of the change. Couple of questions: Why is the parent change
needed, and does the "sensors" command still work after this change ?

Guenter

> 
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Tested-by: Daniel Wagner <dwagner@suse.de>

Maybe add

Fixes: 400b6a7b13a3f ("nvme: Add hardware monitoring support")

> ---
>  drivers/nvme/host/core.c  |  1 +
>  drivers/nvme/host/hwmon.c | 31 +++++++++++++++++++++----------
>  drivers/nvme/host/nvme.h  |  6 ++++++
>  3 files changed, 28 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index fff49e544fdf..3c6c77e44bf7 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4419,6 +4419,7 @@ EXPORT_SYMBOL_GPL(nvme_start_ctrl);
>  
>  void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
>  {
> +	nvme_hwmon_exit(ctrl);
>  	nvme_fault_inject_fini(&ctrl->fault_inject);
>  	dev_pm_qos_hide_latency_tolerance(ctrl->device);
>  	cdev_device_del(&ctrl->cdev, ctrl->device);
> diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
> index 552dbc04567b..8f9e96986780 100644
> --- a/drivers/nvme/host/hwmon.c
> +++ b/drivers/nvme/host/hwmon.c
> @@ -223,12 +223,12 @@ static const struct hwmon_chip_info nvme_hwmon_chip_info = {
>  
>  int nvme_hwmon_init(struct nvme_ctrl *ctrl)
>  {
> -	struct device *dev = ctrl->dev;
> +	struct device *dev = ctrl->device;
>  	struct nvme_hwmon_data *data;
>  	struct device *hwmon;
>  	int err;
>  
> -	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
>  	if (!data)
>  		return 0;
>  
> @@ -237,19 +237,30 @@ int nvme_hwmon_init(struct nvme_ctrl *ctrl)
>  
>  	err = nvme_hwmon_get_smart_log(data);
>  	if (err) {
> -		dev_warn(ctrl->device,
> -			"Failed to read smart log (error %d)\n", err);
> -		devm_kfree(dev, data);
> +		dev_warn(dev, "Failed to read smart log (error %d)\n", err);
> +		kfree(data);
>  		return err;
>  	}
>  
> -	hwmon = devm_hwmon_device_register_with_info(dev, "nvme", data,
> -						     &nvme_hwmon_chip_info,
> -						     NULL);
> +	hwmon = hwmon_device_register_with_info(dev, "nvme",
> +						data, &nvme_hwmon_chip_info,
> +						NULL);
>  	if (IS_ERR(hwmon)) {
>  		dev_warn(dev, "Failed to instantiate hwmon device\n");
> -		devm_kfree(dev, data);
> +		kfree(data);
>  	}
> -
> +	ctrl->hwmon_device = hwmon;
>  	return 0;
>  }
> +
> +void nvme_hwmon_exit(struct nvme_ctrl *ctrl)
> +{
> +	if (ctrl->hwmon_device) {
> +		struct nvme_hwmon_data *data =
> +			dev_get_drvdata(ctrl->hwmon_device);
> +
> +		hwmon_device_unregister(ctrl->hwmon_device);
> +		ctrl->hwmon_device = NULL;
> +		kfree(data);
> +	}
> +}
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 88a6b97247f5..f51b942bb4f5 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -246,6 +246,9 @@ struct nvme_ctrl {
>  	struct rw_semaphore namespaces_rwsem;
>  	struct device ctrl_device;
>  	struct device *device;	/* char device */
> +#ifdef CONFIG_NVME_HWMON
> +	struct device *hwmon_device;
> +#endif
>  	struct cdev cdev;
>  	struct work_struct reset_work;
>  	struct work_struct delete_work;
> @@ -809,11 +812,14 @@ static inline struct nvme_ns *nvme_get_ns_from_dev(struct device *dev)
>  
>  #ifdef CONFIG_NVME_HWMON
>  int nvme_hwmon_init(struct nvme_ctrl *ctrl);
> +void nvme_hwmon_exit(struct nvme_ctrl *ctrl);
>  #else
>  static inline int nvme_hwmon_init(struct nvme_ctrl *ctrl)
>  {
>  	return 0;
>  }
> +
> +static inline int nvme_hwmon_exit(struct nvme_ctrl *ctrl) {}
>  #endif
>  
>  u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
> -- 
> 2.29.2
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
