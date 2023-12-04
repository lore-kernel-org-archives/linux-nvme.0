Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A398C46CA0
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 10:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Exl52A+JFELSda2Osmbv9y7XFUMKErDg9l9CNqylhQA=; b=wrSIPuZxfIeM3T+OSKnwkkC1xr
	MpEt4kZ/PuiEk8qod4hcQJbZ/KUPPgFpuTYWNoqt/+93XAoL3DdaLyUDjDFrqRAyS3LjKs9/cKqZf
	IZR8MlqYsf1qirscM3LrOoQ8gqVwdl2ZWK1LA/euF9zXdV8n7jbbcD8pTymq+JHU2o/d2g4Hk9jAQ
	oO4rPkS0q+ttpX+syai+2iDWJ8ia2bzZzNgi+7L/yimDltNYKQw/wvPbYRM5HimRKQlXYmkZb7IwN
	I+swoKGmhVkgI/4/lw/1dXF/tzBimiuGveypmkukhpHZb7r0rIskEqb/C/eXYsOU6yZzfKEBRkfT7
	RdQtIRvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rA69D-003XM5-0I;
	Mon, 04 Dec 2023 10:25:55 +0000
Received: from mail-lf1-f50.google.com ([209.85.167.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rA68y-003XJf-36
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 10:25:52 +0000
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50bf5398755so124331e87.0
        for <linux-nvme@lists.infradead.org>; Mon, 04 Dec 2023 02:25:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701685539; x=1702290339;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Exl52A+JFELSda2Osmbv9y7XFUMKErDg9l9CNqylhQA=;
        b=iWIy3OA+QVkPGDBKaVBMTzOkShat5T5rQWnLcWI3fI7qI5m9gKYbXHkYV6UbW7kqNM
         D5qsPXcqdzbFK07rJE0xG7j8ay2tAWLCL3ppvA8tgi5fNCzTu7/UnT0Njzmwe2e5Ifrs
         rSmRh3O0tor6EON7foiEdAHzpI/pKNr7Rq8HtHsi408gSwI1yWyb4Kgqlu071ywQ9Vcy
         qrXoF1JGmPWLwnyLkplSpSU8pzZI+QccT6YOr1yh9WGerNWloG2CrxV/HBETMW3L0Tib
         BRSjWNfi84efm6JFqTJtlsfJfZoZQWnSoMRXhaNL5aucrzntns+/fND3IaLMteJdxCnX
         G29A==
X-Gm-Message-State: AOJu0Yy3aabGeLNTPK9kPyxq5uzC720iBB3T3gA0gem3AHLiq/geJ/n3
	gGtMN5thUYEXVGAaR24KoC0dlyNddwM=
X-Google-Smtp-Source: AGHT+IFivPb3rstVll13tEVLX/C3h5FUwmUtaRnOBOtPxXeAcdBBNFDd7fGXrb1J8qGPWBEvJfj5nQ==
X-Received: by 2002:a05:6512:281c:b0:50b:fcd4:97e8 with SMTP id cf28-20020a056512281c00b0050bfcd497e8mr649755lfb.6.1701685538835;
        Mon, 04 Dec 2023 02:25:38 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id fc12-20020a05600c524c00b0040b400711f5sm18276120wmb.7.2023.12.04.02.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 02:25:37 -0800 (PST)
Message-ID: <ef031aaa-e89f-4a66-b85b-28515db0800e@grimberg.me>
Date: Mon, 4 Dec 2023 12:25:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: add namespace paths links
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230908065717.92207-1-hare@suse.de>
 <70d9fb1e-07f8-d130-4308-f279c36ddc24@grimberg.me>
 <dd985619-7486-4ef7-9904-36e1d056767b@suse.de>
 <44f7eb6a-2dd5-b487-afeb-88b7e64d8a12@grimberg.me>
 <31a44658-4a3a-43db-a99c-451c655dfb4a@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <31a44658-4a3a-43db-a99c-451c655dfb4a@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_022541_087001_97913610 
X-CRM114-Status: GOOD (  17.05  )
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



On 9/12/23 17:04, Hannes Reinecke wrote:
> On 9/12/23 14:55, Sagi Grimberg wrote:
>>
>>>>> It is really annoying to always have to loop through the entire
>>>>> /sys/block directory just to find the namespace path links for
>>>>> a single namespace in libnvme/nvme-cli.
>>>>> So provide links to the namespace paths for efficient lookup.
>>>>>
>>>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>>>> ---
>>>>>   drivers/nvme/host/core.c      |  3 +++
>>>>>   drivers/nvme/host/multipath.c | 10 ++++++++++
>>>>>   2 files changed, 13 insertions(+)
>>>>>
>>>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>>>> index 37b6fa746662..88933838e067 100644
>>>>> --- a/drivers/nvme/host/core.c
>>>>> +++ b/drivers/nvme/host/core.c
>>>>> @@ -3681,6 +3681,9 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>>>>>       if (!nvme_ns_head_multipath(ns->head))
>>>>>           nvme_cdev_del(&ns->cdev, &ns->cdev_device);
>>>>> +    else
>>>>> +        sysfs_remove_link(&disk_to_dev(ns->head->disk)->kobj,
>>>>> +                  ns->disk->disk_name);
>>>>>       del_gendisk(ns->disk);
>>>>>       down_write(&ns->ctrl->namespaces_rwsem);
>>>>> diff --git a/drivers/nvme/host/multipath.c 
>>>>> b/drivers/nvme/host/multipath.c
>>>>> index 0a88d7bdc5e3..9dd0be645dad 100644
>>>>> --- a/drivers/nvme/host/multipath.c
>>>>> +++ b/drivers/nvme/host/multipath.c
>>>>> @@ -875,6 +875,16 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, 
>>>>> __le32 anagrpid)
>>>>>       if (blk_queue_is_zoned(ns->queue) && ns->head->disk)
>>>>>           ns->head->disk->nr_zones = ns->disk->nr_zones;
>>>>>   #endif
>>>>> +    if (ns->head->disk) {
>>>>
>>>> Why are the two conditions not identical?
>>>>
>>> Which two?
>>
>> ns->head->disk and nvme_ns_head_multipath()
>>
> How can we have one without the other? I thought that both are mutually 
> dependent .. but yeah, we should be using 'nvme_ns_head_multipath()' here.
> 
>>>
>>>>> +        int ret;
>>>>> +
>>>>> +        ret = sysfs_create_link(&disk_to_dev(ns->head->disk)->kobj,
>>>>> +                    &disk_to_dev(ns->disk)->kobj,
>>>>> +                    ns->disk->disk_name);
>>>>> +        if (ret)
>>>>> +            dev_warn(ns->ctrl->device,
>>>>> +                 "failed to create namespace path link\n");
>>>>> +    }
>>>>>   }
>>>>>   void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
>>>>
>>>> What will these links be used for?
>>>
>>> Mapping for nvme-cli, as explained in the description.
>>> Clearly it doesn't do it _now_, but once the patch is in we can
>>> simplify nvme-cli to take advantage of it.
>>
>> you mean for nvme list -v ?
>>
>> Don't really mind having it, but would want to hear from others as
>> well.
> 
> Ok.

Hey Hannes,
Has this gone anywhere?

