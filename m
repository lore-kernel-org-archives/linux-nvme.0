Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADDC9C54791
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Mar 2024 12:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4Fl29a1HKwHzq3oTHp8XbgixDXjDszlPDA3ON3F5+sc=; b=HledH5FWWpyXf/tWMeqPwGau6D
	ufX/4F2Ugml8cn6j/krDidtRXyiCJkzmmuYeJCbJMpFBlS0HzRxD51ZC+IdOHP2vOSdz23M8kuN4z
	13QPjuWfbzrCGeeW9kDEBrLPJ2t1BP2gOVdY2wQix3j2pn0bn/IMk10n2OE0cSPYNr89dAqeqaGjn
	nYsgjhT+M2Ymodb8Gj6mLMknAboAgPBb4YzRTAsvsVEKJpeNnS4+XS6s/rcjNfk/DCpATa5Anb1jj
	+Dpj6Fus+Tjdc2RT1AHAvRznsqFLQqXYj9KiMxLZBRMA1Nix5pZGVRXY5INDO7sFtuRPRp3FlXqga
	6MSge+6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkNqp-0000000A5Wa-0SpJ;
	Wed, 13 Mar 2024 12:36:55 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkNql-0000000A5Vd-3mu2
	for linux-nvme@lists.infradead.org;
	Wed, 13 Mar 2024 12:36:53 +0000
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33e972c8b67so749352f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 13 Mar 2024 05:36:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710333410; x=1710938210;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Fl29a1HKwHzq3oTHp8XbgixDXjDszlPDA3ON3F5+sc=;
        b=aklg1w1X3JCZj5eMwCQ6l/Qs4YcXcLfmgJK3CJj3OYRWs2yis/IKD3LzhAvwd/rCRN
         GcX/EM+hhJ56tH8HQn5pUEUiIFnrx1xAsqIhoDMsjdKBXcqIveGt/vF8ZGYqCz4ad3YB
         owWKDfQelM2lVvVBOeXm2ok9X6laiL3hs3//q3/jXIl2R1S7bxi5rKDkuFuRROaC3Ek4
         XkLkE+QdjMW4YsIT/IHYg+bsMCVEK7AseKiYe6zDCkTc7BS5JB+7RTKy0n/L0kUfX0S0
         YdKaO+7chhophK47xGk66aihd9gdqHqncYkYpUuaqXY7AaJc/4VxIlORFZ0WGD+mi8mz
         AWPg==
X-Forwarded-Encrypted: i=1; AJvYcCXhO7YgBWTcvvAQ6UT1eoeF3l6JIt7GhIEIsbV7D5nQaVDdJ6+5lk3BQQJnhl957T/m7JRe9qZdUTDmjTlibW7gTo3d6IS+6XN3FzW8qiU=
X-Gm-Message-State: AOJu0Yxbdo0RAXc4uz4FdUSL9OSPoq03/PcLcPvDGs8az591RHeeISBJ
	cpxIteO2muasgWhe/TzY29BHKRXbE6DMkfBA/DUWHtkqrSLtu8j1
X-Google-Smtp-Source: AGHT+IFDVdk5x9LF2Q1xC8miKtPibYFnVEs3bbOM53h6Smwex1DGfwOighwI0fMEPvNGX0e9HwYfFw==
X-Received: by 2002:a5d:5545:0:b0:33d:b387:88df with SMTP id g5-20020a5d5545000000b0033db38788dfmr8296324wrw.7.1710333409559;
        Wed, 13 Mar 2024 05:36:49 -0700 (PDT)
