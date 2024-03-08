Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0C7C54E4A
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Mar 2024 14:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zp4GzYxfGCirIYcnYK2L2Pf8kzjR2RotTZe6f8zzD7U=; b=ECdtFq4eemP//OMFnWfNrbaUNH
	qifoBjetqRfrsFn2wwCVLNQFNP/71n82Ndd6QixhfumU5Ov8+tTWXQ/dvlCTshDNT/lSw0SAzrGVL
	UYQW/CDwF9fpKy1zee5qvxR+8oIxcONFA88TwqeEd3zs6rQ2OOw/nhdLRANvLKGnEKu9HrfmZoWpx
	obru2009aoFoVJrwK3lMNXLoe0DaNKz6b/A0yXYPx6Pf7WFLattKadUmlNEyJVdjI41faRCxoVYZd
	MVokeXueqLIkc4DA+slxFrgfaBm37ic2IOq1ktMRZ5OQKec3X2U1Lb5VzLlY4W9OLLbdb3XgJmLuP
	Lcvp2kvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rib3F-00000009W4d-08ko;
	Fri, 08 Mar 2024 14:18:21 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rib3C-00000009W34-15RB
	for linux-nvme@lists.infradead.org;
	Fri, 08 Mar 2024 14:18:19 +0000
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33e73f04309so375592f8f.0
        for <linux-nvme@lists.infradead.org>; Fri, 08 Mar 2024 06:18:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709907492; x=1710512292;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zp4GzYxfGCirIYcnYK2L2Pf8kzjR2RotTZe6f8zzD7U=;
        b=OEWBwAyWej96dgDwYY+RTYH2ZTPm8UWPykcr+uFB2zam1Crcks0xIi4pWbOV4BBiur
         o6qZWjrsZF8CPuqQqmih4XBkEmaNzeoroJWZ3rzGSfd90tXnP2uYjFxzRujrJB7TgpD1
         /y9o/tbsG/8l8wpetdDpf/+xj6zbFELkmouCK0Go2TdLZKHgPWJzIB+VykYrGG8vxB/f
         75JUqe5KJKfS801ybK1MyXiZdj6HHYonTfbKxadt9Czaw5yNQVGNaWdu/kmeGLuzXvml
         a/yRJIdTCxHYX0lUhIIzuWqsZQ/YgOiGmQd/kMU+iCQyUysaQxYzC0JuetotVvA8oK5I
         FKXA==
X-Forwarded-Encrypted: i=1; AJvYcCX/3rYUbO20gRf5GfizRx2j3z5S/+rKxp4RoMIqaNgjWxivqAuDkFnHc8855S4gbgqstS+hm2qDl/rpj8z/nVEFB7sMQHZ2unM2Wzs5I2I=
X-Gm-Message-State: AOJu0YwQlYVuwSb2ZrFfA8srwmEH6Yo2GPcJMTweEZhRHdPll9b6yBuh
	QMZ7R26eiahkK1GyFGveDdRJD8cD//zIWGlTCVsZeonD8ccw9jJCtGKh+d6o
X-Google-Smtp-Source: AGHT+IHWwXonEG5TbUlEoD/ETysmcuPWJb7xAtAWTk+4+KAqIBJlxkWT42U4D9f3w1t/sxdnPhyEOw==
X-Received: by 2002:a05:6000:1a43:b0:33e:c9e:991 with SMTP id t3-20020a0560001a4300b0033e0c9e0991mr1536807wry.6.1709907491726;
        Fri, 08 Mar 2024 06:18:11 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id v7-20020a5d59c7000000b0033e475940fasm10768889wry.66.2024.03.08.06.18.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 06:18:11 -0800 (PST)
Message-ID: <ae2423d6-8b1c-4174-81b7-e20d542a4c32@grimberg.me>
Date: Fri, 8 Mar 2024 16:18:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: add sysfs attribute 'tls_keyring'
Content-Language: he-IL, en-US
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240308121006.69442-1-hare@kernel.org>
 <50f03f5d-f356-4f2e-8239-c8bbdc780a13@grimberg.me>
 <b3669b3a-7c75-413f-a5d3-6ee5fac6a279@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <b3669b3a-7c75-413f-a5d3-6ee5fac6a279@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240308_061818_396970_55C977EE 
X-CRM114-Status: GOOD (  23.32  )
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



