Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F46C77B7C
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Apr 2023 23:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XQJuYlr//MXySqSo5VyQmrNmyMPLl7mjyx+IxfnN6ws=; b=LcYxM7cLqv7m+rtrKciy4NMgd4
	7JA23WXvO0DUIOVFJPqzOzRTSkir9q47LCvr2nm3j5hH9c02k5BaZw5wFD8+Y4tiOXkPNChwgkc1K
	d14WNgZ1hAWEZRnrYrLp/sVSf6l6TUB0FDE0aMc9NHtSagzS09ntkWFT9My9/WJ1hEtS+o06vwfpf
	oPL1ZPFMXDgHps80TbxrFcTjKZQcM9YjwzTAJmJLJ90AASRa7SoWJtbgbB+d53JoeY++2+wm19mXK
	6k0WWw7nmfLideoNM4hTbnt9ASYC6GahPe7OXfi54SzI97mDQYUbNsZa85/o78burRAcdC2HbegMl
	Nw5V4fpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1prSFb-002PUQ-1l;
	Tue, 25 Apr 2023 23:39:11 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1prSFY-002PTU-0f
	for linux-nvme@lists.infradead.org;
	Tue, 25 Apr 2023 23:39:09 +0000
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-63b50a02bffso5337820b3a.2
        for <linux-nvme@lists.infradead.org>; Tue, 25 Apr 2023 16:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682465945; x=1685057945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XQJuYlr//MXySqSo5VyQmrNmyMPLl7mjyx+IxfnN6ws=;
        b=MTU6bAJIytaqi+FaSnPpCHgD51Tqa69wv4E7BHaPTCcloetSoCCzaDL/Q1KWIonUKj
         wxqyKz4U/+AiUYaS2msAemA1C1FijdG+PJfEgWkjV9YckjOE9UV1DjEkcOmYHl0M58Fu
         DWWpGVJwjzOB+B+A+dZNsvNK+EhkagZgoZjuu9nnKkk9ifwJqjhBuE+OoEwupu5PdB8Z
         XXzN9GcvAdttx4uH6afsEWs7aGA5Q0oowQylOc9uvcDgj/8/gyQ0PMQQTtR2e7A17CCJ
         pYNCgHY0pKpHrfjqzXQb5cEEAHOIZiVi9vWNj3LM66OhZVfQWJZXQ4HHNbYV6IDKPBMo
         auUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682465945; x=1685057945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQJuYlr//MXySqSo5VyQmrNmyMPLl7mjyx+IxfnN6ws=;
        b=Vjaplhmd59Hj8zS69mAZ9Va11dmQp4EFbWFvP/gWj23cVfMMrdr8z1p6tiBbUvDOyr
         It+uWccwFVljBb/sRGLUUx+VcdJSDqPkGc17O+/J1GuPM6sfz3GlUWUCZCzTO7HVfABp
         26OkDB/UkpQS7Q5lM6OgYQrZCaoyY5RvHq9NAOnvni7px711Y4X992PGpmc8amsFxfjw
         ANhM1t3lpoI9EYmpoUqCyr7GU3hOWBhAZGJhGanS5GFG1abdvpjoIa3Zzf8oSyHxYZBJ
         iY56hnM3kWfkoChJNYUG9mbJFunk4kzb8tXprXvSP5/w0ZmlpaueNXnpaz8lZOmCVHXj
         ZzeQ==
X-Gm-Message-State: AAQBX9dZoHu7vzV4C2KOK6P7ApFJjxIbOStoEo9LH4fTLXR7502D/RlC
	lDjDB8ZkyWdVOX9a6rLCPZY=
X-Google-Smtp-Source: AKy350aoyOWr56aeX0QCzn0q3/gFBe6CsYPZGN6l0clMIZFUfkblgdEx8AOrHAijMgLVwu4J3Ye4gA==
X-Received: by 2002:a05:6a00:14cf:b0:63d:408a:e14 with SMTP id w15-20020a056a0014cf00b0063d408a0e14mr27518778pfu.4.1682465944839;
        Tue, 25 Apr 2023 16:39:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p2-20020a056a000a0200b00638c9a2ba5csm9867958pfh.62.2023.04.25.16.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 16:39:04 -0700 (PDT)
