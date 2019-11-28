Return-Path: <SRS0=mBQh=ZU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6E7C432C0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Nov 2019 15:15:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A901C21781
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Nov 2019 15:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Zd5HtvSc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7H/vMgH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A901C21781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3yWFguB5HsBw+LKzjKEMLRMgx2G7cDwq7eEoIq3FiZU=; b=Zd5HtvSc1dvk1yJBZrXOJXHB4
	6zEX5r3f+RTXdUDUJ1dd8am5lxTDgjBE7G2OVkdJ8RU79Mf/TGXCC2tAnYwDIiAR+W7T8l3+VqZGA
	w/WvSHYvpLgPlouzDb4BAMZKezJ8IJmwNzed1s+DMk1c0+XgsvsOAnSpKFUlBQn7RTaV3eojhuOeV
	emUMQ4V1hmhsBhIDRdY5WPCp41FNeJapuAWLSgMeAws9d9vE3nEumqIy8h9nDnFcDIzPuMkyDkXXw
	SkNFGIOre1/zZXw0qtDy4JCyN419jH06K4p5pCqk0EZ3cjFvmPUR8pIoZeiTwEemtuI5rjbyEiO5t
	JrkyMZB5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iaLVe-0008Kb-KC; Thu, 28 Nov 2019 15:15:10 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iaLUd-0006sB-Mp
 for linux-nvme@lists.infradead.org; Thu, 28 Nov 2019 15:14:10 +0000
Received: by mail-ot1-x342.google.com with SMTP id o9so1365741ote.2
 for <linux-nvme@lists.infradead.org>; Thu, 28 Nov 2019 07:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=HtuUzrcYCx4FDKvEYRGNCE7CBoyzQfGcKVK/4Fc5Xdo=;
 b=U7H/vMgHKUQfGCWIqsAc2hDHGYhdMRtA9d/x76Mk5bgXtAUHQYEQezz4KCmwjzRW3Q
 +hsmclBS9eH14K21262FlXFPBytrKVmtqE6z5p3Mhr0hBRSz6Z0pzVEFti39PLc/XAxR
 zhD+DjtkdgHLUyMGBNkFnUDJXEDRhysdooejFjchqAbk1nkr7MKaHCVY0WU/efzuvrsy
 f7sb0aw+V9v5w/zyksxHwYqHPfyNJvAnODn4HLzBofYH0/kjvpWUixCFUvHR0Kn2JOBg
 AJvdKW3wjpEhw10cyE8N83V/fU3TEDHS51QKDX7k+/MRSvBF6VZIQ9wkkGDnU6m7vv3p
 18+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HtuUzrcYCx4FDKvEYRGNCE7CBoyzQfGcKVK/4Fc5Xdo=;
 b=BKKtmzfe90dF7nvCXDfYJMvuLhKQySvRS2G0RTJbCKh4o66vKgBWkCOQ+ldjEcKmRK
 3PdH1l+t+0JY5UShyqAPNPW0D18AwoWUYIJ6Fpr0woaRhsI5DsaXgUOqWxbVweKIRUug
 /Iqly4um+tUDJjGMtXqjpm4F0nlRJzCF3EyN6G0KFt7J0B6MsHX0uQjlUDXkHPGV+Yxo
 dXSiRD/2lD5P+EopqaMviii7wNpad7fskZlQKSfFnZIekCWwvSa7q5cWR9v/IqW0rTNQ
 ++G6qOY3mXAWzE/ynFZ3KIAawMVW+pFxLLW+nFBYqhOvhw0xTybQ1CoHeNcXPSH07xIh
 ZRSw==
X-Gm-Message-State: APjAAAUtRqZFWmcuB2pkdC0K1sJ9hlYrXkifCxXyetLKONtb1wjMIM3W
 W62WBi7HvsVHvNVOLpfX/dM=
X-Google-Smtp-Source: APXvYqwID9RssdR2nPQiWYVEbA9lQFH3JA3ZSSEgHgyZrAY109cux/TszBuuQeKLk9wPhsrCNT+FyQ==
X-Received: by 2002:a05:6830:46:: with SMTP id d6mr8123426otp.7.1574954045573; 
 Thu, 28 Nov 2019 07:14:05 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 l73sm2613001oib.0.2019.11.28.07.14.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 28 Nov 2019 07:14:04 -0800 (PST)
Subject: Re: [PATCH v2 7/8] nvme: hwmon: switch to use <linux/temperature.h>
 helpers
