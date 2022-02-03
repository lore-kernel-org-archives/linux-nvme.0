Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A04C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Feb 2022 13:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vLplqnYKa7rAnsuga6weIqYzZEc56+aG4QXR6MP7YJM=; b=FtYEJBQhx4s6TuM6b8/A7kR/xo
	PBXkP2+NjIeR3TH9xpWF1aSTALVGOX4+qhJ8EvIYQ0wvbPfgnxzsYL4mZFlpfgfmMQXanA06e7Ff9
	x4c4VOVncVBPVXqPe5IQz8+WlPkAzFgbW1Ze6fJZU+1SFsrEK0O/iVz7D758sBmhJs4bYfoE2UqOA
	6VKDB/B1B5afue4cag1wga4mmSDicOgNQLxDvHK/J+w7b7B3ODBTNgfrQhcbu24ReUmjc4S//4P4m
	1BNcFWMAGjIgETacyCO5vvw8Yl6fcDu72QvHYaqG/S7T/RAI9OaZwwxhX6JftYsz8meBnIyn/FltJ
	nP/e4HIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFbqV-001MbU-6W; Thu, 03 Feb 2022 13:08:19 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFbqS-001MaT-0a
 for linux-nvme@lists.infradead.org; Thu, 03 Feb 2022 13:08:17 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 n40-20020a05600c3ba800b00353958feb16so1787538wms.1
 for <linux-nvme@lists.infradead.org>; Thu, 03 Feb 2022 05:08:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=vLplqnYKa7rAnsuga6weIqYzZEc56+aG4QXR6MP7YJM=;
 b=mDSaAuTtOUDetc1jMsh89hoLY1d5x5dzKO328kipRQElvNYaJnCIkOD8xucvt29Urc
 5pGust3UYdNpgl96zwU5Lr6UEXDJk2D+gdfrNINQVooCTnl3TUlqefnROrDdviGK+lpY
 bR9D6wnRWFpMbvon2l/xI7wHS07YMlw5innfklI70QCxd+drk46uam5HHyC5U1RORkUZ
 1WBGzI8APY6ir0AQ6UwKzFKhFViLrBG5L0Bim+lQ7rIcpxbQSeTZJ+2vsTvCbXKzaocV
 yoCoxk2+G2mZMCFRoZ4FiqutJFjoN5TQFGYn59s97Gfesyh+vnclwy3rA/JbTIeS575g
 4Spw==
X-Gm-Message-State: AOAM533Qj+ig8wH7t74NF5oERo9YmY4Wc7NgJcs8mxPmrLDreUGaUNqv
 PmIYL5v+ks/bZbFcMk6psXc=
X-Google-Smtp-Source: ABdhPJxMvapl1GmKY+8NBjpJsztG7z+2aTmQVpGCF2Bd4UwTtZ2aF5zCtgwFuKALKoRZcUW7VZwm2A==
X-Received: by 2002:a05:600c:2948:: with SMTP id
 n8mr10338608wmd.61.1643893694355; 
 Thu, 03 Feb 2022 05:08:14 -0800 (PST)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id h6sm7591727wmq.26.2022.02.03.05.08.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Feb 2022 05:08:13 -0800 (PST)
Message-ID: <95306ac0-3572-17fa-889a-5b6fa36fbc2a@grimberg.me>
Date: Thu, 3 Feb 2022 15:08:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] nvme: Expose cntrltype and dctype through sysfs.
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>,
 "Belanger, Martin" <Martin.Belanger@dell.com>,
 Martin Belanger <nitram_67@hotmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "Hayes, Stuart" <Stuart.Hayes@dell.com>,
 "Rose, Charles" <Charles.Rose@dell.com>
References: <20220202213451.33599-1-nitram_67@hotmail.com>
 <BL0PR13MB4291C612318AC862FDDEB7719C279@BL0PR13MB4291.namprd13.prod.outlook.com>
 <49b2d58e-80b4-94f2-77ef-c2d1ec19e581@suse.de>
 <BLAPR19MB45318B8797176BF97BAB0A30F2289@BLAPR19MB4531.namprd19.prod.outlook.com>
 <68451fbe-ff4c-a89c-36d7-1b5829fab825@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <68451fbe-ff4c-a89c-36d7-1b5829fab825@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220203_050816_096414_A9434F00 
X-CRM114-Status: GOOD (  21.20  )
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


