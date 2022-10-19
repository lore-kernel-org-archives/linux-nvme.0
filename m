Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B984C43217
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Oct 2022 09:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MTm8Rkzxmk/9b6k41XKM5ki4OeZ5YmJw8T2/sIpABEU=; b=DFGYknWD13sG5aMWAkuCLFRSZM
	aVWQc9j4fgUDnyUQmHufzvAUEfOTwjJlJl3Ro5CmgXjfF+F40rRlzmjiwn7cR7WZMYhoKBZVZNXch
	O/XSrGBaN6fYIilOUpfgYYZtNKGObIDJGq6oTDIoe4E3nfXabzfHIjiEHMTZqElOaG6jcWgm00r3R
	49A27YyITthDLkRz24rV6rifezKZltY1Dd/dfwPvZkJA0CGZGUdmFQiqIkkr4qg3BlHFGlkAeLcg3
	5Q+QBSbdbWEu+XUDUCGsYFF40lhhkP8wAAOGWPblcLtJBT3bgz+xL+IOxdb8MP9fFKrmEdhcybnkG
	+LsT4UoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol50A-00H8Mf-OP; Wed, 19 Oct 2022 09:04:38 +0000
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol508-00H8I9-Tu
	for linux-nvme@lists.infradead.org; Wed, 19 Oct 2022 09:04:38 +0000
Received: by mail-lf1-x135.google.com with SMTP id p8so819304lfu.11
        for <linux-nvme@lists.infradead.org>; Wed, 19 Oct 2022 02:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MTm8Rkzxmk/9b6k41XKM5ki4OeZ5YmJw8T2/sIpABEU=;
        b=KMheqgu7ZplhV0NlMRC3fp4LOLST81zipo/BinXCFR/+aVxbHNOyYfbQlEydf3zKM+
         AbG98zUw2AjjV2stb4JwVRr+QSN6I7VH2TlqS8M7QE0xIXF97wLyqIE1h9uEfUh/lgLg
         XMTBsBtarmyA+8xP0hrd9eV/SEh/Nm9oIlrto3djDDUfpDmSZHCspTw/y730kXMldJYF
         ukPff6Dz+MR5EQCRcPvuz0aQMD4C+JNfUm60V7MOWywIkdd3IoHCJXyG2azSod5S3h4f
         gAYoSsU4vNMcSSgmZtXcyI0yQmjDXPsfWkZUoEBY6VS2rXPTLt6IJ0YyUk5GPsKaVRZn
         9ltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MTm8Rkzxmk/9b6k41XKM5ki4OeZ5YmJw8T2/sIpABEU=;
        b=DKhohQQbKV1WPDplExRTWe7nGx1wonIp+/7c1dExU3WtH6jDl6IFl5DgG1H3gjkIJW
         jLgj/q+Q5rMCMnu+UJ19ehUvQkId0UeteOO6Y1p/te/GAC0ZWUziDfpjGGer7rND5jnc
         ZDWXbb35vSahGRG6pTXmKeJn3Q+b6cSNAcD6/4owKjVl7G8T3OzbDMqJyokv3eFTfty5
         dAalK2/Q5WrUfh7CPMAQY0xHea72+atf7+29eOCp0iem+E3PriL4cS4Y8k6cCPOnc2P2
         edNfwYxd2fbPctZrgt19tvPOdm3CWZN2AZ7274ML4Apv9mNNNnb4oNI96zjzb5NS4YIm
         9qqw==
X-Gm-Message-State: ACrzQf29IHQlxv5n6sJBISscULvdLNvual/d0RREbsN1jH7IgRShWbAI
	BFvPUVoO7+18COTb2+5zXEs=
X-Google-Smtp-Source: AMsMyM6qvqj3h/EsINfj/iBKh9DFfn2UVh+xVxrw8Pq7FaV/7+wNRVx78RHCplGjHsOCaXbk83OKWA==
X-Received: by 2002:a05:6512:3b0b:b0:4a2:5bd5:6d95 with SMTP id f11-20020a0565123b0b00b004a25bd56d95mr2337359lfv.364.1666170273138;
        Wed, 19 Oct 2022 02:04:33 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id du13-20020a056512298d00b0048b143c09c2sm2184178lfb.259.2022.10.19.02.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 02:04:32 -0700 (PDT)
Date: Wed, 19 Oct 2022 12:04:30 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, linux@roeck-us.net,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme-hwmon: consistently ignore errors from
 nvme_hwmon_init
Message-ID: <20221019090430.hermibuln2reo5av@mobilestation>
References: <20221019083744.993792-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019083744.993792-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221019_020437_011200_FA6D83F8 
X-CRM114-Status: GOOD (  23.20  )
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

On Wed, Oct 19, 2022 at 10:37:44AM +0200, Christoph Hellwig wrote:
> An NVMe controller works perfectly fine even when the hwmon
> initialization fails.  Stop returning errors that do not come from a
> controller reset from nvme_hwmon_init to handle this case consistently.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> 
> Changes since v1:
>  - switch to ignoring the errors in the caller.

Great! Thanks.
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Sergey

> 
>  drivers/nvme/host/core.c  |  6 +++++-
>  drivers/nvme/host/hwmon.c | 13 ++++++++-----
>  2 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 9cbe7854d4883..dc42206005855 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3262,8 +3262,12 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
>  		return ret;
>  
>  	if (!ctrl->identified && !nvme_discovery_ctrl(ctrl)) {
> +		/*
> +		 * Do not return errors unless we are in a controller reset,
> +		 * the controller works perfectly fine without hwmon.
> +		 */
>  		ret = nvme_hwmon_init(ctrl);
> -		if (ret < 0)
> +		if (ret == -EINTR)
>  			return ret;
>  	}
>  
> diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
> index 0a586d7129201..23918bb7bdca2 100644
> --- a/drivers/nvme/host/hwmon.c
> +++ b/drivers/nvme/host/hwmon.c
> @@ -230,7 +230,7 @@ int nvme_hwmon_init(struct nvme_ctrl *ctrl)
>  
>  	data = kzalloc(sizeof(*data), GFP_KERNEL);
>  	if (!data)
> -		return 0;
> +		return -ENOMEM;
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
> @@ -247,11 +246,15 @@ int nvme_hwmon_init(struct nvme_ctrl *ctrl)
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
> +	return err;
>  }
>  
>  void nvme_hwmon_exit(struct nvme_ctrl *ctrl)
> -- 
> 2.30.2
> 

