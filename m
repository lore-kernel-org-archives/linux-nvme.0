Return-Path: <SRS0=ulAu=GW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5862CC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jan 2021 06:29:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C531B23120
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jan 2021 06:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C531B23120
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SQyMYZrK/qhr0l7BJ7+CvQwJg6RWRZfp5+5YnLvJ3bM=; b=ylt20t40OIEaYZouDWjXqcLPP
	eSdEsjt6D7+Ii2OEJ+B/FZy9RmuTTy93m0+gn30nJtjPHgUvkfjDjY8WSlW1PBEa5Pqi5Qcw7gle3
	DBA4+j+9GbFJBFyraBrmGwAza3mKh1KM50WuMM90gLKDLYaCv6DWB4k4WEQpxUo44NN5dy4z1mld8
	VQ1QBEoEKZrhZKZHLLM2s8oVnCSSptsanpBBX2dpUMzYn8aLIbguUBvUYsz8whIyIcEG7e90wpyuj
	kttSQrvEbEOqo1WJdlyyBXBSelY4OPjCffaIvhwlYPfe5W44HVYXJhRrWrwD5BIrIXZX5KD2KKcLr
	6DZYQROmQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l1kVS-0005OE-9j; Tue, 19 Jan 2021 06:28:46 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l1kVP-0005No-9N
 for linux-nvme@lists.infradead.org; Tue, 19 Jan 2021 06:28:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B1BBB6736F; Tue, 19 Jan 2021 07:28:41 +0100 (CET)
Date: Tue, 19 Jan 2021 07:28:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme/hwmon: rework to avoid devm allocation
Message-ID: <20210119062841.GB21413@lst.de>
References: <20210119062242.123824-1-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210119062242.123824-1-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210119_012843_716204_82DB70EF 
X-CRM114-Status: GOOD (  24.42  )
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
Cc: Keith Busch <keith.busch@wdc.com>, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Guenter Roeck <linux@roeck-us.net>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

As requested last time: please include the author of the code in the
discussion.

On Tue, Jan 19, 2021 at 07:22:42AM +0100, Hannes Reinecke wrote:
> The original design to use device-managed resource allocation
> doesn't really work as the NVMe controller has a vastly different
> lifetime than the hwmon sysfs attributes, causing warning about
> duplicate sysfs entries upon reconnection.
> This patch reworks the hwmon allocation to avoid device-managed
> resource allocation, and uses the NVMe controller as parent for
> the sysfs attributes.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Tested-by: Daniel Wagner <dwagner@suse.de>
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
---end quoted text---

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