Received: from [10.50.4.153] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id q25-20020adfab19000000b0033e45930f35sm11787592wrc.6.2024.03.13.05.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 05:36:49 -0700 (PDT)
Message-ID: <99f5f33b-2c68-4c93-ad4d-333a05cb4d09@grimberg.me>
Date: Wed, 13 Mar 2024 14:36:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/1] nvmet: support reservation feature
Content-Language: he-IL, en-US
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, kch@nvidia.com, linux-nvme@lists.infradead.org
References: <20240201023207.112007-1-kanie@linux.alibaba.com>
 <20240201023207.112007-2-kanie@linux.alibaba.com>
 <ee516418-d072-4506-acba-d02f22cc4476@grimberg.me>
 <0c74a2c2-c9d9-4b0c-9deb-bdc3caf72005@linux.alibaba.com>
 <Zd6msstIWsNQMPfK@kbusch-mbp>
 <727aabbc-1464-48d6-9915-a1c22343c2b2@linux.alibaba.com>
 <6e34a652-da40-46f2-8a43-b45b08682e41@grimberg.me>
 <0c33b803-baff-45af-90bb-623822f756b8@linux.alibaba.com>
 <d6073345-ceef-49b2-834e-618bbbb78de3@grimberg.me>
 <8fccdd92-9055-45ba-8edb-8b2b647343b3@linux.alibaba.com>
 <47f18beb-3647-4464-9f2c-b75e10ec346b@grimberg.me>
 <2eb0672e-1073-497b-94ce-f3c356b7580e@linux.alibaba.com>
 <9983f5a2-6abb-41c8-89a7-aad32e247500@grimberg.me>
 <8d157341-0f64-4c91-b3d0-d3d5669c9e20@linux.alibaba.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <8d157341-0f64-4c91-b3d0-d3d5669c9e20@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240313_053651_974248_D93E79B2 
X-CRM114-Status: GOOD (  19.04  )
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



On 13/03/2024 13:56, Guixin Liu wrote:
>
> 在 2024/3/13 17:54, Sagi Grimberg 写道:
>>
>>
>> On 13/03/2024 5:42, Guixin Liu wrote:
>>>
>>> 在 2024/3/13 05:31, Sagi Grimberg 写道:
>>>> So I understand from you that there is out-of-band mechanism for 
>>>> fence guarantee?
>>>>
>>>> In any event, Christoph reminded me that preempt and abort is 
>>>> mandatory, so we cannot
>>>> get away without doing it.
>>>>
>>> Agree.
>>>> I suggest to introduce a per-ns-per-controller percpuref, with an 
>>>> xarray that is rcu protected.
>>>
>>> I will implement it in v9, and I also think that we should a 
>>> time-limited wait.
>>
>> If it is time-limited, and you didn't manage to wait, so you need to 
>> fail the preempt and abort
>> action (without DNR set so the reservation holder can retry if it 
>> chooses to).
>>
> It can wait.
>>>
>>>>
>>>> btw, I also think that reservations on nsid=0xffffffff should also 
>>>> work. IIRC there were at least
>>>> two use-cases that would have benefited from reservations on all 
>>>> subsystem namespaces.
>>>> It can also be a lot more lightweight to implement that (outside of 
>>>> conflicting reservations checks). 
>>>
>>> You mean one host can reserve all of namespaces by sending one 
>>> reservation command?
>>
>> Yes. The use-case is to have the reservation in the subsystem level.
>> The spec seems to imply that this is a valid reservation request.
>>
>>>
>>> Well, Could you please tell me which two use-cases?
>>
>> Don't remember for sure, but IIRC I've seen people run oracle rac 
>> with all namespaces in the
>> nvmet subsystem is exposed to DB hosts, and there were many namespaces.
>>
>>>
>>> I think this will make the target code too complicated, because the 
>>> reservation situation on each
>>>
>>> namespace may different, we should handle it one-by-one, and if 
>>> failed in middle, we should revert
>>>
>>> the handled namespaces.
>>
>> Not sure why you'd assume that, this would be a subsystem-wide 
>> reservation, which should simply
>> cross-check individual namespace reservations for conflicts. Sure it 
>> adds complication, but I think implementing
>> it on every individual namespace is a naive implementation.
>
> Well, this is strange, a few years ago, when I tested SCSI 
> reservations with Oracle RAC,
>
> I did not observe any "all LUN" reservation commands being issued.
>
> I also researched LIO and SPDK, and found that neither supports "all 
> LUN/NS" reservation commands.
>
> When a host issued a reservation command without carrying a specific 
> LUN or NS ID, both returned an error.

Didn't say this is actually in use, but a use-case that would benefit.

