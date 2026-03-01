Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61DFBFD0055
	for <linux-nvme@archiver.kernel.org>; Sun,  1 Mar 2026 05:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rpI27w57lPJdjlVRZT7eA03PR77ly+SuhMWGNuiPQKc=; b=dEn3uLMs1zht6zJ5aBdu1vqVG0
	XXn7pJeLBrsFJijjighWBclocfvKLxk0InBfp/T3I2Lprf45C976fckWngspm8iAKujVTM2+oYmFz
	J1ePB2OtMeryvMGPTVEfXj2z52Nf8lbyp4Kk4qx37hMuEwmUDA5iD5Ml1dWxi4bhYRLwpKt8e/8u8
	PsHkziMGFo8e4uaFzS0/iAnwSVg9aqnA6guOCP14i6mEvaZ0zO4pVM1tLC5HrV05cRa0P4/TuhiuA
	3gbBaDyC2XdXUnCDu7JbHZclnKSD/LO3Df9CK4nliigHH+LslcPTohzomk5cELKfzLWif6L5eaDrx
	L/Vu+r8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwZ8W-0000000AqNW-1tMO;
	Sun, 01 Mar 2026 05:14:36 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwZ8T-0000000AqN9-0nUW
	for linux-nvme@lists.infradead.org;
	Sun, 01 Mar 2026 05:14:34 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2ae43042ea7so7021565ad.0
        for <linux-nvme@lists.infradead.org>; Sat, 28 Feb 2026 21:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772342072; x=1772946872; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rpI27w57lPJdjlVRZT7eA03PR77ly+SuhMWGNuiPQKc=;
        b=mNLqU8f1n02Or5qkZr67uiq8fp2l5VgH8KXhDL/2MpDDmZkpgoJZUqiyAd+lMgp/+t
         fLw7ZUUnxp+tG2C6w7zOwvtvFIJAoiT3HxzrK5Y0MbekzrvanOy2K/QqlL75MIAJYmtV
         WrI9IsNmJAbGx3PSBA0KUJK7HNMdnwUqddyLBlftpo+mmSS5T0/5vFmvT6vqtIoHNWb9
         wgXmjh7oOV745G0QCbMsH7xgoozlZGVVwJF7dY1RQe2Cba1W4oN352RwuIbTjVNUD1fU
         mU0td1+toHevOZb4tYPZ3A1R6RhpBZ5HuT07UOyoWM8iLV4I27fcnmyhI4ToyYCOL1BE
         wgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772342072; x=1772946872;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rpI27w57lPJdjlVRZT7eA03PR77ly+SuhMWGNuiPQKc=;
        b=ChXHyD9oqf+oV+BWM/KEhqLLrJ/vvVHq8dtpLe+Hnh4Oxj7SEHfeYFHVblr8YmWSLp
         ZHy11imdbVW4g6s4wmW6NV1TsuVP3krHUxz/uVtx7a5dqiWuUwgY0JSmD0T0UbDgvnZA
         obWwqShKkEJTmc7W7oheWiVB2SCtBwzNKDYKVqiBn9pahMqvOtKHMsKqc6sfCJzNXvdd
         Ywk3gLIHKJE0FCtaPmzXPyjSQ81UhndkRGkMw7vwkot/mcz1gFvHD85KYbq01fMLaXaR
         j2FZE/hDOrrtEC8jIFaGEThpXjAbsjFPGKkjdwoC9svstP6Eb2PagNv2DjiXaV2AsJJu
         dYWw==
X-Forwarded-Encrypted: i=1; AJvYcCWrN4L5MJg2jVYdRMyMxCqkdYIFDcNDrO/JH4+0qR3DoMCJkOcrNV8fbkytawo5JIR1jSE8cN1Amw2V@lists.infradead.org
X-Gm-Message-State: AOJu0YxtXJZ/F6Q/s43IdaWxmeK4zvBeyyXIgoxlRZqNfYQ+hf8apBIE
	eFd9QRucSZNyPVeSz0nYig1m7Vym1mjCtdPKNAUFrHPfYvlqc8/i3y9c
X-Gm-Gg: ATEYQzxXqCogSnyYdiH5n+pfFgm8pIRS3Y4QDOuO/T0VJAHtN7WgPH4HL1tfdao3oAM
	yRgT9Gaws6kF44WdhiBjl9PS+eBIDBIAJEaJW4FAH2Tgk4FY0mGMQP+RT5nZylHDRI6dMGYT7Lv
	uoUxL9wCPycTCGX2W2wsi7vIVA+1V1JUmxwJRqOtUG3qw1DO0xSI8gHPFA/cQqcMYcAHLOw/YUs
	tyijfwAZEZFMLpnK4uEiEiAMjoZAGQ50JHelQg1Z/+8J213Tp0tDAPdCahdIFaEZH3SSBzoP4Ox
	Xxt1V1uiCQC/Na5/E64ypcyRdjc1XhWYc1MQN4qNgXA83/bO7VQILLRNVUN87Fta37PuwFm9ZJo
	eu+zv94Z6d7fQ1qflJk2PLR+PKuESAV5FVY1a2xsGL68D6qzsM912pkQFX63JSmk6v3oJTz+G6w
	tWcC3bzyKxHtinqXQw/02hWFlCh/e11ieDHzZNq3Rhusu39kSFMhi2cznS1eR8fUMau30S
