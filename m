Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45B1C48BF6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 12:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oF6KmtBzNdpCIaFyLBmiCqb1PMnj7ILp5AYIpT88ggk=; b=l1yyzXD2oXl64J2rwYcwrG1uNr
	N3ZbITBCT4dn428H+5zsfiXLcwDJEB3Z7u3sBpvnt5E6aytX3nWjNi5VBfjtjzIDbDyw8hYA+YMth
	6mFgiPL2Yus0V/yXgS1YNwWJR+oTipeNg2+AaKNKWSpoZSvxj/FZCQ9Rar/kKK2aEXW8ofUJL1I1Q
	mgXUhkNnI+jgplwbRzMWUZ10t1v4OC4zfvwz7sjg7QG20tsL9wDYAwCQj4YuR7uHQPdf1iqGlFwY9
	83JAw1cuZ0xreXhG8PbpbesU92CdqW39E2W6bvBAPrxB53IOJhpgYyaC6JPspI69aCQ38lL9+IRSs
	3B+dWASw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riCRG-00000004TRr-0fui;
	Thu, 07 Mar 2024 12:01:30 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riCRC-00000004TR0-1o7M
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 12:01:28 +0000
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33e12bcf6adso261540f8f.1
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 04:01:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709812883; x=1710417683;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oF6KmtBzNdpCIaFyLBmiCqb1PMnj7ILp5AYIpT88ggk=;
        b=frjI2Wob0Uja03lLFRu7T+bQlnvKjwmi5JxNZUNWG2iwV/BtFEquR0hf9MrtZHBuoM
         hmx9Gd/DZtP1GqeL/rxwNLRQ3O/CND5e96DPSjnBm6i26AeiPW6dvn90rWYBzsbHqFqs
         o+Ku5KXCm0TiPE0wC8smMBzM6GeicmektvKNrkGI1SVYdHFmpR2vGuMokz1bWAMbHa7h
         42rtwGaOirRRneP+/ocm+BbDvp33LA38TIRJHtaNq2Rx8zdULg1LisTejiiZygzjVU0g
         NQT0gxZO97BuTe0byW3+W3cmew8LusITWJM3WEnCAXjhfuKjgF++aQ/cYHfL6hbqeHka
         jU5g==
X-Forwarded-Encrypted: i=1; AJvYcCXldLMdcNVrUnuCC8gR9ZrdX5ltyrMs2e3/0a9tGKBOfU+iLmxtLLGnT+vt5aGEHF9gkNqpmQ7HSAFXRv7808/6LhMZxE/htYTwX0xOwtE=
X-Gm-Message-State: AOJu0Yz+XXiElD5tgJGJ437wpNc+zn0yNofZo5GzYue8Dv3QbrTULgec
	gp2cckDOF1VBXfawF4PVg6orqHOGr2feQz7GpAnKsu8PcdMq/sCT
X-Google-Smtp-Source: AGHT+IE8EIJv4HKsw1/7TPhcT7wGmEYZ7Bg11FYc3xz7mIiR/pat54vciH562myB00TqCIW4zTWYkw==
X-Received: by 2002:adf:dd87:0:b0:33e:4503:3ba4 with SMTP id x7-20020adfdd87000000b0033e45033ba4mr3637618wrl.7.1709812883215;
        Thu, 07 Mar 2024 04:01:23 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id j16-20020a5d6190000000b0033e0019b814sm20008084wru.34.2024.03.07.04.01.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 04:01:22 -0800 (PST)
Message-ID: <7ff7c9cc-6b02-4adc-9b78-8bab26341049@grimberg.me>
Date: Thu, 7 Mar 2024 14:01:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] nvme-fc: FPIN link integrity handling
Content-Language: he-IL, en-US
To: Hannes Reinecke <hare@suse.de>, hare@kernel.org,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20240219085929.31255-1-hare@kernel.org>
 <1dfa9a4e-e4a2-4d48-b569-85e48ce4311c@grimberg.me>
 <1c3eea31-b80f-4b95-ab15-ac42f7c45c16@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <1c3eea31-b80f-4b95-ab15-ac42f7c45c16@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_040126_557605_8D835B87 
X-CRM114-Status: GOOD (  26.57  )
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



On 07/03/2024 13:29, Hannes Reinecke wrote:
> On 3/7/24 11:10, Sagi Grimberg wrote:
>>
>>
>> On 19/02/2024 10:59, hare@kernel.org wrote:
>>> From: Hannes Reinecke <hare@suse.de>
>>>
>>> FPIN LI (link integrity) messages are received when the attached
>>> fabric detects hardware errors. In response to these messages the
>>> affected ports should not be used for I/O, and only put back into
>>> service once the ports had been reset as then the hardware might
>>> have been replaced.
>>
>> Does this mean it cannot service any type of communication over
>> the wire?
>>
> It means that the service is impacted, and communication cannot be 
> guaranteed (CRC errors, packet loss, you name it).
> So the link should be taken out of service until it's been (manually)
> replaced.

OK, that's what I assumed.

>
>>> This patch adds a new controller flag 'NVME_CTRL_TRANSPORT_BLOCKED'
>>> which will be checked during multipath path selection, causing the
>>> path to be skipped.
>>
>> While this looks sensible to me, it also looks like this introduces a 
>> ctrl state
>> outside of ctrl->state... Wouldn't it make sense to move the 
>> controller to
>> NVME_CTRL_DEAD ? or is it not a terminal state?
>>
> Actually, I was trying to model it alongside the 
> 'devloss_tmo'/'fast_io_fail' mechanism we have in SCSI.
> Technically the controller is still present, it's just that we shouldn't
> send I/O to it.

Sounds like a dead controller to me.

> And I'd rather not disconnect here as we're trying to
> do an autoconnect on FC, so manually disconnect would interfere with
> that and we probably end in a death spiral doing disconnect/reconnect.

I suggested just transitioning the state to DEAD... Not sure how keep-alives
behave though...

>
> We could 'elevate' it to a new controller state, but wasn't sure how big
> an appetite there is. And we already have flags like 'stopped' which
> seem to fall into the same category.

stopped is different because it is not used to determine if it is capable
for IO (admin or io queues). Hence it is ok to be a flag.

>
> So I'd rather not touch the state machine.

I'm just trying to understand if it falls into one of the existing 
states that
we have today. Because it sounds awfully like DEAD to me.

