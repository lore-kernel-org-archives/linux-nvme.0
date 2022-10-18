Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE752C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Oct 2022 15:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e0GRGzZQV4vYoZpdrv2OYDTN9KFqReHC/dniORka27A=; b=wvE3cNzaqhqX8AAD6WqAYuS0Wc
	qYLtS+EK1BKbkz1InKeIvipRzNRTduxHrBX4jBWReShq+O4C5zUaM2lpFd6Who3un/HOd/3flSddi
	TzLe6QPZ0NuXCbJAt1/NBXeApSv4AIGCz0+x+nDIzJdoVs0LxpiqiVwlzGE12qUkCBYPUvhIcWoMg
	duGiAKPHKPt/PcT7/+UjdSaU3Ohk4NZyPqr6GliAwj1ReYFFMSk5+Ecjw7t2UggCYmp9C2zHxQ9QL
	SN0eSF5xs5UC8GabcVovk5T3v6ulDD/SUz3i4JE1cJ2J8QCtMGQ6rHMiKrXAlt7RhwGWZhqBM3ckh
	hKGbxiFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okobh-007jeT-BZ; Tue, 18 Oct 2022 15:34:17 +0000
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okoZC-007gvr-MQ
	for linux-nvme@lists.infradead.org; Tue, 18 Oct 2022 15:31:44 +0000
Received: by mail-lf1-x12b.google.com with SMTP id bp15so23154959lfb.13
        for <linux-nvme@lists.infradead.org>; Tue, 18 Oct 2022 08:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e0GRGzZQV4vYoZpdrv2OYDTN9KFqReHC/dniORka27A=;
        b=lDmnQZrDTn7kySqXZP40aHxGG48CI8vKlIJmLpTdq1/JfJC5hvbPZd0nd5npVCMF+A
         jLnAjIUCTGseM9pRboft0fDcHTK5jBBXQbW9SNwssXtmQ4Szd/B5vFKQAyTlStxdmgwe
         LXyXVmjIsPaEEWDPdgXOEtqgnZaKkPf7jHVbPz4xl4kYXOf3bXXABt8Mv50g7Ww6OSKt
         7vPWMeBDfoKsMt1sTYdJTwMqi2ZldlTgR7tNKG+IDdsiXLRsdAM4wbExTizlO2LM8N9K
         FWSP5d5PwNDgXsTYjlCI2Cq41bBHvCVxuM8ss89ga2IY8eEdi9szBrXHoUrtm7+a5mhe
         BPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0GRGzZQV4vYoZpdrv2OYDTN9KFqReHC/dniORka27A=;
        b=RZZIByttugXlaMkQ0AAlBiy57Qi1uDADLPdxfx1ysauVglarYX+glq9s7NR1BbuYuc
         qz/2UZAIc51hR68Z+vTdT2W9FpJiebPC2kfuKhF2kciN6gAc8LiFGFX5EvIoA6d0ZMpS
         eZfAkMleZEwTRe6jUeYnQ4/u4EoJIthmW9VNCoCR+SOckunGnyNGFIk+2LIczJMwPaxO
         OuZlIWAM5aHG4WUlG9SOSC79MbCZBV9HFFIcV/hf0AL4R0zFTJXLK9N+XPf/9TpnYk4Y
         IqHEnVJ3Lfph8usoDFXKMD0kHq8QaCIZXv8mujhIVbwH6Y/+fK9DdIkV8by0NgHYkx29
         O6Qg==
X-Gm-Message-State: ACrzQf3FYL8ILN1tZbi+4R4dEmFyueHnBA061eBvsL6aSL6vhur/Bjdp
	N/7IjH5KxGQ0zCW2OIewrv7oxYG40G4GZQ==
X-Google-Smtp-Source: AMsMyM7BBgH0CVNOQjt5GrdTF5yli4Ppb31baQ+h1/t0idoj2bt9bkvObqIK/QPQ3gCKGsmaSICuFQ==
X-Received: by 2002:ac2:5195:0:b0:4a2:bd54:90cf with SMTP id u21-20020ac25195000000b004a2bd5490cfmr1238715lfi.486.1666107098742;
        Tue, 18 Oct 2022 08:31:38 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id h24-20020ac24d38000000b0048b08e25979sm1883955lfk.199.2022.10.18.08.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 08:31:38 -0700 (PDT)
