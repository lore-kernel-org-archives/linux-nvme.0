Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3BF8C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Feb 2022 13:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RsbpR8SQ05FCq3e2UtjkV5ConR/pdlO8UD8eN5RnerI=; b=q4mru5k1V2LqlU1yNY6VB3lPF+
	OKvGZk7R1rGDyCJsm2szdbCe2+bzLxav26m9gGrmkMCn41FlR8luvP/khvMbdV6XoGW7vaC3jjfFB
	3pWG6DfowcorblfoWrMoRSiCxYZqE8AsWhUH8SSVcmxoFuwTlMlGugs2Nkq0tgXtc5P7btscsckgh
	Cgjq7SA4JZxVj7zyiwpkXqNWyWFV8yY7FYU1DVsCBwnlQfYhJxnfUWzxsKZE/YEn5ZW+HYvGJ/Rd6
	JjrmO0bnyGzoKLgcniTzTT9XbrhHIIPGZCk8/J0PLoP7Ykp0Ohk4jjQOqdL7jaajwm72U/hnObeW+
	BDCfRNRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFcEY-001ROY-1e; Thu, 03 Feb 2022 13:33:10 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFcEU-001RMg-O0
 for linux-nvme@lists.infradead.org; Thu, 03 Feb 2022 13:33:08 +0000
Received: by mail-wr1-f41.google.com with SMTP id k18so5049077wrg.11
 for <linux-nvme@lists.infradead.org>; Thu, 03 Feb 2022 05:33:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=RsbpR8SQ05FCq3e2UtjkV5ConR/pdlO8UD8eN5RnerI=;
 b=eR65BF/H1/p9OkmO1vyJDWYR+hHXQC+e8Cfx0NP4/MOgYTyAlUWDT5fy/JjEKe/Vvb
 y0HBzjEJQEHvnYplR4mWIyjLfasgkkTU1sMUNBHCnzCaoZft/75VwZD0oG151W0/3vrE
 sOeSE+5S1dN0fg8pjOyTsoIibsU62FH2YiXndQ1gWMYuSPo1MH5yt0yNxLrmXconzvCw
 cptvLNGcyUCI51tt7NUpY3JZT6xf4x9zXEqx1gXsBUr+1SyHjQO7dEIRboPJWQAxFSpt
 hnNLnDVYqgK2F70wAY/W0frT/wLGj6TEx3p293aDeZRXKNPfnGLGMWbhYDQcw2dP2tkM
 BegA==
X-Gm-Message-State: AOAM530NQCmE4aNrS0bFz7rcbUmry+IYU2G6ln5blQaZwDFB5FepYqK5
 0c/jNgiThjd/iql94IGCxvg=
X-Google-Smtp-Source: ABdhPJy//fAWTyDQ2ie2y8AvjpOG1XJoyhnH13OVBbkCcapFkJh15Nsq5BEzF7zbEpgWdrF5JXGjuw==
X-Received: by 2002:a5d:448b:: with SMTP id j11mr8561754wrq.172.1643895184691; 
 Thu, 03 Feb 2022 05:33:04 -0800 (PST)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id n10sm7217513wmr.25.2022.02.03.05.33.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Feb 2022 05:33:03 -0800 (PST)
Message-ID: <ea56c568-9cbe-3087-21b0-81023ead927f@grimberg.me>
Date: Thu, 3 Feb 2022 15:33:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] nvme: Expose cntrltype and dctype through sysfs.
Content-Language: en-US
To: "Belanger, Martin" <Martin.Belanger@dell.com>,
 Hannes Reinecke <hare@suse.de>, Martin Belanger <nitram_67@hotmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "Hayes, Stuart" <Stuart.Hayes@dell.com>,
 "Rose, Charles" <Charles.Rose@dell.com>
References: <20220202213451.33599-1-nitram_67@hotmail.com>
 <BL0PR13MB4291C612318AC862FDDEB7719C279@BL0PR13MB4291.namprd13.prod.outlook.com>
 <49b2d58e-80b4-94f2-77ef-c2d1ec19e581@suse.de>
 <BLAPR19MB45318B8797176BF97BAB0A30F2289@BLAPR19MB4531.namprd19.prod.outlook.com>
 <68451fbe-ff4c-a89c-36d7-1b5829fab825@suse.de>
 <SJ0PR19MB4544B435D22B0F19E2B7CEBAF2289@SJ0PR19MB4544.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <SJ0PR19MB4544B435D22B0F19E2B7CEBAF2289@SJ0PR19MB4544.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220203_053306_836092_EFCFD3A5 
X-CRM114-Status: GOOD (  22.51  )
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


