Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B0B3C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Oct 2022 15:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5kL58Vzyx64L09PkTEMwOMN2dqRTnXGwQa87/rkLY9Y=; b=VUbZZO++vHob8gZVyH2A19bf2M
	vU6mrLP2TpUmhE63n1ah6bzBAZSdl3a/lRqtx5qyaxC4FmuxB+2G7Z4NJb7YKFtI2nFkEfHy0JPTB
	qAzH9cfaEQtH4OFeoza70pw1MK2yH4qhlzPSwEf9AFsbBnkek4ywbiPyd1yfaF4c7vrnXXPAqLhVg
	JW3CkaNtRAoXrdTZn4QV9+mmCp55AKCcJCkVcf10lXj67MjCOCFaXoHkX9q7W4eOCq9PTkTnHdUdf
	B2hHCfxjZ01LEY9oHTztF5vhqMrHkvZ2H2EJYPVfaNwpTRa2bRc4r+ji3l3DCnLosLpI6MMhy5sTP
	eHWHa2Dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okomw-007uB6-UU; Tue, 18 Oct 2022 15:45:55 +0000
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okolC-007sTd-VJ
	for linux-nvme@lists.infradead.org; Tue, 18 Oct 2022 15:44:08 +0000
Received: by mail-lf1-x134.google.com with SMTP id b2so23239109lfp.6
        for <linux-nvme@lists.infradead.org>; Tue, 18 Oct 2022 08:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5kL58Vzyx64L09PkTEMwOMN2dqRTnXGwQa87/rkLY9Y=;
        b=mJ6fuv4Z6hGquCKjPP3LHgIGCz3DLGVRstzxqg9/mV/PqI2cly8MSdRfp+wTVZZiHr
         /n9rQ2xl8k7HfRcTQzdGF0AHiilY6s58M7hYghYpHTjyydeq+fxtLo9LM5SDYeotIMEm
         pgax2oIynr4OhKBmRPvZAQSBDLJQgga/TjUbjlUOFrc0gN5ORWYAJopUvUcb5e/tQA9+
         4JpX/Pt+ncBC1dS1f+Q5LXxKB2EjpQLkjFgW0h/FoPG9zMuFg3ujvoMfN6DFWokF8eg1
         zaCBz2llgl/PdTPieXcVK9+QxdDw3O4ECwtFDQ4CHIeuWW7NNEYwNS15tJcSLx6VMTJb
         +U2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kL58Vzyx64L09PkTEMwOMN2dqRTnXGwQa87/rkLY9Y=;
        b=nyp7Tmaxx8zRWf33fBvQEP1AZzfpGLxbsCxyhLNz5exh34tkZMjz37dcnt7pMBes1H
         YRZ1g2gvNIUeivmjVgjsYHCD0tWSkQa8oyNaOBcrpGaDhkyerCVAIucZo1ms+Llt16UM
         QCWO2gLZ2CmEz82nHRWQVy5eG7cQlKq+5DFhbZxZISZGGe2qwpY/99m5jkT6RNHJXE1f
         6ciWQLXkjc12cAxVORldzIYojPVCHC+hn+PYW7ZBGIOH/H1ftXjwGivUJFLyDwUvnE1Q
         ddixIiMiyWBtk7YSHYLJiVObVwJdrldBJCa50rKszoBTsHzEfbAvfqhR5bYggIyu6mHg
         6L3Q==
X-Gm-Message-State: ACrzQf0A66D/ylsppsSaUfnvNTkAzZ1wmvKvyuHQ0oX+0li5dG2jIltF
	kEGe1c2CytnpuFQbJEvsIkA=
X-Google-Smtp-Source: AMsMyM7bDjuSG6OtECnj15aYU+3ERkUJ3m/8jSmrRzWuPFqhRTbJ5wU/nkqMR52RewDJK8qFlN3a3w==
X-Received: by 2002:a05:6512:159e:b0:4a2:46f6:eea0 with SMTP id bp30-20020a056512159e00b004a246f6eea0mr1312250lfb.451.1666107844832;
        Tue, 18 Oct 2022 08:44:04 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id p6-20020ac246c6000000b0049e9122bd0esm1903472lfo.114.2022.10.18.08.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 08:44:04 -0700 (PDT)
Date: Tue, 18 Oct 2022 18:44:02 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, sagi@grimberg.me, linux@roeck-us.net,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-hwmon: don't return errors from nvme_hwmon_init
Message-ID: <20221018154402.pl53szsvnzowa5r7@mobilestation>
References: <20221018145808.681327-1-hch@lst.de>
 <Y07C/FdD3mpKgBjN@kbusch-mbp.dhcp.thefacebook.com>
 <20221018152309.GB22639@lst.de>
 <Y07FoBKCrJibFOY5@kbusch-mbp.dhcp.thefacebook.com>
 <20221018153136.yjsnmhppwstbcwac@mobilestation>
 <20221018153841.GA24029@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018153841.GA24029@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221018_084407_044798_32456A68 
X-CRM114-Status: GOOD (  23.88  )
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

On Tue, Oct 18, 2022 at 05:38:41PM +0200, Christoph Hellwig wrote:
> On Tue, Oct 18, 2022 at 06:31:36PM +0300, Serge Semin wrote:
> > What about just taking the -EINTR error into account by the
> > nvme_hwmon_init() caller and ignore any other there? Meanwhile you can
> > convert the nvme_hwmon_init() method to return any error including the
> > ENOMEM. Thus the function will be more consistent and will have
> > independent from the caller context design.
> 

> Yeah, that actually looks a tad cleaner than what I just sent out:

> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 9cbe7854d4883..7c949f44e1db2 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3261,9 +3261,13 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
>  	if (ret < 0)
>  		return ret;
>  
> +	/*
> +	 * Do not return errors unless we are in a controller reset.
> +	 * The controller works perfectly fine without the hwmon registration.
> +	 */
>  	if (!ctrl->identified && !nvme_discovery_ctrl(ctrl)) {
>  		ret = nvme_hwmon_init(ctrl);

> -		if (ret < 0)
> +		if (err == -EINTR)
>  			return ret;

Note: s/err/ret

Exactly what I meant. Looks good to me.

-Sergey

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

