Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D164BCD37B2
	for <linux-nvme@archiver.kernel.org>; Sun, 10 May 2026 22:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TC0/JxzOsYZtN5fUJQmRvVLSE404nYts9TY2x9W2Sm0=; b=16HlnUJg/sLzW8H+l1xKcyrkhp
	NYkXFLU+MQOx37QfmFCpnme52KBnkehXFl7/1JSfvplOt1r2F+DGfK0yzCZmyQeestWlLqzgLQPJy
	hJZiwYldeGLaFLIsV7MIkiH+GGe6eIYnNtlvIb9TrrIXgsuNyQJ96IYi7957DY0bE9LjpGj9o6OBh
	cAQ+V/zpcBn2J2NgshCXewcGQLADz+4cAvpH+0F3Vf/rRXOGqH65bJgDuEt7AjaFjrfW7VhQFWR99
	zAU1MZrfScEaOeBDQwrYeUPvKrwritYnC1QLJox6xbC9oKICYeneEb1VL/GGO4VahFNTags4ARhXI
	+QayQYAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMCVK-0000000BkIz-03CT;
	Sun, 10 May 2026 22:20:06 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMCVH-0000000BkIb-1N8D
	for linux-nvme@lists.infradead.org;
	Sun, 10 May 2026 22:20:04 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488d2079582so39498215e9.2
        for <linux-nvme@lists.infradead.org>; Sun, 10 May 2026 15:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778451601; x=1779056401;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TC0/JxzOsYZtN5fUJQmRvVLSE404nYts9TY2x9W2Sm0=;
        b=gxgrapAjOAuz8wYh7/YgJB594VKVZtfmG8Pb7EkBR2Qrh907lcsZe9cJifHXCDRoEL
         1oqGJAVj8ArYIFtQvUf7zfCFO+AFMTg0sEIRysBiKfXc9R08HAfcZbwtLbVt/L4WR04B
         OhG5XIMGLj3I4EdEYi0Ch6zx9zB4rcvnX3gnIVpOyXyHfe3GRf1qSF4vXE9/0zLdHju2
         huR0HGxY7H3FKdFoDmLKluRiyadrfbRxzEouJ/vPK18x+PmUK2Qu2LCoxwVzse2Tl59x
         X7taXoIu7azfl31FliWDiYS6ij39PG6mmJw1eff7fFa9UUMArjfv7HCh26AyBXgFb+N5
         aDig==
X-Forwarded-Encrypted: i=1; AFNElJ/H8DV2epTczgbLww8Whe73roVvFdQKNzFD/6LBEwn55oKEnylhWhPtHUDEe/vTiZsDGMxEhGQ7iCoX@lists.infradead.org
X-Gm-Message-State: AOJu0YzqIz3xkBmIoPN2KgwtSqsi9ikQTCvlTrPNDV9K5xNOwBru5urX
	FqxWZ6S+XSUStLvswGTePdoK7A9Rq+ng2n6j4NHFt7Ijic8YDqC986cG
X-Gm-Gg: Acq92OFEm2ejx9iCc41BfaSCBcIKku262qr1Uc5xREyWc9ba1yE5k3MeNMFy5teqMHv
	eI2yi+i/DOebviOhO9bCFAtl4DeAp2XhBY/vjhNtPn+SBH2TH9aG2bPEsTJnSv4YtCC3bfRCWs2
	D6qSL8H7i5wrD4l4u7zpFMYAWbN4KmTLv5G4+LtSkol9CAWvSSfT7dNLfSxU8Xf1h87pYhMs9oW
	qqJrGqKC5D0EZAEpfJyDoDHlMSz6R/2SP36jR/knwH9rWlnXAkRsoquRPHOUwoUgQI7U2+JrdwY
	OYND7baJZKVxlh6Cs8ttDaVe/U5pCUGwlHsidthWPgLglg/al+LH4wiILFF9gJ1+0Ruv5O8oBxO
	IYKI4R8HogrWdotXmVvLCRi9ESwxhk6D61/hoVrWaakT1qJs8VHEhD5nKc5aSJqXvjqzCSbvWzX
	AP9/xmVpeR3zsXw/04xAOJv1ZL0rX9Jw==
X-Received: by 2002:a05:600c:470a:b0:488:a639:b772 with SMTP id 5b1f17b1804b1-48e51e15485mr335757235e9.7.1778451601320;
        Sun, 10 May 2026 15:20:01 -0700 (PDT)
Received: from [10.100.102.74] ([89.138.75.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e702e042dsm147593875e9.5.2026.05.10.15.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2026 15:20:00 -0700 (PDT)
Message-ID: <73735bc1-9821-42d8-9594-1e9cdb03e15a@grimberg.me>
Date: Mon, 11 May 2026 01:19:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: make providing NGUID as UUID usage less scary
To: AlanCui4080 <me@alancui.cc>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>
Cc: linux-kernel@vger.kernel.org
References: <UPNVP7_KTI2VieaAyBtUMA@alancui.cc>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <UPNVP7_KTI2VieaAyBtUMA@alancui.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260510_152003_389845_95B50CB3 
X-CRM114-Status: GOOD (  19.43  )
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



On 07/05/2026 19:36, AlanCui4080 wrote:
> Hi,
>
>> From: Keith Busch <kbusch@kernel.org>
>>
>> The warning is a bit alarming, and it only prints for the very first
>> non-sgl capable device that receives a passthrough command. Just log an
>> informational message on initial discovery for every device.
> Since we decide to show this warning at device initial discovery stage,
> here are some similar warnings that I think are essentially the same.
>
> grep -C3 -rn "dev_warn_once" ./drivers/nvme/*
> ```
> ./drivers/nvme/host/sysfs.c-147-         * we have no UUID set
> ./drivers/nvme/host/sysfs.c-148-         */
> ./drivers/nvme/host/sysfs.c-149-        if (uuid_is_null(&ids->uuid)) {
> ./drivers/nvme/host/sysfs.c:150:                dev_warn_once(dev,
> ./drivers/nvme/host/sysfs.c-151-                        "No UUID available providing old NGUID\n");
> ./drivers/nvme/host/sysfs.c-152-                return sysfs_emit(buf, "%pU\n", ids->nguid);
> ./drivers/nvme/host/sysfs.c-153-        }
> ```
>
> This warning will only complain for the first partition of the first device also.
> And for NVMe devices, according to the NVM-Express-1_4 specification p.175 Figure 251:
> "Bit 9 (UUID List): ...", UUID is not mandatory i guess. So let's degrade it into a
> informational message on initial discovery for every device.
>
> Signed-off-by: Alan Cui <me@alancui.cc>
> ---
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 3fdcd73b9546..c432d8bc7b62 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4296,6 +4296,10 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info *info)
>                  goto out;
>          }
>   
> +       if (uuid_is_null(&info->ids.uuid)) {
> +               dev_info(ns->ctrl->device, "No UUID available, uuid_show providing old NGUID\n");
> +       }
> +
>          ret = nvme_update_ns_info(ns, info);
>   out:
>          /*
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index 29430949ce2f..839a36c22ebf 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -147,8 +147,6 @@ static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
>           * we have no UUID set
>           */
>          if (uuid_is_null(&ids->uuid)) {
> -               dev_warn_once(dev,
> -                       "No UUID available providing old NGUID\n");
>                  return sysfs_emit(buf, "%pU\n", ids->nguid);
>          }
>          return sysfs_emit(buf, "%pU\n", &ids->uuid);

TBH, I'm not sure why should this be a warning or an info log. This 
looks like a debug print to me.

Keith WDYT?