To: Akinobu Mita <akinobu.mita@gmail.com>, linux-nvme@lists.infradead.org,
 linux-hwmon@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1574952879-7200-1-git-send-email-akinobu.mita@gmail.com>
 <1574952879-7200-8-git-send-email-akinobu.mita@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <479c99fe-51c6-910f-4471-4883de4cfd21@roeck-us.net>
Date: Thu, 28 Nov 2019 07:14:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1574952879-7200-8-git-send-email-akinobu.mita@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191128_071407_770730_935DD805 
X-CRM114-Status: GOOD (  19.74  )
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
Cc: Amit Kucheria <amit.kucheria@verdurent.com>,
 Jean Delvare <jdelvare@suse.com>, Sagi Grimberg <sagi@grimberg.me>,
 Sujith Thomas <sujith.thomas@intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Darren Hart <dvhart@infradead.org>,
 Zhang Rui <rui.zhang@intel.com>, Christoph Hellwig <hch@lst.de>,
 Andy Shevchenko <andy@infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/28/19 6:54 AM, Akinobu Mita wrote:
> This switches the nvme driver to use kelvin_to_millicelsius() and
> millicelsius_to_kelvin() in <linux/temperature.h>.
> 
> Cc: Sujith Thomas <sujith.thomas@intel.com>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Andy Shevchenko <andy@infradead.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Amit Kucheria <amit.kucheria@verdurent.com>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Jens Axboe <axboe@fb.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> * v2
> - add Reviewed-by tag
> 
>   drivers/nvme/host/hwmon.c | 13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
> index a5af21f..14720c1 100644
> --- a/drivers/nvme/host/hwmon.c
> +++ b/drivers/nvme/host/hwmon.c
> @@ -5,14 +5,11 @@
>    */
>   
>   #include <linux/hwmon.h>
> +#include <linux/temperature.h>
>   #include <asm/unaligned.h>
>   
>   #include "nvme.h"
>   
> -/* These macros should be moved to linux/temperature.h */
> -#define MILLICELSIUS_TO_KELVIN(t) DIV_ROUND_CLOSEST((t) + 273150, 1000)
> -#define KELVIN_TO_MILLICELSIUS(t) ((t) * 1000L - 273150)
> -
>   struct nvme_hwmon_data {
>   	struct nvme_ctrl *ctrl;
>   	struct nvme_smart_log log;
> @@ -35,7 +32,7 @@ static int nvme_get_temp_thresh(struct nvme_ctrl *ctrl, int sensor, bool under,
>   		return -EIO;
>   	if (ret < 0)
>   		return ret;
> -	*temp = KELVIN_TO_MILLICELSIUS(status & NVME_TEMP_THRESH_MASK);
> +	*temp = kelvin_to_millicelsius(status & NVME_TEMP_THRESH_MASK);
>   
>   	return 0;
>   }
> @@ -46,7 +43,7 @@ static int nvme_set_temp_thresh(struct nvme_ctrl *ctrl, int sensor, bool under,
>   	unsigned int threshold = sensor << NVME_TEMP_THRESH_SELECT_SHIFT;
>   	int ret;
>   
> -	temp = MILLICELSIUS_TO_KELVIN(temp);
> +	temp = millicelsius_to_kelvin(temp);
>   	threshold |= clamp_val(temp, 0, NVME_TEMP_THRESH_MASK);
>   
>   	if (under)
> @@ -88,7 +85,7 @@ static int nvme_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>   	case hwmon_temp_min:
>   		return nvme_get_temp_thresh(data->ctrl, channel, true, val);
>   	case hwmon_temp_crit:
> -		*val = KELVIN_TO_MILLICELSIUS(data->ctrl->cctemp);
> +		*val = kelvin_to_millicelsius(data->ctrl->cctemp);
>   		return 0;
>   	default:
>   		break;
> @@ -105,7 +102,7 @@ static int nvme_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>   			temp = get_unaligned_le16(log->temperature);
>   		else
>   			temp = le16_to_cpu(log->temp_sensor[channel - 1]);
> -		*val = KELVIN_TO_MILLICELSIUS(temp);
> +		*val = kelvin_to_millicelsius(temp);
>   		break;
>   	case hwmon_temp_alarm:
>   		*val = !!(log->critical_warning & NVME_SMART_CRIT_TEMPERATURE);
> 


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
