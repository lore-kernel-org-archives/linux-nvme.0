Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E44CA0EC3
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Sep 2023 12:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ENtGc9o8xcLlc6lfbqOegJalv73jBKAVIhdPi//rXhg=; b=t+JrPXsORgiZ2Qeh6smKA+d+YL
	lTXM8Wx329UYV/j4HIVlCc8zhBr5+rxwHITkR84iOEgOHWhyFpgLdapwFUk3oXk6g2U6V8xr5q407
	mpWcicGG4xg7S+rC7YLxuwjRFaQ/uLsRIuU75ppf/RM0rliF79wNMdyOVTQSKUa9jZvpICqdhqH7s
	TFOjjsMfnUSG4pTbAR4DAfkiGU3RLeQMxBfmBwjSiWBZdbkKgD3ehUm5TdG33jkNIpWs/psl305qb
	RmbQeNCVUS4FmGqjcUTOTemHmP+0z5kVeKkGn0ayFWEYbE2T0ZLOI1Ptg5lKHc6X8AmVaCuxThwyv
	CjpoMYhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qg2vG-003MoV-2q;
	Tue, 12 Sep 2023 12:55:18 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qg2vD-003MnM-0G
	for linux-nvme@lists.infradead.org;
	Tue, 12 Sep 2023 12:55:16 +0000
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-31c49de7a41so817155f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 12 Sep 2023 05:55:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694523312; x=1695128112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ENtGc9o8xcLlc6lfbqOegJalv73jBKAVIhdPi//rXhg=;
        b=HiYwh1yqg3xmW7LPwYFyKBtYt7O3u9GLOukOoY2OR1TW+bgkuDKzL5AHa0rkbKVV1E
         Ob8aAFjHEpSU9b/yxy9UTgEARmsdPCsxvfM8ArYpqTrcX48kRZGcy99roPrWzCKgTq+7
         AGc/XtJVxXMOpV6MpXNjkRAgOlefYFccfoKJqpfhosaJkpYBWQpwRlr2InOW5KBHxE+f
         Y2amkWXlK5APx5410IE1ourFLAcDX7vbJNnDYhKeHG47DWeqlJiYNp/sFsPCbiBELG8X
         ZiRObY6BKayOFaPxAgWOICaS3LoWYmevU38+7ge8yu6QLYSl+ajwXxQWs2ZqUrmqNoyH
         qr1g==
X-Gm-Message-State: AOJu0YzzNnvILlxjXKnXBjYciIRCXqJ/YhHw3qD0ORfakSErG4Yln9p1
	0QXzafyu8J1qMmW2ev476AY=
X-Google-Smtp-Source: AGHT+IHOfxe+M1bqjJP34ePKNupJxPvhgU8bjSZ2TPdC772t5WB0rDr+ZFqWYG8WzGjnZcJUPVwN5Q==
X-Received: by 2002:adf:e7c7:0:b0:31a:ea18:c516 with SMTP id e7-20020adfe7c7000000b0031aea18c516mr9498961wrn.3.1694523311960;
        Tue, 12 Sep 2023 05:55:11 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id c18-20020aa7d612000000b005254b41f507sm5961504edr.32.2023.09.12.05.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 05:55:10 -0700 (PDT)
Message-ID: <44f7eb6a-2dd5-b487-afeb-88b7e64d8a12@grimberg.me>
Date: Tue, 12 Sep 2023 15:55:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] nvme: add namespace paths links
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230908065717.92207-1-hare@suse.de>
 <70d9fb1e-07f8-d130-4308-f279c36ddc24@grimberg.me>
 <dd985619-7486-4ef7-9904-36e1d056767b@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <dd985619-7486-4ef7-9904-36e1d056767b@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_055515_119725_A7299EF0 
X-CRM114-Status: GOOD (  17.43  )
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


>>> It is really annoying to always have to loop through the entire
>>> /sys/block directory just to find the namespace path links for
>>> a single namespace in libnvme/nvme-cli.
>>> So provide links to the namespace paths for efficient lookup.
>>>
>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>> ---
>>>   drivers/nvme/host/core.c      |  3 +++
>>>   drivers/nvme/host/multipath.c | 10 ++++++++++
>>>   2 files changed, 13 insertions(+)
>>>
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index 37b6fa746662..88933838e067 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -3681,6 +3681,9 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>>>       if (!nvme_ns_head_multipath(ns->head))
>>>           nvme_cdev_del(&ns->cdev, &ns->cdev_device);
>>> +    else
>>> +        sysfs_remove_link(&disk_to_dev(ns->head->disk)->kobj,
>>> +                  ns->disk->disk_name);
>>>       del_gendisk(ns->disk);
>>>       down_write(&ns->ctrl->namespaces_rwsem);
>>> diff --git a/drivers/nvme/host/multipath.c 
>>> b/drivers/nvme/host/multipath.c
>>> index 0a88d7bdc5e3..9dd0be645dad 100644
>>> --- a/drivers/nvme/host/multipath.c
>>> +++ b/drivers/nvme/host/multipath.c
>>> @@ -875,6 +875,16 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, 
>>> __le32 anagrpid)
>>>       if (blk_queue_is_zoned(ns->queue) && ns->head->disk)
>>>           ns->head->disk->nr_zones = ns->disk->nr_zones;
>>>   #endif
>>> +    if (ns->head->disk) {
>>
>> Why are the two conditions not identical?
>>
> Which two?

ns->head->disk and nvme_ns_head_multipath()

> 
>>> +        int ret;
>>> +
>>> +        ret = sysfs_create_link(&disk_to_dev(ns->head->disk)->kobj,
>>> +                    &disk_to_dev(ns->disk)->kobj,
>>> +                    ns->disk->disk_name);
>>> +        if (ret)
>>> +            dev_warn(ns->ctrl->device,
>>> +                 "failed to create namespace path link\n");
>>> +    }
>>>   }
>>>   void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
>>
>> What will these links be used for?
> 
> Mapping for nvme-cli, as explained in the description.
> Clearly it doesn't do it _now_, but once the patch is in we can
> simplify nvme-cli to take advantage of it.

you mean for nvme list -v ?

Don't really mind having it, but would want to hear from others as
well.