>>>> From: Martin Belanger <martin.belanger@dell.com>
>>>>
>>>> TP8010 introduces the Discovery Controller Type (dctype) attribute.
>>>> The dctype is returned in the response to the Identify command. This
>>>> patch exposes the dctype through the sysfs. Since the dctype depends
>>>> on the Controller Type (cntrltype), another attribute of the Identify
>>>> response, the patch also exposes the cntrltype as well.
>>>>
>>>> Signed-off-by: Martin Belanger <martin.belanger@dell.com>
>>>> ---
>>>>    drivers/nvme/host/core.c | 35
>>> +++++++++++++++++++++++++++++++++++
>>>>    drivers/nvme/host/nvme.h |  3 +++
>>>>    include/linux/nvme.h     | 10 +++++++++-
>>>>    3 files changed, 47 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c index
>>>> 872c389dc6d3..c65d44fb65c4 100644
>>>> --- a/drivers/nvme/host/core.c
>>>> +++ b/drivers/nvme/host/core.c
>>>> @@ -2992,6 +2992,9 @@ static int nvme_init_identify(struct nvme_ctrl
>>> *ctrl)
>>>>        ctrl->max_namespaces = le32_to_cpu(id->mnan);
>>>>        ctrl->ctratt = le32_to_cpu(id->ctratt);
>>>>
>>>> +    ctrl->cntrltype = id->cntrltype;
>>>> +    ctrl->dctype = id->dctype;
>>>> +
>>>>        if (id->rtd3e) {
>>>>            /* us -> s */
>>>>            u32 transition_time = le32_to_cpu(id->rtd3e) /
>>> USEC_PER_SEC; @@
>>>> -3525,6 +3528,34 @@ static ssize_t
>>> nvme_ctrl_fast_io_fail_tmo_store(struct device *dev,
>>>>    static DEVICE_ATTR(fast_io_fail_tmo, S_IRUGO | S_IWUSR,
>>>>        nvme_ctrl_fast_io_fail_tmo_show,
>>> nvme_ctrl_fast_io_fail_tmo_store);
>>>>
>>>> +static ssize_t nvme_ctrl_cntrltype_show(struct device *dev,
>>>> +                     struct device_attribute *attr, char *buf) {
>>>> +    struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>>>> +
>>>> +    switch (ctrl->cntrltype) {
>>>> +    case NVME_CTRL_IO:    return sysfs_emit(buf, "io\n");
>>>> +    case NVME_CTRL_DISC:    return sysfs_emit(buf, "disc\n");
>>>
>>> 'discovery', please. 'disc' is misleading here.
>>>
>>>> +    case NVME_CTRL_ADMIN:    return sysfs_emit(buf, "admin\n");
>>>> +    default:        return sysfs_emit(buf, "reserved\n");
>>>> +    }
>>>> +}
>>>> +static DEVICE_ATTR(cntrltype, S_IRUGO, nvme_ctrl_cntrltype_show,
>>>> +NULL);
>>>> +
>>>> +static ssize_t nvme_ctrl_dctype_show(struct device *dev,
>>>> +                     struct device_attribute *attr, char *buf) {
>>>> +    struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>>>> +
>>>> +    switch (ctrl->dctype) {
>>>> +    case NVME_DCTYPE_NOT_REPORTED:    return sysfs_emit(buf,
>>> "nr\n");
>>>
>>> Please use 'none' here; 'nr' is ambiguous ('Number'?)
>>
>> Thanks for the review. I will apply the changes.
>>
>> Question: Since this was part of a set of patches, do I need to resubmit
>> the whole set or can I just resubmit this one patch?
>>
> Whole series, please. And gather up the reviews when resubmitting.
> 
>> Also, Sagi mentioned that the dctype should only be exposed for
>> Discovery Controllers, which makes sense. However, I found that
>> when  nvme_dev_attrs_are_visible() is invoked the ctrl object is
>> not fully configured yet (i.e. the controller is not yet identified).
>> Is there any other way to determine the controller type prior to
>> receiving the response to the Identify command?
>>
> Nope, unfortunately.
> 
> But maybe we can lump both attributes together in to a single ctrltype;
> then we would have 'io', 'admin', 'discovery', 'discovery-cdc', and 
> 'discovery-ddc'.
> 
> Hmm?

We should really move the ctrl device node creation to
nvme_init_ctrl_finish. I think this came up before...

