Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC264C433EF
	for <linux-nvme@archiver.kernel.org>; Sun,  6 Feb 2022 08:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LN6FmrdEWpez4IHpFMNsQLcMyCsaRYxtQ3DwCPFniCc=; b=z4BbgHc7vVhvRZfKW5XbywhqOV
	hrrdy3EDs//ms3C5m9owy4fmhkvtFM9bmM1yBXGdWjPGsBLusiigzgJvz0YzYBCd4WfxzrMvAJQbs
	IkfX8PZ/T3cF0C1JghHKGRMNry4r0hlIPaCs56PxCH/XB+tHvzBt/GPUqmsFkKbcCEefC2sZHfgoy
	OsBGslmwrhBGGI/N8FKohjOeEZk2vWwPsadCfqOy14kj33kFjHj4Mf/seQeL4FeyCxVNqW3QNpAvt
	bM34KgNIU1Y6KPGeQOFwbGGMfMPEW3c11/JChEXR7bG6RhPM0HM7EhzZOXkflxvDLlWy4WFjxKnLL
	GpQC/SkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nGdKD-0081eE-6e; Sun, 06 Feb 2022 08:55:13 +0000
Received: from mail-ej1-f49.google.com ([209.85.218.49])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nGdK1-0081d6-LG
 for linux-nvme@lists.infradead.org; Sun, 06 Feb 2022 08:55:03 +0000
Received: by mail-ej1-f49.google.com with SMTP id o12so33172036eju.13
 for <linux-nvme@lists.infradead.org>; Sun, 06 Feb 2022 00:55:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=LN6FmrdEWpez4IHpFMNsQLcMyCsaRYxtQ3DwCPFniCc=;
 b=LM7diyHpP1fW6BIHm0qnb1KllJ9cK8pwHAU95sTb9bqP07aKBFtpDx2WuwO7ip2557
 kK46o9LSMoFPKmblYaQ8xP0pHkaIyaaAibyW4JzD3HjkzUs10oSSiePuO2yTOcTInG9i
 MmtzPTUGpkFfuv7+vSrYEh7BTR2Xa5YC3xFnpA5zcmFbm47lYmgFSfwMq6DEOFrlaIFz
 Zk3MH5CMZ2LJdzL/uEHIsXi+N4YCiPMUr7bel0lKkZGIDkVO/AvGDQJzO506f2CX9jNM
 hrEiSnbGqzieBkFIzFTiKB7sHRv4D8NThfF6uK/ALcu64GwZXW2IPPZPdDDtkyYzPDJ5
 3Rsg==
X-Gm-Message-State: AOAM530xmVZT7+zo9jQBsZ2hpIw1uTuB2wzbGA3E1Uc1h8os81QPKGgs
 Lj5K7JKM0dE+ITXw/pC+zAY=
X-Google-Smtp-Source: ABdhPJzgqOp7LhI2LiPbrJ0vDKwlxElLH+u1HhYjAby9dWji7lcQz0Ov/PgA2ndCN92E7nwvxFSqCQ==
X-Received: by 2002:a17:906:240d:: with SMTP id
 z13mr1445034eja.210.1644137697597; 
 Sun, 06 Feb 2022 00:54:57 -0800 (PST)
Received: from [10.100.102.14] (46-117-116-119.bb.netvision.net.il.
 [46.117.116.119])
 by smtp.gmail.com with ESMTPSA id n6sm3417687edy.87.2022.02.06.00.54.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Feb 2022 00:54:57 -0800 (PST)
Message-ID: <93a3faf5-2e97-cd27-63ae-ea37293d5e54@grimberg.me>
Date: Sun, 6 Feb 2022 10:54:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCHv2 3/3] nvme: Expose cntrltype and dctype through sysfs
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>,
 Martin Belanger <nitram_67@hotmail.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hare@suse.de,
 axboe@fb.com, hch@lst.de, rafael@kernel.org, charles_rose@dell.com,
 stuart_hayes@dell.com, Martin Belanger <martin.belanger@dell.com>
References: <20220203211748.27542-1-nitram_67@hotmail.com>
 <BL0PR13MB429136A542739D745DE3AB679C289@BL0PR13MB4291.namprd13.prod.outlook.com>
 <YfzZmxPrtXwavoRZ@kroah.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <YfzZmxPrtXwavoRZ@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220206_005501_748030_FAC2A4E1 
X-CRM114-Status: GOOD (  14.73  )
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

Hey Greg,

>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index b5e452aa3c0e..4e3db5ec3924 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -2990,6 +2990,9 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
>>   	ctrl->max_namespaces = le32_to_cpu(id->mnan);
>>   	ctrl->ctratt = le32_to_cpu(id->ctratt);
>>   
>> +	ctrl->cntrltype = id->cntrltype;
>> +	ctrl->dctype = id->dctype;
>> +
>>   	if (id->rtd3e) {
>>   		/* us -> s */
>>   		u32 transition_time = le32_to_cpu(id->rtd3e) / USEC_PER_SEC;
>> @@ -3115,6 +3118,10 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
>>   			return ret;
>>   	}
>>   
>> +	ret = device_update_groups(ctrl->device);
>> +	if (ret)
>> +		return ret;
> 
> Why is this needed here?  How did the class or type just change?  That
> should never change over the lifespan of a device.  If it does, you need
> to tear down the old device and create a new one as something really
> wrong just happened.

The class and type do not change. The fundamental need here is to update
visible attributes of the device.

In nvme, we create the device node with its sysfs attributes and next
comes a process where we interrogate it for capabilities/personality.
In this example, the attributes cntrltype and dctype are learned from
the device identification, and the desire is that dctype will only be
visible for specific cntrltype (i.e. cntrltype is I/O controllers vs.
discovery controllers and dctype is the discovery controller type).

So perhaps a more narrowed interface to update attributes
visibility of the controller would be more appropriate instead?

Something like:
--
	ret = device_update_visibility(ctrl->device->groups);
--

