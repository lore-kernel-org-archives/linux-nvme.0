Return-Path: <SRS0=270x=ZG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFAFC432C3
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2019 19:14:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8794C20718
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2019 19:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TBJHpCod";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnibOcAE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8794C20718
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0aV69oBjxM6xDQI2Ng6q5ZF+jKH0gfZGOXwQ8fo6VYs=; b=TBJHpCod6lcqSg
	IEeVNcFti7FuIkW1ffzA98hxE4ATj8jaSW1lZXEcACBgxZOd9L/rz+ETIZf/yTQkDyS8FcDMUCT55
	zSB7djR3oSao6wIM3F9YWBgJzpE4iBHUbTE20VvgnhxJPoK7lI8BTeki12JOLZvaYzRJVNp59dqBS
	qvlTf84HMN9PHJDUUJw+TFBo/9LtVyGHj3FdNz2GH0qZKopqsnK2XUrRiE1LGHa1nblKkC2iBkcbT
	ik0LudnivIuF81G4lzrOklyliS6LXqr2t+ocQILVcC+CRL3XhGIuGhXgT0sgMXlBmSCnhKsAViWP6
	qI/6rxAc2brPopCEWA8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iVKZq-0002Gl-HM; Thu, 14 Nov 2019 19:14:46 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iVKZm-0002Dq-RR
 for linux-nvme@lists.infradead.org; Thu, 14 Nov 2019 19:14:44 +0000
Received: by mail-pl1-x642.google.com with SMTP id s10so3080078plp.2
 for <linux-nvme@lists.infradead.org>; Thu, 14 Nov 2019 11:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=eEgMwv4stYpP/dtbh27yGsGdSdg4kPUVFwkU2s2SmcI=;
 b=KnibOcAELnyreaUyZfu9T1C9xnp2J1iyoVIYgNWPG3CLCVSbZa7E/MAMt/2Tz7b7Yn
 xgOpwnWKVcWQloaaoTXlJSm1XxIQhu6v5dctuwdxNRPiqeBc32d9EWP77LhQcOd097uU
 0v2EeQeCV5996gmoKk4tW+5FSDiqJPdUmLFYkOK+gdULVj7UFWvR7rwp920D9GS5JCud
 EBeajhvChHcJRwaHTeTReuJ1BUKTTEMv6dp0t8ALsm/KK8dluDOtL5HoDxXVSlJDh512
 YIvEEdCOGiT386GCg6NUkfJXNJTzZIL4vSVCeJZ57eeeGLXfmJAQq1TetbynTP3ixpiN
 CQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=eEgMwv4stYpP/dtbh27yGsGdSdg4kPUVFwkU2s2SmcI=;
 b=bYVo3vQD7+Vzmp456BHrhJ0Dk2TOMl8uh58t1EFSYqZDDKdNwIl09uUKDnxZ9LOjNs
 OAoejd/wAZ3XgTwnm8ACzcdbr9YFJQfzdDOgPZMtu6TAm53gc/IRA7oTxs/qwiYQkLzR
 gdNm2KvF/BZ3i7v9b2o6iUlMaO+CzPvmBD8xWiHGfn3q8ps98CfygTg98l8wnQ4H9Gka
 o5LEoAfG35MSb4MYaq5XVxw2CTG00/+KioXbFIEt3eXUDEh9RG3bb3+GbwZbKVvRTgUX
 3prEyxrVNGIW7Fq3A9O/vMahgew0cNCxn+l1PG+wEn34l3IeD6fCsUXRd/rbMRA3aKr+
 37tg==
X-Gm-Message-State: APjAAAWe/OWSBtcwUezSkKGixJVx/OdQrg+FkqUCJYUq+SrxVXrK9716
 13j8X6Y5X4rjHX/eJttK11pZYSIP
X-Google-Smtp-Source: APXvYqxEwalysafupc/hxFAIWDdIp3t9KjjysJERhvel2CwWU6Z1VmwPIoL2g0i21O0jO8EIbjZoCg==
X-Received: by 2002:a17:902:b218:: with SMTP id
 t24mr11247613plr.267.1573758882326; 
 Thu, 14 Nov 2019 11:14:42 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id v14sm5375539pja.22.2019.11.14.11.14.41
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 14 Nov 2019 11:14:41 -0800 (PST)
Date: Thu, 14 Nov 2019 11:14:40 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH v2 2/2] nvme: hwmon: add quirk to avoid changing
 temperature threshold
Message-ID: <20191114191440.GB11288@roeck-us.net>
References: <1573746001-20979-1-git-send-email-akinobu.mita@gmail.com>
 <1573746001-20979-3-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1573746001-20979-3-git-send-email-akinobu.mita@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191114_111442_914290_82A37FC1 
X-CRM114-Status: GOOD (  28.01  )
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
Cc: linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Nov 15, 2019 at 12:40:01AM +0900, Akinobu Mita wrote:
> This adds a new quirk NVME_QUIRK_NO_TEMP_THRESH_CHANGE to avoid changing
> the value of the temperature threshold feature for specific devices that
> show undesirable behavior.
> =