Date: Tue, 18 Oct 2022 18:31:36 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, linux@roeck-us.net, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-hwmon: don't return errors from nvme_hwmon_init
Message-ID: <20221018153136.yjsnmhppwstbcwac@mobilestation>
References: <20221018145808.681327-1-hch@lst.de>
 <Y07C/FdD3mpKgBjN@kbusch-mbp.dhcp.thefacebook.com>
 <20221018152309.GB22639@lst.de>
 <Y07FoBKCrJibFOY5@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y07FoBKCrJibFOY5@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221018_083142_796562_1BFC1E88 
X-CRM114-Status: GOOD (  26.30  )
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

On Tue, Oct 18, 2022 at 09:26:24AM -0600, Keith Busch wrote:
> On Tue, Oct 18, 2022 at 05:23:09PM +0200, Christoph Hellwig wrote:
> > On Tue, Oct 18, 2022 at 09:15:08AM -0600, Keith Busch wrote:
> > > We still need to check for < 0 since nvme_hwmon_init() sends an admin
> > > command. If the admin command times out, the controller is reset and
> > > -EINTR is returned, indicating we have to abort initialization. All
> > > other errors should be ignored, though, since the controller remains
> > > usable.
> > 
> > So I guess we should just ignore everything but EINTR, e.g.:
> 
> Yep, this looks fine. You'll just need to initialize 'int err = 0;' at
> the beginning.
> 
>  
> > diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
> > index 0a586d7129201..aed245678315f 100644
> > --- a/drivers/nvme/host/hwmon.c
> > +++ b/drivers/nvme/host/hwmon.c
> > @@ -230,7 +230,7 @@ int nvme_hwmon_init(struct nvme_ctrl *ctrl)
> >  
> >  	data = kzalloc(sizeof(*data), GFP_KERNEL);
> >  	if (!data)
> > -		return 0;
> > +		goto err;
> >  
> >  	data->ctrl = ctrl;
> >  	mutex_init(&data->read_lock);
> > @@ -238,8 +238,7 @@ int nvme_hwmon_init(struct nvme_ctrl *ctrl)
> >  	err = nvme_hwmon_get_smart_log(data);
> >  	if (err) {
> >  		dev_warn(dev, "Failed to read smart log (error %d)\n", err);
> > -		kfree(data);
> > -		return err;
> > +		goto err_free_data;
> >  	}
> >  
> >  	hwmon = hwmon_device_register_with_info(dev, "nvme",
> > @@ -247,11 +246,22 @@ int nvme_hwmon_init(struct nvme_ctrl *ctrl)
> >  						NULL);
> >  	if (IS_ERR(hwmon)) {
> >  		dev_warn(dev, "Failed to instantiate hwmon device\n");
> > -		kfree(data);
> > -		return PTR_ERR(hwmon);
> > +		err = PTR_ERR(hwmon);
> > +		goto err_free_data;
> >  	}
> >  	ctrl->hwmon_device = hwmon;
> >  	return 0;
> > +
> > +err_free_data:
> > +	kfree(data);
> > +err:
> > +	/*
> > +	 * Do not return errors unless we are in a controller reset.
> > +	 * The controller works perfectly fine without the hwmon registration.
> > +	 */

> > +	if (err == -EINTR)
> > +		return -EINTR;

What about just taking the -EINTR error into account by the
nvme_hwmon_init() caller and ignore any other there? Meanwhile you can
convert the nvme_hwmon_init() method to return any error including the
ENOMEM. Thus the function will be more consistent and will have
independent from the caller context design.

-Sergey

> > +	return 0;
> >  }
> >  
> >  void nvme_hwmon_exit(struct nvme_ctrl *ctrl)
> > -- 
> > 2.30.2
> > 

