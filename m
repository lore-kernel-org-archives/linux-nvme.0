Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5437DC77B75
	for <linux-nvme@archiver.kernel.org>; Wed, 17 May 2023 07:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Iwnl3W0UHELcCGxJeHUgReW0x/G0Gp/JfM1jOx3npPc=; b=cKHc2vJON8Z3DLmnsa9RaPvtfp
	GkjQSSM59z0TZ1QDJFFKlWcFp2Ys+3SsicYMbSBlQd52Aimuc4jl97/PjfG8jET39bGR1rMA/+IyN
	5Hyt9CQlt7LZF2m6XgBFsaRwRG6ZgNq5cd1gFBZL2I51YoNTZQMdNxZAKTl6eKG/ruH3TlayuLB0/
	UuvgVLKafiglFHDmmSOns7mHhhfl3N5XFFPKss1uz75UXPtbL07HoQoO+6Cd9fl0YJgK7rqZqovAX
	ndmHrc7PNzJj+60nBJ/y9cYNqvxDcp7DVFJES8kLEirDzbQQHq4KeHLavooGF8w2OXP+iiEXlEdPR
	DJvcP7kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzBhC-008gtL-2O;
	Wed, 17 May 2023 07:35:38 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzBh9-008gsK-2K
	for linux-nvme@lists.infradead.org;
	Wed, 17 May 2023 07:35:37 +0000
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3064056fa4eso22646f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 17 May 2023 00:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684308934; x=1686900934;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iwnl3W0UHELcCGxJeHUgReW0x/G0Gp/JfM1jOx3npPc=;
        b=SHN51qPPFM5SC7Eo4a3W5BSvfc/2DRXGQibTE5PHH67g0rySIl2R6X2dwAomY/Cu/J
         FtWJ0s9R8azZUVLm1bvBFxlBtvg5TLM8r6tf8ermO6ilMo0b468bkr9UpfwWBKvMGPvA
         rEKmL6eQ/FkBJ8qYLzMJkM3hpbY62gB79imYZupJQPAwRS10LxfbqhIjdRktWcNTAHrs
         oyk0xMzyQ31mApDGX76tTd4YGg80wTZRupyZm6mPisA5rKwU4sDi4R+RePeKvzpD1Pk1
         HWnTAjRVNyYqsdl8qfPFAi4izbHe9jbrWZU0Etldms6KPdTbSXwpLdW84rJwz8+lLTtp
         xBpA==
X-Gm-Message-State: AC+VfDzaBS0YI8cKTl1K5rKf0Si+d1gzTbVHwJPhKMZaFIAnKjvJPlTa
	MjApbbGVyPNb6ukVQI8fWi4=
X-Google-Smtp-Source: ACHHUZ4OenxMx4EGWnVgJ7XT7dKJEvHnnh5PTwZyII5Xwvjv7NVYg5QSvIxqMVL5viPbU8NWqliFkQ==
X-Received: by 2002:adf:f60e:0:b0:2f8:15d8:e627 with SMTP id t14-20020adff60e000000b002f815d8e627mr873551wrp.7.1684308933931;
        Wed, 17 May 2023 00:35:33 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id u14-20020adfdd4e000000b003063938bf7bsm1825639wrm.86.2023.05.17.00.35.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 00:35:33 -0700 (PDT)
Message-ID: <caea300c-1f70-4314-8c33-fd368c2d833a@grimberg.me>
Date: Wed, 17 May 2023 10:35:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] nvme-core: use macro defination to define dev attr
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, hare@suse.de
Cc: kbusch@kernel.org, hch@lst.de, linux-nvme@lists.infradead.org
References: <20230516100605.53712-1-kch@nvidia.com>
 <20230516100605.53712-4-kch@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230516100605.53712-4-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230517_003535_765049_6AC59ADA 
X-CRM114-Status: GOOD (  18.05  )
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