X-Received: by 2002:a17:903:234c:b0:2ae:3a1e:3489 with SMTP id d9443c01a7336-2ae3a1e3594mr53969895ad.15.1772342072306;
        Sat, 28 Feb 2026 21:14:32 -0800 (PST)
Received: from ?IPV6:240b:10:2720:5500:7dbc:adce:1626:8eb9? ([240b:10:2720:5500:7dbc:adce:1626:8eb9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6f46c2sm108785775ad.89.2026.02.28.21.14.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Feb 2026 21:14:32 -0800 (PST)
Message-ID: <b305fd31-9d73-49c7-9019-b0832a913239@gmail.com>
Date: Sun, 1 Mar 2026 14:14:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme/ioctl: allow 64-bit results in io-passthru command
To: Maurizio Lombardi <mlombard@arkamax.eu>, linux-nvme@lists.infradead.org
References: <20260224185159.20247-1-ikegami.t@gmail.com>
 <DGNY74KW07IJ.1KYHECYVFPIVP@arkamax.eu>
Content-Language: en-US
From: Tokunori Ikegami <ikegami.t@gmail.com>
In-Reply-To: <DGNY74KW07IJ.1KYHECYVFPIVP@arkamax.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260228_211433_276982_89E9A474 
X-CRM114-Status: GOOD (  16.63  )
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

Just sent the v2 patch fixed as adviced. Thanks for your comment.

On 2026/02/25 18:50, Maurizio Lombardi wrote:
> On Tue Feb 24, 2026 at 7:51 PM CET, Tokunori Ikegami wrote:
>> Deprecated NVME_IOCTL_IO_CMD ioctl on the char device.
>> But nvme-cli still uses it and NVME_IOCTL_IO64_CMD for now.
>> So add NVME_IOCTL_IO64_CMD also to allow it.
>>    Note: 32/62-bit ioctl duplicated code should be refactored.
> Indeed nvme_dev_user_cmd() seems identical.
>
> Wouldn't make sense to add a "bool is64bit" parameter to
> nvme_dev_user_cmd() and then just do
>
> if (is64bit)
> 	ret = nvme_user_cmd64(ctrl, ns, argp, 0, open_for_write);
> else
> 	ret = nvme_user_cmd(ctrl, ns, argp, 0, open_for_write);
>
> ?
>
> Maurizio
>
>> Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
>> ---
>>   drivers/nvme/host/ioctl.c | 39 +++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 39 insertions(+)
>>
>> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
>> index 8844bbd39515..ff7df944ef53 100644
>> --- a/drivers/nvme/host/ioctl.c
>> +++ b/drivers/nvme/host/ioctl.c
>> @@ -845,6 +845,43 @@ static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp,
>>   	return ret;
>>   }
>>   
>> +static int nvme_dev_user_cmd64(struct nvme_ctrl *ctrl, void __user *argp,
>> +		bool open_for_write)
>> +{
>> +	struct nvme_ns *ns;
>> +	int ret, srcu_idx;
>> +
>> +	srcu_idx = srcu_read_lock(&ctrl->srcu);
>> +	if (list_empty(&ctrl->namespaces)) {
>> +		ret = -ENOTTY;
>> +		goto out_unlock;
>> +	}
>> +
>> +	ns = list_first_or_null_rcu(&ctrl->namespaces, struct nvme_ns, list);
>> +	if (ns != list_last_entry(&ctrl->namespaces, struct nvme_ns, list)) {
>> +		dev_warn(ctrl->device,
>> +			"NVME_IOCTL_IO64_CMD not supported when multiple namespaces present!\n");
>> +		ret = -EINVAL;
>> +		goto out_unlock;
>> +	}
>> +
>> +	dev_warn(ctrl->device,
>> +		"using deprecated NVME_IOCTL_IO64_CMD ioctl on the char device!\n");
>> +	if (!nvme_get_ns(ns)) {
>> +		ret = -ENXIO;
>> +		goto out_unlock;
>> +	}
>> +	srcu_read_unlock(&ctrl->srcu, srcu_idx);
>> +
>> +	ret = nvme_user_cmd64(ctrl, ns, argp, 0, open_for_write);
>> +	nvme_put_ns(ns);
>> +	return ret;
>> +
>> +out_unlock:
>> +	srcu_read_unlock(&ctrl->srcu, srcu_idx);
>> +	return ret;
>> +}
>> +
>>   long nvme_dev_ioctl(struct file *file, unsigned int cmd,
>>   		unsigned long arg)
>>   {
>> @@ -859,6 +896,8 @@ long nvme_dev_ioctl(struct file *file, unsigned int cmd,
>>   		return nvme_user_cmd64(ctrl, NULL, argp, 0, open_for_write);
>>   	case NVME_IOCTL_IO_CMD:
>>   		return nvme_dev_user_cmd(ctrl, argp, open_for_write);
>> +	case NVME_IOCTL_IO64_CMD:
>> +		return nvme_dev_user_cmd64(ctrl, argp, open_for_write);
>>   	case NVME_IOCTL_RESET:
>>   		if (!capable(CAP_SYS_ADMIN))
>>   			return -EACCES;

