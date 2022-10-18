Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DFFC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Oct 2022 15:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FtYoEyXdJFHPrVMO5Et+HGkUESN7UsKs38mpB8m9hQE=; b=H9NztzRdPRXAS1XMTD5Ftra+Sc
	Pv+QaVKJEJlNVtLyWuVVXibTV/SZZufEAcceHTQWWOzkVaed7cacbbqRlj9dQ/ov7vPOFrGndT4yd
	zgkbqjyfS4rqv2BbOpp+0AY3p+NeRRCKt8LbSW5A1FvXH7C3s67Vw+ffsla9+lxbsz4C4SR8niV21
	ZaqzXY5cfhHEcF6CiBedNRHtnVoN3meneVlNUnr81rpC7dGbc+x/NOzkJllcfZnUPZ0JVjeQSHI4X
	4OCDe/dG7WLYXPbNgRko/Rajes6iOT7VQxgkUhrdwq7O8hjs4NaemDa31RS85FAAXsMfh3hijgTkI
	9AUhAVWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okoJM-007TfF-3g; Tue, 18 Oct 2022 15:15:20 +0000
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okoIU-007TCH-04
	for linux-nvme@lists.infradead.org; Tue, 18 Oct 2022 15:14:29 +0000
Received: by mail-lf1-x130.google.com with SMTP id s20so23035378lfi.11
        for <linux-nvme@lists.infradead.org>; Tue, 18 Oct 2022 08:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FtYoEyXdJFHPrVMO5Et+HGkUESN7UsKs38mpB8m9hQE=;
        b=obBd/Tzn52NNFDfgw3x3Tugh1FSj6IYD1aRdxkqnG1XBMOhdd/Y5nuUFgoLlw7D2Kl
         unZDeINiZfiFVS+Z7Iv72SEeyUyYcdXu8dQbyMii9hSgeV5RaqKu8voydu7exSTHnNhb
         EW5JHhh7aPq7RlzL/gWrcGQK8fK6wsIqQfFQTzBl86qoJcGn6n07ZdvCSyTg3O6+AGrM
         zKBac3gdOO6adQ2Cd7d96hKE0QwbnPWrrmojj1d89jEyswvr9nhqtemaXeKB+KeB7DdP
         r2aVqstE72X6VtBdGos81WyEDhHiCESlbYfRV3Sk/pb5p1/PPmR2H/Wtf9/cC7F7EPT/
         SZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FtYoEyXdJFHPrVMO5Et+HGkUESN7UsKs38mpB8m9hQE=;
        b=6cf56vf8CGFWxa6GvG72hFE1fnB/XIEMro7YUuvepC06yWbK/BgW4WguGHEd0W/hXw
         MmbL5I3IDMu3zWBPSNZPMsoT/aQfpc0V6NRoLtL0Z0V8Iz2IeZjXwgWNmRjQDMks2mRo
         +TEfVy8pgJMHe8hxXPa16wLmROtmlCn9WMMCA+p2g3Ms0PzjPN0IUdxaD7tnRN9RQ5OY
         j9NuYzYHuqqmDPp/ruQoLnhVAqzmKxwJOQ4b+PwIX/7g/P9tLTu/odiRF6V7eP2hNCth
         6S+hhEbxbZ1ImliUUqp4G7Qm8L157hb7L3k1YtWGv3okW0ltnDez/8ShwV16xjPSSpPJ
         +x1w==
X-Gm-Message-State: ACrzQf3oGma3Y/Z4DWo9tReILVJbmltPtAOaMyA45J2KQaH2+yWhtZyW
	htbz1ExkLPTTa0azfLq81EI=
X-Google-Smtp-Source: AMsMyM6y+/ors3VgBvhYEzLisDWOTy70luYmR4ZK/n1zSMOMSL650mYsxGQLex9Ob/xCaPEr5uhDKw==
X-Received: by 2002:a05:6512:32ae:b0:4a2:c69c:998f with SMTP id q14-20020a05651232ae00b004a2c69c998fmr1257650lfe.599.1666106064149;
        Tue, 18 Oct 2022 08:14:24 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id f19-20020a056512361300b0049fff3f645esm1896376lfs.70.2022.10.18.08.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 08:14:23 -0700 (PDT)
Date: Tue, 18 Oct 2022 18:14:21 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, linux@roeck-us.net,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-hwmon: don't return errors from nvme_hwmon_init
Message-ID: <20221018151421.jeqe2bi6nyj3afzi@mobilestation>
References: <20221018145808.681327-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018145808.681327-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221018_081426_062300_96CE7F1D 
X-CRM114-Status: GOOD (  26.58  )
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