> Insated of duplicating the code for dhchap_secret & dhchap_ctrl_secret,
> define a macro to register device attribute to create device attribute
> that will also define store and show helpers.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/host/sysfs.c | 66 +++++++++++++++------------------------
>   1 file changed, 25 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index 515baf8d6402..e0a2a041e595 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -407,17 +407,6 @@ static ssize_t dctype_show(struct device *dev,
>   static DEVICE_ATTR_RO(dctype);
>   
>   #ifdef CONFIG_NVME_AUTH
> -static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
> -		struct device_attribute *attr, char *buf)
> -{
> -	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> -	struct nvmf_ctrl_options *opts = ctrl->opts;
> -
> -	if (!opts->dhchap_secret)
> -		return sysfs_emit(buf, "none\n");
> -	return sysfs_emit(buf, "%s\n", opts->dhchap_secret);
> -}
> -
>   static ssize_t nvme_dhchap_secret_store_common(struct nvme_ctrl *ctrl,
>   		const char *buf, size_t count, bool ctrl_secret)
>   {
> @@ -472,37 +461,32 @@ static ssize_t nvme_dhchap_secret_store_common(struct nvme_ctrl *ctrl,
>   	return count;
>   }
>   
> +#define NVME_AUTH_DEVICE_ATTR(NAME, cs)					\
> +static ssize_t nvme_ctrl_##NAME##_show(struct device *dev,		\
> +		struct device_attribute *attr, char *buf)		\
> +{									\
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);			\
> +	struct nvmf_ctrl_options *opts = ctrl->opts;			\
> +									\
> +	if (!opts->NAME)						\

This is where these macros can really take things out of context...
The code just lost readability at this point.

> +		return sysfs_emit(buf, "none\n");			\
> +	return sysfs_emit(buf, "%s\n", opts->NAME);			\
> +}									\
> +									\
> +static ssize_t nvme_ctrl_##NAME##_store(struct device *dev,		\
> +		struct device_attribute *attr, const char *buf,		\
> +		size_t count)						\
> +{									\
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);			\
> +									\
> +	return nvme_dhchap_secret_store_common(ctrl, buf, count, cs);	\
> +}									\
> +									\
> +static DEVICE_ATTR(NAME, S_IRUGO | S_IWUSR,				\
> +	nvme_ctrl_##NAME##_show, nvme_ctrl_##NAME##_store);		\
>   
> -static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
> -		struct device_attribute *attr, const char *buf, size_t count)
> -{
> -	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> -
> -	return nvme_dhchap_secret_store_common(ctrl, buf, count, false);
> -}
> -
> -static DEVICE_ATTR(dhchap_secret, S_IRUGO | S_IWUSR,
> -	nvme_ctrl_dhchap_secret_show, nvme_ctrl_dhchap_secret_store);
> -
> -static ssize_t nvme_ctrl_dhchap_ctrl_secret_show(struct device *dev,
> -		struct device_attribute *attr, char *buf)
> -{
> -	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> -	struct nvmf_ctrl_options *opts = ctrl->opts;
> -
> -	if (!opts->dhchap_ctrl_secret)
> -		return sysfs_emit(buf, "none\n");
> -	return sysfs_emit(buf, "%s\n", opts->dhchap_ctrl_secret);
> -}
> -
> -static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
> -		struct device_attribute *attr, const char *buf, size_t count)
> -{
> -	return nvme_dhchap_secret_store_common(ctrl, buf, count, false);
> -}
> -
> -static DEVICE_ATTR(dhchap_ctrl_secret, S_IRUGO | S_IWUSR,
> -	nvme_ctrl_dhchap_ctrl_secret_show, nvme_ctrl_dhchap_ctrl_secret_store);
> +NVME_AUTH_DEVICE_ATTR(dhchap_secret, false);
> +NVME_AUTH_DEVICE_ATTR(dhchap_ctrl_secret, true);
>   #endif
>   
>   static struct attribute *nvme_dev_attrs[] = {