On 08/03/2024 16:06, Hannes Reinecke wrote:
> On 3/8/24 15:01, Sagi Grimberg wrote:
>>
>>
>> On 08/03/2024 14:10, Hannes Reinecke wrote:
>>> Add a sysfs attribute 'tls_keyring' to hold the contents for the
>>> 'keyring' fabrics option. This option is only meaningful if the
>>> 'tls' option has been specified; if the 'tls_key' option is specified
>>> the key is looked up directly and the keyring setting is ignored.
>>> So blank out the keyring value when 'tls_key' is specified.
>>>
>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>> ---
>>>   drivers/nvme/host/sysfs.c | 55 
>>> +++++++++++++++++++++++++++++++++++++--
>>>   1 file changed, 53 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
>>> index 6c7f1d5c056f..7b65ff7426c9 100644
>>> --- a/drivers/nvme/host/sysfs.c
>>> +++ b/drivers/nvme/host/sysfs.c
>>> @@ -5,11 +5,12 @@
>>>    * Copyright (c) 2011-2014, Intel Corporation.
>>>    */
>>> -#include <linux/nvme-auth.h>
>>> -
>>>   #include "nvme.h"
>>>   #include "fabrics.h"
>>> +#include <linux/nvme-auth.h>
>>> +#include <linux/nvme-keyring.h>
>>> +
>>>   static ssize_t nvme_sysfs_reset(struct device *dev,
>>>                   struct device_attribute *attr, const char *buf,
>>>                   size_t count)
>>> @@ -677,6 +678,52 @@ static ssize_t tls_key_show(struct device *dev,
>>>       return sysfs_emit(buf, "%08x", key_serial(ctrl->tls_key));
>>>   }
>>>   static DEVICE_ATTR_RO(tls_key);
>>> +
>>> +static ssize_t tls_keyring_show(struct device *dev,
>>> +                struct device_attribute *attr, char *buf)
>>> +{
>>> +    struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>>> +    struct key *keyring;
>>> +
>>> +    if (!ctrl->tls_key)
>>> +        return 0;
>>> +    /* Do not display the keyring for user-selected keys */
>>> +    if (ctrl->opts->tls_key)
>>> +        return 0;
>>> +    keyring = ctrl->opts->keyring;
>>> +    if (!keyring) {
>>> +        keyring = key_lookup(nvme_keyring_id());
>>> +        if (!keyring)
>>> +            return -EINVAL;
>>
>> Weird if this failed...
>>
> Yeah. But feels even weirder to _not_ check it.
> WARN_ON?

WARN_ON is better I guess as this is really unexpected.

>
>>> +    }
>>> +    return sysfs_emit(buf, "%s", keyring->description);
>>> +}
>>> +
>>> +static ssize_t tls_keyring_store(struct device *dev,
>>> +        struct device_attribute *attr, const char *buf, size_t count)
>>> +{
>>> +    struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>>> +    int err;
>>> +    u32 key_id;
>>> +    struct key *keyring;
>>> +
>>> +    if (!strlen(buf))
>>> +        return -EINVAL;
>>> +    err = kstrtou32(buf, 0, &key_id);
>>> +    if (err)
>>> +        return err;
>>> +    keyring = key_lookup(key_id);
>>> +    if (IS_ERR(keyring)) {
>>> +        pr_err("key %08x not found\n", key_id);
>>> +        return -EINVAL;
>>> +    }
>>> +    if (ctrl->opts->keyring)
>>> +        key_put(ctrl->opts->keyring);
>>> +    ctrl->opts->keyring = keyring;
>>> +    return 0;
>>> +}
>>
>> Why should there be a _store() for this?
>>
> Technically one can change the keyring. But I can drop it for now,
> and revisit the issue once I get around to fully test key revokation
> and key rotation.

Still I don't see a sane use-case where this would be used.

>
>>> +static DEVICE_ATTR(tls_keyring, S_IRUGO | S_IWUSR,
>>> +        tls_keyring_show, tls_keyring_store);
>>>   #endif
>>>   static struct attribute *nvme_dev_attrs[] = {
>>> @@ -708,6 +755,7 @@ static struct attribute *nvme_dev_attrs[] = {
>>>   #endif
>>>   #ifdef CONFIG_NVME_TCP_TLS
>>>       &dev_attr_tls_key.attr,
>>> +    &dev_attr_tls_keyring.attr,
>>>   #endif
>>>       &dev_attr_adm_passthru_err_log_enabled.attr,
>>>       NULL
>>> @@ -743,6 +791,9 @@ static umode_t nvme_dev_attrs_are_visible(struct 
>>> kobject *kobj,
>>>       if (a == &dev_attr_tls_key.attr &&
>>>           (!ctrl->opts || strcmp(ctrl->opts->transport, "tcp")))
>>>           return 0;
>>> +    if (a == &dev_attr_tls_keyring.attr &&
>>> +        (!ctrl->opts || strcmp(ctrl->opts->transport, "tcp")))
>>> +        return 0;
>>
>> Wouldn't it make better sense to expose it only if tls was requested?
>
> Sort of. But we never did for the 'tls_key' attribute, too, which would
> have the same restriction. So I didn't do it here.

OK, not a must. Can be added later...

