Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D248CC54E4A
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Mar 2024 14:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AAJe7Wr5/ti/2DItKxhJgAPl8/qgQ3jB2lIIwnp90mE=; b=SKv6ewI2VltZ4+Buu+zyvchVd/
	5vxOdvACjtQyUW9SgcqAyYkUamF2vqFaka3G5ubSEPZx2RQjERNIF/MPK14bYLXjXrX8/v46jYYTO
	culJP72MvRUy3vdURIPAFDoYTRHpxygwUOooZsW9fo3ZFcaLTTXOpj0E1aRNnubsqB4jRo+Iarv87
	ZXO93PqV6NTS3uV113I4wz+gK9V9kJdj8DihKNcWIW2TJFil7+Fu2XNmJ0KXYpl/Owuxzq/VclCb5
	LV4jsVttepHS8RhDy7J68i2d0LFKYrJguNGDNT0qb/UunGtUx5338s+Bfeg40OgTJRw3DeYJTNARb
	Qx6CwGuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riamh-00000009QqU-38n4;
	Fri, 08 Mar 2024 14:01:15 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riamd-00000009QoN-0Abi
	for linux-nvme@lists.infradead.org;
	Fri, 08 Mar 2024 14:01:12 +0000
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-412db7067d6so874155e9.1
        for <linux-nvme@lists.infradead.org>; Fri, 08 Mar 2024 06:01:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709906469; x=1710511269;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AAJe7Wr5/ti/2DItKxhJgAPl8/qgQ3jB2lIIwnp90mE=;
        b=uEjjBf/4/4L9tORrSLl5a0aZZltgTfIIShQIEOAdcuVTXaVl33jOyrvvZY0xrYCQPO
         8h3VHL72tlRRu+wPtk2X2pvFotu6XU49Nn+6OHLSHg55PW7bBYtPsl36iITmoeg2EWO1
         3yl5e3rPbz8lrO6otVbys+cnhe5QUCMMZurwWgpaoO0SUd4edjuC85peuqaH0gU9tbba
         M/x3Sjw5z3wJksTk/hjl4hIaPYMLn7DLElQ7eia+b7DeLDWr4hT3h3oWozcZIK8aeo1H
         L9yBjCEw9yQG+4Jdwm+XqgOMx3CjUogwcGNbDA4lu0ZkPBuuWOst2VfoMdouW+dyRK1f
         ceIg==
X-Forwarded-Encrypted: i=1; AJvYcCV+3Lj3Nz9ojO0BJH6+KEckzJUrqFJJmANyTGluczLgnSoSA6jFFQBHsv2xj9nU2ZQ/QKXcw5590oSBv6OoF6cDL3YDuE9eNahQ2RRe8vU=
X-Gm-Message-State: AOJu0Yyk6Yy+dlhbBPCFAANwtBhzdONVNmPzrLGkvu2J9EReT8h0NVnX
	lQxo8cKkf/WL6neRIwQA7DrhlKj3zAbPSCPVNbWfz2T2+J3TBFMD
X-Google-Smtp-Source: AGHT+IGnToJAQpQsApxrIWmNYsRJsyeM8lYGRgqXFjSm0gS7mfMvKw6tAGGi0BGnnbyeNtd5abgNng==
X-Received: by 2002:a05:600c:3b24:b0:412:ddee:e66f with SMTP id m36-20020a05600c3b2400b00412ddeee66fmr1569890wms.2.1709906468388;
        Fri, 08 Mar 2024 06:01:08 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id jg2-20020a05600ca00200b004131683c268sm2736367wmb.27.2024.03.08.06.01.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 06:01:08 -0800 (PST)
Message-ID: <50f03f5d-f356-4f2e-8239-c8bbdc780a13@grimberg.me>
Date: Fri, 8 Mar 2024 16:01:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: add sysfs attribute 'tls_keyring'
Content-Language: he-IL, en-US
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20240308121006.69442-1-hare@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240308121006.69442-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240308_060111_118888_B9B64392 
X-CRM114-Status: GOOD (  24.64  )
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



On 08/03/2024 14:10, Hannes Reinecke wrote:
> Add a sysfs attribute 'tls_keyring' to hold the contents for the
> 'keyring' fabrics option. This option is only meaningful if the
> 'tls' option has been specified; if the 'tls_key' option is specified
> the key is looked up directly and the keyring setting is ignored.
> So blank out the keyring value when 'tls_key' is specified.
>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/sysfs.c | 55 +++++++++++++++++++++++++++++++++++++--
>   1 file changed, 53 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index 6c7f1d5c056f..7b65ff7426c9 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -5,11 +5,12 @@
>    * Copyright (c) 2011-2014, Intel Corporation.
>    */
>   
> -#include <linux/nvme-auth.h>
> -
>   #include "nvme.h"
>   #include "fabrics.h"
>   
> +#include <linux/nvme-auth.h>
> +#include <linux/nvme-keyring.h>
> +
>   static ssize_t nvme_sysfs_reset(struct device *dev,
>   				struct device_attribute *attr, const char *buf,
>   				size_t count)
> @@ -677,6 +678,52 @@ static ssize_t tls_key_show(struct device *dev,
>   	return sysfs_emit(buf, "%08x", key_serial(ctrl->tls_key));
>   }
>   static DEVICE_ATTR_RO(tls_key);
> +
> +static ssize_t tls_keyring_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +	struct key *keyring;
> +
> +	if (!ctrl->tls_key)
> +		return 0;
> +	/* Do not display the keyring for user-selected keys */
> +	if (ctrl->opts->tls_key)
> +		return 0;
> +	keyring = ctrl->opts->keyring;
> +	if (!keyring) {
> +		keyring = key_lookup(nvme_keyring_id());
> +		if (!keyring)
> +			return -EINVAL;

Weird if this failed...

> +	}
> +	return sysfs_emit(buf, "%s", keyring->description);
> +}
> +
> +static ssize_t tls_keyring_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +	int err;
> +	u32 key_id;
> +	struct key *keyring;
> +
> +	if (!strlen(buf))
> +		return -EINVAL;
> +	err = kstrtou32(buf, 0, &key_id);
> +	if (err)
> +		return err;
> +	keyring = key_lookup(key_id);
> +	if (IS_ERR(keyring)) {
> +		pr_err("key %08x not found\n", key_id);
> +		return -EINVAL;
> +	}
> +	if (ctrl->opts->keyring)
> +		key_put(ctrl->opts->keyring);
> +	ctrl->opts->keyring = keyring;
> +	return 0;
> +}

Why should there be a _store() for this?

> +static DEVICE_ATTR(tls_keyring, S_IRUGO | S_IWUSR,
> +		tls_keyring_show, tls_keyring_store);
>   #endif
>   
>   static struct attribute *nvme_dev_attrs[] = {
> @@ -708,6 +755,7 @@ static struct attribute *nvme_dev_attrs[] = {
>   #endif
>   #ifdef CONFIG_NVME_TCP_TLS
>   	&dev_attr_tls_key.attr,
> +	&dev_attr_tls_keyring.attr,
>   #endif
>   	&dev_attr_adm_passthru_err_log_enabled.attr,
>   	NULL
> @@ -743,6 +791,9 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
>   	if (a == &dev_attr_tls_key.attr &&
>   	    (!ctrl->opts || strcmp(ctrl->opts->transport, "tcp")))
>   		return 0;
> +	if (a == &dev_attr_tls_keyring.attr &&
> +	    (!ctrl->opts || strcmp(ctrl->opts->transport, "tcp")))
> +		return 0;

Wouldn't it make better sense to expose it only if tls was requested?

