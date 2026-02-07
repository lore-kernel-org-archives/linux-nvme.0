Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88586EE0ADC
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Feb 2026 13:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7sxU+ebw0lsF0jwdaC3TlDthFDkcdvrf9lQZuX6wRVU=; b=RAvB3wxSf95P5+34DNbUyaepgO
	EA0roEPEkWvorbg7qmZrNG8dZ/KGhlR9i3iIvhvNTl1C4UvemVKtwh5s8/qhdW913O8pAImZOncnr
	K2ThydYTlv/LoYWND54pRklSGPMuUeItlSYBLalSqcXGiBT4pzo2cfPEAz8zhaMCVxxM8BINYPG5T
	PX7spKystDQsR/o2BDdbsO3uDkcWTOxrfK2XVT15OMoEMbITYObclHXOI/b+M6NE1nVGYiSxZtIkZ
	iKOSmZ3MSU/qEsbrgngV987gcMmn9GnPBO0ev/Zm6hkjdO2IbkIiOgeSIPGP/Bse4853VC8hSTxT0
	BejOYM3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voips-0000000CVpw-3Mcd;
	Sat, 07 Feb 2026 13:58:56 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voipq-0000000CVpa-0CtI
	for linux-nvme@lists.infradead.org;
	Sat, 07 Feb 2026 13:58:55 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-482f2599980so36430355e9.0
        for <linux-nvme@lists.infradead.org>; Sat, 07 Feb 2026 05:58:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770472732; x=1771077532;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7sxU+ebw0lsF0jwdaC3TlDthFDkcdvrf9lQZuX6wRVU=;
        b=pFjBb9d8TPm2PoRgDAHUTcsEyK0/lbI33Qyz0hpvsSLwlUicWog0eWs+XLs+ZPadbe
         m6DjvMBTcRCCbqkiH1/wQKfgkgvTM/dkHCRKJrtONGNxRElAsnFYGyUtMNtlm/5rTgv9
         Ip5YNfGvjAsFhJVWupL3o7iD0UUvnYkotKOzC1FdAmfyP9BME92L7Y3uutiJ6UogwSSU
         OoIQhvsDWU1gCE3aiSuA+33Ans6yt6vwu7jklDQF7Zz8FSIzlF5wrSJPYw8iP8G7pvsg
         p+Oy7cDdbtezm8Dzuc5vQLlwvELCez6WSGQH0gffng0SDN3rcBHGT3tFfHP+9yDYxFHW
         newQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEQ3srSEWXQwe/nYTYfnzOkCUm81wRpzTM/IWeKjUH9CsnXYWRydM5aVyknYNVoSYP73uALIvmwOGa@lists.infradead.org
X-Gm-Message-State: AOJu0Yw6Hwp/oXrHPKdA5bmW9FmvqW+0x45nO0xJFIZ482BvXjhtpX6O
	dUNtosrbsBfUBQ0INZtljWsMb03vXcuENfsNhb8RmWxLXQ+jC+587DZc
X-Gm-Gg: AZuq6aLSMSFME79U6hD4+c1yLWxckzVX3haVg6MzsZWwwHDfc4Vzzvdp6b15zUuIYH3
	ugayQ9uTBcMyM1avtMWjxGr0lhmhbafDlDszKDqshhmF+0vv5dno/nsL1jLv+OrBrtpFH4qUAmh
	62SsuCQMOl0vAJ2Od7X9uu9AvZsC8zIA6YSbTieU1Mgw41WuA4sVdH7Yu8ncK28CbRYc3T3Z7ds
	o2BcEa9PU9HZDn0/5QapcfV8/5ji5e2zV4eZtikHnEId1Cw7MWbXbr0ON0iMbiY6SbCs9aMuoyH
	oXJ4YRiTDLAaSBrBiFvXFfPjLgexHX4hAKjRRuvIEAZ6Nd4dNA+NH0DNz4ZjLjurnUZ+AO/N9/1
	3BwQRhwkRq4/i7aSLIJIs2po15F3xxGn/LBKh/3+c8cKGMZ5LrM3GV9mOW7l13+c8YS730BnBO0
	wkuL0gJSl+EgFcTEIcrUD1Tu8n/PBop2NZLMO+R6FfK7o=
