Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AEBCC433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Oct 2022 09:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=57XCYk7+xY+9VqqR9bLwE5p2GUDtZRSOkfdt+GZEYok=; b=cx77aOSmtG7k3MUA3XlSUIe5B1
	psrnkMkJM3xzkWl4Z+/YOdRA/SXix1+N95EUXZUO4/KDyI+NgsGEBLTB9siyadk7LKsgVeYiujggC
	nanqH4fCMPfkaUDiQOzq0xwiBaGyG67SkoxOCiwGOj46JwfoZ+d/mdj2Y7zHssX3X91nqtlSl+sB2
	6ozN22rwCc2/9N34jkOgq+B4dYW4mp4t27HcD+3BOKDBORSWUqURxpAiAPPxwzFIkbJ23qscxpae8
	OyDxP/HYF/O5UEsoa/pqjqN8nZsd8X2WQ69bajTa0F02wLQppvgQ5geGU3EWGwbE1WG88wpwI38+p
	dUfMMiaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol5YW-00HQU0-67; Wed, 19 Oct 2022 09:40:08 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol5YP-00HQ2Z-SH
	for linux-nvme@lists.infradead.org; Wed, 19 Oct 2022 09:40:06 +0000
Received: by mail-wr1-f42.google.com with SMTP id a10so28093256wrm.12
        for <linux-nvme@lists.infradead.org>; Wed, 19 Oct 2022 02:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=57XCYk7+xY+9VqqR9bLwE5p2GUDtZRSOkfdt+GZEYok=;
        b=KuqS3gSyqX7Ciwz4gujJG3bb5eA033WVGG2VmpzlPWJEKi1xbKc11de2W275Ph4OeN
         sHTZy2f63pqbXboductywqiGLkQQuxar7Yxcp/TFR9BPHzephN96Fc10e3xFHkUSfnLw
         JQwFmw13VGWq5IOLKuLSMTOQBC45YcjQeOJ1RKkLXoqzeP2QAlPA6GGs0m1CDhPH3XJK
         3nrhkgjA02JXY3vM1TJcDqNQljVEEmhl0WBfvj8jqjlY4UTswKr2VA15hgjzFwGzpEsf
         B2+vy+NyoUGCFAgJ5TQKMaAw5tB09KthCKHHPTlq+OkySujLKe/1b2g3jrOmxbmM47AK
         GlBw==
X-Gm-Message-State: ACrzQf0YSCLHEpbkPmCV5lTHujx5VBExtBN/yAtgRS2lfIIw2Gdqe96l
	Haoi+752XC0M99r7fhtq58U=
X-Google-Smtp-Source: AMsMyM6gye3sPAXhOlBnkQtVCq5GOfrdu5ZWTBxBgODWF7fnzeCLsQWbCMyzkOtZ90y5q+4nRmWzgQ==
X-Received: by 2002:a05:6000:18a:b0:22e:c396:6c3d with SMTP id p10-20020a056000018a00b0022ec3966c3dmr4474831wrx.499.1666172350349;
        Wed, 19 Oct 2022 02:39:10 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id r16-20020a05600c35d000b003a84375d0d1sm23626104wmq.44.2022.10.19.02.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 02:39:09 -0700 (PDT)
Message-ID: <3ba99d83-e8ac-8aa1-4ae6-28a99f9417be@grimberg.me>
Date: Wed, 19 Oct 2022 12:39:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] nvme-hwmon: consistently ignore errors from
 nvme_hwmon_init
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org,
 fancer.lancer@gmail.com, linux@roeck-us.net
Cc: linux-nvme@lists.infradead.org
References: <20221019083744.993792-1-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221019083744.993792-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221019_024001_956427_DE736680 
X-CRM114-Status: GOOD (  23.81  )
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


> An NVMe controller works perfectly fine even when the hwmon
> initialization fails.  Stop returning errors that do not come from a
> controller reset from nvme_hwmon_init to handle this case consistently.

Maybe I'm missing something, but nvme_hwmon_init is not called
from the reset flow, only in the first init, I don't understand
how the commit msg follows the code.

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> 
> Changes since v1:
>   - switch to ignoring the errors in the caller.
> 
>   drivers/nvme/host/core.c  |  6 +++++-
>   drivers/nvme/host/hwmon.c | 13 ++++++++-----
>   2 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 9cbe7854d4883..dc42206005855 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3262,8 +3262,12 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
>   		return ret;
>   
>   	if (!ctrl->identified && !nvme_discovery_ctrl(ctrl)) {
> +		/*
> +		 * Do not return errors unless we are in a controller reset,
> +		 * the controller works perfectly fine without hwmon.
> +		 */
>   		ret = nvme_hwmon_init(ctrl);
> -		if (ret < 0)
> +		if (ret == -EINTR)
>   			return ret;
>   	}
>   
> diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
> index 0a586d7129201..23918bb7bdca2 100644
> --- a/drivers/nvme/host/hwmon.c
> +++ b/drivers/nvme/host/hwmon.c
> @@ -230,7 +230,7 @@ int nvme_hwmon_init(struct nvme_ctrl *ctrl)
>   
>   	data = kzalloc(sizeof(*data), GFP_KERNEL);
>   	if (!data)
> -		return 0;
> +		return -ENOMEM;
>   
>   	data->ctrl = ctrl;
>   	mutex_init(&data->read_lock);
> @@ -238,8 +238,7 @@ int nvme_hwmon_init(struct nvme_ctrl *ctrl)
>   	err = nvme_hwmon_get_smart_log(data);
>   	if (err) {
>   		dev_warn(dev, "Failed to read smart log (error %d)\n", err);
> -		kfree(data);
> -		return err;
> +		goto err_free_data;
>   	}
>   
>   	hwmon = hwmon_device_register_with_info(dev, "nvme",
> @@ -247,11 +246,15 @@ int nvme_hwmon_init(struct nvme_ctrl *ctrl)
>   						NULL);
>   	if (IS_ERR(hwmon)) {
>   		dev_warn(dev, "Failed to instantiate hwmon device\n");
> -		kfree(data);
> -		return PTR_ERR(hwmon);
> +		err = PTR_ERR(hwmon);
> +		goto err_free_data;
>   	}
>   	ctrl->hwmon_device = hwmon;
>   	return 0;
> +
> +err_free_data:
> +	kfree(data);
> +	return err;
>   }
>   
>   void nvme_hwmon_exit(struct nvme_ctrl *ctrl)

