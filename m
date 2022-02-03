Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE00C433FE
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Feb 2022 15:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G/gcahF1Zypr4GxpS439jBWo3U9g5fUjCFQp5coEEvU=; b=20ljyC128R3YoRZZjRw0gLUnVZ
	zDudRGAkspES+RDr0w5KUCA7sS8l4Qhk4npzE7nBpqUkFDmwQTa7njSqW4/moqlSg0vzMlRp9czh6
	8M4yEbMR54eu1OjQkZR182tjDKaAv9W3CcYqLA5lC2EtVDjV1+hoKg0Vt+g8WmJHlRj73442J2aVM
	6j5DZwjbFp0AZG8mtP7RCC7qFk6FzMiV7hyLuDQZ9hgJcZjlf2LrtSy62ewer+RZNKGIdIAj2BjDi
	LhKB893/ijCntDUKgE5QtRXRDF4nt/kzcbsM2Tuo6EEw/xySZJg0YlJhpgBuAG0nY0APP48GX4X8x
	KofIBatA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFePO-001tuQ-NL; Thu, 03 Feb 2022 15:52:30 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFePM-001ttx-86
 for linux-nvme@lists.infradead.org; Thu, 03 Feb 2022 15:52:29 +0000
Received: by mail-wr1-f51.google.com with SMTP id e8so5971368wrc.0
 for <linux-nvme@lists.infradead.org>; Thu, 03 Feb 2022 07:52:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=G/gcahF1Zypr4GxpS439jBWo3U9g5fUjCFQp5coEEvU=;
 b=S1RWgTvqsP4jl9meZgcG7WN88WgKk9nHi1qB18HYCnGXACfQ9kUx2gLxvU8uDRFqqB
 V7TvUpl8LiglgJMx2mVnx2SHH6hCP2/0GL/X0bPitJ88rcFgh5FvYOsRqlF2g7T0k1iS
 UZ5M6nWNvis91ZPW+dC5MJiPPKySWKrT8udglBGtuXSPTBJAAcp+UVY5OoZDUo/ytsa7
 L/99H/9W6gW1m+/PtqAYmy0TWk/+OtrRQDZaxTdNwrn5rDY6RJamMc5H91bsvdUO5+vu
 oznSVwmdBKJvgm1ek8szVwnk1MimnoQ7kHqNBjwF+DccomkGMSCtGA2E2PeNlqZ3lP6w
 VEpw==
X-Gm-Message-State: AOAM530RAmGZoY6OJuHP0rM+uG1JyndrvbuOgrqdTt38R2bVQI3W6Lnq
 voANp1NHnZkk69ZRNww4lcg=
X-Google-Smtp-Source: ABdhPJyyrIRQbE2HT7TkS/1fAi5fQisb0PVQI8b5CP62jPCKg/Yp41+gCgL6dbnPj5T4NYSn36Vm2g==
X-Received: by 2002:adf:f981:: with SMTP id f1mr29944339wrr.651.1643903546388; 
 Thu, 03 Feb 2022 07:52:26 -0800 (PST)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id k32sm9722482wms.14.2022.02.03.07.52.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Feb 2022 07:52:26 -0800 (PST)
Message-ID: <d0fb3f06-a35e-c8f1-ae5d-b6871c913bcd@grimberg.me>
Date: Thu, 3 Feb 2022 17:52:24 +0200
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
 <ea56c568-9cbe-3087-21b0-81023ead927f@grimberg.me>
 <SJ0PR19MB4544CF86ADD8F3771CA9E4BEF2289@SJ0PR19MB4544.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <SJ0PR19MB4544CF86ADD8F3771CA9E4BEF2289@SJ0PR19MB4544.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220203_075228_329878_9009EC02 
X-CRM114-Status: GOOD (  15.11  )
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


>> There is already an interface to update sysfs groups, so in theory
>> this should do the trick:
>> --
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index c11cd3a814fd..d86828cf7720 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -3115,6 +3115,11 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
>>                           return ret;
>>           }
>>
>> +       ret = sysfs_update_groups(&ctrl->device->kobj,
>> ctrl->device->groups);
>> +       if (ret)
>> +               return ret;
>> +
>> +
> 
> I just tried this and it works.

Makes sense.

> Martin
> 
>>           ctrl->identified = true;
>>
>>           return 0;
>> --
>>
>> But probably we want add a nicer interface like
>> --
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index c11cd3a814fd..8fb94cb15fb0 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -3115,6 +3115,11 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
>>                           return ret;
>>           }
>>
>> +       ret = device_update_groups(&ctrl->device);
>> +       if (ret)
>> +               return ret;
>> +
>> +
>>           ctrl->identified = true;
>>
>>           return 0;
>> --
>>
>> Where device_update_groups would be something like:
>> --
>> int device_update_groups(struct device *dev)
>> {
>>           struct class *class = dev->class;
>>           const struct device_type *type = dev->type;
>>           int error;
>>
>>           if (class) {
>>                   error = device_update_groups(dev, class->dev_groups);
>>                   if (error)
>>                           return error;
>>           }
>>
>>           if (type) {
>>                   error = device_update_groups(dev, type->groups);
>>                   if (error)
>>                           goto err_remove_class_groups;
>>           }
>>
>>           error = device_update_groups(dev, dev->groups);
>>           if (error)
>>                   goto err_remove_type_groups;

This last hunk should probably be:
	return device_update_groups(dev, dev->groups);

>> }
>> EXPORT_SYMBOL_GPL(device_update_groups);
>> --
> 
> Sagi, would you add this function to drivers/base/core.c?
> Martin

Yes. This would need some more eyeballs though, maybe this
should be extended to device_update_attrs?

