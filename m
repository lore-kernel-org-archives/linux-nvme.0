Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03712C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 08:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yulVxfhjlD0aES4pC+XrOF5BdfNuY2UT2JODmyI3HZQ=; b=dTb85MrJyRWr4Bz/pCbr2HrELz
	SUVYFjAEVNYbE6RXoaBaBEn5Z1tAziYixbp7jv62vQf8qY5jR6tH6VdMd+catqVmvxyAbCtaBz+C8
	4BeOlvY6Lt+HF+RqzcEiCdavg98QMg8ah3PfKXfb4uIVcDAHMfDheAto3k4/FCkRfRHV3HOGYAaZP
	+37qG1pta0KDGuipfITk0v8qZmYLGu15mKzACXBCb7PuQsv+RSW/VGr4jfThSTTAsdjKomYF8S+Cg
	NZwr3e1UCaCX+DoXImGjkbVk4h/mgXG7eAR8zzfA8w52X0X8th1egoOU/IrmlqyPCj7lgZp1t2t3i
	/vtK+PPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU2zs-008O0P-CZ; Tue, 15 Mar 2022 08:57:40 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU2zq-008NzD-4j
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 08:57:39 +0000
Received: by mail-wm1-f44.google.com with SMTP id r64so3066786wmr.4
 for <linux-nvme@lists.infradead.org>; Tue, 15 Mar 2022 01:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=yulVxfhjlD0aES4pC+XrOF5BdfNuY2UT2JODmyI3HZQ=;
 b=1DoVZdHq2yiGVf8US3O196F0IHL7wXDwDxIG+SpXasLTuO5eMSLO55JwsYfhf4JMz2
 /5FW8SkXpPBWUzxl0DJh/AA1FQ+N8WSFvm241Oi8ehjzbMOhQul7pqMWifqJ4hyPXtzh
 JL/UC9lvUx2Xm7P0it3sHHSPYwB8sQthNcEHtLkRFlYbQ+/bPrxlb0oC3g6JYLEDZopJ
 J2mG4EQQejCnvdBhus5CZO3kgek0oA8uTAWMx2h1ygNUYRVk2d9uqBxlJHkXGr9nW2VF
 GQxx7H76anQFFTk5XaqeGWfoW0cpKXWfFvd/b4HHj8i0iO2ZHp6W+S8O1K9HWE1owwrG
 kzbw==
X-Gm-Message-State: AOAM530P/oD3DsDa5Zlo11vHnZprJBZZ3+YOUCYHhPZHdtFCaVUEKhY5
 DfiO/l/nFWMNdEuGmQYh+UQyyebtJuA=
X-Google-Smtp-Source: ABdhPJwQnbwdjc8R1/mTKoEQavitBF1OIlgt3V/fl1KXTuVDceWqOxt1Ua5xn+VFVMQceUyGlfil/g==
X-Received: by 2002:a7b:cd82:0:b0:389:77ef:66d7 with SMTP id
 y2-20020a7bcd82000000b0038977ef66d7mr2330718wmj.171.1647334656892; 
 Tue, 15 Mar 2022 01:57:36 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 f15-20020a0560001a8f00b0020397ea11d2sm10267969wry.20.2022.03.15.01.57.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Mar 2022 01:57:36 -0700 (PDT)
Message-ID: <42045e78-dce4-2653-e882-46c48cc6e64e@grimberg.me>
Date: Tue, 15 Mar 2022 10:57:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/3] nvmet: restrict setting of discovery_nqn to discovery
 subsystem
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20220314105333.56714-1-hare@suse.de>
 <20220314105333.56714-3-hare@suse.de> <20220315080908.GB3082@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220315080908.GB3082@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_015738_225458_44180E16 
X-CRM114-Status: GOOD (  17.16  )
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


>> Changing the discovery NQN only makes sense for the discovery subsystem,
>> as any other subsystem can only have one (fixed) subsystem NQN.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/target/configfs.c | 32 +++++++++++++++++++++++++++-----
>>   1 file changed, 27 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
>> index 9b94af2444b2..58124abdbf62 100644
>> --- a/drivers/nvme/target/configfs.c
>> +++ b/drivers/nvme/target/configfs.c
>> @@ -1310,6 +1310,12 @@ CONFIGFS_ATTR(nvmet_subsys_, attr_model);
>>   static ssize_t nvmet_subsys_attr_discovery_nqn_show(struct config_item *item,
>>   			char *page)
>>   {
>> +	struct nvmet_subsys *subsys = to_subsys(item);
>> +
>> +	/* Only the discovery subsystem can have a different subsystem NQN */
>> +	if (subsys != nvmet_disc_subsys)
>> +		return -EBUSY;
>> +
>>   	return snprintf(page, PAGE_SIZE, "%s\n",
>>   			nvmet_disc_subsys->subsysnqn);
> 
> This completely breaks the existing ABI.  This attribute is shown on
> the "normal subsystems" and in fact only exposed for those so far.

I don't think we even want this to be on a per-subsystem at all.

> It is a fairly recent addition by you and without nvmetcli support, so
> maybe we can revert this entire attribute to redo discovery controller
> handling, but as-is this patch seems rather broken.

I think we could, I doubt anyone uses this interface at this point...

