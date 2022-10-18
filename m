Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5663C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Oct 2022 15:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VkIjEzsWT+bR7Nrypgai+xHwbEeEdfla1jyud8gLyhk=; b=mU2GhW7YRT9J/yqEj5WI2kwfEg
	2Mh5f8BksN6jovqFecg2QuHP3/KS08Qo0hh02yIQDuJAiZmKkH0e61+9k2TuPeaJRMWGAFz9cI6eM
	+SHzI7xaxM3o7KITuCY15DO06wCI4x4q0FGG9KdFsIqT48oAEwYGjLoN6HqhHv2AKDYGnft3CcMqb
	Z+C+HTMDamuEr62abOyDlHGS0sv+AN6ji/a+vmPsf0r7DHrxNetgMLLT3eJco+ynHjaPR74NcaDak
	3iOd/D4nTuttCA7TzZViMs5I7ZAn9mxgSyu3iZQ2WlJJYSbBsfgJeO1ZbY2Gsl85BLUSuw8NxuEWG
	Caln3XyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okoVW-007dJt-Vi; Tue, 18 Oct 2022 15:27:55 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okoU8-007c3t-GU
	for linux-nvme@lists.infradead.org; Tue, 18 Oct 2022 15:26:29 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id A9216615B9;
	Tue, 18 Oct 2022 15:26:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2CBC433D6;
	Tue, 18 Oct 2022 15:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666106787;
	bh=v/BCb9LB4GPwQvz5TLbqUEcqCrCQPqu5bIQT1JgH5D8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FMvGFzcofyAjBHWA/lcsX+bonxlow1XYJ0OuKhRUVa0tkvct2qTTpVcZ5wzmSElYK
	 9J0WrBsw+wsBZQ/Bxp0zQsuYkvi4nb0oDu9HDsGrudOvuAjd8G8grm12hsseLIsEKI
	 rwXnr1CHqA7W1EDj1jEYylTMiZ9022qO1jHq+YaaLQTxll76Xbs9jtF+ljbMkfOmK5
	 je3LXUKryjsl7T5HJCPbPbxU+L/bdM98z4kFkMkob9oyXXC3QCShiM39zeqvpW4Dl5
	 2sg1HvyJcpALbQRwDnFiHmQxLW0WkxwrTDYPiVDY2AP46AyuROzqEn3Pc9Q1Dtsrmd
	 6Za/WFA6PytpQ==
Date: Tue, 18 Oct 2022 09:26:24 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, fancer.lancer@gmail.com, linux@roeck-us.net,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-hwmon: don't return errors from nvme_hwmon_init
Message-ID: <Y07FoBKCrJibFOY5@kbusch-mbp.dhcp.thefacebook.com>
References: <20221018145808.681327-1-hch@lst.de>
 <Y07C/FdD3mpKgBjN@kbusch-mbp.dhcp.thefacebook.com>
 <20221018152309.GB22639@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018152309.GB22639@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221018_082628_641156_5528882E 
X-CRM114-Status: GOOD (  24.50  )
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

On Tue, Oct 18, 2022 at 05:23:09PM +0200, Christoph Hellwig wrote:
> On Tue, Oct 18, 2022 at 09:15:08AM -0600, Keith Busch wrote:
> > We still need to check for < 0 since nvme_hwmon_init() sends an admin
> > command. If the admin command times out, the controller is reset and
> > -EINTR is returned, indicating we have to abort initialization. All
> > other errors should be ignored, though, since the controller remains
> > usable.
> 
> So I guess we should just ignore everything but EINTR, e.g.:

Yep, this looks fine. You'll just need to initialize 'int err = 0;' at
the beginning.

 
> diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
> index 0a586d7129201..aed245678315f 100644
> --- a/drivers/nvme/host/hwmon.c
> +++ b/drivers/nvme/host/hwmon.c
> @@ -230,7 +230,7 @@ int nvme_hwmon_init(struct nvme_ctrl *ctrl)
>  
>  	data = kzalloc(sizeof(*data), GFP_KERNEL);
>  	if (!data)
> -		return 0;
> +		goto err;
>  
>  	data->ctrl = ctrl;
>  	mutex_init(&data->read_lock);
> @@ -238,8 +238,7 @@ int nvme_hwmon_init(struct nvme_ctrl *ctrl)
>  	err = nvme_hwmon_get_smart_log(data);
>  	if (err) {
>  		dev_warn(dev, "Failed to read smart log (error %d)\n", err);
> -		kfree(data);
> -		return err;
> +		goto err_free_data;
>  	}
>  
>  	hwmon = hwmon_device_register_with_info(dev, "nvme",
> @@ -247,11 +246,22 @@ int nvme_hwmon_init(struct nvme_ctrl *ctrl)
>  						NULL);
>  	if (IS_ERR(hwmon)) {
>  		dev_warn(dev, "Failed to instantiate hwmon device\n");
> -		kfree(data);
> -		return PTR_ERR(hwmon);
> +		err = PTR_ERR(hwmon);
> +		goto err_free_data;
>  	}
>  	ctrl->hwmon_device = hwmon;
>  	return 0;
> +
> +err_free_data:
> +	kfree(data);
> +err:
> +	/*
> +	 * Do not return errors unless we are in a controller reset.
> +	 * The controller works perfectly fine without the hwmon registration.
> +	 */
> +	if (err == -EINTR)
> +		return -EINTR;
> +	return 0;
>  }
>  
>  void nvme_hwmon_exit(struct nvme_ctrl *ctrl)
> -- 
> 2.30.2
> 