X-Received: by 2002:a05:6000:2210:b0:432:c0e8:4a33 with SMTP id ffacd0b85a97d-43629341477mr9044708f8f.22.1770472731838;
        Sat, 07 Feb 2026 05:58:51 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-89.bb.netvision.net.il. [89.138.75.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296b2ef1sm13904393f8f.7.2026.02.07.05.58.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Feb 2026 05:58:51 -0800 (PST)
Message-ID: <a2b46f72-857d-4145-ba87-c36c88710f18@grimberg.me>
Date: Sat, 7 Feb 2026 15:58:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/14] nvmet: Implement CCR nvme command
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Hannes Reinecke <hare@suse.de>
Cc: Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-4-mkhalfella@purestorage.com>
 <77a00fa1-5707-4859-8a7a-e823ca18c9fe@suse.de>
 <20260203184039.GB3729-mkhalfella@purestorage.com>
 <21be273b-b1b2-4813-8178-e01cb0aa6301@suse.de>
 <20260204004417.GK3729-mkhalfella@purestorage.com>
 <d53ac6e1-af6a-46ce-9b91-946a26ee1043@suse.de>
 <20260204175250.GL3729-mkhalfella@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260204175250.GL3729-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260207_055854_106013_A172B227 
X-CRM114-Status: GOOD (  17.47  )
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



On 04/02/2026 19:52, Mohamed Khalfella wrote:
> On Wed 2026-02-04 01:55:18 +0100, Hannes Reinecke wrote:
>> On 2/4/26 01:44, Mohamed Khalfella wrote:
>>> On Wed 2026-02-04 01:38:44 +0100, Hannes Reinecke wrote:
>>>> On 2/3/26 19:40, Mohamed Khalfella wrote:
>>>>> On Tue 2026-02-03 04:19:50 +0100, Hannes Reinecke wrote:
>>>>>> On 1/30/26 23:34, Mohamed Khalfella wrote:
>>>>>>> @@ -1501,6 +1516,38 @@ struct nvmet_ctrl *nvmet_ctrl_find_get(const char *subsysnqn,
>>>>>>>      	return ctrl;
>>>>>>>      }
>>>>>>>      
>>>>>>> +struct nvmet_ctrl *nvmet_ctrl_find_get_ccr(struct nvmet_subsys *subsys,
>>>>>>> +					   const char *hostnqn, u8 ciu,
>>>>>>> +					   u16 cntlid, u64 cirn)
>>>>>>> +{
>>>>>>> +	struct nvmet_ctrl *ctrl;
>>>>>>> +	bool found = false;
>>>>>>> +
>>>>>>> +	mutex_lock(&subsys->lock);
>>>>>>> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
>>>>>>> +		if (ctrl->cntlid != cntlid)
>>>>>>> +			continue;
>>>>>>> +		if (strncmp(ctrl->hostnqn, hostnqn, NVMF_NQN_SIZE))
>>>>>>> +			continue;
>>>>>>> +
>>>>>> Why do we compare the hostnqn here, too? To my understanding the host
>>>>>> NQN is tied to the controller, so the controller ID should be sufficient
>>>>>> here.
>>>>> We got cntlid from CCR nvme command and we do not trust the value sent by
>>>>> the host. We check hostnqn to confirm that host is actually connected to
>>>>> the impacted controller. A host should not be allowed to reset a
>>>>> controller connected to another host.
>>>>>
>>>> Errm. So we're starting to not trust values in NVMe commands?
>>>> That is a very slippery road.
>>>> Ultimately it would require us to validate the cntlid on each
>>>> admin command. Which we don't.
>>>> And really there is no difference between CCR and any other
>>>> admin command; you get even worse effects if you would assume
>>>> a misdirected 'FORMAT' command.
>>>>
>>>> Please don't. Security is _not_ a concern here.
>>> I do not think the check hurts. If you say it is wrong I will delete it.
>>>
>> It's not 'wrong', It's inconsistent. The argument that the contents of
>> an admin command may be wrong applies to _every_ admin command.
>> Yet we never check on any of those commands.
>> So I fail to see why this command requires special treatment.
> Okay, I will delete this check.

It is a very different command than other commands that nvmet serves. Format
is different because it is an attached namespace, hence the host should 
be able
to format it. If it would have been possible to access a namespace that 
is not mapped
to a controller, then this check would have been warranted I think.

There have been some issues lately opened on nvme-tcp that expose 
attacks that can
crash the kernel with some hand-crafted commands, I'd say that this is a 
potential attack vector.

