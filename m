Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B390C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Nov 2022 14:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zUVO2uAs73/Cql4hA1XYlfICmYsaoNdkKDKz1SK2c6E=; b=SmzeqP7JxL3Yx9H7DKFGcLqPje
	5O5j/w6RfsJ/YFmTtNC/QhWbOjuQugWSsMifOsWz0Qd/v0EdrKL1XYAlpcQjScZXRzHmojZqc3IMN
	oItoMA1zuSrtuabxd3lGLR4/SnvRBKzUtY9kt9m+OaJSiDLtUDo0rrFHEJAzHZZlUlsq4Xyg5SXhO
	eqjsd2c79lHivpgCe5zYifcH7fi4hAxdo1XiO4SdWoMCsIGW4ReCiss62NlyDFUMb52pafFKT9UWJ
	9/5JNJEVRwslxOGgozghe5rXVqqbOZyHaCM3JuZnS8auPG7WIsc2fxKfvfdFzJPTMd9ow8zP2LCj5
	dbxtsU2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox7ic-00EPmP-0m; Mon, 21 Nov 2022 14:24:18 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox7i0-00EPDX-KH
	for linux-nvme@lists.infradead.org; Mon, 21 Nov 2022 14:23:42 +0000
Received: by mail-wr1-f52.google.com with SMTP id n3so3540255wrp.5
        for <linux-nvme@lists.infradead.org>; Mon, 21 Nov 2022 06:23:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zUVO2uAs73/Cql4hA1XYlfICmYsaoNdkKDKz1SK2c6E=;
        b=IhYb3RSF/46cRDMsedOO2xVvGrSIoqTpBnB9n1mCROUV+nCgaUFdcyFSyHHAdl4Pz7
         jnK++Hdpj7RKhXn1rBy725bepD74QfDS+l6CElxxc4pCEK43tpPNNvDd8c/xPBKgTaGG
         owsDVGW050w2334SV63sShNcKXafIDkHG9FlXNpkbUkzr4arCJl9Jmh3DyP1nOQZA+KZ
         rXSE5zPu51pkmlfAHjXXlUiunD39xSTYe4+q7K/XJfcVLhDGJrPk+x0qs9bhskJ0yg1H
         T8CAxirkVr0MQgJ7dWZEwy8EAluZgzu+44sY0Qh4Xm3Ow58NKO+paex+WmEeEZqDUy1+
         wrZg==
X-Gm-Message-State: ANoB5pllbgWmUEHOVd9CslJ6ucKDvUgjjZN+qo4HG4vPPS/bcvnWAWff
	NM5Ylu1dOf1WK1bsWIlMabI=
X-Google-Smtp-Source: AA0mqf7ChoO9bVpAH815e7zMKu+nV+8KSfXMLdXxkhULiKL5kB1Iw1kfanUOCLCZp+XvB8fgiFcGAw==
X-Received: by 2002:adf:a181:0:b0:241:bd28:f985 with SMTP id u1-20020adfa181000000b00241bd28f985mr9526709wru.686.1669040617656;
        Mon, 21 Nov 2022 06:23:37 -0800 (PST)
Received: from [192.168.64.178] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id o5-20020a05600c510500b003b4ff30e566sm27219966wms.3.2022.11.21.06.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 06:23:37 -0800 (PST)
Message-ID: <e86daef2-dcfc-5918-b718-a6f1d3c6cf9b@grimberg.me>
Date: Mon, 21 Nov 2022 16:23:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: =?UTF-8?B?UmU6IOetlOWkjTog562U5aSNOiBbUEFUQ0hdIG52bWU6IGZpeCBtZW1s?=
 =?UTF-8?Q?eak_in_nvme=5fctrl=5fdhchap=5fsecret=5fstore=28=29?=
Content-Language: en-US
To: zhangqilong <zhangqilong3@huawei.com>, "hare@suse.de" <hare@suse.de>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20221121062113.84721-1-zhangqilong3@huawei.com>
 <b86df48d-2fd2-fe90-a1c2-721cb51d826e@grimberg.me>
 <dacd7300dfe54845b6a5ef2ee8f940d7@huawei.com>
 <9a9512de-1bbc-fafb-74d1-3bd0a156ab81@grimberg.me>
 <3e04d64de5bc4891b67b97f8fc8f9023@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <3e04d64de5bc4891b67b97f8fc8f9023@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221121_062340_722564_6A6A3A5B 
X-CRM114-Status: GOOD (  15.98  )
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



On 11/21/22 13:54, zhangqilong wrote:
>>>>>     drivers/nvme/host/core.c | 7 +++++--
>>>>>     1 file changed, 5 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>>>> index da55ce45ac70..e06d1b3961fe 100644
>>>>> --- a/drivers/nvme/host/core.c
>>>>> +++ b/drivers/nvme/host/core.c
>>>>> @@ -3748,13 +3748,16 @@ static ssize_t
>>>> nvme_ctrl_dhchap_secret_store(struct device *dev,
>>>>>     		int ret;
>>>>>
>>>>>     		ret = nvme_auth_generate_key(dhchap_secret, &ctrl-
>> host_key);
>>>>> -		if (ret)
>>>>> +		if (ret) {
>>>>> +			kfree(dhchap_secret);
>>>>>     			return ret;
>>>>> +		}
>>>>>     		kfree(opts->dhchap_secret);
>>>>>     		opts->dhchap_secret = dhchap_secret;
>>>>>     		/* Key has changed; re-authentication with new key */
>>>>>     		nvme_auth_reset(ctrl);
>>>>> -	}
>>>>> +	} else
>>>>> +		kfree(dhchap_secret);
>>
>> Perhaps lets change the check above to strncmp directly against buf and
>> allocate inside the clause.
>>
> 
> Good suggestion and I have updated fixes like:
> 
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3730,7 +3730,6 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
>   {
>          struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>          struct nvmf_ctrl_options *opts = ctrl->opts;
> -       char *dhchap_secret;
> 
>          if (!ctrl->opts->dhchap_secret)
>                  return -EINVAL;
> @@ -3739,17 +3738,20 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
>          if (memcmp(buf, "DHHC-1:", 7))
>                  return -EINVAL;
> 
> -       dhchap_secret = kzalloc(count + 1, GFP_KERNEL);
> -       if (!dhchap_secret)
> -               return -ENOMEM;
> -       memcpy(dhchap_secret, buf, count);
>          nvme_auth_stop(ctrl);
> -       if (strcmp(dhchap_secret, opts->dhchap_secret)) {
> +       if (strncmp(buf, opts->dhchap_secret, count)) {
>                  int ret;
> +               char *dhchap_secret;
> 
> +               dhchap_secret = kzalloc(count + 1, GFP_KERNEL);
> +               if (!dhchap_secret)
> +                       return -ENOMEM;
> +               memcpy(dhchap_secret, buf, count);

Maybe kmemdup instead?

>                  ret = nvme_auth_generate_key(dhchap_secret, &ctrl->host_key);
> -               if (ret)
> +               if (ret) {
> +                       kfree(dhchap_secret);
>                          return ret;
> +               }
>                  kfree(opts->dhchap_secret);
> 
> Do you think is it that ok?
> 