On Tue, Oct 18, 2022 at 04:58:08PM +0200, Christoph Hellwig wrote:
> An NVMe controller works perfectly fine even when the hwmon
> initialization fails.  Stop returning errors from nvme_hwmon_init to
> handle this case consistently.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I was going to resubmit the series taking into account your resolution
on this issue since patch #3 still needs to be resent. But you just
submitted a fixup patch. Less worries to me. I'll resend patch #3
separately then. Thanks.

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Sergey

> ---
> 
> This should go before the patch from Serge to document and consistently
> handle the lack of initialization failure handling for hwmon.
> 
>  drivers/nvme/host/core.c  |  7 ++-----
>  drivers/nvme/host/hwmon.c | 16 +++++++++-------
>  drivers/nvme/host/nvme.h  |  5 ++---
>  3 files changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 9cbe7854d4883..952768966bdcd 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3261,11 +3261,8 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
>  	if (ret < 0)
>  		return ret;
>  
> -	if (!ctrl->identified && !nvme_discovery_ctrl(ctrl)) {
> -		ret = nvme_hwmon_init(ctrl);
> -		if (ret < 0)
> -			return ret;
> -	}
> +	if (!ctrl->identified && !nvme_discovery_ctrl(ctrl))
> +		nvme_hwmon_init(ctrl);
>  
>  	ctrl->identified = true;
>  
> diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
> index 0a586d7129201..c6ddb8b46c699 100644
> --- a/drivers/nvme/host/hwmon.c
> +++ b/drivers/nvme/host/hwmon.c
> @@ -221,7 +221,8 @@ static const struct hwmon_chip_info nvme_hwmon_chip_info = {
>  	.info	= nvme_hwmon_info,
>  };
>  
> -int nvme_hwmon_init(struct nvme_ctrl *ctrl)
> +/* do not return errors - nvme works fine without hwmon registration */
> +void nvme_hwmon_init(struct nvme_ctrl *ctrl)
>  {
>  	struct device *dev = ctrl->device;
>  	struct nvme_hwmon_data *data;
> @@ -230,7 +231,7 @@ int nvme_hwmon_init(struct nvme_ctrl *ctrl)
>  
>  	data = kzalloc(sizeof(*data), GFP_KERNEL);
>  	if (!data)
> -		return 0;
> +		return;
>  
>  	data->ctrl = ctrl;
>  	mutex_init(&data->read_lock);
> @@ -238,8 +239,7 @@ int nvme_hwmon_init(struct nvme_ctrl *ctrl)
>  	err = nvme_hwmon_get_smart_log(data);
>  	if (err) {
>  		dev_warn(dev, "Failed to read smart log (error %d)\n", err);
> -		kfree(data);
> -		return err;
> +		goto out_free_data;
>  	}
>  
>  	hwmon = hwmon_device_register_with_info(dev, "nvme",
> @@ -247,11 +247,13 @@ int nvme_hwmon_init(struct nvme_ctrl *ctrl)
>  						NULL);
>  	if (IS_ERR(hwmon)) {
>  		dev_warn(dev, "Failed to instantiate hwmon device\n");
> -		kfree(data);
> -		return PTR_ERR(hwmon);
> +		goto out_free_data;
>  	}
>  	ctrl->hwmon_device = hwmon;
> -	return 0;
> +	return;
> +
> +out_free_data:
> +	kfree(data);
>  }
>  
>  void nvme_hwmon_exit(struct nvme_ctrl *ctrl)
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index a29877217ee65..4cd3e00c47a2b 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -1000,12 +1000,11 @@ static inline struct nvme_ns *nvme_get_ns_from_dev(struct device *dev)
>  }
>  
>  #ifdef CONFIG_NVME_HWMON
> -int nvme_hwmon_init(struct nvme_ctrl *ctrl);
> +void nvme_hwmon_init(struct nvme_ctrl *ctrl);
>  void nvme_hwmon_exit(struct nvme_ctrl *ctrl);
>  #else
> -static inline int nvme_hwmon_init(struct nvme_ctrl *ctrl)
> +static inline void nvme_hwmon_init(struct nvme_ctrl *ctrl)
>  {
> -	return 0;
>  }
>  
>  static inline void nvme_hwmon_exit(struct nvme_ctrl *ctrl)
> -- 
> 2.30.2
> 