> Guenter reported:
> =

> "On my Intel NVME drive (SSDPEKKW512G7), writing any minimum limit on the
> Composite temperature sensor results in a temperature warning, and that
> warning is sticky until I reset the controller.
> =

> It doesn't seem to matter which temperature I write; writing -273000 has
> the same result."
> =

> The Intel NVMe has the latest firmware version installed, so this isn't
> a problem that was ever fixed.
> =

> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Jens Axboe <axboe@fb.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>

Tested on:
	INTEL SSDPEKKW512G7

Specifically verified that min/max attributes are indeed read-only
on this drive.

nvme-pci-0100
Adapter: PCI adapter
Composite:    +32.9=B0C  (low  =3D -273.1=B0C, high =3D +69.8=B0C)
                       (crit =3D +79.8=B0C)

groeck@jupiter:/sys/class/hwmon/hwmon0$ ls -l
total 0
lrwxrwxrwx 1 root root    0 Nov 14 10:59 device -> ../../../0000:01:00.0
-r--r--r-- 1 root root 4096 Nov 14 10:59 name
drwxr-xr-x 2 root root    0 Nov 14 10:59 power
lrwxrwxrwx 1 root root    0 Nov 14 10:59 subsystem -> ../../../../../../cla=
ss/hwmon
-r--r--r-- 1 root root 4096 Nov 14 10:59 temp1_alarm
-r--r--r-- 1 root root 4096 Nov 14 10:59 temp1_crit
-r--r--r-- 1 root root 4096 Nov 14 10:59 temp1_input
-r--r--r-- 1 root root 4096 Nov 14 10:59 temp1_label
-r--r--r-- 1 root root 4096 Nov 14 10:59 temp1_max
-r--r--r-- 1 root root 4096 Nov 14 10:59 temp1_min
-rw-r--r-- 1 root root 4096 Nov 14 10:59 uevent

groeck@jupiter:/sys/class/hwmon/hwmon0$ sudo nvme list
Node             SN                   Model                                =
    Namespace Usage                      Format           FW Rev  =

---------------- -------------------- -------------------------------------=
--- --------- -------------------------- ---------------- --------
/dev/nvme0n1     BTPY65250EQN512F     INTEL SSDPEKKW512G7                  =
    1         512.11  GB / 512.11  GB    512   B +  0 B    PSF121C

> ---
>  drivers/nvme/host/nvme-hwmon.c | 6 +++++-
>  drivers/nvme/host/nvme.h       | 5 +++++
>  drivers/nvme/host/pci.c        | 3 ++-
>  3 files changed, 12 insertions(+), 2 deletions(-)
> =

> diff --git a/drivers/nvme/host/nvme-hwmon.c b/drivers/nvme/host/nvme-hwmo=
n.c
> index 97a84b4..a5af21f 100644
> --- a/drivers/nvme/host/nvme-hwmon.c
> +++ b/drivers/nvme/host/nvme-hwmon.c
> @@ -170,8 +170,12 @@ static umode_t nvme_hwmon_is_visible(const void *_da=
ta,
>  	case hwmon_temp_max:
>  	case hwmon_temp_min:
>  		if ((!channel && data->ctrl->wctemp) ||
> -		    (channel && data->log.temp_sensor[channel - 1]))
> +		    (channel && data->log.temp_sensor[channel - 1])) {
> +			if (data->ctrl->quirks &
> +			    NVME_QUIRK_NO_TEMP_THRESH_CHANGE)
> +				return 0444;
>  			return 0644;
> +		}
>  		break;
>  	case hwmon_temp_alarm:
>  		if (!channel)
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 000a3d9..19e5e87 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -115,6 +115,11 @@ enum nvme_quirks {
>  	 * Prevent tag overlap between queues
>  	 */
>  	NVME_QUIRK_SHARED_TAGS                  =3D (1 << 13),
> +
> +	/*
> +	 * Don't change the value of the temperature threshold feature
> +	 */
> +	NVME_QUIRK_NO_TEMP_THRESH_CHANGE	=3D (1 << 14),
>  };
>  =

>  /*
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 931d4a9..2c0206b 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3529,7 +3529,8 @@ static const struct pci_device_id nvme_id_table[] =
=3D {
>  				NVME_QUIRK_DEALLOCATE_ZEROES, },
>  	{ PCI_VDEVICE(INTEL, 0xf1a5),	/* Intel 600P/P3100 */
>  		.driver_data =3D NVME_QUIRK_NO_DEEPEST_PS |
> -				NVME_QUIRK_MEDIUM_PRIO_SQ },
> +				NVME_QUIRK_MEDIUM_PRIO_SQ |
> +				NVME_QUIRK_NO_TEMP_THRESH_CHANGE },
>  	{ PCI_VDEVICE(INTEL, 0xf1a6),	/* Intel 760p/Pro 7600p */
>  		.driver_data =3D NVME_QUIRK_IGNORE_DEV_SUBNQN, },
>  	{ PCI_VDEVICE(INTEL, 0x5845),	/* Qemu emulated controller */
> -- =

> 2.7.4
> =


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
