Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80178C4167B
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 11:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+gxJPws422b2Km2Lt5+gEcDFhjPndl5ZiP2IpGzxOao=; b=P7UprNxxXNBIY1Fbot+3iq1BIR
	ZwfyFesSg/dN7sH5xSeprNPaOW4RTxOQAZoNLAHMAvxs119L2AKH1cuQ4hlBN59ZYTMo+GnMTZ2R8
	RlNaT7NI/dccDWOvG5jvsZ8WzozTfM2dH1p2mx1Gi/gu7Rd5jFPknw/oM/W66xMO1PnxTTIWo31pt
	dPlNjs28p7Eu8bGsrYT3DRncW0KCqyLWA0G4ZBB3053SrQ33eoYEsQdrNRAs69NIUXw3iginE/ipM
	OPNALF6a7X5WskOE3CHk/7RvCjrIRa7zq2QKA12lAysiems35YsI8Z9tWiPK/ymQUROJyPBluuu2U
	n2cwLq2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rA7bE-003kii-2O;
	Mon, 04 Dec 2023 11:58:56 +0000
Received: from mail-ed1-f46.google.com ([209.85.208.46])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rA7bA-003kfR-0a
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 11:58:54 +0000
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-54c68c8009eso325019a12.1
        for <linux-nvme@lists.infradead.org>; Mon, 04 Dec 2023 03:58:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701691129; x=1702295929;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+gxJPws422b2Km2Lt5+gEcDFhjPndl5ZiP2IpGzxOao=;
        b=mmWLz7ZNmGHPfgXMd1k4IOSavsc95AweqxnqR94Gb7hJmBnAUM65LWhrL6KUDIBZA1
         mDie9892wb8z0skLX6kyAZM82iztZ2NZatugAbjE0YVcNDMMDEk1d7CWdY++qPd6X0sy
         NOLVzONxPU1avG9TUs0busDKhIHKIqbwjih+xllfCKkt8zQqdretHNUKZTU8ZT9IF7IX
         +N3no9olATb5QCiCyJUfKAIW1MBSlXYJVZo79GqTuUmhQW1LPzd4J5SeMUoKSZaYAKP9
         /phbF3O07sOe2lCzNH2y+7H01s5KQoxkbc1s+by2FmGq6daClwP6o29E/Z/K+iA7KQ0h
         gENQ==
X-Gm-Message-State: AOJu0Yw6+Xci0ovSqWB4Sa29BnpKAl8GylanWrt+QyB2Rx0cstbffMMx
	Qk+ZcZPf0W8S1jCCbWjeB1AdO3Z5f+Q=
X-Google-Smtp-Source: AGHT+IGHuPAAkn2W4v2eBvvSMdJLv2eSq+32BNqfX9NxL43jwcAUg9ZwneZ3OSU5dQlbpqtQJYcIOQ==
X-Received: by 2002:a17:906:6dd2:b0:a01:ee03:37ee with SMTP id j18-20020a1709066dd200b00a01ee0337eemr19286646ejt.4.1701691128778;
        Mon, 04 Dec 2023 03:58:48 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id g5-20020a170906198500b009c5c5c2c5a4sm5215662ejd.219.2023.12.04.03.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 03:58:48 -0800 (PST)
Message-ID: <f5e70144-b6e3-4584-b2da-8ba3f783a4a8@grimberg.me>
Date: Mon, 4 Dec 2023 13:58:47 +0200
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
 <ef031aaa-e89f-4a66-b85b-28515db0800e@grimberg.me>
 <3095351b-f163-4b4c-8f37-145bab624a68@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <3095351b-f163-4b4c-8f37-145bab624a68@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_035852_219592_6AA9E58E 
X-CRM114-Status: GOOD (  16.21  )
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


>>>>>>> It is really annoying to always have to loop through the entire
>>>>>>> /sys/block directory just to find the namespace path links for
>>>>>>> a single namespace in libnvme/nvme-cli.
>>>>>>> So provide links to the namespace paths for efficient lookup.
>>>>>>>
>>>>>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>>>>>> ---
>>>>>>>   drivers/nvme/host/core.c      |  3 +++
>>>>>>>   drivers/nvme/host/multipath.c | 10 ++++++++++
>>>>>>>   2 files changed, 13 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>>>>>> index 37b6fa746662..88933838e067 100644
>>>>>>> --- a/drivers/nvme/host/core.c
>>>>>>> +++ b/drivers/nvme/host/core.c
>>>>>>> @@ -3681,6 +3681,9 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>>>>>>>       if (!nvme_ns_head_multipath(ns->head))
>>>>>>>           nvme_cdev_del(&ns->cdev, &ns->cdev_device);
>>>>>>> +    else
>>>>>>> +        sysfs_remove_link(&disk_to_dev(ns->head->disk)->kobj,
>>>>>>> +                  ns->disk->disk_name);
>>>>>>>       del_gendisk(ns->disk);
>>>>>>>       down_write(&ns->ctrl->namespaces_rwsem);
>>>>>>> diff --git a/drivers/nvme/host/multipath.c 
>>>>>>> b/drivers/nvme/host/multipath.c
>>>>>>> index 0a88d7bdc5e3..9dd0be645dad 100644
>>>>>>> --- a/drivers/nvme/host/multipath.c
>>>>>>> +++ b/drivers/nvme/host/multipath.c
>>>>>>> @@ -875,6 +875,16 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, 
>>>>>>> __le32 anagrpid)
>>>>>>>       if (blk_queue_is_zoned(ns->queue) && ns->head->disk)
>>>>>>>           ns->head->disk->nr_zones = ns->disk->nr_zones;
>>>>>>>   #endif
>>>>>>> +    if (ns->head->disk) {
>>>>>>
>>>>>> Why are the two conditions not identical?
>>>>>>
>>>>> Which two?
>>>>
>>>> ns->head->disk and nvme_ns_head_multipath()
>>>>
>>> How can we have one without the other? I thought that both are 
>>> mutually dependent .. but yeah, we should be using 
>>> 'nvme_ns_head_multipath()' here.
>>>
>>>>>
>>>>>>> +        int ret;
>>>>>>> +
>>>>>>> +        ret = sysfs_create_link(&disk_to_dev(ns->head->disk)->kobj,
>>>>>>> +                    &disk_to_dev(ns->disk)->kobj,
>>>>>>> +                    ns->disk->disk_name);
>>>>>>> +        if (ret)
>>>>>>> +            dev_warn(ns->ctrl->device,
>>>>>>> +                 "failed to create namespace path link\n");
>>>>>>> +    }
>>>>>>>   }
>>>>>>>   void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
>>>>>>
>>>>>> What will these links be used for?
>>>>>
>>>>> Mapping for nvme-cli, as explained in the description.
>>>>> Clearly it doesn't do it _now_, but once the patch is in we can
>>>>> simplify nvme-cli to take advantage of it.
>>>>
>>>> you mean for nvme list -v ?
>>>>
>>>> Don't really mind having it, but would want to hear from others as
>>>> well.
>>>
>>> Ok.
>>
>> Hey Hannes,
>> Has this gone anywhere?
> 
> Sadly, no. Everyone said "Yeah, good idea, but let's wait for the 
> others." I _dearly_ would love to have it as it will simplify the
> logic in nvme-cli/libnvme drastically.
> Shall I repost?

Yes, and I personally don't mind having it, so if no one voices
any concern, I don't see why we should prevent it.