Date: Tue, 25 Apr 2023 16:39:02 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Hristo Venev <hristo@venev.name>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-pci: add quirk for missing secondary temperature
 thresholds
Message-ID: <5e8a5d87-3cc8-4141-bcea-34aff5a82149@roeck-us.net>
References: <20230425195853.322100-1-hristo@venev.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425195853.322100-1-hristo@venev.name>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230425_163908_247752_8B914ED2 
X-CRM114-Status: GOOD (  27.10  )
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

On Tue, Apr 25, 2023 at 10:58:54PM +0300, Hristo Venev wrote:
> On Kingston KC3000 and Kingston FURY Renegade (both have the same PCI
> IDs) accessing temp3_{min,max} fails with an invalid field error (note
> that there is no problem setting the thresholds for temp1).
> 
> This contradicts the NVM Express Base Specification 2.0b, page 292:
> 
>   The over temperature threshold and under temperature threshold
>   features shall be implemented for all implemented temperature sensors
>   (i.e., all Temperature Sensor fields that report a non-zero value).
> 
> Define NVME_QUIRK_NO_SECONDARY_TEMP_THRESH that disables the thresholds
> for all but the composite temperature and set it for this device.
> 

The description above says that temp3_{min,max} return errors.
How about temp2 ? This patch disables that as well, but it is not clear
if temp2_{min,max} return errors as well. If temp2 limits work, disabling
them would be overkill.

Thanks,
Guenter

> Signed-off-by: Hristo Venev <hristo@venev.name>
> ---
>  drivers/nvme/host/hwmon.c | 3 ++-
>  drivers/nvme/host/nvme.h  | 5 +++++
>  drivers/nvme/host/pci.c   | 2 ++
>  3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
> index 9e6e56c20ec9..7a2c4b5e018c 100644
> --- a/drivers/nvme/host/hwmon.c
> +++ b/drivers/nvme/host/hwmon.c
> @@ -163,7 +163,8 @@ static umode_t nvme_hwmon_is_visible(const void *_data,
>  	case hwmon_temp_max:
>  	case hwmon_temp_min:
>  		if ((!channel && data->ctrl->wctemp) ||
> -		    (channel && data->log->temp_sensor[channel - 1])) {
> +		    (channel && data->log->temp_sensor[channel - 1] &&
> +		     !(data->ctrl->quirks & NVME_QUIRK_NO_SECONDARY_TEMP_THRESH))) {
>  			if (data->ctrl->quirks &
>  			    NVME_QUIRK_NO_TEMP_THRESH_CHANGE)
>  				return 0444;
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index bf46f122e9e1..a2d4f59e0535 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -149,6 +149,11 @@ enum nvme_quirks {
>  	 * Reports garbage in the namespace identifiers (eui64, nguid, uuid).
>  	 */
>  	NVME_QUIRK_BOGUS_NID			= (1 << 18),
> +
> +	/*
> +	 * No temperature thresholds for channels other than 0 (Composite).
> +	 */
> +	NVME_QUIRK_NO_SECONDARY_TEMP_THRESH	= (1 << 19),
>  };
>  
>  /*
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index cd7873de3121..e457ad169dcb 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3416,6 +3416,8 @@ static const struct pci_device_id nvme_id_table[] = {
>  		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
>  	{ PCI_DEVICE(0x2646, 0x501E),   /* KINGSTON OM3PGP4xxxxQ OS21011 NVMe SSD */
>  		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
> +	{ PCI_DEVICE(0x2646, 0x5013),   /* Kingston KC3000, Kingston FURY Renegade */
> +		.driver_data = NVME_QUIRK_NO_SECONDARY_TEMP_THRESH, },
>  	{ PCI_DEVICE(0x1f40, 0x1202),   /* Netac Technologies Co. NV3000 NVMe SSD */
>  		.driver_data = NVME_QUIRK_BOGUS_NID, },
>  	{ PCI_DEVICE(0x1f40, 0x5236),   /* Netac Technologies Co. NV7000 NVMe SSD */
> -- 
> 2.40.0
> 