>>>>> From: Martin Belanger <martin.belanger@dell.com>
>>>>>
>>>>> TP8010 introduces the Discovery Controller Type (dctype) attribute.
>>>>> The dctype is returned in the response to the Identify command. This
>>>>> patch exposes the dctype through the sysfs. Since the dctype depends
>>>>> on the Controller Type (cntrltype), another attribute of the
>>>>> Identify response, the patch also exposes the cntrltype as well.
>>>>>
>>>>> Signed-off-by: Martin Belanger <martin.belanger@dell.com>
>>>>> ---
>>>>>     drivers/nvme/host/core.c | 35
>>>> +++++++++++++++++++++++++++++++++++
>>>>>     drivers/nvme/host/nvme.h |  3 +++
>>>>>     include/linux/nvme.h     | 10 +++++++++-
>>>>>     3 files changed, 47 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>>>> index
>>>>> 872c389dc6d3..c65d44fb65c4 100644
>>>>> --- a/drivers/nvme/host/core.c
>>>>> +++ b/drivers/nvme/host/core.c
>>>>> @@ -2992,6 +2992,9 @@ static int nvme_init_identify(struct nvme_ctrl
>>>> *ctrl)
>>>>>     	ctrl->max_namespaces = le32_to_cpu(id->mnan);
>>>>>     	ctrl->ctratt = le32_to_cpu(id->ctratt);
>>>>>
>>>>> +	ctrl->cntrltype = id->cntrltype;
>>>>> +	ctrl->dctype = id->dctype;
>>>>> +
>>>>>     	if (id->rtd3e) {
>>>>>     		/* us -> s */
>>>>>     		u32 transition_time = le32_to_cpu(id->rtd3e) /
>>>> USEC_PER_SEC; @@
>>>>> -3525,6 +3528,34 @@ static ssize_t
>>>> nvme_ctrl_fast_io_fail_tmo_store(struct device *dev,
>>>>>     static DEVICE_ATTR(fast_io_fail_tmo, S_IRUGO | S_IWUSR,
>>>>>     	nvme_ctrl_fast_io_fail_tmo_show,
>>>> nvme_ctrl_fast_io_fail_tmo_store);
>>>>>
>>>>> +static ssize_t nvme_ctrl_cntrltype_show(struct device *dev,
>>>>> +				     struct device_attribute *attr, char *buf) {
>>>>> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>>>>> +
>>>>> +	switch (ctrl->cntrltype) {
>>>>> +	case NVME_CTRL_IO:	return sysfs_emit(buf, "io\n");
>>>>> +	case NVME_CTRL_DISC:	return sysfs_emit(buf, "disc\n");
>>>>
>>>> 'discovery', please. 'disc' is misleading here.
>>>>
>>>>> +	case NVME_CTRL_ADMIN:	return sysfs_emit(buf, "admin\n");
>>>>> +	default:		return sysfs_emit(buf, "reserved\n");
>>>>> +	}
>>>>> +}
>>>>> +static DEVICE_ATTR(cntrltype, S_IRUGO, nvme_ctrl_cntrltype_show,
>>>>> +NULL);
>>>>> +
>>>>> +static ssize_t nvme_ctrl_dctype_show(struct device *dev,
>>>>> +				     struct device_attribute *attr, char *buf) {
>>>>> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>>>>> +
>>>>> +	switch (ctrl->dctype) {
>>>>> +	case NVME_DCTYPE_NOT_REPORTED:	return sysfs_emit(buf,
>>>> "nr\n");
>>>>
>>>> Please use 'none' here; 'nr' is ambiguous ('Number'?)
>>>
>>> Thanks for the review. I will apply the changes.
>>>
>>> Question: Since this was part of a set of patches, do I need to
>>> resubmit the whole set or can I just resubmit this one patch?
>>>
>> Whole series, please. And gather up the reviews when resubmitting.
>>
>>> Also, Sagi mentioned that the dctype should only be exposed for
>>> Discovery Controllers, which makes sense. However, I found that when
>>> nvme_dev_attrs_are_visible() is invoked the ctrl object is not fully
>>> configured yet (i.e. the controller is not yet identified).
>>> Is there any other way to determine the controller type prior to
>>> receiving the response to the Identify command?
>>>
>> Nope, unfortunately.
>>
>> But maybe we can lump both attributes together in to a single ctrltype; then
>> we would have 'io', 'admin', 'discovery', 'discovery-cdc', and 'discovery-ddc'.
>>
>> Hmm?
> 
> I like that. I shall combine them into a single attribute.

I don't think this is a good approach.

There is already an interface to update sysfs groups, so in theory
this should do the trick:
--
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c11cd3a814fd..d86828cf7720 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3115,6 +3115,11 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
                         return ret;
         }

+       ret = sysfs_update_groups(&ctrl->device->kobj, 
ctrl->device->groups);
+       if (ret)
+               return ret;
+
+
         ctrl->identified = true;

         return 0;
--

But probably we want add a nicer interface like
--
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c11cd3a814fd..8fb94cb15fb0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3115,6 +3115,11 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
                         return ret;
         }

+       ret = device_update_groups(&ctrl->device);
+       if (ret)
+               return ret;
+
+
         ctrl->identified = true;

         return 0;
--

Where device_update_groups would be something like:
--
int device_update_groups(struct device *dev)
{
         struct class *class = dev->class;
         const struct device_type *type = dev->type;
         int error;

         if (class) {
                 error = device_update_groups(dev, class->dev_groups);
                 if (error)
                         return error;
         }

         if (type) {
                 error = device_update_groups(dev, type->groups);
                 if (error)
                         goto err_remove_class_groups;
         }

         error = device_update_groups(dev, dev->groups);
         if (error)
                 goto err_remove_type_groups;
}
EXPORT_SYMBOL_GPL(device_update_groups);
--

